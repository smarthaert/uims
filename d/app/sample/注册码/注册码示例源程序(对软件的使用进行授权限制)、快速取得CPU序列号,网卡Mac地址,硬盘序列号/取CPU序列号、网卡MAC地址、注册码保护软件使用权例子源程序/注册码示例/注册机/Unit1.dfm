object Form1: TForm1
  Left = 257
  Top = 245
  BorderStyle = bsDialog
  Caption = #20135#29983#27880#20876#30721
  ClientHeight = 157
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 59
    Top = 30
    Width = 62
    Height = 13
    AutoSize = False
    Caption = #26426#22120#26631#35782
  end
  object Label2: TLabel
    Left = 67
    Top = 70
    Width = 46
    Height = 13
    AutoSize = False
    Caption = #27880#20876#30721
  end
  object Editid: TEdit
    Left = 128
    Top = 24
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object Editcode: TEdit
    Left = 129
    Top = 64
    Width = 256
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 205
    Top = 112
    Width = 96
    Height = 25
    Caption = #20135#29983#27880#20876#30721
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 320
    Top = 112
    Width = 90
    Height = 25
    Caption = #20851'    '#38381
    ModalResult = 2
    TabOrder = 3
    OnClick = Button2Click
  end
end
