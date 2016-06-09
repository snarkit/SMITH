object PlantCardEditForm: TPlantCardEditForm
  Left = 282
  Top = 39
  Caption = 'Edit Plant Cards'
  ClientHeight = 905
  ClientWidth = 1499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object DistributionPanel: TPanel
    Left = 614
    Top = 73
    Width = 885
    Height = 832
    Align = alClient
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    VerticalAlignment = taAlignTop
    object IslandsPanel: TPanel
      Left = 0
      Top = 439
      Width = 885
      Height = 393
      Align = alBottom
      Caption = 'IslandsPanel'
      ShowCaption = False
      TabOrder = 0
      object AzoresPanel: TPanel
        Left = 1
        Top = 1
        Width = 431
        Height = 391
        Align = alLeft
        Alignment = taLeftJustify
        BorderStyle = bsSingle
        Caption = 'Azores'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        Padding.Left = 5
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        object AZStatusControl: TOrgStatusControl
          Left = 16
          Top = 47
          Width = 179
          Height = 130
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Caption = 'Status'
          OnStatusChangeEvent = AZStatusControlStatusChangeEvent
          StatusGB.Left = 0
          StatusGB.Top = 0
          StatusGB.Width = 179
          StatusGB.Height = 130
          Padding.Left = 5
          Padding.Top = 35
          Padding.Right = 5
          Padding.Bottom = 5
          OrgStatus = 'Undefined'
        end
        object AZAbundanceControl: TOrgAbundanceControl
          Left = 16
          Top = 218
          Width = 113
          Height = 130
          Caption = 'Abundance'
          DataField = 'AZABUNDANCE'
          DataSource = PlantCardDS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          BorderStyle = bsNone
          TabOrder = 1
          Items.Strings = (
            'Common'
            'Infrequent'
            'Rare'
            'Unknown')
          Values.Strings = (
            'C'
            'I'
            'R'
            'X')
        end
        object AZIslandsControl: TOrgDistributionControl
          Left = 222
          Top = 47
          Width = 200
          Height = 330
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          DistributionGB.Left = 0
          DistributionGB.Top = 0
          DistributionGB.Width = 199
          DistributionGB.Height = 329
          DistributionGB.Padding.Left = 5
          DistributionGB.Padding.Top = 35
          DistributionGB.Padding.Right = 5
          DistributionGB.Padding.Bottom = 10
          OnDistributionChangeEvent = AZIslandsControlDistributionChangeEvent
          OrgDistribution = ' '
          DistributionDataType = odAZIslands
          DistributionList.Left = 5
          DistributionList.Top = 135
          DistributionList.Width = 189
          DistributionList.Height = 219
          DistributionList.BorderStyle = bsNone
          DistributionList.Font.Charset = DEFAULT_CHARSET
          DistributionList.Font.Color = clWindowText
          DistributionList.Font.Height = -13
          DistributionList.Font.Name = 'Tahoma'
          DistributionList.Font.Style = []
          DistributionList.Items.Strings = (
            'Corvo'
            'Flores'
            'Faial'
            'Pico'
            'S'#227'o Jorge'
            'Graciosa'
            'Terceira'
            'S'#227'o Miguel'
            'Santa Maria')
          DistributionList.MultiSelect = True
          DistributionList.ParentColor = True
          DistributionList.ParentFont = False
          DistributionList.TabOrder = 1
          DistributionList.Padding.Left = 5
          DistributionList.Padding.Top = 5
          DistributionList.Padding.Right = 5
          DistributionList.Padding.Bottom = 5
          DistributionValues.Strings = (
            'C=Corvo'
            'L=Flores'
            'F=Faial'
            'P=Pico'
            'J=S'#227'o Jorge'
            'G=Graciosa'
            'T=Terceira'
            'M=S'#227'o Miguel'
            'R=Santa Maria')
          HintLabel.Left = 5
          HintLabel.Top = 61
          HintLabel.Width = 172
          HintLabel.Height = 32
          HintLabel.Caption = 'or select below (shift+click for range, ctrl+click for several)'
          HintLabel.WordWrap = True
          Caption = 'Islands'
          MyHint = 'or select below (shift+click for range, ctrl+click for several)'
          Separator = '/'
        end
      end
      object MDPanel: TPanel
        Left = 459
        Top = 1
        Width = 425
        Height = 391
        Align = alRight
        Alignment = taLeftJustify
        BorderStyle = bsSingle
        Caption = 'Madeira'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
        object MDStatusControl: TOrgStatusControl
          Left = 22
          Top = 56
          Width = 179
          Height = 130
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Caption = 'Status'
          OnStatusChangeEvent = MDStatusControlStatusChangeEvent
          StatusGB.Left = 0
          StatusGB.Top = 0
          StatusGB.Width = 179
          StatusGB.Height = 130
          Padding.Left = 5
          Padding.Top = 35
          Padding.Right = 5
          Padding.Bottom = 5
          OrgStatus = 'Undefined'
        end
        object MDAbundanceControl: TOrgAbundanceControl
          Left = 20
          Top = 218
          Width = 113
          Height = 130
          Caption = 'Abundance'
          DataField = 'MDABUNDANCE'
          DataSource = PlantCardDS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          BorderStyle = bsNone
          TabOrder = 1
          Items.Strings = (
            'Common'
            'Infrequent'
            'Rare'
            'Unknown')
          Values.Strings = (
            'C'
            'I'
            'R'
            'X')
        end
        object MDIslandsControl: TOrgDistributionControl
          Left = 207
          Top = 52
          Width = 200
          Height = 330
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          DistributionGB.Left = 0
          DistributionGB.Top = 0
          DistributionGB.Width = 199
          DistributionGB.Height = 329
          DistributionGB.Padding.Left = 5
          DistributionGB.Padding.Top = 35
          DistributionGB.Padding.Right = 5
          DistributionGB.Padding.Bottom = 10
          OnDistributionChangeEvent = MDIslandsControlDistributionChangeEvent
          OrgDistribution = ' '
          DistributionDataType = odMDIslands
          DistributionList.Left = 5
          DistributionList.Top = 135
          DistributionList.Width = 189
          DistributionList.Height = 219
          DistributionList.BorderStyle = bsNone
          DistributionList.Font.Charset = DEFAULT_CHARSET
          DistributionList.Font.Color = clWindowText
          DistributionList.Font.Height = -13
          DistributionList.Font.Name = 'Tahoma'
          DistributionList.Font.Style = []
          DistributionList.Items.Strings = (
            'Madeira'
            'Porto Santo'
            'Desertas'
            'Salvagens')
          DistributionList.MultiSelect = True
          DistributionList.ParentColor = True
          DistributionList.ParentFont = False
          DistributionList.TabOrder = 1
          DistributionList.Padding.Left = 5
          DistributionList.Padding.Top = 5
          DistributionList.Padding.Right = 5
          DistributionList.Padding.Bottom = 5
          DistributionValues.Strings = (
            'MD=Madeira'
            'PS=Porto Santo'
            'DS=Desertas'
            'SV=Salvagens')
          HintLabel.Left = 5
          HintLabel.Top = 61
          HintLabel.Width = 176
          HintLabel.Height = 32
          HintLabel.Caption = 'or select below (shift+click for range, ctrl+click for several)'
          HintLabel.WordWrap = True
          Caption = 'Islands'
          MyHint = 'or select below (shift+click for range, ctrl+click for several)'
          Separator = '/'
        end
      end
    end
    object ContinentPanel: TPanel
      Left = 0
      Top = 0
      Width = 885
      Height = 407
      Align = alTop
      Alignment = taLeftJustify
      BorderStyle = bsSingle
      Caption = 'Continental Portugal'
      Padding.Left = 5
      TabOrder = 1
      VerticalAlignment = taAlignTop
      object PTStatusControl: TOrgStatusControl
        Left = 15
        Top = 39
        Width = 179
        Height = 130
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Caption = 'Status'
        OnStatusChangeEvent = PTStatusControlStatusChangeEvent
        StatusGB.Left = 0
        StatusGB.Top = 0
        StatusGB.Width = 179
        StatusGB.Height = 130
        Padding.Left = 5
        Padding.Top = 35
        Padding.Right = 5
        Padding.Bottom = 5
        OrgStatus = 'Undefined'
      end
      object PTAbundanceControl: TOrgAbundanceControl
        Left = 15
        Top = 231
        Width = 113
        Height = 130
        Caption = 'Abundance'
        DataField = 'PTABUNDANCE'
        DataSource = PlantCardDS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        BorderStyle = bsNone
        TabOrder = 1
        Items.Strings = (
          'Common'
          'Infrequent'
          'Rare'
          'Unknown')
        Values.Strings = (
          'C'
          'I'
          'R'
          'X')
      end
      object PTProvinceControl: TOrgDistributionControl
        Left = 200
        Top = 39
        Width = 167
        Height = 352
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        DistributionGB.Left = 0
        DistributionGB.Top = 0
        DistributionGB.Width = 166
        DistributionGB.Height = 351
        DistributionGB.Padding.Left = 5
        DistributionGB.Padding.Top = 35
        DistributionGB.Padding.Right = 5
        DistributionGB.Padding.Bottom = 10
        OnDistributionChangeEvent = PTProvinceControlDistributionChangeEvent
        OrgDistribution = ' '
        DistributionDataType = odProvinces
        DistributionList.Left = 5
        DistributionList.Top = 135
        DistributionList.Width = 156
        DistributionList.Height = 241
        DistributionList.Margins.Top = 15
        DistributionList.BorderStyle = bsNone
        DistributionList.Font.Charset = DEFAULT_CHARSET
        DistributionList.Font.Color = clWindowText
        DistributionList.Font.Height = -13
        DistributionList.Font.Name = 'Tahoma'
        DistributionList.Font.Style = []
        DistributionList.Items.Strings = (
          'Minho'
          'Tras-os-Montes'
          'Douro litoral'
          'Beira alta'
          'Beira litoral'
          'Beira baixa'
          'Ribatejo'
          'Estremadura'
          'Alto Alentejo'
          'Baixo Alentejo'
          'Algarve')
        DistributionList.MultiSelect = True
        DistributionList.ParentColor = True
        DistributionList.ParentFont = False
        DistributionList.TabOrder = 1
        DistributionList.Padding.Left = 5
        DistributionList.Padding.Top = 5
        DistributionList.Padding.Right = 5
        DistributionList.Padding.Bottom = 5
        DistributionValues.Strings = (
          'M=Minho'
          'T=Tras-os-Montes'
          'D=Douro litoral'
          'B=Beira alta'
          'L=Beira litoral'
          'I=Beira baixa'
          'R=Ribatejo'
          'E=Estremadura'
          'A=Alto Alentejo'
          'J=Baixo Alentejo'
          'G=Algarve')
        HintLabel.Left = 5
        HintLabel.Top = 61
        HintLabel.Width = 156
        HintLabel.Height = 48
        HintLabel.Caption = 'or select below (shift+click for range, ctrl+click for several)'
        HintLabel.WordWrap = True
        Caption = 'Provinces'
        MyHint = 'or select below (shift+click for range, ctrl+click for several)'
        Separator = '/'
      end
      object PTFloristicControl: TOrgDistributionControl
        Left = 373
        Top = 50
        Width = 508
        Height = 330
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        DistributionGB.Left = 0
        DistributionGB.Top = 0
        DistributionGB.Width = 507
        DistributionGB.Height = 329
        DistributionGB.Padding.Left = 5
        DistributionGB.Padding.Top = 35
        DistributionGB.Padding.Right = 5
        DistributionGB.Padding.Bottom = 10
        OnDistributionChangeEvent = PTFloristicControlDistributionChangeEvent
        OrgDistribution = ' '
        DistributionDataType = odFloristic
        DistributionList.Left = 5
        DistributionList.Top = 135
        DistributionList.Width = 497
        DistributionList.Height = 219
        DistributionList.BorderStyle = bsNone
        DistributionList.Columns = 3
        DistributionList.Font.Charset = DEFAULT_CHARSET
        DistributionList.Font.Color = clWindowText
        DistributionList.Font.Height = -13
        DistributionList.Font.Name = 'Tahoma'
        DistributionList.Font.Style = []
        DistributionList.Items.Strings = (
          'Northwest (western)'
          'Northwest (montane)'
          ''
          'Northeast (high mountain)'
          'Northeast (basic)'
          'Northeast (400-900 m)'
          'Northeast (<400 m)'
          ''
          'West Centre (sand)'
          'West Centre (limestone)'
          'West Centre (Lisbon)'
          'West Centre (Cintra)'
          ''
          'North Centre'
          ''
          'East Centre (montane)'
          'East Centre (plain)'
          ''
          'South Centre (lower Tejo)'
          'South Centre (middle Tejo)'
          'South Centre (Arrabida)'
          ''
          'Southwest (northern)'
          'Southwest (southern)'
          'Southwest (montane)'
          ''
          'Southeast (northern)'
          'Southeast (southern)'
          ''
          'Algarve (Barrocal)'
          'Algarve (Barlavento)'
          'Algarve (Sotavento)')
        DistributionList.MultiSelect = True
        DistributionList.ParentColor = True
        DistributionList.ParentFont = False
        DistributionList.TabOrder = 1
        DistributionList.Padding.Left = 5
        DistributionList.Padding.Top = 5
        DistributionList.Padding.Right = 5
        DistributionList.Padding.Bottom = 5
        DistributionValues.Strings = (
          'NWW=Northwest (western)'
          'NWM=Northwest (montane)'
          '000='
          'NEH=Northeast (high mountain)'
          'NEB=Northeast (basic)'
          'NED=Northeast (400-900 m)'
          'NEL=Northeast (<400 m)'
          '000='
          'WCS=West Centre (sand)'
          'WCL=West Centre (limestone)'
          'WCX=West Centre (Lisbon)'
          'WCC=West Centre (Cintra)'
          '000='
          'NCE=North Centre'
          '000='
          'ECM=East Centre (montane)'
          'ECP=East Centre (plain)'
          '000='
          'SCL=South Centre (lower Tejo)'
          'SCC=South Centre (middle Tejo)'
          'SCA=South Centre (Arrabida)'
          '000='
          'SWN=Southwest (northern)'
          'SWS=Southwest (southern)'
          'SWM=Southwest (montane)'
          '000='
          'SEN=Southeast (northern)'
          'SES=Southeast (southern)'
          '000='
          'AGC=Algarve (Barrocal)'
          'AGB=Algarve (Barlavento)'
          'AGS=Algarve (Sotavento)')
        HintLabel.Left = 5
        HintLabel.Top = 61
        HintLabel.Width = 497
        HintLabel.Height = 16
        HintLabel.Caption = 'or select below (shift+click for range, ctrl+click for several)'
        HintLabel.WordWrap = True
        Caption = 'Floristic areas'
        MyHint = 'or select below (shift+click for range, ctrl+click for several)'
        Separator = '/'
      end
    end
  end
  object TitleGroupBox: TGroupBox
    Left = 0
    Top = 0
    Width = 1499
    Height = 73
    Align = alTop
    Caption = 'Current plant'
    TabOrder = 1
    object Plantname: TIB_Text
      Left = 786
      Top = 26
      Width = 107
      Height = 28
      AutoSize = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object IB_Label1: TIB_Label
      Left = 16
      Top = 32
      Width = 61
      Height = 16
      Alignment = taLeftJustify
      Caption = 'EPPO code'
      ShowAccelChar = True
      Transparent = True
      Layout = tlTop
      WordWrap = False
    end
    object PlantCode: TIB_Text
      Left = 617
      Top = 26
      Width = 91
      Height = 24
      DataField = 'PLANTCODE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SearchButton: TButton
      Left = 210
      Top = 29
      Width = 75
      Height = 25
      Caption = 'Search'
      TabOrder = 0
      OnClick = SearchButtonClick
    end
    object CodeLocateEdit: TIB_LocateEdit
      Left = 83
      Top = 29
      Width = 121
      Height = 24
      DataField = 'PLANTCODE'
      DataSource = PlantCardDS
    end
    object DeleteButton: TButton
      Left = 502
      Top = 29
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 2
      OnClick = DeleteButtonClick
    end
    object SaveButton: TButton
      Left = 1296
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 3
      OnClick = SaveButtonClick
    end
    object CloseButton: TButton
      Left = 1412
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 4
      OnClick = CloseButtonClick
    end
    object IB_NavigationBar1: TIB_NavigationBar
      Left = 326
      Top = 28
      Width = 120
      Height = 25
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
      DataSource = PlantCardDS
      ReceiveFocus = False
      CustomGlyphsSupplied = []
    end
  end
  object PlantDataPanel: TPanel
    Left = 0
    Top = 73
    Width = 614
    Height = 832
    Align = alLeft
    BorderStyle = bsSingle
    Caption = 'PlantDataPanel'
    ShowCaption = False
    TabOrder = 2
    object FormRG: TIB_RadioGroup
      Left = 22
      Top = 50
      Width = 322
      Height = 280
      Caption = 'Form'
      DataField = 'FORM'
      DataSource = PlantCardDS
      BorderStyle = bsNone
      TabOrder = 0
      Items.Strings = (
        'Deciduous tree'
        'Evergreen tree'
        'Deciduous shrub'
        'Evergreen shrub'
        'Low shrub'
        'Herbaceous perennial, surviving above ground'
        'Herbaceous perennial, surviving at ground level'
        'Herbaceous perennial, bulbous or rhizomatous'
        'Annual'
        'Biennial'
        'Water plant')
      Values.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11')
    end
    object VulnerabilityRG: TIB_RadioGroup
      Left = 390
      Top = 50
      Width = 185
      Height = 150
      Caption = 'Vulnerability'
      DataField = 'VULNERABILITY'
      DataSource = PlantCardDS
      BorderStyle = bsNone
      TabOrder = 1
      Items.Strings = (
        'Least concern'
        'Near threatened'
        'Vulnerable'
        'Endangered'
        'Critically endangered')
      Values.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object ProtectionRG: TIB_RadioGroup
      Left = 394
      Top = 231
      Width = 121
      Height = 84
      Caption = 'Protection'
      DataField = 'PROTECTION'
      BorderStyle = bsNone
      TabOrder = 2
      Items.Strings = (
        'Yes'
        'No')
      Values.Strings = (
        'Y'
        'N')
    end
    object SizeGB: TGroupBox
      Left = 23
      Top = 359
      Width = 185
      Height = 73
      Caption = 'Size    '
      TabOrder = 3
      OnExit = SizeGBExit
      object Dash2: TLabel
        Left = 75
        Top = 36
        Width = 6
        Height = 16
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Unitscm: TLabel
        Left = 162
        Top = 34
        Width = 17
        Height = 16
        Caption = 'cm'
      end
      object MinSize: TXSpinEdit
        Left = 3
        Top = 31
        Width = 65
        Height = 26
        Increment = 5
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object MaxSize: TXSpinEdit
        Left = 92
        Top = 31
        Width = 64
        Height = 26
        Increment = 5
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
    object FlowerGB: TGroupBox
      Left = 232
      Top = 359
      Width = 185
      Height = 73
      Caption = 'Month of flowering'
      TabOrder = 4
      OnExit = FlowerGBExit
      object Dash3: TLabel
        Left = 75
        Top = 36
        Width = 6
        Height = 16
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object MinFlower: TXSpinEdit
        Left = 3
        Top = 31
        Width = 65
        Height = 26
        MaxValue = 12
        MinValue = 1
        TabOrder = 0
        Value = 1
      end
      object MaxFlower: TXSpinEdit
        Left = 92
        Top = 31
        Width = 64
        Height = 26
        MaxValue = 12
        MinValue = 1
        TabOrder = 1
        Value = 1
      end
    end
    object AltitudeGB: TGroupBox
      Left = 411
      Top = 359
      Width = 185
      Height = 73
      Caption = 'Altitude'
      TabOrder = 5
      OnExit = AltitudeGBExit
      object Dash1: TLabel
        Left = 75
        Top = 36
        Width = 6
        Height = 16
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Unitsm: TLabel
        Left = 162
        Top = 34
        Width = 11
        Height = 16
        Caption = 'm'
      end
      object MinAltitude: TXSpinEdit
        Left = 3
        Top = 31
        Width = 65
        Height = 26
        Increment = 100
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object MaxAltitude: TXSpinEdit
        Left = 92
        Top = 31
        Width = 64
        Height = 26
        Increment = 100
        MaxValue = 4000
        MinValue = 0
        TabOrder = 1
        Value = 100
      end
    end
    object MediumGB: TGroupBox
      Left = 22
      Top = 454
      Width = 185
      Height = 121
      Caption = 'Medium'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 
        'Vvobject CheckBox3: TCheckBoxobject CheckBox3: TCheckBoxobject C' +
        'heckBox3: TCheckBox'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnExit = MediumGBExit
      object MarineCB: TCheckBox
        Left = 12
        Top = 88
        Width = 97
        Height = 17
        Caption = 'Marine'
        TabOrder = 0
      end
      object FreshwaterCB: TCheckBox
        Left = 12
        Top = 60
        Width = 97
        Height = 17
        Caption = 'Freshwater'
        TabOrder = 1
      end
      object TerrestrialCB: TCheckBox
        Left = 12
        Top = 32
        Width = 97
        Height = 17
        Caption = 'Terrestrial'
        TabOrder = 2
      end
    end
    object GuildGB: TGroupBox
      Left = 32
      Top = 644
      Width = 176
      Height = 154
      Caption = 'Guild'
      TabOrder = 7
      OnExit = GuildGBExit
      object AutotrophCB: TCheckBox
        Left = 12
        Top = 36
        Width = 97
        Height = 17
        Caption = 'Autotroph'
        TabOrder = 0
      end
      object SaprophyteCB: TCheckBox
        Left = 12
        Top = 66
        Width = 97
        Height = 17
        Caption = 'Saprophyte'
        TabOrder = 1
      end
      object ParasiteCB: TCheckBox
        Left = 12
        Top = 96
        Width = 97
        Height = 17
        Caption = 'Parasite'
        TabOrder = 2
      end
      object CarnivoreCB: TCheckBox
        Left = 12
        Top = 126
        Width = 97
        Height = 17
        Caption = 'Carnivore'
        TabOrder = 3
      end
    end
    object EndemicRG: TIB_RadioGroup
      Left = 24
      Top = 581
      Width = 184
      Height = 57
      Caption = 'Endemic'
      DataField = 'ENDEMIC'
      DataSource = PlantCardDS
      BorderStyle = bsNone
      TabOrder = 8
      Columns = 2
      Items.Strings = (
        'Yes'
        'No')
      Values.Strings = (
        'Y'
        'N')
    end
    object HabitatGB: TGroupBox
      Left = 214
      Top = 454
      Width = 392
      Height = 174
      Caption = 'Habitat'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      object HabitatMemo: TIB_Memo
        Left = 2
        Top = 32
        Width = 388
        Height = 140
        DataField = 'HABITAT'
        DataSource = PlantCardDS
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        BorderStyle = bsNone
        TabOrder = 0
        AutoSize = False
      end
    end
    object WorldwideGB: TGroupBox
      Left = 214
      Top = 644
      Width = 395
      Height = 150
      Caption = 'Worldwide distribution'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object WorldwideMemo: TIB_Memo
        Left = 2
        Top = 28
        Width = 391
        Height = 120
        DataField = 'WORLDDIST'
        DataSource = PlantCardDS
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        BorderStyle = bsNone
        TabOrder = 0
        AutoSize = False
      end
    end
  end
  object PlantCardDS: TIB_DataSource
    Left = 955
    Top = 8
  end
end
