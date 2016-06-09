unit ForayConcepts;

interface

uses Windows, OrganismConcepts, classes, IB_Components, IB_Access, Sysutils,
  Generics.Collections, Dialogs;

type

  TIMSDate = class(TObject)
    fyear: integer;
    fmonth: integer;
    fday: integer;
    fdecade: integer;
  private
    function AsString: string;
  end;

  TFind = class(TObject)
  private
    fforaycode: string;
    forgcode: string;
    ffindnotes: string;
  public
    property foraycode: string read fforaycode write fforaycode;
    property orgcode: string read forgcode write forgcode;
    property findnotes: string read ffindnotes write ffindnotes;
    procedure Clear;
    procedure ReadFromDataset(Dataset: TIB_Dataset);
    procedure WriteToDataset(Dataset: TIB_Query);
  end;

  TFindlist = class(TList<TFind>)
  private
    procedure FreeOnRemove(Sender: TObject; const Item: TFind; Action: TCollectionNotification);
  public
    constructor Create;
  end;

  TForay = class(TObject)
  private
    fforaycode: string;
    fforayname: string;
    fforaycountry: string;
    fforayplace: string;
    fforaydate: TIMSDate;
    fforaycomments: string;
  protected
    function GetForayDate: string;
    procedure SetForayDate(Value: TDate); overload;
    procedure SetForayDate(Value: string); overload;
  public
    property foraycode: string read fforaycode write fforaycode;
    property forayname: string read fforayname write fforayname;
    property foraycountry: string read fforaycountry write fforaycountry;
    property forayplace: string read fforayplace write fforayplace;
    property foraydate: string read GetForayDate write SetForayDate;
    property foraycomments: string read fforaycomments write fforaycomments;
    constructor Create;
    destructor Destroy; override;
    function Compare(AForay: TForay): string;
    function IsEmpty: boolean;
    procedure Assign(AForay: TForay);
    procedure Clear;
    procedure ReadFromDataset(Dataset: TIB_Dataset);
    procedure WriteToDataset(Dataset: TIB_Query);
  end;

implementation

procedure TFind.Clear;
begin
  forgcode := '';
  fforaycode := '';
  ffindnotes := '';
end;

procedure TFind.ReadFromDataset(Dataset: TIB_Dataset);
begin
  Clear;
  if not(Dataset.FindField('FORAYCODE') = nil) and
    (not Dataset.FindField('FORAYCODE').IsNull) then
    fforaycode := Dataset.FieldValues['FORAYCODE'];
  if not(Dataset.FindField('ORGCODE') = nil) and
    (not Dataset.FindField('ORGCODE').IsNull) then
    forgcode := Dataset.FieldValues['ORGCODE'];
  if not(Dataset.FindField('FINDNOTES') = nil) and
    (not Dataset.FindField('FINDNOTES').IsNull) then
    ffindnotes := Dataset.FieldValues['FINDNOTES'];
end;

procedure TFind.WriteToDataset(Dataset: TIB_Query);
begin
  try
    with Dataset do
    begin
      FieldValues['ORGCODE'] := forgcode;
      FieldValues['FORAYCODE'] := fforaycode;
      FieldValues['FINDNOTES'] := ffindnotes;
      Post;
    end;
  except
    on e: EIB_StatementError do
      ShowMessage('Error writing data for foray ' + foraycode + ' ' +
          e.Message);
  end;
end;

constructor TFindList.Create;
begin
  inherited Create;
  OnNotify:=FreeOnRemove;
end;

procedure TFindList.FreeOnRemove(Sender: TObject; const Item: TFind; Action: TCollectionNotification);
begin
    if Action = cnRemoved then
       Item.Free;
end;

constructor TForay.Create;
begin
  inherited;
  fforaydate := TIMSDate.Create;
  fforaydate.fyear := 0;
  fforaydate.fmonth := 0;
  fforaydate.fday := 0;
end;

destructor TForay.Destroy;
begin
  fforaydate.Free;
  fforaydate := nil;
  inherited;
end;

procedure TForay.Assign(AForay: TForay);
begin
  fforaycode := AForay.foraycode;
  fforayname := AForay.forayname;
  fforaycountry := AForay.foraycountry;
  fforayplace := AForay.forayplace;
  foraydate := AForay.foraydate;
  fforaycomments := AForay.foraycomments;
end;

function TForay.GetForayDate: string;
begin
  result := fforaydate.AsString;
end;

function TForay.IsEmpty: boolean;
begin
  result := (fforaycode = '');
end;

procedure TForay.Clear;
begin
  fforaycode := '';
  fforayname := '';
  fforaycountry := '';
  fforayplace := '';
  fforaydate.fday := 0;
  fforaydate.fmonth := 0;
  fforaydate.fyear := 0;
  fforaycomments := '';
