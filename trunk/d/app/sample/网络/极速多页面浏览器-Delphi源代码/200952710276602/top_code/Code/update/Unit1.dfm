object Form1: TForm1
  Left = 304
  Top = 255
  Width = 622
  Height = 291
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #26497#36895#27983#35272#22120' '#22312#32447#21319#32423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 40
    Width = 39
    Height = 13
    Caption = #28304#25991#20214':'
  end
  object Label2: TLabel
    Left = 24
    Top = 80
    Width = 51
    Height = 13
    Caption = #30446#26631#25991#20214':'
  end
  object Label_status: TLabel
    Left = 240
    Top = 240
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 80
    Top = 32
    Width = 425
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 48
    Top = 112
    Width = 145
    Height = 57
    Caption = #21319#32423
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 80
    Top = 72
    Width = 425
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object pb: TProgressBar
    Left = 24
    Top = 200
    Width = 561
    Height = 33
    TabOrder = 3
  end
  object Button2: TButton
    Left = 224
    Top = 112
    Width = 161
    Height = 57
    Caption = #20013#26029
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 416
    Top = 112
    Width = 169
    Height = 57
    Caption = #32487#32493
    TabOrder = 5
    OnClick = Button3Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 13000
    OnTimer = Timer1Timer
    Left = 552
    Top = 40
  end
end
