unit EUDMain;

interface

uses
  Windows, Messages, SysUtils, Variants, VarUtils, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, FMTBcd, ADODB, Grids, DBGrids, DB, ComObj,
  DBClient, Provider, SqlExpr, StdCtrls, ExtCtrls, DBCtrls, Mask,
  ComCtrls, RecError,  Generics.Collections, OrganismConcepts, BookConcepts,
  IB_Components, IB_Access, IB_Grid, Excel2000, OleServer, IB_NavigationBar,
  ExcelXP;

type


  DataLine = record
    linenumber:integer;
    EPPT:ansistring;
    Orgcode:string;
    Language:string;
    lno:string;
    Fullname:string;
    Auth: string;
    Preferred:integer;
    Dis: string;
    Coste: string;
    Bry1: string;
    Ff: string;
    Bry2: string;
    Corse: string;
    Ker: string;
    Hegi: string;
    C_end: string;
    Polno: string;
    Family: string;
    Fr: boolean;
    Comments: string;
  end;

  EuroNameList = class(TOrgNames)
    function IndexOfName(aNameString:string):integer;
  end;

  EuroErrorList = class(TStringList)
    procedure Report(reportType,line:integer;value,reason:string);
  end;

  TReflist = class(TList<TPageRef>)
  private
    procedure FreeOnRemove(Sender: TObject; const Item: TPageRef; Action: TCollectionNotification);
  public
    constructor Create;
  end;

  EuroOrganism = class(TOrganism)
  private
    fNbSCInames:integer;
    fNbFRnames:integer;
    fNbENnames:integer;
    fNbNLnames:integer;
    fNbDEnames:integer;
    fNbITnames:integer;
    fNbESnames:integer;
    fNbCAnames:integer;
    fNbPTnames:integer;
    fNbSEnames:integer;
    fNbDAnames:integer;
    fNbPLnames:integer;
    fNbRUnames:integer;
    fRefList:TRefList;
    fSciNameList:EuroNameList;
    fFRNameList:EuroNameList;
    fENNameList:EuroNameList;
    fNLNameList:EuroNameList;
    fDENameList:EuroNameList;
    fITNameList:EuroNameList;
    fESNameList:EuroNameList;
    fCANameList:EuroNameList;
    fPTNameList:EuroNameList;
    fSENameList:EuroNameList;
    fDANameList:EuroNameList;
    fPLNameList:EuroNameList;
    fRUNameList:EuroNameList;
  public
    property nbSciNames:integer read fNbSCInames write fNbSCInames;
    property nbFRnames:integer read fNbFRnames write fNbFRnames;
    property nbENnames:integer read fNbENnames write fNbENnames;
    property nbNLnames:integer read fNbNLnames write fNbNLnames;
    property nbDENames:integer read fNbDEnames write fNbDEnames;
    property nbITnames:integer read fNbITnames write fNbITnames;
    property nbESnames:integer read fNbESnames write fNbESnames;
    property nbCANames:integer read fNbCANames write fNbCANames;
    property nbPTnames:integer read fNbPTnames write fNbPTnames;
    property nbSEnames:integer read fNbSEnames write fNbSEnames;
    property nbDANames:integer read fNbDAnames write fNbDAnames;
    property nbPLNames:integer read fNbPLnames write fNbPLnames;
    property nbRUnames:integer read fNbRUnames write fNbRUnames;
    property RefList:TRefList read fRefList write fRefList;
    property SciNameList:EuroNameList read fSciNameList write fSciNameList;
    property FRNameList:EuroNameList read fFRNameList write fFRNameList;
    property ENNameList:EuroNameList read fENNameList write fENNameList;
    property NLNameList:EuroNameList read fNLNameList write fNLNameList;
    property DENameList:EuroNameList read fDENameList write fDENameList;
    property ITNameList:EuroNameList read fITNameList write fITNameList;
    property ESNameList:EuroNameList read fESNameList write fESNameList;
    property CANameList:EuroNameList read fCANameList write fCANameList;
    property PTNameList:EuroNameList read fPTNameList write fPTNameList;
    property SENameList:EuroNameList read fSENameList write fSENameList;
    property DANameList:EuroNameList read fDANameList write fDANameList;
    property PLNameList:EuroNameList read fPLNameList write fPLNameList;
    property RUNameList:EuroNameList read fRUNameList write fRUNameList;
   constructor Create;
    destructor Destroy; override;
    function AddName(AName:TOrgName;ALanguage:ansistring):boolean;
    function GetRefcode(aSource:string):string;
    function IndexOfName(aNameString:string;ALanguage:ansistring):integer;
    function GetLanguageList(ALanguage:ansistring):EuroNameList;
    function PageRefExists(aBookcode,aRefcode:string;aPageNo:integer):boolean;
    procedure Clear;
  end;

  TEUMainForm = class(TForm)
    SkipPanel: TPanel;
    Label2: TLabel;
    SkipButton: TButton;
    SkipCountEdit: TEdit;
    BatchSetButton: TButton;
    BatchSizeEdit: TEdit;
    Label3: TLabel;
    CleanFamiliesButton: TButton;
    FamiliesQuery: TIB_Query;
    FamLinksQuery: TIB_Query;
    procedure BatchSetButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CleanFamiliesButtonClick(Sender: TObject);
    procedure BatchSizeEditChange(Sender: TObject);
  published
    ProcessButton: TButton;
    OpenInputDataDialog: TOpenDialog;
    DisplayInputButton: TButton;
    ChangeFileButton: TButton;
    Edit1: TEdit;
    DisplayOutputButton: TButton;
    Label1: TLabel;
    DataListBox: TListBox;
    ErrorListBox: TListBox;
    ShowErrorButton: TButton;
    UserModes: TRadioGroup;
    TableButtons: TRadioGroup;
    CloseDisplayButton: TButton;
    FindCodeButton: TButton;
    ZapButton: TButton;
    DataGrid: TIB_Grid;
    FindCodeValue: TEdit;
    EUDataSource: TIB_DataSource;
    InputDataGrid: TStringGrid;
    SQLNavigator: TIB_NavigationBar;
    procedure ProcessButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChangeFileButtonClick(Sender: TObject);
    procedure DisplayOutputButtonClick(Sender: TObject);
    procedure ShowErrorButtonClick(Sender: TObject);
    procedure TableButtonsClick(Sender: TObject);
    procedure CloseDisplayButtonClick(Sender: TObject);
    procedure ZapButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FindCodeButtonClick(Sender: TObject);
    procedure DisplayInputButtonClick(Sender: TObject);
    procedure InputDataGridClick(Sender: TObject);
    procedure UserModesClick(Sender: TObject);
    procedure SkipButtonClick(Sender: TObject);
    procedure SkipCountEditChange(Sender: TObject);
  private
    function CheckValidType:boolean;       // check valid data
    function CheckVarIsType( AVariant : OleVariant; const AVarType: TVarType ) :Boolean;
    procedure GetDataFieldHeadings;
    procedure ClearDataLine;
    procedure ProcessCommonName(Alangcode:ansistring;AlangCount:integer);
    procedure ProcessNames;
    procedure ProcessOrganism;
    procedure ProcessSciName(preferred:boolean);
    procedure ProcessRow;
    procedure ProcessReference(shortcode:string; fieldData:string;RefIsCode:boolean);
    function ReadDataLine(ARow:integer):integer;                                         // process line of data
    procedure RefreshData;
    procedure SaveReport;
    procedure UpdateOrganism;  // output data to mysql
    procedure UpdateNames(NameList:EuroNameList;Language:ansistring);
    procedure VerboseReport;
    procedure Zap(Dataset:TIB_Query);
    { Private declarations }
  public
    { Public declarations }
    TodaysDate:string;
    ExcelWorkbook :_workbook;
    ExcelWorksheet :_Worksheet;
    InputDataRange :ExcelRange;
    InputDataColCount:integer;
    InputDataRowCount:integer;
    FieldHeadings:array of string;
    currentOrg:EuroOrganism;
    currentBook:TBook;
    BatchSize:integer;
    SkipCount:integer;
    EUInData:DataLine;
    OrgUses:TOrgUses;
    RunNo:integer;
      nbLinesRead,nbOrganisms:integer;
    ProcessingActive:boolean;
  end;

