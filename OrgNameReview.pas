unit OrgNameReview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, DBCtrls, OrganismConcepts,  Math,
  Grids, DBGrids, DB, ExtCtrls, IB_Components, IB_Grid, IB_Access,
  Generics.Defaults, OrganismEdit;

type

  TOrgNameReviewForm = class(TForm)
    Label1: TLabel;
    SourceRG: TRadioGroup;
    NameListView: TListView;
    buttonPanel: TPanel;
    CancelButton: TButton;
    ReturnButton: TButton;
    SortRG: TRadioGroup;
    NameGridDS: TIB_DataSource;
    Panel1: TPanel;
    Label2: TLabel;
    CodeLabel: TLabel;
    SearchOrgcode: TEdit;
    ChangeCodeButton: TButton;
    ImportOtherNamesButton: TButton;
    procedure FormActivate(Sender: TObject);
    procedure OrgNamesListGridKeyPress(Sender: TObject; var Key: Char);
    procedure SortRGClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SourceRGClick(Sender: TObject);
    procedure NameListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure SearchOrgcodeChange(Sender: TObject);
    procedure NameListViewClick(Sender: TObject);
    procedure ChangeCodeButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure NameListViewCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ImportOtherNamesButtonClick(Sender: TObject);
  private
    procedure DisplayNames(Nameset:TOrgNames);
    procedure PopulateNameListView;
    procedure RenewData;
    procedure Setup;
    { Déclarations privées }
  public
    resultName:TOrgName;
    CallingRoutine:integer;
    CurrentOrg:TOrganism;
    NameQuery:TIB_Query;
    Tablename:ansistring;
    Mode:smallInt;
    SetupDone:boolean;
    { Déclarations publiques }
  end;

var OrgNameReviewForm:TOrgNameReviewForm;     ActiveColumn: integer =-1;

const SortFields: array[0..2] of ansistring =('OrgCode','Fullname','Language');

implementation

uses IMSMain;


{$R *.dfm}

//
//  Form which allows selection of names in the database for copying or importing
//

procedure TOrgNameReviewForm.CancelButtonClick(Sender: TObject);
begin
 // if Mode=GeneralMode then close;
end;

procedure TOrgNameReviewForm.DisplayNames(Nameset:TOrgNames);
var  AName:TOrgName; i:integer;
     oldCursor:TCursor; ListItem :TListItem;
begin
    oldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourglass;
    try
      NameSet.Sort(TComparer<TOrgName>.Construct(IMSHomeForm.OrgNamesComparison));
      NameListView.SortType:=stNone;
      for i:=0 to NameSet.Count-1 do
      begin
        AName:=TOrgName(NameSet.Items[i]);
        ListItem:= NameListView.Items.Add;
        ListItem.Caption := AName.fullname;
        if AName.IsScientific then  //first subitem is authority
          ListItem.SubItems.Add(TScientificName(AName).Author)
        else ListItem.SubItems.Add(' ');
        if AName.LanguageName='' then
          AName.LanguageName:=IMSHomeForm.LanguageLookup.FindLanguageName(AName.LanguageCode);
        ListItem.SubItems.Add(AName.LanguageName); //2nd subitem is language
        if TScientificName(AName).preferred then ListItem.SubItems.Add('P') else ListItem.SubItems.Add(' '); //3rd subitem is preferred
      end;
    finally
      Screen.Cursor:=oldCursor;
    end;
end;


procedure TOrgNameReviewForm.FormActivate(Sender: TObject);
begin
    if not setupdone then Setup    //includes retrieving data
    else RenewData;
end;

procedure TOrgNameReviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  setupdone:=false;
end;

procedure TOrgNameReviewForm.FormCreate(Sender: TObject);
begin
  resultName:=TOrgName.Create;
  CurrentOrg:=TOrganism.Create;
  NameListView.ViewStyle:=vsReport;   //bug fix to avoid stream read error
  NameListView.Clear;
end;

procedure TOrgNameReviewForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(CurrentOrg);
    FreeAndNil(resultName);
end;



