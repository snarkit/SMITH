object BookEditForm: TBookEditForm
  Left = 0
  Top = 0
  Caption = 'Compare book versions'
  ClientHeight = 900
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 16
  object Label2: TLabel
    Left = 673
    Top = 67
    Width = 128
    Height = 16
    Caption = 'Fields with differences'
  end
  object Label21: TLabel
    Left = 699
    Top = 217
    Width = 51
    Height = 16
    Caption = 'Records:'
  end
  object recct: TLabel
    Left = 749
    Top = 217
    Width = 28
    Height = 16
    Caption = 'recct'
  end
  object CopyButton: TButton
    Left = 680
    Top = 388
    Width = 164
    Height = 25
    Caption = 'Copy in Ian'#39's version'
    ModalResult = 1
    TabOrder = 0
  end
  object UpdateButton: TButton
    Left = 684
    Top = 348
    Width = 147
    Height = 25
    Caption = 'Save edited old version'
    ModalResult = 2
    TabOrder = 1
  end
  object IgnoreButton: TButton
    Left = 719
    Top = 433
    Width = 71
    Height = 25
    Caption = 'Skip'
    ModalResult = 5
    TabOrder = 2
  end
  object ExistPanel: TPanel
    Left = 109
    Top = 0
    Width = 267
    Height = 892
    Caption = 'Existing IMSDB'
    TabOrder = 3
    VerticalAlignment = taAlignTop
    object oldBookcode: TEdit
      Left = 17
      Top = 30
      Width = 217
      Height = 24
      TabOrder = 0
      OnChange = oldBookChange
    end
    object oldshortcode: TEdit
      Left = 40
      Top = 69
      Width = 121
      Height = 24
      TabOrder = 1
      OnChange = oldBookChange
    end
    object oldAuthor: TEdit
      Left = 17
      Top = 109
      Width = 217
      Height = 24
      TabOrder = 2
      OnChange = oldBookChange
    end
    object oldTitle: TEdit
      Left = 17
      Top = 149
      Width = 217
      Height = 24
      TabOrder = 3
      OnChange = oldBookChange
    end
    object oldVolume: TEdit
      Left = 40
      Top = 189
      Width = 121
      Height = 24
      TabOrder = 4
      OnChange = oldBookChange
    end
    object oldEdition: TEdit
      Left = 40
      Top = 228
      Width = 121
      Height = 24
      TabOrder = 5
      OnChange = oldBookChange
    end
    object oldPublisher: TEdit
      Left = 40
      Top = 268
      Width = 121
      Height = 24
      TabOrder = 6
      OnChange = oldBookChange
    end
    object oldPlace: TEdit
      Left = 40
      Top = 308
      Width = 121
      Height = 24
      TabOrder = 7
      OnChange = oldBookChange
    end
    object oldYearpub: TEdit
      Left = 40
      Top = 348
      Width = 121
      Height = 24
      TabOrder = 8
      OnChange = oldBookChange
    end
    object oldOPlace: TEdit
      Left = 40
      Top = 427
      Width = 121
      Height = 24
      TabOrder = 9
      OnChange = oldBookChange
    end
    object oldPrice: TEdit
      Left = 40
      Top = 626
      Width = 121
      Height = 24
      TabOrder = 10
      OnChange = oldBookChange
    end
    object oldRef: TEdit
      Left = 40
      Top = 666
      Width = 121
      Height = 24
      TabOrder = 11
      OnChange = oldBookChange
    end
    object oldOYear: TEdit
      Left = 40
      Top = 467
      Width = 121
      Height = 24
      TabOrder = 12
      OnChange = oldBookChange
    end
    object oldISBN: TEdit
      Left = 40
      Top = 507
      Width = 121
      Height = 24
      TabOrder = 13
      OnChange = oldBookChange
    end
    object oldSubject: TEdit
      Left = 40
      Top = 547
      Width = 121
      Height = 24
      TabOrder = 14
      OnChange = oldBookChange
    end
    object oldDateAcq: TEdit
      Left = 40
      Top = 587
      Width = 121
      Height = 24
      TabOrder = 15
      OnChange = oldBookChange
    end
    object oldNbPages: TEdit
      Left = 40
      Top = 746
      Width = 121
      Height = 24
      TabOrder = 16
      OnChange = oldBookChange
    end
    object oldUsedBy: TEdit
      Left = 40
      Top = 706
      Width = 121
      Height = 24
      TabOrder = 17
      OnChange = oldBookChange
    end
    object oldNotes: TMemo
      Left = 40
      Top = 812
      Width = 171
      Height = 70
      Lines.Strings = (
        '')
      TabOrder = 18
      OnChange = oldBookChange
    end
    object OldBookPlateStatus: TEdit
      Left = 40
      Top = 782
      Width = 121
      Height = 24
      TabOrder = 19
      OnChange = oldBookChange
    end
    object oldOPublisher: TEdit
      Left = 40
      Top = 388
      Width = 121
      Height = 24
      TabOrder = 20
      OnChange = oldBookChange
    end
  end
  object Panel2: TPanel
    Left = 369
    Top = 0
    Width = 288
    Height = 892
    Caption = 'Ian'#39's version'
    TabOrder = 4
    VerticalAlignment = taAlignTop
    object IMSBookcode: TEdit
      Left = 29
      Top = 30
      Width = 230
      Height = 24
      TabOrder = 0
      OnChange = IMSBookcodeChange
    end
    object IMSshortcode: TEdit
      Left = 59
      Top = 69
      Width = 121
      Height = 24
      TabOrder = 1
      OnChange = IMSBookcodeChange
    end
    object IMSAuthor: TEdit
      Left = 32
      Top = 109
      Width = 227
      Height = 24
      TabOrder = 2
      OnChange = IMSBookcodeChange
    end
    object IMSTitle: TEdit
      Left = 29
      Top = 149
      Width = 230
      Height = 24
      TabOrder = 3
      OnChange = IMSBookcodeChange
    end
    object IMSVolume: TEdit
      Left = 59
      Top = 189
      Width = 121
      Height = 24
      TabOrder = 4
      OnChange = IMSBookcodeChange
    end
    object IMSEdition: TEdit
      Left = 59
      Top = 228
      Width = 121
      Height = 24
      TabOrder = 5
      OnChange = IMSBookcodeChange
    end
    object IMSPublisher: TEdit
      Left = 59
      Top = 268
      Width = 121
      Height = 24
      TabOrder = 6
      OnChange = IMSBookcodeChange
    end
    object IMSPlace: TEdit
      Left = 59
      Top = 308
      Width = 121
      Height = 24
      TabOrder = 7
      OnChange = IMSBookcodeChange
    end
    object IMSYearpub: TEdit
      Left = 59
      Top = 348
      Width = 121
      Height = 24
      TabOrder = 8
      OnChange = IMSBookcodeChange
    end
    object IMSOPublisher: TEdit
      Left = 60
      Top = 388
      Width = 121
      Height = 24
      TabOrder = 9
      OnChange = IMSBookcodeChange
    end
    object IMSOPlace: TEdit
      Left = 57
      Top = 427
      Width = 121
      Height = 24
      TabOrder = 10
      OnChange = IMSBookcodeChange
    end
    object IMSPrice: TEdit
      Left = 59
      Top = 626
      Width = 121
      Height = 24
      TabOrder = 11
      OnChange = IMSBookcodeChange
    end
    object IMSRef: TEdit
      Left = 59
      Top = 666
      Width = 121
      Height = 24
      TabOrder = 12
      OnChange = IMSBookcodeChange
    end
    object IMSOYear: TEdit
      Left = 59
      Top = 467
      Width = 121
      Height = 24
      TabOrder = 13
      OnChange = IMSBookcodeChange
    end
    object IMSISBN: TEdit
      Left = 59
      Top = 507
      Width = 121
      Height = 24
      TabOrder = 14
      OnChange = IMSBookcodeChange
    end
    object IMSSubject: TEdit
      Left = 59
      Top = 547
      Width = 121
      Height = 24
      TabOrder = 15
      OnChange = IMSBookcodeChange
    end
    object IMSDateAcq: TEdit
      Left = 59
      Top = 587
      Width = 121
      Height = 24
      TabOrder = 16
      OnChange = IMSBookcodeChange
    end
    object IMSNbPages: TEdit
      Left = 59
      Top = 746
      Width = 121
      Height = 24
      TabOrder = 17
      OnChange = IMSBookcodeChange
    end
    object IMSUsedBy: TEdit
      Left = 58
      Top = 706
      Width = 121
      Height = 24
      TabOrder = 18
      OnChange = IMSBookcodeChange
    end
    object IMSNotes: TMemo
      Left = 13
      Top = 812
      Width = 257
      Height = 58
      Lines.Strings = (
        '')
      TabOrder = 19
      OnChange = IMSBookcodeChange
    end
    object IMSBookPLateStatus: TEdit
      Left = 60
      Top = 782
      Width = 121
      Height = 24
      TabOrder = 20
    end
  end
  object DifferenceList: TListBox
    Left = 680
    Top = 89
    Width = 121
    Height = 97
    TabOrder = 5
  end
  object AbortButton: TButton
    Left = 688
    Top = 507
    Width = 143
    Height = 25
    Caption = 'Abort'
    TabOrder = 6
    OnClick = AbortButtonClick
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 109
    Height = 892
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 7
    object bookcodelabel: TLabel
      Left = 16
      Top = 33
      Width = 54
      Height = 16
      Caption = 'bookcode'
    end
    object shortcodelabel: TLabel
      Left = 15
      Top = 72
      Width = 56
      Height = 16
      Caption = 'shortcode'
    end
    object Label5: TLabel
      Left = 25
      Top = 112
      Width = 37
      Height = 16
      Caption = 'author'
    end
    object Label6: TLabel
      Left = 33
      Top = 152
      Width = 21
      Height = 16
      Caption = 'title'
    end
    object Label7: TLabel
      Left = 23
      Top = 192
      Width = 41
      Height = 16
      Caption = 'volume'
    end
    object Label8: TLabel
      Left = 24
      Top = 231
      Width = 38
      Height = 16
      Caption = 'edition'
    end
    object Label9: TLabel
      Left = 17
      Top = 271
      Width = 52
      Height = 16
      Caption = 'publisher'
    end
    object Label10: TLabel
      Left = 28
      Top = 311
      Width = 30
      Height = 16
      Caption = 'place'
    end
    object Label11: TLabel
      Left = 20
      Top = 351
      Width = 46
      Height = 16
      Caption = 'yearpub'
    end
    object Label12: TLabel
      Left = 4
      Top = 391
      Width = 78
      Height = 16
      Caption = 'orig publisher'
    end
    object Label13: TLabel
      Left = 15
      Top = 430
      Width = 56
      Height = 16
      Caption = 'orig place'
    end
    object Label3: TLabel
      Left = 18
      Top = 470
      Width = 51
      Height = 16
      Caption = 'orig year'
    end
    object Label4: TLabel
      Left = 30
      Top = 510
      Width = 27
      Height = 16
      Caption = 'ISBN'
    end
    object Label16: TLabel
      Left = 23
      Top = 550
      Width = 41
      Height = 16
      Caption = 'subject'
    end
    object Label17: TLabel
      Left = 19
      Top = 590
      Width = 49
      Height = 16
      Caption = 'date acq'
    end
    object Label18: TLabel
      Left = 29
      Top = 629
      Width = 28
      Height = 16
      Caption = 'price'
    end
    object Label19: TLabel
      Left = 35
      Top = 669
      Width = 16
      Height = 16
      Caption = 'ref'
    end
    object Label20: TLabel
      Left = 21
      Top = 709
      Width = 44
      Height = 16
      Caption = 'used by'
    end
    object Label14: TLabel
      Left = 9
      Top = 749
      Width = 68
      Height = 16
      Caption = 'Nb of pages'
    end
    object Label1: TLabel
      Left = 4
      Top = 783
      Width = 91
      Height = 16
      Caption = 'BookPlateStatus'
    end
    object Label15: TLabel
      Left = 27
      Top = 816
      Width = 31
      Height = 16
      Caption = 'notes'
    end
  end
end
