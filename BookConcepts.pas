unit BookConcepts;

interface
uses Windows,IB_Components,IB_Access,Graphics,Classes,Types,SysUtils,Printers,
     Dialogs, Variants, Ansistrings, generics.collections;

type
   TBookUse = class(TObject)
   private
     fName:ansistring;
     fCode:ansistring;
     fIndex:smallInt;
     fHeading:ansistring;
   public
     property UseCode:ansistring read fCode write fCode;
     property UseName:ansistring read fName write fName;
     property UseIndex: smallInt read fIndex write fIndex;
     property Heading:ansistring read fHeading write fHeading;
     constructor Create(NewName,NewCode,NewHeading:ansistring;NewIndex:smallInt);
     procedure Assign(AUse:TBookUse);
   end;

   TBookUses = class(TList<TBookUse>)
   private
     procedure FreeOnRemove(Sender: TObject; const Item: TBookUse; Action: TCollectionNotification);
   public
     constructor Create;
     destructor Destroy; override;
     function FindUseName(AUseCode:ansistring):ansistring;
     function FindUseCode(AUseName:ansistring):ansistring;
     function FindUseIndex(AUseName:ansistring):smallInt;
     function IsValidCode(AUseCode:ansistring):boolean;
   end;

   TBook = class(TObject)
   private
     fbookcode:string;
     fshortcode:string;
     ftitle:string;
     fauthor:string;
     fnbpages:integer;
     fnotes:string;
     fVolume:string;
     fEdition:string;
     fPublisher:string;
     fPlace:string;
     fyearpub:string;
     fOrigTitle:string;
     fOPublisher:string;
     fOplace:string;
     fOyear:string;
     fISBN:string;
     fSubject:string;
     fPrice:integer;
     fDateAcquired:string;
     fRef:string;
     fUsedBy:ansistring;
     fBookPlateStatus:string;
   public
     property author:string read fauthor write fauthor;
     property bookcode:string read fbookcode write fbookcode;
     property DateAcquired:string read fDateAcquired write fDateAcquired;
     property Edition:string read fEdition write fEdition;
     property ISBN:string read fISBN write fISBN;
     property notes:string read fnotes write fnotes;
     property NumberOfPages:integer read fnbpages write fnbpages;
     property OPublisher:string read fOPublisher write fOPublisher;
     property Oplace:string read fOplace write fOplace;
     property OYear:string read fOyear write fOyear;
     property place:string read fplace write fplace;
     property Price:integer read fPrice write fPrice;
     property Publisher:string read fPublisher write fPublisher;
     property Ref:string read fRef write fRef;
     property shortcode:string read fshortcode write fshortcode;
     property Subject:string read fSubject write fSubject;
     property title:string read ftitle write ftitle;
     property OrigTitle:string read fOrigTitle write fOrigTitle;
     property UsedBy:ansistring read fUsedBy write fUsedBy;
     property Volume:string read fVolume write fVolume;
     property yearpub:string read fyearpub write fyearpub;
     property BookPlateStatus:string read fBookPlateStatus write fBookPlateStatus;
     function AddUse(AUsename:ansistring):boolean;
     function Compare(ABook:TBook):string;
     function IsEmpty:boolean;
     procedure Assign(ABook:TBook);
     procedure Clear;
     procedure ClearUses;
     procedure ReadFromDataset(Dataset:TIB_Dataset);
     //procedure setUses(Value: AnsiString); overload;
     function StripUse(AUseName:ansistring):boolean;
     procedure WriteToDataset(Dataset:TIB_Query);
   end;

  TPageRef = class(TObject)
  private
    forgcode:ansistring;
    fbookcode: string;
    fvolume: string;
    fpageno: integer;
    frefcode: string;
    fnotes:string;
  public
    property orgcode:ansistring read forgcode write forgcode;
    property bookcode:string read fbookcode write fbookcode;
    property volume:string read fvolume write fvolume;
    property pageno:integer read fpageno write fpageno;
    property refcode:string read frefcode write frefcode;
    property notes:string read fnotes write fnotes;
    constructor Create(orgcode:ansistring); overload;
    constructor Create(orgcode:ansistring;bookcode:string;pageno:integer); overload;
    constructor Create(orgcode:ansistring;bookcode:string;refcode:string); overload;
    procedure Assign(APageRef:TPageRef);
    procedure Clear;
    procedure ReadFromDataset(Dataset:TIB_Dataset);
    procedure WriteToDataset(Dataset:TIB_Query);
  end;

  TBookplate = class(TObject)
  private
      fsource:TBook;
      fauthor:string;
      ftitle:string;
      fvolume:string;
      fedition:string;
      fpubdata:string;
      fOrigTitle:string;
      fopubdata:string;
      fisbn:string;
      fsubject:string;
      fdateacquired:string;
      fref:string;
      fHSpacing:integer;
      fVSpacing:integer;
      fHLineThick:integer;
      fVLineThick:integer;
      fVertSkipText:integer;
      fVertSkipLine:integer;
      fHeight:integer;
      fFrameWidth: Integer;
      fFrameHeight: Integer;
      fLineIndent1:integer;
      fLineIndent2:integer;
      fWidth:integer;
      fDesignHeight:integer;
      fDesignWidth:integer;
      fDesign:TBitmap;
      fRubricFont:Tfont;
      fFieldFont:TFont;
      fLMargin:integer;
      fRMargin:integer;
      fTMargin:integer;
      forigpoint:TPoint;
      fPageColNo:integer;
      fPageRowNo:integer;
      procedure AdjustDimensions;
      procedure DrawFrame(Canvas:TCanvas);
      function PrintLine(Canvas:TCanvas;PrintPointX,PrintPointY:Integer;RubricText,FieldText:string):TPoint;
  public
      property Source:TBook read fsource write fsource;
      property PageColNo:integer read fPageColNo write fPageColNo;
      property PageRowNo:integer read fPageRowNo write fPageRowNo;
      constructor Create(Height,Width:integer);
      destructor Destroy;override;
      procedure Fill(Dataset:TIB_Dataset);
      procedure Paint(Canvas:TCanvas);
  end;

  TBookPlatePage = class(TObject)
  private
    fMaxCols:integer;
    fMaxRows:integer;
    fLabelHeight:integer;
    fLabelWidth:integer;
    fpageheight:integer;
    fpagewidth:integer;
    fCol:integer;
    fRow:integer;
    fpagefull:boolean;
    fBookPlateList:TList;
    function GetBookPlate(ACol,ARow:integer):TBookPlate;
    procedure setmaxcols(Value:integer);
    procedure setmaxrows(Value:integer);
    procedure setpageheight(Value:integer);
    procedure setpagewidth(Value:integer);

  public
    property Bookplates[ACol,ARow:integer]:TBookPlate read getBookPlate;
    property LabelHeight:integer read fLabelHeight write fLabelHeight;
    property LabelWidth:integer read fLabelWidth write fLabelWidth;
    property MaxCols:integer read fMaxCols write setMaxCols;
    property MaxRows:integer read fMaxRows write setMaxRows;
    property PageHeight:integer read fpageheight write setpageheight;
    property PageWidth:integer read fpagewidth write setpagewidth;
    property Pagefull:boolean read fpagefull;
    constructor Create;
    destructor Destroy; override;
    procedure AddBookPlate(ABookPlate:TBookPlate);
    procedure Clear;
    procedure AssemblePage(Canvas:TCanvas);
    procedure Print;
  end;

