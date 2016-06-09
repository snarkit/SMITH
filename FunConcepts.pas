unit FunConcepts;


interface
uses OrganismConcepts, classes, IB_Components;

type

  TFunOrganism = class(TOrganism)
  private
    fRefCount:integer;
    fFindCount: integer;
    fNamedataset: TIB_Dataset;
  public
    property findCount: integer read fFindCount write fFindCount;
    property refCount:integer read fRefCount write fRefCount;
    property Namedataset:TIB_Dataset read fNamedataset write fNamedataset;
  end;


  TFind = class(TObject)
  private
    fforaycode:string;
    feppocode:string;
    fnotes: string;
  public
    property foraycode:string read fforaycode write fforaycode;
    property eppocode:string read feppocode write feppocode;
    property notes: string read fnotes write fnotes;
  end;

  TForay = class(TObject)
  private
    fforaycode:string;
    fforayname:string;
    fforaycountry:string;
    fforayplace:string;
    fforaydate:TDate;
    fnotes: string;
  public
    property foraycode:string read fforaycode write fforaycode;
    property forayname:string read fforayname write fforayname;
    property foraycountry: string read fforaycountry write fforaycountry;
    property forayplace: string read fforayplace write fforayplace;
    property foraydate: TDate read fforaydate write fforaydate;
    property notes: string read fnotes write fnotes;
  end;


implementation




end.
