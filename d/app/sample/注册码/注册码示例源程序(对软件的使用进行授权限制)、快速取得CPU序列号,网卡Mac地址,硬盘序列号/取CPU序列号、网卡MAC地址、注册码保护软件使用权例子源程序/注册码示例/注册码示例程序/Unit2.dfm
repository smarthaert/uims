object Form2: TForm2
  Left = 193
  Top = 218
  BorderStyle = bsDialog
  Caption = #27880#20876
  ClientHeight = 172
  ClientWidth = 477
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
  object Label3: TLabel
    Left = 40
    Top = 96
    Width = 145
    Height = 13
    AutoSize = False
    Caption = #27880#20876#30721#35201#29992#27880#20876#26426#20135#29983
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8388863
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 14
    Top = 134
    Width = 449
    Height = 13
    Caption = #20320#21487#20351#29992#21387#32553#21253#37324#30340'DLL'#37324#30340#20004#20010#20989#25968#65292#21462#24471'CPU'#24207#21015#21495#25110#32593#21345'MAC'#22320#22336#20316#20026#26426#22120#26631#35782
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 152
    Width = 202
    Height = 13
    Caption = '(GetCPUSerialNumber '#21644' GetMacAddress)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Editid: TEdit
    Left = 128
    Top = 24
    Width = 257
    Height = 21
    ReadOnly = True
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
    Left = 208
    Top = 104
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 312
    Top = 104
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 3
  end
end