implementation

uses IMSData;

//_______TBookUses_______________________________________________________________________________________________

constructor TBookUses.Create;
var i:smallint;
begin
  inherited;
  OnNotify:=FreeOnRemove;
  i:=0;
  i:=Add(TBookUse.Create('Source','S','All books and sources',i));
  i:=Add(TBookUse.Create('Book','B','Books',i));
  i:=Add(TBookUse.Create('Fungi','F','Books on fungi',i));
  i:=Add(TBookUse.Create('Japanese','J','Japanese plant books',i));
  i:=Add(TBookUse.Create('Europe','E','European floras',i));
end;

destructor TBookUses.Destroy;
begin
  Clear;
  inherited;
end;

function TBookUses.FindUseName(AUseCode:ansistring):ansistring;
var i:smallint;
begin
   result:='';
   for i:=0 to Count do
      if Items[i].UseCode=AUseCode then result:=Items[i].UseName;
end;

function TBookUses.FindUseCode(AUseName:ansistring):ansistring;
var i:smallint;
begin
   result:='';
   for i:=0 to Count-1 do
      if Items[i].UseName=AUseName then result:=Items[i].UseCode;
end;

function TBookUses.FindUseIndex(AUseName:ansistring):smallInt;
var i:smallint;
begin
   result:=-1;
   for i:=0 to Count-1 do
      if Items[i].UseName=AUseName then result:=i;
end;

procedure TBookUses.FreeOnRemove(Sender: TObject; const Item: TBookUse; Action: TCollectionNotification);
begin
    if Action = cnRemoved then
       Item.Free;
end;

function TBookUses.IsValidCode(AUseCode:ansistring):boolean;
var i:smallint;
begin
   result:=false;
   for i:=0 to Count do
      if Items[i].UseCode=AUseCode then result:=true;
end;

//_______TBookUse_______________________________________________________________________________________________

constructor TBookUse.Create(NewName,NewCode,NewHeading:ansistring;NewIndex:smallInt);
begin
  inherited Create;
  fName:=NewName;
  fCode:=NewCode;
  fheading:=NewHeading;
  fIndex:=NewIndex;
end;

