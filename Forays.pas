unit Forays;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, IMSData, ComCtrls, DBCtrls, DB, Mask,
  ExtCtrls, DateUtils, IB_Components, IB_Monitor, IB_Grid, IB_Access,
  IB_Controls, IB_EditButton, ForayConcepts, IB_NavigationBar;

type
  TForayForm = class(TForm)
    MergePanel: TPanel;
    EditPanel: TPanel;
    Label2: TLabel;
    UseListCB: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    ForayPlaceList: TListView;
    Label3: TLabel;
    MergeGB: TGroupBox;
    MergeButton: TButton;
    ForayToMergeWith: TEdit;
    ForayToMerge: TEdit;
    PrepareMergeButton: TButton;
    ForayListGrid: TIB_Grid;
    CloseButton: TButton;
    EditForayDate: TIB_Edit;
    EditForayName: TIB_Edit;
    EditForaycode: TIB_Edit;
    ForayPlaceMemo: TIB_Memo;
    ForayCountryList: TIB_ComboBox;
    Label7: TLabel;
    AcceptButton: TButton;
    Panel1: TPanel;
    Label8: TLabel;
    IB_NavigationBar1: TIB_NavigationBar;
    DuplicateButton: TButton;
    NewForayButton: TButton;
    DeleteForayButton: TButton;
    CancelButton: TButton;
    EditForayButton: TButton;
    SaveButton: TButton;
    SearchPanel: TPanel;
    Label9: TLabel;
    SearchVal: TEdit;
    SearchButton: TButton;
    StringStart: TCheckBox;
    SearchfromTop: TCheckBox;
    Label6: TLabel;
    ForayCommentsMemo: TIB_Memo;
    SeeFindsButton: TButton;
    EditFindsButton: TButton;
    procedure SaveNewForayButtonClick(Sender: TObject);
    procedure UseListCBClick(Sender: TObject);
    procedure ForayPlaceListDblClick(Sender: TObject);
    procedure EditForayButtonClick(Sender: TObject);
    procedure NewForayButtonClick(Sender: TObject);
    procedure CloseListButtonClick(Sender: TObject);
    procedure ForayListGridExit(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ForayNameDateExit(Sender: TObject);
    procedure PrepareMergeButtonClick(Sender: TObject);
    procedure MergeButtonClick(Sender: TObject);
    procedure MergeWithButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DeleteForayButtonClick(Sender: TObject);
    procedure ForayListGridClick(Sender: TObject);
    procedure EditForayDateEnter(Sender: TObject);
    procedure EditForayDateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AcceptButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SeeFindsButtonClick(Sender: TObject);
    procedure EditFindsButtonClick(Sender: TObject);
  private
    procedure FillList;
    function ParseDate(InputDate:string;var OutputDate:TDate;var Day,Month,Year:integer):boolean;
  public
    Mode:smallInt;
    CurrentForay:TForay;
    ForayQuery:TIB_Query;
    { Déclarations publiques }
  end;

var
  ForayForm: TForayForm;

implementation

uses Finds, IMSMain;


{$R *.dfm}

procedure TForayForm.AcceptButtonClick(Sender: TObject);
begin
    ModalResult:=mrOK;
end;


procedure TForayForm.CancelButtonClick(Sender: TObject);
begin
  if ForayQuery.Modified then
      ForayQuery.Cancel;
  EditPanel.Visible:=false;
end;

procedure TForayForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TForayForm.CloseListButtonClick(Sender: TObject);
begin
    ForayPlaceList.Visible:=true;
end;


procedure TForayForm.DeleteForayButtonClick(Sender: TObject);
begin
    EditPanel.Visible:=true;
    if MessageDlg('Delete this foray?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
     IMSDM.ExplicitDelete(ForayQuery);
    EditPanel.Visible:=false;                     // refs???
end;

procedure TForayForm.EditFindsButtonClick(Sender: TObject);
begin
  FindsForm.Show;
end;

procedure TForayForm.EditForayButtonClick(Sender: TObject);
begin
   if ForayQuery.State=dssBrowse then ForayQuery.Edit;
   EditPanel.Visible:=true;
   MergeButton.Enabled:=false;
end;


procedure TForayForm.FillList;
var ForayLine:TListItem;
begin
   with ForayQuery do
   begin
    ForayPlaceList.Items.Clear;
    Open;
    First;
    while not Eof do begin
      ForayLine:=ForayPlaceList.Items.Add;
      ForayLine.Caption:=FieldValues['FORAYNAME'];
      ForayLine.SubItems.Add(FieldValues['FORAYCOUNTRY']);
      ForayLine.SubItems.Add(FieldValues['FORAYPLACE']);
      Next;
    end;
   end;
end;

procedure TForayForm.ForayPlaceListDblClick(Sender: TObject);
var i:integer;
begin
  i:=ForayPlaceList.ItemIndex;
  with IMSDM.AllForaysQuery do begin
    FieldValues['FORAYNAME']:=ForayPlaceList.Items[i].Caption;
    FieldValues['FORAYCOUNTRY']:=ForayPlaceList.Items[i].SubItems[0];
    FieldValues['FORAYPLACE']:=ForayPlaceList.Items[i].SubItems[1];
  end;
end;

procedure TForayForm.EditForayDateEnter(Sender: TObject);
var ResultDate,DefDate:TDate; day,month,year:integer;
begin
{  DefDate:=encodeDate(2020,01,01);
  if ParseDate(ForayDate.Text,ResultDate,day,month,year) then
  begin
  end }
end;

procedure TForayForm.EditForayDateMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var DefDate:TDate;
begin
//under construction
end;

procedure TForayForm.ForayListGridClick(Sender: TObject);
begin
    CurrentForay.foraycode:=ForayQuery.FieldByName('foraycode').AsString;
    EditForayButton.Enabled:=true;
    DeleteForayButton.Enabled:=true;
    if MergeButton.Enabled then ForayToMerge.Text:=CurrentForay.foraycode;
end;

procedure TForayForm.ForayListGridExit(Sender: TObject);
begin
   if IMSDM.AllForaysQuery.Modified then
      if MessageDlg('Save last edited record?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
        IMSDM.AllForaysQuery.Post
      else IMSDM.AllForaysQuery.Cancel;
end;

procedure TForayForm.ForayNameDateExit(Sender: TObject);
var aforaycode:widestring;
begin
  if not IMSDM.AllForaysQuery.FieldByName('Forayname').IsNull then
  begin
    if IMSDM.AllForaysQuery.FieldByName('Foraydate').IsNull then IMSDM.AllForaysQuery.FieldValues['Foraydate']:='';
    aForaycode:=Trim(IMSDM.AllForaysQuery.FieldValues['Forayname'])+'/'+IMSDM.AllForaysQuery.FieldValues['Foraydate'];
    IMSDM.AllForaysQuery.FieldValues['FORAYCODE']:=aforaycode;
  end;
end;



procedure TForayForm.FormActivate(Sender: TObject);
begin
    ForayQuery:=ForayListGrid.DataSource.DataSet as TIB_Query;
   //initialize for mode of entry
    if Mode=SearchMode then
    begin
      AcceptButton.Visible:=true;
      CloseButton.Visible:=false;
    end
    else begin
      AcceptButton.Visible:=false;
      CloseButton.Visible:=true;
    end;
    if (currentForay.foraycode<>'') then
    begin
      if not ForayQuery.Active then ForayQuery.Open;
     (ForayQuery as TIB_Query).Locate('FORAYCODE',currentForay.foraycode,[]);
    end
    else FillList;
    ForayQuery.OrderingItemNo:=1;
end;



procedure TForayForm.FormCreate(Sender: TObject);
begin
    CurrentForay:=TForay.Create;
  //bug fix to avoid Stream error
  ForayPlaceList.ViewStyle:=vsReport;
  ForayPlaceList.Clear;
end;

procedure TForayForm.FormDestroy(Sender: TObject);
begin
    CurrentForay.Free;
end;

procedure TForayForm.MergeButtonClick(Sender: TObject);
begin
  if (ForayToMergeWith.Text<>'') and (ForayToMerge.Text<>'')
  and (ForayToMergeWith.Text<>ForayToMerge.Text) then
  begin
   try
      IMSDM.FindsByForayQuery.First;
      while not eof do begin         // replace foraycode
          IMSDM.FindsByForayQuery.FieldValues['FORAYCODE']:=ForayToMergeWith.Text;
          IMSDM.FindsByForayQuery.Post;
      end;
      IMSDM.FindsByForayQuery.Close;
   except
      on e:exception do ShowMessage('Error '+e.message+' on or after '+IMSDM.FindsByForayQuery.FieldValues['FINDID']);
   end;
   //FindsForm.ShowModal;
  end;
end;

procedure TForayForm.MergeWithButtonClick(Sender: TObject);
begin
  ForayToMergeWith.Text:=IMSDM.AllForaysQuery.FieldValues['FORAYCODE'];
  MergeButton.Enabled:=true;
end;

procedure TForayForm.NewForayButtonClick(Sender: TObject);
begin
   EditPanel.Visible:=true;
   ForayQuery.Append;
end;

function TForayForm.ParseDate(InputDate:string;var OutputDate:TDate;var Day,Month,Year:integer):boolean;
var k,k2:integer; rest:string;
begin
  k:=Pos('-', InputDate);
  if k=0 then year:=StrToIntDef(InputDate,99)
  else begin
    year:=StrToIntDef(copy(InputDate,1,k-1),99);
    rest:=copy(InputDate,k+1,999);
    k2:=Pos('-',rest);
    if k2=0 then
    begin
      day:=0;
      month:=StrToIntDef(rest,999);
    end
    else begin
       month:=StrToIntDef(copy(rest,1,k2-1),99);
       day:=StrToIntDef(copy(rest,k2+1,999),999);
       try
        OutputDate:=encodeDate(year,month,day);
        result:=true;
       except
         on EConvertError do result:=false;
       end;
    end;
  end;
end;

procedure TForayForm.PrepareMergeButtonClick(Sender: TObject);
begin
  ForayToMerge.Text:=CurrentForay.foraycode;
  MergeButton.Enabled:=true;
  ShowMessage('Select foray to merge with by clicking in list');
end;

procedure TForayForm.SaveNewForayButtonClick(Sender: TObject);
begin
  if (EditForayName.Text<>'') and (ForayQuery.Modified) then
  begin
      if EditForayCode.Text='' then EditForayCode.Text:=EditForayName.Text+'/'+EditForayDate.Text;
      ForayQuery.Post;
  end;
  EditPanel.Visible:=false;
end;

procedure TForayForm.SearchButtonClick(Sender: TObject);
begin
  if (SearchVal.Text<>'') and ForayListGrid.SelectedField.IsText then
  begin
    with TIB_Query(ForayQuery) do
    begin
      if SearchFromTop.Checked then First else Next;
      DisableControls;
      if StringStart.Checked then   //start at beginning of string
      begin
          while not eof do
          begin
            if (ForayListGrid.SelectedField.Value>'') and     //substring found at start (pos 1)
               (Pos(SearchVal.Text,ForayListGrid.SelectedField.Value)=1) then break
            else Next;
          end;
          if eof then Locate('FORAYCODE',currentForay.foraycode,[])   //not found
          else currentForay.ReadFromDataset(ForayQuery);
      end
      else
      begin
          while not eof do
          begin
            if (ForayListGrid.SelectedField.Value>'') and     //substring found
                 (Pos(SearchVal.Text,ForayListGrid.SelectedField.Value)>0) then break
            else Next;
          end;
          if eof then Locate('BOOKCODE',currentForay.foraycode,[])   //not found
          else currentForay.ReadFromDataset(ForayQuery);
      end;
      EnableControls;
    end;
  end;

end;

procedure TForayForm.SeeFindsButtonClick(Sender: TObject);
begin
    FindsForm.Show;
end;

procedure TForayForm.UseListCBClick(Sender: TObject);
begin
  if (Sender as TCheckBox).State=cbChecked then begin
     ForayPlaceList.Visible:=True;
     FillList;
  end
  else ForayPlaceList.Visible:=False;
end;
end.
