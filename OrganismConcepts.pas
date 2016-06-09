unit OrganismConcepts;

interface

uses IB_Components,Classes,IB_Access, Variants, Sysutils, Dialogs, Controls,
dateUtils, IDStack, uEPPT, Generics.Collections, Graphics,  Ansistrings;

type

   TOrgUse = class(TObject)
   private
     fName:ansistring;
     fCode:ansistring;
     fIndex:smallInt;
     fHeading:ansistring;
   public
     property UseCode:ansistring read fCode write fcode;
     property UseName:ansistring read fName write fName;
     property UseIndex: smallInt read fIndex write fIndex;
     property Heading:ansistring read fHeading write fHeading;
     constructor Create(NewName,NewCode,NewHeading:ansistring;NewIndex:smallInt);
     function IsValid:boolean;
     procedure Assign(AUse:TOrgUse);
   end;

  TOrgUses = class(TList<TOrgUse>)
   private
     procedure FreeOnRemove(Sender: TObject; const Item: TOrgUse; Action: TCollectionNotification);
   public
     constructor Create;
     destructor Destroy; override;
     function FindUseName(AUseCode:ansistring):ansistring;
     function FindUseCode(AUseName:ansistring):ansistring;
     function FindUseIndex(AUseName:ansistring):smallInt;
     function IsValidCode(AUseCode:ansistring):boolean;
   end;

  TLanguageTable = class
  private
    fCodeNameStrings:TstringList;
    fNameCodeStrings:TstringList;
    fCodeSortStrings:TstringList;
    fSortCodeStrings:TstringList;
    fCodes: Array [0..40] of ansistring;
    fColours: Array [0..40] of TColor;
    function GetCount:integer;
    function GetACode(Index:integer):ansistring;
    function GetAColour(Index:integer):TColor;
    //function GetSortCode(Index:integer):TColor;
  public
    function Add(Code:ansistring;Name:string;SortOrder:integer; Colour:TColor):integer;
    property Codes[Index:Integer]:ansistring read GetACode;
    property Colours[Index:Integer]:TColor read GetAColour;
    constructor Create;
    destructor Destroy;override;
    function FindLanguageCode(Name:ansistring):ansistring;
    function FindLanguageColour(Code:ansistring):TColor; overload;
    function FindLanguageColour(Name:string):TColor; overload;
    function FindLanguageName(Code:ansistring):ansistring;
    function FindSortOrder(Code:ansistring):integer; overload;
    function FindSortOrder(Name:string):integer; overload;
    property Count:integer read GetCount;
  end;

  TOrgName = class(TObject)
  private
    fOrgcode: ansistring;
    fFullname: string;
    fLanguageCode: ansistring;
    fLanguageName : ansistring;
    fNameID: integer;
    fDateModified:TDate;
    fComments: string;
    fEditStatus: ansistring;
    fEPPOID:integer;
    fEPPOStatus: ansistring;
  protected
    fAuthor: string;
    fPreferred: boolean;
    function DetermineScientific:boolean;
    function GetEPPOCode:ansistring;
  public
    property Orgcode:ansistring read fOrgcode write fOrgcode;
    property DateModified:TDate read fDateModified write fDateModified;
    property EPPOCode:ansistring read GetEPPOCode;
    property Fullname:string read fFullname write fFullname;
    property IsScientific:boolean read DetermineScientific;
    property LanguageCode:ansistring read fLanguageCode write fLanguageCode;
    property LanguageName:ansistring read fLanguageName write fLanguageName;
    property NameID:integer read fNameID write fNameID;
    property Comments:string read fComments write fComments;
    property EditStatus: ansistring read fEditStatus write fEditStatus;
    property EPPOStatus: ansistring read fEPPOStatus write fEPPOStatus;
    constructor Create; overload;
    constructor Create(currcode:ansistring); overload;
    constructor Create(currcode:ansistring;newName:string;nameLanguage:ansistring); overload;
    procedure Assign(AnOrgName:TOrgName);
    procedure Clear; virtual;
    function Compare(tarGetName:TOrgName):string;
    procedure MergeFrom(SourceName:TOrgName);
    procedure ReadFromDataSet(DataSet:TIB_DataSet);virtual;
    procedure WriteToDataSet(DataSet:TIB_Query);virtual;
 end;

TOrgNames = class(TList<TOrgName>)
 private
    function GetNameString(i:integer):string;
    procedure FreeOnRemove(Sender: TObject; const Item: TorgName; Action: TCollectionNotification);
    procedure SetNameString(i:integer;Value:string);
 public
    property NameStrings[i:integer]:string read GetNameString write SetNameString;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(ANameList:TorgNames);
    procedure DeleteName(Index:integer);
  end;

 TScientificName = class(TOrgName)
  public
    property Preferred:boolean read fPreferred write fPreferred;
    property Author: string read fAuthor write fAuthor;
    constructor Create(currcode:ansistring;IsPreferred:boolean); overload;
    constructor Create(currcode:ansistring;IsPreferred:boolean;newName:string;nameLanguage:ansistring;nameAuthor:string); overload;
  end;

  ENameDataSetException = class(Exception)
  public
    constructor Create(const Msg: String);
  end;

  TOrgEPPOCheck = class(TObject)
    fStatusCode:integer;
    fStatusMessage:string;
    fAltOrgcode:ansistring;
    fAltPrefname:string;
    fColour:integer;
  private
  public
    property StatusCode:integer read fStatusCode write fStatusCode;
    property StatusMessage:string read fStatusMessage write fStatusMessage;
    property AltOrgcode:ansistring read fAltOrgcode write fAltOrgcode;
    property AltPrefname:string read fAltPrefname write fAltPrefname;
    property Colour:integer read fColour write fColour;
    constructor Create;
    procedure Clear;
  end;

  TOrganism = class(TObject)
  private
    fOrgcode:ansistring;
    fCard:string;
    fComments: string;
    fDatemodified:Tdate;
    fPolno:ansistring;
    fEPPOConnection: SmallInt;  //0=initial state  1=active  -1=disactivated by user
    fEPPONameList:TOrgNames;
    fEPPOCheck:TOrgEPPOCheck;
    fFamily:ansistring;
    fNamelist: TOrgNames;
    fPreferredName:string;
    fUsedby:ansistring;
    fEPPOValidate:ansistring;
  protected
    function GetNameCount:integer;
    function GetAName(index:integer):TOrgName;
    procedure SetAName(index:integer;Value:TOrgname);
    function GetEPPOPrefName:string;
    procedure SetDummyName;
  public
    property Card:string read fCard write fCard;
    property Comments:string read fComments write fComments;
    property EPPOCodeStatus:TOrgEPPOCheck read fEPPOCheck;
    property EPPOConnection:SmallInt read fEPPOConnection;
    property EPPONameList:TOrgNames read fEPPONameList;
    property EPPOPrefName:string read GetEPPOPrefName;
    property Family:ansistring read fFamily write fFamily;
    function LocateNames(Dataset:TIB_Query):boolean;
    property NameCount:integer read GetnameCount;
    property NameList:TOrgNames read fNameList;
    property Names[index:integer]:TOrgName read GetAName;
    property Orgcode:ansistring read fOrgcode write fOrgcode;
    property Polno:ansistring read fPolno write fPolno;
    property PreferredName:string read fPreferredName  write fPreferredName;
    property Usedby:ansistring read fUsedby write fUsedby;
    property EPPOValidate:ansistring read fEPPOValidate write fEPPOValidate;
    constructor Create;
    destructor Destroy; override;
    function AddName(AName:TOrgname):integer;
    function AddUse(AUseName:ansistring):boolean;
    procedure Assign(AnOrganism:TOrganism);
    function ChangePreferredName(NamePos:integer):integer;
    procedure Clear;
    procedure ClearUses;
    function Compare(AnOrganism:TOrganism):string;
    procedure DeleteName(index:integer);
    procedure DeleteNameByID(ANameID:integer);
    procedure DisactivateEPPOConnection(Silent:boolean);
    function IndexOfName(name,auth:string;lang:ansistring):integer;
    function LocateNameInDataset(Name,Author: string;lang:ansistring;Pref:boolean;Dataset:TIB_Query):boolean;
    procedure MergeFrom(sourceOrg:TOrganism);
    procedure PopulateEPPONameList;
    procedure PopulateEPPOCheck;
    procedure ReactivateEPPOConnection;
    procedure RemoveName(name:string;lang:ansistring);
    procedure ReadBasicFromDataSet(DataSet:TIB_Query);virtual;
    procedure ReadNamesFromDataSet(DataSet:TIB_Query);virtual;
    function StripUse(AUseName:ansistring):boolean;
    function UsedByIsEmpty:boolean;
    procedure WriteBasicToDataSet(DataSet:TIB_Query);virtual;
    function WriteNamesToDataSet(Dataset:TIB_Query):boolean; virtual;
   end;

