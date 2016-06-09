unit IMSMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, BookConcepts, IB_Components, IB_Access, EUDMain,
  ImgList, ActnList, StdActns, Menus, OrganismConcepts, IniFiles, ComCtrls,
  Generics.Defaults, Generics.Collections, Math, Grids, IB_Grid, StrUtils,
  OleServer, ExcelXP, IdBaseComponent, IdComponent, IdIOHandler,Idhttp,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, NativeXML;

type

  TIMSHomeForm = class(TForm)
    VerifyIcons: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Admin: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    ActionList1: TActionList;
    FileExit1: TFileExit;
    Books1: TMenuItem;
    Plants1: TMenuItem;
    Fungi1: TMenuItem;
    Europeanplants: TMenuItem;
    japaneseplants1: TMenuItem;
    EditBooksAction: TAction;
    openbooks1: TMenuItem;
    BookPlatesAction: TAction;
    Bookplates1: TMenuItem;
    EditEuropeanPlants: TAction;
    EditJapanesePlants: TAction;
    EditFungiAction: TAction;
    EditFungi1: TMenuItem;
    EditPortugueseCards: TAction;
    EditPortugueseplantdescriptions1: TMenuItem;
    RunJapanPlants: TAction;
    ExitButton: TButton;
    EditForays: TAction;
    Editforays1: TMenuItem;
    ReviewJapaneseplantsbybook1: TMenuItem;
    TestRG: TRadioGroup;
    EditAllByCode: TAction;
    OrgNamesOpen: TAction;
    InfoLabel: TLabel;
    ShowVersion: TAction;
    EditAllByName: TAction;
    Findorganismsbycode1: TMenuItem;
    Findorganismsbyname1: TMenuItem;
    CheckPrefNames: TAction;
    CheckPrefNames1: TMenuItem;
    AdminDSQL: TIB_DSQL;
    AdminQuery: TIB_Query;
    AdminGrid: TIB_Grid;
    AdminDS: TIB_DataSource;
    AdminLabel: TLabel;
    EPPOLookupCB: TCheckBox;
    Bookrefs: TMenuItem;
    EditBookRefs: TAction;
    Addorganism1: TMenuItem;
    AddOrganism: TAction;
    ClearButton: TButton;
    CheckDuplicateNames: TAction;
    Label1: TLabel;
    RunDataImport: TAction;
    Adm1: TMenuItem;
    FillPreferredNames: TAction;
    FillPreferredNames1: TMenuItem;
    Mergetables1: TMenuItem;
    MergeOrgTables: TAction;
    CheckCard: TAction;
    FindScientificNameErrors: TAction;
    Checkscientificnames1: TMenuItem;
    RunDataImport2: TMenuItem;
    Checkcard1: TMenuItem;
    NbLines: TLabel;
    SplitJPNames: TAction;
    SplitJapanesenames1: TMenuItem;
    insertJPUse: TAction;
    InsertJPuse1: TMenuItem;
    Res1: TMenuItem;
    ManageBooks: TAction;
    ExportToEPPO: TAction;
    Admin1: TMenuItem;
    ExporttoEPPO1: TMenuItem;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure FormActivate(Sender: TObject);
    procedure EditJapanesePlantsExecute(Sender: TObject);
    procedure EditFungiActionExecute(Sender: TObject);
    procedure EditBooksActionExecute(Sender: TObject);
    procedure RunJapanPlantsExecute(Sender: TObject);
    procedure BookPlatesActionExecute(Sender: TObject);
    procedure EditPortugueseCardsExecute(Sender: TObject);
    procedure EditForaysExecute(Sender: TObject);
    procedure EditEuropeanPlantsExecute(Sender: TObject);
    procedure EditAllByCodeExecute(Sender: TObject);
    procedure TestRGClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OrgNamesOpenExecute(Sender: TObject);
    procedure EditAllByNameExecute(Sender: TObject);
    procedure CheckPrefNamesExecute(Sender: TObject);
    procedure EditBookRefsExecute(Sender: TObject);
    procedure EPPOLookupCBClick(Sender: TObject);
    procedure AddOrganismExecute(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure CheckDuplicateNamesExecute(Sender: TObject);
    procedure AdminGridDblClick(Sender: TObject);
    procedure RunDataImportExecute(Sender: TObject);
    procedure FillPreferredNamesExecute(Sender: TObject);
    procedure MergeOrgTablesExecute(Sender: TObject);
    procedure FindScientificNameErrorsExecute(Sender: TObject);
    procedure CheckcardExecute(Sender: TObject);
    procedure SplitJPNamesExecute(Sender: TObject);
    procedure insertJPUseExecute(Sender: TObject);
    procedure ManageBooksExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExportToEPPOExecute(Sender: TObject);
  private
    { Private declarations }
  public
    AdminTask:smallint;
    AdminOrgTableName:string;
    AdminNameTableName:string;
    CurrentBookUseName:ansistring;
    CurrentOrgUsename:ansistring;
    CurrentBookUse:ansistring;
    EPPOFilesPath:string;
    FamilyList:TStringList;
    LanguageLookup: TLanguageTable;
    NewQuery:boolean;
    OrgNamesComparison:TComparison<TOrgName>;
    OrgUses: TOrgUses;
    EPPOCodeModList:TStringList;
    function ValidOrgCode(ACode: string): ansistring;
    function GetFamilyName(familycode:ansistring):ansistring;
    function PickABook(SelectionUseName, TargetUseName:ansistring;var ReturnBook:TBook):boolean;
    procedure CheckEppoJobs;
    procedure CreateEPPOCodeMod;
    procedure SetEnvironment;
    procedure SplitString(InputString:ansistring;var OutputArray:array of ansistring;separator:ansistring);
    { Public declarations }
  end;

var
  IMSHomeForm: TIMSHomeForm;

    //  Colours for languages
const ColourList: Array [0..40] of TColor =
    //  Latin(2),        English, French, Italian, German, Dutch, Spanish (Castillian),
        (clBlack,clBlack,$00118800,clRed,$001199,$00660044,$00FF1111,$00009955 ,
    //   Catalan, Portuguese, Swedish, Danish,                       Polish,
        clFuchsia,$001166AA,$002233CC,$00006655,clNone,clNone,clNone,$00660077,clNone,clNone,clNone,
    //                                                                              Russian,
        clNone,clNone,clNone,clNone,clNone,clNone,clNone,clNone,clNone,clNone,clNone,clNavy,
    //                                                                Japanese
        clNone,clNone,clNone,clNone,clNone,clNone,clNone,clNone,clNone,clBlue);
      NullMode=0;
      EditMode=1;
      SearchMode=2;
      BookplatesMode=3;
      SingleImportMode=4;
      MultipleImportMode=5;
      ViewMode=6;
      TransferMode=7;
      DeleteMode=8;
      InsertMode=9;
      EditNamesMode=10;
      EditRefsMode=11;
      EditFindsMode=12;
      EditDistMode=13;
      MergeMode=14;
      RescueMode=15;
      ExportMode=16;


implementation

uses IMSData, OrganismSelect, OrganismEdit, Forays, PlantCardEditor,
  OrgNameSelect, OrgNameReview, Refs, Books, Finds, JPEMain, Admin;

{$R *.dfm}
procedure TIMSHomeForm.AddOrganismExecute(Sender: TObject);
begin
    OrganismEditForm.Mode:=InsertMode;
    CurrentOrgUseName:='All';
    OrganismEditForm.CurrentOrg.Clear;
    OrganismEditForm.ShowModal;
end;

procedure TIMSHomeForm.AdminGridDblClick(Sender: TObject);
begin
  if AdminTask=1 then
  begin
    OrganismEditForm.CurrentOrg.Clear;
    OrganismEditForm.CurrentOrg.Orgcode:=AdminQuery.FieldValues['OrgCode'];
    OrganismEditForm.Mode:=EditMode;
    OrganismEditForm.ShowModal;               //edit
  end;
end;

procedure TIMSHomeForm.BookPlatesActionExecute(Sender: TObject);
begin
    CurrentBookUseName:='Source';
    BooksForm.Mode:=BookplatesMode;
    BooksForm.ShowModal;
end;

procedure TIMSHomeForm.CheckcardExecute(Sender: TObject);
begin
  AdminTask:=1;
  AdminLabel.Caption:='Organisms with content in card field ';
  AdminQuery.SQL.Clear;
  AdminQuery.SQL.Add('Select O.orgcode, O.card from '+AdminOrgTableName+' O ');
  AdminQuery.SQL.Add('where (trim(o.CARD) > '+quotedstr('')+')');
  AdminQuery.Open;
  AdminGrid.Visible:=true;
  ClearButton.Visible:=true;
  NbLines.Caption:=IntToStr(AdminQuery.RecordCount)+' lines';
  NbLines.Visible:=true;
end;

procedure TIMSHomeForm.CheckDuplicateNamesExecute(Sender: TObject);
begin
  AdminTask:=1;
  AdminLabel.Caption:='Duplicate names ';
  AdminQuery.SQL.Clear;
  AdminQuery.SQL.Add('Select N1.orgcode, N1.Fullname, N1.Authority from '+AdminNameTableName+' N1 ');
  AdminQuery.SQL.Add('Join '+AdminNameTableName+' N2 ON (N1.Fullname=N2.Fullname) and (N1.Authority=N2.Authority)');
  AdminQuery.SQL.Add('where (N1.orgcode<>N2.orgcode)');
  AdminQuery.SQL.Add('and (N1.language='+quotedstr('la')+')');
  AdminQuery.Open;
  AdminGrid.Visible:=true;
  ClearButton.Visible:=true;
  NbLines.Caption:=IntToStr(AdminQuery.RecordCount)+' lines';
  NbLines.Visible:=true;
end;

procedure TIMSHomeForm.CheckEppoJobs;
var i,j, reply:integer; Inifile:TInifile; cname,JobFileNameBase,EPPOXMLJobURL,JobID:String;
SRec:TSearchRec; Idhttp:TIdhttp;
begin
  //Check outstanding EPPOConnect jobs in pending folder:
  //open ini file;
  IniFile := TIniFile.Create(ChangeFileExt(Paramstr(0),'.ini')) ;
  EPPOFilesPath:=IniFile.ReadString('EPPO', 'JobsSent', 'My Documents');
  JobFileNameBase:=IniFile.ReadString('EPPO', 'JobFileNameBase','EPPOJob');
  EPPOXMLJobURL:=IniFile.ReadString('EPPO',EPPOXMLJobURL, 'http://xxx/xmljob?id=') ;
  SRec.Name:=JobFileNameBase+'*.xml';
  Idhttp:=TIdhttp.Create;
  //run through list of files in folder
  if Findfirst(EPPOFilesPath,FaAnyFile,SRec)=0 then  //find first file
  begin
    repeat
      reply:=0;
      //for each file interrogate EPPO to see if it has finished  (job no)
      cname:=ExtractFileName(SRec.Name);
      j:=Pos('.',cname);
      JobID:= Copy(cname,8,length(cname)-j);   //extract numeric part
      idhttp.Get(EPPOXMLJobURL+JobID);
      //http://xxx/xmljob?id=123
      if reply<0 then
      begin
        // error
      end
      else if reply=1 then
      begin  //if so update it, handle job, move to completed folder
        //process
        //move to completed folder
      end;
      SRec.Name:=JobFileNameBase+'*.xml';
    until FindNext(SRec)<>0;
  end;
  FindClose(SRec);
  Idhttp.Free;
  IniFile.Free;
  //if not tell user
end;

procedure TIMSHomeForm.CheckPrefNamesExecute(Sender: TObject);
begin
  AdminTask:=1;
  AdminLabel.Caption:='Organisms with multiple preferred names or where preferred name not does not match name records';
  AdminQuery.SQL.Clear;
  AdminQuery.SQL.Add('Select O.orgcode, O.preferredName from '+AdminOrgTableName+' O ');
  AdminQuery.SQL.Add('Join '+AdminNameTableName+' N ON O.orgcode=N.orgcode');
  AdminQuery.SQL.Add('where (N.preferred<>0)');
  AdminQuery.SQL.Add('and (O.preferredName<>N.Fullname)');
  AdminQuery.Open;
  AdminGrid.Visible:=true;
  ClearButton.Visible:=true;
  NbLines.Caption:=IntToStr(AdminQuery.RecordCount)+' lines';
  NbLines.Visible:=true;
end;


procedure TIMSHomeForm.ClearButtonClick(Sender: TObject);
begin
  AdminGrid.Visible:=false;
  AdminLabel.Caption:='';
  ClearButton.Visible:=false;
  NbLines.Caption:=' ';
  NbLines.Visible:=false;
end;

procedure TIMSHomeForm.EditAllByCodeExecute(Sender: TObject);
begin
    OrganismSelectForm.Mode:=EditMode;             //show edit, add, delete buttons
    CurrentOrgUseName:='All';
    OrganismSelectForm.Show;    //get org code
end;

procedure TIMSHomeForm.EditAllByNameExecute(Sender: TObject);
begin
    CurrentOrgUseName:='All';
    OrgNameSelectForm.Mode:=EditMode;             //show edit, add, delete buttons
    OrgNameSelectForm.Show;
end;

procedure TIMSHomeForm.EditBooksActionExecute(Sender: TObject);
begin
    CurrentBookUseName:='Source';
    BooksForm.CurrentUseName:=CurrentBookUseName;
    BooksForm.Mode:=EditMode;
    BooksForm.ShowModal;
end;

procedure TIMSHomeForm.EditBookRefsExecute(Sender: TObject);
begin
  CurrentBookUseName:='Source';
  BookRefsForm.CurrentBook.Clear;  //reset to allow for change of dataset (live or test)
  BookRefsForm.Show;
end;


procedure TIMSHomeForm.EditEuropeanPlantsExecute(Sender: TObject);
begin
    OrganismSelectForm.Mode:=EditMode;             //show edit, add, delete buttons
    CurrentOrgUseName:='Europe';
    if OrganismSelectForm.ShowModal=mrOK then   //get org code
    begin
      OrganismEditForm.CurrentOrg.Clear;
      OrganismEditForm.CurrentOrg.Orgcode:=OrganismSelectForm.CurrentOrgCode;
      OrganismEditForm.Show;               //edit
    end;
end;

procedure TIMSHomeForm.EditForaysExecute(Sender: TObject);
begin
  CurrentOrgUseName:='Fungi';
  ForayForm.Show;
end;

procedure TIMSHomeForm.EditFungiActionExecute(Sender: TObject);
begin
    OrganismSelectForm.Mode:=EditMode;             //show edit, add, delete buttons
    CurrentOrgUseName:='Fungi';
    OrganismSelectForm.Show;
end;


procedure TIMSHomeForm.EditJapanesePlantsExecute(Sender: TObject);
begin
    CurrentBookUseName:='Japanese';
    CurrentOrgUseName:='Japan';
    OrganismSelectForm.Mode:=EditMode;             //show edit, add, delete buttons
    if OrganismSelectForm.ShowModal=mrOK then   //get org code
    begin
      OrganismEditForm.CurrentOrg.Clear;
      OrganismEditForm.CurrentOrg.Orgcode:=OrganismSelectForm.CurrentOrgCode;
      OrganismEditForm.Show;               //edit
    end;
end;

procedure TIMSHomeForm.EditPortugueseCardsExecute(Sender: TObject);
begin
    PlantCardEditForm.Show;
end;

procedure TIMSHomeForm.EPPOLookupCBClick(Sender: TObject);
begin
// reset to try connection again if it is disactivated
    if EPPOLookupCB.Checked then OrganismEditForm.CurrentOrg.ReactivateEPPOConnection
end;

procedure TIMSHomeForm.ExportToEPPOExecute(Sender: TObject);
begin
  AdminForm.Mode:=ExportMode;
  AdminForm.ShowModal;
end;

procedure TIMSHomeForm.FillPreferredNamesExecute(Sender: TObject);
begin
  AdminForm.Mode:=EditMode;
  AdminForm.ShowModal;
end;

procedure TIMSHomeForm.FindScientificNameErrorsExecute(Sender: TObject);
begin
  AdminTask:=1;
  AdminLabel.Caption:='Scientific names starting with lower case';
  AdminQuery.SQL.Clear;
  AdminQuery.SQL.Add('Select O.orgcode, O.Fullname, O.Authority, O.preferred from '+AdminNameTableName+' O ');
  AdminQuery.SQL.Add('where (O.language='+quotedstr('la')+')');
  AdminQuery.SQL.Add('and (UPPER(left(O.Fullname,1))<>left(O.Fullname,1))');
  AdminQuery.Open;
  AdminGrid.Visible:=true;
  ClearButton.Visible:=true;
  NbLines.Caption:=IntToStr(AdminQuery.RecordCount)+' lines';
  NbLines.Visible:=true;
end;

procedure TIMSHomeForm.FormActivate(Sender: TObject);
begin
  System.ReportMemoryLeaksOnShutdown:=true;
 try
  try
    if IMSDM.FBConnection.ConnectionStatus = csDisconnected then IMSDM.FBConnection.Connected:=true;
  except
    on e:exception do
    begin
      ShowMessage('Cannot connect to Firebird IMS database. Closing down. '+e.message);
      Close;
    end;
  end;
    //define datasets to use
    SetEnvironment;
    if  LanguageLookup.Count=0 then
    begin
      with IMSDM.AllLanguagesQuery do
      begin
        open;
        First;
        while not eof do
        begin
          LanguageLookup.Add(IMSDM.AllLanguagesQuery.FieldValues['LangCode'],
            IMSDM.AllLanguagesQuery.FieldValues['LangName'],
            IMSDM.AllLanguagesQuery.FieldValues['SortOrder'],
            ColourList[IMSDM.AllLanguagesQuery.FieldByName('SortOrder').AsInteger]);
          Next;
        end;
        close;
      end;
    end;
  finally
    if IMSDM.FBConnection.ConnectionStatus = csDisconnected then
      ShowMessage('Cannot open database. Check Firebird alias "IMSDB" exists in alias.conf');
  end;
end;

procedure TIMSHomeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      //if Assigned(ExcelApp) then ExcelApp.Quit;
      //IMSHomeForm.ExcelApp :=nil;
end;

procedure TIMSHomeForm.CreateEPPOCodeMod;
//write accumulated eppocode names in EPPOCodeModList to xml
var  ADoc:TNativeXml; i:integer;
begin
    ADoc:=TNativeXml.Create('eppocodes');
    try
      for i:=0 to EPPOCodeModList.Count-1 do  //recover stored name-value pairs
      begin
        if EPPOCodeModList.Names[i]='eppocode' then   //start of new code
        begin
          if not first then ADoc.Root.NodeAdd('/eppocode');
          ADoc.Root.NodeAdd('eppocode');    //code as attr
          ADoc.Root.NodeAdd('names');
        end
        else begin
        end;
        ADoc.WriteToString(Stream);
      end;
      //fidhttp.Post(url,Stream);  }
    finally
         ADoc.Free;
    end;

end;

procedure TIMSHomeForm.FormCreate(Sender: TObject);
begin
   FamilyList:=TStringList.Create;
   FamilyList.CaseSensitive:=false;
   EPPOCodeModList:=TStringList.Create;
   LanguageLookup:=TLanguageTable.Create;
   OrgUses:=TOrgUses.Create;
   InfoLabel.Caption:='Use the Edit menu option to find organisms by name or eppo code and add new organisms; '+
  'Books to run Bookplates and edit book data; '+
  'Plants and Fungi options to view organisms by type and perform certain editing functions on groups of organisms; '+
  'Checks for checking errors in the database. '+
  'Make sure Test data option is selected before you change anything! '+
  'Finds and forays are live data - do not change!';
end;

procedure TIMSHomeForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(OrgUses);
    FreeAndNil(LanguageLookup);
    FreeAndNil(FamilyList);
    FreeAndNil(EPPOCodeModList);
end;

function TIMSHomeForm.GetFamilyName(familycode:ansistring):ansistring;
var i:integer;
begin
    result:='';
    for i:=0 to FamilyList.Count-1 do
    begin
        if FamilyList.ValueFromIndex[i]=familycode then
        begin
          result:=FamilyList.Names[i];
          break;
        end;
    end;
end;

procedure TIMSHomeForm.insertJPUseExecute(Sender: TObject);
begin
  AdminForm.Mode:=TransferMode;
  AdminForm.ShowModal;
end;

procedure TIMSHomeForm.MergeOrgTablesExecute(Sender: TObject);
begin
  AdminForm.Mode:=MergeMode;
  AdminForm.ShowModal;
end;

procedure TIMSHomeForm.OrgNamesOpenExecute(Sender: TObject);
begin
    OrgNameSelectForm.Show;
end;

function TIMSHomeForm.PickABook(SelectionUseName,TargetUseName:ansistring;var ReturnBook:TBook):boolean;
begin
    result:=false;
    BooksForm.NewUseName:=TargetUseName;
    BooksForm.CurrentUseName:=SelectionUseName;
    BooksForm.Mode:=SearchMode;             //set lookup mode (sets buttons etc)
    if BooksForm.ShowModal=mrOK then
    begin
      ReturnBook.Assign(BooksForm.CurrentBook);
      result:=True;
    end;
end;

procedure TIMSHomeForm.ManageBooksExecute(Sender: TObject);
begin
  AdminForm.Mode:=RescueMode;
  AdminForm.ShowModal;
end;

procedure TIMSHomeForm.RunDataImportExecute(Sender: TObject);
begin
  AdminTask:=0;
  if MessageDlg('Beware! According to the settings you choose, the data importing module may overwrite the database. '
    +'Run it now?',mtWarning,[mbYes,mbCancel],0 )=mrYes then
    EUMainForm.Show;
end;

procedure TIMSHomeForm.RunJapanPlantsExecute(Sender: TObject);
begin
  CurrentBookUseName:='Japanese';
  CurrentOrgUseName:='Japan';
  JPEditorForm.Show;
end;

procedure TIMSHomeForm.SetEnvironment;
//set sort routines for organism name lists and display; set datasets
begin

//custom comparison routine for lists of names
OrgNamesComparison:=
function (const Left, Right: TOrgName): Integer
begin
    result := CompareValue(IMSHomeForm.LanguageLookup.FindSortOrder(Left.LanguageCode),IMSHomeForm.LanguageLookup.FindSortOrder(Right.LanguageCode));
    if result=0 then
    begin
        if (Left.IsScientific and TScientificName(Left).Preferred) then result:=-1;  // L preferred
        if (Right.IsScientific and TScientificName(Right).Preferred) then
          if result<0 then result:=0                               //error: both are preferred!
          else result:=1;                                          // R preferred
    end;
    if result=0 then
        result := CompareText(Left.FullName,Right.FullName)  //fullname
end;

//set files for data
    if TestRG.ItemIndex=0 then
    begin
      OrganismSelectForm.OrgQuery := IMSDM.TestOrgsByUseQuery;
      AdminOrgTableName:= 'EUORGANISMS';
      AdminNameTableName:='EUORGNAMES';
      BooksForm.BookQuery:=IMSDM.BooksByUseQuery;
      OrgNameSelectForm.DSQLDatasetN:='EUORGNAMES';
      OrgNameSelectForm.DSQLDatasetO:='EUORGANISMS';
      OrgNameReviewForm.NameQuery:=IMSDM.TestEUOrgNamesROQuery;   //read only
      OrganismEditForm.OrgQuery := IMSDM.TestEUOrgByCodeQuery;
      OrganismEditForm.NameQuery := IMSDM.TestEUNamesByOrgQuery;
      OrganismEditForm.RefQuery := IMSDM.TestEURefsByOrgQuery;
      OrganismEditForm.FindQuery := IMSDM.FindsByOrgQuery;
      BookRefsForm.RefQuery:=IMSDM.TestEURefsByBookQuery;
      PlantCardEditForm.CardQuery:=IMSDM.PlantCardQuery;
      FindsForm.FindQuery:=IMSDM.TestFindsByForayQuery;
      JPEditorForm.BooksQuery:=IMSDM.JapaneseBooksQuery;
      JPEditorForm.OrgQuery:=IMSDM.TestJPOrgsQuery;
      JPEditorForm.NameQuery:=IMSDM.TestJPNamesByOrgQuery;
      JPEditorForm.RefQuery:=IMSDM.TestJPRefsByBookPageQuery;
      JPEditorForm.OrgsByFamilyQuery:=IMSDM.TestOrgsByFamilyQuery;
    end
    else begin
      BooksForm.BookQuery:=IMSDM.BooksByUseQuery;
      OrganismSelectForm.OrgQuery := IMSDM.OrgsByUseQuery;
      AdminOrgTableName:='ORGANISMS';
      AdminNameTableName:='ORGNAMES';
      OrgNameSelectForm.DSQLDatasetN:='ORGNAMES';
      OrgNameSelectForm.DSQLDatasetO:='ORGANISMS';
      OrgNameReviewForm.NameQuery:=IMSDM.OrgNamesROQuery;     //read only
      OrganismEditForm.OrgQuery := IMSDM.OrgByCodeQuery;
      OrganismEditForm.NameQuery := IMSDM.NamesByOrgQuery;
      OrganismEditForm.RefQuery := IMSDM.RefsByOrgQuery;
      OrganismEditForm.FindQuery := IMSDM.FindsByOrgQuery;
      BookRefsForm.RefQuery:= IMSDM.RefsByBookQuery;
      PlantCardEditForm.CardQuery:=nil;                   //no data
      FindsForm.FindQuery:= IMSDM.FindsByForayQuery;
      JPEditorForm.BooksQuery:=IMSDM.BooksByUseQuery;
      JPEditorForm.OrgQuery:=IMSDM.AllOrganismsQuery;
      JPEditorForm.NameQuery:=IMSDM.NamesByOrgQuery;
      JPEditorForm.RefQuery:=IMSDM.RefsByBookPageQuery;
      JPEditorForm.OrgsByFamilyQuery:=IMSDM.OrgsByFamilyQuery;
    end;
    NewQuery:=true;
//fill list of families
    if FamilyList.Count=0 then
    begin
      with IMSDM.AllFamiliesQuery do
      begin
        open;
        while not eof do
        begin
          FamilyList.Add(Trim(FieldValues['FAMILYNAME'])+'='+FieldValues['FAMILYCODE']);
          Next;
        end;
        close;
      end;
      FamilyList.Sort;
    end;
end;

procedure TIMSHomeForm.SplitJPNamesExecute(Sender: TObject);
begin
  AdminForm.Mode:=EditNamesMode;
  AdminForm.ShowModal;
end;

procedure TIMSHomeForm.SplitString(InputString:ansistring;var OutputArray:array of ansistring;separator:ansistring);
//splits string of uses on separator "/" into an array of strings
var i,j,k,m,n:integer;
begin
    k:=pos(separator,InputString);     //separator
    j:=1;                              //current pos in input string
    i:=0;                              //pos in output array
    n:=Length(InputString);            //length of input string remaining to process
    m:=Length(separator);              //length of separator
    while k>0 do
    begin
      OutputArray[i]:=copy(InputString,j,k-1); //substring from current pos to before separator
      j:=j+k+m-1;   // move current pos past separator
      n:=n-k-m;     // cut length by length of substring and separator
      k:=pos('/',copy(InputString,j,n)); //locate next separator
      inc(i);
    end;
    OutputArray[i]:=copy(InputString,j,n);
end;

procedure TIMSHomeForm.TestRGClick(Sender: TObject);
begin
  SetEnvironment;
end;

function TIMSHomeForm.ValidOrgCode(ACode: string): ansistring;
//returns uppercase ansi version of code or blanks if not valid
var NewCode:ansistring;
begin
    NewCode := ansistring(ACode);
    if (ACode = String(NewCode)) and (Length(NewCode) > 0) and
      (Length(NewCode) < 9) then //check 1 to 8 ansi chars
    begin
      NewCode := UPPERCase(NewCode); // ensure upper case
      result:=NewCode;
    end
    else result:='        ';
end;

end.