const EuroError=0;
      EuroHeading=1;
      EuroInfo=2;

var
  EUMainForm: TEUMainForm;
  ErrorList:EuroErrorList;
  //Testing:boolean;

implementation

uses IMSData, IMSMain;

{$R *.dfm}


procedure TEUMainForm.BatchSizeEditChange(Sender: TObject);
begin
  BatchSizeEdit.Font.Color:=clBlack;
  BatchSetButton.Width:=120;
end;

procedure TEUMainForm.ChangeFileButtonClick(Sender: TObject);
var V:ExcelRange;
begin
  try
  if OpenInputDataDialog.Execute then
  begin
      edit1.text:=OpenInputDataDialog.Filename;
      if not Assigned(IMSHomeForm.ExcelApp) then IMSHomeForm.ExcelApp.Connect;
      ExcelWorkbook:=IMSHomeForm.ExcelApp.Workbooks.Open(edit1.text,false,true,EmptyParam,
                                              EmptyParam,EmptyParam,EmptyParam,
                                              EmptyParam,EmptyParam,EmptyParam,
                                              EmptyParam,EmptyParam,EmptyParam,
                                              EmptyParam,EmptyParam,LOCALE_USER_DEFAULT);
      ExcelWorksheet:=ExcelWorkbook.Worksheets[1] as _worksheet;
      // commented out lines are alternative version of range finding but could help avoid using a macro first
      //ExcelWorksheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
      V:=ExcelWorksheet.UsedRange[Locale_User_Default];
      // Get the value of the last row
      //InputDataRowCount := ExcelApp.ActiveCell.Row;
      InputDataRowCount := V.Rows.count;
      // Get the value of the last column
      //InputDataColCount := ExcelApp.ActiveCell.Column;
      InputDataColCount := V.Columns.count;
      InputDataRange:=ExcelWorksheet.Range['A1',ExcelWorksheet.Cells.Item[InputDataRowCount,InputDataColCount]];
      ProcessButton.Enabled:=true;
      DisplayInputButton.Enabled:=true;
      ShowErrorButton.Enabled:=false;
  end;
  except
    on exception do
    begin
        if Assigned(ExcelWorkbook) then
        begin
          ExcelWorkbook.Close(False, emptyparam,emptyparam,0);
        end;
        ExcelWorksheet:= nil;    //prevent Excel from going on running by unassigning all variables
        ExcelWorkbook:= nil;
    end;
  end;
end;

function TEUMainForm.CheckValidType: boolean;
//determine type of line and check validity
var valid:boolean; langno:string;len:integer;
begin
try
  valid:=true;
  //mandatory fields
  if UserModes.ItemIndex>1 then     //test mode
  begin
    if EUInData.Orgcode='' then   //Orgcode
    begin
      valid:=false;
      ErrorList.Report(EuroError,EUInData.linenumber,'Encountered ','Unknown code')
    end
    else
    if UserModes.ItemIndex=2 then ErrorList.Report(EuroInfo,EUInData.linenumber,'Encountered ',EUInData.Orgcode);
  end;
  if EUInData.Language='' then
  begin
    valid:=false ;
    ErrorList.Report(EuroError,EUInData.linenumber,'Language missing',EUInData.Orgcode);
  end;
  EUInData.Lno:=trim(EUInData.Lno);
  if (EUInData.Lno='') or (StrToIntDef(EUInData.Lno,99)=99) then
  begin
    ErrorList.Report(EuroError,EUInData.linenumber,'Lang no not numeric',EUInData.Orgcode);
    EUInData.Lno:='99';
  end;
  if EUInData.Fullname='' then   //name
  begin
    valid:=false ;
    ErrorList.Report(EuroError,EUInData.linenumber,'Name null',EUInData.Orgcode)
  end;
  if EUInData.Polno='' then            //book
  begin
    valid:=false ;
    ErrorList.Report(EuroError,EUInData.linenumber,'Polno null',EUInData.Orgcode)
  end;
  if (EUInData.Auth<>'') and (EUInData.Language<>'A') then    //author for common name
  begin
    valid:=false ;
    ErrorList.Report(EuroError,EUInData.linenumber,'Author for common name',EUInData.Orgcode)
  end;
  if (EUInData.Auth='') and (EUInData.Language='A') and IMSDM.NameNeedsAuthority(EUInData.Fullname) then    //author missing for scientific name
  begin
    valid:=false ;
    ErrorList.Report(EuroError,EUInData.linenumber,'Author missing for scientific name',EUInData.Orgcode)
  end;
  if (EUInData.Ker='K') and (EUInData.FR<>true) then    //in France (? for org not row)
  begin
    valid:=false ;
    ErrorList.Report(EuroError,EUInData.linenumber,'Presence in France inconsistent',EUInData.Orgcode)
  end;

  result:=valid;
except on e:exception do
  ShowMessage(e.Message+' at Orgcode '+EUInData.Orgcode+' line '+IntToStr(nblinesread));

end;
end;

function TEUMainForm.CheckVarIsType( AVariant : OleVariant; const AVarType: TVarType ) :Boolean;
var
   SourceType: TVarType;
begin
  SourceType:=TVarData(AVariant).VType;
  //the types are ole compatible
  if (AVarType and varTypeMask < varInt64) and (SourceType and varTypeMask < varInt64) then
    Result:=
    (SourceType=AVarType) or
    (VariantChangeTypeEx(TVarData(AVariant), TVarData(AVariant), VAR_LOCALE_USER_DEFAULT, 0, AVarType)=VAR_OK)
  else
  Result:=False; //Here you must process the variant pascal types like varString
end;

