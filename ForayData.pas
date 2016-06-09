unit ForayData;

interface

uses
  SysUtils, Classes, IB_Components, IB_Access;

type
  TForayDM = class(TDataModule)
    NewForaysQuery: TIB_Query;
    NewForaysDS: TIB_DataSource;
    ForayConnection: TIB_Connection;
    FunTransaction: TIB_Transaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ForayDM: TForayDM;

implementation

{$R *.dfm}

end.
