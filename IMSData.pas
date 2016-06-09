unit IMSData;

interface

uses
  SysUtils, Classes, DB, IB_Components,
  Dialogs, IB_Monitor, IB_Access, IB_Dialogs,
  OrganismConcepts, BookConcepts, ForayConcepts, IB_Session;

type
  TIMSDM = class(TDataModule)
    FBConnection: TIB_Connection;
    IMSTransaction: TIB_Transaction;
    RefsByOrgQuery: TIB_Query;
    RefsByOrgDS: TIB_DataSource;
    FindsByOrgDS: TIB_DataSource;
    FindsByForayQuery: TIB_Query;
    FindsByForayDS: TIB_DataSource;
    BooksByUseQuery: TIB_Query;
    BooksByUseDS: TIB_DataSource;
    AllForaysQuery: TIB_Query;
    AllForaysDS: TIB_DataSource;
    RefsByBookQuery: TIB_Query;
    RefsByBookDS: TIB_DataSource;
    OpenDialog1: TOpenDialog;
    FindsByOrgQuery: TIB_Query;
    AllEUPlantNames: TIB_Query;
    AllPlantsDS: TIB_DataSource;
    OrgByCodeQuery: TIB_Query;
    OrgByCodeDS: TIB_DataSource;
    OrgNamesDS: TIB_DataSource;
    OrgNamesROQuery: TIB_Query;
    MarkedBooksQuery: TIB_Query;
    RefsByBookPageQuery: TIB_Query;
    RefsByBookPageDS: TIB_DataSource;
    MarkedBooksDS: TIB_DataSource;
    BookByCodeQuery: TIB_Query;
    BookByCodeDS: TIB_DataSource;
    OrgsByNameQuery: TIB_Query;
    OrgsByNameQueryDS: TIB_DataSource;
    OrgsByGenusDS: TIB_DataSource;
    OrgsByGenusQuery: TIB_Query;
    FungalBooksQuery: TIB_Query;
    FungalBooksDS: TIB_DataSource;
    JapaneseBooksQuery: TIB_Query;
    JapaneseBooksDS: TIB_DataSource;
    AllOrganismsQuery: TIB_Query;
    FamilyByOrgQuery: TIB_Query;
    FamilyByOrgDS: TIB_DataSource;
    TestJPOrgsQuery: TIB_Query;
    GenusBySpeciesQuery: TIB_Query;
    GenusBySpeciesDS: TIB_DataSource;
    OrgsByFamilyQuery: TIB_Query;
    OrgsByFamilyDS: TIB_DataSource;
    Links: TIB_Query;
    AllOrganismsDS: TIB_DataSource;
    TestJPRefsQuery: TIB_Query;
    TestJPNamesByOrgQuery: TIB_Query;
    BookByShortCodeQuery: TIB_Query;
    BooksCursor: TIB_Cursor;
    FamilyByGenusQuery: TIB_Query;
    AllNamesDS: TIB_DataSource;
    AllFamiliesQuery: TIB_Query;
    AllFamiliesDS: TIB_DataSource;
    AllPageRefsQuery: TIB_Query;
    OrgsByUseQuery: TIB_Query;
    AllPlantsQuery: TIB_Query;
    AllEUPlantNamesDS: TIB_DataSource;
    TestEURefsQuery: TIB_Query;
    TestOrgsByUseQuery: TIB_Query;
    EuroBooksQuery: TIB_Query;
    OrgRefInSourceQuery: TIB_Query;
    AllLanguagesQuery: TIB_Query;
    AllLanguagesDS: TIB_DataSource;
    PlantCardQuery: TIB_Query;
    ForayByCodeQuery: TIB_Query;
    ForayByCodeDS: TIB_DataSource;
    orgNamesByLanguageQuery: TIB_Query;
    OrgNamesByLanguageDS: TIB_DataSource;
    NamesByOrgDS: TIB_DataSource;
    TestEUOrgByCodeQuery: TIB_Query;
    NamesByOrgQuery: TIB_Query;
    AllNamesQuery: TIB_Query;
    TestEUNamesByOrgLangQuery: TIB_Query;
    TestEUNamesByOrgQuery: TIB_Query;
    TestEUOrgsQuery: TIB_Query;
    TestEUNamesQuery: TIB_Query;
    TestEURefsByOrgQuery: TIB_Query;
    TestEUOrgNamesROQuery: TIB_Query;
    TestEURefsByBookQuery: TIB_Query;
    TestFindsByForayQuery: TIB_Query;
    TestorgsByFamilyQuery: TIB_Query;
    TestRefsbybookQuery: TIB_Query;
    TestJPRefsbybookPageQuery: TIB_Query;
    procedure MarkedBooksQueryBeforePost(IB_Dataset: TIB_Dataset);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    CanPostMarked:boolean;

    function GetEPPOCodeForNameString(ANameString:string):ansistring;
    function GetEPPOPrefNameForCode(ACode:ansistring):string;
    function GetFamily(speciescode:ansistring):ansistring;
    function GetGenus(speciescode:ansistring):ansistring;
    function getDistributionCount:integer;
    function GetForayByCode(foraycode:string;var AForay:TForay):boolean;
    function getSourceOrgRef(orgcode:ansistring;bookcode:string):string;
    function IsBookcode(bookcode:string):boolean;
    function IsShortBookcode(shortcode:string):boolean;
    function GetBookUseCode(AUseName:ansistring):ansistring;
    function NameNeedsAuthority(FullName:string):boolean;
    function GetOrgUseCode(AUseName:ansistring):ansistring;
    function OpenDatasetForOrg(Dataset:TIB_Query;eppocode:ansistring):boolean;
    function SelectFindsByForay(foraycode:ansistring):boolean;
    function SelectOrgsByName(searchname:string):boolean;
    function SelectFindsByOrg(eppocode:ansistring):boolean;
    procedure GetBookByCode(bookcode:string;var ABook:TBook);
    procedure GetBookByShortCode(shortcode:string;var ABook:TBook);
    procedure ExplicitDelete(IB_Dataset: TIB_Dataset);
    procedure ExplicitPost(IB_Dataset: TIB_Dataset);