procedure TEUMainForm.CloseDisplayButtonClick(Sender: TObject);
begin
  if EUDataSource.DataSet.Modified then
    if MessageDlg('Save this change?',mtConfirmation,[mbYes,mbNo],0)=mrNo then
       EUDataSource.DataSet.Cancel else EUDataSource.DataSet.Post;
  ShowErrorButton.Visible:=true;
  ProcessButton.Visible:=true;
  DisplayInputButton.Visible:=true;
  UserModes.Visible:=true;
  DataListBox.Visible:=true;
  ErrorListBox.Visible:=true;
  DataGrid.Visible:=false;
  SQLNavigator.Visible:=false;
  CloseDisplayButton.Visible:=false;
  TableButtons.Visible:=false;
  ZapButton.Visible:=false;
end;




procedure TEUMainForm.DisplayInputButtonClick(Sender: TObject);
var ARow,ACol:integer;
begin
  if InputDataGrid.Visible then InputDataGrid.Visible:=false
  else begin
    InputDataGrid.RowCount:=100;
    InputDataGrid.ColCount:=InputDataColCount;
    InputDataGrid.Visible:=true;
    ARow:=1;
    while ARow<=InputDataRowCount do
    begin
      InputDataGrid.Cells[(0), (ARow - 1)] :=IntToStr(ARow);   //number lines
      for ACol:=1 to InputDataGrid.ColCount do
        InputDataGrid.Cells[(ACol - 1), (ARow - 1)] := InputDataRange.Cells.Item[ARow, ACol];  //display dataline
      if ARow=InputDataGrid.RowCount then
        if MessageDlg(IntToStr(ARow)+'rows read. Continue viewing input data?',mtConfirmation,[mbYes,mbCancel],0)=mrYes then
        begin
            //InputDataGrid.Visible:=false;
            InputDataGrid.RowCount:=InputDataGrid.RowCount+100;
            //InputDataGrid.Visible:=true;
        end
        else break;
      ARow:=ARow+1;
    end;
  end;
end;

procedure TEUMainForm.DisplayOutputButtonClick(Sender: TObject);
begin
  if UserModes.ItemIndex>1 then      //test data
  begin
    ShowErrorButton.Visible:=false;
    ProcessButton.Visible:=false;
    DisplayInputButton.Visible:=false;
    DataListBox.Visible:=false;
    ErrorListBox.Visible:=false;
    UserModes.Visible:=false;
    CloseDisplayButton.Visible:=true;
    TableButtons.Visible:=true;
    SQLNavigator.Visible:=true;
    ZapButton.Visible:=true;
    RefreshData;
    DataGrid.Visible:=true;
  end
  else ShowMessage('Cannot view live data');
end;

procedure TEUMainForm.FindCodeButtonClick(Sender: TObject);
var indx:integer;
begin
  if FindCodeValue.Text<>'' then
  begin
      indx:=DataListBox.Items.IndexOf('   number'+'='+FindCodeValue.Text);
      if indx>-1 then DataListBox.Itemindex:=indx;
  end;
end;

procedure TEUMainForm.FormActivate(Sender: TObject);
var FormatSettings:TFormatSettings; temp:string;
begin
  if ErrorList=nil then
  begin
   ErrorList:=EuroErrorList.Create;
   System.ReportMemoryLeaksOnShutdown:=true;
   ProcessButton.Enabled:=false;
   DisplayInputButton.Enabled:=false;
   RunNo:=0;
   GetLocaleFormatSettings(1036,FormatSettings);
   if FormatSettings.ShortDateFormat<>'yyyy-mm-dd' then
   begin
     temp:=FormatSettings.ShortDateFormat;
     FormatSettings.ShortDateFormat:='yyyy-mm-dd';
     TodaysDate:=DateToStr(Date,FormatSettings);
     FormatSettings.ShortDateFormat:=temp;
   end;
  end;
end;

procedure TEUMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    try
        if IMSDM.TestEUOrgsQuery.Active then IMSDM.TestEUOrgsQuery.Close;
        if IMSDM.TestEUNamesByOrgLangQuery.Active then IMSDM.TestEUNamesByOrgLangQuery.Close;
        if IMSDM.TestEUNamesQuery.Active then IMSDM.TestEUNamesQuery.Close;
        if IMSDM.TestEURefsQuery.Active then IMSDM.TestEURefsQuery.Close;
        if IMSDM.AllOrganismsQuery.Active then IMSDM.AllOrganismsQuery.Close;
        if IMSDM.OrgNamesByLanguageQuery.Active then IMSDM.OrgNamesByLanguageQuery.Close;
        if IMSDM.RefsByOrgQuery.Active then IMSDM.RefsByOrgQuery.Close;
      SaveReport;
      if currentOrg<>nil then FreeAndNil(CurrentOrg);
      if currentBook<>nil then FreeAndNil(currentBook);
// Close Excel
      try
        if Assigned(ExcelWorkbook) then
        begin
          ExcelWorkbook.Close(False, emptyparam,emptyparam,0);
        end;
      finally
        ExcelWorksheet:= nil;    //prevent Excel from going on running by unassigning all variables
        ExcelWorkbook:= nil;
        if Assigned(IMSHomeForm.ExcelApp) then IMSHomeForm.ExcelApp.Quit;
        IMSHomeForm.ExcelApp :=nil;
        Action:=caFree;
      end;
    finally
        FreeAndNil(ErrorList);    //need this or the file never closes, even with 'finally'
    end;
end;

procedure TEUMainForm.FormCreate(Sender: TObject);
begin
  OrgUses:=TOrgUses.Create;
end;

procedure TEUMainForm.FormDestroy(Sender: TObject);
begin
  OrgUses.Free;
end;

procedure TEUMainForm.GetDataFieldHeadings;
var i:integer;
begin
    SetLength(FieldHeadings,InputDataColCount+1);
    for i:=1 to InputDataColCount do
        FieldHeadings[i]:=InputDataRange.Cells.Item[1,i];
end;

procedure TEUMainForm.CleanFamiliesButtonClick(Sender: TObject);
var i:integer;famcode:ansistring;
begin
  FamiliesQuery.Open;
  FamLinksQuery.Open;   //links with code = 1xxxF
  while not FamLinksQuery.Eof do   //run through file
  begin
    famcode:= FamLinksQuery.FieldValues['CODE'];
    if FamiliesQuery.Locate('FAMILYCODE',famcode,[],1) then
    begin
      if FamiliesQuery.FieldValues['FAMILYNAME']='' then
      begin
        FamiliesQuery.Edit;
        FamiliesQuery.FieldValues['FAMILYNAME']:=IMSDM.GetEPPOPrefNameForCode(famcode);  //name from lookup in EPPT
        FamiliesQuery.Post;
      end
    end
    else begin //if family code not found
      FamiliesQuery.Insert;               //insert in Families table
      FamiliesQuery.FieldValues['FAMILYCODE']:=FamLinksQuery.FieldValues['CODE']; //code from Links
      FamiliesQuery.FieldValues['FAMILYNAME']:=IMSDM.GetEPPOPrefNameForCode(famcode);  //name from lookup in EPPT
      FamiliesQuery.Post;
    end;
    FamLinksQuery.Next;
  end;