procedure TOrgNameReviewForm.ImportOtherNamesButtonClick(Sender: TObject);
begin
  if MessageDlg('Confirm import of names from EPPT',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    Mode:=MultipleImportMode;  //signal to calling routine
    ResultName.Orgcode:='';  //cancel import of single name
  end;
end;

procedure TOrgNameReviewForm.NameListViewClick(Sender: TObject);
begin
//save new selection
   if NameListView.Selected<>nil then
   begin
    resultName.Clear;
    resultName.Orgcode:=SearchOrgcode.Text;
    resultName.Fullname:=NameListView.Selected.Caption;
    if resultName.IsScientific then TScientificName(resultName).Author:=NameListView.Selected.SubItems[0];
    resultName.LanguageName:=NameListView.Selected.SubItems[1];
    resultName.LanguageCode:=IMSHomeForm.LanguageLookup.FindLanguageCode(resultName.LanguageName);
   end;
end;

procedure TOrgNameReviewForm.NameListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
//custom comparison routine for treeview display
  Compare:=0;
  if SortRG.Items[SortRG.ItemIndex] = 'Fullname' then   //caption (orgcode)
  begin
    Compare := CompareText(Item1.Caption,Item2.Caption);
    if Compare=0 then Compare := CompareText(Item1.Subitems[0],Item2.Subitems[0]); //authority
  end;
  if Compare=0 then   //names equal OR not name order
    begin
      if SortRG.Items[SortRG.ItemIndex] = 'Language' then   //subitem[2] (name)
         // language order OR same namee subsort on language
      begin
        Compare := CompareValue(IMSHomeForm.LanguageLookup.FindSortOrder((Item1.SubItems[1])),IMSHomeForm.LanguageLookup.FindSortOrder(Item2.SubItems[1]));
        if Compare=0 then
          if Item1.SubItems[2]='P' then Compare:=-1    //preferred
          else if Item2.SubItems[2]='P' then Compare:=1
              else Compare := CompareText(Item1.Caption,Item2.Caption)  //fullname
      end;
    end;
end;

procedure TOrgNameReviewForm.NameListViewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  (Sender as TListView).Canvas.Font.Color:=IMSHomeForm.LanguageLookup.FindLanguageColour(IMSHomeForm.LanguageLookup.FindLanguageCode(Item.SubItems[1]));
  if Item.SubItems[2]='P' then (Sender as TListView).Canvas.Font.Style:=[fsBold];
end;

procedure TOrgNameReviewForm.OrgNamesListGridKeyPress(Sender: TObject;
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

procedure TOrgNameReviewForm.PopulateNameListView;
begin
      NameListView.Clear;
      if SourceRG.ItemIndex=0 then      //EPPT
        DisplayNames(CurrentOrg.EPPONameList)
      else if SourceRG.ItemIndex=1 then
        DisplayNames(CurrentOrg.NameList);
      NameListView.AlphaSort;
end;

procedure TOrgNameReviewForm.RenewData;
var SearchVal:ansistring;
begin
        SearchVal:=IMSHomeForm.ValidOrgCode(SearchOrgcode.Text);
        if (SourceRG.ItemIndex=1) and      //IMS database names
          (SearchVal=OrganismEditForm.CurrentOrg.Orgcode) then // cannot look up IMS names for current org
        ShowMessage('This organism is currently being edited. To see its names return to the edit form')
        else begin
          if trim(SearchVal)='' then        //if no user selection use current org
            SearchVal:=CurrentOrg.Orgcode;
          if SearchVal<>CurrentOrg.Orgcode then
          begin
            CurrentOrg.Clear;    //change organism
            CurrentOrg.Orgcode:=SearchVal;
            CurrentOrg.ReadNamesFromDataSet(NameQuery);
            CurrentOrg.PopulateEPPONameList;
          end;
          PopulateNameListView;
          SearchOrgcode.Text:='';
          CodeLabel.Caption:=SearchVal;
        end;
end;

procedure TOrgNameReviewForm.SearchOrgcodeChange(Sender: TObject);
begin
    if SearchOrgcode.Text<>CurrentOrg.Orgcode then ChangeCodeButton.Enabled:=true;      //allow user to search for nother organism's names
end;

procedure TOrgNameReviewForm.ChangeCodeButtonClick(Sender: TObject);
var SearchVal:ansistring;
begin
//if SearchOrgcode.Text has been changed by user and is not blank
  SearchVal:=IMSHomeForm.ValidOrgCode(SearchOrgcode.Text);
  if (SearchVal<>CurrentOrg.Orgcode) and (SearchVal<>'') then
  begin
    Renewdata;
    ImportOtherNamesButton.Enabled:= (CurrentOrg.OrgCode=OrganismEditForm.CurrentOrg.OrgCode); //can only import EPPT names to same organism
  end;
end;

procedure TOrgNameReviewForm.Setup;
//initialise appropriate sort order and filters
// then open data
begin
        SortRG.ItemIndex:=1;   //sort by language
        if (Mode=SingleImportMode) then   //find
        begin
          ReturnButton.Visible:=true;
          CancelButton.Caption:='Cancel (ignore selection)';
        end
        else if Mode<>TransferMode then  //transfer one name
        begin
          ReturnButton.Visible:=false;
          CancelButton.Caption:='Close';
        end;
        if SourceRG.ItemIndex=0 then RenewData
        else SourceRG.ItemIndex:=0;    //retrieve data from EPPT by default
        Setupdone:=true;
end;

procedure TOrgNameReviewForm.SortRGClick(Sender: TObject);
begin
    NameListView.AlphaSort;   //apply sort to listview
end;

procedure TOrgNameReviewForm.SourceRGClick(Sender: TObject);
begin
    Renewdata;
    ImportOtherNamesButton.Enabled:=(SourceRG.ItemIndex=0)  // enable import button for ePPT names
end;

end.










