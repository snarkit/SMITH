unit Books;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Grids, DBGrids, Printers,
  ExtCtrls, DBCtrls, IB_Grid, IB_Components, IB_Access,  IMSMain,
  IB_NavigationBar, BookConcepts, IB_Controls, Mask, IB_EditButton;

type
  TBooksForm = class(TForm)
    DataGrid: TIB_Grid;
    TopPanel: TPanel;
    LeftPanel: TPanel;
    NavPanel: TPanel;
    Label3: TLabel;
    IB_NavigationBar1: TIB_NavigationBar;
    DuplicateButton: TButton;
    InsertButton: TButton;
    DeleteButton: TButton;
    EditButton: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog: TPrintDialog;
    SearchPanel: TPanel;
    Label6: TLabel;
    SearchVal: TEdit;
    SearchButton: TButton;
    StringStart: TCheckBox;
    SearchfromTop: TCheckBox;
    EditPanel: TPanel;
    EditRef: TIB_Edit;
    EditBookcode: TIB_Edit;
    EditShortcode: TIB_Edit;
    EditAuthor: TIB_Edit;
    EditDateAcq: TIB_Edit;
    EditEdition: TIB_Edit;
    EditISBN: TIB_Edit;
    EditNbPages: TIB_Edit;
    EditOPlace: TIB_Edit;
    EditOPublisher: TIB_Edit;
    EditOrigTitle: TIB_Edit;
    EditOYear: TIB_Edit;
    EditPrice: TIB_Edit;
    EditPlace: TIB_Edit;
    EditPublisher: TIB_Edit;
    EditSubject: TIB_Edit;
    IB_Memo1: TIB_Memo;
    EditVolume: TIB_Edit;
    EditYear: TIB_Edit;
    EditTitle: TIB_Edit;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Title: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Subject: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Publisher: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    EditUseText: TIB_Text;
    CaseCB: TCheckBox;
    EditUsesButton: TButton;
    EditUsePanel: TPanel;
    AcceptUseButton: TButton;
    CancelUseButton: TButton;
    SaveButton: TButton;
    CancelButton: TButton;
    BooksDS: TIB_DataSource;
    FilterPanel: TPanel;
    Label2: TLabel;
    NbRecords: TLabel;
    Label1: TLabel;
    UseFilterRG: TRadioGroup;
    BookplatePanel: TPanel;
    Label5: TLabel;
    PreviewButton: TButton;
    PagePreviewButton: TButton;
    PrintButton: TButton;
    ClearXButton: TButton;
    PrintFilterRG: TRadioGroup;
    SetXButton: TButton;
    CloseButton: TButton;
    Label24: TLabel;
    IB_ComboBox1: TIB_ComboBox;
    procedure PreviewButtonClick(Sender: TObject);
    procedure ClearXButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FilterRGClick(Sender: TObject);
    procedure DuplicateButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InsertButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure MarkAllButtonClick(Sender: TObject);
    procedure PagePreviewButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClearPButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure DataGridDblClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DataGridTitleClick(Sender: TObject; ACol, ARow: Integer;
      AButton: TMouseButton; AShift: TShiftState);
    procedure AcceptUseButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DataGridCellClick(Sender: TObject; ACol, ARow: Integer;
      AButton: TMouseButton; AShift: TShiftState);
    procedure SetXButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure UseButtonClick(Sender: TObject);
    procedure EditUsesButtonClick(Sender: TObject);
    procedure CancelUseButtonClick(Sender: TObject);
  private
    FilterChanged:boolean;
    chckBoxArray: array of TCheckBox;
    procedure CreateEditUseCheckboxes;
    procedure DoFilter;
    procedure SelectApplication(BookUseName: ansistring);
    procedure SelectPrintCategory(Value: string);
    procedure StopPrinting;
    procedure FillEditUsePanel;

  public
    CurrentBook:TBook;
    CurrentUseName:ansistring;
    BookUses:TBookUses;
    NewUseName:ansistring;
    Mode:smallInt;
    BookQuery:TIB_Query;
    MyBookmark:string;
  end;

var
  BooksForm: TBooksForm; code:string;

implementation

uses BPPrint, IMSData;
{$R *.dfm}