end;

procedure TEUMainForm.ClearDataLine;
begin
    EUInData.linenumber:=0;
    EUInData.EPPT:='';
    EUInData.Orgcode:='';    //clear input data line
    EUInData.Language:='';
    EUInData.Lno:='';
    EUInData.Fullname:='';
    EUInData.Auth:='';
    EUInData.Preferred:=0;
    EUInData.Dis:='';
    EUInData.Coste:='';
    EUInData.BRY1:='';
    EUInData.Ff :='';
    EUInData.BRY2 :='';
    EUInData.Corse :='';
    EUInData.Ker :='';
    EUInData.Hegi :='';
    EUInData.C_end:='';
    EUInData.Polno :='';
    EUInData.Family :='';
    EUInData.Fr :=false;
    EUINData.Comments :='';
  end;

procedure TEUMainForm.InputDataGridClick(Sender: TObject);
begin
    InputDataGrid.Visible:=false;
end;

procedure TEUMainForm.ProcessButtonClick(Sender: TObject);
var ARow,ACol:integer;
begin
   if currentOrg=nil then currentOrg:=EuroOrganism.Create
   else currentOrg.Clear;
   if currentBook=nil then currentBook:=TBook.Create
   else currentBook.Clear;
   DataGrid.Visible:=false;
   ErrorListBox.Clear;
   ErrorList.Clear;
   nbOrganisms:=0;
   nbLinesRead:=1;            // data lines numbered from 2
  try
    ProcessingActive:=true;
    ErrorList.Report(EuroHeading,0,'European Plant Data processing started ',DateTimeToStr(Now));
    inc(RunNo);
    GetDataFieldHeadings;        //col headings from first line
    for ARow:= 2 to InputDataRowCount do
    begin
        ClearDataLine;
        if ReadDataLine(ARow)>0 then
          if ARow>SkipCount then
            ProcessRow;
        if not ProcessingActive then break;    //processing switched off by user
    end;
    if ProcessingActive then
    begin
      ProcessOrganism;  // last org
      ShowMessage('End of data reached successfully');
    end;
    ShowMessage('Read '+IntToStr(nbLinesRead)+' lines for '+IntToStr(nbOrganisms)+' organisms');
    ErrorList.Report(EuroHeading,0,'European Plant Data processing finished ',DateTimeToStr(Now));
    ShowErrorButton.Enabled:=true;
    ShowErrorButton.Click;
  except
    on e:exception do ShowMessage('Error '+e.Message+' on record '+intToStr(nblinesread));
  end;
end;

procedure TEUMainForm.ProcessCommonName(ALangcode:ansistring;AlangCount:integer);
var AName:TOrgName;
begin
    AName:=TOrgName.Create(currentOrg.Orgcode,EUInData.Fullname,ALangcode);
    if currentOrg.AddName(AName,ALangcode) then  //returns true if added
      AlangCount:=AlangCount+1
    else begin
      ErrorList.Report(EuroError,EUInData.Linenumber,currentOrg.Orgcode,'Duplicate '+ALangcode+' name');
      AName.Free;  //get rid of unwanted name
    end;
end;


procedure TEUMainForm.ProcessNames;   //add names to appropriate list
var lInt:integer;
    ILanguage:Char;  //input language
begin
    ILanguage := EUInData.Language[1];
    if (EUInData.Lno='') then    //if Language number missing
          if (currentOrg.preferredname='') then lInt:=0 //if no preferred name yet, treat as preferred
          else lInt:=currentOrg.nbSciNames  //otherwise use name count
    else lInt:=StrToInt(EUInData.Lno);
    case  ILanguage of
          'A': ProcessSciName(lInt=0);     //scientific name
          //non-scientific names
          'B':
          begin
              ProcessCommonName('fr',currentOrg.nbFRNames);
          end;
          'C':
          begin
              ProcessCommonName('en',currentOrg.nbENNames);
          end;
          'D':
          begin
              ProcessCommonName('nl',currentOrg.nbNLNames);
          end;
          'E':
          begin
              ProcessCommonName('de',currentOrg.nbDENames);
          end;
          'F':
          begin
              ProcessCommonName('it',currentOrg.nbITNames);
          end;
          'G':
          begin
              ProcessCommonName('es',currentOrg.nbESNames);
          end;
          'H':
          begin
              ProcessCommonName('pt',currentOrg.nbPTNames);
          end;
          'I':
          begin
              ProcessCommonName('se',currentOrg.nbSENames);
          end;
          'J':
          begin
              ProcessCommonName('ca',currentOrg.nbCANames);
          end;
          'K':
          begin
              ProcessCommonName('ru',currentOrg.nbRUNames);
          end;
          'L':
          begin
              ProcessCommonName('pl',currentOrg.nbPLNames);
          end;
          'M':
          begin
              ProcessCommonName('da',currentOrg.nbDANames);
          end;
        end;
end;

procedure TEUMainForm.ProcessOrganism;
begin
     //check mandatory elements present
     inc(nbOrganisms);
     if currentOrg.Family='' then ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'no Family code');
     if currentOrg.preferredName='' then
       ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'no preferred name');
    // if currentOrg.RefList.Count=0 then ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'no page references');
     UpdateOrganism; //in test mode add Comments to output, live - write old org data to output
     currentorg.Clear;
     if (BatchSize>0) and (nbOrganisms mod BatchSize = 0) then  //avoid losing server (error 10055) by pausing
     begin
      SaveReport;
      if MessageDlg('Reached record '+IntToStr(nbOrganisms)+'. Carry on?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
         ProcessingActive:=false;
     end;
end;

procedure TEUMainForm.ProcessRow;   // start processing data line
begin
    //processing loop for each line of data
    inc(nbLinesRead);
    if EUInData.linenumber=0 then EUInData.linenumber:=nbLinesRead; //put in line count for test modes
    if CheckValidType then
    begin
      if currentOrg.Orgcode<>EUInData.Orgcode then  // start a new organism
      begin
        if currentOrg.Orgcode>''  then  ProcessOrganism;   //if not the first finish organism
        // initialise values for new organism
        currentOrg.Orgcode:=EUInData.Orgcode;  //code
      end;
      //names
      ProcessNames;
      //Family
      if EUInData.Family>'' then
        if (currentOrg.Family='') then currentOrg.Family:=EUInData.Family //normalise family
        else if (currentOrg.Family<>EUInData.Family) then
            ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'multiple Family codes');
      if EUInData.Polno>'' then
        if (currentOrg.Polno='') then currentOrg.Polno:=EUInData.Polno
        else if (currentOrg.Polno<>EUInData.Polno) then
            ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'multiple Polno codes');
      // references
      ProcessReference('Coste',EUInData.Coste,true);
      ProcessReference('Ker',EUInData.Ker,true);
      ProcessReference('Bry1',EUInData.Bry1,true);
      ProcessReference('Bry2',EUInData.Bry2,false);
      ProcessReference('Ff',EUInData.Ff,true);
      ProcessReference('Hegi',EUInData.Hegi,true);
      ProcessReference('Corse',EUInData.Corse,false);
      if (UserModes.ItemIndex>1) and (EUInData.Comments>'') then currentOrg.Comments:=EUInData.Comments;
      // end of processing loop for valid lines
    end
    else if (UserModes.ItemIndex>1) and (EUInData.Comments>'') then ErrorList.Report(EuroHeading,EUInData.linenumber,currentOrg.Orgcode,currentOrg.Comments);      //invalid lines
