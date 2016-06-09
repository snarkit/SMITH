unit OrgNameSelect;
//Presents list of names
//returns selected name in

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, DBCtrls, IMSData, OrganismConcepts, Math,
  Grids, DBGrids, DB, ExtCtrls, IB_Components, IB_Grid, IB_Access,
  Generics.Defaults, StrUtils, IB_NavigationBar;

type

  TOrgNameSelectForm = class(TForm)
    NavPanel: TPanel;
    JumpGB: TGroupBox;
    JumpButton: TButton;
    Jump: TEdit;
    NameQueryGrid: TIB_Grid;
    FilterPanel: TPanel;
    NameGridDS: TIB_DataSource;
    NameQuery: TIB_Query;
    SortRG: TRadioGroup;
    ContentFilterGB: TGroupBox;
    NameStrFilter: TEdit;
    NameStrFilterCB: TCheckBox;
    LanguageFilterGB: TGroupBox;
    LanguageList: TListBox;
    LanguageFilterCB: TCheckBox;
    AcceptButton: TButton;
    CancelButton: TButton;
    PrefNameStringGB: TGroupBox;
    PrefnameFilterStr: TEdit;
    PrefNameFilterCB: TCheckBox;
    PreferredOnlyCB: TCheckBox;
    FromStartCB: TCheckBox;
    CaseCB: TCheckBox;
    IB_NavigationBar1: TIB_NavigationBar;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure OrgNamesListGridKeyPress(Sender: TObject; var Key: Char);
    procedure SortRGClick(Sender: TObject);
    procedure JumpButtonClick(Sender: TObject);
    procedure NameStrFilterCBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NameQueryGridClick(Sender: TObject);
    //procedure CancelButtonClick(Sender: TObject);
    procedure PreferredOnlyCBClick(Sender: TObject);
    //procedure LanguageSelectButtonClick(Sender: TObject);
    procedure LanguageListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LanguageFilterCBClick(Sender: TObject);
    procedure LanguageListEnter(Sender: TObject);
    procedure LanguageListExit(Sender: TObject);
    procedure NameStrFilterEnter(Sender: TObject);
    procedure NameStrFilterExit(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure PrefnameFilterStrEnter(Sender: TObject);
    procedure PrefNameFilterCBClick(Sender: TObject);
    procedure PrefnameFilterStrExit(Sender: TObject);
    procedure FromStartCBClick(Sender: TObject);
    procedure CaseCBClick(Sender: TObject);
    procedure AcceptButtonClick(Sender: TObject);
    procedure NameQueryGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
{    procedure NameGridDSDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);}
  private
    CurrentPos:integer;
    FilterReady:boolean;
    Tablename:ansistring;
    SetupDone:boolean;
    function FindLineContents(JumpText:string;StartPos:integer):boolean;
    procedure GetNames;
    function GetNameFilter:string;
    function GetPrefNameFilter:string;
    function GetLangFilter:string;
    procedure RenewData;
    procedure Setup;
  public
    DSQLDatasetN:string;
    DSQLDatasetO:string;
    resultName:TOrgName;
    Mode:smallInt;
    CallingRoutine:integer;
    //traceCount:integer;
  end;

var OrgNameSelectForm:TOrgNameSelectForm;     ActiveColumn: integer =-1;

const SortFields: array[0..2] of ansistring =('OrgCode','Fullname','Language');

implementation

uses OrganismEdit, IMSMain;

{$R *.dfm}

//
//  Form which allows selection of names in the database
//


procedure TOrgNameSelectForm.AcceptButtonClick(Sender: TObject);
begin
  if Mode=EditMode then
  begin
    OrganismEditForm.Mode:=EditMode;
    OrganismEditForm.CurrentOrg.Clear;
    OrganismEditForm.CurrentOrg.Orgcode:=ResultName.OrgCode;
    OrganismEditForm.ShowModal;
  end
  else begin
    SetupDone:=false;
    ModalResult:=mrOK;
  end;
end;

procedure TOrgNameSelectForm.CancelButtonClick(Sender: TObject);
begin
  if Mode=EditMode then Close
  else begin
    SetupDone:=false;
    ModalResult:=mrCancel;
  end;
end;

procedure TOrgNameSelectForm.CaseCBClick(Sender: TObject);
begin
  if NameStrFilterCB.Checked or PrefNameFilterCB.Checked then RenewData;  //only meaningful if string filters on
end;

