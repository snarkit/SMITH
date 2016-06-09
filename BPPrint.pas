unit BPPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IB_Access, BookConcepts;

type
  TBPPrintForm = class(TForm)
    NextPageButton: TButton;
    PaintBox1: TPaintBox;
    procedure NextPageButtonClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    WBitmap:TBitmap;
    { Déclarations publiques }
  end;

var
  BPPrintForm: TBPPrintForm; suspend:boolean;



implementation

uses Books;

{$R *.dfm}

{$UNDEF DEBUG}



procedure TBPPrintForm.FormCreate(Sender: TObject);
begin
      BPPrintForm.WBitmap:=TBitmap.Create;               //create bitmap for paintbox
end;

procedure TBPPrintForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(WBitmap);
end;

procedure TBPPrintForm.NextPageButtonClick(Sender: TObject);
begin
    ModalResult:=mrOK;
end;

procedure TBPPrintForm.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Draw(0,0,WBitmap);

end;

end.