procedure TBookUse.Assign(AUse:TBookUse);
begin
    fIndex:=AUse.UseIndex;
    fName:=AUse.UseName;
    fCode:=AUse.UseCode;
end;

//_______TBook_______________________________________________________________________________________________

function TBook.AddUse(AUseName:ansistring):boolean;
var AUseCode:ansistring;
begin
  result:=false;
  AUseCode:=IMSDM.GetBookUseCode(AUseName);
  if AUseCode<>'' then
  begin
    if (ansipos(AUseCode,fUsedBy)=0) then
    begin
      fUsedBy:=fUsedBy+AUseCode;
      result:=True;
    end;
  end;
end;

procedure TBook.Assign(ABook: TBook);
begin
        fbookcode:=ABook.bookcode;
        fshortcode:=ABook.shortcode;
        fAuthor:=ABook.Author;
        fTitle:=ABook.Title;
        fVolume:=ABook.Volume;
        fEdition:=ABook.Edition;
        fPublisher:=ABook.Publisher;
        fPlace:=ABook.Place;
        fYearPub:=ABook.YearPub;
        fOrigTitle:=ABook.OrigTitle;
        fOPublisher:=ABook.OPublisher;
        fOPlace:=ABook.OPlace;
        fOYear:=ABook.OYear;
        fISBN:=ABook.ISBN;
        fSubject:=ABook.Subject;
        fDateAcquired:=ABook.DateAcquired;
        fPrice:=ABook.Price;
        fRef:=ABook.Ref;
        fUsedBy:=ABook.fUsedBy;
        fBookPlateStatus:=ABook.BookPlateStatus;
        fnbpages:=ABook.NumberOfPages;
        fnotes:=ABook.notes;
end;

procedure TBook.Clear;
begin
        fbookcode:='';
        fshortcode:='';
        fAuthor:='';
        fTitle:='';
        fVolume:='';
        fEdition:='';
        fPublisher:='';
        fPlace:='';
        fYearPub:='';
        fOPublisher:='';
        fOPlace:='';
        fOYear:='';
        fISBN:='';
        fSubject:='';
        fDateAcquired:='';
        fPrice:=0;
        fRef:='';
        fUsedBy:='';
        fBookPlateStatus:='';
        fnbpages:=0;
        fnotes:='';
end;

procedure TBook.ClearUses;
begin
  fUsedBy:='';
end;

function TBook.Compare(ABook: TBook):string;
begin
      result:='';
        if fbookcode<>ABook.bookcode then result:=result+',bookcode';
        if fshortcode<>ABook.shortcode then result:=result+',shortcode';
        if fAuthor<>ABook.Author then result:=result+',Author';
        if fTitle<>ABook.Title then result:=result+',Title';
        if fVolume<>ABook.Volume then result:=result+',Volume';
        if fEdition<>ABook.Edition then result:=result+',Edition';
        if fPublisher<>ABook.Publisher then result:=result+',Publisher';
        if fPlace<>ABook.Place then result:=result+',Place';
        if fYearPub<>ABook.YearPub then result:=result+',YearPub';
        if fTitle<>ABook.OrigTitle then result:=result+',OrigTitle';
        if fOPublisher<>ABook.OPublisher then result:=result+',OPublisher';
        if fOPlace<>ABook.OPlace then result:=result+',OPlace';
        if fOYear<>ABook.OYear then result:=result+',OYear';
        if fISBN<>ABook.ISBN then result:=result+',ISBN';
        if fSubject<>ABook.Subject then result:=result+',Subject';
        if fDateAcquired<>ABook.DateAcquired then result:=result+',DateAcquired';
        if fPrice<>ABook.Price then result:=result+',Price';
        if fRef<>ABook.Ref then result:=result+',Ref';
        if UsedBy<>ABook.UsedBy then result:=result+',UsedBy';
        if fnbpages<>ABook.NumberOfPages then result:=result+',NumberOfPages';
        if fBookPlateStatus<>ABook.BookPlateStatus then result:=result+',BookPlateStatus';
        if fnotes<>ABook.notes then result:=result+',notes';
        if (length(result)>0) then result:=copy(result,2,length(result)-1);
end;


function TBook.IsEmpty:boolean;
begin
  result:=(fbookcode='');
end;

