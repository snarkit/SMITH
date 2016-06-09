object BooksTransferForm: TBooksTransferForm
  Left = 0
  Top = 0
  Caption = 'Append bookplate books to IMS'
  ClientHeight = 642
  ClientWidth = 789
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    789
    642)
  PixelsPerInch = 120
  TextHeight = 17
  object Label1: TLabel
    Left = 705
    Top = 112
    Width = 51
    Height = 34
    Anchors = [akTop, akRight]
    Caption = 'Existing IMSDB'
    WordWrap = True
    ExplicitLeft = 696
  end
  object Label2: TLabel
    Left = 705
    Top = 368
    Width = 40
    Height = 34
    Anchors = [akTop, akRight]
    Caption = 'Ian'#39's IMSDB'
    WordWrap = True
    ExplicitLeft = 696
  end
  object GoButton: TButton
    Left = 28
    Top = 20
    Width = 125
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Compare versions'
    TabOrder = 0
    OnClick = GoButtonClick
  end
  object IB_Grid1: TIB_Grid
    Left = 28
    Top = 79
    Width = 660
    Height = 236
    CustomGlyphsSupplied = []
    DataSource = IMSDM.AllBooksDS
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 1
    ExplicitWidth = 662
  end
  object IB_NavigationBar1: TIB_NavigationBar
    Left = 183
    Top = 23
    Width = 120
    Height = 25
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    DataSource = IMSDM.AllBooksDS
    ReceiveFocus = False
    CustomGlyphsSupplied = []
  end
  object UnProcessedCB: TCheckBox
    Left = 369
    Top = 28
    Width = 193
    Height = 17
    Caption = 'Ignore already processed'
    TabOrder = 3
  end
  object IB_Grid2: TIB_Grid
    Left = 27
    Top = 346
    Width = 662
    Height = 236
    CustomGlyphsSupplied = []
    DataSource = BooksDM.NewBooksDS
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 4
    ExplicitWidth = 663
  end
  object IB_NavigationBar2: TIB_NavigationBar
    Left = 183
    Top = 599
    Width = 120
    Height = 25
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
    DataSource = BooksDM.NewBooksDS
    ReceiveFocus = False
    CustomGlyphsSupplied = []
  end
  object ProblemList: TListBox
    Left = 183
    Top = 112
    Width = 326
    Height = 357
    ItemHeight = 17
    TabOrder = 6
    Visible = False
  end
end
