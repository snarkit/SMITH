unit OrganismSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IMSData, StdCtrls, Grids, DBGrids, DB, ExtCtrls, DBCtrls, IBODataset, Mask,
  IB_Grid, IB_Components, IB_Access, IB_Controls, OrganismConcepts,
  IB_EditButton, IB_NavigationBar;

type
  TOrganismSelectForm = class(TForm)
    OrgListGrid: TIB_Grid;
    OrgListGridDS: TIB_DataSource;
    Panel1: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    JumpValue: TEdit;
    JumpButton: TButton;
    ButtonPanel: TPanel;
    DeleteOrgButton: TButton;
    AddOrgButton: TButton;
    AcceptButton: TButton;
    FilterPanel: TPanel;
    Label2: TLabel;
    NbRecords: TLabel;
    Label1: TLabel;
    UseFilterRG: TRadioGroup;
    IB_NavigationBar1: TIB_NavigationBar;
    CloseButton: TButton;
    Panel3: TPanel;
    SortRG: TRadioGroup;
    DispOrgCode: TIB_Text;
    procedure FormActivate(Sender: TObject);
    procedure JumpButtonClick(Sender: TObject);
    procedure AddOrgButtonClick(Sender: TObject);
    procedure DeleteOrgButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SortRGClick(Sender: TObject);
    procedure UseFilterRGClick(Sender: TObject);
    procedure JumpValueKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure AcceptButtonClick(Sender: TObject);
  private
    procedure DoFilter;
    procedure FillUseButtons;
    { Déclarations privées }
  public
    CurrentOrgCode:ansistring;
    CurrentOrgUseName:ansistring;
    Mode:smallint;
    OrgQuery: TIB_Query;
    SortFields: array[0..3] of ansistring;
    procedure FillSortFields;
    procedure SetEditButtonsOn;
    procedure SetEditButtonsOff;
    { Déclarations publiques }
  end;

var
  OrganismSelectForm: TOrganismSelectForm;

implementation

uses OrgNameSelect, OrganismEdit, IMSMain;

{$R *.dfm}


procedure TOrganismSelectForm.AcceptButtonClick(Sender: TObject);
begin
  if DispOrgCode.Caption<>'' then
  begin
    CurrentOrgCode:=DispOrgCode.Caption;
    if AcceptButton.Caption='Edit' then
    begin
      //set edit form mode
      OrganismEditForm.Mode:=EditMode;
      OrganismEditForm.CurrentOrg.Clear;
      OrganismEditForm.CurrentOrg.Orgcode:=CurrentOrgCode;
      OrganismEditForm.ShowModal;
      OrgQuery.Refresh;
    end;
  end
  else ShowMessage('Select an organism');
end;

procedure TOrganismSelectForm.AddOrgButtonClick(Sender: TObject);
begin
    OrganismEditForm.Mode:=InsertMode;
    OrganismEditForm.CurrentOrg.Clear;
    OrganismEditForm.ShowModal;
    OrgQuery.Refresh;
end;

procedure TOrganismSelectForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TOrganismSelectForm.DeleteOrgButtonClick(Sender: TObject);
begin
    CurrentOrgCode:=DispOrgCode.Caption;
    OrganismEditForm.Mode:=DeleteMode;
    OrganismEditForm.CurrentOrg.Clear;
    OrganismEditForm.CurrentOrg.Orgcode:=CurrentOrgCode;
    OrganismEditForm.ShowModal;
    OrgQuery.Refresh;
end;

procedure TOrganismSelectForm.FillUseButtons;
var i:integer;
begin
    for i:=0 to UseFilterRG.Items.Count-1 do
        if IMSHomeForm.OrgUses[i].UseName=CurrentOrgUseName then
          UseFilterRG.Buttons[i].Checked:=True;
end;

procedure TOrganismSelectForm.FillSortFields;
var i:integer;
//set list of fields used for ordering
begin
  for i:=0 to SortRG.Items.count-1 do
    SortFields[i]:=OrgQuery.OrderingLinks.Names[i];   //get field name from orderinglinks in dataset
end;


procedure TOrganismSelectForm.FormActivate(Sender: TObject);
var i,k:integer; AUseName:ansistring;
begin
    OrgListGridDS.Dataset:=OrgQuery;  //select test or live data
    if Mode=EditMode then AcceptButton.Caption:='Edit'
    else AcceptButton.Caption:='Accept';
    if SortFields[0]='' then     //first time only
    begin
      SortRG.ItemIndex:=0;
      FillSortFields;
      //Insert search by use radio buttons
      for i := 0 to IMSHomeForm.OrgUses.Count-1 do
        UseFilterRG.Items.Add(IMSHomeForm.OrgUses[i].Heading+' ('+IMSHomeForm.OrgUses[i].UseCode+')');
    end;
    //every time
    if CurrentOrgUseName='' then CurrentOrgUseName:=IMSHomeForm.CurrentOrgUseName; //if unset use what is current in home form
    k:=IMSHomeForm.OrgUses.FindUseIndex(CurrentOrgUseName);
    if UseFilterRG.ItemIndex=k then DoFilter //no change of use just performs retrieval
    else
      UseFilterRG.ItemIndex:=k;              //performs selection and retrieval
    if Mode=EditMode then SetEditButtonsOn else SetEditButtonsOff;