end;

procedure TEUMainForm.ProcessReference(shortcode:string;fieldData:string;RefIsCode:boolean);
var CurrentValue:string;
begin
      if (fieldData<>'') then
      begin
        currentBook.Clear;
        IMSDM.GetBookByShortCode(shortcode,currentBook);   //recover bookcode corresponding to shortcode
        if Currentbook.IsEmpty then
              ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'source code '+shortcode+' not found')
        else begin
          if RefIsCode=true then  //Refcode must be consistent while page numbers need not be unique
          begin
            CurrentValue:= currentOrg.getRefcode(currentBook.bookcode);
            if CurrentValue = '' then             //create reference
              currentOrg.RefList.Add(TPageRef.Create(currentOrg.Orgcode,currentBook.bookcode,fieldData))
            else if CurrentValue<>fieldData then  //ensure consistency with previous entries
                ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'source '+shortcode+' has different reference values')
          end
          else currentOrg.RefList.Add(TPageRef.Create(currentOrg.Orgcode,currentBook.bookcode,StrToInt(fieldData)));
        end;
      end;
end;

procedure TEUMainForm.ProcessSciName(preferred:boolean);
var prefname:TScientificName; i:integer;
begin
   if preferred then  //this is supposed to be the preferred name
   begin
      i:= currentOrg.IndexOfName(EUInData.Fullname,'la'); //exists already?
      if i>=0 then     //ignore duplicate names
      begin
        prefName:=TScientificName(currentOrg.SciNameList[i]);    //get this name
        if prefName.author='' then prefName.author:=EUInData.Auth //insert author if not there
        else if (EUInData.Auth>'') and (prefName.author<>EUInData.Auth) then
            ErrorList.Report(EuroError,EUInData.linenumber,prefName.Fullname,'different author for preferred name');
        if not prefName.preferred then     //not marked as pref
            ErrorList.Report(EuroError,EUInData.linenumber,prefName.Fullname,'different preferred names');
      end
      else begin          //insert preferred name
        currentOrg.SciNameList.Add(TScientificName.Create(currentOrg.Orgcode,true,EUInData.Fullname,'la',EUInData.Auth));
        currentOrg.nbSciNames:=currentOrg.nbSciNames+1;
      end;
      currentOrg.PreferredName:=EUInData.Fullname;
   end
   else begin                                      //scientific synonym
        if currentOrg.IndexOfName(EUInData.Fullname,'la')<0 then     //ignore duplicate names
        begin     //no need to check l because order of synonyms doesn't matter
            currentOrg.SciNameList.Add(TScientificName.Create(currentOrg.Orgcode,false,EUInData.Fullname,'la',EUInData.Auth));
            currentOrg.nbSciNames:=currentOrg.nbSciNames+1;
        end
   end;
end;

function TEUMainForm.ReadDataLine(ARow:integer):integer;
var ACol,NbValues:integer; val:OLEVariant;
begin
//fill line with values
try
  NbValues:=0;
  for ACol:=1 to InputDataColCount do
  begin
   Val:= InputdataRange.Cells.Item[ARow,ACol];
   if not VarIsNull(Val) then
   begin
    Inc(NbValues);
    if CheckVarIsType(Val,varOleStr) then Val:=trim(Val);

    if FieldHeadings[acol]='linenumber' then
    begin
          if UserModes.ItemIndex>1 then EUInData.Comments:=Val //show notes in test date
          else EUInData.linenumber:=Val
    end
    else if FieldHeadings[acol]='eppt' then EUInData.EPPT:=Val
    else if FieldHeadings[acol]='POLNO' then EUInData.Polno:=Val
    else if FieldHeadings[acol]='CODE' then EUInData.Orgcode:=ansistring(Val)
    else if FieldHeadings[acol]='L' then EUInData.Language:=Val
    else if FieldHeadings[acol]='LN' then EUInData.Lno:=Val
    else if FieldHeadings[acol]='Name' then EUInData.FullName:=Val
    else if FieldHeadings[acol]='AUTH' then EUInData.Auth:=Val
    else if FieldHeadings[acol]='PREFERRED' then EUInData.Preferred:=Val
    else if FieldHeadings[acol]='FAM' then EUInData.Family:='1'+Val+'F'
    else if FieldHeadings[acol]='COSTE' then EUInData.Coste:=Val
    else if FieldHeadings[acol]='B1' then EUInData.Bry1:=Val
    else if FieldHeadings[acol]='FF' then EUInData.Ff:=Val
    else if FieldHeadings[acol]='B2' then EUInData.Bry2:=Val
    else if FieldHeadings[acol]='Corse' then EUInData.Corse:=Val
    else if FieldHeadings[acol]='fr' then
          begin
            if CheckVarIsType(Val,varBoolean) then EUInData.fr:=Val
            else ErrorList.Report(EuroError,nbLinesRead+1,'Presence in France not boolean',EUInData.Orgcode);
          end
    else if FieldHeadings[acol]='K' then EUInData.Ker:=Val
    else if FieldHeadings[acol]='Hegi' then EUInData.Hegi:=Val
    else if FieldHeadings[acol]='C_end' then EUInData.C_end:=Val
    else if FieldHeadings[acol]='DIS' then EUInData.Dis:=Val
    else if MessageDlg('Unknown column: '+FieldHeadings[acol],mtError,[mbOK,mbAbort],0)=mrAbort then
         ProcessingActive:=false;
   end;
  end;
  except
    on e:exception do
      ErrorList.Report(EuroError,EUInData.linenumber,currentOrg.Orgcode,'Error '+e.message+' encountered during data read')
  end;
  result:=NbValues;
end;

procedure TEUMainForm.RefreshData;
begin
  if (UserModes.ItemIndex>1) then               //test data
  begin
    EUDataSource.DataSet.Close;      //close old
    if TableButtons.ItemIndex=0 then
    begin
      EUDataSource.Dataset:=IMSDM.TestEUOrgsQuery;
      IMSDM.TestEUOrgsQuery.Close;
      //IMSDM.TestEUOrgsQuery.Params[0].Value:='%';     //no params here
    end;
    if TableButtons.ItemIndex=1 then EUDataSource.Dataset:=IMSDM.TestEUNamesQuery;
    if TableButtons.ItemIndex=2 then EUDataSource.Dataset:=IMSDM.TestEURefsQuery;
    if TableButtons.ItemIndex=3 then EUDataSource.Dataset:=IMSDM.EUROBooksQuery;
    EUDataSource.DataSet.Open;
  end
  else ShowMessage('Cannot view live data');
