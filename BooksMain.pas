unit BooksMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Grids, DBGrids, Printers,
  ExtCtrls, DBCtrls, IB_Grid, IB_Components, IB_Access,IMSData,
  IB_NavigationBar, BookConcepts;

type
  TBooksForm = class(TForm)
    DataGrid: TIB_Grid;
    IB_DSQL1: TIB_DSQL;
    EditUsePanel: TPanel;
    AcceptUseButton: TButton;
    TopPanel: TPanel;
    BookplatePanel: TPanel;
    Label4: TLabel;
    PreviewButton: TButton;
    PagePreviewButton: TButton;
    PrintButton: TButton;
    ClearXButton: TButton;
    PrintFilterRG: TRadioGroup;
    SearchPanel: TPanel;
    SearchVal: TEdit;
    SearchButton: TButton;
    StringStart: TCheckBox;
    SearchfromTop: TCheckBox;
    AcceptButton: TButton;
    CloseButton: TButton;
    LeftPanel: TPanel;
    FilterPanel: TPanel;
    Label2: TLabel;
    NbRecords: TLabel;
    Label1: TLabel;
    UseFilterRG: TRadioGroup;
    EditPanel: TPanel;
    Label3: TLabel;
    IB_NavigationBar1: TIB_NavigationBar;
    DuplicateButton: TButton;
    InsertButton: TButton;
    DeleteButton: TButton;
    CancelButton: TButton;
    EditButton: TButton;
    SaveButton: TButton;
    SetXButton: TButton;
    Label5: TLabel;
    Label6: TLabel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog: TPrintDialog;
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
    procedure AcceptButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DataGridCellClick(Sender: TObject; ACol, ARow: Integer;
      AButton: TMouseButton; AShift: TShiftState);
    procedure DataGridEditButtonClick(Sender: TObject);
    procedure SetXButtonClick(Sender: TObject);
  private
    FilterChanged:boolean;
    procedure DoFilter;
    procedure SelectApplication(BookUse: TBookUse);
    procedure SelectPrintCategory(Value: string);
    procedure StopPrinting;
    procedure DataGridEditUse;

  public
    CurrentBook:TBook;
    PickedBook:TBook;
    NewUse:TBookUse;
    Modal:boolean;
  end;

var
  BooksForm: TBooksForm; code:string;


implementation

uses BPPrint;
{$R *.dfm}


procedure TBooksForm.AcceptButtonClick(Sender: TObject);
//available when form is called modally
begin
    if not CurrentBook.IsEmpty and not (PickedBook=nil) then
    begin
        PickedBook.CopyFrom(currentBook);
        PickedBook.AddUse(NewUse);
        try
        PickedBook.WriteToDisk(Datagrid.Datasource.Dataset as TIB_Query);
        SaveButton.Click;
        ModalResult:=mrOK;
        except
           on e:exception do ShowMessage('Error '+e.message);
        end;
    end;
end;

procedure TBooksForm.AcceptUseButtonClick(Sender: TObject);
var i:integer; ACheckBox:TCheckBox; BookUse:TBookUse;
begin
   for i := 0 to EditUsePanel.ComponentCount - 1 do
      if (EditUsePanel.Components[i] is TCheckBox) then
      begin
        ACheckBox:=EditUsePanel.Components[i] as TCheckBox;
        if AcheckBox.Checked then
          for BookUse := Low(TBookUse) to High(TBookUse) do
            if Ord(BookUse)=ACheckBox.Tag then CurrentBook.AddUse(BookUse);
      end;
   try
      IMSDM.CanPostMarked:=true;
      CurrentBook.WriteToDisk(Datagrid.Datasource.Dataset as TIB_Query);
   except
     on e:exception do ShowMessage('Error '+e.message);
   end;
   EditUsePanel.Visible:=false;
end;

procedure TBooksForm.CancelButtonClick(Sender: TObject);
begin
   if Datagrid.Datasource.Dataset.NeedToPost then Datagrid.Datasource.Dataset.Cancel;
end;

procedure TBooksForm.ClearXButtonClick(Sender: TObject);
begin
  with Datagrid.Datasource.Dataset do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldValues['Print'] = 'X' then
      begin
        Edit;
        FieldValues['Print'] := ' ';
        IMSDM.CanPostMarked:=true;
        Post;
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
  with Datagrid.Datasource.Dataset do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldValues['Print'] = 'P' then
      begin
        Edit;
        FieldValues['Print'] := 'X';
        IMSDM.CanPostMarked:=true;
        Post;
        Next;
      end;
    end;
    First;
    EnableControls;
  end;

end;

procedure TBooksForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;