end;

function TForay.Compare(AForay: TForay): string;
begin
  result := '';
  if fforaycode <> AForay.foraycode then
    result := result + 'foraycode';
  if fforayname <> AForay.forayname then
    result := result + 'forayname';
  if fforaycountry <> AForay.foraycountry then
    result := result + 'foraycountry';
  if fforayplace <> AForay.forayplace then
    result := result + 'forayplace';
  if foraydate <> AForay.foraydate then
    result := result + 'foraydate';
  if fforaycomments <> AForay.foraycomments then
    result := result + 'foraycomments';
end;

procedure TForay.ReadFromDataset(Dataset: TIB_Dataset);
begin
  Clear;
  if not(Dataset.FindField('FORAYCODE') = nil) and
    (not Dataset.FindField('FORAYCODE').IsNull) then
    fforaycode := Dataset.FieldValues['FORAYCODE'];
  if not(Dataset.FindField('FORAYNAME') = nil) and
    (not Dataset.FindField('FORAYNAME').IsNull) then
    fforayname := Dataset.FieldValues['FORAYNAME'];
  if not(Dataset.FindField('FORAYCOUNTRY') = nil) and
    (not Dataset.FindField('FORAYCOUNTRY').IsNull) then
    foraycountry := Dataset.FieldValues['FORAYCOUNTRY'];
  if not(Dataset.FindField('FORAYPLACE') = nil) and
    (not Dataset.FindField('FORAYPLACE').IsNull) then
    forayplace := Dataset.FieldValues['FORAYPLACE'];
  if not(Dataset.FindField('FORAYDATE') = nil) and
    (not Dataset.FindField('FORAYDATE').IsNull) then
    foraydate := Dataset.FieldValues['FORAYDATE'];
  if not(Dataset.FindField('foraycomments') = nil) and
    (not Dataset.FindField('foraycomments').IsNull) then
    fforaycomments := Dataset.FieldValues['foraycomments'];
end;

procedure TForay.SetForayDate(Value: TDate);
var
  FormatSettings: TFormatSettings;
  AString: string;
begin
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT,FormatSettings);
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  FormatSettings.DateSeparator := '-';
  AString := DateToStr(Value, FormatSettings);
  fforaydate.fyear := StrToInt(copy(AString, 1, 4));
  fforaydate.fmonth := StrToInt(copy(AString, 6, 7));
  fforaydate.fday := StrToInt(copy(AString, 9, 10));
  fforaydate.fdecade := fforaydate.fyear div 10;
end;

procedure TForay.SetForayDate(Value: string);
var
  datelength: integer;
begin
  fforaydate.fyear := 0;
  fforaydate.fdecade := 0;
  fforaydate.fmonth := 0;
  fforaydate.fday := 0;
  datelength := length(Value);
  if datelength > 3 then
  begin
    fforaydate.fyear := StrToIntDef(copy(Value, 1, 4), 0); // year numeric?
    if fforaydate.fyear > 0 then
      fforaydate.fdecade := fforaydate.fyear div 10
    else
      fforaydate.fdecade := StrToIntDef(copy(Value, 1, 3),0);
  end;
  if (datelength > 6) and (Value[5] = '-') then
    fforaydate.fmonth := StrToInt(copy(Value, 6, 2))
  else
    fforaydate.fmonth := 0;
  if (datelength = 10) and (Value[8] = '-') then
    fforaydate.fday := StrToInt(copy(Value, 9, 2))
  else
    fforaydate.fday := 0;
end;

procedure TForay.WriteToDataset(Dataset: TIB_Query);
begin
  with Dataset do
    try
      FieldValues['FORAYCODE'] := fforaycode;
      FieldValues['FORAYNAME'] := fforayname;
      FieldValues['FORAYCOUNTRY'] := fforaycountry;
      FieldValues['FORAYPLACE'] := fforayplace;
      FieldValues['FORAYDATE'] := fforaydate.AsString;
      FieldValues['FORAYCOMMENTS'] := fforaycomments;
      Post;
    except
      on e: EIB_StatementError do
        ShowMessage('Error writing data for foray ' + foraycode + ' ' +
            e.Message);
    end;
end;

function TIMSDate.AsString: string;
begin
  if fday = 0 then
    if fmonth = 0 then
      if fyear = 0 then
        if fdecade = 0 then
          result := 'unknown'
        else
          result := IntToStr(fdecade) + '*'
        else
          result := IntToStr(fyear)
        else
          result := IntToStr(fyear) + '-' + copy(IntToStr(fmonth + 100), 2, 2)
        else
          result := IntToStr(fyear) + '-' + copy(IntToStr(fmonth + 100), 2, 2)
            + '-' + copy(IntToStr(fday + 100), 2, 2);
end;

end.