end;


procedure TEUMainForm.SaveReport;
var Month,Day,Hour,Min,aWord:word;
begin
    if assigned(ErrorList) then
    begin
      DecodeDate(Date,aWord,Month,Day);
      DecodeTime(Time,Hour,Min,aWord,aWord);
      ErrorList.SaveToFile('EuroErrorList_'+Format('%.2u%.2u_%.2u%.2u_%u',[Month,Day,Hour,Min,RunNo])+'.txt',TEncoding.UTF8);
    end;
end;

procedure TEUMainForm.ShowErrorButtonClick(Sender: TObject);
begin
  ErrorListBox.Visible:=true;
  DataGrid.Visible:=false;
  if assigned(ErrorList) then
      ErrorListBox.Items:=ErrorList;
end;

procedure TEUMainForm.SkipButtonClick(Sender: TObject);
begin
  SkipCount:= strToInt(SkipCountEdit.Text);
  SkipCountEdit.Font.Color:=clRed;
end;

procedure TEUMainForm.TableButtonsClick(Sender: TObject);
begin
    if (UserModes.ItemIndex>1) then RefreshData    //test data or books
    else ShowMessage('Cannot view live data');
end;

procedure TEUMainForm.UpdateOrganism;
var
    currentName:TScientificName;
    currentRef:TPageRef;
    i:integer;
    oldOrg:TOrganism;
    OrgFound:boolean;
    differences:string;
    RefQuery:TIB_Query;
begin
  try
  // basic organism data
   if (UserModes.ItemIndex=2) then VerboseReport      //verbose report for testing
   else if (UserModes.ItemIndex>0) then               //exclude data validation mode
   //write basic organism data to database
   begin
      currentOrg.AddUse('Europe');           //compulsory field
      if (UserModes.ItemIndex=3) then        //test data
      begin
        if IMSDM.TestEUOrgByCodeQuery.Active then IMSDM.TestEUOrgByCodeQuery.Close;
        IMSDM.TestEUOrgByCodeQuery.Params[0].Value:=currentOrg.Orgcode;
        IMSDM.TestEUOrgByCodeQuery.Open;
        if IMSDM.TestEUOrgByCodeQuery.IsEmpty then OrgFound:=false
        else begin
          OrgFound:=true;
          if MessageDlg('Entry for '+currentOrg.Orgcode+' is already in test database. Continue?',
              mtWarning,[mbYes,mbAbort],0)<>mrYes then
                ProcessingActive:=false;
        end;
        //for test data organism is either new (insert) or not (ignore) i.e. no updating of basic info
        if not OrgFound then
        begin
          IMSDM.TestEUOrgsQuery.Append;
          currentOrg.writeBasicToDataset(IMSDM.TestEUOrgsQuery)
        end;
      end
      else begin                 // live data
        if IMSDM.OrgByCodeQuery.Active then IMSDM.OrgByCodeQuery.Close;
        OrgFound:=false;
        IMSDM.OrgByCodeQuery.Params[0].Value:=currentOrg.Orgcode;
        IMSDM.OrgByCodeQuery.Open;
        if IMSDM.OrgByCodeQuery.IsEmpty then IMSDM.OrgByCodeQuery.Append  //insert new org
        else begin                   //organism exists in DB
            oldOrg:=TOrganism.Create;
            try
              oldOrg.readBasicFromDataset(IMSDM.OrgByCodeQuery); //get existing record
              differences:= currentOrg.Compare(oldOrg);
              // for live data record can be updated
              if length(differences)>0 then  //otherwise record is a duplicate
                if MessageDlg(currentOrg.Orgcode+': Merge new data for '+differences+' with existing record?',
                 mtConfirmation,[mbYes,mbNo],0)=mrYes then
                begin
                  currentOrg.mergeFrom(oldOrg);
                  IMSDM.OrgByCodeQuery.Edit;
                  currentOrg.writeBasicToDataset(IMSDM.OrgByCodeQuery);
                end;
            finally
              oldOrg.Free;
            end;
        end;
      end;
   end;
   if ProcessingActive then                //user may have aborted after error
   begin
   //update names
    if (UserModes.ItemIndex<>2) then        //all modes except verbose, test process names against existing data
    begin
      UpdateNames(currentOrg.SciNameList,'la');
      UpdateNames(currentOrg.FRNameList,'fr');
      UpdateNames(currentOrg.ENNameList,'en');
      UpdateNames(currentOrg.NLNameList,'nl');
      UpdateNames(currentOrg.DENameList,'de');
      UpdateNames(currentOrg.ITNameList,'it');
      UpdateNames(currentOrg.ESNameList,'es');
      UpdateNames(currentOrg.CANameList,'ca');
      UpdateNames(currentOrg.PTNameList,'pt');
      UpdateNames(currentOrg.SENameList,'se');
      UpdateNames(currentOrg.DANameList,'da');
      UpdateNames(currentOrg.PLNameList,'pl');
      UpdateNames(currentOrg.RUNameList,'ru');
    end;
    if (UserModes.ItemIndex=1) or (UserModes.ItemIndex=3) then   //data insertion modes, process refs
    begin
    //update references
      if (UserModes.ItemIndex=3) then RefQuery:=IMSDM.TestEURefsByOrgQuery    //test data refs
      else RefQuery:= IMSDM.RefsByOrgQuery;
      RefQuery.Close;
      RefQuery.ParamByName('ORGCODE').Value:=currentOrg.Orgcode;
      RefQuery.Open;
      for i:=0 to currentOrg.RefList.Count - 1 do
      begin
        currentRef:=currentOrg.RefList[i];
        if not RefQuery.Locate('BOOKCODE;REFCODE;PAGENO',VarArrayOf([currentRef.bookcode,currentRef.refcode,currentRef.pageno]),[lopCaseInsensitive],1) then
        begin
          RefQuery.Insert;
          currentRef.writeToDataset(RefQuery);
        end;
      end;
    end;
   end;
  except
    on e:exception do ShowMessage('SQL error '+e.message);
  end;
end;

procedure TEUMainForm.UserModesClick(Sender: TObject);
begin
end;

procedure TEUMainForm.UpdateNames(NameList:EuroNameList;Language:ansistring);
// update names (does not apply to index 2 verbose)
// input : list of names of a specific language; language code
var existingName:TOrgName;
    i:integer;
    currentName:TScientificName;
    currentRef:TPageRef;
    differences:string;
    NameQuery:TIB_Query;