procedure TBooksForm.DataGridTitleClick(Sender: TObject; ACol, ARow: Integer;
  AButton: TMouseButton; AShift: TShiftState);
begin
  TIB_Query(Datagrid.Datasource.Dataset).Locate('BOOKCODE',code,[]);
  DataGrid.Col:=ACol;
end;

procedure TBooksForm.DataGridCellClick(Sender: TObject; ACol, ARow: Integer;
  AButton: TMouseButton; AShift: TShiftState);
begin
    if DataGrid.DataSource.Dataset.State=dssBrowse then  //first entry to new row
        CurrentBook.ReadFromDisk(Datagrid.Datasource.Dataset);
end;

procedure TBooksForm.DataGridDblClick(Sender: TObject);
begin
  if DataGrid.SelectedField.FieldName='PRINT' then  // click in Print column - toggle print status
   begin
    Datagrid.Datasource.Dataset.Edit;
    if (Datagrid.Datasource.Dataset.FieldByName('Print').IsNull) or (Datagrid.Datasource.Dataset.FieldValues['Print']='')
      or (Datagrid.Datasource.Dataset.FieldValues['Print']=' ') then       //blank to X
      Datagrid.Datasource.Dataset.FieldByName('Print').Value := 'X'
    else
    if Datagrid.Datasource.Dataset.FieldValues['Print'] = 'X' then       //X to Z
      Datagrid.Datasource.Dataset.FieldValues['Print'] := 'Z'
    else
    if Datagrid.Datasource.Dataset.FieldValues['Print'] = 'Z' then       //Z to blank
      Datagrid.Datasource.Dataset.FieldValues['Print'] := ' '
    else
    if Datagrid.Datasource.Dataset.FieldValues['Print'] = 'P' then       //P to blank (error)
      Datagrid.Datasource.Dataset.FieldValues['Print'] := ' ';
    IMSDM.CanPostMarked:=true;
    Datagrid.Datasource.Dataset.Post;
   end;
   CurrentBook.ReadFromDisk(Datagrid.Datasource.Dataset);    //get details of selected book
end;


procedure TBooksForm.DataGridEditButtonClick(Sender: TObject);
begin
  if DataGrid.SelectedField.FieldName='USEDBY' then  // click in USE column to open USE editor
         DataGridEditUse;

end;

procedure TBooksForm.DataGridEditUse;
var i:integer; ACheckBox:TCheckBox; BookUse:TBookUse;
begin
   EditUsePanel.Visible:=true;
   for i := 0 to EditUsePanel.ComponentCount - 1 do
      if (EditUsePanel.Components[i] is TCheckBox) then
      begin
          ACheckBox:=EditUsePanel.Components[i] as TCheckBox;
          ACheckBox.Checked:=false;   //uncheck checkbox
          for BookUse:=Low(TBookUse) to High(TBookUse) do
            if (BookUse in CurrentBook.UsedBy) and (ACheckBox.Tag=Ord(BookUse)) then
                AcheckBox.Checked:=true;
      end;
end;

procedure TBooksForm.DeleteButtonClick(Sender: TObject);
var code:string;
begin
  if Datagrid.Datasource.Dataset.FieldByName('BOOKCODE').IsNotNull then code:=Datagrid.Datasource.Dataset.FieldValues['BOOKCODE']
  else code:='this record';
  if MessageDlg('Confirm deletion of '+code+'?', mtConfirmation,[mbOK,mbCancel],0)=mrOK then
  begin
     IMSDM.CanpostMarked:=true;
     Datagrid.Datasource.Dataset.Delete;
  end;
end;

procedure TBooksForm.DoFilter;
begin  if FilterChanged then
  begin
    Datagrid.Datasource.Dataset.Close;
    Datagrid.Datasource.Dataset.Open;          //reopen data to apply new filter
    Datagrid.Datasource.Dataset.Last;
    NbRecords.Caption := IntToStr(Datagrid.Datasource.Dataset.RecordCount);
    Datagrid.Datasource.Dataset.First;
  end;
  FilterChanged:=false;
end;

procedure TBooksForm.DuplicateButtonClick(Sender: TObject);
var
  i: integer;
  SavedValues: array of variant;
begin
  Datagrid.Datasource.Dataset.OrderingItemNo:=7;         //title order
  with Datagrid.Datasource.Dataset do
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
  end;
end;

procedure TBooksForm.EditButtonClick(Sender: TObject);
begin
    if DataGrid.DataSource.Dataset.State=dssBrowse then DataGrid.DataSource.Dataset.Edit;
end;

