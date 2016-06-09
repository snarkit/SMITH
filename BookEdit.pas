unit BookEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, IB_Grid, ExtCtrls, BookConcepts;

type
  TBookEditForm = class(TForm)
    CopyButton: TButton;
    UpdateButton: TButton;
    IgnoreButton: TButton;
    ExistPanel: TPanel;
    oldBookcode: TEdit;
    oldshortcode: TEdit;
    oldAuthor: TEdit;
    oldTitle: TEdit;
    oldVolume: TEdit;
    oldEdition: TEdit;
    oldPublisher: TEdit;
    oldPlace: TEdit;
    oldYearpub: TEdit;
    oldOPlace: TEdit;
    Panel2: TPanel;
    IMSBookcode: TEdit;
    IMSshortcode: TEdit;
    IMSAuthor: TEdit;
    IMSTitle: TEdit;
    IMSVolume: TEdit;
    IMSEdition: TEdit;
    IMSPublisher: TEdit;
    IMSPlace: TEdit;
    IMSYearpub: TEdit;
    IMSOPublisher: TEdit;
    IMSOPlace: TEdit;
    IMSPrice: TEdit;
    IMSRef: TEdit;
    IMSOYear: TEdit;
    IMSISBN: TEdit;
    IMSSubject: TEdit;
    IMSDateAcq: TEdit;
    IMSNbPages: TEdit;
    IMSUsedBy: TEdit;
    IMSNotes: TMemo;
    oldPrice: TEdit;
    oldRef: TEdit;
    oldOYear: TEdit;
    oldISBN: TEdit;
    oldSubject: TEdit;
    oldDateAcq: TEdit;
    oldNbPages: TEdit;
    oldUsedBy: TEdit;
    oldNotes: TMemo;
    OldBookPlateStatus: TEdit;
    IMSBookPLateStatus: TEdit;
    DifferenceList: TListBox;
    Label2: TLabel;
    AbortButton: TButton;
    oldOPublisher: TEdit;
    Panel3: TPanel;
    bookcodelabel: TLabel;
    shortcodelabel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    Label15: TLabel;
    Label21: TLabel;
    recct: TLabel;
    procedure oldBookChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure IMSBookcodeChange(Sender: TObject);
    procedure AbortButtonClick(Sender: TObject);
    procedure BookPlateCopyButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BookEditForm: TBookEditForm;

implementation

uses BooksTransfer;


{$R *.dfm}

procedure TBookEditForm.AbortButtonClick(Sender: TObject);
begin
     BookstransferForm.Interrupt:=True;
     modalresult:=mrIgnore;
end;

procedure TBookEditForm.BookPlateCopyButtonClick(Sender: TObject);
begin
   BooksTransferForm.CurrentOldBook.BookPlateStatus:=BooksTransferForm.CurrentIMSBook.BookPlateStatus;
end;