end;

var IMSDM:TIMSDM;

implementation

{$R *.dfm}
uses Controls, Books, OrganismEdit,
IMSMain;

procedure TIMSDM.ExplicitDelete(IB_Dataset: TIB_Dataset);
begin
    CanPostMarked:=true;
    IB_Dataset.Delete;
end;

procedure TIMSDM.ExplicitPost(IB_Dataset: TIB_Dataset);
begin
// use to post record when automatic post is disabled. This could be
// eg to prevent premature posting in grids by clicking on line above or below
    CanPostMarked:=true;
    IB_Dataset.Post;
end;

procedure TIMSDM.GetBookByCode(bookcode:string;var ABook:TBook);
begin
  if ABook<>nil then
  with BookByCodeQuery do
  begin
    if active then close;
    ParamByName('BOOKCODE').value:=bookcode;
    prepare;
    open;
    if IsEmpty then ABook.Clear
    else ABook.ReadFromDataset(BookByCodeQuery);
  end;
end;

procedure TIMSDM.GetBookByShortCode(shortcode:string;var ABook:TBook);
begin
  if ABook<>nil then
  with BookByShortCodeQuery do
  begin
    ParamByName('SHORTCODE').value:=shortcode;
    prepare;
    open;
    if not IsEmpty then ABook.ReadFromDataset(BookByShortCodeQuery);
  end;
end;

function TIMSDM.GetDistributionCount:integer;
begin
    result:=0;
end;

function TIMSDM.GetEPPOCodeForNameString(ANameString:string):ansistring;
begin
  with TScientificName.Create do
  begin
    Fullname:=ANameString;
    result:=EPPOCode;
    Free;
  end;
end;

function TIMSDM.GetFamily(speciescode:ansistring):ansistring;
//returns family code from input org code
begin
  if (length(speciescode)>4) and (length(speciescode)<7) then
  begin
    with FamilyByOrgQuery do
    begin
      close;
      ParamByName('SPECIESCODE').value:=speciescode;
      prepare;
      open;
      if IsEmpty then result:=''
      else begin
        result:=FamilyByOrgQuery.FieldValues['FAMILYCODE'];
        if FamilyByOrgQuery.FieldValues['LEVEL']<>'F' then  //stop at family level
        begin
          if FamilyByOrgQuery.FieldValues['LEVEL']='S' then  //if subfamily found (last char = 'S') then try again
          with FamilyByGenusQuery do
          begin
            close;
            ParamByName('GENUSCODE').value:=result;
            prepare;
            open;
            if IsEmpty then result:=''
            else begin
              result:=FamilyByOrgQuery.FieldValues['FAMILYCODE'];
            end;
          end;
        end;
      end;
    end;
    if FamilyByOrgQuery.FieldValues['LEVEL']<>'F' then result:=''; //null
  end
  else result:='';     //invalid code
end;

function TIMSDM.GetEPPOPrefNameForCode(ACode:ansistring):string;
begin
  with TOrganism.Create do
  begin
    Orgcode:=ACode;
    result:=EPPOPrefName;
    Free;
  end;
end;


function TIMSDM.GetForayByCode(foraycode:string;var AForay:TForay):boolean;
begin
  with ForayByCodeQuery do
  begin
    if active then close;
    ParamByName('ForayCODE').value:=Foraycode;
    prepare;
    open;
    if IsEmpty then AForay.Clear
    else AForay.ReadFromDataset(ForayByCodeQuery);
  end;
  result:=not ForayByCodeQuery.IsEmpty;
