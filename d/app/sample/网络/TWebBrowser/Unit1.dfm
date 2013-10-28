object Form1: TForm1
  Left = 115
  Top = 124
  AutoScroll = False
  Caption = #31616#21333#27983#35272#22120'  --'#26080#21452#20316#21697
  ClientHeight = 600
  ClientWidth = 860
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 48
    Height = 20
    Caption = #22320#22336#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 40
    Width = 857
    Height = 561
    TabOrder = 0
    ControlData = {
      4C00000093580000FB3900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620C000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object ComboBox1: TComboBox
    Left = 80
    Top = 8
    Width = 673
    Height = 21
    Color = clSkyBlue
    ItemHeight = 13
    TabOrder = 1
    Text = 'http://www.codefans.net/'
  end
  object BitBtn1: TBitBtn
    Left = 768
    Top = 8
    Width = 65
    Height = 25
    Caption = #36716#21040
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn1Click
  end
end