procedure TBookEditForm.FormActivate(Sender: TObject);
begin
        oldbookcode.Text:=BooksTransferForm.CurrentOldBook.bookcode;
        oldshortcode.Text:=BooksTransferForm.CurrentOldBook.shortcode;
        oldAuthor.Text:=BooksTransferForm.CurrentOldBook.Author;
        oldTitle.Text:=BooksTransferForm.CurrentOldBook.Title;
        oldVolume.Text:=BooksTransferForm.CurrentOldBook.Volume;
        oldEdition.Text:=BooksTransferForm.CurrentOldBook.Edition;
        oldPublisher.Text:=BooksTransferForm.CurrentOldBook.Publisher;
        oldPlace.Text:=BooksTransferForm.CurrentOldBook.Place;
        oldYearPub.Text:=BooksTransferForm.CurrentOldBook.YearPub;
        oldOPublisher.Text:=BooksTransferForm.CurrentOldBook.OPublisher;
        oldOPlace.Text:=BooksTransferForm.CurrentOldBook.OPlace;
        oldOYear.Text:=BooksTransferForm.CurrentOldBook.OYear;
        oldISBN.Text:=BooksTransferForm.CurrentOldBook.ISBN;
        oldSubject.Text:=BooksTransferForm.CurrentOldBook.Subject;
        oldDateAcq.Text:=BooksTransferForm.CurrentOldBook.DateAcquired;
        oldPrice.Text:=IntToStr(BooksTransferForm.CurrentOldBook.Price);
        oldRef.Text:=BooksTransferForm.CurrentOldBook.Ref;
        oldUsedBy.Text:=BooksTransferForm.CurrentOldBook.UsedByAsAnsiStr;
        oldBookPlateStatus.Text:=BooksTransferForm.CurrentOldBook.BookPlateStatus;
        oldnbpages.Text:=IntToStr(BooksTransferForm.CurrentOldBook.NumberOfPages);
        oldnotes.Text:=BooksTransferForm.CurrentOldBook.notes;
        IMSbookcode.Text:=BooksTransferForm.CurrentIMSBook.bookcode;
        IMSAuthor.Text:=BooksTransferForm.CurrentIMSBook.Author;
        IMSTitle.Text:=BooksTransferForm.CurrentIMSBook.Title;
        IMSVolume.Text:=BooksTransferForm.CurrentIMSBook.Volume;
        IMSEdition.Text:=BooksTransferForm.CurrentIMSBook.Edition;
        IMSPublisher.Text:=BooksTransferForm.CurrentIMSBook.Publisher;
        IMSPlace.Text:=BooksTransferForm.CurrentIMSBook.Place;
        IMSYearPub.Text:=BooksTransferForm.CurrentIMSBook.YearPub;
        IMSOPublisher.Text:=BooksTransferForm.CurrentIMSBook.OPublisher;
        IMSOPlace.Text:=BooksTransferForm.CurrentIMSBook.OPlace;
        IMSOYear.Text:=BooksTransferForm.CurrentIMSBook.OYear;
        IMSISBN.Text:=BooksTransferForm.CurrentIMSBook.ISBN;
        IMSSubject.Text:=BooksTransferForm.CurrentIMSBook.Subject;
        IMSDateAcq.Text:=BooksTransferForm.CurrentIMSBook.DateAcquired;
        IMSPrice.Text:=IntToStr(BooksTransferForm.CurrentIMSBook.Price);
        IMSRef.Text:=BooksTransferForm.CurrentIMSBook.Ref;
        IMSUsedBy.Text:=BooksTransferForm.CurrentIMSBook.UsedByAsAnsiStr;
        IMSBookPlateStatus.Text:=BooksTransferForm.CurrentIMSBook.BookPlateStatus;
        IMSnbpages.Text:=IntToStr(BooksTransferForm.CurrentIMSBook.NumberOfPages);
        IMSnotes.Text:=BooksTransferForm.CurrentIMSBook.notes;
end;

