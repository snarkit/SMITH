object ForayEditForm: TForayEditForm
  Left = 0
  Top = 0
  Caption = 'Compare book versions'
  ClientHeight = 582
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
    Left = 673
    Top = 300
    Width = 164
    Height = 25
    Caption = 'Copy in Ian'#39's version'
    ModalResult = 1
    TabOrder = 0
  end
  object UpdateButton: TButton
    Left = 684
    Top = 260
    Width = 147
    Height = 25
    Caption = 'Save edited old version'
    ModalResult = 2
    TabOrder = 1
  end
  object IgnoreButton: TButton
    Left = 706
    Top = 341
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
    Height = 555
    Caption = 'Existing IMSDB'
    TabOrder = 3
    VerticalAlignment = taAlignTop
    object oldForaycode: TEdit
      Left = 17
      Top = 30
      Width = 217
      Height = 24
      TabOrder = 0
      OnChange = oldForayChange
    end
    object oldforayname: TEdit
      Left = 17
      Top = 64
      Width = 217
      Height = 24
      TabOrder = 1
      OnChange = oldForayChange
    end
    object oldforaycountry: TEdit
      Left = 17
      Top = 109
      Width = 90
      Height = 24
      TabOrder = 2
      OnChange = oldForayChange
    end
    object oldforayplace: TEdit
      Left = 17
      Top = 149
      Width = 217
      Height = 24
      TabOrder = 3
      OnChange = oldForayChange
    end
    object oldforaydate: TEdit
      Left = 17
      Top = 189
      Width = 121
      Height = 24
      TabOrder = 4
      OnChange = oldForayChange
    end
    object oldComments: TMemo
      Left = 17
      Top = 243
      Width = 222
      Height = 70
      Lines.Strings = (
        '')
      TabOrder = 5
      OnChange = oldForayChange
    end
  end
  object Panel2: TPanel
    Left = 369
    Top = 0
    Width = 288
    Height = 555
    Caption = 'Ian'#39's version'
    TabOrder = 4
    VerticalAlignment = taAlignTop
    object IMSForaycode: TEdit
      Left = 33
      Top = 34
      Width = 230
      Height = 24
      TabOrder = 0
      OnChange = IMSforaycodeChange
    end
    object IMSforayname: TEdit
      Left = 33
      Top = 64
      Width = 225
      Height = 24
      TabOrder = 1
      OnChange = IMSforaycodeChange
    end
    object IMSforaycountry: TEdit
      Left = 33
      Top = 109
      Width = 74
      Height = 24
      TabOrder = 2
      OnChange = IMSforaycodeChange
    end
    object IMSforayplace: TEdit
      Left = 33
      Top = 149
      Width = 230
      Height = 24
      TabOrder = 3
      OnChange = IMSforaycodeChange
    end
    object IMSVolume: TEdit
      Left = -432
      Top = 560
      Width = 121
      Height = 24
      TabOrder = 4
    end
    object IMSforaydate: TEdit
      Left = 34
      Top = 189
      Width = 121
      Height = 24
      TabOrder = 5
      OnChange = IMSforaycodeChange
    end
    object IMSComments: TMemo
      Left = 33
      Top = 243
      Width = 237
      Height = 70
      Lines.Strings = (
        '')
      TabOrder = 6
      OnChange = IMSforaycodeChange
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
    Left = 680
    Top = 397
    Width = 143
    Height = 25
    Caption = 'Abort'
    TabOrder = 6
    OnClick = AbortButtonClick
  end
  object Panel3: TPanel
    Left = 2
    Top = 0
    Width = 109
    Height = 555
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 7
    object bookcodelabel: TLabel
      Left = 16
      Top = 33
      Width = 56
      Height = 16
      Caption = 'foraycode'
    end
    object shortcodelabel: TLabel
      Left = 15
      Top = 72
      Width = 61
      Height = 16
      Caption = 'forayname'
    end
    object Label5: TLabel
      Left = 15
      Top = 112
      Width = 71
      Height = 16
      Caption = 'foraycountry'
    end
    object Label6: TLabel
      Left = 19
      Top = 152
      Width = 59
      Height = 16
      Caption = 'forayplace'
    end
    object Label7: TLabel
      Left = 22
      Top = 192
      Width = 54
      Height = 16
      Caption = 'foraydate'
    end
    object Label15: TLabel
      Left = 27
      Top = 269
      Width = 59
      Height = 16
      Caption = 'comments'
    end
  end
end
