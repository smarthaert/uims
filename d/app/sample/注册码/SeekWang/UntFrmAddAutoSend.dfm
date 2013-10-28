object FrmAddAutoSend: TFrmAddAutoSend
  Left = 514
  Top = 290
  BorderStyle = bsDialog
  Caption = #26032#22686#29992#25143
  ClientHeight = 107
  ClientWidth = 200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 14
    Top = 21
    Width = 36
    Height = 13
    Caption = #29992#25143#21517
  end
  object lbl2: TLabel
    Left = 14
    Top = 48
    Width = 36
    Height = 13
    Caption = #23494'    '#30721
  end
  object Edt1: TEdit
    Left = 62
    Top = 18
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edt2: TEdit
    Left = 62
    Top = 45
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Btn1: TButton
    Left = 14
    Top = 75
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    TabOrder = 2
    OnClick = Btn1Click
  end
  object Btn2: TButton
    Left = 108
    Top = 74
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    TabOrder = 3
    OnClick = Btn2Click
  end
end
