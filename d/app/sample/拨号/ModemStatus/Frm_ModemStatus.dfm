object FrmModemStatus: TFrmModemStatus
  Left = 153
  Top = 205
  Width = 253
  Height = 181
  Caption = #21462#24471'Modem'#30340#29366#24577
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnCheckModem: TButton
    Left = 29
    Top = 112
    Width = 75
    Height = 25
    Caption = #26816#27979
    TabOrder = 0
    OnClick = BtnCheckModemClick
  end
  object GBxModemStatus: TGroupBox
    Left = 8
    Top = 8
    Width = 233
    Height = 89
    Caption = 'Modem'#29366#24577
    TabOrder = 1
    object CBxMS_CTS: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = #28165#38500#21457#36865
      TabOrder = 0
    end
    object CBxMS_DSR: TCheckBox
      Left = 104
      Top = 16
      Width = 121
      Height = 17
      Caption = #25968#25454#20934#22791#23601#32490
      TabOrder = 1
    end
    object CBxMS_RING: TCheckBox
      Left = 8
      Top = 55
      Width = 97
      Height = 17
      Caption = #25320#21495#25351#31034
      TabOrder = 2
    end
    object CBxMS_RLSD: TCheckBox
      Left = 104
      Top = 55
      Width = 121
      Height = 17
      Caption = #25509#21463#26816#27979#20449#21495
      TabOrder = 3
    end
  end
  object BtnCLose: TButton
    Left = 141
    Top = 112
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 2
    OnClick = BtnCLoseClick
  end
end
