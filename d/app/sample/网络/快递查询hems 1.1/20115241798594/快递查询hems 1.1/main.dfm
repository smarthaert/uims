object fMain: TfMain
  Left = 202
  Top = 66
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24555#36882#26597#35810#31995#32479' 1.0 by hpping'
  ClientHeight = 474
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 18
    Width = 565
    Height = 75
    Caption = #21442#25968
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 30
      Width = 31
      Height = 13
      AutoSize = False
      Caption = #20844#21496
    end
    object Label2: TLabel
      Left = 186
      Top = 33
      Width = 57
      Height = 13
      AutoSize = False
      Caption = #24555#36882#21495#30721
    end
    object cbList: TComboBox
      Left = 55
      Top = 27
      Width = 124
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = #30003#36890'|shentong'
      Items.Strings = (
        '')
    end
    object enNo: TEdit
      Left = 244
      Top = 29
      Width = 148
      Height = 21
      TabOrder = 1
    end
    object btnOK: TButton
      Left = 402
      Top = 27
      Width = 49
      Height = 25
      Caption = '&OK'
      TabOrder = 2
      OnClick = btnOKClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 24
    Top = 110
    Width = 563
    Height = 345
    Caption = #32467#26524
    TabOrder = 1
    object webpage: TWebBrowser
      Left = 2
      Top = 15
      Width = 559
      Height = 328
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C000000C6390000E62100000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
