object DatapumpForm: TDatapumpForm
  Left = 0
  Top = 0
  Caption = 'Simple Datapump'
  ClientHeight = 250
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 44
    Top = 10
    Width = 126
    Height = 16
    Caption = 'List of available tables'
  end
  object PumpButton: TButton
    Left = 40
    Top = 123
    Width = 113
    Height = 25
    Caption = 'Pump '
    TabOrder = 0
    OnClick = PumpButtonClick
  end
  object SrcDataGrid: TIB_Grid
    Left = 264
    Top = 92
    Width = 320
    Height = 120
    CustomGlyphsSupplied = []
    DataSource = SrcData
    Visible = False
    TabOrder = 1
  end
  object TestButton: TButton
    Left = 376
    Top = 36
    Width = 73
    Height = 25
    Caption = 'Test source'
    TabOrder = 2
    OnClick = TestButtonClick
  end
  object TableCombo: TComboBox
    Left = 40
    Top = 32
    Width = 145
    Height = 24
    TabOrder = 3
    Text = 'TableCombo'
    OnChange = TableComboChange
    Items.Strings = (
      'Species-Genus'
      'Genus-Family'
      'Books')
  end
  object SrcDataQuery: TIB_Query
    DatabaseName = '127.0.0.1:IMSDB'
    IB_Connection = IMSDM.FBConnection
    SQL.Strings = (
      'SELECT DATATYPE,CODE,DATATYPE_PARENT,CODEPARENT,LINKID'
      'FROM LINKS'
      'where (idlinkcode=9)'
      'and (codeparent like '#39'1%F'#39')')
    Left = 208
    Top = 8
  end
  object SrcData: TIB_DataSource
    Dataset = SrcDataQuery
    Left = 216
    Top = 56
  end
  object DSTStatement: TIB_DSQL
    DatabaseName = '127.0.0.1:IMSDB'
    IB_Connection = IMSDM.FBConnection
    SQL.Strings = (
      'Insert into GenusFamilyLink'
      '(Genuscode, familycode) '
      'Values (:genuscode,:familycode)')
    Left = 312
    Top = 16
  end
  object DataPump: TIB_DataPump
    AfterFetchRow = DataPumpAfterFetchRow
    DstLinks.Strings = (
      ':genuscode=genuscode'
      ':familycode=familycode'
      ':datatype=datatype')
    DstStatement = DSTStatement
    SrcDataset = SrcDataQuery
    Left = 112
    Top = 64
  end
end
