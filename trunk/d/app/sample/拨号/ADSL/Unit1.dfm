object Frm_main: TFrm_main
  Left = 220
  Top = 205
  Width = 365
  Height = 376
  Caption = #33258#21160#25320#21495#31243#24207
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 24
    Width = 46
    Height = 13
    Caption = #29992#25143#21517':'
  end
  object lbl2: TLabel
    Left = 16
    Top = 56
    Width = 54
    Height = 13
    Caption = #23494'  '#30721': '
  end
  object lbl3: TLabel
    Left = 16
    Top = 87
    Width = 65
    Height = 13
    Caption = #36830#25509#32447#36335#65306
  end
  object edt_username: TEdit
    Left = 64
    Top = 16
    Width = 121
    Height = 21
    ImeName = #26497#21697#20116#31508#36755#20837#27861
    TabOrder = 0
  end
  object edt_password: TEdit
    Left = 64
    Top = 48
    Width = 121
    Height = 21
    ImeName = #26497#21697#20116#31508#36755#20837#27861
    TabOrder = 3
  end
  object cbb_dialname: TComboBox
    Left = 79
    Top = 78
    Width = 106
    Height = 21
    Style = csDropDownList
    ImeName = #26497#21697#20116#31508#36755#20837#27861
    ItemHeight = 13
    TabOrder = 5
  end
  object btn_autoDial: TButton
    Left = 195
    Top = 16
    Width = 78
    Height = 33
    Caption = #33258#21160#25320#21495
    TabOrder = 1
    OnClick = btn_autoDialClick
  end
  object PageControl1: TPageControl
    Left = 6
    Top = 118
    Width = 343
    Height = 222
    ActivePage = TabSheet1
    TabOrder = 6
    object TabSheet1: TTabSheet
      Caption = #26085#24535#20449#24687
      object mmo_log: TMemo
        Left = 0
        Top = 0
        Width = 335
        Height = 194
        Align = alClient
        ImeName = #26497#21697#20116#31508#36755#20837#27861
        ReadOnly = True
        TabOrder = 0
      end
      object Button2: TButton
        Left = 236
        Top = 146
        Width = 75
        Height = 25
        Caption = #28165#31354#26085#24535
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'IP'#35760#24405
      ImageIndex = 1
      object lst_ip: TListBox
        Left = 0
        Top = 0
        Width = 335
        Height = 194
        Align = alClient
        ImeName = #26497#21697#20116#31508#36755#20837#27861
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #22522#26412#35774#32622
      ImageIndex = 1
      object Label1: TLabel
        Left = 18
        Top = 26
        Width = 85
        Height = 13
        Caption = #33258#21160#25320#21495':'#38388#38548
      end
      object Label2: TLabel
        Left = 178
        Top = 25
        Width = 104
        Height = 13
        Caption = #20998#33258#21160#26029#32447#21518#37325#25320
      end
      object cnsedt_dialtime: TCnSpinEdit
        Left = 109
        Top = 20
        Width = 61
        Height = 22
        MaxValue = 100
        MinValue = 1
        TabOrder = 0
        Value = 5
      end
      object chk_autoHideApp: TCheckBox
        Left = 20
        Top = 56
        Width = 170
        Height = 17
        Caption = #31243#24207#33258#21160#38544#34255#21040#29366#24577#26639
        TabOrder = 1
      end
      object chk_TrayShowInfo: TCheckBox
        Left = 20
        Top = 83
        Width = 169
        Height = 17
        Caption = #29366#24577#26639#25320#21495#20449#24687#25552#31034
        TabOrder = 2
      end
      object chk_autoSaveLog: TCheckBox
        Left = 20
        Top = 108
        Width = 168
        Height = 17
        Caption = #33258#21160#20445#23384#26085#24535#35760#24405
        TabOrder = 3
      end
      object Button1: TButton
        Left = 21
        Top = 140
        Width = 119
        Height = 32
        Caption = #20445#23384#35774#32622
        TabOrder = 4
        OnClick = Button1Click
      end
    end
  end
  object btn_disAutoDial: TButton
    Left = 194
    Top = 62
    Width = 110
    Height = 30
    Caption = #26242#20572#33258#21160#25320#21495
    TabOrder = 4
    OnClick = btn_disAutoDialClick
  end
  object btn_disConnect: TButton
    Left = 273
    Top = 16
    Width = 78
    Height = 33
    Caption = #26029#24320#32593#32476
    TabOrder = 2
    OnClick = btn_disConnectClick
  end
  object DialUp1: TDialUp
    CurrentConnection = 'adsl (WAN '#24494#22411#31471#21475' (PPPOE))'
    PossibleConnections.Strings = (
      #23485#24102#36830#25509
      'adsl'
      #20892#21512#19987#32593)
    LangStrList.Strings = (
      'Connecting to %s...'
      'Verifying username and password...'
      'An error occured while trying to connect to %s.')
    Left = 252
    Top = 234
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 212
    Top = 235
  end
  object CnTrayIcon1: TCnTrayIcon
    AutoHide = True
    Icon.Data = {
      0000010001002020040000000000E80200001600000028000000200000004000
      0000010004000000000000020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      00B3111111111111000000000000000000BBB333333333110000000000000000
      008888B333333331000000000000000000033333333331100000000000000000
      000888888BBBBB10000000000000000000000333333333100000000000000000
      000008BBBB3B10000444440000000000000008BBBB3310044676764400000000
      00000888BB3310476767667640000000000000BBBB3372267676676764000000
      000000BBBB3372777767627674000000000000888BB377777772226766400000
      0000000BBBB3377777722276764000000000000BBBB337777222226766400000
      0000000888BB37877222222666400000000000008BBB33777722772222400000
      000000008BBB337F777227222240000000000000888BB378F777222224000000
      000000000BBBB3377772222224000000000000000888B3372777222240000000
      000000000088BB373277772400000000000000000088BB337222220000000000
      0000000000088BB370000000000000000000000000088BB33100000000000000
      000000000000BBB333100000000000000B3333333333BBB33310000000000000
      0BB3333333333BBB33300000000000000BBB3333333BBBBBB330000000000000
      08BBBBBBBBBBB88BBB3000000000000008B8888888888888BB30000000000000
      08888888888888888BB00000000000000000000000000000000000000000FC00
      0FFFFC000FFFFC000FFFFE001FFFFE001FFFFF801FFFFF80783FFF80600FFF80
      4007FFC00003FFC00003FFC00001FFE00001FFE00001FFE00001FFF00001FFF0
      0001FFF00003FFF80003FFF80007FFFC000FFFFC003FFFFE07FFFFFE03FFFFFF
      01FFF80001FFF80001FFF80001FFF80001FFF80001FFF80001FFFFFFFFFF}
    UseAppIcon = True
    OnDblClick = CnTrayIcon1DblClick
    Left = 212
    Top = 96
  end
end