begin
   existingName:=TOrgName.Create;
   if (UserModes.ItemIndex=3) then   //open Test DB
      NameQuery:=IMSDM.TestEUNamesByOrgLangQuery
   else NameQuery:= IMSDM.OrgNamesByLanguageQuery;
   if NameQuery.Active then NameQuery.Close;
   //get organism's existing names and eliminate/report duplicates
   NameQuery.ParamByName('Orgcode').Value:=currentOrg.Orgcode;
   NameQuery.ParamByName('Language').Value:=Language;
   NameQuery.Prepare;
   NameQuery.Open();
   while not NameQuery.eof do
   begin
      existingName.Clear;
      existingName.readFromDataset(NameQuery); //get existing record
      i:=0;
      while i< NameList.Count do         //compare all names
      begin
        currentName:=TScientificName(NameList[i]);
        differences:=existingName.Compare(currentName);
        if length(differences)=0 then   //exact match means duplicate name so ignore except validation only
        begin
          {if (UserModes.ItemIndex=0) then   //Data validation
          ErrorList.Report(EuroInfo,EUInData.linenumber,'name already in database',  currentName.Fullname);  }
          NameList.Delete(i);  //ignore identical name for other modes
        end
        else begin //other differences
          //fullname has to be unique so name data must be merged if fullnames are the same
          if pos('Fullname',differences)=0 then //fullname the same
          begin
            if (UserModes.ItemIndex=0) then     //for validation only  report situation
            begin
               //ErrorList.Report(EuroInfo,EUInData.linenumber,'name differs from database by '+differences,  currentName.Fullname);
            end
            else begin //if same fullname found and only difference is an author where there was none, or user says go ahead
              if ((differences='Author')  and (TScientificName(existingName).Author='')) or (MessageDlg(currentOrg.Orgcode+': new data for '+currentName.Fullname+
              ' has differences in '+differences+'. Merge with existing?',mtWarning,[mbYes,mbNo],0)=mrYes) then
              begin //merge new data with existing
                existingName.MergeFrom(currentName);
                existingName.EditStatus:='M';
                NameQuery.Edit;
                if existingName.IsScientific then
                  TScientificName(existingName).writeToDataset(NameQuery)
                else existingName.WriteToDataSet(NameQuery);
              end
            end;
            NameList.Delete(i);
          end
          else inc(i);    //look at next name if name is not same
        end;
      end;
      NameQuery.Next;
   end;
   //insert the rest (new) names
   if (UserModes.ItemIndex>0) then       //live run
      //write remaining names to dataset
      for i:=0 to NameList.Count-1 do
      begin
              currentName:=TScientificName(NameList[i]);
              NameQuery.Append;
              currentName.EditStatus:='N';
              if currentName.IsScientific then
                (currentName as TScientificName).writeToDataset(NameQuery)
              else currentName.writeToDataset(NameQuery);
      end;
   existingName.Free;
end;

procedure TEUMainForm.VerboseReport;
var currentName:TScientificName;
    i:integer;
    currentRef:TPageRef;

    procedure DisplayNames(NameList:EuroNameList);
    var i:integer;
    begin
      for i:=0 to NameList.Count-1 do
      begin
        currentName:=TScientificName(NameList[i]);
        ErrorList.Report(EuroInfo,EUInData.linenumber,currentName.Fullname,currentName.LanguageCode);
      end;
    end;