end;


procedure TOrganismSelectForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  OrgQuery.Close;
end;

procedure TOrganismSelectForm.FormDestroy(Sender: TObject);
var i:integer;
begin
  while UseFilterRG.Items.Count>0 do
    UseFilterRG.Items.delete(0);
end;

procedure TOrganismSelectForm.JumpButtonClick(Sender: TObject);
var MyBookmark, JumpVal, FieldVal, PresentVal:string;  OrgFound:boolean; len:integer; FieldName:ansistring;
begin
  OrgFound:=false;
  if SortRG.ItemIndex=0 then JumpVal:=IMSHomeForm.ValidOrgCode(JumpValue.Text)
  else JumpVal:=UpperCase(JumpValue.Text);
  if JumpVal<>'' then
  begin
    if OrgQuery.Eof then OrgQuery.First;
    MyBookmark:=OrgQuery.Bookmark;
    len:=length(JumpVal);
    if SortRG.ItemIndex=0 then FieldName:='ORGCODE'
    else if SortRG.ItemIndex=1 then FieldName:='POLNO'
          else FieldName:='PREFERREDNAME';
    PresentVal:=Uppercase(Copy(OrgQuery.FieldValues[FieldName],1,len));
    OrgQuery.DisableControls;
    if (PresentVal<=JumpVal) then OrgQuery.Next else OrgQuery.Prior;  //start search at next record
    while (not OrgQuery.eof) and (not OrgQuery.bof)  do
    begin
      if  (OrgQuery.FieldByName(FieldName).IsNotNull) then
      begin
        FieldVal:=Uppercase(Copy(OrgQuery.FieldValues[FieldName],1,len));
        if FieldVal=JumpVal then
        begin
          OrgFound:=true;
          break
        end
        else begin
          if (PresentVal<JumpVal) then   //going forwards
          begin
            if (FieldVal>=JumpVal) then break;
          end
          else
          if (PresentVal>JumpVal) and (FieldVal<=JumpVal) then break;
        end;
      end;
      if (PresentVal<=JumpVal) then OrgQuery.Next else OrgQuery.Prior;  //continue search
    end;
    OrgQuery.EnableControls;
  end;
  if not OrgFound then
  begin
      if (PresentVal<>JumpVal) then ShowMessage(JumpVal+' not found');
      OrgQuery.Bookmark:=MyBookmark;
  end;
end;


procedure TOrganismSelectForm.JumpValueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then JumpButtonClick(JumpButton);
end;

procedure TOrganismSelectForm.DoFilter;
// open query for list with parameter USEDBY
var Value:ansistring; MyBookmark:string;
begin
  if OrganismEditForm.CurrentOrg.Orgcode<>'' then   //save any current code
    MyBookmark:= OrgQuery.Bookmark;
  if OrgQuery.Active then OrgQuery.Close;
  Value:= IMSDM.GetOrgUseCode(CurrentOrgUseName);
  OrgQuery.ParamByName('use').Value:='%'+Value+'%';
  OrgQuery.OrderingItemNo:=SortRG.ItemIndex+1;
  OrgQuery.prepare;
  OrgQuery.Open;
  if OrgQuery.IsEmpty then ShowMessage('No organisms found for this use in '+IMSHomeForm.TestRG.Items[IMSHomeForm.TestRG.ItemIndex])
  else begin
    //set count
    OrgQuery.Last;
    NbRecords.Caption := IntToStr(OrgQuery.RecordCount);
    OrgQuery.First;
    if OrganismEditForm.CurrentOrg.Orgcode<>'' then   //allows keeping current organism
     OrgQuery.Bookmark:=MyBookmark;
  end;
end;

procedure TOrganismSelectForm.SetEditButtonsOn;
begin
  AddOrgButton.Visible:=True;
  DeleteOrgButton.Visible:=True;
end;

procedure TOrganismSelectForm.SortRGClick(Sender: TObject);
begin
  OrgQuery.OrderingItemNo:=SortRG.ItemIndex+1;
end;

procedure TOrganismSelectForm.SetEditButtonsOff;
begin
  AddOrgButton.Visible:=False;
  DeleteOrgButton.Visible:=False;
end;

procedure TOrganismSelectForm.UseFilterRGClick(Sender: TObject);
var i:integer;
begin
  CurrentOrgUseName:='';
  for i:=0 to UseFilterRG.Items.Count-1 do
  begin
    if (UseFilterRG.Buttons[i].Checked) then
      CurrentOrgUseName:=IMSHomeForm.OrgUses[i].UseName;
  end;
  DoFilter;
end;

end.