procedure TBook.ReadFromDataset(Dataset:TIB_Dataset);
// assumes dataset is prepared and active
begin
        Clear;
        if not (Dataset.FindField('BOOKCODE')=nil) and (not Dataset.FindField('BOOKCODE').IsNull) then fbookcode:=Dataset.FieldValues['BOOKCODE'];
        if not (Dataset.FindField('SHORTCODE')=nil) and (not Dataset.FindField('SHORTCODE').IsNull) then fshortcode:=Dataset.FieldValues['SHORTCODE'];
        if not (Dataset.FindField('AUTHOR')=nil) and (not Dataset.FindField('AUTHOR').IsNull) then fAuthor:=Dataset.FieldValues['AUTHOR'];
        if not (Dataset.FindField('TITLE')=nil) and (not Dataset.FindField('TITLE').IsNull) then fTitle:=Dataset.FieldValues['TITLE'];
        if not (Dataset.FindField('VOLUME')=nil) and (not Dataset.FindField('VOLUME').IsNull) then fVolume:=Dataset.FieldValues['VOLUME'];
        if not (Dataset.FindField('EDITION')=nil) and (not Dataset.FindField('EDITION').IsNull) then fEdition:=Dataset.FieldValues['EDITION'];
        if not (Dataset.FindField('PUBLISHER')=nil) and (not Dataset.FindField('PUBLISHER').IsNull) then fPublisher:=Dataset.FieldValues['PUBLISHER'];
        if not (Dataset.FindField('PLACE')=nil) and (not Dataset.FindField('PLACE').IsNull) then fPlace:=Dataset.FieldValues['PLACE'];
        if not (Dataset.FindField('YEAR_PUBL')=nil) and (not Dataset.FindField('YEAR_PUBL').IsNull) then fYearPub:=Dataset.FieldValues['YEAR_PUBL'];
        if not (Dataset.FindField('ORIGTITLE')=nil) and (not Dataset.FindField('ORIGTITLE').IsNull) then fOrigTitle:=Dataset.FieldValues['ORIGTITLE'];
        if not (Dataset.FindField('OPUBLISHER')=nil) and (not Dataset.FindField('OPUBLISHER').IsNull) then fOPublisher:=Dataset.FieldValues['OPUBLISHER'];
        if not (Dataset.FindField('OPLACE')=nil) and (not Dataset.FindField('OPLACE').IsNull) then fOPlace:=Dataset.FieldValues['OPLACE'];
        if not (Dataset.FindField('OYEAR')=nil) and (not Dataset.FindField('OYEAR').IsNull) then fOYear:=Dataset.FieldValues['OYEAR'];
        if not (Dataset.FindField('ISBN')=nil) and (not Dataset.FindField('ISBN').IsNull) then fISBN:=Dataset.FieldValues['ISBN'];
        if not (Dataset.FindField('SUBJECT')=nil) and (not Dataset.FindField('SUBJECT').IsNull) then fSubject:=Dataset.FieldValues['SUBJECT'];
        if not (Dataset.FindField('DATE_ACQ')=nil) and (not Dataset.FindField('DATE_ACQ').IsNull) then fDateAcquired:=Dataset.FieldValues['DATE_ACQ'];
        if not (Dataset.FindField('REF')=nil) and (not Dataset.FindField('REF').IsNull) then fRef:=Dataset.FieldValues['REF'];
        if not (Dataset.FindField('PRICE')=nil) and (not Dataset.FindField('PRICE').IsNull) then fPrice:=Dataset.FieldValues['PRICE'];
        if not (Dataset.FindField('NUMBERPAGES')=nil) and (not Dataset.FindField('NUMBERPAGES').IsNull) and (Dataset.FieldByName('NUMBERPAGES').AsInteger>=0) then fnbpages:=Dataset.FieldValues['NUMBERPAGES'];
        if not (Dataset.FindField('USEDBY')=nil) and (not Dataset.FindField('USEDBY').IsNull) then fusedby:=Dataset.FieldValues['USEDBY'];
        if not (Dataset.FindField('PRINT')=nil) and (not Dataset.FindField('PRINT').IsNull) then fBookPlateStatus:=Dataset.FieldValues['PRINT'];
        if fBookPlateStatus='' then fBookPlateStatus:=' ';
        if not (Dataset.FindField('NOTES')=nil) and (not Dataset.FindField('NOTES').IsNull) then fnotes:=Dataset.FieldValues['NOTES'];
end;


function TBook.StripUse(AUseName:ansistring):boolean;
var k:integer; AUseCode:ansistring;
begin
  result:=false;
  AUseCode:=IMSDM.GetBookUseCode(AUseName);
  if AUseCode<>'' then
  begin
    k:=ansipos(AUseCode,fUsedBy);
    if k>0 then
    begin
      fUsedby:=stuffstring(fusedBy,k,1,'');
      result:=True;
    end;
  end;
end;

