object FrmReg: TFrmReg
  Left = 420
  Top = 285
  BorderStyle = bsDialog
  Caption = #27880#20876
  ClientHeight = 154
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 29
    Width = 45
    Height = 16
    Caption = #26426#22120#30721
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 68
    Width = 45
    Height = 16
    Caption = #27880#20876#30721
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 24
    Top = 90
    Width = 267
    Height = 13
    Caption = '('#20813#36153#29992#25143#35831#21040#32676#37324#32034#21462#27880#20876#30721'     QQ'#32676#65306'65154632)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edt1: TEdit
    Left = 59
    Top = 24
    Width = 232
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object Edt2: TEdit
    Left = 59
    Top = 63
    Width = 232
    Height = 21
    TabOrder = 1
  end
  object Btn1: TButton
    Left = 65
    Top = 121
    Width = 75
    Height = 25
    Caption = #27880#20876
    TabOrder = 2
    OnClick = Btn1Click
  end
  object Btn2: TButton
    Left = 176
    Top = 121
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = Btn2Click
  end
end
