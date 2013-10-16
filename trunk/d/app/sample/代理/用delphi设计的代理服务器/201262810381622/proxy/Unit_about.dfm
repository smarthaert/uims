object about: Tabout
  Left = 226
  Top = 115
  Width = 320
  Height = 263
  Caption = '关于本软件、、'
  Color = clMenu
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 16
    Width = 145
    Height = 19
    Caption = 'HTTP代理服务器'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 109
    Top = 204
    Width = 91
    Height = 25
    Caption = '关  闭'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 40
    Width = 281
    Height = 153
    Color = clBtnShadow
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = []
    Lines.Strings = (
      '  本程序用于提供HTTP代理服务功能，'
      '是我的毕业设计作品。由于时间很短，'
      '还有很多的错误之处。希望您在试用之'
      '后，能及时提供意见以便于以后对之进'
      '行改进。'
      '  作    者：阿宝'
      '  联系方法：sodme@21cn.com '
      '  关于本程序的详细使用说明请参照“'
      '使用说明”部分。')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
end