procedure TBook.WriteToDataset(Dataset:TIB_Query);
// assumes dataset is assigned, prepared and active
begin
     with Dataset do
      try
        if State=dssBrowse then Edit;
        FieldValues['BOOKCODE']:=fbookcode;
        FieldValues['SHORTCODE']:=fshortcode;
        FieldValues['NUMBERPAGES']:=fnbpages;
        FieldValues['NOTES']:=fnotes;
        FieldValues['AUTHOR']:=fAuthor;
        FieldValues['TITLE']:=fTitle;
        FieldValues['VOLUME']:=fVolume;
        FieldValues['EDITION']:=fEdition;
        FieldValues['PUBLISHER']:=fPublisher;
        FieldValues['PLACE']:=fPlace;
        FieldValues['YEAR_PUBL']:=fYearPub;
        FieldValues['ORIGTITLE']:=fOrigTitle;
        FieldValues['OPUBLISHER']:=fOPublisher;
        FieldValues['OPLACE']:=fOPlace;
        FieldValues['OYEAR']:=fOYear;
        FieldValues['ISBN']:=fISBN;
        FieldValues['SUBJECT']:=fSubject;
        FieldValues['DATE_ACQ']:=fDateAcquired;
        FieldValues['PRICE']:=fPrice;
        FieldValues['REF']:=fRef;
        FieldValues['USEDBY']:=fUsedBy;
        if fBookPlateStatus='' then FieldValues['PRINT']:=' '
        else FieldValues['PRINT']:=fBookPlateStatus;
        FieldValues['MARKER']:='S';   //ensure consistency with other apps
        IMSDM.ExplicitPost(Dataset);
      except on e:EIB_StatementError do ShowMessage('Error writing data for book '+fbookcode+' '+e.Message);
      end;
end;

//_______TPageRef______________________________________________________________________________________________

constructor TPageRef.Create(orgcode:ansistring);
begin
  Create;
  forgcode:=orgcode;
  fpageno:=0;
  end;

constructor TPageRef.Create(orgcode:ansistring;bookcode:string;pageno:integer);
begin
  Create;
  forgcode:=orgcode;
  fbookcode:=bookcode;
  fpageno:=pageno;
  frefcode:='';
  end;

constructor TPageRef.Create(orgcode:ansistring;bookcode:string;refcode:string);
begin
  Create;
  forgcode:=orgcode;
  fbookcode:=bookcode;
  frefcode:=refcode;
  fpageno:=0;
  end;

procedure TPageRef.Assign(APageRef: TPageRef);
begin
  forgcode:=APageRef.orgcode;
  fbookcode:=APageRef.bookcode;
  fpageno:=APageRef.pageno;
  frefcode:=APageRef.refcode;
  fnotes:=APageRef.notes;
  fvolume:=APageRef.volume;
end;

procedure TPageRef.Clear;
begin
    forgcode:='';
    fbookcode:='';
    fvolume:='';
    fpageno:=0;
    frefcode:=' ';
    fnotes:='';
end;

procedure TPageRef.ReadFromDataset(Dataset:TIB_Dataset);
// assumes dataset is assigned, prepared and active
begin
            forgcode:=Dataset.FieldValues['orgcode'];
            fbookcode:=Dataset.FieldValues['bookcode'];
            fpageno:=Dataset.FieldByName('pageno').AsInteger;
            frefcode:=Dataset.FieldByName('refcode').AsString;
            fnotes:=Dataset.FieldByName('notes').AsString;
            fvolume:=Dataset.FieldByName('volume').AsString;
end;

procedure TPageRef.WriteToDataset(Dataset:TIB_Query);
// assumes dataset is assigned, prepared and active
begin
      try
        with Dataset do
        begin
            FieldValues['orgcode']:=forgcode;
            FieldValues['bookcode']:=fbookcode;
            FieldValues['pageno']:=fpageno;
            FieldValues['refcode']:=frefcode;
            FieldValues['notes']:=fnotes;
            FieldValues['volume']:=fvolume;
            Post;
        end;
      except
          on e:EIB_StatementError do ShowMessage('Error writing ref data for '+forgcode+' '+e.message)
      end;
end;

//_______TBookPlate_______________________________________________________________________________________________

constructor TBookPlate.Create(Height,Width:integer);
begin
    inherited Create;
    fHeight:=Height;
    fWidth:=Width;
    fDesign:=TBitmap.Create;
    fDesign.LoadFromFile('Images\BookPlateImage.bmp');
    fRubricFont:=TFont.Create;
    fFieldFont:=TFont.Create;
    fRubricFont.Color:= clBlack;
    fRubricFont.Size:=11;
    fRubricFont.Style:=[fsBold];
    fRubricFont.Name:= 'ITC Fenice Std';
    fFieldFont.Assign(fRubricFont);
    fFieldFont.Name:= 'Monotype Corsiva';
    fFieldFont.Style:=[fsItalic];
    fFieldFont.Height:=fRubricFont.Height;
    fFieldFont.Style:=[];
    fPageColNo:=1;
    fPageRowNo:=1;
end;

destructor TBookPlate.Destroy;
begin
  FreeAndNil(fDesign);
  FreeAndNil(fRubricFont);
  FreeAndNil(fFieldFont);
  FreeAndNil(fsource);

  inherited;
end;

