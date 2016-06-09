unit Refs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, IB_Access, BookConcepts, Books,
  DBGrids, Mask, ExtCtrls, DB, IBODataSet, IB_Grid, IB_Controls, IB_EditButton,
  IB_Components, OrganismEdit, IB_NavigationBar;

type
  TBookRefsForm = class(TForm)
    RefsGrid: TIB_Grid;
    RefDataSource: TIB_DataSource;
    Panel1: TPanel;
    NewRefButton: TButton;
    EditRefButton: TButton;
    DeleteRefButton: TButton;
    EditPanel: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Orgcode: TIB_Edit;
    DBPage: TIB_Edit;
    DBVolume: TIB_Edit;
    Button1: TButton;
    CancelRefButton: TButton;
    DBRefcode: TIB_Edit;
    Label3: TLabel;
    EditRefNotes: TIB_Memo;
    Panel2: TPanel;
    ChangeBookButton: TButton;
    TypeLabel: TLabel;
    DispBookCode: TLabel;
    JumpEdit: TEdit;
    JumpButton: TButton;
    CloseButton: TButton;
    IB_NavigationBar1: TIB_NavigationBar;
    procedure SaveRefButtonClick(Sender: TObject);
    procedure NewRefButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure JumpButtonClick(Sender: TObject);
    procedure CancelRefButtonClick(Sender: TObject);
    procedure EditRefButtonClick(Sender: TObject);
    procedure DeleteRefButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChangeBookButtonClick(Sender: TObject);
    procedure RefsGridDblClick(Sender: TObject);
  private
    procedure GetReferences;
    { D�clarations priv�es }
  public
    CurrentBook:TBook;
    CurrentBookUse:ansistring;
    RefQuery: TIB_Query;
  end;

var
  BookRefsForm: TBookRefsForm;


implementation

uses IMSMain;




{$R *.dfm}



procedure TBookRefsForm.CancelRefButtonClick(Sender: TObject);
begin
    if RefQuery.Modified then
     RefQuery.Cancel;
    EditPanel.Visible:=false;

end;

procedure TBookRefsForm.ChangeBookButtonClick(Sender: TObject);
begin
      if IMSHomeForm.PickABook(CurrentBookUse, '', CurrentBook) then
      begin
        DispBookCode.Caption:=CurrentBook.bookcode;
        GetReferences;
      end;
end;

procedure TBookRefsForm.CloseButtonClick(Sender: TObject);
begin
   if RefQuery.Modified then
      if MessageDlg('Save last edited record?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
        RefQuery.Post;
  Close;
end;


procedure TBookRefsForm.DeleteRefButtonClick(Sender: TObject);
begin
  if MessageDlg('Delete reference?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    RefQuery.Delete;
  end;
end;

procedure TBookRefsForm.EditRefButtonClick(Sender: TObject);
begin
    EditPanel.Visible:=true;
    RefQuery.Edit;
end;

procedure TBookRefsForm.FormActivate(Sender: TObject);
begin
    RefsGrid.DataSource.Dataset:=RefQuery;     //in case data set changed
    if CurrentBook.IsEmpty then     //first entry
    begin
      CurrentBookUse:=BooksForm.CurrentUseName;
      if CurrentBookUse='' then CurrentBookUse:='Source';
      if IMSHomeForm.PickABook(CurrentBookUse, '', CurrentBook) then
        GetReferences
      else begin     //prevent cycling on first entry
        ShowMessage('No book has been selected');
        CurrentBook.Bookcode:='unselected';
      end;
      DispBookCode.Caption:=CurrentBook.bookcode;
    end
end;

procedure TBookRefsForm.FormCreate(Sender: TObject);
begin
  CurrentBook := TBook.Create;
end;

procedure TBookRefsForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CurrentBook);
end;

procedure TBookRefsForm.GetReferences;
begin
      EditPanel.Visible:=false;
      // find references
      RefQuery.Close;
      RefQuery.ParamByName('bookcode').Value := CurrentBook.Bookcode;
      RefQuery.ParamByName('volume').Value := '%'+CurrentBook.Volume;
      RefQuery.Prepare;
      RefQuery.Open;
      if RefQuery.IsEmpty then ShowMessage('No refences found in the '+IMSHomeForm.TestRG.Buttons[IMSHomeForm.TestRG.ItemIndex].Caption)
      else RefQuery.OrderingItemNo:=1;
end;

procedure TBookRefsForm.JumpButtonClick(Sender: TObject);
//
var ColOK:boolean; JumpValue:variant;
begin
  ColOK:=True;
  If (JumpEdit.Text<>'') then
  begin
    if (RefQuery.OrderingField.IsText) then
    begin
      if StrToIntDef(JumpEdit.Text,9999)=9999 then JumpValue:=Uppercase(JumpEdit.Text);
    end
    else
      if (RefQuery.OrderingField.IsNumeric) then
      begin
        if StrToIntDef(JumpEdit.Text,9999)<9999 then
          JumpValue:=StrToInt(JumpEdit.Text);
      end
      else begin
        ShowMessage('Cannot use jump in this column');   //not numeric or text
        ColOK:=false;
      end;
    if ColOK then
    begin
      RefQuery.DisableControls;
      if JumpValue<RefQuery.OrderingField.Value then
        RefQuery.First;
      while not RefQuery.EOF and (RefQuery.OrderingField.Value<JumpValue)
        do RefQuery.Next;
      RefQuery.EnableControls;
    end;
  end;
end;

procedure TBookRefsForm.NewRefButtonClick(Sender: TObject);
begin
  RefQuery.Append;
  RefQuery.FieldValues['BOOKCODE']:=currentBook.bookcode;
  EditPanel.Visible:=true;
end;

procedure TBookRefsForm.RefsGridDblClick(Sender: TObject);
begin
    OrganismEditForm.CurrentOrg.OrgCode:=RefQuery.FieldValues['OrgCode'];
    OrganismEditForm.Mode:=EditRefsMode;
    OrganismEditForm.ShowModal;
end;

procedure TBookRefsForm.SaveRefButtonClick(Sender: TObject);
begin
    if RefQuery.Modified then
      RefQuery.Post;
    EditPanel.Visible:=false;
end;


end.