procedure TBooksForm.CloseButtonClick(Sender: TObject);
//available when form is called modally.
// If a use is set by the caller it is added to the selected book
begin
  if CloseButton.Caption='Close' then Close
  else begin
    if (CurrentBook.IsEmpty) then CurrentBook.ReadFromDataset(BookQuery); //if no book selected get details of selected book
    //Add new use code
    if (not CurrentBook.IsEmpty) and (NewUseName<>'') then  //if new use is blank, there is nothing to add
    begin
      if CurrentBook.AddUse(NewUseName) then   //invalid use can't be added
        try
        CurrentBook.WriteToDataset(BookQuery);
        SaveButton.Click;
        except
           on e:exception do ShowMessage('Error '+e.message);
        end;
    end;
    ModalResult:=mrOK;
  end;
end;

procedure TBooksForm.AcceptUseButtonClick(Sender: TObject);
var i:integer;
begin
   CurrentBook.ClearUses;
   //add each use which is checked using itsindex
   for i := low(chckBoxArray) to high(chckBoxArray) do
      if chckBoxArray[i].Checked then
      begin
        CurrentBook.AddUse(BookUses[i+1].UseName);
      end;
   try
      BookQuery.FieldValues['USEDBY']:=CurrentBook.UsedBy;
   except
     on e:exception do ShowMessage('Error '+e.message);
   end;
   EditUsePanel.Visible:=false;
   SaveButton.Enabled:=true;
   CancelButton.Enabled:=true;
end;

procedure TBooksForm.CancelButtonClick(Sender: TObject);
begin
   if BookQuery.NeedToPost then
   try
    BookQuery.Cancel;
   finally
    EditPanel.Visible:=false;
    DataGrid.Enabled:=true;;
   end;
end;

procedure TBooksForm.CancelUseButtonClick(Sender: TObject);
begin
    EditUsePanel.Visible:=false;
   SaveButton.Enabled:=true;
   CancelButton.Enabled:=true;
end;

procedure TBooksForm.ClearXButtonClick(Sender: TObject);
begin
  with BookQuery do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldValues['Print'] = 'X' then
      begin
        Edit;
        FieldValues['Print'] := ' ';
        IMSDM.ExplicitPost(BookQuery);
      end;
      Next;
    end;
    First;
    EnableControls;
  end;
end;

procedure TBooksForm.ClearPButtonClick(Sender: TObject);
begin
  if MessageDlg('This will reset all P''s shown to X. Continue?', mtWarning,[mbOK,mbCancel],0)=mrOK then
  with BookQuery do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldValues['Print'] = 'P' then
      begin
        Edit;
        FieldValues['Print'] := 'X';
        IMSDM.ExplicitPost(BookQuery);
        Next;
      end;
    end;
    First;
    EnableControls;
  end;

end;

procedure TBooksForm.CreateEditUseCheckboxes;
   //Create a check box for each possible use on EditUsePanel
   //(excluding 'Source')
var i,maxwidth:integer;
begin
    EditUsePanel.Height:=100+BookUses.Count*25;
    maxwidth:=0;
    SetLength(chckBoxArray, BookUses.Count-1) ; //no 'Source'
    //create checkboxes
    for i := 0 to BookUses.Count-2   do   //NB count of checkboxes is 1 less than count of uses
    begin
      chckBoxArray[i] := TCheckBox.Create(nil) ;
      chckBoxArray[i].Parent:=EditUsePanel;    //need parent to display component
      chckBoxArray[i].top:=40+i*25;
      chckBoxArray[i].left:=20;
      chckBoxArray[i].ClientWidth:=Canvas.TextWidth(BookUses[i+1].Heading)+100;
      if chckBoxArray[i].ClientWidth>maxwidth then maxwidth:=chckBoxArray[i].ClientWidth;
      chckBoxArray[i].Caption:=BookUses[i+1].Heading;
    end;
    AcceptUseButton.Top:=EditUsePanel.Height-50;
    CancelUseButton.Top:=AcceptUseButton.Top;
    EditUsePanel.Width:=maxwidth;
    AcceptUseButton.Left:=30;
    CancelUseButton.Left:=(EditUsePanel.Width-CancelUseButton.Width-AcceptUseButton.Left) ;
