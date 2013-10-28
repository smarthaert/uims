object formarp: Tformarp
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'IPMAC'
  ClientHeight = 229
  ClientWidth = 284
  Color = cl3DLight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object setip: TGroupBox
    Left = 8
    Top = 8
    Width = 130
    Height = 213
    Caption = 'IP'#35774#32622
    TabOrder = 0
    object editmyip: TLabeledEdit
      Left = 16
      Top = 32
      Width = 102
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = #26412#26426'IP'
      TabOrder = 0
    end
    object btnsetip: TButton
      Left = 13
      Top = 179
      Width = 105
      Height = 21
      Caption = #35774#20026#40664#35748
      TabOrder = 4
      OnClick = btnsetipClick
    end
    object editgateip: TLabeledEdit
      Left = 16
      Top = 112
      Width = 102
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = #32593#20851'IP'
      TabOrder = 2
    end
    object editdns: TLabeledEdit
      Left = 16
      Top = 152
      Width = 102
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'DNS'
      TabOrder = 3
    end
    object editsubnet: TLabeledEdit
      Left = 16
      Top = 72
      Width = 102
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = #23376#32593#25513#30721
      TabOrder = 1
    end
  end
  object gatemac: TGroupBox
    Left = 144
    Top = 8
    Width = 130
    Height = 73
    Caption = #32593#20851'MAC'
    TabOrder = 1
    object btnsetmac: TButton
      Left = 16
      Top = 43
      Width = 105
      Height = 21
      Caption = #35774#20026#40664#35748
      TabOrder = 1
      OnClick = btnsetmacClick
    end
    object editgatemac: TEdit
      Left = 16
      Top = 16
      Width = 105
      Height = 21
      TabOrder = 0
    end
  end
  object arp: TGroupBox
    Left = 144
    Top = 87
    Width = 130
    Height = 54
    Caption = 'ARP'#20445#25252
    TabOrder = 2
    object btnARP: TButton
      Left = 16
      Top = 19
      Width = 105
      Height = 21
      Caption = #24320#21551
      TabOrder = 0
      OnClick = btnARPClick
    end
  end
  object findmac: TGroupBox
    Left = 144
    Top = 147
    Width = 130
    Height = 74
    Caption = 'MAC'#26597#35810
    TabOrder = 3
    object btnfindmac: TButton
      Left = 16
      Top = 43
      Width = 105
      Height = 21
      Caption = #26597#35810
      TabOrder = 1
      OnClick = btnfindmacClick
    end
    object editfindmac: TEdit
      Left = 16
      Top = 16
      Width = 105
      Height = 21
      TabOrder = 0
      Text = '192.168.1.1'
    end
  end
  object TrayIconarp: TTrayIcon
    Visible = True
    OnClick = TrayIconarpClick
    Left = 80
  end
end
