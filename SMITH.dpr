program SMITH;

uses
  Forms,
  IMSMain in 'IMSMain.pas' {iMSHomeForm},
  Books in 'Books.pas' {BooksForm},
  BPPrint in 'BPPrint.pas' {BPPrintForm},
  BookConcepts in 'BookConcepts.pas',
  IMSData in 'IMSData.pas' {IMSDM: TDataModule},
  OrganismSelect in 'OrganismSelect.pas' {OrganismSelectForm},
  EUPlants in 'EUPlants.pas' {EUPlantsForm},
  PlantCardEditor in 'PlantCardEditor.pas' {PlantCardEditForm},
  ForayConcepts in 'ForayConcepts.pas',
  ueppt in 'ueppt.pas',
  OrgNameSelect in 'OrgNameSelect.pas' {OrgNameSelectForm},
  Refs in 'Refs.pas' {BookRefsForm},
  OrganismEdit in 'OrganismEdit.pas' {OrganismEditForm},
  JPEMain in 'JPEMain.pas' {JPEditorForm},
  Forays in 'Forays.pas' {ForayForm},
  Finds in 'Finds.pas' {FindsForm},
  OrganismConcepts in 'OrganismConcepts.pas',
  Admin in 'Admin.pas' {AdminForm},
  EUDMain in 'EUDMain.pas' {EUMainForm},
  OrgNameReview in 'OrgNameReview.pas' {OrgNameReviewForm};

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SMITH';
  Application.CreateForm(TIMSHomeForm, IMSHomeForm);
  Application.CreateForm(TBPPrintForm, BPPrintForm);
  Application.CreateForm(TIMSDM, IMSDM);
  Application.CreateForm(TBooksForm, BooksForm);
  Application.CreateForm(TOrganismSelectForm, OrganismSelectForm);
  Application.CreateForm(TEUPlantsForm, EUPlantsForm);
  Application.CreateForm(TPlantCardEditForm, PlantCardEditForm);
  Application.CreateForm(TOrganismEditForm, OrganismEditForm);
  Application.CreateForm(TOrgNameSelectForm, OrgNameSelectForm);
  Application.CreateForm(TBookRefsForm, BookRefsForm);
  Application.CreateForm(TJPEditorForm, JPEditorForm);
  Application.CreateForm(TForayForm, ForayForm);
  Application.CreateForm(TFindsForm, FindsForm);
  Application.CreateForm(TAdminForm, AdminForm);
  Application.CreateForm(TEUMainForm, EUMainForm);
  Application.CreateForm(TEUMainForm, EUMainForm);
  Application.CreateForm(TOrgNameReviewForm, OrgNameReviewForm);
  Application.Run;
end.
