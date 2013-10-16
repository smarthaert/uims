object server: Tserver
  Left = 192
  Top = 136
  BorderStyle = bsDialog
  Caption = #26381#21153#31471#29983#25104
  ClientHeight = 105
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 105
    Height = 13
    AutoSize = False
    Caption = #33258#21160#19978#32447#21517#31216#65306
  end
  object Label2: TLabel
    Left = 8
    Top = 16
    Width = 89
    Height = 13
    AutoSize = False
    Caption = #33258#21160#19978#32447#22320#22336#65306
  end
  object Edit1: TEdit
    Left = 96
    Top = 8
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 96
    Top = 32
    Width = 161
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 112
    Top = 64
    Width = 89
    Height = 33
    Caption = #29983#25104#26381#21153#31471
    TabOrder = 2
    OnClick = Button1Click
  end
end
