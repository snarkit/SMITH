unit JPEMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FMTBcd, WideStrings, DB, OrganismConcepts, ActnList,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, ImgList,
  Mask, DBCtrls, Spin, ComCtrls, ueppt, BookConcepts, IB_Access, IMSData, Books,
  IB_Controls, IB_Components, Grids, IB_Grid, IB_EditButton, StrUtils;

type
  TJPEditorForm = class(TForm)
    RefPanel: TPanel;
    RefListView: TListView;
    BookPanel: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    FamilyPanel: TPanel;
    FamilyMembers: TListView;
    BookDataSource: TIB_DataSource;
    ShowTitle: TIB_Edit;
    ShowBookAuthor: TIB_Edit;
    ShowBookCode: TIB_Edit;
    ShowBookNotes: TIB_Memo;
    ShowBookPages: TIB_Edit;
    Label7: TLabel;
    DispCount: TLabel;
    BookList: TComboBox;
    BookCount: TLabel;
    Label9: TLabel;
    Prefname: TLabel;
    OrgcodeLabel: TLabel;
    EditRefPanel: TPanel;
    Label1: TLabel;
    SaveRefButton: TButton;
    CancelButton: TButton;
    EditPageNo: TEdit;
    RefNotes: TMemo;
    FindNameButton: TButton;
    FindCodeButton: TButton;
    Notes: TLabel;
    ShowCode: TLabel;
    ShowName: TLabel;
    ButtonPanel: TPanel;
    NewBookButton: TButton;
    EditBookButton: TButton;
    DeleteBookButton: TButton;
    Panel1: TPanel;
    NewRefButton: TButton;
    DeleteRefButton: TButton;
    PagePanel: TPanel;
    Label8: TLabel;
    UpButton: TButton;
    DownButton: TButton;
    PageToFind: TSpinEdit;
    PageButton: TButton;
    Panel2: TPanel;
    ClickLabel: TLabel;
    RefOrderButtons: TRadioGroup;
    CloseButton: TButton;
    Label6: TLabel;
    Panel3: TPanel;
    TitleLabel: TLabel;
    FamilyListCB: TComboBox;
    Label10: TLabel;
    FamilyCount: TLabel;
    FamOrderButtons: TRadioGroup;
    EditRefButton: TButton;
    EditOrgButton: TButton;
    procedure BookListChange(Sender: TObject);
    procedure FindNameButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RefListViewClick(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure PageButtonClick(Sender: TObject);
    procedure NewBookButtonClick(Sender: TObject);
    procedure FamilyMembersClick(Sender: TObject);
    procedure RefOrderButtonsClick(Sender: TObject);
    procedure RefListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FamOrderButtonsClick(Sender: TObject);
    procedure FamilyMembersCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure NewRefButtonClick(Sender: TObject);
    procedure DeleteBookButtonClick(Sender: TObject);
    procedure EditBookButtonClick(Sender: TObject);
    procedure SaveRefButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure DeleteRefButtonClick(Sender: TObject);
    procedure EditPagenoExit(Sender: TObject);
    procedure RefNotesExit(Sender: TObject);
    procedure EditExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function CompareInt(Item1,Item2:string):integer;
    function CompareDate(Item1,Item2:string):integer;
    procedure FamilyListCBChange(Sender: TObject);
    procedure FindCodeButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure EditRefButtonClick(Sender: TObject);
    procedure EditOrgButtonClick(Sender: TObject);
  private
    function LocateRef(Orgcode:ansistring;Pageno:integer):boolean;
    procedure AddListOrgItem(Dataset:TIB_Query;ListView:TListView;SubItemFieldList:array of string);
    procedure AdjustListHeight(ListView:TListView;MaxHeight:integer);
    function ChangeOrganism(Orgcode:ansistring):boolean;
    procedure EditOrganism;
    procedure FillBookList;
    procedure FindBookRefs;
    procedure FindFamilyMembers;
    procedure ListOrgs(Dataset:TIB_Query;ListView:TListView;SubItemFieldList:array of string);
    procedure NextPage;
    procedure PreviousPage;
    function SelectOrgsByFamily(familycode:ansistring):boolean;
    procedure ChangeBook(BookCode:string);
  public
    currentBook:TBook;
    currentOrg:TOrganism;
    CurrentRef:TPageRef;
    BooksQuery: TIB_Query;
    OrgQuery: TIB_Query;
    NameQuery: TIB_Query;
    RefQuery: TIB_Query;
    OrgsByFamilyQuery: TIB_Query;
    EditRefMode:integer;
    { Public declarations }
  end;

var
  JPEditorForm: TJPEditorForm;

implementation

uses OrganismEdit, IMSMain, OrgNameSelect, OrganismSelect;




{$R *.dfm}

procedure TJPEditorForm.AddListOrgItem(Dataset:TIB_Query;ListView:TListView;SubItemFieldList:array of string);
var  i:integer; ListItem: TListItem;  fieldname:string;
begin
          ListItem:=ListView.Items.Add;
          ListItem.Caption:=DataSet.FieldValues['orgcode'];
          for i := 0 to Length(SubItemFieldList)-1  do
          begin
            fieldname:=SubItemFieldList[i];
            if DataSet.FieldByName(fieldname).IsNull then
              ListItem.SubItems.Add('')
            else ListItem.SubItems.Add(DataSet.FieldValues[fieldname]);
          end;
end;

procedure TJPEditorForm.AdjustListHeight(ListView:TListView;MaxHeight:integer);
var  inc, OldHeight, MinHeight:integer;
//adjust height of listbox to fit items
begin
  if ListView.Items.Count>0 then   //if no items will reduce list height to 0!
  begin
    MinHeight:= ListView.Font.Height;
    inc:=-MinHeight;
    oldheight:=0;
    while ListView.Height<>OldHeight do  //loop while changing
    begin
      OldHeight:=ListView.Height;
      if ListView.VisibleRowCount<ListView.Items.Count then
        if (ListView.Height<=MaxHeight-inc) then ListView.Height:=ListView.Height+inc
        else break
      else if ListView.VisibleRowCount>ListView.Items.Count then
        if (ListView.Height>MinHeight) then ListView.Height:=ListView.Height-inc
       else break;
    end;
  end;
end;

procedure TJPEditorForm.BookListChange(Sender: TObject);
var i:integer;
 begin
    i:=BookList.ItemIndex;
    if i>=0 then
    begin
      ChangeBook(BookList.Items[i]);
    end;
end;

procedure TJPEditorForm.CancelButtonClick(Sender: TObject);
begin
      if (RefQuery.Modified) and
        (MessageDlg('Confirm cancel changes?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
           RefQuery.Cancel;
      ShowCode.Caption:='';
      EditPageNo.Text:='';
      ShowName.Caption:='';
      RefNotes.Text:='';
      EditRefPanel.Visible:=false;
      PagePanel.Visible:=true;
      RefListView.Enabled:=true;
      EditRefMode:=NullMode;

end;

function TJPEditorForm.ChangeOrganism(Orgcode:ansistring):boolean;
//make new organism current
begin
   result:=false;
   CurrentOrg.Clear;
   CurrentOrg.orgcode:=Orgcode;
   try
   //get details
      OrgQuery.Open;
      if OrgQuery.Locate('OrgCode',CurrentOrg.orgcode,[lopCaseInsensitive],1) then
      begin
        CurrentOrg.readBasicFromDataset(OrgQuery);
        OrgcodeLabel.Caption:=CurrentOrg.orgcode;
        Prefname.Caption:=CurrentOrg.preferredname;
        result:=true;
      end
      else showMessage('Organism not found');;
      OrgQuery.Close;
   except
     on e:exception do ShowMessage('Problem encountered on organism '+CurrentOrg.orgcode+'; error was '+e.Message);
   end;
end;

procedure TJPEditorForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

function TJPEditorForm.LocateRef(Orgcode:ansistring;Pageno:integer):boolean;
var padcode:ansistring;
//locates reference in current book from org and pageno   (IBO Locate won't work for some reason )
begin
   result:=false;
   RefQuery.First;
   try
      while not RefQuery.eof do
        if (RefQuery.FieldValues['ORGCODE']=orgcode) and
          (RefQuery.FieldValues['BOOKCODE']=CurrentBook.bookcode) and
          (RefQuery.FieldValues['pageno']=pageno) then
        begin
           result:=true;
           break;
        end
        else RefQuery.Next;
    except
     on e:exception do ShowMessage('Problem encountered on reference for '+orgcode+' in '+CurrentBook.bookcode+'; error was '+e.Message);
    end;
end;

function TJPEditorForm.CompareDate(Item1,Item2:string):integer;
var j,k:Tdate;
begin
  if not(Item1<>'') then result:=-1 //Item1 is not a date so Item2 is greater
  else begin
    j:=StrToDate(Item1);
    if not(Item2<>'') then  result:=1 //Item2 is not a date so Item1 is greater
    else begin
      k:=StrToDate(Item2);
      if j=k then result:=0
      else if j>k then result:=1
      else result:=-1;
    end;
  end;
end;

function TJPEditorForm.CompareInt(Item1,Item2:string):integer;
var j,k:integer;
begin
  j:=StrToInt(Item1);
  k:=StrToInt(Item2);
  if j=k then result:=0
  else result:=j-k;
end;

procedure TJPEditorForm.DeleteBookButtonClick(Sender: TObject);
var i:integer; AUseCode:ansistring;
begin
  if MessageDlg('This will NOT DELETE the source, but will remove it from the list of Japanese sources. Remove '+currentBook.bookcode+'?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
      if CurrentBook.StripUse('Japanese') then
        CurrentBook.WriteToDataset(BooksQuery);
      i:=BookList.Items.IndexOf(currentbook.bookcode);
      if i>=0 then BookList.Items.Delete(i);       //remove from list
      BooksQuery.Refresh;            //remove from dataset
      CurrentBook.Clear;      //clear currentbook though another book will be selected
      BookList.ItemIndex:=0;                       //select first book
      ChangeBook(BookList.Items[0]);
  end;
end;

procedure TJPEditorForm.DeleteRefButtonClick(Sender: TObject);
begin
  if (CurrentRef.orgcode<>'') then
      if MessageDlg('Delete reference '+currentRef.orgcode+' on page '+IntToStr(CurrentRef.PageNo)+' of this book?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
      begin
        ShowMessage('Deleting '+IntToStr(RefQuery.FieldValues['REFID']));
        RefQuery.Delete;
        RefListView.Selected.Delete;
        CurrentRef.orgcode:='';
   end;
end;

procedure TJPEditorForm.DownButtonClick(Sender: TObject);
begin
  RefListView.Items.Clear;
  while (RefListView.Items.Count=0) and (StrToInt(PageToFind.Text)<PageToFind.MaxValue)
    do NextPage;
end;

procedure TJPEditorForm.EditBookButtonClick(Sender: TObject);
begin
    BooksForm.CurrentUseName:='Japanese';
    BooksForm.Currentbook.bookcode:=Currentbook.bookcode;
    BooksForm.Mode:=EditMode;
    BooksForm.ShowModal;
end;

procedure TJPEditorForm.EditExecute;
begin
    if OrganismSelectForm.ShowModal=mrOK then   //get org code
    begin
      OrganismEditForm.CurrentOrg.Clear;
      OrganismEditForm.CurrentOrg.Orgcode:=OrganismSelectForm.CurrentOrgCode;
      OrganismEditForm.ShowModal;   //edit
    end;
end;

procedure TJPEditorForm.EditOrganism;
begin
      IMSHomeForm.CurrentOrgUseName:='Japan';
      OrganismEditForm.CurrentOrg.Assign(CurrentOrg);
      OrganismEditForm.Mode:=EditNamesMode;
      OrganismEditForm.ShowModal;
end;

procedure TJPEditorForm.EditOrgButtonClick(Sender: TObject);
begin
    if FamilyMembers.Selected<>nil then
    begin
      CurrentOrg.Clear;
      CurrentOrg.Orgcode:=FamilyMembers.Selected.Caption;
      OrganismEditForm.Mode:=EditMode;
      OrganismEditForm.CurrentOrg.Clear;
      OrganismEditForm.CurrentOrg.Orgcode:=CurrentOrg.OrgCode;
      OrganismEditForm.ShowModal;
    end;
end;

procedure TJPEditorForm.EditPagenoExit(Sender: TObject);
begin
  CurrentRef.pageno:=StrToIntDef(EditPageno.text,0);
end;

procedure TJPEditorForm.EditRefButtonClick(Sender: TObject);
begin
      if (CurrentRef.orgcode<>'') then     //get org and book from list
      begin
        //if OK copy existing values to edit fields
          ShowCode.Caption:=CurrentRef.orgcode;
          EditPageNo.Text:=IntToStr(CurrentRef.pageno);
          ShowName.Caption:=RefListView.Selected.SubItems[0];
          RefNotes.Text:=CurrentRef.Notes;
          EditRefMode:=EditMode;
          FindcodeButton.Visible:=false;
          FindNameButton.Visible:=false;
          EditRefPanel.Visible:=true;
          PagePanel.Visible:=false;
          RefListView.Enabled:=false;
        end;
end;

procedure TJPEditorForm.FamilyMembersClick(Sender: TObject);
var AListItem:TListItem;
begin
    if FamilyMembers.Selected<>nil then
    begin
      if ChangeOrganism(Ansistring(FamilyMembers.Selected.Caption)) then
        //change of org in family list - try to match it in refs
        begin
          AListItem:=RefListView.FindCaption(0,CurrentOrg.orgcode,false,true,false);
          if AListItem=nil then RefListView.ItemIndex:=-1  //org has no ref in this book
          else begin
            AListItem.Selected:=true;
            AListItem.MakeVisible(false);
          end;
        end
    end;
end;

procedure TJPEditorForm.FamilyMembersCompare(Sender: TObject; Item1,
   Item2: TListItem; Data: Integer; var Compare: Integer);
var ix: Integer;
begin
  ix:=FamOrderButtons.ItemIndex;
  case ix of
   0: Compare := CompareText(Item1.Caption,Item2.Caption);  //code
   1: if Item2.SubItems.Count>0 then             //if compare called on creation - subitems not yet created
         Compare := CompareText(Item1.SubItems[0],Item2.SubItems[0]);    //name
   2: if Item2.SubItems.Count>0 then
         Compare := CompareDate(Item1.SubItems[1],Item2.SubItems[1]);    //date modified
  end;
end;

procedure TJPEditorForm.FamOrderButtonsClick(Sender: TObject);
begin
  FamilyMembers.AlphaSort;
end;

procedure TJPEditorForm.FindBookRefs;
var  pageno:integer;
begin
  pageno:=0;
  if (PageToFind.Text>'') then
        pageno:=StrToIntDef(PageToFind.Text,9999);  //valdate page number
  if pageno=9999 then pageno:=0;
  if pageno=0 then     //all pages
    with RefQuery do
    begin
      close;
      ParamByName('BOOKCODE').value:=currentBook.Bookcode;
      if currentBook.Volume<>'' then ParamByName('VOLUME').value:=currentBook.Volume
      else ParamByName('VOLUME').value:='%';   //any
      ParamByName('LOWPAGENO').value:=0;
      ParamByName('HIGHPAGENO').value:=9999;
      prepare;
      open;
    end
  else with RefQuery do
  begin
    ParamByName('BOOKCODE').value:=currentBook.bookcode;
    if currentBook.Volume<>'' then ParamByName('VOLUME').value:=currentBook.Volume
    else ParamByName('VOLUME').value:='%';   //any
    ParamByName('LOWPAGENO').value:=pageno-1;
    ParamByName('HIGHPAGENO').value:=pageno+1;
    prepare;
    open;
  end;
  ListOrgs(RefQuery,RefListView,['FULLNAME','pageno']);
end;


procedure TJPEditorForm.FindCodeButtonClick(Sender: TObject);
begin
    OrganismSelectForm.Mode:=TransferMode;         //show edit, add, delete buttons
    OrganismSelectForm.CurrentOrgUseName:='All';
    if OrganismSelectForm.ShowModal=mrOK then      //get orgname
    begin
      CurrentOrg.Clear;
      CurrentOrg.Orgcode:=OrganismSelectForm.CurrentOrgCode;
      ShowCode.Caption:=CurrentOrg.Orgcode;
      ShowName.Caption:=CurrentOrg.PreferredName;
    end;
end;

procedure TJPEditorForm.FamilyListCBChange(Sender: TObject);
begin
    FindFamilyMembers;
end;

procedure TJPEditorForm.FillBookList;
begin
//construct list of books in memory
    BooksQuery.DisableControls;
    BooksQuery.First;
    BookList.Clear;
    while not BooksQuery.eof do
    begin
      BookList.Items.Add(BooksQuery.FieldValues['BOOKCODE']);
      BooksQuery.Next;
    end;
    BooksQuery.EnableControls;
    BookCount.Caption:=IntToStr(BookList.Items.Count);
end;


procedure TJPEditorForm.FindFamilyMembers;
var i,j:integer; OrgLine:TListItem; famcode:ansistring;
begin
  if FamilyListCB.ItemIndex>=0 then
  begin
    famcode:=IMSHomeForm.FamilyList.Values[FamilyListCB.Items[FamilyListCB.ItemIndex]];  //family code
    SelectOrgsByFamily(famcode);
    ListOrgs(OrgsByFamilyQuery,FamilyMembers,['FULLNAME','datemodified']);
    for j:=0 to FamilyMembers.Items.Count-1 do
    begin
      OrgLine:=FamilyMembers.Items[j];
      if (OrgLine.SubItems[1]<>'') and (StrToDate(OrgLine.SubItems[1])=Date) then
         OrgLine.StateIndex:=0;
    end;
    FamilyMembers.ItemIndex:=-1; //no selection to start with
  end;
end;

procedure TJPEditorForm.FindNameButtonClick(Sender: TObject);
begin
    OrgNameSelectForm.Mode:=TransferMode;         //show edit, add, delete buttons
    if OrgNameSelectForm.ShowModal=mrOK then      //get orgname
    begin

      ChangeOrganism(OrgNameSelectForm.ResultName.OrgCode);
      CurrentOrg.PreferredName:=OrgNameSelectForm.ResultName.fullname;
      ShowName.Caption:=CurrentOrg.PreferredName;
      ShowCode.Caption:=CurrentOrg.ORGCODE;
    end;
end;

procedure TJPEditorForm.FormActivate(Sender: TObject);
var familycode,genuscode,orgcode:ansistring;  i:integer; familyname:string;
begin
  if BookList.Items.Count=0 then  //first entry - initialize booklist and family list
  begin
  //initialize list of books
    BooksQuery.ParamByName('UsedBy').Value:='%'+BooksForm.BookUses.FindUseCode('Japanese')+'%';
    BooksQuery.ParamByName('Print').Value:='%';
    BooksQuery.Open;
    BookDataSource.Dataset:=BooksQuery;
    FillBookList;
  //copy list of families
    FamilyListCB.Clear;
    for i:=0 to IMSHomeForm.FamilyList.Count-1 do
    begin
        FamilyListCB.Items.Add(IMSHomeForm.FamilyList.Names[i]);  //copy namesof families into combo box
    end;
    FamilyListCB.Sorted:=True;
    FamilyCount.Caption:=IntToStr(FamilyListCB.Items.Count);
  end;
  //initialise current organism
  if CurrentBook.IsEmpty then
  begin
     BookList.ItemIndex:=0;           //set book to first
     ChangeBook(BookList.Items[0]);
  end;
end;


procedure TJPEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    BooksQuery.Close; //book query
end;

procedure TJPEditorForm.FormCreate(Sender: TObject);
begin
  currentOrg:=TOrganism.Create;
  currentBook:=TBook.Create;
  CurrentRef:=TPageRef.Create;
  //bug fix to avoid Stream error
  FamilyMembers.ViewStyle:=vsReport;
  FamilyMembers.Columns[0].Width:=100;
  FamilyMembers.Columns[1].Width:=200;
  FamilyMembers.Columns[2].Width:=150;
  FamilyMembers.Clear;
  RefListView.ViewStyle:=vsReport;
  RefListView.Columns[0].Width:=100;
  RefListView.Columns[1].Width:=200;
  RefListView.Columns[2].Width:=80;
  RefListView.Clear;
end;

procedure TJPEditorForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(currentOrg);
    FreeAndNil(currentBook);
    FreeAndNil(CurrentRef);
end;

procedure TJPEditorForm.FormResize(Sender: TObject);
begin
   AdjustListHeight(RefListView,RefPanel.ClientHeight-100);
   AdjustListHeight(FamilyMembers,FamilyPanel.ClientHeight-100);
end;

procedure TJPEditorForm.ListOrgs(Dataset:TIB_Query;ListView:TListView;SubItemFieldList:array of string);
begin
    ListView.enabled:=false;
    ListView.Items.Clear;
    Dataset.Open;
    if not DataSet.IsEmpty then
    begin
       //ListView.Enabled:=true;
       DataSet.First;
       while not DataSet.Eof do
       begin
          AddListOrgItem(Dataset,ListView,SubItemFieldList);
          DataSet.Next;
       end;
       ListView.Enabled:=true;
       if ListView.Items.Count>1 then ListView.AlphaSort;
    end;
end;

procedure TJPEditorForm.NewBookButtonClick(Sender: TObject);
var  ABook: TBook;
begin
    // go to master list, pick a book and reset its codes (see bookplates)
    ABook := TBook.Create;
    try
    if IMSHomeForm.PickABook('Book','Japanese',ABook) then
      if not ABook.IsEmpty then
      begin
        BooksQuery.Refresh;
        BookList.Items.Add(ABook.bookcode);    //adds item at end, but it is then sorted
        BookList.ItemIndex:=BookList.Items.IndexOf(ABook.bookcode);  //select new entry
        ChangeBook(ABook.bookcode);            //set as new book
      end;
      finally
      ABook.Free;
    end;
end;


procedure TJPEditorForm.NewRefButtonClick(Sender: TObject);
begin
      EditRefPanel.Visible:=true;
      PagePanel.Visible:=false;
      RefListView.Enabled:=false;
      FindcodeButton.Visible:=True;
      FindNameButton.Visible:=True;
      EditRefMode:=InsertMode;
      if currentOrg.orgcode<>'' then
      begin
        CurrentRef.orgcode:=currentOrg.orgcode;
        ShowCode.Caption:=currentOrg.orgcode;
        if currentOrg.preferredname<>'' then ShowName.Caption:=currentOrg.preferredname;
      end;
      CurrentRef.bookCode:=currentBook.bookCode;
      CurrentRef.Volume:=currentBook.volume;
      EditPageno.SetFocus;
end;

procedure TJPEditorForm.NextPage;
begin
  if (PageToFind.Text>'') and (StrToInt(PageToFind.Text)<PageToFind.MaxValue) then
      PageToFind.Text:=IntToStr(StrToInt(PageToFind.Text)+1);
  FindBookRefs;
end;

procedure TJPEditorForm.PageButtonClick(Sender: TObject);
begin
    FindBookRefs;
end;

procedure TJPEditorForm.PreviousPage;
begin
  if (PageToFind.Text>'') and (StrToInt(PageToFind.Text)>0) then PageToFind.Text:=IntToStr(StrToInt(PageToFind.Text)-1);
  FindBookRefs;
end;

procedure TJPEditorForm.RefOrderButtonsClick(Sender: TObject);
begin
  RefListView.AlphaSort;
end;

procedure TJPEditorForm.RefListViewCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if RefOrderButtons.ItemIndex = 0 then              //code
    Compare := CompareText(Item1.Caption,Item2.Caption)
  else if Item2.SubItems.Count>0 then             //if compare called on creation - subitems not yet created
          if RefOrderButtons.ItemIndex = 1 then      //pageno ascending order
              Compare := CompareInt(Item1.SubItems[1],Item2.SubItems[1]);
end;

procedure TJPEditorForm.RefNotesExit(Sender: TObject);
begin
  CurrentRef.Notes:=RefNotes.Text;
end;

procedure TJPEditorForm.RefListViewClick(Sender: TObject);
// change family
var AListItem:TListItem;
begin
    if RefListView.Selected<>nil then
    begin
      CurrentRef.orgcode:=Ansistring(RefListView.Selected.Caption);      //get org from list
      CurrentRef.pageno:=StrToInt(RefListView.Selected.SubItems[1]);      //page no
      if LocateRef(CurrentRef.orgcode,CurrentRef.pageno) then  //locate reference
          CurrentRef.readFromDataset(RefQuery);
      if ChangeOrganism(CurrentRef.orgcode) then  //make org current and adjust family list
      begin
      // adjust family list
      //change of reference implies change of org and perhaps family
        if (FamilyListCB.ItemIndex>=0) then     //find new org in family list if there is one
          AListItem:=Familymembers.FindCaption(0,CurrentOrg.orgcode,false,true,false);   //find new org in family list
        if AListItem=nil then    //not in this family so change list to org's family
        begin
        //change family
          FamilyListCB.ItemIndex:=FamilyListCB.Items.IndexOf(IMSHomeForm.GetFamilyName(CurrentOrg.Family));
          FindFamilyMembers;
          AListItem:=Familymembers.FindCaption(0,CurrentOrg.orgcode,false,true,false); //find org in new family list
        end;
        if AListItem<>nil then   //probably only in test data
        begin
          AListItem.Selected:=true;
          AListItem.MakeVisible(false);
        end;
      end;
    end;
end;

procedure TJPEditorForm.SaveRefButtonClick(Sender: TObject);
var canaddref,refsexist:boolean; AListItem:TListItem;
begin
  canaddref:=false;    //cannot add ref if errors or it's already there
  //validate data from edit fields
  CurrentRef.pageno:=StrToIntDef(Trim(EditPageNo.Text),-1);
  if CurrentRef.pageno<0 then
    ShowMessage('Page number not numeric')
  else begin
  //check duplicates
    if (ShowCode.Caption<>'') then  //orgcode must be set
    begin
      refsexist:=LocateRef(ShowCode.Caption,CurrentRef.pageno); //NB moves pointer
      if refsexist and (EditMode=InsertMode) then
      begin
        if StrToInt(EditPageNo.Text)=RefQuery.FieldValues['Pageno'] then //repeat ref  same page no
          ShowMessage(CurrentOrg.orgcode+' already has a reference for page '+EditPageNo.Text+' of this book. Change the organism and/or page number before clicking Add New Ref button')
        else canaddref:=MessageDlg(CurrentOrg.orgcode+' already has a page reference in this book. Add another for page '+pageToFind.Text+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes
      end
      else
        canaddref:=true; //no existing refs
    end
  end;
  if canaddref then
  begin
      if EditRefMode=InsertMode then RefQuery.Insert
      else RefQuery.Edit;
  //put edited values in CurrentRef
      CurrentRef.Notes:= RefNotes.Text;
      CurrentRef.Orgcode:=ShowCode.Caption;
      CurrentRef.pageno:=StrToIntDef(Trim(EditPageNo.Text),-1);
      CurrentRef.WriteToDataset(RefQuery);
      ShowMessage('Reference saved');
      if EditRefMode=InsertMode then //insert display line
      begin
          AListItem:=RefListView.Items.Add;
          AListItem.SubItems.Add('');
          AListItem.SubItems.Add('');
      end
      else AListItem:=RefListView.Selected;
      AListItem.Caption:=CurrentRef.orgcode;
      AListItem.SubItems[0]:=ShowName.Caption;
      AListItem.SubItems[1]:=IntToStr(CurrentRef.pageno);
      RefListView.Enabled:=true;
  end;
  PagePanel.Visible:=true;
  EditRefPanel.Visible:=false;
end;

function TJPEditorForm.SelectOrgsByFamily(familycode:ansistring):boolean;
begin
  with OrgsByFamilyQuery do
  begin
    close;
    ParamByName('FAMILY').value:=familycode;
    prepare;
    open;
    result:=IsEmpty;
  end;
end;

procedure TJPEditorForm.ChangeBook(BookCode:string);
// set CurrentBook and find references
begin
  if Bookcode<>'' then
  begin
    BooksQuery.Open;
    if BooksQuery.Locate('BookCode',Bookcode,[],1) then
    begin
      CurrentBook.ReadFromDataset(BooksQuery);
      if CurrentBook.NumberOfPages=0 then CurrentBook.NumberOfPages:=999;
      PageToFind.MinValue:=0;
      PageToFind.MaxValue:=CurrentBook.NumberOfPages;
      PageToFind.Value:=0;       //set for whole book when first selected
      FindBookRefs;              // then look for page refs
    end
    else ShowMessage('Cannot find book '+ Bookcode);
  end;
end;

procedure TJPEditorForm.UpButtonClick(Sender: TObject);
begin
  RefListView.Items.Clear;
  while (RefListView.Items.Count=0) and (StrToInt(PageToFind.Text)>0) do PreviousPage;
end;


end.
