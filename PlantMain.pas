unit PlantMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JPEMain, StdCtrls, jpeg, BookConcepts, ExtCtrls ;

type
  TPlantMainForm = class(TForm)
    Image1: TImage;
    JPPlantsButton: TButton;
    EurPlantsButton: TButton;
    procedure JPPlantsButtonClick(Sender: TObject);
    procedure EurPlantsButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlantMainForm: TPlantMainForm;

implementation

uses IMSMain, OrganismSelect, EUPlants, IMSData;

{$R *.dfm}

procedure TPlantMainForm.EurPlantsButtonClick(Sender: TObject);
begin
  IMSHomeForm.CurrentUse:=Euro;
  OrganismSelectForm.OrglistGrid.DataSource.Dataset:=IMSDM.AllEUPlantNames;
  OrganismSelectForm.Show;
end;

procedure TPlantMainForm.JPPlantsButtonClick(Sender: TObject);
begin
  IMSHomeForm.CurrentUse:=JP;
  JPEditorForm.ShowModal;
end;

end.
