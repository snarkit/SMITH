program DatabaseExtract;

uses
  Forms,
  DataExtractor in 'DataExtractor.pas' {DatapumpForm},
  IMSData in 'IMSData.pas' {IMSDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatapumpForm, DatapumpForm);
  Application.CreateForm(TIMSDM, IMSDM);
  Application.Run;
end.