end;

procedure TBooksForm.DataGridTitleClick(Sender: TObject; ACol, ARow: Integer;
  AButton: TMouseButton; AShift: TShiftState);
begin
  TIB_Query(BookQuery).Locate('BOOKCODE',code,[]);  //keep current record active
  DataGrid.Col:=ACol;
  {if DataGrid.GridFields[ACol].DisplayWidth>DataGrid.GridFields[ACol].DefaultWidth then
     DataGrid.GridFields[ACol].DefaultWidth }
end;

procedure TBooksForm.DataGridCellClick(Sender: TObject; ACol, ARow: Integer;
  AButton: TMouseButton; AShift: TShiftState);
begin
    if BookQuery.State=dssBrowse then  //first entry to new row
        CurrentBook.ReadFromDataset(BookQuery);
end;

procedure TBooksForm.DataGridDblClick(Sender: TObject);
begin
  if DataGrid.SelectedField.FieldName='PRINT' then  // click in Print column - toggle print status
   begin
    BookQuery.Edit;
    if (BookQuery.FieldByName('Print').IsNull) or (BookQuery.FieldValues['Print']='')
      or (BookQuery.FieldValues['Print']=' ') then       //blank to X
      BookQuery.FieldByName('Print').Value := 'X'
    else
    if BookQuery.FieldValues['Print'] = 'X' then       //X to Z
      BookQuery.FieldValues['Print'] := 'Z'
    else
    if BookQuery.FieldValues['Print'] = 'Z' then       //Z to blank
      BookQuery.FieldValues['Print'] := ' '
    else
    if BookQuery.FieldValues['Print'] = 'P' then       //P to blank (error)
      BookQuery.FieldValues['Print'] := ' ';
    IMSDM.ExplicitPost(BookQuery);
   end;
   CurrentBook.ReadFromDataset(BookQuery);    //get details of selected book
end;


procedure TBooksForm.DeleteButtonClick(Sender: TObject);
var code:string;
begin
  if BookQuery.FieldByName('BOOKCODE').IsNotNull then code:=BookQuery.FieldValues['BOOKCODE']
  else code:='this record';
  if MessageDlg('Confirm deletion of '+code+'?', mtConfirmation,[mbOK,mbCancel],0)=mrOK then
  begin
     IMSDM.ExplicitDelete(BookQuery);
  end;
end;

procedure TBooksForm.DoFilter;
begin  if FilterChanged then
  begin
    BookQuery.Prepare;
    BookQuery.Open;          //reopen data to apply new filter
    BookQuery.Last;
    NbRecords.Caption := IntToStr(BookQuery.RecordCount);
    BookQuery.First;
    FilterChanged:=false;
  end;
end;

procedure TBooksForm.DuplicateButtonClick(Sender: TObject);
var
  i: integer;
  SavedValues: array of variant;
begin
  MyBookmark:= BookQuery.Bookmark;    //bookmark current
  with BookQuery do
  begin
    setlength(SavedValues, FieldCount);
    try
      for i := 0 to FieldCount - 1 do
        SavedValues[i] := Fields[i].Value;
      Insert;
      for i := 0 to FieldCount - 1 do
      begin
        if Fields[i].FieldName<>'BOOKID' then Fields[i].Value := SavedValues[i];
        if Fields[i].FieldName='BOOKCODE' then Fields[i].Value := '*'+SavedValues[i]  //avoid duplicate code
        else if Fields[i].FieldName='REF' then Fields[i].Value := '*'+SavedValues[i];  //avoid duplicate reference
      end;
    finally
      SavedValues := nil;  //deallocate memory
    end;
    EditPanel.Visible:=true;
  end;
end;

procedure TBooksForm.EditButtonClick(Sender: TObject);
begin
    if BookQuery.State=dssBrowse then BookQuery.Edit;
    EditPanel.Visible:=true;
    EditPanel.Top:=ClientRect.Top;
    DataGrid.Enabled:=false;
    EditPanel.BringToFront;
end;

procedure TBooksForm.UseButtonClick(Sender: TObject);
begin
   //
   if Sender is TCheckBox then ShowMessage('Checkbox '+(sender as TCheckbox).Caption);
end;

