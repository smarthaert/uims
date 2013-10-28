object Form1: TForm1
  Left = 318
  Top = 153
  Width = 411
  Height = 221
  Caption = #25171#21360#20449#23553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 403
    Height = 157
    Align = alTop
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 214
    Top = 164
    Width = 75
    Height = 25
    Caption = #25171#21360
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 300
    Top = 164
    Width = 75
    Height = 25
    Caption = #36864#20986
    TabOrder = 2
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = Form2.ADODataSet1
    Left = 10
    Top = 158
  end
end
