object frmSetup: TfrmSetup
  Left = 260
  Top = 136
  ActiveControl = BitBtn2
  BorderStyle = bsDialog
  Caption = #36873#39033
  ClientHeight = 135
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
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
    Left = 11
    Top = 8
    Width = 159
    Height = 114
    Caption = #36873#39033#35774#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 24
      Width = 42
      Height = 12
      Caption = #31471#21475#21495':'
    end
    object PortEd: TFloatEdit
      Left = 60
      Top = 21
      Width = 77
      Height = 20
      TabOrder = 0
      Text = '1811'
      Digits = 0
      Value = 1811
      Min = 100
      Max = 60000
      ErrorMessage = '[No Text]'
    end
    object AutoRunCBX: TCheckBox
      Left = 16
      Top = 64
      Width = 97
      Height = 17
      Caption = #24320#26426#33258#21160#21551#21160
      TabOrder = 1
    end
  end
  object BitBtn1: TBitBtn
    Left = 186
    Top = 22
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 186
    Top = 54
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 2
    OnClick = BitBtn2Click
  end
end