procedure TBookPlate.AdjustDimensions;
begin
    fDesignHeight:=MulDiv(fHeight,550,1485);       //set design height relative to height of bookplate (55mm)
    fDesignWidth:=MulDiv(fWidth,31,87);        //set design width relative to width of bookplate (31mm on 134.5)
    fHSpacing:=MulDiv(fDesignWidth,108,1000);    // set all other dimensions relative to design
    fVSpacing:=MulDiv(fDesignHeight,13,100);
    fLineIndent1:=MulDiv(fDesignWidth,216,1000);    //left frame line pos
    fLineIndent2:=fDesignWidth+1;
    //VLineThick:=MulDiv(LabelHeight,40,100);
    fVertSkipLine:=MulDiv(fDesignHeight,666,1000); // top frame line pos  ==2/3
    fVertSkipText:=fDesignHeight;                 //lower text section
    fHLineThick:=MulDiv(fWidth,13,1000);
    fVLineThick:=fHLineThick;
    //set margins
    fTMargin:=muldiv(fHeight,9,210);   // 9mm blank top border on 210mm label height
    fLMargin:=muldiv(fWidth,70,1485);   // 7mm blank left border on 148.5mm label width
    fRMargin:=fLMargin;
    fFrameWidth:=fWidth-fLMargin-fLineIndent1-fHSpacing-fRMargin;
    fFrameHeight:=MulDiv(fDesignHeight,96,55);  //excludes line thickness
end;

procedure TBookPlate.DrawFrame(Canvas:TCanvas);
var X,Y,Gap:integer;
begin
  X:=fOrigPoint.X+fLMargin;
  Y:=fOrigPoint.Y+fTMargin;
 try
    Canvas.StretchDraw(Rect(X,Y,X+fDesignWidth,Y+fDesignHeight),fDesign);
    //frame
    Canvas.Pen.Color:=clBlack;
    Canvas.Pen.Style:=psSolid;
    Canvas.Pen.Width:=fHLineThick;
    Canvas.MoveTo(X+fLineIndent1,Y+fDesignHeight);  //start in top left under bitmap
    Canvas.LineTo(X+fLineIndent1,Y+fVertSkipLine+fFrameHeight);    //L frame
    Canvas.LineTo(X+fLineIndent1+fFrameWidth,Y+fVertSkipLine+fFrameHeight);   //B
    Canvas.LineTo(X+fLineIndent1+fFrameWidth,Y+fVertSkipLine);  //R
    Canvas.LineTo(X+fLineIndent2,Y+fVertSkipLine);            //T
    Canvas.Pen.Width:=2;
    Gap:=fHLineThick div 2;     // square off corners of frame
    Canvas.MoveTo(X+fLineIndent2-Gap,Y+fVertSkipLine-Gap);
    Canvas.LineTo(X+fLineIndent1+fFrameWidth+Gap,Y+fVertSkipLine-Gap);   //T
    Canvas.LineTo(X+fLineIndent1+fFrameWidth+Gap,Y+fVertSkipLine+fFrameHeight+Gap);  //R
    Canvas.LineTo(X+fLineIndent1-Gap,Y+fVertSkipLine+fFrameHeight+Gap);    //B
    Canvas.LineTo(X+fLineIndent1-Gap,Y+fDesignHeight);            //T
  finally
    Canvas.MoveTo(X,Y);
  end;
end;


procedure TBookplate.Fill(Dataset:TIB_Dataset);
var TextString:string;
begin
        if source<>nil then source.ReadFromDataset(Dataset);
        fauthor:=source.Author;
        ftitle:=source.title;
        fvolume:=source.volume;
        fedition:=source.edition;
        if source.publisher>'' then
        begin
          TextString:=source.publisher;
          if Dataset.FieldValues['PLACE']>'' then TextString:=TextString+', '+Dataset.FieldValues['PLACE'];
          if Dataset.FieldValues['YEAR_PUBL']>'' then TextString:=TextString+', '+Dataset.FieldValues['YEAR_PUBL'];
          fpubdata:=TextString;
        end;
        if source.fOrigTitle>'' then fOrigTitle:=source.fOrigTitle;
        if source.fopublisher>'' then
        begin
          TextString:=Dataset.FieldValues['OPUBLISHER'];
          if Dataset.FieldValues['OPLACE']>'' then TextString:=TextString+', '+Dataset.FieldValues['OPLACE'];
          if Dataset.FieldValues['OYEAR']>'' then TextString:=TextString+', '+Dataset.FieldValues['OYEAR'];
          fopubdata:=TextString;
        end;
        fisbn:=source.fisbn;
        fsubject:=source.fsubject;
        fdateacquired:=source.fdateacquired;
        fref:=source.ref;
end;