implementation

uses IMSData;

function canReplace(oldValue,newValue:string):integer;
//returns 1 if old value does not exist = always replace
// 0 if values are the same = never replace
// -1 if values are different = ask
begin
    if (newValue=oldValue) then result:=0  //same values don't replace
    else if oldValue='' then result:=1  //can always replace a blank
         else if NewValue='' then result:=0 //never overwrite with blank
              else result:=-1;
end;

{___TOrgUses____________________________________________________________________________________________________}

constructor TOrgUses.Create;
var i:smallint;
begin
  inherited;
  OnNotify:=FreeOnRemove;
  i:=0;
  i:=Add(TOrgUse.Create('All','','All organisms',i));
  i:=Add(TOrgUse.Create('Fungi','FU','Fungi',i));
  i:=Add(TOrgUse.Create('Japan','JP','Japanese organisms',i));
  i:=Add(TOrgUse.Create('Europe','EU','European organisms',i));
  i:=Add(TOrgUse.Create('France','FR','French organisms',i));
  i:=Add(TOrgUse.Create('Portugal','PT','Portuguese organisms',i));
end;

destructor TOrgUses.Destroy;
begin
  Clear;
  inherited;
end;

function TOrgUses.FindUseName(AUseCode:ansistring):ansistring;
var i:smallint;
begin
   result:='';
   for i:=0 to Count-1 do
      if Items[i].UseCode=AUseCode then result:=Items[i].UseName;
end;

function TOrgUses.FindUseCode(AUseName:ansistring):ansistring;
var i:smallint;
begin
   result:='';
   for i:=0 to Count-1 do
      if Items[i].UseName=AUseName then result:=Items[i].UseCode;
end;

function TOrgUses.FindUseIndex(AUseName:ansistring):smallInt;
var i:smallint;
begin
   result:=-1;
   for i:=0 to Count-1 do
      if Items[i].UseName=AUseName then result:=i;
end;

procedure TOrgUses.FreeOnRemove(Sender: TObject; const Item: TOrgUse; Action: TCollectionNotification);
begin
    if Action = cnRemoved then
       Item.Free;
end;

function TOrgUses.IsValidCode(AUseCode:ansistring):boolean;
var i:smallint;
begin
   result:=false;
   for i:=0 to Count do
      if Items[i].UseCode=AUseCode then result:=true;
end;

{___TOrgUse____________________________________________________________________________________________________}
constructor TOrgUse.Create(NewName,NewCode,NewHeading:ansistring;NewIndex:smallInt);
begin
  inherited Create;
  fName:=NewName;
  fCode:=NewCode;
  fheading:=NewHeading;
  fIndex:=NewIndex;
end;

function TOrgUse.IsValid:boolean;
begin
  result:=(fCode<>'');  // invalid if use has not been set
end;

procedure TOrgUse.Assign(AUse:TOrgUse);
begin
  if AUse.IsValid then
  begin
    fIndex:=AUse.UseIndex;
    fName:=AUse.UseName;
    fCode:=AUse.UseCode;
  end;
end;




{___TOrgName____________________________________________________________________________________________________}

constructor TOrgName.Create;
begin
  inherited;
  fEditStatus:=' ';
  fEPPOStatus:=' ';
  end;

constructor TOrgName.Create(currcode:ansistring);
begin
  create;
  fOrgcode:=currcode;
  fDateModified:=0;
end;

constructor TOrgName.Create(currcode:ansistring;newName:string;nameLanguage:ansistring);
begin
  Create;
  fOrgcode:=currcode;
  fFullname:=newName;
  fLanguageCode:=nameLanguage;
  fDateModified:=0;
end;

procedure TOrgName.Assign(AnOrgName:TOrgName);
begin
  if fEditStatus=' ' then
  begin
    Orgcode:=AnOrgName.Orgcode;
    Fullname:=AnOrgName.Fullname;
    LanguageCode:=AnOrgName.LanguageCode;
    LanguageName:=AnOrgName.LanguageName;
    nameID:=AnOrgName.nameID;        // why would you copy the unique identifier?
    Comments:=AnOrgName.Comments;
    fauthor:=TScientificName(AnOrgName).Author;
    fPreferred:=TScientificName(AnOrgName).Preferred;
    fEPPOStatus:=AnOrgName.EPPOStatus;
  end;
end;

procedure TOrgName.Clear;
begin
  fOrgcode:='';
  fFullname:='';
  fLanguageCode:='';
  fLanguageName:='';
  fComments:='';
  fPreferred:=false;
  fauthor:='';
  fDateModified:=0;
  fEditStatus:=' ';
  fEPPOStatus:=' ';
end;

function TOrgName.determineScientific:boolean;
begin
  result:=(fLanguageCode='la');
end;

function TOrgName.Compare(tarGetName:TOrgName):string;
//compare two names and return a text list of differences found
begin
  result:='';
  if fOrgcode<>tarGetName.Orgcode then result:=result+',Orgcode';
  if fFullname<>tarGetName.Fullname then result:=result+',Fullname';
  if fLanguageCode<>tarGetName.LanguageCode then result:=result+',Language';
  if fComments<>tarGetName.Comments then result:=result+',Comments';
  if IsScientific then
  begin
    if tarGetName.IsScientific then
    begin
      if fPreferred<>(tarGetName as TScientificName).Preferred then result:=result+',Preferred';
      if (fAuthor<>(tarGetName as TScientificName).Author) then result:=result+',Author';
    end
    else result:=result+',target not scientific';
  end;
  if length(result)>0 then result:=copy(result,2,length(result)-1);
