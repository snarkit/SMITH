unit EUPlants;
//this is a skeleton at present
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid;

type
  TEUPlantsForm = class(TForm)
    EUPlantsGrid: TIB_Grid;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EUPlantsForm: TEUPlantsForm;

implementation

{$R *.dfm}

procedure TEUPlantsForm.FormActivate(Sender: TObject);
begin
  EUPlantsGrid.DataSource.Dataset.Open;
end;

end.