procedure TBookPlate.Paint(Canvas:TCanvas);
var PP:TPoint; X,Y:Integer;
begin
        fOrigPoint.X:=(fPageColNo-1)*fWidth;
        fOrigPoint.Y:=(fPageRowNo-1)*fHeight;
        AdjustDimensions;
                //white background over whole area
        Canvas.Brush.Style:=bsSolid;
        Canvas.Brush.Color:=clWhite;
        Canvas.FillRect(Rect(fOrigPoint.X,fOrigPoint.Y,fWidth,fHeight));  //white background
        Canvas.Brush.Style:=bsClear;

{$IFDEF DEBUG}
        // draw edge of label for testing
        Canvas.MoveTo(fOrigPoint.X,fOrigPoint.Y);  //start in top left
        Canvas.LineTo(fOrigPoint.X+fWidth-1,fOrigPoint.Y);    //T frame
        Canvas.LineTo(fOrigPoint.X+fWidth-1,fOrigPoint.Y+fHeight-1);   //R
        Canvas.LineTo(fOrigPoint.X,fOrigPoint.Y+fHeight-1);  //B
        Canvas.LineTo(fOrigPoint.X,fOrigPoint.Y);            //L
{$ENDIF}

        X:=fOrigPoint.X+fLMargin;        // origin of usable area
        Y:=fOrigPoint.Y+fTMargin;

        DrawFrame(Canvas);
        fFieldFont.Height := fRubricFont.Height;
        PP.X:=X;
        PP.Y:=Y;
        if fauthor>'' then PP:=PrintLine(Canvas,X+fDesignWidth+fHSpacing,Y,'Auteur : ',fauthor);
        if fTitle>'' then PP:=PrintLine(Canvas,X+fDesignWidth+fHSpacing,PP.Y+fVSpacing,'Titre : ',fTitle);
        PP.Y:=Y+fVertSkipText;
        if fVolume>'' then PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'Volume : ',fVolume);
        if fEdition>'' then PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'Edition : ',fEdition);
        if fPubdata>'' then
          PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'Editeur : ',fPubdata);
        if fOrigTitle>'' then
          PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'Titre original : ',fOrigTitle);
        if fOPubdata>'' then
          PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'Editeur original : ',fOPubdata);
        if fISBN>'' then PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'ISBN : ',fISBN);
        if fSubject>'' then PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'Classement : ',fSubject);
        if fDateAcquired>'' then PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'Date d''acquisition : ',fDateAcquired);
        if fref>'' then PP:=PrintLine(Canvas,X+fLineIndent1+fHSpacing,PP.Y+fVSpacing,'R�f�rence : ',fref);
end;

function TBookPlate.PrintLine(Canvas:TCanvas;PrintPointX,PrintPointY:Integer;RubricText,FieldText:string):TPoint;
var TextString,rest:string; x1,i,j,k,ksp,kpun,len, imin,imax,textw:Integer; spacepos:array[1..30] of integer;
begin
    begin
      Canvas.Font.Assign(fRubricFont);
      Canvas.TextOut(PrintPointX,PrintPointY,RubricText);
      x1:=Canvas.PenPos.X;        //current pos
      Canvas.Font.Assign(fFieldFont);
      len:=Length(FieldText);
      TextString:=FieldText;
      rest:=FieldText;
      textw:=Canvas.TextWidth(TextString);
      if x1+textw<(fOrigPoint.X+fWidth-fRMargin-fHSpacing) then
          Canvas.TextOut(x1,PrintPointY,TextString)
      else begin
          j:=0;                                            // too long so find break point
          i:=1;
          imin:=1;
          k:=len+1;
          while k>1 do begin
            ksp:=Pos(' ',Copy(TextString,j+1,len));
             if (ksp>0) and (ksp<k) then k:=ksp;
            kpun:=Pos('/',Copy(TextString,j+1,len));
             if (kpun>0) and (k-kpun>1) then k:=kpun;
            kpun:=Pos('-',Copy(TextString,j+1,len));
             if (kpun>0) and (k-kpun>1) then k:=kpun;
            kpun:=Pos(':',Copy(TextString,j+1,len));
             if (kpun>0) and (k-kpun>1) then k:=kpun;
            j:=j+k;
            spacepos[i]:=k;          // fill array with positions of spaces or punctuation
            inc(i);
            k:=Length(Copy(TextString,j+1,len))+1;
          end;
          imax:=i-1;
          Dec(i);                              // we already know the full line won't fit,
          TextString:=Copy(rest,1,j-1);        // so remove last word
          while TextString<>'' do begin         //work back through text till it fits
            while x1+Canvas.TextWidth(TextString)>(fOrigPoint.X+fWidth-fRMargin-fHSpacing) do
            begin
              if i=imin then                   //no more spaces or punctuation in text
                j:=Round(Length(rest)/2)+1     // if no space cut in half, add 1 because space is cut
              else j:=j-spacepos[i];
              if i<imin then raise exception.create('No space to output value');  // error in penpos, should never happen!
              dec(i);
              TextString:=Copy(rest,1,j-1);
            end;
            Canvas.TextOut(x1,PrintPointY,TextString);        // print line of text
            x1:=PrintPointX;
            PrintPointY:=PrintPointY+Canvas.TextHeight(TextString);
            rest:=Copy(rest,j+1,len);
            TextString:=rest;
            j:=Length(rest)+1;
            imin:=i+1;            //ignore spaces in text dealt with
            i:=imax;
          end;

      end;
      Result:=Canvas.PenPos;
    end;
