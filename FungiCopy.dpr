program FungiCopy;

uses
  Forms,
  FungiTransfer in 'FungiTransfer.pas' {FungiTransferForm},
  BookConcepts in 'BookConcepts.pas',
  IMSData in 'IMSData.pas' {IMSDM: TDataModule},
  FungusEdit in 'FungusEdit.pas' {ForayEditForm},
  ForayConcepts in 'ForayConcepts.pas',
  ForayData in 'ForayData.pas' {ForayDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'BookCopy';
  Application.CreateForm(TFungiTransferForm, FungiTransferForm);
  Application.CreateForm(TForayEditForm, ForayEditForm);
  Application.CreateForm(TIMSDM, IMSDM);
  Application.CreateForm(TForayDM, ForayDM);
  Application.Run;
end.
