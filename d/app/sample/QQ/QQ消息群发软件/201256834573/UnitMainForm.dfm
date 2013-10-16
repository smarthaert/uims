object MainForm: TMainForm
  Left = 301
  Top = 72
  BorderStyle = bsDialog
  Caption = 'QQ'#20449#24687#32676#21457#36719#20214
  ClientHeight = 602
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lbl2: TLabel
    Left = 16
    Top = 16
    Width = 88
    Height = 12
    AutoSize = False
    Caption = #35201#21457#36865#30340#25991#23383
  end
  object lbl3: TLabel
    Left = 16
    Top = 137
    Width = 64
    Height = 12
    AutoSize = False
    Caption = #24320#22987'QQ'#21495
  end
  object lbl4: TLabel
    Left = 233
    Top = 137
    Width = 64
    Height = 12
    AutoSize = False
    Caption = #32467#26463'QQ'#21495
  end
  object lbl5: TLabel
    Left = 426
    Top = 16
    Width = 88
    Height = 12
    AutoSize = False
    Caption = #21457#36865#21382#21490
  end
  object wb1: TWebBrowser
    Left = 16
    Top = 361
    Width = 603
    Height = 224
    TabOrder = 7
    ControlData = {
      4C000000523E0000271700000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object btn3: TButton
    Left = 289
    Top = 169
    Width = 123
    Height = 51
    Caption = #21457#36865
    TabOrder = 4
    OnClick = btn3Click
  end
  object mmoNew: TMemo
    Left = 217
    Top = 236
    Width = 193
    Height = 116
    Lines.Strings = (
      'mmo2')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
    WordWrap = False
  end
  object mmoText: TMemo
    Left = 16
    Top = 36
    Width = 394
    Height = 89
    Lines.Strings = (
      'http://www.513erp.com')
    TabOrder = 0
  end
  object edtBegin: TEdit
    Left = 72
    Top = 133
    Width = 123
    Height = 20
    TabOrder = 2
    Text = '1042029034'
  end
  object edtEnd: TEdit
    Left = 289
    Top = 133
    Width = 123
    Height = 20
    TabOrder = 3
    Text = '1042029036'
  end
  object mmoHistory: TMemo
    Left = 426
    Top = 36
    Width = 193
    Height = 317
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object mmoOld: TMemo
    Left = 16
    Top = 236
    Width = 193
    Height = 116
    Lines.Strings = (
      'mmo1')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
    WordWrap = False
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 80
    Top = 176
  end
end
