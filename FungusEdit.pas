unit FungusEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, IB_Grid, ExtCtrls, ForayConcepts;

type
  TForayEditForm = class(TForm)
    CopyButton: TButton;
    UpdateButton: TButton;
    IgnoreButton: TButton;
    ExistPanel: TPanel;
    oldforaycode: TEdit;
    oldforayname: TEdit;
    oldforaycountry: TEdit;
    oldforayplace: TEdit;
    oldforaydate: TEdit;
    Panel2: TPanel;
    IMSforaycode: TEdit;
    IMSforayname: TEdit;
    IMSforaycountry: TEdit;
    IMSforayplace: TEdit;
    IMSVolume: TEdit;
    IMSforaydate: TEdit;
    IMScomments: TMemo;
    oldcomments: TMemo;
    DifferenceList: TListBox;
    Label2: TLabel;
    AbortButton: TButton;
    Panel3: TPanel;
    shortcodelabel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label15: TLabel;
    Label21: TLabel;
    recct: TLabel;
    procedure oldForayChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure IMSforaycodeChange(Sender: TObject);
    procedure AbortButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ForayEditForm: TForayEditForm;

implementation

uses FungiTransfer;


{$R *.dfm}

procedure TForayEditForm.AbortButtonClick(Sender: TObject);
begin
     FungiTransferForm.Interrupt:=True;
     modalresult:=mrIgnore;
end;


procedure TForayEditForm.FormActivate(Sender: TObject);
begin
        oldforaycode.Text:=FungiTransferForm.CurrentOldForay.foraycode;
        oldforayname.Text:=FungiTransferForm.CurrentOldForay.forayname;
        oldforaycountry.Text:=FungiTransferForm.CurrentOldForay.foraycountry;
        oldforayplace.Text:=FungiTransferForm.CurrentOldForay.forayplace;
        oldforaydate.Text:=FungiTransferForm.CurrentOldForay.foraydate;
        oldcomments.Text:=FungiTransferForm.CurrentOldForay.foraycomments;
        IMSforaycode.Text:=FungiTransferForm.CurrentIMSForay.foraycode;
        IMSforayname.Text:=FungiTransferForm.CurrentIMSForay.forayname;
        IMSforaycountry.Text:=FungiTransferForm.CurrentIMSForay.foraycountry;
        IMSforayplace.Text:=FungiTransferForm.CurrentIMSForay.forayplace;
        IMSforaydate.Text:=FungiTransferForm.CurrentIMSForay.foraydate;
        IMScomments.Text:=FungiTransferForm.CurrentIMSForay.foraycomments;
end;

procedure TForayEditForm.IMSforaycodeChange(Sender: TObject);
begin
  if sender=IMSforaycode then FungiTransferForm.CurrentIMSForay.foraycode:=IMSforaycode.Text;
  if sender=IMSforayname then FungiTransferForm.CurrentIMSForay.forayname:=IMSforayname.Text;
  if sender=IMSforaycountry then FungiTransferForm.CurrentIMSForay.foraycountry:=IMSforaycountry.Text;
  if sender=IMSforayplace then FungiTransferForm.CurrentIMSForay.forayplace:=IMSforayplace.Text;
  if sender=IMSforaydate then FungiTransferForm.CurrentIMSForay.foraydate:=IMSforaydate.Text;
  if sender=IMScomments then FungiTransferForm.CurrentIMSForay.foraycomments:=IMScomments.Text;
end;

procedure TForayEditForm.oldForayChange(Sender: TObject);
begin
  if sender=oldforaycode then FungiTransferForm.CurrentOldForay.foraycode:=oldforaycode.Text;
  if sender=oldforayname then FungiTransferForm.CurrentOldForay.forayname:=oldforayname.Text;
  if sender=oldforaycountry then FungiTransferForm.CurrentOldForay.foraycountry:=oldforaycountry.Text;
  if sender=oldforayplace then FungiTransferForm.CurrentOldForay.forayplace:=oldforayplace.Text;
  if sender=oldforaydate then FungiTransferForm.CurrentOldForay.foraydate:=oldforaydate.Text;
  if sender=oldcomments then FungiTransferForm.CurrentOldForay.foraycomments:=oldcomments.Text;
end;

end.