function TOrgNameSelectForm.FindLineContents(JumpText:string;StartPos:integer):boolean;
begin
    if (JumpText='') then result:=false
    else
      result:=NameQuery.Locate('FULLNAME',JumpText,[lopCaseInsensitive, lopPartialKey, lopFindNearest],startpos);
end;

procedure TOrgNameSelectForm.FormActivate(Sender: TObject);
begin
    if not setupdone then Setup;
    RenewData;
end;

procedure TOrgNameSelectForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    //OrgNamesListGrid.DataSource.Dataset.Close;
end;

procedure TOrgNameSelectForm.FormCreate(Sender: TObject);
begin
  resultName:=TOrgName.Create;
end;

procedure TOrgNameSelectForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(resultName);
end;

procedure TOrgNameSelectForm.FromStartCBClick(Sender: TObject);
begin
  if NameStrFilterCB.Checked or PrefNameFilterCB.Checked then RenewData;  //only meaningful if string filters on
end;

function TOrgNameSelectForm.GetNameFilter:string;
var k:integer;PadText:string;
begin
    if NameStrFilter.Text<>'' then
    begin
      if FromStartCB.Checked then PadText:='' else PadText:='%';
      if CaseCB.Checked then
        result:='(n.FullName like '+QuotedStr(PadText+NameStrFilter.Text+'%')+')' //case sensitive
      else
        result:='(Upper(n.FullName) like '+QuotedStr(PadText+UpperCase(NameStrFilter.Text)+'%')+')';
    end
    else result:='';
end;

function TOrgNameSelectForm.GetPrefNameFilter:string;
var k:integer;PadText:string;
begin
    if PrefNameFilterStr.Text<>'' then
    begin
      if FromStartCB.Checked then PadText:='' else PadText:='%';
      if CaseCB.Checked then
        result:='(o.PreferredName like '+QuotedStr(PadText+PrefNameFilterStr.Text+'%')+')' //case sensitive
      else
        result:='(Upper(o.PreferredName) like '+QuotedStr(PadText+UpperCase(PrefNameFilterStr.Text)+'%')+')';
   end
   else result:='';
end;

function TOrgNameSelectForm.GetLangFilter:string;
var i:integer; joinphr,phrase:string;
begin
    if PreferredOnlyCB.Checked then       //must be latin
      result:='(n.LANGUAGE = ' + QuotedStr('la') + ') and (n.PREFERRED<>0)'
    else begin
      result:='';
      joinphr:='';
      if LanguageList.SelCount>0 then
        // language
        for i:=0 to LanguageList.Items.Count-1 do
        begin
          if  LanguageList.Selected[i] then
            phrase:= '(Language = '+QuotedStr(IMSHomeForm.LanguageLookup.FindLanguageCode(LanguageList.Items[i]))+')'
          else phrase:='';
          if phrase>'' then
          begin
            if result>'' then joinphr:= ' or ';
            result:=result+joinphr+phrase;
          end;
        end;
        if (result>'') and (joinphr>'') then result:='('+result+')';  //several languages  means multiple ORs
    end;
end;

procedure TOrgNameSelectForm.GetNames;
// get names from database
// by building a dynamic SQL statement from filter info
// names corresponding to Orgcode or all if no Orgcode
var LangFilter,NameFilter,Filter,ordering, oldresultname:string; oldpos:integer;
begin
    oldresultname:=ResultName.Fullname; //resultname changes every time line is changed
    oldPos:=NameQuery.RecNo;
    //name filter
    NameFilter:='';
    if PrefNameFilterCB.Checked then NameFilter:=GetPrefNameFilter;
    if NameStrFilterCB.Checked then
      if NameFilter>'' then NameFilter:=NameFilter+' and '+GetNameFilter  //only use filter if required
      else NameFilter:=GetNameFilter;

    //language filter
    if (LanguageFilterCB.Checked) or PreferredOnlyCB.Checked then LangFilter:=GetLangFilter;
    if LangFilter<>'' then
      if NameFilter<>'' then
        Filter:=NameFilter+' and '+LangFilter
      else Filter:=LangFilter
    else if NameFilter<>'' then
        Filter:=NameFilter;

    NameQuery.Close;
    NameQuery.SQL.Clear;
    NameQuery.SQL.Add('Select l.sortorder, l.langname, n.nameid, n.orgcode, n.fullname,'+
      'n.authority, n.preferred, n.language, n.datemodified, n.comments, n.epptstatus from '+DSQLDatasetN+' n');
    NameQuery.SQL.Add('Join LANGUAGES l ON l.langcode=n.language');
    if PrefNameFilterCB.Checked then NameQuery.SQL.Add('Join '+DSQLDatasetO+' o ON o.orgcode=n.orgcode');
    if (Filter<>'') then
      NameQuery.SQL.Add('where '+Filter);
    if SortRG.ItemIndex=0 then //code
       ordering:='orgcode,l.sortorder,n.preferred desc'
    else if SortRG.ItemIndex=1 then  //name
            ordering:='FULLNAME'
    else if SortRG.ItemIndex=2 then  //name
            ordering:='l.sortorder,n.preferred desc'         //language
    else ordering:='n.datemodified desc,orgcode,l.sortorder,n.preferred desc';
    NameQuery.SQL.Add('order by '+ ordering);
    NameQuery.Prepare;
    NameQuery.Open;
    if NameQuery.IsEmpty then ShowMessage('No organisms found with this filter and dataset')
    else begin
      NameQuery.DisableControls;
      // locate previously selected line if possible
      if not NameQuery.Locate('FULLNAME',oldresultname,[lopCaseInsensitive, lopPartialKey ],oldPos) then
      begin
          NameQuery.First;
          ResultName.readFromDataset(NameQueryGrid.DataSource.Dataset);
      end;
      NameQuery.EnableControls;
    end;
    FilterReady:=true;