begin
      ErrorList.Report(EuroHeading,EUInData.linenumber,'Results for',currentOrg.Orgcode);
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Expected', currentOrg.Comments);
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Family', currentOrg.Family);
      ErrorList.Report(EuroHeading,EUInData.linenumber,currentOrg.Orgcode, 'Names');
      ErrorList.Report(EuroInfo,EUInData.linenumber,'scientific', IntToStr(currentOrg.nbSciNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'French', IntToStr(currentOrg.nbFRNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'English', IntToStr(currentOrg.nbENNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Dutch', IntToStr(currentOrg.nbNLNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'German', IntToStr(currentOrg.nbDENames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Italian', IntToStr(currentOrg.nbITNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Spanish', IntToStr(currentOrg.nbESNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Catalan', IntToStr(currentOrg.nbCANames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Portuguese', IntToStr(currentOrg.nbPTNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Swedish', IntToStr(currentOrg.nbSENames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Danish', IntToStr(currentOrg.nbDANames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Polish', IntToStr(currentOrg.nbPLNames));
      ErrorList.Report(EuroInfo,EUInData.linenumber,'Russian', IntToStr(currentOrg.nbRUNames));
      for i:=0 to currentOrg.SciNameList.Count-1 do
      begin
        currentName:=TScientificName(currentOrg.SciNameList[i]);
        ErrorList.Report(EuroInfo,EUInData.linenumber,currentName.Fullname,currentName.LanguageCode);
        ErrorList.Report(EuroInfo,EUInData.linenumber,'Author',(currentName as TScientificName).author);
      end;
      DisplayNames(currentOrg.FRNameList );
      DisplayNames(currentOrg.ENNameList );
      DisplayNames(currentOrg.NLNameList );
      DisplayNames(currentOrg.DENameList );
      DisplayNames(currentOrg.ITNameList );
      DisplayNames(currentOrg.ESNameList );
      DisplayNames(currentOrg.CANameList );
      DisplayNames(currentOrg.PTNameList );
      DisplayNames(currentOrg.SENameList );
      DisplayNames(currentOrg.DANameList );
      DisplayNames(currentOrg.PLNameList );
      DisplayNames(currentOrg.RUNameList );

      ErrorList.Report(EuroHeading,EUInData.linenumber,currentOrg.Orgcode, 'Page Refs');
      for i:=0 to currentOrg.RefList.Count - 1 do
      begin
        currentRef:=currentOrg.RefList[i];
        ErrorList.Report(EuroInfo,EUInData.linenumber,'Book',currentRef.bookcode);
        ErrorList.Report(EuroInfo,EUInData.linenumber,'Page',IntToStr(currentRef.pageno));
        ErrorList.Report(EuroInfo,EUInData.linenumber,'Refcode',currentRef.refcode);
      end;
      ErrorList.Report(EuroHeading,EUInData.linenumber,currentOrg.Orgcode, 'End of output');

end;

procedure TEUMainForm.Zap(Dataset:TIB_Query);
begin
     if not Dataset.Active then Dataset.Open;
     begin
        Dataset.First;
        while not Dataset.eof do Dataset.Delete;
     end;
end;



procedure TEUMainForm.ZapButtonClick(Sender: TObject);
begin
  if (UserModes.ItemIndex>1) then               //clear test data only
  begin
    if MessageDlg('Are you sure? You will lose ALL the data (except the book codes)!',
        mtWarning,[mbYes,mbNo],0) = mrYes then
    try
     Zap(IMSDM.TestEUNamesQuery);
     Zap(IMSDM.TestEURefsQuery);
     Zap(IMSDM.TestEUOrgsQuery);
     RefreshData;
    except
      on e:exception do ShowMessage('Database could not be emptied. Error was '+e.Message);
    end
  end
  else
    ShowMessage('Cannot zap live data; function only available in test version');
end;

procedure EuroErrorList.Report(reportType,line:integer;value,reason:string);
begin
  if reportType=EuroError then Add('***Error  at line '+IntToStr(line)+'    '+value+': '+reason)
  else if reportType=EuroHeading then Add('------------ '+value+'='+reason+' ------------')
  else Add('    '+value+'='+reason);
end;


constructor EuroOrganism.Create;
begin
  inherited;
  Orgcode:='';
  Family:='';
  fNbscinames:=0;
  fNbFRnames:=0;
  fNbENnames:=0;
  fNbNLnames:=0;
  fNbDEnames:=0;
  fNbITnames:=0;
  fNbESnames:=0;
  fNbCANames:=0;
  fNbPTnames:=0;
  fNbSEnames:=0;
  fNbDAnames:=0;
  fNbPLNames:=0;
  fNbRUnames:=0;
  fSciNameList:=EuroNameList.Create;
  fFRNameList:=EuroNameList.Create;
  fENNameList:=EuroNameList.Create;
  fNLNameList:=EuroNameList.Create;
  fDENameList:=EuroNameList.Create;
  fITNameList:=EuroNameList.Create;
  fESNameList:=EuroNameList.Create;
  fCANameList:=EuroNameList.Create;
  fPTNameList:=EuroNameList.Create;
  fSENameList:=EuroNameList.Create;
  fDANameList:=EuroNameList.Create;
  fPLNameList:=EuroNameList.Create;
  fRUNameList:=EuroNameList.Create;
  fRefList:=TRefList.Create;
end;


destructor EuroOrganism.Destroy;
begin
    fSciNameList.Clear;
    fFRNameList.Clear;
    fENNameList.Clear;
    fNLNameList.Clear;
    fDENameList.Clear;
    fITNameList.Clear;
    fESNameList.Clear;
    fCANameList.Clear;
    fPTNameList.Clear;
    fSENameList.Clear;
    fDANameList.Clear;
    fPLNameList.Clear;
    fRUNameList.Clear;
    fRefList.Clear;
    fSciNameList.Free;
    fFRNameList.Free;
    fENNameList.Free;
    fNLNameList.Free;
    fDENameList.Free;
    fITNameList.Free;
    fESNameList.Free;
    fCANameList.Free;
    fPTNameList.Free;
    fSENameList.Free;
    fDANameList.Free;
    fPLNameList.Free;
    fRUNameList.Free;
    fRefList.Free;
    inherited;
end;

function EuroOrganism.AddName(AName:TOrgName;ALanguage:ansistring):boolean;
//returns true if name successfully added
var LanguageNames:EuroNameList;
begin
    result:=false;
    LanguageNames:=GetLanguageList(ALanguage); //get appropriate list
    if IndexOfName(AName.Fullname,ALanguage)<0 then     //name string not present
        if LanguageNames.Add(AName)>=0 then
          result:=true;
end;

procedure EuroOrganism.Clear;
begin
    fSciNameList.Clear;
    fFRNameList.Clear;
    fENNameList.Clear;
    fNLNameList.Clear;
    fDENameList.Clear;
    fITNameList.Clear;
    fESNameList.Clear;
    fCANameList.Clear;
    fPTNameList.Clear;
    fSENameList.Clear;
    fDANameList.Clear;
    fPLNameList.Clear;
    fRUNameList.Clear;
    fRefList.Clear;
    fNbscinames:=0;
    fNbFRnames:=0;
    fNbENnames:=0;
    fNbNLnames:=0;
    fNbDEnames:=0;
    fNbITnames:=0;
    fNbESnames:=0;
    fNbCAnames:=0;
    fNbPTnames:=0;
    fNbSEnames:=0;
    fNbDAnames:=0;
    fNbPLNames:=0;
    fNbRUnames:=0;
    inherited;
end;

function EuroOrganism.getRefcode(aSource:string):string;
//returns organism's unique refcode for given source
var
  oRef:TPageRef;
  i:integer;
begin
   result:='';
   for i:=0 to fRefList.Count-1 do
   begin
      oRef:=fRefList.Items[i];
      if (oRef.bookcode=aSource) then result:=oRef.refcode;
   end;
end;


function EuroOrganism.IndexOfName(aNameString:string;ALanguage:ansistring):integer;
//returns index of name in given list
var LanguageNames:EuroNameList;
begin
   result:=-1;
   LanguageNames:=GetLanguageList(ALanguage); //get appropriate list
   if LanguageNames<>nil then result:=LanguageNames.IndexOfName(aNameString);
end;

function EuroOrganism.GetLanguageList(ALanguage:ansistring):EuroNameList;
begin
   result:=nil;
   if ALanguage='la' then result:=fSciNameList;
   if ALanguage='fr' then result:=fFRNameList;
   if ALanguage='en' then result:=fENNameList;
   if ALanguage='nl' then result:=fNLNameList;
   if ALanguage='de' then result:=fDENameList;
   if ALanguage='it' then result:=fITNameList;
   if ALanguage='es' then result:=fESNameList;
   if ALanguage='ca' then result:=fCANameList;
   if ALanguage='pt' then result:=fPTNameList;
   if ALanguage='se' then result:=fSENameList;
   if ALanguage='da' then result:=fDANameList;
   if ALanguage='pl' then result:=fPLNameList;
   if ALanguage='ru' then result:=fRUNameList;
   if result=nil then
    raise exception.Create('Unknown language '+ALanguage);
end;

function EuroOrganism.PageRefExists(aBookcode,aRefCode:string;aPageNo:integer):boolean;
//returns true if pageref exists for given source in list of refs  ? not used
var
  oRef:TPageRef;
  i:integer;
begin
   result:=false;
   for i:=0 to fRefList.Count-1 do
   begin
      oRef:=fRefList.Items[i];
      if (oRef.bookcode=aBookcode) and (oRef.refcode=aRefCode) and (oRef.pageno=aPageNo) then result:=true;
   end;
end;

constructor TRefList.Create;
begin
  inherited Create;
  OnNotify:=FreeOnRemove;
end;

procedure TRefList.FreeOnRemove(Sender: TObject; const Item: TPageRef; Action: TCollectionNotification);
begin
    if Action = cnRemoved then
       Item.Free;
end;


function EuroNameList.IndexOfName(aNameString:string):integer;
var  i:integer;
begin
   result:=-1;
   for i:=0 to Count-1 do
   begin
      if TOrgname(Items[i]).Fullname=aNameString then result:=i;
   end
end;

procedure TEUMainForm.SkipCountEditChange(Sender: TObject);
begin

end;

procedure TEUMainForm.BatchSetButtonClick(Sender: TObject);
begin
  ShowMessage('Mode is '+IntToStr(UserModes.ItemIndex));
  BatchSize:=StrToInt(BatchSizeEdit.Text);
  BatchSizeEdit.Font.Color:=clRed;
end;

end.