procedure TBooksForm.FilterRGClick(Sender: TObject);
var BookUse:TBookUse;
begin
    if Sender=PrintFilterRG then UseFilterRG.ItemIndex:=-1  //reset typefilter
    else PrintFilterRG.ItemIndex:=-1;   //reset printing filter

    if  PrintFilterRG.ItemIndex = 0 then SelectPrintCategory('X')   //for printing
    else if PrintFilterRG.ItemIndex = 1 then SelectPrintCategory('P')   //printed in last batch
    else if PrintFilterRG.ItemIndex = 2 then SelectPrintCategory('Z')   //finished
    else if UseFilterRG.ItemIndex >0 then
      for BookUse:=Low(TBookUse) to High(TBookUse) do
      begin
        if Ord(BookUse)=UseFilterRG.ItemIndex then SelectApplication(BookUse);  //particular use
      end
    else SelectPrintCategory('All');                    //all books and other sources
  DoFilter;
end;

procedure TBooksForm.FormActivate(Sender: TObject);
var fieldname:string; i:integer;
begin
 try
  if IMSDM.FBConnection.ConnectionStatus = csDisconnected then IMSDM.FBConnection.Connected:=true;
 finally
  if IMSDM.FBConnection.ConnectionStatus = csDisconnected then
      ShowMessage('Cannot open database. Check Firebird alias "IMSDB" exists in alias.conf');
 end;
  if Datagrid.Datasource.Dataset.Active=false then     //first entry
  begin
      CurrentBook:=TBook.Create;
      SelectApplication(Book);           // handles only books by default, not other sources
      Datagrid.Datasource.Dataset.OrderingItemNo:=7;  //title order
      FilterChanged:=true;
  end;
  DoFilter;
  fieldname:=Datagrid.Datasource.Dataset.OrderingItems.Names[Datagrid.Datasource.Dataset.OrderingItemNo-1];
  for i:= 0 to DataGrid.GridFieldCount-1 do
   begin
     if DataGrid.GridFields[i].FieldName = fieldName then
     begin
       DataGrid.Col:=i+1;
       Break;
     end;
   end;
end;

