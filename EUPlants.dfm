object EUPlantsForm: TEUPlantsForm
  Left = 0
  Top = 0
  Caption = 'EUPlantsForm'
  ClientHeight = 530
  ClientWidth = 773
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
  object EUPlantsGrid: TIB_Grid
    Left = 0
    Top = 0
    Width = 773
    Height = 530
    CustomGlyphsSupplied = []
    DataSource = IMSDM.AllEUPlantNamesDS
    Align = alClient
    TabOrder = 0
  end
end
