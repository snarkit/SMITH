unit DataExtractor;
{example showing how to use the datapump
It copies eppt links from  LINKS into either species-genus or genus-family }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IB_Components, IB_Process, IB_DataScan, IB_DataPump,
  IB_Access, Grids, IB_Grid, StrUtils, IB_Dialogs;

type
  TDatapumpForm = class(TForm)
    PumpButton: TButton;
    SrcDataQuery: TIB_Query;
    SrcData: TIB_DataSource;
    DSTStatement: TIB_DSQL;
    DataPump: TIB_DataPump;
    SrcDataGrid: TIB_Grid;
    TestButton: TButton;
    TableCombo: TComboBox;
    Label1: TLabel;
    procedure PumpButtonClick(Sender: TObject);
    procedure TestButtonClick(Sender: TObject);
    procedure DataPumpAfterFetchRow(ARow: TIB_Row);
    procedure TableComboChange(Sender: TObject);
  private
    { Private declarations }
    procedure FillForSpeciesGenus;
    procedure FillForGenusFamily;
  public
    { Public declarations }
  end;

var
  DatapumpForm: TDatapumpForm;

implementation

{$R *.dfm}

procedure TDatapumpForm.DataPumpAfterFetchRow(ARow: TIB_Row);
// must provide all output column values, or they are null
var genus,family,orgcode:ansistring;
begin
 try
  if TableCombo.ItemIndex=0 then     //species-genus
  begin
    genus:=ARow.ByName('codeparent').Value;
    DstStatement.ParamByName('datatype').Value:=ARow.ByName('datatype').Value;
    DstStatement.ParamByName('speciescode').Value:=ARow.ByName('code').Value;
    DstStatement.ParamByName('genuscode').Value:=genus;
    orgcode:=ARow.ByName('code').Value;
  end
  else begin
    DstStatement.ParamByName('genuscode').Value:=ARow.ByName('code').Value;
    DstStatement.ParamByName('familycode').Value:=ARow.ByName('codeparent').Value;
  end;
 except
    on e:exception do
      ShowMessage(e.message+' error at '+genus+' for '+orgcode);
 end;
end;


procedure TDatapumpForm.FillForGenusFamily;
//set of parameters for Species-Genus which
// define SQL code for source query
// define SQL code for destination insert query
// define mapping of columns to destination from source

begin
    SrcDataQuery.SQL.Text:='SELECT CODE,CODEPARENT,LINKID '+
      'FROM LINKS WHERE (idlinkcode=9) AND (code like ''1%G'') and (codeparent like ''1%S'') AND (statuslink = ''A'') ';
    DstStatement.SQL.Text:='Insert into GenusFamilyLink (Genuscode, familycode) '+
      'Values (:genuscode, :familycode)';
    Datapump.DstLinks.Strings[0]:=':genuscode=code';
    Datapump.DstLinks.Strings[1]:=':familycode=codeparent';
end;

procedure TDatapumpForm.FillForSpeciesGenus;
//set of parameters for Species-Genus which
// define SQL code for source query
// define SQL code for destination insert query
// define mapping of columns to destination from source
begin
    SrcDataQuery.SQL.Text:='SELECT DATATYPE,CODE,CODEPARENT,DATATYPE_PARENT,STATUSLINK,LINKID '+
      'FROM LINKS WHERE (idlinkcode=9) AND (datatype = ''GAF'') AND (statuslink = ''A'') '+
      'AND code not in (select speciescode from speciesgenuslink)';
    DstStatement.SQL.Text:='Insert into SpeciesGenusLink (Datatype, Speciescode, Genuscode) '+
      'Values (:datatype, :speciescode, :genuscode)';
    Datapump.DstLinks.Strings[0]:=':datatype=datatype';
    Datapump.DstLinks.Strings[1]:=':speciescode=code';
    Datapump.DstLinks.Strings[2]:=':genuscode=codeparent';
end;

procedure TDatapumpForm.PumpButtonClick(Sender: TObject);
begin
  try
      SrcDataQuery.Prepare;
      DstStatement.Prepare;
      Datapump.Prepare;
      Datapump.Execute;
  except
      on e:exception do
      begin
        ShowMessage('Failed with '+e.Message);
        ShowMessage('Failed at '+DstStatement.ParamByName('genuscode').Value);
      end;
  end;
end;

procedure TDatapumpForm.TableComboChange(Sender: TObject);
var Operation:integer;
begin
   Operation:=(sender as TComboBox).ItemIndex;
   case of Operation
   0: FillForSpeciesGenus
   1: FillForGenusFamily;
   end;
end;

procedure TDatapumpForm.TestButtonClick(Sender: TObject);
begin
  SrcDataQuery.Open;
  SrcDataGrid.Visible:=true;
end;

end.
