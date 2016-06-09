object EUMainForm: TEUMainForm
  Left = 0
  Top = 0
  Caption = 'European Plant Database - Data Validation and Importation'
  ClientHeight = 930
  ClientWidth = 1181
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
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 17
  object Label1: TLabel
    Left = 39
    Top = 25
    Width = 97
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Input data from'
  end
  object ProcessButton: TButton
    Left = 667
    Top = 86
    Width = 127
    Height = 43
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Start processing'
    TabOrder = 0
    OnClick = ProcessButtonClick
  end
  object DisplayInputButton: TButton
    Left = 208
    Top = 86
    Width = 172
    Height = 43
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Display/hide input file'
    Enabled = False
    TabOrder = 1
    OnClick = DisplayInputButtonClick
  end
  object ChangeFileButton: TButton
    Left = 425
    Top = 10
    Width = 188
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Click to select input  file'
    TabOrder = 2
    OnClick = ChangeFileButtonClick
  end
  object Edit1: TEdit
    Left = 39
    Top = 51
    Width = 574
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 3
  end
  object DisplayOutputButton: TButton
    Left = 425
    Top = 86
    Width = 179
    Height = 43
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Display test database'
    TabOrder = 4
    OnClick = DisplayOutputButtonClick
  end
  object DataListBox: TListBox
    Left = 10
    Top = 196
    Width = 522
    Height = 684
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ItemHeight = 17
    ScrollWidth = 600
    TabOrder = 5
  end
  object ErrorListBox: TListBox
    Left = 540
    Top = 196
    Width = 522
    Height = 684
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ItemHeight = 17
    ScrollWidth = 600
    TabOrder = 6
  end
  object ShowErrorButton: TButton
    Left = 801
    Top = 145
    Width = 98
    Height = 43
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Show log'
    Enabled = False
    TabOrder = 7
    OnClick = ShowErrorButtonClick
  end
  object UserModes: TRadioGroup
    Left = 917
    Top = 20
    Width = 236
    Height = 137
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Run mode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 2
    Items.Strings = (
      'Data validation (errors only)'
      'Live run (output to database)'
      'Test - trace output to log'
      'Test - output to test database')
    ParentFont = False
    TabOrder = 8
  end
  object TableButtons: TRadioGroup
    Left = 282
    Top = 137
    Width = 463
    Height = 51
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Tables'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Organisms'
      'OrgNames'
      'BookRefs'
      'Books')
    TabOrder = 9
    Visible = False
    OnClick = TableButtonsClick
  end
  object CloseDisplayButton: TButton
    Left = 491
    Top = 888
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Close'
    TabOrder = 10
    Visible = False
    OnClick = CloseDisplayButtonClick
  end
  object FindCodeButton: TButton
    Left = 10
    Top = 97
    Width = 135
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Find data in input'
    TabOrder = 11
    Visible = False
    OnClick = FindCodeButtonClick
  end
  object ZapButton: TButton
    Left = 112
    Top = 888
    Width = 245
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Empty database (except books)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    Visible = False
    OnClick = ZapButtonClick
  end
  object DataGrid: TIB_Grid
    Left = 9
    Top = 196
    Width = 1052
    Height = 642
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    CustomGlyphsSupplied = []
    DataSource = EUDataSource
    TabOrder = 13
    DefaultRowHeight = 22
  end
  object FindCodeValue: TEdit
    Left = 10
    Top = 137
    Width = 117
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 14
    Visible = False
  end
  object InputDataGrid: TStringGrid
    Left = 39
    Top = 195
    Width = 1126
    Height = 551
    TabOrder = 15
    Visible = False
    OnClick = InputDataGridClick
  end
  object SQLNavigator: TIB_NavigationBar
    Left = 146
    Top = 153
    Width = 120
    Height = 25
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 16
    Visible = False
    DataSource = EUDataSource
    ReceiveFocus = False
    CustomGlyphsSupplied = []
  end
  object SkipPanel: TPanel
    Left = 636
    Top = 8
    Width = 231
    Height = 71
    Caption = 'SkipPanel'
    ShowCaption = False
    TabOrder = 17
    object Label2: TLabel
      Left = 191
      Top = 7
      Width = 25
      Height = 17
      Caption = 'lines'
    end
    object Label3: TLabel
      Left = 191
      Top = 37
      Width = 27
      Height = 17
      Caption = 'orgs'
    end
    object SkipButton: TButton
      Left = 13
      Top = 4
      Width = 101
      Height = 25
      Caption = 'Ignore first'
      TabOrder = 0
      OnClick = SkipButtonClick
    end
    object SkipCountEdit: TEdit
      Left = 120
      Top = 3
      Width = 65
      Height = 25
      TabOrder = 1
    end
    object BatchSetButton: TButton
      Left = 13
      Top = 34
      Width = 84
      Height = 25
      Caption = 'Stop after '
      TabOrder = 2
      OnClick = BatchSetButtonClick
    end
    object BatchSizeEdit: TEdit
      Left = 146
      Top = 33
      Width = 39
      Height = 25
      TabOrder = 3
      Text = '0'
      OnChange = BatchSizeEditChange
    end
  end
  object CleanFamiliesButton: TButton
    Left = 992
    Top = 164
    Width = 161
    Height = 25
    Caption = 'Clean familiy data'
    TabOrder = 18
    OnClick = CleanFamiliesButtonClick
  end
  object OpenInputDataDialog: TOpenDialog
    DefaultExt = 'xlsx'
    FileName = 
      'C:\Users\Clare\Documents\Rad Studio\Projets\Common\EuroPlants.xl' +
      's'
    Filter = 'Excel (*.xlsx);(*.xlsm)|*.xlsx;*.xlsm'
    InitialDir = 'C:\Users\Clare\Documents\Rad Studio\Projets\Europlants'
    Left = 152
  end
  object EUDataSource: TIB_DataSource
    Dataset = IMSDM.AllOrganismsQuery
    Left = 304
    Top = 8
  end
  object FamiliesQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsReadOnly.Strings = (
      'FAMILYID=TRUE')
    FieldsVisible.Strings = (
      'FAMILYID=FALSE')
    IB_Connection = IMSDM.FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM FAMILIES')
    DeleteSQL.Strings = (
      'DELETE FROM FAMILIES FAMILIES'
      'WHERE'
      '   FAMILYID = :OLD_FAMILYID')
    EditSQL.Strings = (
      'UPDATE FAMILIES FAMILIES SET'
      '   FAMILIES.FAMILYCODE = :FAMILYCODE,'
      '   FAMILIES.FAMILYNAME = :FAMILYNAME'
      'WHERE'
      '   FAMILYID = :OLD_FAMILYID')
    GeneratorLinks.Strings = (
      'FAMILIES.FAMILYID=FAMILYID_NO')
    InsertSQL.Strings = (
      'INSERT INTO FAMILIES('
      '   FAMILYCODE,'
      '   FAMILYNAME)'
      'VALUES ('
      '   :FAMILYCODE,'
      '   :FAMILYNAME)')
    KeyLinks.Strings = (
      'FAMILIES.FAMILYID')
    KeyLinksAutoDefine = False
    Left = 361
    Top = 5
  end
  object FamLinksQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = IMSDM.FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM LINKS L'
      'where ((L.DATATYPE = '#39'SPT'#39') OR (L.DATATYPE = '#39'SFT'#39'))'
      'AND (L.CODE like '#39'1__%F'#39') '
      'AND (L.STATUSLINK = '#39'A'#39') ')
    KeyLinks.Strings = (
      'LINKS.LINKID')
    Left = 407
    Top = 7
  end
end