procedure TBookEditForm.IMSBookcodeChange(Sender: TObject);
begin
  if sender=IMSbookcode then BooksTransferForm.CurrentIMSBook.bookcode:=IMSbookcode.Text;
  if sender=IMSshortcode then BooksTransferForm.CurrentIMSBook.shortcode:=IMSshortcode.Text;
  if sender=IMSAuthor then BooksTransferForm.CurrentIMSBook.Author:=IMSAuthor.Text;
  if sender=IMSTitle then BooksTransferForm.CurrentIMSBook.Title:=IMSTitle.Text;
  if sender=IMSVolume then BooksTransferForm.CurrentIMSBook.Volume:=IMSVolume.Text;
  if sender=IMSEdition then BooksTransferForm.CurrentIMSBook.Edition:=IMSEdition.Text;
  if sender=IMSPublisher then BooksTransferForm.CurrentIMSBook.Publisher:=IMSPublisher.Text;
  if sender=IMSplace then BooksTransferForm.CurrentIMSBook.place:=IMSplace.Text;
  if sender=IMSYearPub then BooksTransferForm.CurrentIMSBook.YearPub:=IMSYearPub.Text;
  if sender=IMSOPublisher then BooksTransferForm.CurrentIMSBook.OPublisher:=IMSOPublisher.Text;
  if sender=IMSOPlace then BooksTransferForm.CurrentIMSBook.OPlace:=IMSOPlace.Text;
  if sender=IMSOYear then BooksTransferForm.CurrentIMSBook.OYear:=IMSOYear.Text;
  if sender=IMSISBN then BooksTransferForm.CurrentIMSBook.ISBN:=IMSISBN.Text;
  if sender=IMSSubject then BooksTransferForm.CurrentIMSBook.Subject:=IMSSubject.Text;
  if sender=IMSDateAcq then BooksTransferForm.CurrentIMSBook.DateAcquired:=IMSDateAcq.Text;
  if sender=IMSPrice then BooksTransferForm.CurrentIMSBook.Price:=StrToInt(IMSPrice.Text);
  if sender=IMSRef then BooksTransferForm.CurrentIMSBook.Ref:=IMSRef.Text;
  if sender=IMSUsedBy then BooksTransferForm.CurrentIMSBook.SetUses(IMSUsedBy.Text);
  if sender=IMSBookPlateStatus then BooksTransferForm.CurrentIMSBook.BookPlateStatus:=IMSBookPlateStatus.Text;
  if sender=IMSnbpages then BooksTransferForm.CurrentIMSBook.NumberOfPages:=StrToInt(IMSnbpages.Text);
  if sender=IMSnotes then BooksTransferForm.CurrentIMSBook.notes:=IMSnotes.Text;
end;

procedure TBookEditForm.oldBookChange(Sender: TObject);
begin
  if sender=oldbookcode then BooksTransferForm.CurrentOldBook.bookcode:=oldbookcode.Text;
  if sender=oldshortcode then BooksTransferForm.CurrentOldBook.shortcode:=oldshortcode.Text;
  if sender=oldAuthor then BooksTransferForm.CurrentOldBook.Author:=oldAuthor.Text;
  if sender=oldTitle then BooksTransferForm.CurrentOldBook.Title:=oldTitle.Text;
  if sender=oldVolume then BooksTransferForm.CurrentOldBook.Volume:=oldVolume.Text;
  if sender=oldEdition then BooksTransferForm.CurrentOldBook.Edition:=oldEdition.Text;
  if sender=oldPublisher then BooksTransferForm.CurrentOldBook.Publisher:=oldPublisher.Text;
  if sender=oldplace then BooksTransferForm.CurrentOldBook.place:=oldplace.Text;
  if sender=oldYearPub then BooksTransferForm.CurrentOldBook.YearPub:=oldYearPub.Text;
  if sender=oldOPublisher then BooksTransferForm.CurrentOldBook.OPublisher:=oldOPublisher.Text;
  if sender=oldOPlace then BooksTransferForm.CurrentOldBook.OPlace:=oldOPlace.Text;
  if sender=oldOYear then BooksTransferForm.CurrentOldBook.OYear:=oldOYear.Text;
  if sender=oldISBN then BooksTransferForm.CurrentOldBook.ISBN:=oldISBN.Text;
  if sender=oldSubject then BooksTransferForm.CurrentOldBook.Subject:=oldSubject.Text;
  if sender=oldDateAcq then BooksTransferForm.CurrentOldBook.DateAcquired:=oldDateAcq.Text;
  if sender=oldPrice then BooksTransferForm.CurrentOldBook.Price:=StrToInt(oldPrice.Text);
  if sender=oldRef then BooksTransferForm.CurrentOldBook.Ref:=oldRef.Text;
  if sender=oldUsedBy then BooksTransferForm.CurrentOldBook.SetUses(oldUsedBy.Text);
  if sender=oldBookPlateStatus then BooksTransferForm.CurrentOldBook.BookPlateStatus:=oldBookPlateStatus.Text;
  if sender=oldnbpages then BooksTransferForm.CurrentOldBook.NumberOfPages:=StrToInt(oldnbpages.Text);
  if sender=oldnotes then BooksTransferForm.CurrentOldBook.notes:=oldnotes.Text;
end;

end.
