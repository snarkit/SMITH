unit OrganismEdit;

{ Organism names are a list of names associated with the organism, so they can be
  handled as a group before saving to disk (allows change of name numbers).
  Refs and finds are modified directly on the disk.
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ExtCtrls, DBCtrls, IMSData,
  IB_Grid, DateUtils, ComCtrls, OrganismConcepts, BookConcepts, Books,
    Generics.Collections, IB_Access, IB_Components, ForayConcepts, Mask,
  IBC_CustomLabel, IBC_Label, IB_Controls, IB_EditButton, EUDMain,
  Math, Generics.Defaults, IB_Dialogs;

type
  TOrganismEditForm = class(TForm)
    EditPages: TPageControl;
    NameTab: TTabSheet;
    RefTab: TTabSheet;
    FindTab: TTabSheet;
    DistribTab: TTabSheet;
    OrgDataPanel: TPanel;
    PrefName: TIB_Label;
    Label5: TLabel;
    ConfirmDeleteButton: TButton;
    SaveOrgButton: TButton;
    CancelOrgButton: TButton;
    WarningImage: TImage;
    EPPOInfo: TLabel;
    RefPanel: TPanel;
    Label10: TLabel;
    RefDispList: TListView;
    RefCountDisp: TLabel;
    FindPanel: TPanel;
    DistPanel: TPanel;
    NamePanel: TPanel;
    NameCountDisp: TLabel;
    Label11: TLabel;
    NameDispList: TListView;
    FindCountDisp: TLabel;
    Label9: TLabel;
    FindDispList: TListView;
    EditFindPanel: TPanel;
    Label4: TLabel;
    Label12: TLabel;
    EditForayCode: TIB_Edit;
    SaveFindButton: TButton;
    FindForayButton: TButton;
    CancelFindButton: TButton;
    DeleteFindButton: TButton;
    EditFindNotes: TIB_Memo;
    DistributionPanel: TPanel;
    FormGB: TGroupBox;
    Label1: TLabel;
    EPPOOrgCode: TLabel;
    EPPOName: TLabel;
    NewOrgPanel: TPanel;
    OrgCodeOKButton: TButton;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditUsePanel: TPanel;
    AcceptUseButton: TButton;
    InsertUseButton: TButton;
    Label14: TLabel;
    OrgDataSource: TIB_DataSource;
    CodeChangeButton: TButton;
    CancelCodeButton: TButton;
    CloseButton: TButton;
    UsesDisplay: TLabel;
    EditDistPanel: TPanel;
    Label18: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    IB_Memo1: TIB_Memo;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    Button4: TButton;
    RefDataSource: TIB_DataSource;
    EPPOLabel: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    FindDataSource: TIB_DataSource;
    CancelUseButton: TButton;
    NewOrgCode: TEdit;
    ResortButton: TButton;
    FamilyCB: TComboBox;
    IB_LookupDialog1: TIB_LookupDialog;
    NameButtonPanel: TPanel;
    NameTransferPanel: TPanel;
    NameTransferButton: TButton;
    NameTransferCode: TEdit;
    NewNameButton: TButton;
    RefButtonPanel: TPanel;
    NewRefButton: TButton;
    RefTransferPanel: TPanel;
    RefTransferButton: TButton;
    RefTransferCode: TEdit;
    FindsButtonPanel: TPanel;
    NewFindButton: TButton;
    FindTransferPanel: TPanel;
    EditNamePanel: TPanel;
    Label16: TLabel;
    AuthLabel: TLabel;
    Label17: TLabel;
    Label6: TLabel;
    PrefLabel: TLabel;
    Label15: TLabel;
    SaveNameButton: TButton;
    CancelNameButton: TButton;
    ImportNameButton: TButton;
    DeleteNameButton: TButton;
    PreferredCB: TCheckBox;
    EditNameFullName: TEdit;
    EditNameAuthority: TEdit;
    LanguageLB: TComboBox;
    EditNameComments: TMemo;
    EditRefPanel: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label13: TLabel;
    SaveRefButton: TButton;
    CancelRefButton: TButton;
    DeleteRefButton: TButton;
    EditRefNotes: TIB_Memo;
    EditRefPageno: TIB_Edit;
    EditRefVolume: TIB_Edit;
    EditRefBookCode: TIB_Edit;
    ImportBookButton: TButton;
    EditRefRefCode: TIB_Edit;
    PolnoEdit: TEdit;
    CommentsEdit: TMemo;
    CardEdit: TMemo;
    OrgCodeText: TLabel;
    Label2: TLabel;
    Label19: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Panel1: TPanel;
    Label26: TLabel;
    Panel2: TPanel;
    Label31: TLabel;
    FindTransferButton: TButton;
    FindTransferCode: TEdit;
    EPPOValidate: TIB_ComboBox;
    procedure FormActivate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure BrowseBooksButtonClick(Sender: TObject);
    procedure FindForayButtonClick(Sender: TObject);
    procedure NewNameButtonClick(Sender: TObject);
    procedure DeleteNameButtonClick(Sender: TObject);
    procedure SaveNameButtonClick(Sender: TObject);
    procedure ConfirmDeleteButtonClick(Sender: TObject);
    procedure NewRefButtonClick(Sender: TObject);
    procedure NewFindButtonClick(Sender: TObject);
//    procedure EditRefButtonClick(Sender: TObject);
//    procedure EditFindButtonClick(Sender: TObject);
    procedure CancelNameButtonClick(Sender: TObject);
    procedure CancelRefButtonClick(Sender: TObject);
    procedure CancelFindButtonClick(Sender: TObject);
    procedure DeleteOrgItems(DataQuery:TIB_Query);
    procedure DeleteRefButtonClick(Sender: TObject);
    procedure DeleteFindButtonClick(Sender: TObject);
    procedure SaveFindButtonClick(Sender: TObject);
    procedure ViewOtherNamesButtonClick(Sender: TObject);
    procedure SaveRefButtonClick(Sender: TObject);
    procedure OrgCodeOKButtonClick(Sender: TObject);
    procedure SaveOrgButtonClick(Sender: TObject);
    procedure CancelOrgButtonClick(Sender: TObject);
    procedure CardEditChange(Sender: TObject);
    procedure ImportBookButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FindDispListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AcceptUseButtonClick(Sender: TObject);
    procedure InsertUseButtonClick(Sender: TObject);
    procedure NameDispListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure CodeChangeButtonClick(Sender: TObject);
    procedure CancelCodeButtonClick(Sender: TObject);
    procedure PreferredCBClick(Sender: TObject);
    procedure EditPagesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NameTransferButtonClick(Sender: TObject);
    procedure RefTransferButtonClick(Sender: TObject);
    procedure CancelUseButtonClick(Sender: TObject);
    procedure NewOrgCodeExit(Sender: TObject);
    procedure NewOrgPanelExit(Sender: TObject);
    procedure LanguageLBChange(Sender: TObject);
    procedure ResortButtonClick(Sender: TObject);
    procedure FamilyCBChange(Sender: TObject);
    procedure FindTransferButtonClick(Sender: TObject);
    procedure NameDispListDblClick(Sender: TObject);
    procedure PolnoEditChange(Sender: TObject);
    procedure RefDispListDblClick(Sender: TObject);
    procedure CommentsEditChange(Sender: TObject);
    procedure NameDispListCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    chckBoxArray: array of TCheckBox;
    PreferredNameChanged: boolean;
    function AddNewDispFind(AFind: TFind): integer;
    function AddNewDispName(AName: TOrgName): integer;
    function AddNewDispRef(ARef: TPageRef): integer;
    function CodeOK(NewOrgCode:string):ansistring;
    procedure FillLanguageList;
    function SetConfDeleteButton:boolean;
    function NameIsValid:boolean ;
    procedure CreateEditUseCheckboxes;
    procedure DisplayEPPOCheckInfo(orgcode: ansistring);
    procedure DisplayOrgNames;
    procedure DisplayRefs(RefQuery:TIB_Query;orgcode:ansistring);
    procedure DisplayFinds(FindQuery:TIB_Query;orgcode:ansistring);
    procedure FillEditUsePanel;
    procedure FillNameDispList;
    procedure FillNameFields(AName: TOrgName);
    procedure GetDetails;
    procedure ImportEPPONames;
    procedure LockOtherEditPanels;
    procedure LockEditFindPanel;
    procedure LockEditNamePanel;
    procedure LockEditRefPanel;
    procedure RecoverNameFields(AName:TOrgName);
    procedure SetActivePage;
    procedure SetEditButtonsOff;
    procedure SetEditButtonsOn;
    procedure UnLockAllEditPanels;
    procedure UnLockEditFindPanel;
    procedure UnLockEditNamePanel;
    procedure UnLockEditRefPanel;
    procedure UpdateFindCount;
    procedure UpdateNameCount;
    procedure UpdateRefCount;
    { Déclarations privées }
  public
    BasicChanged:boolean;
    NewNameID: integer;
    CurrentOrg: TOrganism;
    Mode:smallInt;  //possible values
                       //OrgInsertMode OrgDeleteMode SingleImportMode
                       //MultipleImportMode SearchMode ViewMode
                       //OrgEditNamesMode OrgEditRefsMode OrgEditFindsMode
                       //OrgEditDistMode:
    NameInsertRequested:boolean;
    OrgQuery: TIB_Query;
    NameQuery: TIB_Query;
    RefQuery: TIB_Query;
    FindQuery: TIB_Query;
    Toggle: integer;
    { Déclarations publiques }
  end;

var
  OrganismEditForm: TOrganismEditForm;

const
  cAltlinecolor = $00FFF2FF;

  implementation

uses Forays, IMSMain, OrgNameReview;
{$R *.dfm}


procedure TOrganismEditForm.AcceptUseButtonClick(Sender: TObject);
var i:integer; OldUsedBy:ansistring ;AUseName:ansistring;
begin
    OldUsedBy:=CurrentOrg.UsedBy;
    CurrentOrg.ClearUses;
   //add each use which is checked using its index
    for i := low(chckBoxArray) to high(chckBoxArray) do
      if chckBoxArray[i].Checked then
      begin
        AUseName:=IMSHomeForm.OrgUses[i+1].UseName;
        CurrentOrg.AddUse(AUseName);
      end;
    try
      if OldUsedBy<>CurrentOrg.UsedBy then
      begin
        OrgQuery.FieldValues['USEDBY']:=CurrentOrg.Usedby;
        UsesDisplay.Caption:='Uses: '+CurrentOrg.Usedby;
      end;
      SetEditButtonsOn;
    finally
      EditUsePanel.Visible:=false;
    end;
end;


function TOrganismEditForm.AddNewDispFind(AFind: TFind): integer;
begin
  with FindDispList.Items.Add do
  begin
    Caption := AFind.Foraycode;
  end;
  result := FindDispList.Items.Count - 1;
end;

function TOrganismEditForm.AddNewDispName(AName: TOrgName): integer;
// Caption is name
// subitem(0) is authority
// subitem(1) is language
// subitem(2) is preferred

begin
  with NameDispList.Items.Add do
  begin
    Caption := AName.fullname;
    if AName.IsScientific then SubItems.Add(TScientificname(AName).Author) else SubItems.Add(' ');
    if AName.LanguageName='' then AName.LanguageName:=IMSHomeForm.LanguageLookup.FindLanguageName(AName.LanguageCode);
    SubItems.Add(AName.LanguageName);
    if AName.IsScientific and TScientificName(AName).Preferred then
    begin
      SubItems.Add('P')
    end
    else SubItems.Add(' ');
    SubItems.Add(AName.EPPOStatus);
    Data:=AName;
  end;
  result := NameDispList.Items.Count - 1;
end;

function TOrganismEditForm.AddNewDispRef(ARef: TPageRef): integer;
begin
  with RefDispList.Items.Add do
  begin
    Caption := ARef.Bookcode;
    SubItems.Add(ARef.volume);
    SubItems.Add(IntToStr(ARef.pageno));
    SubItems.Add(ARef.refcode);
  end;
  result := RefDispList.Items.Count - 1;
end;

procedure TOrganismEditForm.BrowseBooksButtonClick(Sender: TObject);
begin
  BooksForm.ShowModal;
end;

procedure TOrganismEditForm.CancelRefButtonClick(Sender: TObject);
begin
  if RefQuery.Modified then
    RefQuery.Cancel;
  UnLockEditRefPanel;
end;

procedure TOrganismEditForm.CancelUseButtonClick(Sender: TObject);
begin
    EditUsePanel.Visible:=false;
end;

procedure TOrganismEditForm.CardEditChange(Sender: TObject);
begin
  SetEditButtonsOn;
  BasicChanged:=true;
  CurrentOrg.Card:=CardEdit.Text;
end;

procedure TOrganismEditForm.CancelCodeButtonClick(Sender: TObject);
begin
  NewOrgPanel.Visible:=false;
  OrgDataPanel.Visible:=true;  //restore normal appearance of orgedit form
  if (Mode=InsertMode) then Close //operation cancelled was insert so nothing more to do
end;

procedure TOrganismEditForm.CancelFindButtonClick(Sender: TObject);
begin
  if FindQuery.Modified then
    FindQuery.Cancel;
  UnLockEditFindPanel;
end;

procedure TOrganismEditForm.CancelNameButtonClick(Sender: TObject);
begin
  UnLockEditNamePanel;
end;

procedure TOrganismEditForm.CancelOrgButtonClick(Sender: TObject);
begin
  if OrgQuery.NeedToPost then OrgQuery.Cancel;
  UnLockAllEditPanels;
  SetEditButtonsOff;
  OrgDataPanel.Visible:=true;  //restore normal appearance of orgedit form
  if (Mode=InsertMode) then Close //operation cancelled was insert so nothing more to do
  else GetDetails;     //restore data
end;

procedure TOrganismEditForm.CloseButtonClick(Sender: TObject);
var Canclose,PreferredNameFound:boolean; i:integer;
begin
  canClose:=True;
  PreferredNameFound:=false;
  for i:=0 to CurrentOrg.Namelist.Count-1  do
    if TScientificName(CurrentOrg.Namelist.Items[i]).Preferred then PreferredNameFound:=true;
  if not PreferredNameFound then
   if MessageDlg('No preferred name. add one now?',mtWarning,[mbYes,mbNo],0)<>mrNo then
       CanClose:=false;
  if OrgQuery.Modified then
    if MessageDlg('Save your current changes before closing?',mtWarning,[mbYes,mbNo],0)<>mrNo then
       CanClose:=false;
  if ConfirmDeleteButton.Visible=true  then
   if MessageDlg('Cancel deletion of this organism?', mtConfirmation, [mbYes, mbNo], 0)
    <> mrYes then CanClose:=false;
  if CanClose then Close;
end;

procedure TOrganismEditForm.CodeChangeButtonClick(Sender: TObject);
begin
  if OrgQuery.Modified then ShowMessage('Save your current changes before changing the code')
  else begin
    NewOrgPanel.Visible:=true;
    NewOrgCode.SetFocus;
  end;
end;

function TOrganismEditForm.CodeOK(NewOrgCode:string):ansistring;
var ContinueValidation:boolean; NewCode:ansistring;
begin
    ContinueValidation:=true;
    NewCode:=IMSHomeForm.ValidOrgCode(NewOrgCode);   //validate
    if Newcode='        ' then
    begin
      ShowMessage('Invalid code');   //blanks mean invalid
      Newcode:='';
    end
    else begin       //valid code, now test length same as before if a code change
       // following 2 tests not always applicable
      if (Mode<>InsertMode) and (length(NewOrgCode)<>length(CurrentOrg.orgcode)) then
      begin
          if MessageDlg('Code '+NewCode+' is longer than previous code. Continue?',mtWarning,[mbYes,mbNo],0)=mrYes then
            ContinueValidation:=true
            else begin
              ContinueValidation:=false;
              Newcode:='';
            end;
      end;
      //test if out of range
      if ContinueValidation then
        if (length(NewOrgCode)<5) or (length(NewOrgCode)>6) then
          if not (MessageDlg('Code '+NewCode+' is outside the normal code length range. Continue?',mtWarning,[mbYes,mbNo],0)=mrYes) then
              Newcode:='';
            end;
      result:= NewCode;
end;

procedure TOrganismEditForm.CommentsEditChange(Sender: TObject);
begin
    BasicChanged:=true;
  SetEditButtonsOn;
  CurrentOrg.Comments:=CommentsEdit.Text;

end;

procedure TOrganismEditForm.ConfirmDeleteButtonClick(Sender: TObject);
begin
  if MessageDlg('Delete this organism?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    CurrentOrg.WriteNamesToDataset(NameQuery);  //delete any remaining names !!!!!
    IMSDM.ExplicitDelete(OrgQuery);
  end;
  ConfirmDeleteButton.Visible:=false;
  Close;
end;

procedure TOrganismEditForm.CreateEditUseCheckboxes;
   //Create a check box for each possible use on EditUsePanel
   //(excluding 'All')
var i,maxwidth:integer;
  begin
    EditUsePanel.Height:=100+IMSHomeForm.OrgUses.Count*25;
    maxwidth:=0;
    SetLength(chckBoxArray, IMSHomeForm.OrgUses.Count-1);  //no 'All'
    //create checkboxes
    for i := 0 to IMSHomeForm.OrgUses.Count-2   do  //NB count of checkboxes is 1 less than count of uses
    begin
      chckBoxArray[i] := TCheckBox.Create(nil) ;
      chckBoxArray[i].Parent:=EditUsePanel;    //need parent to display component
      chckBoxArray[i].top:=40+i*25;
      chckBoxArray[i].left:=20;
      chckBoxArray[i].ClientWidth:=Canvas.TextWidth(IMSHomeForm.OrgUses[i+1].Heading)+100;
      if chckBoxArray[i].ClientWidth>maxwidth then maxwidth:=chckBoxArray[i].ClientWidth;
      chckBoxArray[i].Caption:=IMSHomeForm.OrgUses[i+1].Heading;
    end;
    AcceptUseButton.Top:=EditUsePanel.Height-50;
    CancelUseButton.Top:=AcceptUseButton.Top;
    EditUsePanel.Width:=maxwidth;
    AcceptUseButton.Left:=40;
    CancelUseButton.Left:=(EditUsePanel.Width-CancelUseButton.Width-AcceptUseButton.Left) ;
  end;


procedure TOrganismEditForm.DeleteOrgItems(DataQuery:TIB_Query);
begin
    if not DataQuery.IsEmpty then
    begin
      DataQuery.First;
      while not DataQuery.eof do
        DataQuery.Delete;
    end;
end;

procedure TOrganismEditForm.DisplayEPPOCheckInfo(orgcode: ansistring);
begin
  // check code & preferred name in EPPO

  CurrentOrg.PopulateEPPOCheck;   //including EPPO names
  ImportEPPONames;
  with CurrentOrg.EPPOCodeStatus do       //get status
  begin
    EPPOInfo.Caption := StatusMessage;
    EPPOInfo.Font.Color := Colour;
    OrgCodeText.Font.Color := Colour;
    PrefName.Font.Color := Colour;
    EPPOOrgCode.Caption := altorgcode;
    EPPOName.Caption := altprefname;
    if (altorgcode<>'') or (altprefname<>'') then EPPOLabel.Caption:='EPPO:' else EPPOLabel.Caption:='';
    WarningImage.Visible := (StatusCode > 2); // all except pref same and code new
    if StatusCode = 0 then
    begin
      IMSHomeForm.EPPOLookupCB.Checked:=false;  //uncheck checkbox
      EPPOInfo.Caption :=
        'EPPO search has been disactivated. To reactivate it tick the checkbox on the main form';
    end;
    //ViewEPPONameButton.Enabled:= (CurrentOrg.EPPONameList.Count>0) and not (StatusCode = 0);
   if (CurrentOrg.EPPONameList.Count>0) and not (StatusCode = 0) then
    ;
  end;
end;

procedure TOrganismEditForm.DisplayOrgNames;
  // puts current org's names in NameDispList
begin
    CurrentOrg.ReadNamesFromDataset(NameQuery); // copy names to list
    CurrentOrg.NameList.Sort(TComparer<TOrgName>.Construct(IMSHomeForm.OrgNamesComparison));
    FillNameDispList
end;

procedure TOrganismEditForm.DeleteFindButtonClick(Sender: TObject);
begin
  if MessageDlg('Delete find?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FindQuery.Delete;
    FindDispList.Items[FindDispList.ItemIndex].Delete;
    UnLockEditFindPanel;
    UpdateFindCount;
  end;
end;

procedure TOrganismEditForm.DeleteNameButtonClick(Sender: TObject);
var AName:TOrgName;
begin
  AName:=NameDispList.Items[NameDispList.ItemIndex].Data; //recover name data from list item
  if (TScientificName(AName).Preferred=true)    //preferred name can't be deleted
    and (Mode<>DeleteMode) then //unless entire org is to be deleted
    ShowMessage('The preferred name cannot be deleted. Change preferred name first')
  else if MessageDlg('Delete name ' + AName.Fullname + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      CurrentOrg.DeleteNameByID(AName.NameID); // locate name in org name list and delete or mark for deletion
      if AName.EditStatus='R' then NameDispList.DeleteSelected // remove name from display (not from org's namelist yet)
      else NameDispList.Items[NameDispList.ItemIndex].Subitems[3]:=AName.EPPOStatus;  //display status
      UnLockEditNamePanel;
      SetEditButtonsOn;
    end;
end;

procedure TOrganismEditForm.DeleteRefButtonClick(Sender: TObject);
begin
  if MessageDlg('Delete reference?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    RefQuery.Delete;
    RefDispList.Items[RefDispList.ItemIndex].Delete;
    UpdateRefCount;
    UnLockEditRefPanel;
  end;
end;

procedure TOrganismEditForm.DisplayFinds(FindQuery:TIB_Query;orgcode:ansistring);
var
  AFind: TFind;
begin
  FindDispList.Clear;
  if IMSDM.OpenDatasetForOrg(FindQuery, orgcode) then
  begin
    AFind := TFind.Create;
    try
      FindQuery.First;
      while not FindQuery.eof do
      begin
        AFind.ReadFromDataset(FindQuery); // copy data
        AddNewDispFind(AFind); // copy currentname to finds display
        FindQuery.Next;
      end;
    finally
      AFind.Free;
    end;
  end;
  UpdateFindCount;
end;

procedure TOrganismEditForm.DisplayRefs(RefQuery:TIB_Query; orgcode:ansistring);
var
  ARef: TPageRef;
begin
  RefDispList.Clear;
  if IMSDM.OpenDatasetForOrg(RefQuery, orgcode) then
  begin
    ARef := TPageRef.Create;
    try
      RefQuery.First;
      while not RefQuery.eof do
      begin
        ARef.ReadFromDataset(RefQuery); // copy data
        AddNewDispRef(ARef); // copy currentname to reference display
        RefQuery.Next;
      end;
    finally
      ARef.Free;
    end;
  end;
  UpdateRefCount;
end;

procedure TOrganismEditForm.EditPagesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  //if edit in progress prevent page switch
  if EditNamePanel.Visible or EditRefPanel.Visible or EditfindPanel.Visible or EditDistPanel.Visible then
  begin
    ShowMessage('Complete the current edit operation before switching to another panel');
    AllowChange:=false;
  end;
end;

procedure TOrganismEditForm.FamilyCBChange(Sender: TObject);
begin
    currentOrg.Family:=IMSHomeForm.FamilyList.Values[FamilyCB.Text];  //update org family with code
    SetEditButtonsOn;
    BasicChanged:=true;
end;

procedure TOrganismEditForm.FillNameDispList;
var
  i: integer;
begin
    NameDispList.Clear;
    for i := 0 to CurrentOrg.NameCount - 1 do
    AddNewDispName(CurrentOrg.Names[i]); // copy currentname to name display panel
    UpdateNameCount;
end;

procedure TOrganismEditForm.FillNameFields(AName: TOrgName);
begin
  with AName do
  begin
    EditNameFullname.Text:=Fullname;
    LanguageLB.ItemIndex := LanguageLB.Items.IndexOf(LanguageName);
    EditNameComments.Text:=Comments;
  end;
  if AName.IsScientific then
  begin
    PreferredCB.Checked := TScientificName(AName).preferred;
    EditNameAuthority.Text:= TScientificName(AName).Author;
  end
  else
  begin
    EditNameAuthority.Text := '';
    PreferredCB.Checked := false;
  end;
  PreferredNameChanged:=false;
  PreferredCB.Visible:=(LanguageLB.ItemIndex<=0);
  PrefLabel.Visible:=PreferredCB.Visible;
  EditNamePanel.Visible := true;
end;

procedure TOrganismEditForm.FillEditUsePanel;
var i:integer;
// sets checkboxes on use editing panel according to edited organism's Orguse
//(excluding 'All')
begin
   for i := 0 to High(chckBoxArray) do   //NB 'All' not present so there are fewer checkboxes than uses
      if ansipos(IMSHomeForm.OrgUses[i+1].UseCode,CurrentOrg.UsedBy)>0 then //OrgUses start with 'All'
          chckBoxArray[i].Checked:=true
      else chckBoxArray[i].Checked:=false;
   UsesDisplay.Caption:='Uses: '+CurrentOrg.Usedby;
end;

procedure TOrganismEditForm.FindDispListClick(Sender: TObject);
begin
  if FindDispList.ItemIndex > -1 then // click was on items
  begin
    // retrieve data by org and book codes
    FindQuery.Locate('ORGCODE;FORAYCODE',
      VarArrayOf([CurrentOrg.orgcode,
        FindDispList.Items[FindDispList.ItemIndex].Caption]), [], 0);
    EditFindPanel.Visible := true;
    LockEditFindPanel;
    FindQuery.Edit;
  end;

end;

procedure TOrganismEditForm.FindForayButtonClick(Sender: TObject);
var
  AForay: TForay;
begin
  AForay := TForay.Create;
  try
    ForayForm.Mode:=SearchMode; // set lookup mode (sets buttons etc)
    ForayForm.ShowModal;
    AForay.Assign(ForayForm.CurrentForay); // returns empty foray if none selected
    FindQuery.FieldValues['FORAYCODE'] := AForay.Foraycode;
   finally
    AForay.Free;
  end;
end;

procedure TOrganismEditForm.FillLanguageList;
var i:integer;
begin
    i:=1;                      //skip 0 (preferred name)
    while LanguageLB.Items.Count < IMSHomeForm.LanguageLookup.Count do     //count of languages
    begin
      if IMSHomeForm.LanguageLookup.Codes[i]>'' then    //  and gaps
        LanguageLB.Items.Add(IMSHomeForm.LanguageLookup.FindLanguageName(IMSHomeForm.LanguageLookup.Codes[i]));
      inc(i);
    end;
    OrgDataSource.Dataset:=OrgQuery;
    if not IMSHomeForm.EPPOLookupCB.Checked then
       CurrentOrg.DisactivateEPPOConnection(true);
    NewNameID:=0; //initialise NameID for new records
end;

procedure TOrganismEditForm.FindTransferButtonClick(Sender: TObject);
var TransferDest:ansistring;
begin
  TransferDest:=trim(IMSHomeForm.ValidOrgCode(FindTransferCode.text));
  if (TransferDest<>'') and (TransferDest<>CurrentOrg.Orgcode) then
  begin
      //transfer names to new code
      FindQuery.First;
      while not FindQuery.eof do      //transfer all Finds
      begin
        FindQuery.FieldByName('Orgcode').Value:=TransferDest;   //new code
        FindQuery.post;
        FindQuery.Next;
      end;
      FindTransferPanel.Visible:=false;
      FindTransferCode.text:='';
      FindDispList.Clear;
      UpdateFindCount;
  end
  else ShowMessage('Enter code of organism which will receive finds');
end;

procedure TOrganismEditForm.FormActivate(Sender: TObject);
var Continue:boolean;  i:integer;
begin
  //on first entry populate Language and Family combo boxes
  if LanguageLB.Items.Count = 0 then
  begin
    FillLanguageList;
    FamilyCB.Clear;
    for i:=0 to IMSHomeForm.FamilyList.Count-1 do
      FamilyCB.Items.Add(IMSHomeForm.FamilyList.Names[i]);    //copy family names into combobox items
  end;
  //every time
  Continue:=True;
  SetEditButtonsOff;  //make sure edit buttons are not visible in case error occurs
  //if new org or change of organism locate organism by orgcode if necessary and process
  if (Mode=InsertMode) then CurrentOrg.orgcode:='';  //clear code for insertion
  //if change of organism then reset orgquery
  if (CurrentOrg.orgcode='') or (CurrentOrg.orgcode<>OrgCodeText.Caption) then
  begin
    if (CurrentOrg.orgcode<>'') then
    with OrgQuery do     //reset dataset for new org
    begin
      Close;
      ParamByName('OrgCode').Value:=(CurrentOrg.orgcode);
      Prepare;
      Open;
    end;
  end
  else if not OrgQuery.Active then OrgQuery.Open;  //reopen after closing form
  SetActivePage;  //set to appropriate page
  //error - no record
  if (OrgQuery.IsEmpty) and (Mode<>InsertMode) then  //not found for edit or deletion = error
  begin
      if Mode=DeleteMode then
      begin
         ShowMessage('No organism found with code '+CurrentOrg.orgcode);
         Continue:=false;   //can't continue
      end
      else // Edit mode, so allow user choice of adding new record
        if MessageDlg('No organism found with code '+CurrentOrg.orgcode+'. Add it now?',
        mtWarning,[mbYes,mbNo],0)<>mrYes then
          Continue:=false      //user chooses not to continue
          else begin
            Mode:=InsertMode;    //change mode
            NewOrgCode.Text:=CurrentOrg.orgcode;  //put code in edit field ready for insert
          end;
  end;
  if Continue then  //process org
  begin
    //insertion
    if Mode=InsertMode then
    begin
      unLockEditNamePanel;
      NewOrgPanel.Visible := true;
      OrgDataPanel.Visible:=false;  //hide org details until code accepted
      NameDispList.Clear;
      UpdateNameCount;
      EditPages.Visible:=false;   //hide detail tabs until org inserted
      LanguageLB.ItemIndex:=0;   //start with Latin, which is default
      FocusControl(NewOrgCode)
    end
    else begin
    //edit or deletion
      EditPages.Visible:=true;
      GetDetails;      //get basic data, names, finds, refs, etc
      //deletion
      if Mode=DeleteMode then
      begin
        if not SetConfDeleteButton then //set if all counts ae zero
          if MessageDlg('There are still names, references or finds associated with the organism. '+
            'Do you want to delete everything now without checking? NB This cannot be undone.',mtConfirmation,[mbYes,mbNo],0)=mrYes then
          begin
            DeleteOrgItems(RefQuery); //delete all refs
            RefDispList.Clear;
            UpdateRefCount;
            DeleteOrgItems(FindQuery);  //delete all finds
            FindDispList.Clear;
            UpdateFindCount;
            DeleteOrgItems(NameQuery);  //delete all names
            NameDispList.Clear;
            CurrentOrg.NameList.Clear;
            CurrentOrg.PreferredName:=CurrentOrg.PreferredName+' [deleted]';
            UpdateNameCount;
          end // delete details?
      end //mode deletion
      else begin //edit mode
               OrgQuery.Edit;
               NewOrgPanel.Visible := false;
      end;
    end //edit or deletion
  end //Continue
end;

procedure TOrganismEditForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    NameQuery.Close;
    RefQuery.close;
    FindQuery.close;
    OrgQuery.close;
    FindDispList.Clear;
    RefDispList.Clear;
end;

procedure TOrganismEditForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if EditNamePanel.Visible or EditRefPanel.Visible or EditfindPanel.Visible or EditDistPanel.Visible or
    OrgQuery.Modified then
  begin
    MessageDlg('Changes are in progress. Finish editing with Save or Cancel buttons before closing form',mtWarning,[mbOK],0);
    CanClose:= false;
  end
end;

procedure TOrganismEditForm.FormCreate(Sender: TObject);
begin
  CurrentOrg := TOrganism.Create;
  CreateEditUseCheckboxes;
  //bug fix to avoid Stream error
  NameDispList.ViewStyle:=vsReport;
  NameDispList.Clear;
  FindDispList.ViewStyle:=vsReport;
  FindDispList.Clear;
  RefDispList.ViewStyle:=vsReport;
  RefDispList.Clear;
end;

procedure TOrganismEditForm.FormDestroy(Sender: TObject);
var i:integer;
begin
  for i := 0 to IMSHomeForm.OrgUses.Count-2 do
    FreeAndNil(chckBoxArray[i]);
  FreeAndNil(CurrentOrg);
end;

procedure TOrganismEditForm.GetDetails;
begin
        PrefName.Caption:='Waiting for EPPO';
        CurrentOrg.ReadBasicFromDataSet(OrgQuery);
        OrgCodeText.Caption:=CurrentOrg.Orgcode;
        //display data for org
        OrgDataPanel.Visible:=true;
        FillEditUsePanel;
        FamilyCB.ItemIndex:=FamilyCB.Items.IndexOf(IMSHomeForm.GetFamilyName(CurrentOrg.Family)); //familycode gives line to show
        PolnoEdit.Text:=CurrentOrg.Polno;
        CardEdit.Text:=CurrentOrg.Card;
        CommentsEdit.Text:=CurrentOrg.Comments;
        EditPages.Visible:=True;
        DisplayOrgNames;
        DisplayRefs(RefQuery,CurrentOrg.Orgcode);
        DisplayFinds(FindQuery,CurrentOrg.Orgcode);
        EditNamePanel.Visible := false;
        EditRefPanel.Visible := false;
        EditFindPanel.Visible := false;
        DisplayEPPOCheckInfo(CurrentOrg.orgcode);
        PrefName.Caption := CurrentOrg.PreferredName;
end;


procedure TOrganismEditForm.ImportBookButtonClick(Sender: TObject);
var
  ABook: TBook; ANewUseName:ansistring;
begin
    ABook := TBook.Create;
    ANewUseName:=IMSHomeForm.currentBookUseName;
  try
    if IMSHomeForm.PickABook('Book',ANewUseName, ABook) then
    begin
      // insert selected book details into new record
      RefQuery.FieldValues['BOOKCODE'] := ABook.Bookcode;
      RefQuery.FieldValues['VOLUME'] := ABook.Volume;
    end;
  finally
    ABook.Free;
  end;
end;

procedure TOrganismEditForm.ViewOtherNamesButtonClick(Sender: TObject);
// get an existing name and add it to current organism
begin
  OrgNameReviewForm.CurrentOrg.Assign(CurrentOrg);  //copy current org
   if (Sender as TButton).Name='ImportNameButton' then
  begin
    OrgNameReviewForm.Mode := SingleImportMode;
  end
  else begin   //ViewEPPONamesButton
    OrgNameReviewForm.Mode := ViewMode;
  end;
  OrgNameReviewForm.SearchOrgcode.Text:=CurrentOrg.Orgcode;
  if OrgNameReviewForm.ShowModal = mrOK then       //returnButton or EPPO Import button
  //handle results:  MultipleImportMode  SingleImportMode TransferMode
    if OrgNameReviewForm.Mode = MultipleImportMode then  //Import All Names Button changes mode
    begin
    //copy names into namelist
    end
    else if OrgNameReviewForm.resultName.orgcode <> '' then    //single name returned
    begin
      //copy data into editing area
      FillNameFields(OrgNameReviewForm.resultName);
    end;
end;

procedure TOrganismEditForm.ImportEPPONames;
    //copy EPPO names into namelist
var i,j:integer;  AName,CopyName:TOrgName;
begin
      for i:=0 to CurrentOrg.EPPONameList.Count-1 do
      begin
        AName:=CurrentOrg.EPPONameList.Items[i]; //copy name
        j:=CurrentOrg.IndexOfName(trim(AName.Fullname),TScientificName(AName).Author,AName.LanguageCode);
        if j>=0 then     //found
        begin
          {if CurrentOrg.Names[j].EPPOStatus<>' ' then //if already marked, ignore
          //note this applies only to orgs modified before 2014-1-31
          begin
            CurrentOrg.Names[j].EditStatus:='S';    //make sure info is saved
            CurrentOrg.Names[j].EPPOStatus:='I';     //mark as identical in EPPO
            SetEditButtonsOn;  //change has been made
          end }
            CurrentOrg.Names[j].EPPOStatus:='I';     //mark as identical in EPPO
            SetEditButtonsOn;  //change has been made
         // end
        end
        else begin
          CopyName:=TOrgName.Create;             //make new name for namelist
          CopyName.Assign(AName);
          Inc(NewNameID);
          CopyName.NameID:=NewNameID;
          CopyName.EditStatus:='N';              //insertion into database
          CopyName.EPPOStatus:='I';              //imported from EPPO
          CurrentOrg.NameList.Add(CopyName);     //add to name list
          SetEditButtonsOn;  //change has been made
        end
      end;
      FillNameDispList;
end;

procedure TOrganismEditForm.InsertUseButtonClick(Sender: TObject);
begin
  EditUsePanel.Visible := true;
end;

procedure TOrganismEditForm.LockOtherEditPanels;
var
  i: integer;
begin
  OrgDataPanel.Enabled := false;
  for i := 0 to EditPages.PageCount - 1 do
    if i <> EditPages.ActivePageIndex then
      EditPages.Pages[i].Enabled := false;
end;

procedure TOrganismEditForm.LanguageLBChange(Sender: TObject);
begin
  if (LanguageLB.ItemIndex=0) then  //latin
    PreferredCB.Visible:=true
  else begin
    if PreferredCB.Checked then PreferredCB.Checked:=false; //turn off mistaken preferred
    PreferredCB.Visible:=false;
  end;
  //hide preferred and authority if not scientific name
  PrefLabel.Visible:=PreferredCB.Visible;
  EditNameAuthority.Visible:=PreferredCB.Visible;
  AuthLabel.Visible:=PreferredCB.Visible;
end;

procedure TOrganismEditForm.LockEditFindPanel;
begin
  FindDispList.Enabled := false;
  NewFindButton.Enabled := false;
  EditFindPanel.Visible := true;
  FindDataSource.Dataset:=FindQuery;
  //LockOtherEditPanels;
end;

procedure TOrganismEditForm.LockEditNamePanel;
//prevent access to editing controls
begin
  NameDispList.Enabled := false;
  NewNameButton.Enabled := false;
  EditNamePanel.Visible := true;
//  LockOtherEditPanels;
end;

procedure TOrganismEditForm.LockEditRefPanel;
//prevent access to editing controls and open dataset
begin
  RefDispList.Enabled := false;
  NewRefButton.Enabled := false;
  EditRefPanel.Visible := true;
  RefDataSource.Dataset:=RefQuery;
  if not RefQuery.ACtive then RefQuery.Open;
  //LockOtherEditPanels;
end;

procedure TOrganismEditForm.NameDispListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
   //compare language then preferred (latin only) then name
   compare := CompareText(Item1.SubItems[1],Item2.SubItems[1]);    //language
   if compare=0 then
      if Item1.SubItems[1]='Latin' then Compare:=CompareText(Item1.SubItems[2],Item2.SubItems[2])  //preferred
      else Compare := CompareText(Item1.Caption,Item2.Caption);     //name
end;

procedure TOrganismEditForm.NameDispListCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Odd(Item.Index) then NameDispList.Canvas.Brush.Color:=cAltlinecolor   //striped background
  else NameDispList.Canvas.Brush.Color:=clWindow;
  NameDispList.Canvas.Font.Color:=IMSHomeForm.LanguageLookup.FindLanguageColour
    (IMSHomeForm.LanguageLookup.FindLanguageCode(Item.SubItems[1]));  //language colour
  if Item.SubItems[2]='P' then NameDispList.Canvas.Font.Style:=[fsBold];  //bold for preferred name
end;

procedure TOrganismEditForm.NameDispListDblClick(Sender: TObject);
begin
  if (NameDispList.ItemIndex > -1) and (NameDispList.Items[NameDispList.ItemIndex].SubItems[3]<>'D') then  //valid click
  begin
      FillNameFields(NameDispList.Items[NameDispList.ItemIndex].Data);
      LockEditNamePanel;
  end;
end;

function TOrganismEditForm.NameIsValid:boolean;
begin
  result:=true;
  if (EditNameFullName.Text > '') and (LanguageLB.ItemIndex > -1) then
  begin
    if LanguageLB.ItemIndex=0 then  //Latin
    begin
      if (EditNameAuthority.Text = '') and (IMSDM.NameNeedsAuthority(EditNameFullName.Text)) then
        if MessageDlg('Authority is missing. Save without authority? Cancel returns to edit',mtWarning,[mbYes,mbCancel],0)<>mrYes then result:=false;
    end
    else begin
      if EditNameAuthority.Text<>'' then
      begin
           MessageDlg('Authority not appropriate for common name.',mtWarning,[mbOK],0);
           result:=false;
      end;
      if PreferredCB.Checked then
      begin
        MessageDlg('Preferred attribute not appropriate for common name.',mtWarning,[mbOK],0);
        result:=false;
      end;
    end
  end
  else begin
    ShowMessage('The name and/or language field is empty');
    result:=false;
  end;
end;

procedure TOrganismEditForm.NameTransferButtonClick(Sender: TObject);
var TransferDest:ansistring; ListItem:TListItem;
begin
  TransferDest:=trim(IMSHomeForm.ValidOrgCode(NameTransferCode.text));  //test valid destination
  if (TransferDest='') or (NameDispList.SelCount=0) then //invalid destination or no names to transfer
   ShowMessage('Select the names to transfer by CTRL+clicking on each, and enter the code of the destination organism BEFORE clicking this button')  //no valid destination
   else if (TransferDest<>CurrentOrg.Orgcode) then
   begin
    if MessageDlg('Transfer '+IntToStr(NameDispList.SelCount)+' highlighted names to '+TransferDest+'? NB This cannot be undone.',mtConfirmation,[mbYes,mbNo],0)=mrYes then   //check with user
    begin  //transfer names to new code
      NameQuery.First;
      while not NameQuery.eof do      //process all names using Listitem to hold each selected name in turn
      begin
        ListItem:=NameDispList.Selected;
        while ListItem<>nil do
        begin
          if TOrgName(ListItem.Data).NameID=NameQuery.FieldValues['NameID'] then //matching ID
          begin
            NameQuery.FieldByName('Orgcode').Value:=TransferDest;   //new code
            NameQuery.FieldByName('PREFERRED').Value:=0;            //not preferred
            NameQuery.post;
            break;  //name found
          end
          else ListItem:=NameDispList.GetNextItem(ListItem,sdBelow,[IsSelected]);   //next selection
        end;
        NameQuery.Next;
      end;
      DisplayOrgNames;    //re-read names from table
      CurrentOrg.PreferredName:=CurrentOrg.PreferredName+' [formerly]';
      UpdateRefCount;
    end; //  user check
   end;
end;

procedure TOrganismEditForm.NewFindButtonClick(Sender: TObject);
begin
  LockEditFindPanel;
  FindQuery.Append;
  FindQuery.FieldValues['ORGCODE'] := CurrentOrg.orgcode;
end;

procedure TOrganismEditForm.NewNameButtonClick(Sender: TObject);
begin
  LockEditNamePanel;
  NameInsertRequested:=true;
end;

procedure TOrganismEditForm.NewOrgCodeExit(Sender: TObject);
begin
   NewOrgCode.Text:=Uppercase(NewOrgCode.Text);
end;

procedure TOrganismEditForm.NewOrgPanelExit(Sender: TObject);
begin
  NewOrgPanel.Visible:=false;
end;

procedure TOrganismEditForm.NewRefButtonClick(Sender: TObject);
begin
  LockEditRefPanel;
  RefQuery.Append;
  RefQuery.FieldValues['ORGCODE'] := CurrentOrg.orgcode;
  RefQuery.FieldValues['PAGENO'] := 0;
  RefQuery.FieldValues['REFCODE'] := ' ';
end;

procedure TOrganismEditForm.OrgCodeOKButtonClick(Sender: TObject);
//if new code is valid and not used, make new record with new code
//for change of code copy all data
//if code exists and it was an insertion, offer edit instead
var OKtoProcess:boolean;OldCode,NewCode:ansistring;i:integer;
  CurrentFind:TFind; CurrentRef:TpageRef;RefList:TRefList; FindList:TFindList;
begin
  if (Mode=InsertMode) or (NewOrgCode.Text <> CurrentOrg.orgcode) then // organism code really has been changed
  begin
    Newcode:=CodeOK(NewOrgCode.Text);
    if Newcode='' then    //new code is invalid
    begin
      ShowMessage('Code has fatal errors');
    end
    else begin
      with OrgQuery do     //prepare dataset for new org
      begin
        Close;
        ParamByName('OrgCode').Value:=Newcode;
        Open;
      end;
      if OrgQuery.IsEmpty then        //new code is OK - no existing org has it
      begin
        if (Mode=InsertMode) then     // make new org from scratch
        begin
            CurrentOrg.Clear;         //clear current data
            OrgQuery.Insert;         //create new record for code
            OKtoProcess:=True
        end
        else
          if MessageDlg('Confirm change of code from '+CurrentOrg.Orgcode+' to '+NewCode+'?',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
          begin
            OrgQuery.Insert;         //create new record for code
            OKtoProcess:=True
          end
          else OKtoProcess:=False;
      end
      else begin   //code exists
        if (Mode=InsertMode) and
          (MessageDlg('Code '+NewCode+' is already in the database. Edit that record now?',mtWarning,[mbYes,mbNo],0)=mrYes) then
          //change to edit and exit
          begin
              Mode:=EditMode;  //change mode ?
              NewOrgPanel.Visible := false;
              CurrentOrg.Clear;
              CurrentOrg.ReadBasicFromDataSet(OrgQuery); //get details
              GetDetails;
              OrgDataPanel.Visible:=true;  //make data visible
              OKtoProcess:=false;
          end
          else begin
            ShowMessage('Code '+NewCode+' is already in the database');
            OKtoProcess:=False;
          end;
      end;
      if OKtoProcess then   //insert basic fields and handle names etc if change of code
      begin
          NewOrgPanel.Visible := false;
          oldcode:=CurrentOrg.Orgcode;
          CurrentOrg.Orgcode:=NewCode;
//          CurrentOrg.Family := IMSDM.GetFamily(CurrentOrg.Orgcode);
          //change code
          OrgQuery.FieldByName('ORGCODE').Value := NewCode;
          OrgQuery.FieldByName('FAMILY').Value := CurrentOrg.Family;
          CurrentOrg.PopulateEPPONameList;
          EditPages.Visible:=True;
          SetEditButtonsOff;
          OrgDataPanel.Visible:=true;  //make data visible
          CurrentOrg.PreferredName:='(New code)'+CurrentOrg.PreferredName;
          //create a new record in dataset with basic data
          CurrentOrg.WriteBasicToDataset(Orgquery); //Save changed or inserted record
          Orgquery.InvalidateRows;
          Orgquery.Edit;
          //make change visible
          PrefName.Caption:=CurrentOrg.PreferredName;
          OrgCodeText.Caption:=NewCode;
          //change code on all names
          if CurrentOrg.NameCount > 0 then
          begin
              for i:=0 to CurrentOrg.NameCount-1 do
              begin
                CurrentOrg.Names[i].Orgcode:=CurrentOrg.orgcode;
                CurrentOrg.Names[i].EditStatus:='N';      //names are new for the new record
              end;
              //reselect for new code
              NameQuery.Close;
              NameQuery.ParamByName('OrgCode').Value:=CurrentOrg.orgcode;
              NameQuery.Open;
              CurrentOrg.WriteNamesToDataSet(NameQuery);
          end;
          //change code on finds
          //get finds for OldCode;
          if IMSDM.OpenDatasetForOrg(FindQuery, oldcode) then
          begin //make a list of old finds
            FindList:=TFindList.Create;
            if not FindQuery.Bof then FindQuery.First;
            while not FindQuery.eof do
            begin
              CurrentFind:=TFind.Create;
              CurrentFind.ReadFromDataset(FindQuery);
              FindList.Add(CurrentFind);
              FindQuery.Next;
            end;
            //reselect for new code
            if IMSDM.OpenDatasetForOrg(FindQuery, CurrentOrg.orgcode) then
            begin //make a set of new finds
              for i:=0 to FindList.Count-1 do
              begin
                CurrentFind:= FindList[i];
                CurrentFind.orgcode:=newcode;
                FindQuery.Insert;
                CurrentFind.WriteToDataset(FindQuery);
              end;
            end;
            FindList.Clear;
            FindList.Free;
            CurrentFind:=nil;
          end;
          //get Refs for OldCode;
          if IMSDM.OpenDatasetForOrg(RefQuery, oldcode) then
          begin //make a list of old refs
            RefList:=TRefList.Create;
            if not RefQuery.Bof then RefQuery.First;
            while not RefQuery.eof do
            begin
              CurrentRef:=TPageRef.Create;
              CurrentRef.ReadFromDataset(RefQuery);
              RefList.Add(CurrentRef);
              RefQuery.Next;
            end;
            //reselect for new code
            if IMSDM.OpenDatasetForOrg(RefQuery, CurrentOrg.orgcode) then
            begin //make a set of new refs
              for i:=0 to RefList.Count-1 do
              begin
                CurrentRef:= RefList[i];
                CurrentRef.orgcode:=newcode;
                RefQuery.Insert;
                CurrentRef.WriteToDataset(RefQuery);
              end;
            end;
            RefList.Clear;
            RefList.Free;
            CurrentRef:=nil;
          end;
          if (Mode=InsertMode) then ShowMessage('The new code entry has been created and saved. Add names')
          else ShowMessage('A new entry has been made for the new code, and all names, references (not yet finds) have been copied. '+
            'Check all data including names, references and finds. NB The old code entry has not been changed');

         end;
      end;  //ContinueProcessing true
    end;  //Valid code
end;

procedure TOrganismEditForm.PolnoEditChange(Sender: TObject);
begin
    SetEditButtonsOn;
    BasicChanged:=true;
    CurrentOrg.Polno:=PolnoEdit.Text;
end;

procedure TOrganismEditForm.PreferredCBClick(Sender: TObject);
begin
  PreferredNameChanged:=true;
end;

procedure TOrganismEditForm.RecoverNameFields(AName:TOrgName);
begin
      // update name in organism namelist
      AName.fullname := EditNameFullName.Text;
      AName.LanguageName:=LanguageLB.Items[LanguageLB.ItemIndex];
      AName.LanguageCode:=IMSHomeForm.LanguageLookup.FindLanguageCode(AName.LanguageName);
      AName.Comments := EditNameComments.Text;
      if AName.IsScientific then
      begin
        TScientificName(AName).preferred := PreferredCB.Checked;
        TScientificName(AName).author := EditNameAuthority.Text;
      end;
end;

procedure TOrganismEditForm.RefDispListDblClick(Sender: TObject);
var ListItem:TListItem;
begin
  if RefDispList.ItemIndex > -1 then // click was on items
  begin
    // retrieve data by org, book, volume, page no and ref code
    ListItem:=RefDispList.Items[RefDispList.ItemIndex];
    if ListItem.SubItems[2]='' then ListItem.SubItems[2]:=' ';
    if  RefQuery.Locate('ORGCODE;BOOKCODE;VOLUME;PAGENO;REFCODE',
      VarArrayOf([CurrentOrg.orgcode, ListItem.Caption,ListItem.SubItems[0],ListItem.SubItems[1],ListItem.SubItems[2]]), [], 1) then
    begin
      EditRefPanel.Visible := true;
      LockEditRefPanel;
      RefQuery.Edit;
    end
    else ShowMessage('Error in editing ref');
  end;
end;

procedure TOrganismEditForm.RefTransferButtonClick(Sender: TObject);
var TransferDest:ansistring;  ListItem:TListItem;
begin
  TransferDest:=trim(IMSHomeForm.ValidOrgCode(RefTransferCode.text));
  if (TransferDest='') or (RefDispList.SelCount=0) then
   ShowMessage('Select the references to transfer by CTRL+clicking on each, and enter the code of the destination organism BEFORE clicking this button')  //no valid destination
  else if (TransferDest<>CurrentOrg.Orgcode) then
  begin
      //transfer refs to new code
    if MessageDlg('Transfer '+IntToStr(RefDispList.SelCount)+' highlighted refs to '+TransferDest+'? NB This cannot be undone.',mtConfirmation,[mbYes,mbNo],0)=mrYes then   //check with user
    begin  //transfer refs to new code
      if IMSDM.OpenDatasetForOrg(RefQuery,CurrentOrg.orgcode) then
      begin
        if not RefQuery.IsEmpty then RefQuery.First;
        while not RefQuery.eof do      //process all names using Listitem to hold each selected name
        begin
          ListItem:=RefDispList.Selected;
          while ListItem<>nil do
            if (ListItem.Caption=RefQuery.FieldValues['bookcode']) and
              (ListItem.SubItems[0]=RefQuery.FieldValues['volume']) and
              (ListItem.SubItems[1]=RefQuery.FieldValues['pageno']) and
              (ListItem.SubItems[2]=RefQuery.FieldValues['refcode']) then //matching record
            begin
              RefQuery.FieldByName('Orgcode').Value:=TransferDest;   //new code
              RefQuery.post;
              ListItem.Delete;
              break;  //name found
            end
            else ListItem:=RefDispList.GetNextItem(ListItem,sdBelow,[IsSelected]);   //next selection
          RefQuery.Next;
        end;
        UpdateRefCount;
      end
    end
  end
  else ShowMessage('Enter code of organism which will receive highlighted references');

end;

procedure TOrganismEditForm.ResortButtonClick(Sender: TObject);
begin
  CurrentOrg.NameList.Sort(TComparer<TOrgName>.Construct(IMSHomeForm.OrgNamesComparison));
  FillNameDispList;
end;

procedure TOrganismEditForm.SaveFindButtonClick(Sender: TObject);
var
  LineInserted: boolean;
begin
  // if required fields present save record
  if (EditForayCode.Text > '') then
  begin
    if FindQuery.NeedToPost then
    begin
      // insertion
      if (FindQuery.state = dssInsert) then
      begin
        LineInserted := true;
        // add new data to displist
        with FindDispList.Items.Add do
        begin
          Caption := EditForayCode.Text;
        end
      end
      else
      begin
        // show changed data in displist
        FindDispList.Items[RefDispList.ItemIndex].Caption :=
          EditRefBookCode.Text;
        LineInserted := false;
      end;
      FindQuery.Post;
      if LineInserted then
        FindQuery.Refresh; // refresh data
      UnLockEditFindPanel;
      UpdateFindCount;
    end;
  end;
end;

procedure TOrganismEditForm.SaveNameButtonClick(Sender: TObject);
//save editd name to dataset and display
var index:integer; AName:TOrgName;
begin
  // can only save if minimum required fields are present
  if NameIsValid then
  begin
    if NameInsertRequested then    //make a new name in organism's namelist
    begin
        //add name skeleton to list of organism names
        Index:=CurrentOrg.AddName(TOrgName.Create(CurrentOrg.Orgcode));
        CurrentOrg.Names[Index].EditStatus:='N';
        CurrentOrg.Names[Index].EPPOStatus='N';
        Inc(NewNameID);
        CurrentOrg.Names[Index].NameID:=NewNameID;  //give it an ID so it can be found again
    end
    else begin //or get name from namelist
      Index:=NameDispList.ItemIndex;
      if (CurrentOrg.Names[Index].EditStatus=' ')
      or (CurrentOrg.Names[Index].EPPOStatus='I') then  //if editing an old or newly imported name
        CurrentOrg.Names[Index].EditStatus:='M';   //mark for modification
    end;
    // copy edited values to current name fields
    AName:= CurrentOrg.Names[Index];
    RecoverNameFields(AName);
    // show edited data in displist
    if NameInsertRequested then    //for a new name fill a new line in display
    begin
      AddNewDispName(AName);
      NameInsertRequested:=false;
    end
    else begin  // or overwrite name fields in display
      NameDispList.Items[Index].Caption := AName.FullName;
      if AName.IsScientific then NameDispList.Items[Index].SubItems.Add(TScientificname(AName).Author)
      else NameDispList.Items[Index].SubItems.Add(' ');
      NameDispList.Items[Index].SubItems[1] :=
          LanguageLB.Items[LanguageLB.ItemIndex];
      if PreferredCB.Checked then NameDispList.Items[Index].SubItems[2]:='P'
      else NameDispList.Items[Index].SubItems[2]:=' ';
      NameDispList.Items[Index].SubItems.Add(AName.EPPOStatus);
    end;
    //change preferred name if necessary
    if PreferredNameChanged and AName.IsScientific then  //can happen if prefCB changed before language
    begin
      if (CurrentOrg.NameCount=1) and (TScientificname(AName).Preferred) then   //only one, so don't ask
        CurrentOrg.ChangePreferredName(Index) //change org's preferred name to this name
      else begin   //confirm change with user
        if MessageDlg('Confirm change of preferred name for organism',mtConfirmation,[mbYes,mbCancel],0)=mrYes then
        begin //remove the P marker from the old preferred name
          if PreferredCB.Checked then     //this name is preferred name
          begin
            index:=CurrentOrg.ChangePreferredName(Index); //change org's preferred name to this name  and clear old
            if Index>=0 then NameDispList.Items[index].SubItems[2]:=' ';   //clear old one in list
          end
          else  //find another preferred (may not exist)
          begin
             NameDispList.Items[index].SubItems[2]:=' ';   //clear this one in list
             index:=CurrentOrg.ChangePreferredName(-1); //find old preferred name and change org's pref name
          end
        end
        else NameDispList.Items[Index].SubItems[2]:=' ';  //ignore change
      end; //more than one name
      PreferredNameChanged:=false;
    end; //not PreferredNameChanged
    //reevaluate EPPO status because name or preferred may have have changed
    DisplayEPPOCheckInfo(CurrentOrg.orgcode);
    UnLockEditNamePanel; // exit
    SetEditButtonsOn;
  end //name valid
end;

procedure TOrganismEditForm.SaveOrgButtonClick(Sender: TObject);
//check for missing fields and allow user to abort save. Avoid asking about any others once one missing field is found
//save org data
var delaySave,namesOK:boolean;
begin
  if (CurrentOrg.PreferredName='') then ShowMessage('Organism must have a preferred name')
  else begin
    delaySave:=false;
    if (FamilyCB.ItemIndex<0) then  //family not in list
    begin
      ShowMessage('Insert a family before saving');
      delaySave:=true;
    end;
    if (not delaySave) and (CurrentOrg.Polno='') then
      if (MessageDlg('Insert a Polunin number before saving?',mtWarning,[mbYes,mbNo],0)=mrYes) then
          delaySave:=true
      else PolnoEdit.Text:=' ';
    if (not delaySave) and (CurrentOrg.UsedByIsEmpty) then
      if (MessageDlg('Insert a use code before saving?',mtWarning,[mbYes,mbNo],0)=mrYes) then
        delaySave:=true
      else OrgQuery.FieldValues['USEDBY']:='  ';
    if (not delaySave) and (CurrentOrg.EPPOValidate='') and
      (MessageDlg('Change EPPO validation status before saving?',mtWarning,[mbYes,mbNo],0)=mrYes) then
      delaySave:=true;
    if not delaySave then
    begin
      //basic data
      if BasicChanged then
      begin
        OrgQuery.Edit;
        CurrentOrg.WriteBasicToDataSet(OrgQuery);
        BasicChanged:=false;
      end;
      //names
      if (CurrentOrg.NameList.Count=0) then namesOK:=true
      else
        if (CurrentOrg.WriteNamesToDataset(NameQuery)) then
        begin
          DisplayOrgNames; //refresh names to get NAMEID for new names
          namesOK:=true;
        end
        else namesOK:=false;
      if namesOK then
      begin
        SetEditButtonsOff;    //Close if names OK  otherwise leave for more editing
        ShowMessage('Organism has been saved');
      end;
      SetConfDeleteButton;    //check whether save has cleared dependent counts
    end;
  end;
end;

procedure TOrganismEditForm.SaveRefButtonClick(Sender: TObject);
var
  LineInserted: boolean;
begin
  // if required fields present save record
  if (EditRefBookCode.Text > '') and ((EditRefPageno.Text > '')
  or (EditRefRefCode.Text > '')) then
  begin
    if RefQuery.NeedToPost then
    begin
      // insertion
      if (RefQuery.state = dssInsert) then
      begin
        LineInserted := true;
        // add new data to displist
        with RefDispList.Items.Add do
        begin
          Caption := EditRefBookCode.Text;
          SubItems.Add(EditRefVolume.Text);
          SubItems.Add(EditRefPageno.Text);
          SubItems.Add(EditRefRefCode.Text);
        end
      end
      else
      begin
        // show changed data in displist
        RefDispList.Items[RefDispList.ItemIndex].Caption :=
          EditRefBookCode.Text;
        RefDispList.Items[RefDispList.ItemIndex].SubItems[0] :=
          EditRefVolume.Text;
        RefDispList.Items[RefDispList.ItemIndex].SubItems[1] :=
          EditRefPageno.Text;
        RefDispList.Items[RefDispList.ItemIndex].SubItems[2] :=
          EditRefRefCode.Text;
        LineInserted := false;
      end;
      RefQuery.Post;
      if LineInserted then
        RefQuery.Refresh; // refresh data
      UnLockEditRefPanel;
    end;
  end;
end;

procedure TOrganismEditForm.SetActivePage;
begin
        Case Mode of
        EditNamesMode:  EditPages.ActivePage := NameTab;
        EditRefsMode:  EditPages.ActivePage := RefTab;
        EditFindsMode:  EditPages.ActivePage := FindTab;
        EditDistMode:  EditPages.ActivePage := DistribTab;
        else  EditPages.ActivePage := NameTab;
        End;
end;

function TOrganismEditForm.SetConfDeleteButton:boolean;
//for deletion of org to be allowed all counts of dependent values must be 0
begin
  ConfirmDeleteButton.Visible := (Mode=DeleteMode) and
    (CurrentOrg.NameCount = 0) and (RefCountDisp.Caption = '0') and
    (FindCountDisp.Caption = '0');
  if not SaveOrgButton.Visible then CloseButton.Visible:= not ConfirmDeleteButton.Visible;
  result:=ConfirmDeleteButton.Visible;
end;

procedure TOrganismEditForm.SetEditButtonsOff;
begin
  SaveOrgButton.Visible := false;
  CancelOrgButton.Visible := false;
  CloseButton.Visible:=true;
end;

procedure TOrganismEditForm.SetEditButtonsOn;
begin
  SaveOrgButton.Visible := true;
  CancelOrgButton.Visible := true;
  CloseButton.Visible:=false;
end;

procedure TOrganismEditForm.UnLockAllEditPanels;
var
  i: integer;
begin
  OrgDataPanel.Enabled := true;
  for i := 0 to EditPages.PageCount - 1 do
  begin
      EditPages.Pages[i].Enabled := true;
  end;
  UnLockEditNamePanel;
  UnLockEditRefPanel;
  UnLockEditFindPanel
end;

procedure TOrganismEditForm.UnLockEditFindPanel;
begin
  FindDispList.Enabled := true;
  EditFindPanel.Visible := false;
  NewFindButton.Enabled := true;
  UpdateFindCount;
end;

procedure TOrganismEditForm.UnLockEditNamePanel;
begin
  NameDispList.Enabled := true;
  EditNameFullName.Text:='';   //clear previous use
  EditNameAuthority.Text:='';
  PreferredCB.Checked:=false;
  EditNamePanel.Visible := false;
  NewNameButton.Enabled := true;
  UpdateNameCount;
end;

procedure TOrganismEditForm.UnLockEditRefPanel;
begin
  RefDispList.Enabled := true;
  EditRefPanel.Visible := false;
  NewRefButton.Enabled := true;
  UpdateRefCount;
end;

procedure TOrganismEditForm.UpdateFindCount;
begin
  FindCountDisp.Caption := IntToStr(FindQuery.Recordcount);
  SetConfDeleteButton;
end;

procedure TOrganismEditForm.UpdateNameCount;
begin
  NameCountDisp.Caption := IntToStr(CurrentOrg.NameCount);
  PrefName.Caption := CurrentOrg.PreferredName;
  SetConfDeleteButton;
end;

procedure TOrganismEditForm.UpdateRefCount;
begin
  RefCountDisp.Caption := IntToStr(RefQuery.Recordcount);
  SetConfDeleteButton;
end;


end.







