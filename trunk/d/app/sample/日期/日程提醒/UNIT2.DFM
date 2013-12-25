object Form2: TForm2
  Left = 460
  Top = 236
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form2'
  ClientHeight = 214
  ClientWidth = 387
  Color = cl3DLight
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000030000000000000000000000000000033BBBBBBB00000000000
    000000000003BB8888888BB00000000000000000003B77777777788B00000000
    0000000003B7F7F7F0F7F778B0000000000000003B7F0F7F7F7F7F078B000000
    000000003B77FFFFF0F7F7F78B00008888888883B77FFFFFF0FF7F7F78B08FFF
    FFFFFFF3B7FFFFFFF0FFF7F778B08F7777777773B7FFFFFF818FFF7F78B08F7F
    FF7FFF73B70FFFFF818FFFF078B08F7FFF7FFF73B7FFFFFFF0FFFF7F78B08F78
    FF78FF73B7FFFFFFF0FFFFF778B08F7777777773B7FFFFFFC0CFFF7F78B08F7F
    FF7FFF7F3B7FFFFCF0FCFFF78B008F7FFF7FFF7F3B7F0FFCF0FCFF0F8B008F78
    FF78FF7FF3B7FFFFC0CFF7F8B0008F7777777777733B77FFF0FF788B00008F7F
    FF7FFF7FF3B3BB7777788BB070008F7FFF7FFF7FF30033BBBBBBB00333008F78
    FF78FF7FFF7FFF3333330F7F80008F7777777777777777773077777F80008F7F
    FF7FFF7FFF7FFF73BB0FFF7F80008F7FFF7FFF7FFF7FFF73330FFF7F80008F78
    FF78FF78FF78FF78FF78FF7F80008F7777777777777777777777777F80008F88
    88888888888888888888888F80008F8888878787878787878888888F80008F77
    77777777777777777777777F80008FFFFFFFFFFFFFFFFFFFFFFFFFFF00008080
    808080808080808080808080000008080808080808080808080808080000FFFF
    C07FFFFF001FFFFE000FFFFC0007FFF80003FFF00001C0000001800000000000
    0000000000000000000000000000000000000000000000000001000000010000
    0003000000030000000300000003000000030000000300000003000000030000
    000300000003000000030000000300000003000000070000000FAAAAAAAF}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object SpeedButton3: TSpeedButton
    Left = 128
    Top = 180
    Width = 117
    Height = 25
    Caption = #30830' '#35748
    Flat = True
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 252
    Top = 180
    Width = 117
    Height = 25
    Caption = #25918' '#24323
    Flat = True
    OnClick = SpeedButton4Click
  end
  object Label6: TLabel
    Left = 16
    Top = 188
    Width = 102
    Height = 12
    Caption = #27700#30707#24037#20316#23460' '#24352#38271#23433
    Font.Charset = GB2312_CHARSET
    Font.Color = clSilver
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 361
    Height = 61
    Caption = #24320#22987#26085#26399'/'#26102#38388#21450#20107#20214#38388#31867#21035
    TabOrder = 0
    object DateTimePicker1: TDateTimePicker
      Left = 16
      Top = 24
      Width = 113
      Height = 20
      Date = 35334.497359838000000000
      Time = 35334.497359838000000000
      DateFormat = dfLong
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 144
      Top = 24
      Width = 57
      Height = 20
      Date = 35334.916527777800000000
      Time = 35334.916527777800000000
      Checked = False
      Kind = dtkTime
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 260
      Top = 24
      Width = 85
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 2
      Items.Strings = (
        #24403#27425#26377#25928
        #27599#22825#19968#27425
        #27599#21608#19968#27425
        #27599#26376#19968#27425
        #27599#24180#19968#27425)
    end
    object ComboBox2: TComboBox
      Left = 200
      Top = 24
      Width = 49
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 3
      Items.Strings = (
        #19978#21320
        #19979#21320)
    end
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 74
    Width = 361
    Height = 95
    Caption = #25552#37266#20869#23481
    TabOrder = 1
    object memo1: TMemo
      Left = 12
      Top = 16
      Width = 337
      Height = 69
      Lines.Strings = (
        '')
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 216
    Width = 361
    Height = 81
    Caption = #25552#37266#26102#21160#20316
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 328
      Top = 16
      Width = 24
      Height = 24
      Hint = #36873#21462#30446#26631#25991#20214
      Caption = '...'
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'System'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object SpeedButton2: TSpeedButton
      Left = 328
      Top = 44
      Width = 24
      Height = 24
      Hint = #36873#21462#30446#26631#25991#20214
      Caption = '...'
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'System'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 22
      Width = 73
      Height = 17
      Caption = #25191#34892#31243#24207
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 50
      Width = 69
      Height = 17
      Caption = #25773#25918#22768#38899
      TabOrder = 1
    end
    object Edit1: TEdit
      Left = 92
      Top = 20
      Width = 233
      Height = 20
      TabOrder = 2
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 92
      Top = 48
      Width = 233
      Height = 20
      TabOrder = 3
      Text = 'Edit2'
    end
  end
end
