object JPEditorForm: TJPEditorForm
  Left = 360
  Top = 328
  Caption = 'Japan Plants Database Editor'
  ClientHeight = 695
  ClientWidth = 1247
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 17
  object Prefname: TLabel
    Left = 779
    Top = 34
    Width = 433
    Height = 37
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object OrgcodeLabel: TLabel
    Left = 8
    Top = 8
    Width = 113
    Height = 37
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BookPanel: TPanel
    Left = 0
    Top = 481
    Width = 1247
    Height = 214
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    Alignment = taLeftJustify
    BevelEdges = []
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = 16759739
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    VerticalAlignment = taAlignTop
    DesignSize = (
      1243
      210)
    object Label2: TLabel
      Left = 631
      Top = 58
      Width = 42
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Author'
    end
    object Label3: TLabel
      Left = 20
      Top = 96
      Width = 24
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Title'
    end
    object Label4: TLabel
      Left = 21
      Top = 133
      Width = 57
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Nb pages'
    end
    object Label5: TLabel
      Left = 212
      Top = 133
      Width = 35
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Notes'
    end
    object Label7: TLabel
      Left = 13
      Top = 25
      Width = 155
      Height = 42
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taCenter
      Caption = 'Current book details: (read only)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object BookCount: TLabel
      Left = 534
      Top = 27
      Width = 4
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taRightJustify
    end
    object Label9: TLabel
      Left = 546
      Top = 27
      Width = 37
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'books'
    end
    object ShowTitle: TIB_Edit
      Left = 98
      Top = 89
      Width = 1101
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'TITLE'
      DataSource = BookDataSource
      ReadOnly = True
      TabOrder = 0
    end
    object ShowBookAuthor: TIB_Edit
      Left = 681
      Top = 56
      Width = 173
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'AUTHOR'
      DataSource = BookDataSource
      ReadOnly = True
      TabOrder = 1
    end
    object ShowBookCode: TIB_Edit
      Left = 187
      Top = 52
      Width = 416
      Height = 29
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'BOOKCODE'
      DataSource = BookDataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object ShowBookNotes: TIB_Memo
      Left = 255
      Top = 130
      Width = 946
      Height = 64
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'NOTES'
      DataSource = BookDataSource
      TabOrder = 3
      AutoSize = False
      ScrollBars = ssVertical
    end
    object ShowBookPages: TIB_Edit
      Left = 98
      Top = 130
      Width = 57
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'NUMBERPAGES'
      DataSource = BookDataSource
      TabOrder = 4
    end
    object BookList: TComboBox
      Left = 187
      Top = 19
      Width = 300
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Sorted = True
      TabOrder = 5
      Text = 'Select a book'
      OnChange = BookListChange
    end
    object ButtonPanel: TPanel
      Left = 624
      Top = 8
      Width = 616
      Height = 41
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'ButtonPanel'
      ShowCaption = False
      TabOrder = 6
      object NewBookButton: TButton
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 200
        Height = 32
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Add a book from master list'
        TabOrder = 0
        OnClick = NewBookButtonClick
      end
      object EditBookButton: TButton
        AlignWithMargins = True
        Left = 216
        Top = 6
        Width = 142
        Height = 32
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Edit in master list'
        TabOrder = 1
        OnClick = EditBookButtonClick
      end
      object DeleteBookButton: TButton
        AlignWithMargins = True
        Left = 370
        Top = 6
        Width = 242
        Height = 32
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Remove this book from Japanese list'
        TabOrder = 2
        OnClick = DeleteBookButtonClick
      end
    end
  end
  object RefPanel: TPanel
    Left = 403
    Top = 0
    Width = 844
    Height = 481
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'Plants referenced in current book'
    Color = 16764125
    Padding.Left = 20
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    VerticalAlignment = taAlignTop
    object DispCount: TLabel
      Left = 325
      Top = 368
      Width = 4
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taRightJustify
    end
    object RefListView: TListView
      AlignWithMargins = True
      Left = 24
      Top = 104
      Width = 680
      Height = 353
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 20
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Columns = <
        item
          Width = 59
        end
        item
          Width = 250
        end
        item
          Alignment = taRightJustify
          Width = 65
        end>
      Items.ItemData = {
        031C0000000100000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
        00016100}
      RowSelect = True
      ParentColor = True
      ShowColumnHeaders = False
      SortType = stText
      StateImages = iMSHomeForm.VerifyIcons
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = RefListViewClick
      OnCompare = RefListViewCompare
    end
    object Panel1: TPanel
      Left = 708
      Top = 100
      Width = 132
      Height = 377
      Margins.Left = 30
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      object NewRefButton: TButton
        Left = 23
        Top = 49
        Width = 94
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Add new ref'
        TabOrder = 0
        OnClick = NewRefButtonClick
      end
      object DeleteRefButton: TButton
        Left = 22
        Top = 93
        Width = 94
        Height = 25
        Caption = 'Delete ref'
        TabOrder = 1
        OnClick = DeleteRefButtonClick
      end
      object PagePanel: TPanel
        Left = 0
        Top = 117
        Width = 132
        Height = 260
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'FindCodePanel'
        ParentColor = True
        ShowCaption = False
        TabOrder = 2
        object Label8: TLabel
          Left = 23
          Top = 18
          Width = 101
          Height = 34
          Caption = 'Choose page (0 for whole book)'
          WordWrap = True
        end
        object UpButton: TButton
          Left = 17
          Top = 170
          Width = 106
          Height = 32
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Previous page'
          TabOrder = 0
          OnClick = UpButtonClick
        end
        object DownButton: TButton
          Left = 16
          Top = 210
          Width = 109
          Height = 33
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Next page'
          TabOrder = 1
          OnClick = DownButtonClick
        end
        object PageToFind: TSpinEdit
          Left = 27
          Top = 73
          Width = 87
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Increment = -1
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
        object PageButton: TButton
          Left = 22
          Top = 108
          Width = 97
          Height = 33
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Go to page'
          TabOrder = 3
          OnClick = PageButtonClick
        end
      end
      object EditRefButton: TButton
        Left = 21
        Top = 7
        Width = 94
        Height = 25
        Caption = 'Edit ref'
        TabOrder = 3
        OnClick = EditRefButtonClick
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 23
      Top = 0
      Width = 814
      Height = 100
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 2
      DesignSize = (
        814
        100)
      object ClickLabel: TLabel
        Left = 10
        Top = 51
        Width = 354
        Height = 17
        Caption = 'Click a name to select it and see the members of its family '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 6
        Width = 245
        Height = 21
        Margins.Left = 10
        Margins.Top = 6
        Caption = 'Plants referenced in current book'
      end
      object RefOrderButtons: TRadioGroup
        Left = 442
        Top = 10
        Width = 212
        Height = 43
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akTop, akRight]
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Code order'
          'Page order')
        TabOrder = 0
        OnClick = RefOrderButtonsClick
      end
      object CloseButton: TButton
        AlignWithMargins = True
        Left = 733
        Top = 10
        Width = 75
        Height = 50
        Margins.Left = 6
        Margins.Top = 10
        Margins.Right = 6
        Margins.Bottom = 40
        Align = alRight
        Caption = 'Close'
        TabOrder = 1
        OnClick = CloseButtonClick
      end
    end
  end
  object FamilyPanel: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 481
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = 12320767
    ParentBackground = False
    ShowCaption = False
    TabOrder = 3
    object FamilyMembers: TListView
      AlignWithMargins = True
      Left = 4
      Top = 121
      Width = 395
      Height = 340
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 20
      Align = alBottom
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 12320767
      Columns = <
        item
          AutoSize = True
        end
        item
          AutoSize = True
          MaxWidth = 250
          MinWidth = 200
        end
        item
          AutoSize = True
        end>
      Items.ItemData = {
        031C0000000100000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
        00016100}
      RowSelect = True
      ShowColumnHeaders = False
      SortType = stText
      StateImages = iMSHomeForm.VerifyIcons
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = FamilyMembersClick
      OnCompare = FamilyMembersCompare
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 403
      Height = 110
      Align = alTop
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      object TitleLabel: TLabel
        Left = 10
        Top = 6
        Width = 123
        Height = 21
        Margins.Left = 10
        Margins.Top = 10
        Caption = 'Species in family'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 291
        Top = 40
        Width = 42
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'families'
      end
      object FamilyCount: TLabel
        Left = 279
        Top = 40
        Width = 4
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
      end
      object FamilyListCB: TComboBox
        Left = 10
        Top = 37
        Width = 212
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 0
        OnChange = FamilyListCBChange
      end
      object FamOrderButtons: TRadioGroup
        Left = 0
        Top = 63
        Width = 222
        Height = 43
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Code '
          'Name'
          'Date ')
        TabOrder = 1
        OnClick = FamOrderButtonsClick
      end
      object EditOrgButton: TButton
        Left = 265
        Top = 74
        Width = 110
        Height = 25
        Caption = 'Edit organism'
        TabOrder = 2
        OnClick = EditOrgButtonClick
      end
    end
  end
  object EditRefPanel: TPanel
    Left = 796
    Top = 77
    Width = 264
    Height = 376
    Alignment = taLeftJustify
    BevelInner = bvSpace
    BevelKind = bkTile
    BorderStyle = bsSingle
    Caption = 'Edit current reference'
    Color = 16764125
    ParentBackground = False
    TabOrder = 0
    VerticalAlignment = taAlignTop
    Visible = False
    object Label1: TLabel
      Left = 28
      Top = 156
      Width = 50
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Page no'
    end
    object Notes: TLabel
      Left = 26
      Top = 194
      Width = 35
      Height = 17
      Caption = 'Notes'
    end
    object ShowCode: TLabel
      Left = 21
      Top = 100
      Width = 32
      Height = 17
      Caption = 'Code'
    end
    object ShowName: TLabel
      Left = 102
      Top = 100
      Width = 35
      Height = 17
      Caption = 'Name'
    end
    object SaveRefButton: TButton
      Left = 30
      Top = 317
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = SaveRefButtonClick
    end
    object CancelButton: TButton
      Left = 151
      Top = 317
      Width = 75
      Height = 25
      ParentCustomHint = False
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = CancelButtonClick
    end
    object EditPageNo: TEdit
      Left = 100
      Top = 153
      Width = 57
      Height = 25
      TabOrder = 2
      OnExit = EditPagenoExit
    end
    object RefNotes: TMemo
      Left = 23
      Top = 213
      Width = 201
      Height = 80
      Lines.Strings = (
        '')
      TabOrder = 3
      OnExit = RefNotesExit
    end
    object FindNameButton: TButton
      Left = 138
      Top = 43
      Width = 110
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Find by name'
      TabOrder = 4
      OnClick = FindNameButtonClick
    end
    object FindCodeButton: TButton
      Left = 20
      Top = 43
      Width = 110
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Find by code'
      TabOrder = 5
      OnClick = FindCodeButtonClick
    end
  end
  object BookDataSource: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Left = 1036
    Top = 438
  end
end