end;

procedure TOrgNameSelectForm.JumpButtonClick(Sender: TObject);
var CurrentPos:integer;
begin
  if NameQuery.eof then NameQuery.First else NameQuery.Next;
  CurrentPos:=NameQuery.RecNo;        //avoid always finding current rec
  if (SortRG.ItemIndex=1) then   //name sort order
  begin
    NameQuery.DisableControls;
    //try down first and if not found ask if to start at top
    while not(NameQuery.Eof) and (pos(Jump.Text,NameQuery.FieldValues['FULLNAME'])=0) do NameQuery.Next;
    if NameQuery.Eof then
    begin
      NameQuery.EnableControls;
      if (MessageDlg('Continue search from top of file?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
      begin
        NameQuery.DisableControls;
        NameQuery.First;
        while (CurrentPos>NameQuery.RecNo) and (pos(Jump.Text,NameQuery.FieldValues['FULLNAME'])=0) do NameQuery.Next;
        if CurrentPos<NameQuery.RecNo then ShowMessage('Not found');
      end;
    end;
    NameQuery.EnableControls;
  end;
end;


procedure TOrgNameSelectForm.LanguageFilterCBClick(Sender: TObject);
begin
  if FilterReady then     //bound to be on?
  begin
    FilterReady:=false;  //lock getnames to prevent recursive calls
    PreferredOnlyCB.checked:=false;
    FilterReady:=true;
    //if not LanguageFilterCB.Checked then LanguageList.ItemIndex:=-1; //clear language selection
    RenewData;
  end;
end;

procedure TOrgNameSelectForm.LanguageListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  //inc(tracecount);
  LanguageList.Canvas.Font.Color:=IMSHomeForm.LanguageLookup.FindLanguageColour((Control as TListBox).Items[Index]);
  LanguageList.Canvas.TextOut(Rect.Left + 4, Rect.Top, (Control as TListBox).Items[Index])  { Display the text. }
end;

procedure TOrgNameSelectForm.LanguageListEnter(Sender: TObject);
begin
    FilterReady:=false;
    LanguageFilterCB.Checked:=false;  //turn checkbox off when langugae selection is changed so user can turn it on!
end;

procedure TOrgNameSelectForm.LanguageListExit(Sender: TObject);
begin
    FilterReady:=True;
end;

{procedure TOrgNameSelectForm.LanguageSelectButtonClick(Sender: TObject);
begin
    RenewData;
end;       }

{procedure TOrgNameSelectForm.NameGridDSDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if NameGridDS.State=dssbrowse then
  NameQueryGrid.CurrentRowFont.Color:=IMSHomeForm.LanguageLookup.FindLanguageColour(ansistring(NameQueryGrid.GridFields[3].Value));

end;   }

procedure TOrgNameSelectForm.NameQueryGridClick(Sender: TObject);
begin
    if Mode=Mode then      //get orgname
      resultName.readFromDataset(NameQueryGrid.DataSource.Dataset)
    else begin
      OrganismEditForm.Mode:=EditNamesMode;    //Only edit mode
      OrganismEditForm.CurrentOrg.Clear;
      OrganismEditForm.CurrentOrg.Orgcode:=OrgNameSelectForm.ResultName.OrgCode;
      OrganismEditForm.ShowModal;                 //edit
    end;
end;


procedure TOrgNameSelectForm.NameQueryGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var langcode:ansistring; CellText:string;
begin
  begin
    langcode:=IMSHomeForm.LanguageLookup.FindLanguageCode(NameQueryGrid.GetCellDisplayText(4, ARow));   //language name
    if langcode>'' then
      NameQueryGrid.Canvas.Font.Color:=IMSHomeForm.LanguageLookup.FindLanguageColour(langcode)
    else NameQueryGrid.Canvas.Font.Color:=clBlack;
    NameQueryGrid.Canvas.FillRect(Rect);
    if (NameQueryGrid.GetCellDisplayText(5, ARow)<>'0') then  //bold for preferred name line
      NameQueryGrid.Canvas.Font.Style:=[fsBold]
    else NameQueryGrid.Canvas.Font.Style:=[];
    CellText:=NameQueryGrid.GetCellDisplayText(ACol, ARow);
    if (ACol=5) then
      if (NameQueryGrid.GetCellDisplayText(5, ARow)<>'0') then CellText:='P'  //P  for preferred name
      else CellText:='';
    NameQueryGrid.Canvas.TextOut(Rect.Left,Rect.Top,CellText);
  end;
end;

procedure TOrgNameSelectForm.NameStrFilterCBClick(Sender: TObject);
begin
  if NameStrFilter.Text<>'' then   //no filter string - do nothing
    RenewData;
end;

procedure TOrgNameSelectForm.NameStrFilterEnter(Sender: TObject);
begin
  FilterReady:=false;
  NameStrFilterCB.Checked:=false;  //tuen CB off so user can turn it on
end;

procedure TOrgNameSelectForm.NameStrFilterExit(Sender: TObject);
begin
  FilterReady:=true;
end;

procedure TOrgNameSelectForm.OrgNamesListGridKeyPress(Sender: TObject;
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

procedure TOrgNameSelectForm.PreferredOnlyCBClick(Sender: TObject);
begin
   if FilterReady then
   begin
     if not PreferredOnlyCB.Checked then LanguageList.ItemIndex:=0    //latin is default
     else begin
        FilterReady:=false;
        LanguageFilterCB.Checked:=false;
        FilterReady:=True;
     end;
     Renewdata;
   end;
end;

procedure TOrgNameSelectForm.PrefNameFilterCBClick(Sender: TObject);
begin
  if PrefNameFilterStr.Text<>'' then   //no filter string - do nothing
    if PrefNameFilterCB.Checked then   //on
    begin
      //if NameStrFilterCB.Checked then NameStrFilterCB.Checked:=false;  //turn name filter off (not necessary?)
      SortRG.ItemIndex:=0;   //set code order
      RenewData;
    end
    else RenewData;
end;

procedure TOrgNameSelectForm.PrefnameFilterStrEnter(Sender: TObject);
begin
  FilterReady:=false;
  PrefNameFilterCB.Checked:=false;  //turn CB off so user can turn it on
end;

procedure TOrgNameSelectForm.PrefnameFilterStrExit(Sender: TObject);
begin
  FilterReady:=true;
end;

procedure TOrgNameSelectForm.RenewData;
begin
    if FilterReady then
    begin
      NameQuery.DisableControls;
      GetNames;
      NameQuery.EnableControls;
    end;
end;

procedure TOrgNameSelectForm.Setup;
//initialise appropriate sort order and filters
// then open data
var i:integer;
begin
    if LanguageList.Items.Count = 0 then
    begin
      i:=0;                      //skip 0 (preferred name)
      while LanguageList.Items.Count <= IMSHomeForm.LanguageLookup.Count-1 do     //count of languages
      begin
        if IMSHomeForm.LanguageLookup.Codes[i]>'' then    //  and gaps
          LanguageList.Items.Add(IMSHomeForm.LanguageLookup.FindLanguageName(IMSHomeForm.LanguageLookup.Codes[i]));
        inc(i);
      end;
    end;
    NameQueryGrid.Visible:=true;
    FilterPanel.Visible:=true;
    PreferredOnlyCB.Checked := true;
    // adjust settings for search for name
    NameStrFilter.Text := '';
    NameStrFilterCB.Checked := false;
    PrefNameFilterStr.Text := '';
    PrefNameFilterCB.Checked := false;
    SortRG.ItemIndex:=1; //sort by name
    FilterReady:=True;
    if Mode=EditMode then AcceptButton.Caption:='Edit organism'
    else AcceptButton.Caption:='Return name';
    setupdone:=true;
    //tracecount:=0;
end;

procedure TOrgNameSelectForm.SortRGClick(Sender: TObject);
begin
   Renewdata;
end;

end.
