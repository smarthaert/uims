object Form1: TForm1
  Left = 244
  Top = 223
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 179
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 20
    Top = 31
    Width = 133
    Height = 13
    Caption = #26426#22120#26631#35782#19968'(CPU'#24207#21015#21495#65289
  end
  object Label1: TLabel
    Left = 12
    Top = 71
    Width = 146
    Height = 13
    Caption = #26426#22120#26631#35782#20108'('#32593#21345'MAC'#22320#22336#65289
  end
  object Label3: TLabel
    Left = 48
    Top = 96
    Width = 417
    Height = 13
    AutoSize = False
    Caption = #27880#65306#20320#21487#22312#21629#20196#31383#21475#37324#29992'ipconfig -all'#26597#21040#32593#21345'MAC'#22320#22336'(Physical Adress)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8388863
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 75
    Top = 120
    Width = 145
    Height = 25
    Caption = #37325#26032#21462'CPU'#24207#21015#21495
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 160
    Top = 28
    Width = 305
    Height = 21
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 160
    Top = 68
    Width = 305
    Height = 21
    TabOrder = 2
  end
  object Button2: TButton
    Left = 272
    Top = 120
    Width = 145
    Height = 25
    Caption = #37325#26032#21462#32593#21345'MAC'#22320#22336
    TabOrder = 3
    OnClick = Button2Click
  end
end
