program BookCopy;

uses
  Forms,
  FungiTransfer in 'FungiTransfer.pas' {BooksTransferForm},
  BookConcepts in 'BookConcepts.pas',
  IMSData in 'IMSData.pas' {IMSDM: TDataModule},
  FungusEdit in 'FungusEdit.pas' {BookEditForm},
  ForayConcepts in 'ForayConcepts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'BookCopy';
  Application.CreateForm(TBooksTransferForm, BooksTransferForm);
  Application.CreateForm(TBookEditForm, BookEditForm);
  Application.CreateForm(TIMSDM, IMSDM);
  Application.Run;
end.
