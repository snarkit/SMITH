object AdminForm: TAdminForm
  Left = 0
  Top = 0
  Caption = 'Administrative tasks'
  ClientHeight = 459
  ClientWidth = 757
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
  object ResultLabel: TLabel
    Left = 311
    Top = 341
    Width = 173
    Height = 24
    Caption = 'Results shown here'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object OpsPageControl: TPageControl
    Left = 0
    Top = 0
    Width = 757
    Height = 459
    ActivePage = ExportTab
    Align = alClient
    TabOrder = 0
    object MergeTab: TTabSheet
      Caption = 'Merge tables'
      ImageIndex = 5
      object MergeNamesPanel: TPanel
        Left = 263
        Top = 0
        Width = 243
        Height = 428
        Align = alRight
        Caption = 'Merge name tables'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        object Label5: TLabel
          Left = 14
          Top = 56
          Width = 188
          Height = 16
          Caption = 'Table to receive new lines (dest)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 22
          Top = 134
          Width = 182
          Height = 16
          Caption = 'Table to get lines from (source)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object MergeNamesButton: TButton
          Left = 84
          Top = 212
          Width = 75
          Height = 25
          Caption = 'Merge'
          TabOrder = 0
          OnClick = MergeNamesButtonClick
        end
        object SourceNamesName: TEdit
          Left = 84
          Top = 156
          Width = 134
          Height = 24
          TabOrder = 1
          Text = 'NAMES'
        end
        object DestNamesName: TEdit
          Left = 84
          Top = 78
          Width = 134
          Height = 24
          TabOrder = 2
          Text = 'NAMES'
        end
      end
      object MergeOrgsPanel: TPanel
        Left = 0
        Top = 0
        Width = 243
        Height = 428
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
        object Label1: TLabel
          Left = 14
          Top = 56
          Width = 188
          Height = 16
          Caption = 'Table to receive new lines (dest)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 22
          Top = 134
          Width = 182
          Height = 16
          Caption = 'Table to get lines from (source)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object MergeOrgsButton: TButton
          Left = 84
          Top = 212
          Width = 75
          Height = 25
          Caption = 'Merge'
          TabOrder = 0
          OnClick = MergeNamesButtonClick
        end
        object SourceOrgName: TEdit
          Left = 84
          Top = 156
          Width = 134
          Height = 24
          TabOrder = 1
          Text = 'ORGS2'
        end
        object DestOrgName: TEdit
          Left = 84
          Top = 78
          Width = 134
          Height = 24
          TabOrder = 2
          Text = 'ORGS'
        end
      end
      object MergeRefsPanel: TPanel
        Left = 506
        Top = 0
        Width = 243
        Height = 428
        Align = alRight
        Caption = 'Merge ref tables'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        VerticalAlignment = taAlignTop
        object Label7: TLabel
          Left = 14
          Top = 56
          Width = 188
          Height = 16
          Caption = 'Table to receive new lines (dest)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 22
          Top = 134
          Width = 182
          Height = 16
          Caption = 'Table to get lines from (source)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object MergeRefsButton: TButton
          Left = 84
          Top = 212
          Width = 75
          Height = 25
          Caption = 'Merge'
          TabOrder = 0
          OnClick = MergeRefsButtonClick
        end
        object SourceRefsName: TEdit
          Left = 84
          Top = 156
          Width = 134
          Height = 24
          TabOrder = 1
          Text = 'BOOKREFS'
        end
        object DestRefsName: TEdit
          Left = 84
          Top = 78
          Width = 134
          Height = 24
          TabOrder = 2
          Text = 'BOOKREFS'
        end
      end
    end
    object OrgEditTab: TTabSheet
      Caption = 'Edit org'
      ImageIndex = 6
      object PrefNamePanel: TPanel
        Left = 0
        Top = 0
        Width = 249
        Height = 428
        Align = alLeft
        Caption = 'Insert missing preferred names'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        object Label2: TLabel
          Left = 14
          Top = 56
          Width = 204
          Height = 16
          Caption = 'Organism table with missing names'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 43
          Top = 136
          Width = 175
          Height = 16
          Caption = 'Name table to get names from'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object OrgFileName: TEdit
          Left = 84
          Top = 78
          Width = 134
          Height = 24
          TabOrder = 0
          Text = 'ORGS'
        end
        object NameFileName: TEdit
          Left = 84
          Top = 156
          Width = 134
          Height = 24
          TabOrder = 1
          Text = 'NAMES'
        end
        object PrefNameButton: TButton
          Left = 84
          Top = 212
          Width = 75
          Height = 25
          Caption = 'Go'
          TabOrder = 2
          OnClick = PrefNameButtonClick
        end
      end
      object JPUsesPanel: TPanel
        Left = 514
        Top = 0
        Width = 235
        Height = 428
        Align = alRight
        Caption = 'Insert JP into uses for orgs in JPORGS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
        object Label12: TLabel
          Left = 0
          Top = 38
          Width = 217
          Height = 16
          Caption = 'Table containing organisms to change'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object JPUseButton: TButton
          Left = 83
          Top = 130
          Width = 75
          Height = 25
          Caption = 'Insert uses'
          TabOrder = 0
          OnClick = JPUseButtonClick
        end
        object JPUsesFileName: TEdit
          Left = 55
          Top = 70
          Width = 134
          Height = 24
          TabOrder = 1
          Text = 'EUORGANISMS'
        end
      end
    end
    object NameEditTab: TTabSheet
      Caption = 'Edit names'
      ImageIndex = 4
      object SplitJPNamesPanel: TPanel
        Left = 0
        Top = 0
        Width = 235
        Height = 428
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        object Label13: TLabel
          Left = 19
          Top = 83
          Width = 178
          Height = 16
          Caption = 'Table containing names to split'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 41
          Top = 38
          Width = 124
          Height = 16
          Caption = 'Split Japanese names'
        end
        object SplitButton: TButton
          Left = 68
          Top = 180
          Width = 75
          Height = 25
          Caption = 'Split'
          TabOrder = 0
          OnClick = SplitButtonClick
        end
        object TargetNamesName: TEdit
          Left = 41
          Top = 125
          Width = 134
          Height = 24
          TabOrder = 1
          Text = 'NAMES'
        end
      end
      object NameEditPanel: TPanel
        Left = 460
        Top = 0
        Width = 289
        Height = 428
        Align = alRight
        Caption = 'Replace text in names'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
        object Label9: TLabel
          Left = 14
          Top = 56
          Width = 211
          Height = 16
          Caption = 'Table containing names to transform'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object First: TLabel
          Left = 14
          Top = 112
          Width = 106
          Height = 16
          Caption = 'Beginning of string'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 17
          Top = 159
          Width = 95
          Height = 16
          Caption = 'String to replace'
        end
        object Label11: TLabel
          Left = 25
          Top = 210
          Width = 99
          Height = 16
          Caption = 'Replacement text'
        end
        object ReplaceButton: TButton
          Left = 96
          Top = 265
          Width = 75
          Height = 25
          Caption = 'Replace'
          TabOrder = 0
        end
        object FirstString: TEdit
          Left = 139
          Top = 108
          Width = 72
          Height = 24
          TabOrder = 1
        end
        object TransformNameTable: TEdit
          Left = 84
          Top = 78
          Width = 134
          Height = 24
          TabOrder = 2
          Text = 'NAMES'
        end
        object Edit1: TEdit
          Left = 149
          Top = 158
          Width = 94
          Height = 24
          TabOrder = 3
          Text = 'Edit1'
        end
        object ReplacementText: TEdit
          Left = 147
          Top = 207
          Width = 86
          Height = 24
          TabOrder = 4
          Text = 'ReplacementText'
        end
      end
    end
    object BooksTab: TTabSheet
      Caption = 'Books/Refs'
      ImageIndex = 2
      object RecoverBooksPanel: TPanel
        Left = 0
        Top = 0
        Width = 367
        Height = 310
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        object Label17: TLabel
          Left = 66
          Top = 10
          Width = 176
          Height = 16
          Caption = 'Recover books with bookplates'
        end
        object Panel1: TPanel
          Left = 22
          Top = 46
          Width = 329
          Height = 54
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 0
          object Label14: TLabel
            Left = 16
            Top = 0
            Width = 171
            Height = 16
            Caption = 'DB to receive new lines (dest)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 11
            Top = 27
            Width = 36
            Height = 16
            Caption = 'server'
          end
          object Label20: TLabel
            Left = 172
            Top = 22
            Width = 25
            Height = 16
            Caption = 'path'
          end
          object DestServerName: TEdit
            Left = 63
            Top = 22
            Width = 84
            Height = 24
            TabOrder = 0
            Text = 'LocalHost'
          end
          object DestDBName: TEdit
            Left = 210
            Top = 22
            Width = 99
            Height = 24
            TabOrder = 1
            Text = 'LocalIMSDB'
          end
        end
        object Panel2: TPanel
          Left = 22
          Top = 119
          Width = 329
          Height = 54
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 1
          object Label15: TLabel
            Left = 22
            Top = 0
            Width = 165
            Height = 16
            Caption = 'DB to get lines from (source)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 172
            Top = 25
            Width = 25
            Height = 16
            Caption = 'path'
          end
          object Label22: TLabel
            Left = 11
            Top = 25
            Width = 36
            Height = 16
            Caption = 'server'
          end
          object SourceServerName: TEdit
            Left = 63
            Top = 22
            Width = 84
            Height = 24
            TabOrder = 0
            Text = 'LocalHost'
          end
          object SourceDBName: TEdit
            Left = 210
            Top = 22
            Width = 99
            Height = 24
            TabOrder = 1
            Text = 'PREVIMS'
          end
        end
        object Panel3: TPanel
          Left = 22
          Top = 192
          Width = 329
          Height = 76
          Caption = 'Panel3'
          ShowCaption = False
          TabOrder = 2
          object Label16: TLabel
            Left = 22
            Top = 0
            Width = 198
            Height = 16
            Caption = 'Range of refs to tansfer (inclusive)'
          end
          object LowerLimit: TEdit
            Left = 28
            Top = 38
            Width = 60
            Height = 24
            TabOrder = 0
            Text = 'LowerLimit'
          end
          object UpperLimit: TEdit
            Left = 109
            Top = 38
            Width = 68
            Height = 24
            TabOrder = 1
            Text = 'UpperLimit'
          end
          object RecoverButton: TButton
            Left = 210
            Top = 38
            Width = 75
            Height = 25
            Caption = 'Transfer'
            TabOrder = 2
            OnClick = RecoverButtonClick
          end
        end
      end
      object ResultsMemo: TMemo
        Left = 367
        Top = 0
        Width = 382
        Height = 310
        Align = alClient
        Lines.Strings = (
          'ResultsMemo')
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object Panel4: TPanel
        Left = 0
        Top = 310
        Width = 749
        Height = 118
        Align = alBottom
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 2
        object DestBookRef: TIB_Text
          Left = 69
          Top = 22
          Width = 71
          Height = 16
          AutoSize = True
          DataField = 'REF'
          DataSource = DestDS
        end
        object DestBookTitle: TIB_Text
          Left = 146
          Top = 22
          Width = 77
          Height = 16
          AutoSize = True
          DataField = 'Title'
          DataSource = DestDS
        end
        object SourceBookRef: TIB_Text
          Left = 69
          Top = 52
          Width = 86
          Height = 16
          AutoSize = True
          DataField = 'REF'
          DataSource = SourceDS
        end
        object SourceBookTitle: TIB_Text
          Left = 161
          Top = 52
          Width = 92
          Height = 16
          AutoSize = True
          DataField = 'TITLE'
          DataSource = SourceDS
        end
        object DestNB: TIB_NavigationBar
          Left = 11
          Top = 17
          Width = 52
          Height = 25
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          DataSource = DestDS
          ReceiveFocus = False
          CustomGlyphsSupplied = []
          VisibleButtons = [nbPrior, nbNext]
        end
        object SourceNB: TIB_NavigationBar
          Left = 11
          Top = 48
          Width = 52
          Height = 25
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
          DataSource = SourceDS
          ReceiveFocus = False
          CustomGlyphsSupplied = []
          VisibleButtons = [nbPrior, nbNext]
        end
        object BookCompareButton: TButton
          Left = 33
          Top = 89
          Width = 75
          Height = 25
          Caption = 'Compare'
          TabOrder = 2
          OnClick = BookCompareButtonClick
        end
        object ContinueButton: TButton
          Left = 194
          Top = 89
          Width = 75
          Height = 25
          Caption = 'Continue'
          TabOrder = 3
          OnClick = ContinueButtonClick
        end
        object RestartButton: TButton
          Left = 367
          Top = 89
          Width = 75
          Height = 25
          Caption = 'Reset'
          TabOrder = 4
          OnClick = RestartButtonClick
        end
      end
    end
    object ExportTab: TTabSheet
      Caption = 'Export to EPPT'
      ImageIndex = 4
      object ExportButton: TButton
        Left = 34
        Top = 64
        Width = 75
        Height = 25
        Caption = 'Export'
        TabOrder = 0
        OnClick = ExportButtonClick
      end
      object CheckList: TListBox
        Left = 70
        Top = 171
        Width = 129
        Height = 222
        TabOrder = 1
      end
      object FirstDate: TEdit
        Left = 140
        Top = 20
        Width = 121
        Height = 24
        TabOrder = 2
        Text = 'FirstDate'
      end
      object SelectButton: TButton
        Left = 34
        Top = 20
        Width = 75
        Height = 25
        Caption = 'Select since'
        TabOrder = 3
        OnClick = SelectButtonClick
      end
    end
  end
  object BasicQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'N.PREFERRED=104')
    IB_Connection = IMSDM.FBConnection
    SQL.Strings = (
      'select * from JPOrgs o'
      'join JPNames n'
      'on o.orgcode = n.orgcode'
      'where (n.preferred<>0)'
      'and (o.preferredname is null) ')
    EditSQL.Strings = (
      'UPDATE JPORGS O SET'
      '   O.ORGCODE = :ORGCODE,'
      '   O.FAMILY = :FAMILY,'
      '   O.POLNO = :POLNO,'
      '   O.DATEMODIFIED = :DATEMODIFIED,'
      '   O.CARD = :CARD,'
      '   O.COMMENTS = :COMMENTS,'
      '   O.USEDBY = :USEDBY,'
      '   O.PREFERREDNAME = :PREFERREDNAME'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    KeyLinksAutoDefine = False
    RequestLive = True
    Left = 387
    Top = 31
  end
  object SecondQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'N.PREFERRED=104')
    IB_Connection = IMSDM.FBConnection
    SQL.Strings = (
      'select * from JPOrgs o'
      'join JPNames n'
      'on o.orgcode = n.orgcode'
      'where (n.preferred<>0)'
      'and (o.preferredname is null) ')
    EditSQL.Strings = (
      'UPDATE JPORGS O SET'
      '   O.ORGCODE = :ORGCODE,'
      '   O.FAMILY = :FAMILY,'
      '   O.POLNO = :POLNO,'
      '   O.DATEMODIFIED = :DATEMODIFIED,'
      '   O.CARD = :CARD,'
      '   O.COMMENTS = :COMMENTS,'
      '   O.USEDBY = :USEDBY,'
      '   O.PREFERREDNAME = :PREFERREDNAME'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    RequestLive = True
    Left = 302
    Top = 33
  end
  object SourceConnection: TIB_Connection
    CacheStatementHandles = False
    LoginPrompt = True
    SQLDialect = 3
    Params.Strings = (
      'CHARACTER SET=UTF8'
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'PROTOCOL=TCP/IP')
    Left = 468
    Top = 34
  end
  object DestConnection: TIB_Connection
    CacheStatementHandles = False
    LoginPrompt = True
    SQLDialect = 3
    Params.Strings = (
      'CHARACTER SET=UTF8'
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'PROTOCOL=TCP/IP')
    Left = 574
    Top = 34
  end
  object SourceBooksQuery: TIB_Query
    DatabaseName = ':'
    FieldsDisplayWidth.Strings = (
      'N.PREFERRED=104')
    IB_Connection = SourceConnection
    SQL.Strings = (
      'select * from books'
      'order by ref')
    KeyLinksAutoDefine = False
    RequestLive = True
    Left = 470
    Top = 87
  end
  object DestBooksQuery: TIB_Query
    DatabaseName = ':'
    FieldsDisplayWidth.Strings = (
      'N.PREFERRED=104')
    IB_Connection = DestConnection
    SQL.Strings = (
      'select * from books'
      'order by ref'
      '')
    EditSQL.Strings = (
      'UPDATE JPORGS O SET'
      '   O.ORGCODE = :ORGCODE,'
      '   O.FAMILY = :FAMILY,'
      '   O.POLNO = :POLNO,'
      '   O.DATEMODIFIED = :DATEMODIFIED,'
      '   O.CARD = :CARD,'
      '   O.COMMENTS = :COMMENTS,'
      '   O.USEDBY = :USEDBY,'
      '   O.PREFERREDNAME = :PREFERREDNAME'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    RequestLive = True
    Left = 572
    Top = 87
  end
  object DestDS: TIB_DataSource
    Dataset = DestBooksQuery
    Left = 649
    Top = 89
  end
  object SourceDS: TIB_DataSource
    Dataset = SourceBooksQuery
    Left = 521
    Top = 89
  end
end
