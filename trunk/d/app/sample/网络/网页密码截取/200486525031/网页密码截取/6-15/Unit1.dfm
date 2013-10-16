object Form1: TForm1
  Left = 262
  Top = 129
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 536
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 376
    Top = 504
    Width = 72
    Height = 13
    AutoSize = False
    Caption = #24403#21069#23494#30721#26159#65306
  end
  object Label2: TLabel
    Left = 32
    Top = 424
    Width = 120
    Height = 13
    AutoSize = False
    Caption = #35831#36755#20837#35201#25171#24320#30340#32593#39029#65306
  end
  object Edit1: TEdit
    Left = 464
    Top = 496
    Width = 105
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 609
    Height = 393
    Align = alTop
    TabOrder = 1
    ControlData = {
      4C000000F13E00009E2800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 472
    Top = 416
    Width = 75
    Height = 25
    Caption = #25171#24320#32593#39029
    TabOrder = 2
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 166
    Top = 420
    Width = 163
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Text = 'www.csdn.net'
  end
  object Button2: TButton
    Left = 72
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 16
    Top = 488
  end
end