end;

function TIMSDM.GetGenus(speciescode:ansistring):ansistring;
begin
  with GenusBySpeciesQuery do
  begin
    ParamByName('SPECIESCODE').value:=speciescode;
    prepare;
    open;
    if not IsEmpty then result:=GenusBySpeciesQuery.FieldValues['GENUSCODE']
    else result:='';
  end;
end;

function TIMSDM.getSourceOrgRef(orgcode:ansistring;bookcode:string):string;
//returns single reference value or page number for organism in source (book) eg Polunin number
begin
    result:='';
    with OrgRefInSourceQuery do
    begin
      ParamByName('ORGCODE').value:=orgcode;
      ParamByName('BOOKCODE').value:=bookcode;
      Prepare;
      Open;
      if not IsEmpty then
        if not fieldByName('RefCode').IsNull then result := fieldValues['RefCode']
        else result := fieldValues['PageNo'];
    end;
end;

function TIMSDM.IsBookcode(bookcode:string):boolean;
begin
    result:=false;
    with BooksCursor do            //make sure book exists
    begin
      try
        SQL.Clear;
        SQL.Add('Select bookcode from books where bookcode='+quotedstr(bookcode));
        Open;
        if not eof then result:=true;
      except
        on e:exception do ShowMessage('Error '+e.Message)
      end;
    end;
end;

function TIMSDM.IsShortBookcode(shortcode:string):boolean;
begin
    result:=false;
    with BooksCursor do            //make sure book exists
    begin
      try
        SQL.Clear;
        SQL.Add('Select shortcode from books where shortcode='+quotedstr(shortcode));
        Open;
        if (not eof) then result:=true;
      except
        on e:exception do ShowMessage('Error '+e.Message)
      end;
    end;
end;

function TIMSDM.GetBookUseCode(AUseName:ansistring):ansistring;
var i:smallint;
begin
   result:='';
   for i:=0 to BooksForm.BookUses.Count-1 do
      if BooksForm.BookUses[i].UseName=AUseName then result:=BooksForm.BookUses[i].UseCode;
end;

function TIMSDM.GetOrgUseCode(AUseName:ansistring):ansistring;
//looks up a single use in list and returns corresponding code or empty string
var i:smallint;
begin
   result:='';
   for i:=0 to IMSHomeForm.OrgUses.Count-1 do
      if IMSHomeForm.OrgUses[i].UseName=AUseName then result:=IMSHomeForm.OrgUses[i].UseCode;
end;

procedure TIMSDM.MarkedBooksQueryBeforePost(IB_Dataset: TIB_Dataset);
begin
    if not CanPostMarked then
    begin
      ShowMessage('Current source record cannot be updated by default; you must request a save with the save button, or cancel');
      Abort;
    end;
    CanPostMarked:=false;
end;

function TIMSDM.NameNeedsAuthority(FullName:string):boolean;
// authority is obligatory except for hybrids (contain ' x ') or varieties (contain quoted strings)
begin
  if (pos(' x ',FullName)=0) and (pos('''' ,FullName)=0) then result:=True
  else result :=false;
end;

function TIMSDM.OpenDatasetForOrg(Dataset:TIB_Query;eppocode:ansistring):boolean;
begin
 // general routine to open query based on eppocode, returns true if opened
  with Dataset do
  begin
    if ParamByName('ORGCODE')<>nil then
    begin
      if ParamByName('ORGCODE').value<>eppocode then
      begin
        close;
        ParamByName('ORGCODE').value:=eppocode;
      end;
      if not prepared then prepare;
      open;
      result:=true;
    end
    else result:=false;;
  end;
end;

function TIMSDM.SelectFindsByForay(foraycode:ansistring):boolean;
begin
  with FindsByForayQuery do
  begin
    ParamByName('FORAYCODE').value:=foraycode;
    prepare;
    open;
    result:=IsEmpty;
  end;
end;

function TIMSDM.SelectFindsByOrg(eppocode:ansistring):boolean;
begin
  with FindsByOrgQuery do
  begin
    ParamByName('ORGCODE').value:=eppocode;
    prepare;
    open;
    result:=IsEmpty;
  end;
end;

function TIMSDM.SelectOrgsByName(searchname:string):boolean;
var nameparam:string;
// return true if any name found
begin
  with OrgsByNameQuery do
  begin
    ParamByName('FULLNAME').value:=searchname;
    prepare;
    open;
    //if exact match not found, try as start of name
    if IsEmpty then
    begin
      close;
      nameparam:=searchname+'%';
      ParamByName('FULLNAME').value:=nameparam;
      prepare;
      open;
      result:=not IsEmpty;
    end
    else result:=true;
  end;
end;


end.
