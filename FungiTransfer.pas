unit FungiTransfer;
 // appears to copy data from Forays in Forayplate project into Forays in IMS data
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ForayConcepts, Grids, IB_Grid, ExtCtrls, IB_NavigationBar,
  IB_Session;

type
  TFungiTransferForm = class(TForm)
    GoButton: TButton;
    IB_Grid1: TIB_Grid;
    IB_NavigationBar1: TIB_NavigationBar;
    Label1: TLabel;
    UnProcessedCB: TCheckBox;
    IB_Grid2: TIB_Grid;
    IB_NavigationBar2: TIB_NavigationBar;
    Label2: TLabel;
    ProblemList: TListBox;
    procedure GoButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    CurrentIMSForay, CurrentOldForay: TForay;
    Interrupt:boolean;
    { Public declarations }
  end;

var
  FungiTransferForm: TFungiTransferForm;

implementation

uses IMSData, ForayData, IB_Components, FungusEdit;

{$R *.dfm}
// reads Forays from IMSDB updated bi IMS, compares with old file records and
// appends or modifies old file as necessary
procedure TFungiTransferForm.FormActivate(Sender: TObject);
begin
      if IMSDM.FBConnection.ConnectionStatus = csDisconnected then IMSDM.FBConnection.Connected:=true;
      if ForayDM.ForayConnection.ConnectionStatus = csDisconnected then ForayDM.ForayConnection.Connected:=true;
      if not ForayDM.NewForaysquery.Active then ForayDM.NewForaysquery.open;
      if not IMSDM.AllForaysQuery.Active then IMSDM.AllForaysQuery.Open;
end;

procedure TFungiTransferForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      CurrentIMSForay.Free;
      CurrentOldForay.Free;
      CurrentIMSForay:= nil;
      CurrentOldForay:= nil;
      Interrupt:=false;
      if ForayDM.NewForaysquery.Active then ForayDM.NewForaysquery.close;
      if IMSDM.AllForaysQuery.Active then IMSDM.AllForaysQuery.close;
      if IMSDM.ForayByCodeQuery.active then IMSDM.ForayByCodeQuery.close;
end;

procedure TFungiTransferForm.FormCreate(Sender: TObject);
begin
      CurrentIMSForay:= TForay.create;
      CurrentOldForay:= TForay.create;
end;

procedure TFungiTransferForm.GoButtonClick(Sender: TObject);
var differences,problems:string; showreply,reply,nbrecs:integer;
begin
  try
    nbrecs:=0;
    while not ForayDM.NewForaysquery.eof do
    begin
        CurrentIMSForay.ReadFromDataset(ForayDM.NewForaysquery);
        IMSDM.GetForayByCode(CurrentIMSForay.Foraycode,CurrentOldForay);
        differences:='';
        problems:='';
        if CurrentOldForay.Foraycode<>'' then
        begin
          differences:=CurrentOldForay.Compare(CurrentIMSForay);
          if (length(differences)>0) and (differences<>'shortcode,UsedBy,NumberOfPages') then
          begin          //Forays differ
            if messageDlg('Fields '+differences+' for '+CurrentOldForay.Foraycode+
              ' have been changed. View differences and decide?',mtWarning,[mbYes,mbNo],0)=mrYes then
            begin
              ForayEditForm.DifferenceList.Items.Clear;
              ForayEditForm.DifferenceList.Items.Delimiter:=',';
              ForayEditForm.DifferenceList.Items.DelimitedText:=differences;
              ForayEditForm.UpdateButton.Enabled:=true;
              ForayEditForm.ExistPanel.Visible:=true;
              ForayEditForm.Recct.Caption:=IntToStr(nbrecs);
              showreply:=ForayEditForm.showModal;
              if showreply=mrOK then
              begin
                if MessageDlg('OK to overwrite old data with Ian''s new data?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
                begin
                  CurrentOldForay.Assign(CurrentIMSForay);
                  IMSDM.ForayByCodeQuery.edit;
                  CurrentOldForay.WriteToDataset(IMSDM.ForayByCodeQuery);
                end //yes to use IMS version
              end //showreply OK
              else if showreply=mrCancel then
              begin
                  if MessageDlg('Confirm rewrite old data with changes?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
                  begin
                    IMSDM.ForayByCodeQuery.edit;
                    CurrentOldForay.WriteToDataset(IMSDM.ForayByCodeQuery);
                  end;  //yes to use old data
              end //showreply Cancel
            end; // yes to view data
          end; // differences found
        end  // blank Foraycode
        else begin   //new Foray
          reply:=MessageDlg('Insert Ian''s new data for '+CurrentIMSForay.Foraycode+'?',mtConfirmation,[mbYes,mbNo,mbAbort],0);
          if reply=mrYes then
          begin
            ForayEditForm.ExistPanel.Visible:=false;
            ForayEditForm.UpdateButton.Enabled:=false;
            ForayEditForm.Recct.Caption:=IntToStr(nbrecs);
            showreply:= ForayEditForm.showModal;
            if showreply=mrOK then
            try
              IMSDM.ForayByCodeQuery.Insert;            //new Foray
              CurrentIMSForay.WriteToDataset(IMSDM.ForayByCodeQuery);
            except on e:EIB_ISCError do
              begin
                showMessage('Error: '+e.Errormessage.Text);
                IMSDM.ForayByCodeQuery.Cancel;
              end;

            end //showreply OK
          end; // yes to insert
        end; // new Foray
      if (reply=mrAbort) or Interrupt then Break;
      ForayDM.NewForaysquery.Next;
      inc(nbrecs);
    end //while not eof
    finally
      IMSDM.IMSTransaction.Commit;
      IMSDM.ForayByCodeQuery.Close;
      ProblemList.Visible:=true;
      problemList.Items.Delimiter:=',';
      problemList.Items.DelimitedText:=Problems;
      ProblemList.AddItem('Completed',nil);
    end;
end;

procedure Split
   (const Delimiter: Char;
    Input: string;
    const Strings: TStrings) ;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;
end.
