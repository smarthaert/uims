object frmAddFormat: TfrmAddFormat
  Left = 464
  Top = 284
  ActiveControl = Edit1
  BorderStyle = bsDialog
  Caption = #22686#21152#26684#24335
  ClientHeight = 186
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 332
    Height = 129
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 54
      Height = 12
      Caption = #26679#24335#21517#31216':'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 54
      Height = 12
      Caption = #26679#24335#25991#20214':'
    end
    object Label3: TLabel
      Left = 16
      Top = 88
      Width = 54
      Height = 12
      Caption = #22791#27880#20449#24687':'
    end
    object Edit1: TEdit
      Left = 80
      Top = 20
      Width = 238
      Height = 20
      TabOrder = 0
      OnExit = Edit1Exit
    end
    object Edit2: TEdit
      Left = 80
      Top = 52
      Width = 238
      Height = 20
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 80
      Top = 84
      Width = 238
      Height = 20
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 184
    Top = 144
    Width = 75
    Height = 25
    Caption = #30830#23450'[&O]'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 144
    Width = 75
    Height = 25
    Caption = #21462#28040'[&C]'
    TabOrder = 2
    OnClick = Button2Click
  end
end