procedure TBooksForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if Datagrid.Datasource.Dataset.NeedToPost then
    if MessageDlg('Save changes to current record?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      SaveButton.Click;
    end
    else Datagrid.Datasource.Dataset.Cancel;
    Datagrid.Datasource.Dataset.Close;
    CurrentBook.Free;
end;

procedure TBooksForm.FormCreate(Sender: TObject);
var i,maxwidth,capwidth:integer;
begin
   //Display a check box for each possible use
  begin
    EditUsePanel.Height:=100+BookUseNbValues*25;
    maxwidth:=0;
    for i := 1 to BookUseNbValues do
      with TCheckBox.Create(EditUsePanel) do
      begin
        Parent:=EditUsePanel;
        top:=10+i*25;
        left:=20;
        ClientWidth:=Canvas.TextWidth(BookUseHeadings[i])+100;
        if ClientWidth>maxwidth then maxwidth:=ClientWidth;
        Caption:=BookUseHeadings[i];
        Tag:=i;
      end;
    AcceptUseButton.Top:=EditUsePanel.Height-50;
    EditUsePanel.Width:=maxwidth;
    AcceptUseButton.Left:=(EditUsePanel.Width-AcceptUseButton.Width) div 2;
    //Insert search by use radio buttons
    for i := 0 to BookUseNbValues do
      UseFilterRG.Items.Add(BookUseHeadings[i]+' ('+BookUseLetters[i]+')');
  end;
end;

procedure TBooksForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    StopPrinting;
end;

procedure TBooksForm.InsertButtonClick(Sender: TObject);
var refno:integer;
begin
  Datagrid.Datasource.Dataset.OrderingItemNo:=6;         //ref order
  TIB_Query(Datagrid.Datasource.Dataset).Locate('REF','1',[lopPartialKey]);
  Datagrid.Datasource.Dataset.Prior;                     //last numeric (works for next 500)
  refno:=Datagrid.Datasource.Dataset.FieldByName('REF').AsInteger;
  Datagrid.Datasource.Dataset.OrderingItemNo:=3;         //date order
  Datagrid.Datasource.Dataset.Append;
  Datagrid.Datasource.Dataset.FieldValues['Bookcode']:='Unique bookcode here';
  Datagrid.Datasource.Dataset.FieldValues['Title']:='Title of source here';
  Datagrid.Datasource.Dataset.FieldValues['USEDBY']:='B';
  Datagrid.Datasource.Dataset.FieldValues['MARKER']:='S';
  if refno>0 then Datagrid.Datasource.Dataset.FieldValues['REF']:='0'+IntToStr(refno+1);
end;

procedure TBooksForm.MarkAllButtonClick(Sender: TObject);
begin
  with Datagrid.Datasource.Dataset do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
        Edit;
        FieldValues['PRINT'] := 'X';
        IMSDM.CanPostMarked:=true;
        Post;
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
      BookPlate.Fill(Datagrid.Datasource.Dataset);
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
    with Datagrid.Datasource.Dataset do
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
          BookPlate.Fill(Datagrid.Datasource.Dataset);
          BookPlatePage.AddBookPlate(BookPlate);
          inc(NbPrinted);
          Edit;
          FieldValues['Print']:='P';
          IMSDM.CanPostMarked:=true;
          Post;
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
    with Datagrid.Datasource.Dataset do
    begin
      First;
      while not EOF do
      begin
        if FieldValues['Print']='P' then
        begin
          Edit;
          FieldValues['Print']:='Z';
          IMSDM.CanPostMarked:=true;
          Post;
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
   with Datagrid.Datasource.Dataset do
   begin
      DisableControls;
      First;
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
          BookPlate.Fill(Datagrid.Datasource.Dataset);
          BookPlatePage.AddBookPlate(BookPlate);
        end;
        Next;
      end;
      EnableControls;
      if Datagrid.Datasource.Dataset.eof then PreviewButton.Enabled:=false; //eof=no selected line
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
var MyMessage:string; LineInserted:boolean;
begin
    if Datagrid.Datasource.Dataset.NeedToPost then
    begin
      if Datagrid.Datasource.Dataset.State=dssInsert then
         LineInserted:=true
      else LineInserted:=false;
      IMSDM.CanPostMarked:=true;
      try
        Datagrid.Datasource.Dataset.Post;
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
          Datagrid.Datasource.Dataset.Refresh;  //refresh data
    end;
end;

procedure TBooksForm.SearchButtonClick(Sender: TObject);
var TargetPos:integer;
begin
  if (SearchVal.Text<>'') and DataGrid.SelectedField.IsText then
  begin
    with TIB_Query(Datagrid.Datasource.Dataset) do
    begin
      if SearchFromTop.Checked then First else Next;
      DisableControls;
      if StringStart.Checked then   //start at beginning of string
      begin
          while not eof do
          begin
            if (DataGrid.SelectedField.Value>'') and     //substring found at start (pos 1)
               (Pos(SearchVal.Text,DataGrid.SelectedField.Value)=1) then break
            else Next;
          end;
          if eof then Locate('BOOKCODE',currentBook.bookcode,[])   //not found
          else CurrentBook.ReadFromDisk(Datagrid.Datasource.Dataset);
      end
      else
      begin
          while not eof do
          begin
            if (DataGrid.SelectedField.Value>'') and     //substring found
                 (Pos(SearchVal.Text,DataGrid.SelectedField.Value)>0) then break
            else Next;
          end;
          if eof then Locate('BOOKCODE',currentBook.bookcode,[])   //not found
          else CurrentBook.ReadFromDisk(Datagrid.Datasource.Dataset);
      end;
      EnableControls;
    end;
  end;
end;

procedure TBooksForm.SelectApplication(BookUse: TBookUse);
var Value:string; AUse:TBookUse;
begin
  for AUse := Low(TBookUse) to High(BookUse) do
     if BookUse=AUse then Value:=BookUseLetters[Ord(AUse)];

  IB_DSQL1.SQL.Clear;
  IB_DSQL1.SQL.Add('UPDATE BOOKS SET MARKER = '+QuotedStr('U'));  // clear current selection
  IB_DSQL1.Execute;
  IB_DSQL1.SQL.Clear;
  IB_DSQL1.SQL.Add('UPDATE BOOKS SET MARKER = '+QuotedStr('S')+' WHERE USEDBY LIKE '+QuotedStr('%'+Value+'%'));
  IB_DSQL1.Execute;
  FilterChanged:=true;
end;

procedure TBooksForm.SelectPrintCategory(Value: string);  // select on PRINT
begin
  IB_DSQL1.SQL.Clear;
  IB_DSQL1.SQL.Add('UPDATE BOOKS SET MARKER = '+QuotedStr('U'));  // clear current selection
  IB_DSQL1.Execute;
  IB_DSQL1.SQL.Clear;
  IB_DSQL1.SQL.Add('UPDATE BOOKS SET MARKER = '+QuotedStr('S'));  // set SelMarker
  if (Value <> 'All') then
      IB_DSQL1.SQL.Add(' WHERE PRINT = '+QuotedStr(Value));
  IB_DSQL1.Execute;
  FilterChanged:=true;
end;

procedure TBooksForm.SetXButtonClick(Sender: TObject);
begin
  with Datagrid.Datasource.Dataset do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      begin
        Edit;
        FieldValues['Print'] := 'X';
        IMSDM.CanPostMarked:=true;
        Post;
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
