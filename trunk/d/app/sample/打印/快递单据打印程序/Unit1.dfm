object Form1: TForm1
  Left = 288
  Top = 155
  Width = 522
  Height = 296
  Caption = #24555#36882#21333#25171#21360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 312
    Top = 238
    Width = 75
    Height = 25
    Caption = #25171#21360
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 402
    Top = 238
    Width = 75
    Height = 25
    Caption = #36864#20986
    TabOrder = 1
    OnClick = Button2Click
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 514
    Height = 229
    Align = alTop
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = Form2.ADODataSet1
    Left = 18
    Top = 236
  end
end
