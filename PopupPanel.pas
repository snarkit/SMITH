unit PopupPanel;

interface
uses controls, SysUtils, ExtCtrls;

type
  TPopUpPanel = class(TPanel)
  private
    fNormalTop:integer;
    fNormalHeight:integer;
    fpopUpTop:integer;
    fpopUpHeight:integer;
    procedure SetPopupTop(Value:integer);
    procedure SetPopupHeight(Value:integer);
  published
    property popUpTop:integer read fpopUpTop write SetPopUpTop;
    property popUpHeight:integer read fpopUpHeight write SetPopupHeight;
    procedure PopUp;
    procedure PopDown;
  end;

implementation

procedure TPopUpPanel.PopUp;
begin
  if (fPopUpHeight > 0) then
  begin
    fNormalTop:=Top;
    fNormalHeight:=Height;
    Top:=fPopUpTop;
    Height:=fPopUpHeight;
  end;
end;

procedure TPopUpPanel.PopDown;
begin
  if (fNormalHeight > 0) and (fNormalTop >= 0)then
  begin
    Top:=fNormalTop;
    Height:=fNormalHeight;
  end;
end;

procedure TPopUpPanel.SetPopupTop(Value:integer);
begin
  if Value >=0 then fPopUpTop:=Value;
end;

procedure TPopUpPanel.SetPopupHeight(Value:integer);
begin
  if Value >=fNormalHeight then fPopUpHeight:=Value;
end;


end.
