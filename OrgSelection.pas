unit OrgSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, DBCtrls, IB_Grid, IB_Components, IB_Access,
  IB_Controls, Grids, DBGrids, DB, IBODataset, ExtCtrls;

type
  TOrgSelectForm = class(TForm)
    PreferredCB: TCheckBox;
    AddOrgButton: TButton;
    Label1: TLabel;
    CancelButton: TButton;
    Label3: TLabel;
    OrganismList: TIB_Grid;
    OrganismNameListDS: TIB_DataSource;
    OrgNamesForListQuery: TIB_Query;
    SortRG: TRadioGroup;
    FilterGB: TGroupBox;
    FilterFieldCB: TComboBox;
    Label4: TLabel;
    FilterStr: TEdit;
    JumpGB: TGroupBox;
    JumpButton: TButton;
    Jump: TEdit;
    ReturnButton: TButton;
    FilterCB: TCheckBox;
    procedure OrganismListDblClick(Sender: TObject);
    procedure OrgFilterButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AddOrgButtonClick(Sender: TObject);
    procedure PreferredCBClick(Sender: TObject);
    procedure OrganismListKeyPress(Sender: TObject; var Key: Char);
    procedure SortRGClick(Sender: TObject);
    procedure JumpButtonClick(Sender: TObject);
    procedure ReturnButtonClick(Sender: TObject);
    procedure FilterCBClick(Sender: TObject);
  private
    procedure GetNames(SQLstring:string);
    { Déclarations privées }
  public
    SelectedOrgCode:string;
    SelectedNameId:integer;
    SortField:widestring;
    CallingRoutine:integer;
    procedure FilterList;
    { Déclarations publiques }
  end;

var OrgSelectForm:TOrgSelectForm;     ActiveColumn: integer =-1;


implementation

uses FunDM, OrganismEdit;

{$R *.dfm}


procedure TOrgSelectForm.OrganismListDblClick(Sender: TObject);
begin
      SelectedOrgCode:=OrgNamesForListQuery.FieldValues['ORGCODE'];
      SelectedNameId:=OrgNamesForListQuery.FieldValues['NAMEID'];
     ModalResult:=mrOK;

end;


procedure TOrgSelectForm.OrgFilterButtonClick(Sender: TObject);
begin
      FilterList;
end;

procedure TOrgSelectForm.FilterList;
var SQLstring:string; oldCursor:TCursor;
begin
  oldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourglass;
  try
    if FilterCB.Checked then
    begin
      case FilterFieldCB.ItemIndex of
        0: begin
          // name
          if FilterStr.Text<>'' then begin
            SQLstring:='(Name like '+QuotedStr('%'+FilterStr.Text+'%')+')';
          end;
        end;
        1: begin
        // genus
          if FilterStr.Text<>'' then begin
            SQLstring:='(orgcode in (Select SpeciesCode from SpeciesGenusLink where GenusCode = '+QuotedStr(FilterStr.Text)+'))';
          end;
        end;
        2: begin
        // family
          if FilterStr.Text<>'' then begin
            SQLstring:='(orgcode in (Select SpeciesCode from SpeciesGenusLink s where S.GenusCode in (Select GenusCode from GenusFamilyLink g where g.FamilyCode = '+QuotedStr(FilterStr.Text)+')))';
          end;
        end;
        3: begin
        // order
          if FilterStr.Text<>'' then begin
            SQLstring:='(orgcode in (Select s.SpeciesCode from SpeciesGenusLink s where S.GenusCode in (Select g.GenusCode from GenusFamilyLink g where g.FamilyCode in (select f.FamilyCode from FamilyORDERLink f where f.ordercode = '+QuotedStr(FilterStr.Text)+'))))';
          end;
        end;
      end;
    end;
  finally
    getNames(SQLstring);
    Screen.Cursor:=oldCursor;
  end;
end;

procedure TOrgSelectForm.GetNames(SQLstring:string);
// Get names corresponding to Orgcode or all if no Orgcode
var sep:string;
begin
        with OrgNamesForListQuery do begin
          Close;
          SQL.Clear;
          sep:='where ';
          SQL.Add('Select nameid, orgcode, name, language, ln from OrgNames ');
          if PreferredCB.Checked then
          begin
            SQL.Add(sep+'(LN=0) and (LANGUAGE='+QuotedStr('A')+')');
            sep:='and ';
          end;
          if SQLstring<>'' then
            SQL.Add(sep+SQLstring);
          if SortField='' then SortField:='ORGCODE';
          SQL.Add('order by '+SortField);
          Prepare;
          Open;
          First;
        end;
end;

procedure TOrgSelectForm.FormActivate(Sender: TObject);
begin
     if OrgNamesForListQuery.SQL.Text<>'' then OrgNamesForListQuery.Open;
     if FilterFieldCB.ItemIndex<0 then begin
      FilterFieldCB.ItemIndex:=0;
      SortRG.ItemIndex:=0;
      FilterList;
     end;
end;

procedure TOrgSelectForm.AddOrgButtonClick(Sender: TObject);
begin
   // if called from organism routine, return (avoids endless nested calls)
   if CallingRoutine=0 then modalResult:=mrCancel
   else begin
    //OrganismsEditForm.OrgDataModified:=False;
    //OrganismsEditForm.CallingRoutine:=CallingRoutine;
    if OrganismsEditForm.ShowModal=mrOK then FilterList;
   end;
end;

procedure TOrgSelectForm.PreferredCBClick(Sender: TObject);
begin
    FilterList;
end;

procedure TOrgSelectForm.OrganismListKeyPress(Sender: TObject;
  var Key: Char);
var sstring,teststr:widestring; i,j:integer;
begin
      sstring:=(Sender as TListView).GetSearchString;
      if sstring='' then sstring:=uppercase(Key);
      for i:=0 to (Sender as TListView).Items.Count-1 do
      begin
        if ActiveColumn=0 then
           teststr:=(Sender as TListView).Items[i].Caption
        else
          teststr:=(Sender as TListView).Items[i].SubItems[ActiveColumn-1];
        j:=length(sstring);
        if Copy(teststr,1,j)=sstring then begin
             (Sender as TListView).ItemIndex:=i;
             break;
        end;
      end;
end;

procedure TOrgSelectForm.SortRGClick(Sender: TObject);
begin
  if SortRG.ItemIndex=0 then SortField:='ORGCODE'
  else SortField:='NAME';
  FilterList;
end;

procedure TOrgSelectForm.JumpButtonClick(Sender: TObject);
begin
    //if Jump.Text<>'' then OrgNamesForListQuery.Locate(SortField,Jump.Text,[loPartialKey]);
end;

procedure TOrgSelectForm.ReturnButtonClick(Sender: TObject);
begin
     ModalResult:=mrOK;
end;

procedure TOrgSelectForm.FilterCBClick(Sender: TObject);
begin
    FilterList;
end;

end.
