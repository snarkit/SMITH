unit BooksTransfer;
 // appears to copy data from Books in Bookplate project into Books in IMS data
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BookConcepts, Grids, IB_Grid, ExtCtrls, IB_NavigationBar,
  IB_Session;

type
  TBooksTransferForm = class(TForm)
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
    CurrentIMSBook, CurrentOldBook: TBook;
    Interrupt:boolean;
    { Public declarations }
  end;

var
  BooksTransferForm: TBooksTransferForm;

implementation

uses IMSData, BookData, IB_Components, BookEdit;

{$R *.dfm}
// reads books from IMSDB updated bi IMS, compares with old file records and
// appends or modifies old file as necessary
procedure TBooksTransferForm.FormActivate(Sender: TObject);
begin
      if IMSDM.FBConnection.ConnectionStatus = csDisconnected then IMSDM.FBConnection.Connected:=true;
      if BooksDM.BookConnection.ConnectionStatus = csDisconnected then BooksDM.BookConnection.Connected:=true;
      if not BooksDM.NewBooksquery.Active then BooksDM.NewBooksquery.open;
      if not IMSDM.AllBooksQuery.Active then IMSDM.AllBooksQuery.Open;
end;

procedure TBooksTransferForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      CurrentIMSBook.Free;
      CurrentOldBook.Free;
      CurrentIMSBook:= nil;
      CurrentOldBook:= nil;
      Interrupt:=false;
      if BooksDM.NewBooksquery.Active then BooksDM.NewBooksquery.close;
      if IMSDM.AllBooksQuery.Active then IMSDM.AllBooksQuery.close;
      if IMSDM.BookByCodeQuery.active then IMSDM.BookByCodeQuery.close;
end;

procedure TBooksTransferForm.FormCreate(Sender: TObject);
begin
      CurrentIMSBook:= TBook.create;
      CurrentOldBook:= TBook.create;
end;

procedure TBooksTransferForm.GoButtonClick(Sender: TObject);
var differences,problems:string; showreply,reply,nbrecs:integer;
begin
  try
    nbrecs:=0;
    while not BooksDM.NewBooksquery.eof do
    begin
      //for each record if not marked V
      if UnProcessedCB.Checked or (BooksDM.NewBooksquery.FieldValues['Marker']<>'V') then
      begin
        CurrentIMSBook.ReadFromDataset(BooksDM.NewBooksquery);
        IMSDM.GetBookByCode(CurrentIMSBook.Bookcode,CurrentOldBook);
        differences:='';
        problems:='';
        if CurrentOldBook.Bookcode<>'' then
        begin
          if CurrentOldBook.Ref<>CurrentIMSBook.Ref then
            problems:=problems+CurrentOldBook.bookcode+': '+CurrentOldBook.ref+'/'+ CurrentIMSBook.Ref+',';
          //book plate status is always to be copied so copy it and save
          if CurrentOldBook.BookPlateStatus<>CurrentIMSBook.BookPlateStatus then
          begin
            CurrentOldBook.BookPlateStatus:=CurrentIMSBook.BookPlateStatus;
            IMSDM.BookByCodeQuery.edit;
            CurrentOldBook.WriteToDataset(IMSDM.BookByCodeQuery);
          end;   //bookplate status
          differences:=CurrentOldBook.Compare(CurrentIMSBook);
          if (length(differences)>0) and (differences<>'shortcode,UsedBy,NumberOfPages') then
          begin          //books differ
            if messageDlg('Fields '+differences+' for '+CurrentOldBook.bookcode+
              ' have been changed. View differences and decide?',mtWarning,[mbYes,mbNo],0)=mrYes then
            begin
              BookEditForm.DifferenceList.Items.Clear;
              BookEditForm.DifferenceList.Items.Delimiter:=',';
              BookEditForm.DifferenceList.Items.DelimitedText:=differences;
              BookEditForm.UpdateButton.Enabled:=true;
              BookEditForm.ExistPanel.Visible:=true;
              BookEditForm.Recct.Caption:=IntToStr(nbrecs);
              showreply:=BookEditForm.showModal;
              if showreply=mrOK then
              begin
                if MessageDlg('OK to overwrite old data with Ian''s new data?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
                begin
                  CurrentOldBook.Assign(CurrentIMSBook);
                  IMSDM.BookByCodeQuery.edit;
                  CurrentOldBook.WriteToDataset(IMSDM.BookByCodeQuery);
                end //yes to use IMS version
              end //showreply OK
              else if showreply=mrCancel then
              begin
                  if MessageDlg('Confirm rewrite old data with changes?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
                  begin
                    IMSDM.BookByCodeQuery.edit;
                    CurrentOldBook.WriteToDataset(IMSDM.BookByCodeQuery);
                  end;  //yes to use old data
              end //showreply Cancel
              else if showreply=mrIgnore then
              begin //ignore = postpone
                    BooksDM.NewBooksquery.edit;
                    BooksDM.NewBooksquery.FieldValues['Marker']:='V';
                    BooksDM.NewBooksquery.Post;
              end; //showreply Ignore
            end; // yes to view data
          end; // differences found
        end  // blank bookcode
        else begin   //new book
          reply:=MessageDlg('Insert Ian''s new data for '+CurrentIMSBook.bookcode+'?',mtConfirmation,[mbYes,mbNo,mbAbort],0);
          if reply=mrYes then
          begin
            BookEditForm.ExistPanel.Visible:=false;
            BookEditForm.UpdateButton.Enabled:=false;
            BookEditForm.Recct.Caption:=IntToStr(nbrecs);
            showreply:= BookEditForm.showModal;
            if showreply=mrOK then
            try
              IMSDM.BookByCodeQuery.Insert;            //new book
              CurrentIMSBook.WriteToDataset(IMSDM.BookByCodeQuery);
            except on e:EIB_ISCError do
              begin
                showMessage('Error: '+e.Errormessage.Text);
                IMSDM.BookByCodeQuery.Cancel;
              end;

            end //showreply OK
          end; // yes to insert
        end; // new book
      end; // not marked for later or all
      if (reply=mrAbort) or Interrupt then Break;
      BooksDM.NewBooksquery.Next;
      inc(nbrecs);
    end //while
    finally
      IMSDM.IMSTransaction.Commit;
      IMSDM.BookByCodeQuery.Close;
      problemList.Items.DelimitedText:=Problems;
      ProblemList.Visible:=true;
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
