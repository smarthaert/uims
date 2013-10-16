object FrmOptions: TFrmOptions
  Left = 384
  Top = 220
  BorderStyle = bsDialog
  Caption = #21442#25968#35774#32622
  ClientHeight = 224
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 177
    Caption = #35774#32622#65306
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 122
      Width = 84
      Height = 13
      Caption = #21457#36865#26102#38388#38388#38548#65306
    end
    object Label2: TLabel
      Left = 8
      Top = 66
      Width = 60
      Height = 13
      Caption = #32447#31243#25968#37327#65306
    end
    object Label3: TLabel
      Left = 8
      Top = 95
      Width = 132
      Height = 13
      Caption = #27599#27425#25915#20987#21457#36865#21253#30340#22823#23567#65306
    end
    object Label4: TLabel
      Left = 208
      Top = 122
      Width = 24
      Height = 13
      Caption = #27627#31186
    end
    object Label5: TLabel
      Left = 208
      Top = 95
      Width = 12
      Height = 13
      Caption = #20301
    end
    object Label6: TLabel
      Left = 8
      Top = 150
      Width = 60
      Height = 13
      Caption = #25915#20987#27425#25968#65306
    end
    object Label7: TLabel
      Left = 208
      Top = 150
      Width = 12
      Height = 13
      Caption = #27425
    end
    object ckOverFlow: TCheckBox
      Left = 8
      Top = 16
      Width = 73
      Height = 17
      Caption = #32531#20914#28322#20986
      TabOrder = 0
      OnClick = ckOverFlowClick
    end
    object ckIPRandom: TCheckBox
      Left = 8
      Top = 40
      Width = 145
      Height = 17
      Caption = #20351#29992#38543#26426#29983#25104#30340'IP'#22320#22336
      TabOrder = 1
      OnClick = ckOverFlowClick
    end
    object spnedtInterval: TSpinEdit
      Left = 144
      Top = 117
      Width = 57
      Height = 22
      MaxValue = 60000
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object spnedtSenderCount: TSpinEdit
      Left = 144
      Top = 64
      Width = 57
      Height = 22
      MaxValue = 25
      MinValue = 1
      TabOrder = 3
      Value = 10
    end
    object spnedtPackageLength: TSpinEdit
      Left = 144
      Top = 90
      Width = 57
      Height = 22
      MaxLength = 1
      MaxValue = 1024
      MinValue = 1
      TabOrder = 4
      Value = 1024
    end
    object spedtLoopCount: TSpinEdit
      Left = 144
      Top = 145
      Width = 57
      Height = 22
      MaxValue = 65535
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
  end
  object btbtnOK: TBitBtn
    Left = 56
    Top = 192
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 1
    Kind = bkOK
  end
  object btbtnCancel: TBitBtn
    Left = 136
    Top = 192
    Width = 75
    Height = 25
    Caption = #21462#28040'(&C)'
    TabOrder = 2
    Kind = bkNo
  end
end