procedure TBooksForm.EditUsesButtonClick(Sender: TObject);
begin
   FillEditUsePanel;
   EditUsePanel.Visible:=true;
   SaveButton.Enabled:=false;
   CancelButton.Enabled:=false;
end;


procedure TBooksForm.ExitButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TBooksForm.FillEditUsePanel;
var i:integer;
// sets checkboxes on use editing panel according to edited book's bookuse
begin
   for i := 0 to High(chckBoxArray) do //NB 'All' not present so there are fewer checkboxes than uses
   //check boxes corresponding to uses
   begin
      if ansipos(BookUses[i+1].UseCode,CurrentBook.UsedBy)>0 then //BookUses start with 'Source'
          chckBoxArray[i].Checked:=true
      else chckBoxArray[i].Checked:=false;
   end;
end;

procedure TBooksForm.FilterRGClick(Sender: TObject);
var i:integer; OldCursor:TCursor;
//sets filter according to checkboxes
begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourglass;
    if Sender=PrintFilterRG then UseFilterRG.ItemIndex:=-1  //reset typefilter
    else PrintFilterRG.ItemIndex:=-1;   //reset printing filter
    // if print filter exists use selection is ignored. Should they be combined?
    if PrintFilterRG.ItemIndex = 0 then SelectPrintCategory('X')   //for printing
    else if PrintFilterRG.ItemIndex = 1 then SelectPrintCategory('P')   //printed in last batch
    else if PrintFilterRG.ItemIndex = 2 then SelectPrintCategory('Z')   //finished
    else if UseFilterRG.ItemIndex >0 then    //not all uses
      begin
       CurrentUseName:=BookUses[UseFilterRG.ItemIndex].UseName;
       SelectApplication(CurrentUseName)  //particular use
      end
    else
        SelectPrintCategory('All');  //all books and other sources
    DoFilter;
    Screen.Cursor:=OldCursor;
end;

procedure TBooksForm.FormActivate(Sender: TObject);
var fieldname:string; Index:integer;OldCursor:TCursor;
begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourglass;
    BooksDS.Dataset:=BookQuery;
    DisableAlign;
    //arrange form according to entry mode
    if (Mode=EditMode) or (Mode=SearchMode) then
    begin
      BookplatePanel.Visible:=false;
      CloseButton.Height:=30;
      CloseButton.Left:=1000;
      DataGrid.Font.Size:=10;
      DataGrid.CurrentRowFont.Size:=11;
      DataGrid.CurrentRowColor:=clWhite;
      DataGrid.OrderingFont.Size:=10;
      DataGrid.DefaultRowHeight:=25;
    end;
    if Mode=BookplatesMode then
    begin
      BookplatePanel.Visible:=true;
      DataGrid.Font.Size:=11;
      DataGrid.CurrentRowColor:=clWhite;
      DataGrid.CurrentRowFont.Size:=11;
      DataGrid.OrderingFont.Size:=11;
      DataGrid.DefaultRowHeight:=28;
      CloseButton.Left:=1250;
    end;
    EnableAlign;
    if currentUseName='' then CurrentUseName:='Book';  //default use is books only
    Index:=BookUses.FindUseIndex(CurrentUseName);
    //on new entry set filter according to calling routine
    if BookQuery.Active=false then     //new entry after closing
    begin
      if UseFilterRG.ItemIndex<>Index then
        UseFilterRG.ItemIndex:=Index
      else begin
        FilterChanged:=True;         //force re-evaluation of query
        dofilter;
      end;
      BookQuery.OrderingItemNo:=7;  //title order
    end;
    //set buttons for mode of entry
    if Mode=SearchMode then
    begin
      CloseButton.Caption:='Accept';
      CloseButton.ModalResult:=mrOK;
    end
    else begin
      CloseButton.Caption:='Close';
      CloseButton.ModalResult:=mrNone;
    end;
    if Mode=EditMode then
    begin
      BookQuery.Locate('Bookcode',Currentbook.bookcode,[],1);
      //BookQuery.Edit;
    end;
    Screen.Cursor:=OldCursor;
end;

