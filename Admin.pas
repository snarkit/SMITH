unit Admin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, IB_Access, StdCtrls, ExtCtrls, OrganismConcepts,
  IB_LocateEdit, IB_Process, IB_FTS_Base, IB_FTS_Search, ComCtrls, BookConcepts,
  IB_NavigationBar, IB_Controls, Grids, ExcelXP;

type
  TAdminForm = class(TForm)
    BasicQuery: TIB_Query;
    ResultLabel: TLabel;
    PrefNamePanel: TPanel;
    Label2: TLabel;
    OrgFileName: TEdit;
    Label3: TLabel;
    NameFileName: TEdit;
    PrefNameButton: TButton;
    MergeOrgsPanel: TPanel;
    MergeOrgsButton: TButton;
    SourceOrgName: TEdit;
    Label1: TLabel;
    DestOrgName: TEdit;
    Label4: TLabel;
    SecondQuery: TIB_Query;
    MergeNamesPanel: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    MergeNamesButton: TButton;
    SourceNamesName: TEdit;
    DestNamesName: TEdit;
    MergeRefsPanel: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    MergeRefsButton: TButton;
    SourceRefsName: TEdit;
    DestRefsName: TEdit;
    NameEditPanel: TPanel;
    Label9: TLabel;
    First: TLabel;
    ReplaceButton: TButton;
    FirstString: TEdit;
    TransformNameTable: TEdit;
    Label10: TLabel;
    Edit1: TEdit;
    ReplacementText: TEdit;
    Label11: TLabel;
    SplitJPNamesPanel: TPanel;
    SplitButton: TButton;
    TargetNamesName: TEdit;
    JPUsesPanel: TPanel;
    JPUseButton: TButton;
    JPUsesFileName: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    OpsPageControl: TPageControl;
    BooksTab: TTabSheet;
    NameEditTab: TTabSheet;
    MergeTab: TTabSheet;
    OrgEditTab: TTabSheet;
    RecoverBooksPanel: TPanel;
    SourceConnection: TIB_Connection;
    Label17: TLabel;
    DestConnection: TIB_Connection;
    Label18: TLabel;
    SourceBooksQuery: TIB_Query;
    DestBooksQuery: TIB_Query;
    ResultsMemo: TMemo;
    DestDS: TIB_DataSource;
    SourceDS: TIB_DataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    DestServerName: TEdit;
    DestDBName: TEdit;
    Label14: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    SourceServerName: TEdit;
    SourceDBName: TEdit;
    Label15: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Panel3: TPanel;
    Label16: TLabel;
    LowerLimit: TEdit;
    UpperLimit: TEdit;
    RecoverButton: TButton;
    Panel4: TPanel;
    DestNB: TIB_NavigationBar;
    SourceNB: TIB_NavigationBar;
    DestBookRef: TIB_Text;
    DestBookTitle: TIB_Text;
    SourceBookRef: TIB_Text;
    SourceBookTitle: TIB_Text;
    BookCompareButton: TButton;
    ContinueButton: TButton;
    RestartButton: TButton;
    ExportTab: TTabSheet;
    ExportButton: TButton;
    CheckList: TListBox;
    FirstDate: TEdit;
    SelectButton: TButton;
    procedure PrefNameButtonClick(Sender: TObject);
    procedure MergeNamesButtonClick(Sender: TObject);
    procedure MergeOrgsButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MergeRefsButtonClick(Sender: TObject);
    procedure SplitButtonClick(Sender: TObject);
    procedure JPUseButtonClick(Sender: TObject);
    procedure RecoverButtonClick(Sender: TObject);
    procedure BookCompareButtonClick(Sender: TObject);
    procedure ContinueButtonClick(Sender: TObject);
    procedure RestartButtonClick(Sender: TObject);
    procedure ExportButtonClick(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
  private
    ExcelWorkbook :_workbook;
    ExcelWorksheet :_Worksheet;
    UpdateSQL:TstringList;
    function OpenBookData:boolean;
    procedure GenerateUpdateSQL(ForOrg:boolean;DestTableName:string);
    procedure GenerateInsertSQL(ForOrg:boolean;DestTableName:string);
    { Private declarations }
  public
    { Public declarations }
    Mode:integer;
  end;

var
  AdminForm: TAdminForm;

implementation
uses IMSMain;

{$R *.dfm}


procedure TAdminForm.BookCompareButtonClick(Sender: TObject);
begin
  if OpenBookData then
  begin  //skip blanks at start
    ResultsMemo.Lines.Clear;
    while SourceBooksQuery.FieldByName('REF').IsNull do SourceBooksQuery.Next;
    while DestBooksQuery.FieldByName('REF').IsNull do DestBooksQuery.Next;
    ShowMessage('Align the two tables on the first matching reference using the nav bars then click Continue');
    //stop for user to check alignment
    BookCompareButton.Enabled:=false;
  end;
end;

procedure TAdminForm.ContinueButtonClick(Sender: TObject);
var SBook,DBook:TBook;  i:integer; Diff:string;  match,ended:boolean;
begin
  try
    SBook:=TBook.Create;
    DBook:=TBook.Create;
    i:=0;
    match:=true;
    ended:=false;
    while match do
    begin
      SBook.ReadFromDataset(SourceBooksQuery);
      DBook.ReadFromDataset(DestBooksQuery);
      Diff:= SBook.Compare(DBook);
      if pos('Ref',Diff)>0 then match:=false;
      if pos('bookcode',Diff)>0 then ResultsMemo.Lines.Add(IntTostr(i)+' '+SBook.Ref+'/'+SBook.Title+' '+DBook.Ref+'/'+DBook.Title);
      inc(i);
      if match then
      begin
        SourceBooksQuery.Next;
        if (SourceBooksQuery.EOF) then
        begin
          ShowMessage('End of source table after '+IntTostr(i)+' lines');
          match:=false;
          ended:=true;
        end
        else begin
          DestBooksQuery.Next;
          if (DestBooksQuery.EOF) then
          begin
            ShowMessage('End of dest table  after '+IntTostr(i)+' lines');
            match:=false;
            ended:=true;
          end;
        end;
      end;
    end;
  finally
    SBook.Free;
    DBook.Free;
  end;
end;


procedure TAdminForm.ExportButtonClick(Sender: TObject);
begin
      if not Assigned(IMSHomeForm.ExcelApp) then IMSHomeForm.ExcelApp.Connect;
      ExcelWorkbook:=IMSHomeForm.ExcelApp.Workbooks.Open(edit1.text,false,false,EmptyParam,
                                              EmptyParam,EmptyParam,EmptyParam,
                                              EmptyParam,EmptyParam,EmptyParam,
                                              EmptyParam,EmptyParam,EmptyParam,
                                              EmptyParam,EmptyParam,LOCALE_USER_DEFAULT);
      ExcelWorksheet:=ExcelWorkbook.Worksheets[1] as _worksheet;
end;

procedure TAdminForm.FormActivate(Sender: TObject);
begin
    Case Mode of
    Mergemode:
    begin
      OpsPageControl.ActivePage:=MergeTab;
    end;
    EditMode:
    begin
      OpsPageControl.ActivePage:=NameEditTab;
      PrefNamePanel.Visible:=true;
    end;
    EditNamesMode:
    begin
      OpsPageControl.ActivePage:=OrgEditTab;
    end;
    RescueMode:
    begin
      OpsPageControl.ActivePage:=BooksTab;
    end;
    ExportMode:
    begin
      OpsPageControl.ActivePage:=ExportTab;
    end;
    End;
end;

procedure TAdminForm.GenerateInsertSQL(ForOrg:boolean;DestTableName:string);
begin
    if ForOrg then  //Org
    begin
      BasicQuery.InsertSQL.Clear;
      BasicQuery.InsertSQL.Add('INSERT INTO '+DestTableName);
      BasicQuery.InsertSQL.Add('(ORGCODE, FAMILY, POLNO, DATEMODIFIED, CARD, ');
      BasicQuery.InsertSQL.Add('COMMENTS, USEDBY, PREFERREDNAME)');
      BasicQuery.InsertSQL.Add('Values (:ORGCODE, :FAMILY, :POLNO,:DATEMODIFIED,');
      BasicQuery.InsertSQL.Add(':CARD, :COMMENTS, :USEDBY, :PREFERREDNAME)');
    end
    else begin  //Name
      BasicQuery.InsertSQL.Clear;
      BasicQuery.InsertSQL.Add('INSERT INTO '+DestTableName);
      BasicQuery.InsertSQL.Add('(ORGCODE, NAME, AUTHORITY, LANGUAGE, DATEMODIFIED,');
      BasicQuery.InsertSQL.Add('PREFERRED,COMMENTS)');
      BasicQuery.InsertSQL.Add('Values (:ORGCODE, :NAME, :AUTHORITY, :LANGUAGE,:DATEMODIFIED,');
      BasicQuery.InsertSQL.Add(':PREFERRED, :COMMENTS)');
    end;
end;

procedure TAdminForm.GenerateUpdateSQL(ForOrg:boolean;DestTableName:string);
begin
    if ForOrg then  //Org
    begin
    BasicQuery.EditSQL.Clear;
    BasicQuery.EditSQL.Add('UPDATE '+DestTableName+' o SET');
    BasicQuery.EditSQL.Add('O.ORGCODE = :ORGCODE,');
    BasicQuery.EditSQL.Add('O.FAMILY = :FAMILY,');
    BasicQuery.EditSQL.Add('O.POLNO = :POLNO,');
    BasicQuery.EditSQL.Add('O.DATEMODIFIED = :DATEMODIFIED,');
    BasicQuery.EditSQL.Add('O.CARD = :CARD,');
    BasicQuery.EditSQL.Add('O.COMMENTS = :COMMENTS,');
    BasicQuery.EditSQL.Add('O.USEDBY = :USEDBY,');
    BasicQuery.EditSQL.Add('O.PREFERREDNAME = :PREFERREDNAME');
    BasicQuery.EditSQL.Add('WHERE');
    BasicQuery.EditSQL.Add('ORGID = :OLD_ORGID');
    end
    else begin  //Name
      BasicQuery.EditSQL.Clear;
      BasicQuery.EditSQL.Add('UPDATE '+DestTableName+' n SET');
      BasicQuery.EditSQL.Add('n.ORGCODE = :ORGCODE,');
      BasicQuery.EditSQL.Add('n.FULLNAME = :FULLNAME,');
      BasicQuery.EditSQL.Add('n.AUTHORITY = :AUTHORITY,');
      BasicQuery.EditSQL.Add('n.LANGUAGE = :LANGUAGE,');
      BasicQuery.EditSQL.Add('n.DATEMODIFIED = :DATEMODIFIED,');
      BasicQuery.EditSQL.Add('n.PREFERRED = :PREFERRED,');
      BasicQuery.EditSQL.Add('n.COMMENTS = :COMMENTS');
      BasicQuery.EditSQL.Add('WHERE');
      BasicQuery.EditSQL.Add('NAMEID = :OLD_NAMEID');
    end;
end;


procedure TAdminForm.JPUseButtonClick(Sender: TObject);
var CurrentOrg:TOrganism; i:integer;
begin
  if (JPUsesFileName.Text='') then ShowMessage('Enter table name first')
  else begin
  try
    BasicQuery.SQL.Clear;
    BasicQuery.SQL.Add('SELECT * FROM '+JPUsesFileName.Text+' O ');
    GenerateUpdateSQL(True,JPUsesFileName.Text);
    SecondQuery.SQL.Clear;
    SecondQuery.SQL.Add('SELECT * FROM JPORGS');
    BasicQuery.Open;
    SecondQuery.open;
    CurrentOrg:=TOrganism.Create;
    i:=0;
    while not SecondQuery.eof do
    begin
      if BasicQuery.Locate('ORGCODE',SecondQuery.FieldValues['ORGCODE'],[],0) then
      begin
        CurrentOrg.Clear;
        CurrentOrg.ReadBasicFromDataSet(BasicQuery);
        BasicQuery.Edit;
        if CurrentOrg.AddUse('Japan') then
        begin
          CurrentOrg.WriteBasicToDataSet(BasicQuery);
          inc(i);
        end;
      end
      else begin
        if MessageDlg('Organism '+SecondQuery.FieldValues['ORGCODE']+' not found in '+JPUsesFileName.Text+ ' Continue?',mtWarning,[mbOK,mbAbort],0)= mrAbort then
          Abort;
      end;
      SecondQuery.Next;
    end;
    ResultLabel.Caption:='JP inserted in uses for '+IntToStr(i)+' organisms';
  finally
    CurrentOrg.Free;
  end;
  end;
end;

procedure TAdminForm.MergeNamesButtonClick(Sender: TObject);
var i:integer; copyname:boolean;
begin
  if (OrgFilename.Text='') or (NameFilename.Text='') then ShowMessage('Enter table names first')
  else begin
    BasicQuery.SQL.Clear;
    BasicQuery.SQL.Add('SELECT * FROM '+DestNamesName.Text);
    BasicQuery.SQL.Add('ORDER BY ORGCODE, LANGUAGE, NAME');
    GenerateInsertSQL(False,DestNamesName.Text);
    BasicQuery.KeyLinksAutoDefine:=false;
    BasicQuery.KeyLinks.Clear;
    BasicQuery.KeyLinks.Add(DestNamesName.Text+'.NAMEID');
    BasicQuery.open;
    SecondQuery.SQL.Clear;
    SecondQuery.SQL.Add('SELECT * FROM '+SourceNamesName.Text);
    SecondQuery.SQL.Add('ORDER BY ORGCODE, LANGUAGE, NAME');
    SecondQuery.open;
    i:=0;
    if MessageDlg('Check table names. OK to continue?',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
      while not SecondQuery.Eof do
      begin
        copyname:=false;
        if BasicQuery.FieldValues['ORGCODE']<SecondQuery.FieldValues['ORGCODE'] then BasicQuery.Next
        else
          if BasicQuery.FieldValues['ORGCODE']>SecondQuery.FieldValues['ORGCODE'] then copyname:=true
          else //orgcode =
            if BasicQuery.FieldValues['LANGUAGE']<SecondQuery.FieldValues['LANGUAGE'] then BasicQuery.Next
            else
              if BasicQuery.FieldValues['LANGUAGE']>SecondQuery.FieldValues['LANGUAGE'] then copyname:=true
              else  //language =
                if BasicQuery.FieldValues['FULLNAME']<SecondQuery.FieldValues['FULLNAME'] then BasicQuery.Next
                else
                  if BasicQuery.FieldValues['FULLNAME']>SecondQuery.FieldValues['FULLNAME'] then copyname:=true
                  else begin
                    inc(i);   //duplicate name
                    SecondQuery.Next;
                    BasicQuery.Next
                  end;
        if copyname then
        begin
        //ShowMessage(SecondQuery.FieldValues['ORGCODE']);
          BasicQuery.Insert;  //insert line into dest query from source values
          BasicQuery.FieldValues['ORGCODE'] := SecondQuery.FieldValues['ORGCODE'];
          BasicQuery.FieldValues['FULLNAME'] := SecondQuery.FieldValues['FULLNAME'];
          BasicQuery.FieldValues['AUTHORITY'] := SecondQuery.FieldValues['AUTHORITY'];
          BasicQuery.FieldValues['LANGUAGE'] := SecondQuery.FieldValues['LANGUAGE'];
          BasicQuery.FieldValues['DATEMODIFIED'] := SecondQuery.FieldValues['DATEMODIFIED'];
          BasicQuery.FieldValues['PREFERRED'] := SecondQuery.FieldValues['PREFERRED'];
          BasicQuery.FieldValues['COMMENTS'] := SecondQuery.FieldValues['COMMENTS'];
          BasicQuery.Post;
          SecondQuery.Next;
        end
      end;
  end;
  BasicQuery.Close;
  SecondQuery.Close;
  ResultLabel.Caption:=IntToStr(i)+' duplicate names found and not inserted';
end;

procedure TAdminForm.MergeOrgsButtonClick(Sender: TObject);
var i:integer;
begin
  if (OrgFilename.Text='') or (NameFilename.Text='') then ShowMessage('Enter table names first')
  else begin
    BasicQuery.SQL.Clear;
    BasicQuery.SQL.Add('SELECT * FROM '+DestOrgName.Text);
    BasicQuery.SQL.Add('ORDER BY ORGCODE');
    BasicQuery.KeyLinksAutoDefine:=false;
    BasicQuery.KeyLinks.Clear;
    BasicQuery.KeyLinks.Add(DestOrgName.Text+'.ORGID');
    GenerateInsertSQL(True,DestOrgName.Text); //for org
    BasicQuery.open;
    SecondQuery.SQL.Clear;
    SecondQuery.SQL.Add('SELECT * FROM '+SourceOrgName.Text);
    SecondQuery.SQL.Add('ORDER BY ORGCODE');
    SecondQuery.open;
    i:=0;
    if MessageDlg('Check tablenames. OK to continue?',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
      while not SecondQuery.Eof do
        if BasicQuery.FieldValues['ORGCODE']>SecondQuery.FieldValues['ORGCODE'] then
        begin
          BasicQuery.Insert;  //insert line into dest query from source values
          BasicQuery.FieldValues['ORGCODE'] := SecondQuery.FieldValues['ORGCODE'];
          BasicQuery.FieldValues['FAMILY'] := SecondQuery.FieldValues['FAMILY'];
          BasicQuery.FieldValues['POLNO'] := SecondQuery.FieldValues['POLNO'];
          BasicQuery.FieldValues['DATEMODIFIED'] := SecondQuery.FieldValues['DATEMODIFIED'];
          BasicQuery.FieldValues['CARD'] := SecondQuery.FieldValues['CARD'];
          BasicQuery.FieldValues['COMMENTS'] := SecondQuery.FieldValues['COMMENTS'];
          if SecondQuery.FieldByName('USEDBY').isnull then
               BasicQuery.FieldValues['USEDBY'] := '  '
          else BasicQuery.FieldValues['USEDBY'] := SecondQuery.FieldValues['USEDBY'];
          BasicQuery.FieldValues['PREFERREDNAME'] := SecondQuery.FieldValues['PREFERREDNAME'];
          BasicQuery.Post;
          SecondQuery.Next;
        end
        else
          if BasicQuery.FieldValues['ORGCODE']<SecondQuery.FieldValues['ORGCODE'] then BasicQuery.Next
          else begin
            inc(i);   //duplicate
            SecondQuery.Next;
            BasicQuery.Next
          end;
  end;
  BasicQuery.Close;
  SecondQuery.Close;
  ResultLabel.Caption:=IntToStr(i)+' duplicate codes found and not inserted';
end;

procedure TAdminForm.MergeRefsButtonClick(Sender: TObject);
var i:integer; copyref:boolean;
begin
  if (OrgFilename.Text='') or (NameFilename.Text='') then ShowMessage('Enter table names first')
  else begin
    BasicQuery.SQL.Clear;
    BasicQuery.SQL.Add('SELECT * FROM '+DestRefsName.Text);
    BasicQuery.SQL.Add('ORDER BY ORGCODE, BOOKCODE, PAGENO');
    BasicQuery.InsertSQL.Clear;
    BasicQuery.InsertSQL.Add('INSERT INTO '+DestRefsName.Text);
    BasicQuery.InsertSQL.Add('(ORGCODE, BOOKCODE, PAGENO, REFCODE, VOLUME, DATEMODIFIED, NOTES)');
    BasicQuery.InsertSQL.Add('Values (:ORGCODE, :BOOKCODE, :PAGENO, :REFCODE, :VOLUME, :DATEMODIFIED,:NOTES)');
    BasicQuery.KeyLinksAutoDefine:=false;
    BasicQuery.KeyLinks.Clear;
    BasicQuery.KeyLinks.Add(DestRefsName.Text+'.REFID');
    BasicQuery.open;
    SecondQuery.SQL.Clear;
    SecondQuery.SQL.Add('SELECT * FROM '+SourceRefsName.Text);
    SecondQuery.SQL.Add('ORDER BY ORGCODE, PAGENO, PAGENO');
    SecondQuery.open;
    i:=0;
    if MessageDlg('Check table names. OK to continue?',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
      while not SecondQuery.Eof do
      begin
        copyref:=false;
        if BasicQuery.FieldValues['ORGCODE']<SecondQuery.FieldValues['ORGCODE'] then BasicQuery.Next
        else
          if BasicQuery.FieldValues['ORGCODE']>SecondQuery.FieldValues['ORGCODE'] then copyref:=true
          else //orgcode =
            if BasicQuery.FieldValues['BOOKCODE']<SecondQuery.FieldValues['BOOKCODE'] then BasicQuery.Next
            else
              if BasicQuery.FieldValues['BOOKCODE']>SecondQuery.FieldValues['BOOKCODE'] then copyref:=true
              else  //language =
                if BasicQuery.FieldValues['PAGENO']<SecondQuery.FieldValues['PAGENO'] then BasicQuery.Next
                else
                  if BasicQuery.FieldValues['PAGENO']>SecondQuery.FieldValues['PAGENO'] then copyref:=true
                  else begin
                    inc(i);   //duplicate name
                    SecondQuery.Next;
                    BasicQuery.Next
                  end;
        if copyref then
        begin
        //ShowMessage(SecondQuery.FieldValues['ORGCODE']);
          BasicQuery.Insert;  //insert line into dest query from source values
          BasicQuery.FieldValues['ORGCODE'] := SecondQuery.FieldValues['ORGCODE'];
          BasicQuery.FieldValues['BOOKCODE'] := SecondQuery.FieldValues['BOOKCODE'];
          BasicQuery.FieldValues['PAGENO'] := SecondQuery.FieldValues['PAGENO'];
          BasicQuery.FieldValues['REFCODE'] := SecondQuery.FieldValues['REFCODE'];
          if SecondQuery.FieldByName('VOLUME').isnull then
               BasicQuery.FieldValues['VOLUME'] := '  '
          else BasicQuery.FieldValues['VOLUME'] := SecondQuery.FieldValues['VOLUME'];
          BasicQuery.FieldValues['DATEMODIFIED'] := SecondQuery.FieldValues['DATEMODIFIED'];
          BasicQuery.FieldValues['NOTES'] := SecondQuery.FieldValues['NOTES'];
          BasicQuery.Post;
          SecondQuery.Next;
        end
      end;
  end;
  BasicQuery.Close;
  SecondQuery.Close;
  ResultLabel.Caption:=IntToStr(i)+' duplicate refs found and not inserted';
end;

function TAdminForm.OpenBookData:boolean;
begin
  if (DestDBName.Text='') or (SourceDBName.Text='') then ShowMessage('Enter database names first')
  else
  try
    DestConnection.Connected:=false;
    DestConnection.Server:=DestServerName.Text;
    DestConnection.Path:=DestDBName.Text;
    SourceConnection.Connected:=false;
    SourceConnection.Server:=SourceServerName.Text;
    SourceConnection.Path:=SourceDBName.Text;
    DestConnection.Connected:=true;
    SourceConnection.Connected:=true;
      DestBooksQuery.SQL.Clear;
      DestBooksQuery.SQL.Add('SELECT * FROM BOOKS');
      DestBooksQuery.SQL.Add('ORDER BY REF');
      DestBooksQuery.KeyLinksAutoDefine:=false;
      DestBooksQuery.KeyLinks.Clear;
      DestBooksQuery.KeyLinks.Add('BOOKS.BOOKID');
      DestBooksQuery.EditSQL.Clear;
      DestBooksQuery.EditSQL.Add('UPDATE BOOKS BOOKS SET');
      DestBooksQuery.EditSQL.Add('   BOOKS.BOOKCODE = :BOOKCODE,');
      DestBooksQuery.EditSQL.Add('   BOOKS.TITLE = :TITLE,');
      DestBooksQuery.EditSQL.Add('   BOOKS.AUTHOR = :AUTHOR,');
      DestBooksQuery.EditSQL.Add('BOOKS.NOTES = :NOTES,');
      DestBooksQuery.EditSQL.Add('BOOKS.ORIGTITLE = :ORIGTITLE,');
      DestBooksQuery.EditSQL.Add('BOOKS.VOLUME = :VOLUME,');
      DestBooksQuery.EditSQL.Add('BOOKS.EDITION = :EDITION,');
      DestBooksQuery.EditSQL.Add('BOOKS.PUBLISHER = :PUBLISHER,');
      DestBooksQuery.EditSQL.Add('BOOKS.PLACE = :PLACE,');
      DestBooksQuery.EditSQL.Add('BOOKS.YEAR_PUBL = :YEAR_PUBL,');
      DestBooksQuery.EditSQL.Add('BOOKS.OPUBLISHER = :OPUBLISHER,');
      DestBooksQuery.EditSQL.Add('BOOKS.OPLACE = :OPLACE,');
      DestBooksQuery.EditSQL.Add('BOOKS.OYEAR = :OYEAR,');
      DestBooksQuery.EditSQL.Add('BOOKS.DATE_ACQ = :DATE_ACQ,');
      DestBooksQuery.EditSQL.Add('BOOKS.PRICE = :PRICE,');
      DestBooksQuery.EditSQL.Add('BOOKS."REF" = :"REF",');
      DestBooksQuery.EditSQL.Add('BOOKS.SUBJECT = :SUBJECT,');
      DestBooksQuery.EditSQL.Add('BOOKS.ISBN = :ISBN,');
      DestBooksQuery.EditSQL.Add('BOOKS.NUMBERPAGES = :NUMBERPAGES,');
      DestBooksQuery.EditSQL.Add('BOOKS.USEDBY = :USEDBY,');
      DestBooksQuery.EditSQL.Add('BOOKS.PRINT = :PRINT,');
      DestBooksQuery.EditSQL.Add('BOOKS.MARKER = :MARKER,');
      DestBooksQuery.EditSQL.Add('BOOKS.SHORTCODE = :SHORTCODE');
      DestBooksQuery.EditSQL.Add('WHERE');
      DestBooksQuery.EditSQL.Add('BOOKID = :OLD_BOOKID');
      DestBooksQuery.InsertSQL.Clear;
      DestBooksQuery.InsertSQL.Add('INSERT INTO BOOKS(BOOKCODE,SHORTCODE,TITLE,AUTHOR,NOTES,ORIGTITLE,');
      DestBooksQuery.InsertSQL.Add('VOLUME, EDITION, PUBLISHER, PLACE, YEAR_PUBL, OPUBLISHER,OPLACE,');
      DestBooksQuery.InsertSQL.Add('OYEAR, DATE_ACQ, PRICE, REF, SUBJECT, ISBN, NUMBERPAGES, PRINT,');
      DestBooksQuery.InsertSQL.Add('MARKER, USEDBY)');
      DestBooksQuery.InsertSQL.Add('VALUES (:BOOKCODE, :SHORTCODE, :TITLE, :AUTHOR, :NOTES, :ORIGTITLE,');
      DestBooksQuery.InsertSQL.Add(':VOLUME, :EDITION, :PUBLISHER, :PLACE, :YEAR_PUBL, :OPUBLISHER, :OPLACE,');
      DestBooksQuery.InsertSQL.Add(':OYEAR, :DATE_ACQ, :PRICE, :REF, :SUBJECT, :ISBN, :NUMBERPAGES, :PRINT,');
      DestBooksQuery.InsertSQL.Add(':MARKER, :USEDBY)');
      DestBooksQuery.open;
      SourceBooksQuery.SQL.Clear;
      SourceBooksQuery.SQL.Add('SELECT * FROM bOOKS');
      SourceBooksQuery.SQL.Add('ORDER BY REF');
      SourceBooksQuery.KeyLinksAutoDefine:=false;
      SourceBooksQuery.KeyLinks.Clear;
      SourceBooksQuery.KeyLinks.Add('BOOKS.BOOKID');
      SourceBooksQuery.open;
      result:=true;
  except on exception do
    begin
      if not DestConnection.Connected then ShowMessage('cannot connect to '+DestDBName.Text)
      else if not SourceConnection.Connected then ShowMessage('cannot connect to '+SourceDBName.Text);
      result:=false;
    end;
  end;
end;

procedure TAdminForm.PrefNameButtonClick(Sender: TObject);
var i:integer;
begin
  if (OrgFilename.Text='') or (NameFilename.Text='') then ShowMessage('Enter table names first')
  else begin
    BasicQuery.SQL.Clear;
    BasicQuery.SQL.Add('SELECT * FROM '+OrgFilename.Text+' o');
    BasicQuery.SQL.Add('JOIN '+NameFilename.Text+' n');
    BasicQuery.SQL.Add('on o.orgcode = n.orgcode');
    BasicQuery.SQL.Add('where (n.preferred<>0)');
    BasicQuery.SQL.Add('and (o.preferredname is null)');
    GenerateUpdateSQL(True,OrgFilename.Text);
    BasicQuery.open;
    i:=0;

    while not BasicQuery.Eof do
    begin
      BasicQuery.Edit;
      BasicQuery.FieldValues['PreferredName']:=BasicQuery.FieldValues['FULLNAME'];
      BasicQuery.Post;
      inc(i);
      BasicQuery.Next;
    end;
  end;
  BasicQuery.Close;
  ResultLabel.Caption:=IntToStr(i)+' names inserted';
end;

procedure TAdminForm.RecoverButtonClick(Sender: TObject);
var  ABook:TBook;
begin
  if OpenBookData then
    if (LowerLimit.Text=' ') or (upperLimit.Text=' ') or (LowerLimit.Text=' ')>(UpperLimit.Text=' ') then
      ShowMessage('Invalid limits')
    else begin
      if MessageDlg('Confirm tansfer of refs '+LowerLimit.Text+' to '+UpperLimit.Text+' OK?',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
      begin
        while not SourceBooksQuery.Eof and (SourceBooksQuery.FieldValues['REF']<Lowerlimit.Text) do SourceBooksQuery.Next;
        if SourceBooksQuery.eof then ShowMessage('Source does not contain refs of '+Lowerlimit.Text+' or over')
        else
        try
          ABook:=TBook.Create;
          while not SourceBooksQuery.Eof and (SourceBooksQuery.FieldValues['REF']<=Upperlimit.Text) do
          begin
            DestBooksQuery.Insert;  //insert line into dest query from source values
            ABook.ReadFromDataset(SourceBooksQuery);
            ABook.WriteToDataset(DestBooksQuery);
            SourceBooksQuery.Next;
          end;
          if (SourceBooksQuery.FieldValues['REF']<Upperlimit.Text) then ShowMessage('End of table met before upper limit reached');
        finally
          ABook.Free;
        end;
      end;
    end;
  DestBooksQuery.Close;
  SourceBooksQuery.Close;
  ResultLabel.Caption:='Missing books inserted';
end;

procedure TAdminForm.RestartButtonClick(Sender: TObject);
begin
    BookCompareButton.Enabled:=true;
end;

procedure TAdminForm.SelectButtonClick(Sender: TObject);
begin
      BasicQuery.SQL.Clear;
      BasicQuery.SQL.Add('SELECT * FROM '+IMSHomeForm.AdminOrgTableName);
      BasicQuery.Open;
      while not BasicQuery.eof do
        if (BasicQuery.FieldValues['DATEMODIFIED']>StrToDate(FirstDate.Text))
        and (BasicQuery.FieldValues['EPPTSTATUS'][1]<>'X') then
         CheckList.AddItem('  '+BasicQuery.FieldValues['orgcode']+' '+BasicQuery.FieldValues['PREFERREDNAME'],nil);
end;

procedure TAdminForm.SplitButtonClick(Sender: TObject);
var AName:TOrgName; j,k:integer; MyBookmark, oldname:string;
begin
  BasicQuery.SQL.Clear;
  BasicQuery.SQL.Add('Select * from '+TargetNamesName.Text+' N1 ');
  BasicQuery.SQL.Add('where (N1.language='+quotedstr('ja')+')');
  GenerateInsertSQL(False,TargetNamesName.Text);
  GenerateUpdateSQL(False,TargetNamesName.Text);
  BasicQuery.Open;
  AName:=TOrgName.Create;
  while not BasicQuery.eof do
  begin
      MyBookmark:=BasicQuery.Bookmark;
      AName.ReadFromDataset(BasicQuery);
      j:=pos('[',AName.Fullname);
      k:=pos(']',AName.Fullname);
      if (j=0) or (k=0) then
      begin
        if j<>k then    //if = already processed
        begin
          ShowMessage('unmatched brackets in '+AName.Orgcode); //error
          Abort;
        end;
      end
      else begin //split
        oldname:=AName.Fullname;
        AName.Fullname:=copy(oldname,1,j-1);//romaji name
        AName.WriteToDataset(BasicQuery);
        BasicQuery.Insert;
        AName.Fullname:=copy(oldname,j+1,k-j-1);//katakana
        AName.WriteToDataset(BasicQuery);
        BasicQuery.Bookmark:=MyBookmark;
      end;
      BasicQuery.next;
  end;
  ResultLabel.Caption:=IntToStr(BasicQuery.RecordCount)+' names changed';
  AName.Free;
  BasicQuery.Close;
end;

end.
