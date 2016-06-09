unit BookData;

interface

uses
  SysUtils, Classes, IB_Components, IB_Access, BookConcepts,
  Dialogs, OrganismConcepts;

type
  TBooksDM = class(TDataModule)
    BookConnection: TIB_Connection;
    BookCursor: TIB_Cursor;
    NewBooksQuery: TIB_Query;
    NewBooksDS: TIB_DataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BooksDM: TBooksDM; CurrentBook:TBook;

implementation

{$R *.dfm}

end.