procedure TBooksForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if BookQuery.Modified then    //NeedToPost is IBO and indicates a record has been changed
    if MessageDlg('The current record has not been saved. Keep changes?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      SaveButton.Click;
    end
    else BookQuery.Cancel;
   BookQuery.Close;
   CloseButton.Caption:='Close';       //restore normal function
   CloseButton.ModalResult:=mrNone;
   Mode:=0;
end;

procedure TBooksForm.FormCreate(Sender: TObject);
var i,maxwidth:integer;
begin
  CurrentBook:=TBook.Create;
  BookUses:=TBookUses.Create;
  Mode:=0;  //set by clients
  CreateEditUseCheckboxes;
  //Insert search by use radio buttons
  for i := 0 to BookUses.Count-1 do  //includes 'Source'
      UseFilterRG.Items.Add(BookUses[i].Heading+' ('+BookUses[i].Heading+')');
  CurrentUseName:='Book';  //default use is books only
end;

procedure TBooksForm.FormDestroy(Sender: TObject);
var i:integer;
begin
  while UseFilterRG.Items.Count>0 do
    UseFilterRG.Items.delete(0);
  for i:=0 to length(chckBoxArray)-1 do
    FreeAndNil(chckBoxArray[i]);
  FreeAndNil(CurrentBook);
  FreeAndNil(BookUses);
end;

procedure TBooksForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    StopPrinting;
end;

procedure TBooksForm.InsertButtonClick(Sender: TObject);
var refno, OldOrdering:integer; newref, bookcode:string;
begin
  MyBookmark:= BookQuery.Bookmark;
  OldOrdering:=BookQuery.OrderingItemNo;
  BookQuery.OrderingItemNo:=6;         //ref order
  TIB_Query(BookQuery).Locate('REF','1',[lopPartialKey]);
  BookQuery.Prior;               //last numeric starting with 0 (will work until we reach 1000)
  refno:=BookQuery.FieldByName('REF').AsInteger;
  if refno<999 then newref:='0'+IntToStr(refno+1)
  else
  begin
    ShowMessage('Sequential reference numbers have reached 1000. Cannot calculate next free number.');
    newref:='0';
  end;
  BookQuery.OrderingItemNo:=OldOrdering;         //previous ordering
  BookQuery.Insert;
  CurrentBook.Clear;
  CurrentBook.Bookcode:='Unique bookcode here';
  BookQuery.FieldValues['Bookcode']:=CurrentBook.Bookcode;
  CurrentBook.Title:='Title of source here';
  BookQuery.FieldValues['Title']:=CurrentBook.Title;
  CurrentUseName:='Book';
  CurrentBook.AddUse(CurrentUseName);
  bookcode:=BookUses.FindUseCode(CurrentUseName);
  BookQuery.FieldValues['USEDBY']:=bookcode;
  CurrentBook.Ref:=newref;
  BookQuery.FieldValues['REF']:= newref;
  BookQuery.FieldValues['PRINT']:=' ';
  BookQuery.FieldValues['MARKER']:='S';
  EditPanel.Visible:=true;
end;

procedure TBooksForm.MarkAllButtonClick(Sender: TObject);
begin
  with BookQuery do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
        Edit;
        FieldValues['PRINT'] := 'X';
        IMSDM.ExplicitPost(BookQuery);
        Next;
    end;
    First;
    EnableControls;
  end;

end;


procedure TBooksForm.PreviewButtonClick(Sender: TObject);
var BookPlate:TBookPlate;
begin
      BPPrintForm.PaintBox1.Height:=650;
      BPPrintForm.PaintBox1.Width:=MulDiv(BPPrintForm.PaintBox1.Height,210,297);      //screen pixels are approx square
      BookPlate:=TBookPlate.Create(BPPrintForm.PaintBox1.ClientHeight,BPPrintForm.PaintBox1.ClientWidth);   //create 1 bookplate
    try
      BookPlate.Source:=TBook.Create;
      BookPlate.Fill(BookQuery);
      BPPrintForm.WBitmap.Height:=BPPrintForm.PaintBox1.Height;
      BPPrintForm.WBitmap.Width:=BPPrintForm.PaintBox1.Width;
      BookPlate.Paint(BPPrintForm.WBitmap.Canvas);
      BPPrintForm.ShowModal;
    finally
      BookPlate.Free;
    end;
end;

procedure TBooksForm.PrintButtonClick(Sender: TObject);
var NbPrinted:Integer;
   BookPlate:TBookPlate; BookPlatePage:TBookPlatePage;
begin
  if PrintDialog.Execute then
  begin
  BookPlatePage:=TBookPlatePage.Create;     //create page
  try
    BookPlatePage.MaxCols:=2;
    BookPlatePage.MaxRows:=2;
    BookPlatePage.PageHeight:=Printer.PageHeight;
    BookPlatePage.PageWidth:=Printer.PageWidth;
    NbPrinted:=0;
    with BookQuery do
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        if FieldValues['Print']='X' then
        begin
          if BookPlatePage.Pagefull then
          begin
            BookPlatePage.Print;
            BookPlatePage.Clear;
          end;
          BookPlate:=TBookPlate.Create(BookPlatePage.LabelHeight,BookPlatePage.LabelWidth);//create 1 bookplate
          BookPlate.Source:=TBook.Create;
          BookPlate.Fill(BookQuery);
          BookPlatePage.AddBookPlate(BookPlate);
          inc(NbPrinted);
          Edit;
          FieldValues['Print']:='P';
          IMSDM.ExplicitPost(BookQuery);
        end;
        Next;
        EnableControls;
      end;
    end;
    if (BookPlatePage.BookPlates[1,1]<>nil) then
    begin
      BookPlatePage.Print;
      BookPlatePage.Clear;
    end;
    if MessageDlg(IntToStr(NbPrinted)+' bookplates printed. Mark them as done?',mtInformation,[mbYes,mbNo],0)=mrYes
    then
    with BookQuery do
    begin
      First;
      while not EOF do
      begin
        if FieldValues['Print']='P' then
        begin
          Edit;
          FieldValues['Print']:='Z';
          IMSDM.ExplicitPost(BookQuery);
        end;
        Next;
      end;
    end;
    PreviewButton.Enabled:=false;    //eof, need to select a line
  finally
    BookPlatePage.Free;
  end;
  end;
end;


procedure TBooksForm.PagePreviewButtonClick(Sender: TObject);
var BookPlate:TBookPlate; BookPlatePage:TBookPlatePage;
begin
   BPPrintForm.PaintBox1.Height:=1000;
   BPPrintForm.PaintBox1.Width:=MulDiv(BPPrintForm.PaintBox1.Height,210,297);
   BPPrintForm.WBitmap.Height:=BPPrintForm.PaintBox1.Height;
   BPPrintForm.WBitmap.Width:=BPPrintForm.PaintBox1.Width;
   BookPlatePage:=TBookPlatePage.Create;     //create page
 try
   BookPlatePage.MaxCols:=2;
   BookPlatePage.MaxRows:=2;
   BookPlatePage.PageHeight:=BPPrintForm.PaintBox1.ClientHeight;
   BookPlatePage.PageWidth:=BPPrintForm.PaintBox1.ClientWidth;
   BPPrintForm.NextPageButton.Visible:=true;
   with BookQuery do
   begin
      DisableControls;
      First;              // error here if no books selected?
      while not EOF do
      begin
        if FieldValues['Print']='X' then
        begin
          if BookPlatePage.Pagefull then
          begin
            BookPlatePage.AssemblePage(BPPrintForm.WBitmap.Canvas);
            BookPlatePage.Clear;
            if not (BPPrintForm.ShowModal=mrOK) then break;
          end;
          BookPlate:=TBookPlate.Create(BookPlatePage.LabelHeight,BookPlatePage.LabelWidth);//create 1 bookplate
          BookPlate.Source:=TBook.Create;
          BookPlate.Fill(BookQuery);
          BookPlatePage.AddBookPlate(BookPlate);
        end;
        Next;
      end;
      EnableControls;
      if BookQuery.eof then PreviewButton.Enabled:=false; //eof=no selected line    ?? always eof??
    end;
    BPPrintForm.NextPageButton.Visible:=false;
    if (BookPlatePage.BookPlates[1,1]<>nil) then     // at least 1 left
    begin
        BookPlatePage.AssemblePage(BPPrintForm.WBitmap.Canvas);
        BookPlatePage.Clear;
        BPPrintForm.ShowModal;
    end;
 finally
   BookPlatePage.Free;
   BPPrintForm.NextPageButton.Visible:=false;
   DoFilter;
 end;
end;

procedure TBooksForm.SaveButtonClick(Sender: TObject);
var MyMessage,Bookcode:string; LineInserted:boolean;
begin
    if BookQuery.NeedToPost then
    begin
      if BookQuery.State=dssInsert then
         LineInserted:=true
      else LineInserted:=false;
      try
        Bookcode:=BookQuery.FieldValues['BOOKCODE'];
        IMSDM.ExplicitPost(BookQuery);
        MyBookmark:=BookQuery.Bookmark;   // which record is bookmarked here?
      except
        on e:exception do
        begin
          if Pos('UNIQUE_BOOKCODE',e.message)>0 then MyMessage:='Duplicate BOOKCODE value'
          else if Pos('UNIQUE_REF',e.message)>0 then MyMessage:='Duplicate REF value'
          else MyMessage:='Save failed with error: '+e.message;
          ShowMessage(MyMessage);
        end;
      end;
      if LineInserted  then
      begin
          BookQuery.Refresh;  //refresh data to get primary key from server
          BookQuery.InvalidateBookmark(MyBookmark);
          BookQuery.Bookmark:=MyBookmark;
          BookQuery.Locate('BOOKCODE',Bookcode,[],1);
          CurrentBook.ReadFromDataset(BookQuery);   //record is last sequential number
      end;
      EditPanel.Visible:=false;
      DataGrid.Enabled:=true;;
    end;
end;

procedure TBooksForm.SearchButtonClick(Sender: TObject);
var i:integer;  TempBookmark,Fieldname,Searchstring, FieldValue:string;
begin
  if (SearchVal.Text<>'') and BookQuery.OrderingField.IsText then
  begin
    if CaseCB.Checked then SearchString:=SearchVal.Text
    else SearchString:=UpperCase(SearchVal.Text);
    with TIB_Query(BookQuery) do
    begin
      TempBookmark:=Bookmark;
      if SearchFromTop.Checked then First
      else if eof then First else Next;
      DisableControls;
      while not eof do
      begin
        if (BookQuery.OrderingField.Value>'') then
        begin
          if CaseCB.Checked then FieldValue:=BookQuery.OrderingField.Value
          else FieldValue:=UpperCase(BookQuery.OrderingField.Value);
          if StringStart.Checked then   //start at beginning of string
          begin
             if (Pos(SearchString,FieldValue)=1) then break  //substring found at start (pos 1)
             else Next;
          end
          else begin  //not string start
            if (Pos(SearchString,FieldValue)>0) then break  //substring found anywhere
             else Next;
          end;
        end
        else Next;
      end;
      with TIB_Query(BookQuery) do
      begin
        if eof then
        begin
            Bookmark:=TempBookmark;
        end
        else CurrentBook.ReadFromDataset(BookQuery);
        EnableControls;
      end;
    end;
  end;
end;

procedure TBooksForm.SelectApplication(BookUseName: ansistring);
var Value:ansistring;
begin
  if BookUseName='Source' then Value:=''    //source means everything
  else Value:=IMSDM.GetBookUseCode(BookUseName);
  BookQuery.Close;
  BookQuery.ParamByName('usedby').value:='%'+Value+'%';
  FilterChanged:=true;
end;

procedure TBooksForm.SelectPrintCategory(Value: string);  // select on PRINT
begin
  BookQuery.Close;
  if (Value = 'All') then
  begin
    BookQuery.ParamByName('print').value:='%';
    BookQuery.ParamByName('usedby').value:='%';
  end
  else BookQuery.ParamByName('print').value:=Value;
  FilterChanged:=true;
end;

procedure TBooksForm.SetXButtonClick(Sender: TObject);
begin
  with BookQuery do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      begin
        Edit;
        FieldValues['Print'] := 'X';
        IMSDM.ExplicitPost(BookQuery);
      end;
      Next;
    end;
    First;
    EnableControls;
  end;

end;

procedure TBooksForm.StopPrinting;
begin
    if Printer.Printing then
    begin
      if MessageDlg('Abort printing?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
        Printer.Abort;
    end;
end;


end.
