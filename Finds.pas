unit Finds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, IB_Grid, IB_Components, IB_Access,
  IB_Controls, DBGrids, Mask, ExtCtrls, DB, IBODataset, IB_EditButton,
  ForayConcepts;

type
  TFindsForm = class(TForm)
    TypeLabel: TLabel;
    FindsGrid: TIB_Grid;
    DispForayCode: TLabel;
    EditFindNotes: TIB_Memo;
    CloseButton: TButton;
    Label1: TLabel;
    JumpEdit: TEdit;
    JumpButton: TButton;
    EditPanel: TPanel;
    Orgcode: TIB_Edit;
    Label2: TLabel;
    NewFindButton: TButton;
    EditFindButton: TButton;
    DeleteFindButton: TButton;
    SaveFindButton: TButton;
    CancelFindButton: TButton;
    FindDataSource: TIB_DataSource;
    OrgByCodeButton: TButton;
    OrgByNameButton: TButton;
    WarnLabel: TLabel;
    procedure CloseButtonClick(Sender: TObject);
    procedure JumpButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NewFindButtonClick(Sender: TObject);
    procedure EditFindButtonClick(Sender: TObject);
    procedure DeleteFindButtonClick(Sender: TObject);
    procedure SaveFindButtonClick(Sender: TObject);
    procedure CancelFindButtonClick(Sender: TObject);
    procedure FindsGridDblClick(Sender: TObject);
    procedure OrgByCodeButtonClick(Sender: TObject);
    procedure OrgByNameButtonClick(Sender: TObject);
  private
    procedure GetFinds;
  public
    FindQuery:TIB_Query;
  end;

var
  FindsForm: TFindsForm;

  implementation

uses IMSData, Forays, IMSMain, OrganismEdit, OrganismSelect, OrgNameSelect;


{$R *.dfm}



procedure TFindsForm.CancelFindButtonClick(Sender: TObject);
begin
    if FindsGrid.DataSource.Dataset.Modified then
     FindsGrid.DataSource.Dataset.Cancel;
    EditPanel.Visible:=false;

end;

procedure TFindsForm.CloseButtonClick(Sender: TObject);
begin
   if FindsGrid.DataSource.Dataset.Modified then
      if MessageDlg('Save last edited record?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      try
        FindsGrid.DataSource.Dataset.Post;
        ShowMessage('Entry saved');
      except
        on e:exception do ShowMessage('Save failed. If error is on INTEG_105, findID must be reset to a higher number.'+e.message);
      end
      else FindsGrid.DataSource.Dataset.Cancel;
  NewFindButton.Enabled:=True;
  FindsGrid.DataSource.DataSet.Close;
  Close;
end;


procedure TFindsForm.DeleteFindButtonClick(Sender: TObject);
begin
  if MessageDlg('Delete find?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    FindQuery.Delete;
  end;

end;

procedure TFindsForm.EditFindButtonClick(Sender: TObject);
begin
    FindsGrid.DataSource.Dataset.Edit;
    OrgByCodeButton.Visible:=false;
    OrgByNameButton.Visible:=False;
    EditPanel.Visible:=true;
    FindQuery.Edit;
end;

procedure TFindsForm.FindsGridDblClick(Sender: TObject);
begin
    OrganismEditForm.CurrentOrg.Clear;
    OrganismEditForm.CurrentOrg.Orgcode:=FindQuery.FieldValues['Orgcode'];
    OrganismEditForm.Mode:=EditFindsMode;
    OrganismEditForm.ShowModal;
end;

procedure TFindsForm.FormActivate(Sender: TObject);
begin
    EditPanel.Visible:=false;
    GetFinds;
end;


procedure TFindsForm.GetFinds;
begin
      EditPanel.Visible:=false;
      FindDataSource.Dataset:=FindQuery;   //data set might have been changed
      FindQuery.Close;
      FindQuery.ParamByName('foraycode').Value := ForayForm.CurrentForay.Foraycode;
      FindQuery.Prepare;
      FindQuery.Open;
      DispForayCode.Caption:=ForayForm.CurrentForay.Foraycode;
      if FindQuery.IsEmpty then ShowMessage('No finds found')
      else FindDataSource.Dataset.OrderingItemNo:=1;
end;

procedure TFindsForm.JumpButtonClick(Sender: TObject);
var FieldName:ansistring;
begin
  If (JumpEdit.Text<>'') then
  begin
    if (FindsGrid.DataSource.Dataset.OrderingItemNo=1) then
      FieldName:='FULLNAME'
    else FieldName:='ORGCODE';
    FindsGrid.DataSource.DataSet.DisableControls;
    if JumpEdit.Text<FindsGrid.DataSource.DataSet.FieldValues[FieldName] then
      FindsGrid.DataSource.DataSet.First;
    while not FindsGrid.DataSource.DataSet.EOF and (FindsGrid.DataSource.DataSet.FieldValues[FieldName]<JumpEdit.Text)
        do FindsGrid.DataSource.DataSet.Next;
    FindsGrid.DataSource.DataSet.EnableControls;
  end;
end;

procedure TFindsForm.NewFindButtonClick(Sender: TObject);
begin
  FindQuery.Append;
  FindsGrid.DataSource.Dataset.FieldValues['FORAYCODE']:=ForayForm.CurrentForay.Foraycode;
  OrgByCodeButton.Visible:=True;
  OrgByNameButton.Visible:=True;
  EditPanel.Visible:=true;
end;

procedure TFindsForm.OrgByCodeButtonClick(Sender: TObject);
begin
    OrganismSelectForm.CurrentOrgUseName:='Fungi';
    OrganismSelectForm.ShowModal;
    FindQuery.FieldValues['ORGCODE']:=OrganismSelectForm.CurrentOrgCode;
end;

procedure TFindsForm.OrgByNameButtonClick(Sender: TObject);
begin
    OrgNameSelectForm.Mode:=TransferMode;
    OrgNameSelectForm.ShowModal;
    FindQuery.FieldValues['ORGCODE']:=OrgNameSelectForm.ResultName.OrgCode;

end;

procedure TFindsForm.SaveFindButtonClick(Sender: TObject);
begin
    if FindsGrid.DataSource.Dataset.Modified then
      FindsGrid.DataSource.Dataset.Post;
    EditPanel.Visible:=false;

end;

end.
