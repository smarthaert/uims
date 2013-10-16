object Form1: TForm1
  Left = 219
  Top = 110
  Width = 267
  Height = 299
  Caption = 'XiaoZ QQ'#22909#21451#32676#21024#22120
  Color = clDefault
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 48
    Width = 209
    Height = 153
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'XiaoZ QQ'#22909#21451#32676#21024#24037#20855#12290
      '1.'#35831#25171#24320#24744#30340'QQ'#22909#21451#20449#24687#31649#29702#22120#65292
      '2.'#36873#20013#24744#38656#35201#21024#38500#30340#22909#21451#32452#65292
      '3.'#28857#36816#34892#28982#21518#21333#20987#22909#21451#21363#21487#12290
      '   QQ707862309')
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 32
    Top = 224
    Width = 75
    Height = 25
    Caption = #24320#22987
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 224
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 2
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 112
    Top = 16
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 152
    Top = 16
  end
end
