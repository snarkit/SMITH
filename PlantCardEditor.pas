unit PlantCardEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Controls, StdCtrls, IBC_CustomLabel, IBC_Label, Mask, IB_Access,
  IB_EditButton, XSpin, ExtCtrls, Grids, IB_Grid, IMSData, IB_LocateEdit,
  IB_Components, organismConcepts, OrgStatusControl, OrgDistributionControl,
  OrgAbundanceControl, IB_NavigationBar;

type

  TPlantCardEditForm = class(TForm)
    DistributionPanel: TPanel;
    TitleGroupBox: TGroupBox;
    Plantname: TIB_Text;
    IB_Label1: TIB_Label;
    SearchButton: TButton;
    CodeLocateEdit: TIB_LocateEdit;
    PlantCode: TIB_Text;
    DeleteButton: TButton;
    SaveButton: TButton;
    CloseButton: TButton;
    PlantDataPanel: TPanel;
    FormRG: TIB_RadioGroup;
    VulnerabilityRG: TIB_RadioGroup;
    ProtectionRG: TIB_RadioGroup;
    SizeGB: TGroupBox;
    Dash2: TLabel;
    Unitscm: TLabel;
    MinSize: TXSpinEdit;
    MaxSize: TXSpinEdit;
    FlowerGB: TGroupBox;
    Dash3: TLabel;
    MinFlower: TXSpinEdit;
    MaxFlower: TXSpinEdit;
    AltitudeGB: TGroupBox;
    Dash1: TLabel;
    Unitsm: TLabel;
    MinAltitude: TXSpinEdit;
    MaxAltitude: TXSpinEdit;
    MediumGB: TGroupBox;
    MarineCB: TCheckBox;
    FreshwaterCB: TCheckBox;
    TerrestrialCB: TCheckBox;
    GuildGB: TGroupBox;
    AutotrophCB: TCheckBox;
    SaprophyteCB: TCheckBox;
    ParasiteCB: TCheckBox;
    CarnivoreCB: TCheckBox;
    EndemicRG: TIB_RadioGroup;
    HabitatGB: TGroupBox;
    HabitatMemo: TIB_Memo;
    WorldwideGB: TGroupBox;
    WorldwideMemo: TIB_Memo;
    IslandsPanel: TPanel;
    AzoresPanel: TPanel;
    MDPanel: TPanel;
    ContinentPanel: TPanel;
    PlantCardDS: TIB_DataSource;
    PTAbundanceControl: TOrgAbundanceControl;
    PTStatusControl: TOrgStatusControl;
    AZStatusControl: TOrgStatusControl;
    MDStatusControl: TOrgStatusControl;
    AZAbundanceControl: TOrgAbundanceControl;
    MDAbundanceControl: TOrgAbundanceControl;
    PTProvinceControl: TOrgDistributionControl;
    AZIslandsControl: TOrgDistributionControl;
    MDIslandsControl: TOrgDistributionControl;
    PTFloristicControl: TOrgDistributionControl;
    IB_NavigationBar1: TIB_NavigationBar;
    procedure CloseButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure SizeGBExit(Sender: TObject);
    procedure AltitudeGBExit(Sender: TObject);
    procedure FlowerGBExit(Sender: TObject);
    procedure MediumGBExit(Sender: TObject);
    procedure GuildGBExit(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PTStatusControlStatusChangeEvent(Sender: TObject;
      var NewStatus: string);
    procedure PTProvinceControlDistributionChangeEvent(Sender: TObject;
      var NewDistribution: string);
    procedure AZIslandsControlDistributionChangeEvent(Sender: TObject;
      var NewDistribution: string);
    procedure MDIslandsControlDistributionChangeEvent(Sender: TObject;
      var NewDistribution: string);
    procedure PTFloristicControlDistributionChangeEvent(Sender: TObject;
      var NewDistribution: string);
    procedure MDStatusControlStatusChangeEvent(Sender: TObject;
      var NewStatus: string);
    procedure AZStatusControlStatusChangeEvent(Sender: TObject;
      var NewStatus: string);
  private
    { Private declarations }
    function GetFieldValue(FieldName:string):string;
    function ValueChanged(FieldName:string;ActualValue:integer):boolean;
    procedure Checksave;
    procedure FillAltitude;
    procedure FillDistribution;
    procedure FillFields;
    procedure FillFlowering;
    procedure FillGuild;
    procedure FillMedium;
    procedure FillSize;
    procedure FillStatus;
    procedure SetEndemic;
  public
    CurrentOrg:TOrganism;
    CardQuery:TIB_Query;
    { Public declarations }
  end;

var
  PlantCardEditForm: TPlantCardEditForm;


implementation

{$R *.dfm}

procedure TPlantCardEditForm.AltitudeGBExit(Sender: TObject);
begin
  if ValueChanged('MINALTITUDE',MinAltitude.Value) or ValueChanged('MAXALTITUDE',MaxAltitude.Value) then
  if MinAltitude.Value<=MaxAltitude.Value  then showMessage('Altitude values inconsistent')
  else
  begin
    PlantCardDS.Dataset.FieldValues['MINALTITUDE']:=MinAltitude.Value;
    PlantCardDS.Dataset.FieldValues['MAXALTITUDE']:=MaxAltitude.Value;
  end;

end;


procedure TPlantCardEditForm.AZIslandsControlDistributionChangeEvent(
  Sender: TObject; var NewDistribution: string);
begin
      PlantCardDS.Dataset.FieldValues['AZISLANDS']:= NewDistribution;
end;

procedure TPlantCardEditForm.AZStatusControlStatusChangeEvent(Sender: TObject;
  var NewStatus: string);
begin
      PlantCardDS.Dataset.FieldValues['AZSTATUS']:= NewStatus;
      SetEndemic;
end;



procedure TPlantCardEditForm.CheckSave;
begin
  if PlantCardDS.Dataset.Modified=true then
    if MessageDlg('Save changes to card?',mtWarning,[mbYes,mbNo],0)=mrYes then
       PlantCardDS.Dataset.Post
    else PlantCardDS.Dataset.Cancel;
end;

procedure TPlantCardEditForm.CloseButtonClick(Sender: TObject);
begin
  CheckSave;
  Close;
end;

procedure TPlantCardEditForm.DeleteButtonClick(Sender: TObject);
begin
    if MessageDlg('Delete this record?',mtConfirmation, [mbYes,mbNo],0)=mryes then
      PlantCardDS.Dataset.Delete;
end;

procedure TPlantCardEditForm.FillAltitude;
begin
    MinAltitude.Value:=PlantCardDS.Dataset.FieldValues['MINALTITUDE'];
    MaxAltitude.Value:=PlantCardDS.Dataset.FieldValues['MAXALTITUDE'];
end;

procedure TPlantCardEditForm.FillDistribution;
begin
    PTProvinceControl.OrgDistribution:=GetFieldValue('PTPROVINCES');
    PTFloristicControl.OrgDistribution:=GetFieldValue('PTFLORISTIC');
    AZIslandsControl.OrgDistribution:=GetFieldValue('AZISLANDS');
    MDIslandsControl.OrgDistribution:=GetFieldValue('MDISLANDS');
end;

function TPlantCardEditForm.GetFieldValue(FieldName:string):string;
begin
    if PlantCardDS.Dataset.FieldByName(FieldName).IsNull then result:=' '
    else result:=PlantCardDS.Dataset.FieldByName(FieldName).AsString;
end;

procedure TPlantCardEditForm.FillFields;
begin
     FillGuild;
     FillMedium;
     FillSize;
     FillAltitude;
     FillFlowering;
     FillStatus;
     FillDistribution;
     SetEndemic;
end;

procedure TPlantCardEditForm.FillFlowering;
begin
    MinFlower.Value:=PlantCardDS.Dataset.FieldValues['FLOWERSTART'];
    MaxFlower.Value:=PlantCardDS.Dataset.FieldValues['FLOWEREND'];
end;

procedure TPlantCardEditForm.FillGuild;
var Guild:string; i:smallint;
begin
  Guild:=PlantCardDS.Dataset.FieldValues['GUILD'];
  for i:=1 to length(Guild) do
  begin
    if Guild[i]='A' then AutotrophCB.State:=cbChecked;
    if Guild[i]='S' then SaprophyteCB.State:=cbChecked;
    if Guild[i]='P' then ParasiteCB.State:=cbChecked;
    if Guild[i]='C' then CarnivoreCB.State:=cbChecked;
  end;
end;


procedure TPlantCardEditForm.FillMedium;
var Medium:string; i:smallint;
begin
  Medium:=PlantCardDS.Dataset.FieldValues['MEDIUM'];
  for i:=1 to length(Medium)  do
  begin
    if Medium[i]='T' then TerrestrialCB.State:=cbChecked;
    if Medium[i]='F' then FreshwaterCB.State:=cbChecked;
    if Medium[i]='M' then FreshwaterCB.State:=cbChecked;
  end;
end;

procedure TPlantCardEditForm.FillSize;
begin
    MinSize.Value:=PlantCardDS.Dataset.FieldValues['MINSIZE'];
    MaxSize.Value:=PlantCardDS.Dataset.FieldValues['MAXSIZE'];
end;

procedure TPlantCardEditForm.FillStatus;
begin
    PTStatusControl.OrgStatus:=GetFieldValue('PTSTATUS');
    AZStatusControl.OrgStatus:=GetFieldValue('AZSTATUS');
    MDStatusControl.OrgStatus:=GetFieldValue('MDSTATUS');
end;

procedure TPlantCardEditForm.FlowerGBExit(Sender: TObject);
begin
  if ValueChanged('FLOWERSTART',MinFlower.Value) or ValueChanged('FLOWEREND',MaxFlower.Value) then
  if MinFlower.Value>MaxFlower.Value then showMessage('Flowering times inconsistent')
  else begin
    PlantCardDS.Dataset.FieldValues['FLOWERSTART']:=MinFlower.Value;
    PlantCardDS.Dataset.FieldValues['FLOWEREND']:=MaxFlower.Value;
  end;

end;

procedure TPlantCardEditForm.FormActivate(Sender: TObject);
var i:integer;
begin
  if CurrentOrg=nil then
  begin
    CurrentOrg:=TOrganism.Create;
    PlantCardDS.Dataset:=CardQuery;
  end;
  if PlantCardDS.Dataset<>nil then
  begin
     for i:=0 to ComponentCount-1 do
     begin
      if (Components[i] is TIB_RadioGroup)
      and (TIB_RadioGroup(Components[i]).DataSource=nil) then
      begin
        TIB_RadioGroup(Components[i]).DataSource:=PlantCardDS;
        if TIB_RadioGroup(Components[i]).DataField='' then
          ShowMessage('Set Datafield for '+Components[i].Name);
      end;
      if (Components[i] is TOrgAbundanceControl)
      and (TOrgAbundanceControl(Components[i]).DataSource=nil) then
      begin
        TOrgAbundanceControl(Components[i]).DataSource:=PlantCardDS;
        if TOrgAbundanceControl(Components[i]).DataField='' then
          ShowMessage('Set Datafield for '+Components[i].Name);
      end;
     end;
  end
  else ShowMessage('Datasource is not set!');
  CodeLocateEdit.SetFocus;
end;

procedure TPlantCardEditForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   CurrentOrg.Free;
   CurrentOrg:=nil;
end;

procedure TPlantCardEditForm.GuildGBExit(Sender: TObject);
var Guild:string;
begin
  Guild:='';
  if AutotrophCB.Checked then Guild:=Guild+'A';
  if SaprophyteCB.Checked then Guild:=Guild+'S';
  if ParasiteCB.Checked then Guild:=Guild+'P';
  if CarnivoreCB.Checked then Guild:=Guild+'C';
  PlantCardDS.Dataset.FieldValues['GUILD']:=Guild;

end;


procedure TPlantCardEditForm.MDIslandsControlDistributionChangeEvent(
  Sender: TObject; var NewDistribution: string);
begin
      PlantCardDS.Dataset.FieldValues['MDISLANDS']:= NewDistribution;
end;

procedure TPlantCardEditForm.MDStatusControlStatusChangeEvent(Sender: TObject;
  var NewStatus: string);
begin
      PlantCardDS.Dataset.FieldValues['MDSTATUS']:= NewStatus;
      SetEndemic;
end;


procedure TPlantCardEditForm.MediumGBExit(Sender: TObject);
var Medium:string;
begin
  Medium:='';
  if TerrestrialCB.Checked then Medium:=Medium+'T';
  if FreshwaterCB.Checked then Medium:=Medium+'F';
  if MarineCB.Checked then Medium:=Medium+'M';
  PlantCardDS.Dataset.FieldValues['MEDIUM']:=Medium;
end;

procedure TPlantCardEditForm.PTFloristicControlDistributionChangeEvent(
  Sender: TObject; var NewDistribution: string);
begin
      PlantCardDS.Dataset.FieldValues['PTFLORISTIC']:= NewDistribution;
end;

procedure TPlantCardEditForm.PTProvinceControlDistributionChangeEvent(
  Sender: TObject; var NewDistribution: string);
begin
      PlantCardDS.Dataset.FieldValues['PTPROVINCES']:= NewDistribution;

end;

procedure TPlantCardEditForm.PTStatusControlStatusChangeEvent(Sender: TObject;
  var NewStatus: string);
begin
      PlantCardDS.Dataset.FieldValues['PTSTATUS']:= NewStatus;
      SetEndemic;
end;


procedure TPlantCardEditForm.SaveButtonClick(Sender: TObject);
begin
  if PlantCardDS.Dataset.NeedToPost=true then PlantCardDS.Dataset.Post;
end;

procedure TPlantCardEditForm.SearchButtonClick(Sender: TObject);
begin
  if Assigned(PlantCardDS.Dataset) and (CodeLocateEdit.Text>'') then
  begin
    CodeLocateEdit.Text:=uppercase(CodeLocateEdit.Text);
    if not PlantCardDS.Dataset.Active then PlantCardDS.Dataset.Open
    else CheckSave;
    if not Assigned(CodeLocateEdit.DataSource) then
      CodeLocateEdit.DataSource:=PlantCardDS;
    if CodeLocateEdit.DataField='' then
      CodeLocateEdit.DataField:='PLANTCODE';
    CodeLocateEdit.Locate;
    if CodeLocateEdit.Text=PlantCardDS.Dataset.FieldValues['Plantcode'] then
    begin
      CurrentOrg.orgcode:=CodeLocateEdit.Text;
      Plantcode.Caption:=CurrentOrg.orgcode;
      Plantname.Caption:=CurrentOrg.PreferredName;
      FillFields;
      PlantCardDS.Dataset.Edit;
    end
    else
      if MessageDlg('Record does not exist. Create one?',mtConfirmation, [mbYes,mbNo],0)=mryes then
      begin
        PlantCardDS.Dataset.Append;
        PlantCardDS.Dataset.FieldValues['Plantcode']:=CodeLocateEdit.Text;
      end;
      CurrentOrg.Clear;
      CurrentOrg.orgcode:=CodeLocateEdit.Text;
      CurrentOrg.readBasicFromDataset(IMSDM.AllOrganismsQuery);
    end;
end;

procedure TPlantCardEditForm.SetEndemic;
begin
  if (PTStatusControl.OrgStatus='NE') or (AZStatusControl.OrgStatus='NE') or (MDStatusControl.OrgStatus='NE') then
  begin
     if EndemicRG.ItemIndex<>0 then EndemicRG.ItemIndex:=0   //Index 0 is Yes
  end else
      if EndemicRG.ItemIndex<>1 then EndemicRG.ItemIndex:=1; //Index 1 is No }

end;

procedure TPlantCardEditForm.SizeGBExit(Sender: TObject);
begin
  if ValueChanged('MINSIZE',MinSize.Value) or ValueChanged('MAXSIZE',MaxSize.Value) then
  if MinSize.Value>MaxSize.Value then showMessage('Flowering times inconsistent')
  else begin
    PlantCardDS.Dataset.FieldValues['MINSIZE']:=MinSize.Value;
    PlantCardDS.Dataset.FieldValues['MAXSIZE']:=MaxSize.Value;
  end;

end;

function TPlantCardEditForm.ValueChanged(FieldName:string;ActualValue:integer):boolean;
begin
    result:= PlantCardDS.Dataset.FieldByName(FieldName).AsInteger<>ActualValue;
end;
end.