end;

function TOrgName.GetEPPOCode:ansistring;
var  i: Integer;
     EPPOdata: TEPPOElems;
// returns a blank string if name is not found, '*ERR*' on a connection error
//  and otherwise returns the EEPT code for the name
// NB changed functionality - no longer returns code only for preferred names!
begin
   EPPOdata := TEPPOElems.Create(true); // create data structure
   try
     try
      result:='';
      // Get code in EPPO
      EPPOdata.name2code(Fullname);
        // maybe EPPO cannot have an active Preferred name which is also a synonym, but better to be sure!
      for i := 0 to EPPOdata.Count - 1 do
      begin
        if TEPPOElem(EPPOdata.Items[i]).statuscode then        //active Preferred name
            result:=TEPPOElem(EPPOdata.Items[i]).code;
      end;
     except
      on EIDSocketError do begin
        ShowMessage('Connection to EPPO failed');
        result := '*ERR*';
      end
     end;
    finally
     EPPOdata.Free;
    end;
end;

procedure TOrgName.MergeFrom(SourceName:TOrgName);
//merge input name data into existing name
var replace:integer;
begin
  if fNameID=sourceName.NameID then    // if ID the same, this is the same record, make it fit
  begin
    if (fOrgcode<>sourceName.Orgcode) then  //could it happen that orgcodes are not the same?
    begin
          if MessageDlg(fOrgcode+': replace existing Orgcode with '+sourceName.Orgcode+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then fOrgcode:=sourceName.Orgcode;
    end;
    if (fFullname=sourceName.Fullname) then
    begin
          if MessageDlg(fOrgcode+': replace existing Fullname '+fFullname+' with '+sourceName.Fullname+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then fFullname:=sourceName.Fullname;
    end;
    if (fLanguageCode=sourceName.LanguageCode) then
    begin
          if MessageDlg(fOrgcode+': replace existing LanguageCode '+fLanguageCode+' with '+sourceName.LanguageCode+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then fLanguageCode:=sourceName.LanguageCode;
    end;
  end;
  //duplicate name records
  if (fOrgcode=sourceName.Orgcode) and (fFullname=sourceName.Fullname)
  and (fLanguageCode=sourceName.LanguageCode) then    //make sure we have the same organism
  begin
      //comments
      replace:= CanReplace(fComments,SourceName.Comments);
      if replace<0 then                //two values not equal
          if MessageDlg(fOrgcode+': replace existing Comment '+fComments+' with '+sourceName.Comments+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then replace:=1;
      if replace=1 then fComments:=sourceName.Comments;
      //status
      replace:= CanReplace(fEditStatus,SourceName.EditStatus);
      if replace<0 then                //two values not equal
          if MessageDlg(fOrgcode+': replace existing Status '+fEditStatus+' with '+sourceName.EditStatus+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then replace:=1;
      if replace=1 then fEditStatus:=sourceName.EditStatus;

      if IsScientific and sourceName.IsScientific then
      begin
        replace:= CanReplace(fauthor,TScientificName(SourceName).Author);
        if replace<0 then                //two values not equal
          if MessageDlg(Orgcode+': replace existing author '+fauthor+' with '+TScientificName(SourceName).author+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then replace:=1;
        if replace=1 then fauthor:=TScientificName(SourceName).author;
        if not (fPreferred = (TScientificName(SourceName).Preferred)) then
          if MessageDlg(Orgcode+': replace existing Preferred '+BoolToStr(fPreferred)+' with '+BoolToStr(TScientificName(SourceName).Preferred)+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then  fPreferred:=TScientificName(SourceName).Preferred;
      end;
   end
   else ShowMessage(Orgcode+' '+fFullname+': organism names cannot be merged with '+sourceName.Fullname);
end;

procedure TOrgName.readFromDataSet(DataSet:TIB_DataSet);
// assumes dataSet is prepared and active
begin
    fEditStatus:=' ';
    fOrgcode:=DataSet.FieldValues['ORGCODE'];
    fFullname:=DataSet.FieldValues['FULLNAME'];
    fLanguageCode:=DataSet.FieldValues['LANGUAGE'];
    fComments:=DataSet.FieldByName('COMMENTS').AsWideString;
    fNameID:= DataSet.FieldValues['NAMEID'];
   // fEPPONameID:= DataSet.FieldValues['EPPONAMEID'];   ?saved?
    fEPPOStatus:= DataSet.FieldByName('EPPOStatus').AsWideString;
    if not DataSet.FieldByName('DATEMODIFIED').IsNull then
        fDateModified:=DataSet.FieldValues['DATEMODIFIED'];
    if IsScientific then
    begin
      fauthor:=DataSet.FieldByName('AUTHORITY').AsWideString;
      fPreferred:=(DataSet.FieldByName('PREFERRED').IsNotNull and DataSet.FieldValues['PREFERRED']<>0);
    end;
end;

procedure TOrgName.writeToDataSet(DataSet:TIB_Query);
begin
  with DataSet do
      try
        if not(FieldByName('ORGCODE').IsNotNull) or (FieldValues['ORGCODE']<>fOrgcode) then
          FieldValues['ORGCODE']:=fOrgcode;
        if not(FieldByName('FULLNAME').IsNotNull) or (FieldValues['FULLNAME']<>fFullname) then
          FieldValues['FULLNAME']:=trim(fFullname);
        if not(FieldByName('LANGUAGE').IsNotNull) or (FieldValues['LANGUAGE']<>fLanguageCode) then
          FieldValues['LANGUAGE']:=fLanguageCode;
        if not(FieldByName('COMMENTS').IsNotNull) or (FieldValues['COMMENTS']<>fComments) then
          FieldValues['COMMENTS']:=fComments;
        if not(FieldByName('EPPOStatus').IsNotNull) or (FieldValues['EPPOStatus']<>fEPPOStatus) then
          FieldValues['EPPOStatus']:=fEPPOStatus;
        FieldValues['DATEMODIFIED']:=today;
        if IsScientific then
        begin
          if FieldValues['AUTHORITY']<>fauthor then FieldValues['AUTHORITY']:=fauthor;
          if fPreferred then FieldValues['PREFERRED']:=1 else FieldValues['PREFERRED']:=0;
        end
        else FieldValues['PREFERRED']:=0;
        Post;
        fEditStatus:=' ';
      except
          on e:EIB_StatementError do ShowMessage('Error in writing to DataSet: '+e.message)
      end;
end;

{___TScientificName____________________________________________________________________________________________________}

constructor TScientificName.Create(currcode:ansistring;IsPreferred:boolean);
begin
  inherited Create;
  fOrgcode:=currcode;
  fPreferred:=IsPreferred;
  fLanguageCode:='la';
  end;

constructor TScientificName.Create(currcode:ansistring;IsPreferred:boolean;newName:string;nameLanguage:ansistring;nameAuthor:string);
begin
  Create;
  fOrgcode:=currcode;
  fPreferred:=IsPreferred;
  fFullname:=newName;
  fLanguageCode:=nameLanguage;
  fAuthor:=nameAuthor;
end;

{___TOrgNames____________________________________________________________________________________________________}

constructor TOrgNames.Create;
begin
  inherited Create;
  OnNotify:=FreeOnRemove;
end;

destructor TOrgNames.Destroy;
begin
  Clear;
  inherited;
end;

procedure TOrgNames.Assign(ANameList:TorgNames);
//Copies names in source list to destination
var i:integer; AName:TOrgName;
begin
   for i:= 0 to ANameList.Count-1 do
   begin
     AName:=TOrgname.Create;
     AName.Assign(TOrgName(ANameList.Items[i]));
     Add(AName);
   end;
end;

procedure TOrgNames.DeleteName(Index:integer);
begin
  if Index<Count then
    if (Items[Index].EditStatus='N') then    //new this session
      if (Items[Index].EPPOStatus='N') then Items[Index].EPPOStatus:='D'  //imported name so mark as new deletion
      else Items[Index].EditStatus:='R'     //name was new entry so mark for removal (no action on EPPO or DB)
    else
    begin
      Items[Index].EditStatus:='D';        //exists in DB so mark for deletion
      if (Items[Index].EPPOStatus='I') then
        Items[Index].EPPOStatus:='D'; //exists in EPPO so mark for deletion
    end;
end;

function TOrgNames.GetNameString(i:integer):string;
begin
    result := Items[i].Fullname;
end;

procedure TOrgNames.FreeOnRemove(Sender: TObject; const Item: TorgName; Action: TCollectionNotification);
begin
    if Action = cnRemoved then
       Item.Free;
end;

procedure TOrgNames.SetNameString(i:integer;Value:string);
begin
  if TOrgName(Items[i]).fFullname<>Value then TOrgName(Items[i]).fFullname := Value;
end;


{___TOrganism____________________________________________________________________________________________________}

constructor TOrganism.Create;
begin
  inherited Create;
  fOrgcode:='';
  fEPPOConnection:=0;
  fNamelist:=TOrgNames.Create;
  fEPPONameList:=TOrgNames.Create;
  fEPPOCheck:=TOrgEPPOCheck.Create;
end;

destructor TOrganism.Destroy;
begin
  FreeAndNil(fEPPOCheck);
  FreeAndNil(fEPPONameList);
  FreeAndNil(fNamelist);
  inherited;
end;

function TOrganism.addName(AName:TOrgName):integer;
//add new name only if it does not already appear in list
//returns position if name was added
begin
    if IndexOfName(AName.Fullname,'',AName.LanguageCode)<0 then  //not found
      result:=fNamelist.Add(AName)//insert and return position in list
    else result:=-1;
end;

function TOrganism.AddUse(AUseName:ansistring):boolean;
var AUseCode:ansistring;
begin
  result:=false;
  AUseCode:= IMSDM.GetOrgUseCode(AUseName);  //look up use in list and return code
  if AUseCode<>'' then
  begin
    if (ansipos(AUseCode,fUsedBy)=0) then
    begin
      fUsedBy:=fUsedBy+AUseCode;
      result:=true;
    end;
  end;
end;

procedure TOrganism.Assign(AnOrganism:TOrganism);
//copy organism data
begin
  if AnOrganism is TOrganism then
  begin
     fCard:=AnOrganism.Card;
     fComments:=AnOrganism.Comments;
     fFamily:=AnOrganism.Family;
     fNamelist.Clear;
     fNameList.Assign(AnOrganism.NameList);
     fEPPONameList.Clear;
     fEPPONameList.Assign(AnOrganism.EPPONameList);
     fPreferredName:=AnOrganism.PreferredName;
     fOrgcode:=AnOrganism.Orgcode;
     fPolno:=AnOrganism.Polno;
     UsedBy:=AnOrganism.UsedBy;
     fEPPOValidate:=AnOrganism.EPPOValidate;
  end;

end;

function TOrganism.ChangePreferredName(NamePos:integer):integer;
var AName:TScientificName; i,oldNamePos:integer;
//Change preferred name for organism
//namepos is index of new preferred name
//return index of previous preferred name
//if no names associated does nothing and returns -1
begin
  result:=-1;  //not found
  //iterate to find another Preferred
  oldNamePos:=-1;
  for i:=0 to fNameList.Count-1 do
  begin
      AName:=TScientificName(fNameList.Items[i]);
      if AName.isScientific then
        if (NamePos>=0) then //current name is new preferred
        begin
          if (AName.Fullname=fPreferredName) and AName.Preferred then  //old pref name
          begin
            oldNamePos:=i; //return position in list of old preferred name
            break;
          end;
        end
        else
          if AName.Preferred then  // current was pref name, or blank or multiple pref name
          begin
            oldNamePos:=i; //return position in list of old preferred name
            break;
          end;
  end;
  if (oldNamePos>=0) then  //old pref found
  begin
    if (NamePos>=0) and (oldNamePos<>NamePos) then    // if old found different from new reset it
    begin  //unset old pref
         AName:=TScientificName(fNameList.Items[oldNamePos]);
         AName.preferred:=false;       //unset preferred
         if AName.EditStatus<>'N' then AName.EditStatus:='M';
         result:=oldNamePos;           //return position
    end
    else NamePos:=oldNamePos;  //pref name
  end;
  // change prefered name for org
  if namepos>=0 then
  begin
    AName:=TScientificName(fNameList.Items[NamePos]);
    if AName.Preferred=true then  //new name found     how could it not be????
    begin
      if fPreferredName<>AName.Fullname then
      begin
          fPreferredName:=AName.Fullname; //set new Preferred name
          if AName.EditStatus<>'N' then AName.EditStatus:='M';
          PopulateEPPOCheck;    //recalculate status
      end;
    end
    else fPreferredName:=fPreferredName+' (formerly)';
  end;
end;

procedure TOrganism.Clear;
begin
  fOrgcode:='';
  fPolno:='';
  fnamelist.Clear;
  fFamily:='';
  fCard:='';
  fComments:='';
  fPreferredName:='';
  fEPPONameList.Clear;
  fEPPOCheck.Clear;
  fUsedby:='';
  fEPPOValidate:='';
end;

procedure TOrganism.ClearUses;
begin
  fUsedby:='';
end;

function TOrganism.Compare(AnOrganism: TOrganism):string;
begin
  result:='';
  if fOrgcode<>AnOrganism.Orgcode then result:=result+',Orgcode';
  if fPolno<>AnOrganism.Polno then result:=result+',Polno';
  if fFamily<>AnOrganism.Family then result:=result+',Family';
  if fCard<>AnOrganism.card then result:=result+',card';
  if fComments<>AnOrganism.Comments then result:=result+',Comments';
  if Usedby<>AnOrganism.Usedby then result:=result+',Usedby';
  if fPreferredName<>AnOrganism.PreferredName then result:=result+',Preferred name';
  if length(result)>0 then result:=copy(result,2,length(result)-1);
end;

procedure TOrganism.deleteName(index:integer);
//delete name with specified index
//will change count of names
begin
  if (index>-1) and (index<fnameList.Count)  then fnameList.deletename(index)
end;

procedure TOrganism.deleteNameByID(ANameID:integer);
//delete record with matching ID
var i:integer;OK:boolean;
begin
  OK:=false;
  for i:=0 to fNamelist.Count-1 do
    if (ANameID=fNamelist.Items[i].NameID) then   //ID matches
    begin
      fnameList.deletename(i); //NB could change count of names hence break
      OK:=true;
      break;
    end;
  if not OK then ShowMessage ('Name with ID '+IntToStr(ANameID)+' not found for deletion');
end;

procedure TOrganism.DisactivateEPPOConnection(Silent:boolean);
// disactivate attempt to connect to EPPO
// if already disactivated no change
//argument Silent if true prevents asking user, if false user can choose to continue to try connections
begin
    if (fEPPOConnection >= 0) then   //not already disactivted
      if not Silent and (MessageDlg(
            'EPPO cannot be reached. Check internet connectivity. '+
            'Keep trying to connect?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
          fEPPOConnection := 1
      else
          fEPPOConnection := -1;
end;

function TOrganism.IndexOfName(name,auth:string;lang:ansistring):integer;
var i:integer; AName:TOrgName;
begin
     result:=-1;
     for i:=0 to fNamelist.Count - 1 do
     begin
        AName:=TOrgName(fNamelist.Items[i]);
        if (AName.Fullname=name) and (AName.LanguageCode=lang) then //match on name and language
          if (auth='') or (TScientificName(AName).Author=auth) then  //match on auth too
          begin
            result:=i;
            break;
          end;
    end;
end;

function TOrganism.GetAName(index:integer):TOrgName;
begin
    result:=TOrgName(fnamelist.Items[index]);
end;

function TOrganism.GetNameCount:integer;
begin
     result:=fNamelist.Count;
end;

function TOrganism.GetEPPOPrefName:string;
var  i: Integer;
     EPPOdata: TEPPOElems;
// returns the Preferred name,
// returns a blank string if there is no valid Preferred name
begin
   result:='';   //default result is blank
   if fEPPOCheck.StatusCode>=0 then
   begin
    EPPOdata := TEPPOElems.Create(true); // create data structure
    try
     try
      EPPOdata.code2name(string(Orgcode));
      if EPPOdata.Count > 0 then
      begin
        i := 0;
        while (i < EPPOdata.Count) do
        begin
          // return active Preferred name
          if (TEPPOElem(EPPOdata.Items[i]).pref)             // Preferred
            and (TEPPOElem(EPPOdata.Items[i]).Statuscode) then  // active
          begin
              result:=TEPPOElem(EPPOdata.Items[i]).Name;
              break;
          end;
          inc(i)
        end;
      end;
     except
      on EIDSocketError do begin
        fEPPOCheck.StatusCode:=-1;
        result := '***';
      end;
     end;
    finally
     EPPOdata.Free;
    end;
   end;
end;

function TOrganism.LocateNames(Dataset:TIB_Query):boolean;
//find beginning of names for org
begin
      if DataSet.Active=true then DataSet.close;    //close before changing
      DataSet.ParamValues['Orgcode']:=fOrgcode;   //Set Orgcode parameter
      DataSet.Prepare;
      if DataSet.Prepared=true then DataSet.Open;
      result:=not DataSet.IsEmpty;
end;

function TOrganism.LocateNameInDataset(Name,Author: string;lang:ansistring;Pref:boolean;Dataset:TIB_Query):boolean;
begin
    //find name in dataset, which must be open
    with Dataset do
    begin
      First;
      while (not eof) do
      begin
        result:=true;
        if Pref and not(FieldValues['Preferred']) then result:=false
        else begin
          if (Name<>'') and (FieldValues['FULLNAME']<>Name) then result:=false
          else if (Author<>'') and (FieldValues['Authority']<>Author) then result:=false
          else if (lang<>'')and (FieldValues['Language']<>lang) then result:=false
          else Break;
        end;
        Next;
      end;
    end;
end;

procedure TOrganism.MergeFrom(sourceOrg:TOrganism);
var replace:integer;
begin
   if fOrgcode=sourceOrg.Orgcode then    //make sure we have the same organism
   begin
      //select one Family
      replace:= canReplace(Family,sourceOrg.Family);
      if replace<0 then                //two values not equal
          if MessageDlg(Orgcode+': replace existing Family '+Family+' with '+sourceOrg.Family+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then replace:=1;
      if replace=1 then Family:=sourceOrg.Family;
      // select one Polno
      replace:= canReplace(Polno,sourceOrg.Polno);
      if replace<0 then                //values not equal
          if MessageDlg(Orgcode+': replace existing Polno '+Polno+' with '+sourceOrg.Polno+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then replace:=1;
      if replace=1 then Polno:=sourceOrg.Polno;
      replace:= canReplace(PreferredName,sourceOrg.PreferredName);
      if replace<0 then                //values not equal
          if MessageDlg(Orgcode+': replace existing PreferredName '+PreferredName+' with '+sourceOrg.PreferredName+'?',
            mtWarning,[mbYes,mbNo],0)=mrYes then replace:=1;
      if replace=1 then PreferredName:=sourceOrg.PreferredName;
      //combine card, Comments
      Card:=Card+' '+sourceOrg.card;
      Comments:=Comments+' '+sourceOrg.Comments;
      Usedby:=Usedby+sourceOrg.Usedby;
   end
   else ShowMessage(Orgcode+'Attempt to merge data for different organism codes'+sourceOrg.Orgcode);
end;

procedure TOrganism.PopulateEPPONameList;
var  i: Integer;
     EPPOdata: TEPPOElems;
     OrgName: TScientificName;
// NB calls EPPO unless connection already disactivated by user
// inserts all active names into organism's fEPPONameList
begin
   fEPPONameList.Clear;
   if fEPPOConnection>=0 then    //active or untried
   begin
    EPPOdata := TEPPOElems.Create(true); // create data structure
    try
     try
      EPPOdata.code2name(string(Orgcode));
      if EPPOdata.Count > 0 then
      begin
        i := 0;
        while (i < EPPOdata.Count) do
        begin
          //copy name
          OrgName:=TScientificName.Create(fOrgCode);
          OrgName.FullName:=TEPPOElem(EPPOdata.Items[i]).name;
          OrgName.Author:=TEPPOElem(EPPOdata.Items[i]).Auth;
          OrgName.LanguageCode:=TEPPOElem(EPPOdata.Items[i]).lang;
          //OrgName.EPPONameID:=TEPPOElem(EPPOdata.Items[i]).nameID;
          // return active Preferred name
          if (TEPPOElem(EPPOdata.Items[i]).pref)
          and (TEPPOElem(EPPOdata.Items[i]).Statuscode) then
          begin
            OrgName.Preferred:=True;
          end;
          fEPPONameList.add(OrgName);
          inc(i);
        end;
      end;
     except
      on EIdSocketError do begin
        DisactivateEPPOConnection(false);
        SetDummyName;
     end;
     end;
    finally
     EPPOdata.Free;
    end;
   end
   else SetDummyName;

end;

procedure TOrganism.PopulateEPPOCheck;
//returns status of orgcode: active in EPPO
//0  Cannot reach EPPO (yellow)
//1  code and name agree with EPPO (blue)
//2  code and name are not yet in EPPO (dark green)
//3  Code is not in EPPO and name has a different code (red)
//4  Error in EPPO: Code has names but no preferred name. Name not in EPPO (maroon)
//5  Error in EPPO: Code has no preferred name but this name is a synonym (maroon)
//6  Preferred name missing. Code has a different preferred name in EPPO. (teal)
//7  Code has a different preferred name in EPPO. IMS name is not in EPPO (fuchsia)
//8  Code has a different preferred name in EPPO. IMS name is a synonym (navy)
//9  Code has a different preferred name in EPPO. Name has a different code (red)
//10  Error: No preferred name. The code is not in EPPO (green)
//11  Error: the code is in EPPO without a preferred name, and there is no preferred name here (green)
//12  Error in EPPO: Code has no preferred name in EPPO. Name has a different code (red)
var
  EPPOName, EPPOAuth:string;
  AName:TScientificName;
  Altorgcode:ansistring;
  i:integer;
begin
    if fEPPONameList.Count=0 then PopulateEPPONameList;  //EPPONameList will always be available
    for i:=0 to fEPPONameList.Count-1 do
    begin
      AName:=TScientificName(fEPPONameList.Items[i]);
      if AName.preferred then
      begin
        EPPOName:=AName.Fullname;
        EPPOAuth:=AName.Author;
        break;
      end
    end;
    if EPPOName = '***' then       //connection failed somewhere along the line
    begin
      fEPPOCheck.StatusCode := 0;
      fEPPOCheck.StatusMessage:='Cannot reach EPPO'; //error
      fEPPOCheck.Colour:=$00008888;        //olive
    end
    else begin    //connection OK
      if (fPreferredName='') then
      begin
        if (EPPOName='') then
        begin
          if fEPPONameList.Count=0 then  //code has no names at all in EPPO ie is new
          begin
              fEPPOCheck.StatusCode := 10;
              fEPPOCheck.StatusMessage:='Error: No preferred name. The code is not in EPPO.' ; //OK
              fEPPOCheck.Colour:=$00004400;        //green
          end
          else begin
              fEPPOCheck.StatusCode := 11;
              fEPPOCheck.StatusMessage:='Error: the code is in EPPO without a preferred name, and there is no preferred name here'; //OK
              fEPPOCheck.Colour:=$00008800;        //green
          end;
        end
        else begin
          fEPPOCheck.StatusCode := 6;
          fEPPOCheck.StatusMessage:='Preferred name missing. Code has a different preferred name in EPPO'; //Error
          fEPPOCheck.Colour:=$00888800;        //teal
          fEPPOCheck.AltPrefname:=EPPOName;
        end;
      end
      else begin  //pref name exists
        if (EPPOName='') then   // no pref name for code in EPPO
        begin
          if fEPPONameList.Count=0 then  //code has no names at all in EPPO ie is new
          begin //code not in EPPO
            altorgcode:=IMSDM.GetEPPOCodeForNameString(fPreferredName);
            if altorgcode='' then   //code and name not found at all in EPPO -> OK just not entered yet
            begin
              fEPPOCheck.StatusCode := 2;
              fEPPOCheck.StatusMessage:='code and name are not yet in EPPO'; //OK
              fEPPOCheck.Colour:=$00008800;        //green    AAOLA
            end
            else begin //name has another code altogether
                fEPPOCheck.StatusCode := 3;
                fEPPOCheck.StatusMessage:='Code is not in EPPO and name has a different code';
                fEPPOCheck.Altorgcode:=altorgcode;
                fEPPOCheck.Colour:=$000000FF;        //red
            end
          end
          else begin  //no pref name but other names exist
            altorgcode:=IMSDM.GetEPPOCodeForNameString(fPreferredName);  //get code for the pref name
            if altorgcode='' then   //preferred name not found in EPPO
            begin
              fEPPOCheck.StatusCode := 4;
              fEPPOCheck.StatusMessage:='Error in EPPO: Code has names but no preferred name. Name not in EPPO'; //Error
              fEPPOCheck.Colour:=$00000088;        //maroon
            end
            else begin
              if altorgcode=fOrgCode then //synonym
              begin
                fEPPOCheck.StatusCode := 5;
                fEPPOCheck.StatusMessage:='Error in EPPO: Code has no preferred name in EPPO but this name is amongst synonyms';
                fEPPOCheck.Colour:=$00000088;        //maroon
              end
              else begin
                fEPPOCheck.StatusCode := 12;
                fEPPOCheck.StatusMessage:='Error in EPPO: Code has no preferred name in EPPO. Name has a different code';
                fEPPOCheck.Altorgcode:=altorgcode;
                fEPPOCheck.Colour:=$000000FF;        //red
              end
            end
          end
        end
        else begin         //EPPO has pref name
          if (EPPOName=fPreferredName) then  //same names
          begin
            fEPPOCheck.StatusCode := 1;
            fEPPOCheck.StatusMessage:='code and name agree with EPPO'; //OK
            fEPPOCheck.Colour:=$00FF0000 ;        //blue AAIPR
          end
          else begin
            if (fEPPONameList.NameStrings[0]='***') then  //pseudo name = persistent error in connection
            begin
              fEPPOCheck.StatusCode := 0;
              fEPPOCheck.StatusMessage:='Cannot reach EPPO'; //OK
              fEPPOCheck.Colour:=$0088CC88;         //pink=  $0088FFFF  //pale fuchsia  $00FF88FF
            end
            else begin // look for name elsewhere
              altorgcode:=IMSDM.GetEPPOCodeForNameString(fPreferredName);
              if altorgcode='' then   //preferred name does not occur in EPPO
              begin
                fEPPOCheck.StatusCode := 7;
                fEPPOCheck.StatusMessage:='Code has a different preferred name in EPPO. IMS name not in EPPO'; //Error
                fEPPOCheck.Colour:=$0088CC88;   //pale grey-green;  AAOSE
                fEPPOCheck.AltPrefname:=EPPOName;
              end
              else if altorgcode=OrgCode then  //name has the right code but is a synonym)
              begin
                fEPPOCheck.StatusCode := 8;
                fEPPOCheck.StatusMessage:='Code has a different preferred name in EPPO. IMS name is a synonym '; //Error
                fEPPOCheck.Colour:=$00880000;        //navy
                fEPPOCheck.AltPrefname:=EPPOName;
              end
              else begin
                fEPPOCheck.StatusCode := 9;
                fEPPOCheck.StatusMessage:='Code has a different preferred name in EPPO. IMS name has a different code'; //Error
                fEPPOCheck.Colour:=$000000FF;        //red
                fEPPOCheck.AltPrefname:=EPPOName;
                fEPPOCheck.Altorgcode:=altorgcode;
              end
            end //not connection error
          end //pref names not the same
        end //EPPO pref name exists
      end; //pref name exists
    end; // name not ****
end;

procedure TOrganism.readBasicFromDataSet(DataSet:TIB_Query);
begin
    with DataSet do
    begin
      try
          if forgcode='' then forgcode:=FieldValues['ORGCODE'];
          if FieldByName('FAMILY').IsNotNull=true then fFamily:=FieldValues['FAMILY'];
          if FieldByName('POLNO').IsNotNull=true then fPolno:=FieldValues['POLNO'];
          if FieldByName('USEDBY').IsNotNull=true then fUsedBy:=FieldValues['USEDBY'];
          if FieldByName('CARD').IsNotNull=true then fCard:=FieldValues['CARD'];
          if FieldByName('DATEMODIFIED').IsNotNull=true then fDatemodified:=FieldValues['DATEMODIFIED'];
          if FieldByName('PREFERREDNAME').IsNotNull=true then fPreferredName:=FieldValues['PREFERREDNAME'];
          if FieldByName('COMMENTS').IsNotNull=true then fComments:=FieldValues['COMMENTS'];
          if FieldByName('EPPOVALIDATE').IsNotNull=true then fEPPOValidate:=FieldValues['EPPOVALIDATE'];
      except
          on e:EIB_StatementError do ShowMessage('Error reading data for '+fOrgcode+' '+e.message)
      end;
    end;
end;

procedure TOrganism.ReadNamesFromDataSet(DataSet:TIB_Query);
var AName:TScientificName;

//find names and read them into list
begin
  fnamelist.Clear;
  try
    if LocateNames(Dataset) then  //true if names found
    begin
      DataSet.First;        //if records present go to top
      while not DataSet.eof do
      begin
        AName:=TScientificName.Create;
        AName.ReadFromDataSet(DataSet);   //copy data
        if AName.Preferred then fpreferredName:=AName.Fullname;
        fNamelist.Add(AName); //insert in org name list
        DataSet.Next;
      end;
    end;
  except on e:EIB_StatementError do
      ShowMessage('Error reading names for '+fOrgcode+' from '+DataSet.Name+' '+e.message);
  end;
end;

procedure TOrganism.RemoveName(name:string;lang:ansistring);
var i:integer; AName:TOrgname;
begin
     for i:=0 to fNamelist.Count - 1 do
     begin
        AName:=TOrgname(fNamelist.Items[i]);
        if (AName.Fullname=name) and (AName.LanguageCode=lang) then
        begin
          fNamelist.Delete(i);
          break;
        end
     end;
end;

procedure TOrganism.ReactivateEPPOConnection;
begin
    fEPPOconnection:=0;
end;

procedure TOrganism.SetAName(index:integer;Value:TOrgname);
var AName:TOrgName;
begin
  AName:=nil;
  if (Index>=0) and (Index<fNameList.Count) then  //if out of bounds no action
    AName:=TOrgname(fNameList[index]);
  if AName<>nil then
    if Length(AName.Compare(Value))>0 then
    begin
      AName.Assign(Value);  //different
      fNameList[index]:=AName;
    end;
end;

procedure TOrganism.SetDummyName;
var     OrgName: TScientificName;
begin
    fEPPONameList.Clear;
    OrgName:=TScientificName.Create;
    OrgName.FullName:='***';          //set dummy name
    OrgName.Preferred:=true;
    fEPPONameList.Add(OrgName);
end;

function TOrganism.StripUse(AUseName:ansistring):boolean;
var k:integer; AUseCode:ansistring;
begin
  result:=false;
  AUseCode:= IMSDM.GetOrgUseCode(AUseName);
  if AUseCode<>'' then
  begin
    k:=ansipos(AUseCode,fUsedBy);
    if k>0 then
    begin
      fUsedby:=stuffstring(fusedBy,k,Length(AUseCode),'');
      result:=True;
    end;
  end;
end;

function TOrganism.UsedByIsEmpty:boolean;
begin
   result:=(fUsedBy='');
end;

procedure TOrganism.WriteBasicToDataSet(DataSet:TIB_Query);
begin
   with DataSet do
      try
        FieldValues['ORGCODE']:=fOrgcode;
        if (FieldByName('FAMILY').IsNull=true) or (FieldValues['FAMILY']<>fFamily) then
          FieldValues['FAMILY']:=fFamily;
        if (FieldByName('POLNO').IsNull=true) or (FieldValues['POLNO']<>fPolno) then
          FieldValues['POLNO']:=fPolno;
        if (FieldByName('USEDBY').IsNull=true) or (FieldValues['USEDBY']<>fUsedBy) then
          FieldValues['USEDBY']:=fUsedBy;
        if (FieldByName('CARD').IsNull=true) or (FieldByName('CARD').AsString<>fCard) then
          FieldValues['CARD']:=fCard;
        if (FieldByName('PREFERREDNAME').IsNull=true) or (FieldValues['PREFERREDNAME']<>fPreferredName) then
          FieldValues['PREFERREDNAME']:=fPreferredName;
        if (FieldByName('COMMENTS').IsNull=true) or (FieldByName('COMMENTS').AsString<>fComments) then
          FieldValues['COMMENTS']:=fComments;
        if (FieldByName('EPPOValidate').IsNull=true) or (FieldValues['EPPOValidate']<>fEPPOValidate) then
          FieldValues['EPPOValidate']:=fEPPOValidate;
        FieldValues['DATEMODIFIED']:=today;
        Post;
      except
          on e:EIB_StatementError do ShowMessage('Error writing data for '+fOrgcode+' '+e.message)
      end
   end;

function TOrganism.WriteNamesToDataSet(Dataset:TIB_Query):boolean;
//updates organism's names according to their status value:
// find records matching on NameID then
//    delete names in list with status D / if EPPOStatus='I' mark for deletion
//    copy names in list with status C / copy to dataset
//    modify names in list with status M / if EPPOStatus='I' mark R for modification
//    ignore names in list with status blank
// finally insert names in list with status N
var i:integer; AName:TOrgName;  status:ansichar; PreferredFound:boolean;
begin
  result:=false;
  //check there is a preferred name
  PreferredFound:=false;
  for i:=0 to fNameList.Count-1 do   //run through names for preferred name
  begin
      AName:= fNameList.Items[i];
      if TScientificName(AName).Preferred then PreferredFound:=True;
  end;
  if not PreferredFound and (fNameList.Count>0)  then   //if deleting org we need to clear all names
      if MessageDlg ('There is no preferred name for '+fOrgcode+'. Do you want to save anyway?',mtWarning,[mbYes,mbCancel],0)=mrYes then
          result:=True
      else result:=false
  else result:=True;
  //
  if result then
  //perform deletions and modifications first
  try
    if not DataSet.bof then DataSet.First;        //if records present go to top
    while not DataSet.eof do   //cycle through saved names
    begin
      for i:=0 to fNameList.Count-1 do  //find matching nameID
      begin
        AName:= fNameList.Items[i];
        if AName.NameID=Dataset.FieldValues['NAMEID'] then  // saved name matches name in namelist
        begin
          if AName.EditStatus<>' ' then   //change signalled
          begin
            status:=AName.EditStatus[1];
            Case Status  of
              'D':  begin    //delete
                      if AName.EPPOStatus='I' then
                      begin
                        AName.EPPOStatus:='D'; //mark for deletion from EPPO
                        DataSet.Edit;
                        AName.WriteToDataSet(DataSet);
                        AName.EditStatus:=' ';
                      end
                      else begin
                        DataSet.Delete;   //Remove deleted name from database
                        AName.EditStatus:='X';  //temporarily mark as deleted so it can be removed from namelist
                      end;
                    end;
              'S':  begin   //Save in DB no action on EPPO
                      AName.EditStatus:=' ';  //copy
                      DataSet.Edit;
                      AName.WriteToDataSet(DataSet);
                    end;
              'M':  begin   //Modify
                      if (AName.EPPOStatus='I') or (AName.EPPOStatus='N') then  //record is in EPPO
                      begin
                        AName.EPPOStatus:='D'; //no longer identical so delete from EPPO
                        AName.EditStatus:='N'; //mark record for insertion
                      end
                      else AName.EditStatus:=' ';
                      DataSet.Edit;
                      AName.WriteToDataSet(DataSet);
                    end;
              'N':  begin   //this is an error that cannot occur because N is not recorded in database
                      ShowMessage ('Record already exists for '+fOrgcode+' '+AName.Fullname);
                      AName.EditStatus:=' ';
                   end
              else ShowMessage ('Unknown status code '+AName.EditStatus+' for '+fOrgcode+' '+AName.Fullname);
            End;
          end;
          Break; //because saved record matched in list
        end
      end;
      if not (AName.EditStatus='X') then Dataset.Next;
    end;
    //remove deleted names from fnamelist
      i:=0;
      while i<= fNameList.Count-1 do   //run through names again for new records and leftovers
      begin
        AName:= fNameList.Items[i];
        if (AName.EditStatus='X') then  //X gone without trace
          fNameList.Delete(i)
        else inc(i);
      end;
      for i:=0 to fNameList.Count-1 do   //run through names again for new records and leftover problems
      begin
        AName:= fNameList.Items[i];
        if (AName.EditStatus='N') then  //N new
        begin
            AName.EditStatus:=' ';
            if AName.EPPOStatus='N' then AName.EPPOStatus:='I';  //mark new import as identical
            DataSet.Insert;
            //insert name
            AName.WriteToDataSet(DataSet);
            AName.EditStatus:=' ';
        end
        else                     //M modified
          if (AName.EditStatus<>' ') then     //other unprocessed names (errors)
          begin
            ShowMessage ('Failed to find record for '+fOrgcode+' '+AName.Fullname+' '+AName.LanguageCode+' with status: '+AName.EditStatus);
          end;
      end;
    except on e:EIB_StatementError do
      ShowMessage('Error writing names for '+fOrgcode+' to '+AName.Fullname+' '+e.message);
    end;
end;

constructor ENameDataSetException.Create(const Msg: String);
begin
  inherited Create('Assign database for Names before '+Msg);
end;

constructor TOrgEPPOCheck.Create;
begin
  inherited;
  fStatusCode:=0;
end;

procedure TOrgEPPOCheck.Clear;
begin
    fStatusCode:=0;
    fStatusMessage:='';
    fAltOrgcode:='';
    fAltPrefName:='';
    fColour:=$0;
end;


{___TLanguageTable____________________________________________________________________________________________________}

constructor TLanguageTable.Create;
var i:integer;
begin
  inherited Create;
  fCodeNameStrings:=TStringList.Create(false);
  fNameCodeStrings:=TStringList.Create(false);
  fCodeSortStrings:=TStringList.Create(false);
  fSortCodeStrings:=TStringList.Create(false);
  for i:=0 to 40 do fCodes[i]:='';
  for i:=0 to 40 do fColours[i]:=clNone;
end;

destructor TLanguageTable.Destroy;
begin
  FreeAndNil(fCodeNameStrings);
  FreeAndNil(fNameCodeStrings);
  FreeAndNil(fCodeSortStrings);
  FreeAndNil(fSortCodeStrings);
  inherited;
end;

function TLanguageTable.Add(Code:ansistring;Name:string;SortOrder:integer; Colour:TColor):integer;
begin
  result:=fCodeNameStrings.Add(Code+'='+Name);
  fNameCodeStrings.Add(Name+'='+Code);
  fCodeSortStrings.Add(Code+'='+IntToStr(SortOrder));
  fSortCodeStrings.Add(IntToStr(SortOrder)+'='+Code);
  fCodes[SortOrder]:=Code;
  fColours[SortOrder]:=Colour;
end;

function TLanguageTable.FindLanguageCode(Name:ansistring):ansistring;
begin
  if Name<>'' then
  begin
    result:=fNameCodeStrings.Values[Name];
    if result='' then
      if MessageDlg('Invalid language name: '+Name,mtWarning,[mbOK,mbAbort],0)=mrAbort then
        raise Exception.Create('Use aborted on error');
  end
  else result:='';
 end;

function TLanguageTable.FindLanguageColour(Code:ansistring):TColor;
var SortVal:integer;
begin
  result:=0;
  if Code<>'' then
  begin
    SortVal:=StrToIntDef(fCodeSortStrings.Values[Code],9999);
    if SortVal=9999 then ShowMessage('No sort string for language code '+Code)
    else result:=fColours[SortVal];
  end;
end;

function TLanguageTable.FindLanguageColour(Name:string):TColor;
begin
  result:=FindLanguageColour(FindLanguageCode(Name));
end;

function TLanguageTable.FindLanguageName(Code:ansistring):ansistring;
begin
  result:=fCodeNameStrings.Values[Code];
  if result='' then ShowMessage('Invalid language code '+Code);
end;

function TLanguageTable.FindSortOrder(Code:ansistring):integer;
begin
  result:=StrToInt(fCodeSortStrings.Values[Code])
end;

function TLanguageTable.FindSortOrder(Name:string):integer;
begin
  result:=StrToInt(fCodeSortStrings.Values[FindLanguageCode(Name)])
end;

function TLanguageTable.GetACode(Index:integer):ansistring;
begin
  result:=fCodes[Index];
end;

function TLanguageTable.GetAColour(Index:integer):TColor;
begin
  result:=fColours[Index];
end;

function TLanguageTable.GetCount:integer;
begin
  result:=fCodeNameStrings.Count;
end;

end.