end;

//_______TBookPlatePage_______________________________________________________________________________________________


constructor TBookPlatePage.Create;
begin
  inherited;
  fMaxCols:=0;
  fMaxRows:=0;
  fCol:=1;
  fRow:=1;
  fBookPlateList:=TList.Create;
end;

destructor TBookPlatePage.Destroy;
begin
  fBookPlateList.Clear;
  FreeAndNil(fBookPlateList);
  inherited;
end;

procedure TBookPlatePage.AddBookPlate(ABookPlate:TBookPlate);
begin
    if not fPagefull then
    begin
      ABookPlate.PageRowNo:=fRow;       //from 1 to MaxRow/Col
      ABookPlate.PageColNo:=fCol;
      fBookPlateList.Add(ABookPlate);
      Inc(fCol);
      if fCol>fMaxCols then
      begin
            fCol:=1;
            Inc(fRow);
            if fRow>fMaxRows then fRow:=1;
      end;
      if (fCol=1) and (fRow=1) then
      begin
            fPageFull:=true;
      end;
    end;
end;

procedure TBookPlatePage.AssemblePage(Canvas:TCanvas);
var i,j:integer;ABookPlate:TBookPlate;
begin
    if Assigned(Canvas) then begin
      Canvas.Brush.Style:=bsSolid;
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(Rect(0,0,maxcols*fLabelWidth-1,maxrows*fLabelHeight-1));

      for j:= 1 to fMaxRows do
        for i:= 1 to fMaxCols do
        begin
          ABookPlate:=BookPlates[i,j];
          if ABookPlate<>nil then
          begin
            ABookPlate.Paint(Canvas);
          end;
        end;
      fPageFull:=false;
    end;
end;

procedure TBookPlatePage.Clear;
var i:integer;ABookPlate:TBookPlate;
begin
   for i := 1 to fBookPlateList.Count do
   begin
        ABookPlate:=fBookPlateList[i-1];
        if ABookPlate<>nil then
            FreeAndNil(ABookPlate);
   end;
  fBookPlateList.Clear;
end;

function TBookPlatePage.getBookPlate(ACol,ARow:integer):TBookPlate;
var i:integer;ABookPlate:TBookPlate;
begin
   result:=nil;
   for i := 1 to fBookPlateList.Count do
   begin
        ABookPlate:=fBookPlateList[i-1];
       if (ABookPlate.PageColNo=ACol) and (ABookPlate.PageRowNo=ARow) then
       begin
          result:=ABookPlate;
          break;
       end;
   end;
end;

procedure TBookPlatePage.Print;
begin
 try
   try
      Printer.BeginDoc;
      AssemblePage(Printer.Canvas);
   except
    on e:exception do
    begin
      if Printer.Printing then Printer.Abort;
      raise;
    end;
   end;
   finally
      Printer.EndDoc;
      fPageFull:=false;
   end;
end;

procedure TBookPlatePage.setPageHeight(Value:integer);
begin
    if fPageHeight<>Value then
    begin
        fPageHeight:=Value;
        if fMaxRows>0 then fLabelHeight:=fPageHeight div fMaxRows
        else if fLabelHeight>0 then fMaxRows:=fPageHeight div fLabelHeight;
    end;
end;

procedure TBookPlatePage.setPageWidth(Value:integer);
begin
    if fPageWidth<>Value then
    begin
        fPageWidth:=Value;
        if fMaxCols>0 then fLabelWidth:=fPageWidth div fMaxCols
        else if fLabelWidth>0 then fMaxCols:=fPageWidth div fLabelWidth;
    end;

end;


procedure TBookPlatePage.setmaxcols(Value:integer);
begin
    if fMaxCols<>Value then
    begin
        fMaxCols:=Value;
        if fPageWidth>0 then fLabelWidth:=fPageWidth div fMaxCols
        else if fLabelWidth>0 then fPageWidth:=fMaxCols*fLabelWidth;
    end;
end;

procedure TBookPlatePage.setmaxrows(Value:integer);
begin
    if fMaxRows<>Value then
    begin
        fMaxRows:=Value;
        if fPageHeight>0 then fLabelHeight:=fPageHeight div fLabelHeight
        else if fLabelHeight>0 then fPageHeight:=fMaxRows*fLabelHeight;
    end;
end;

end.
