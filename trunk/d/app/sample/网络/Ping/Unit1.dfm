object Form1: TForm1
  Left = 0
  Top = 0
  Anchors = []
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #25209#37327'Ping'
  ClientHeight = 342
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object label2: TLabel
    Left = 8
    Top = 8
    Width = 34
    Height = 13
    Caption = 'IP'#22320#22336
  end
  object Label1: TLabel
    Left = 183
    Top = 34
    Width = 12
    Height = 13
    Caption = #20010
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 48
    Height = 13
    Caption = #36229#26102#35774#32622
  end
  object Label4: TLabel
    Left = 116
    Top = 64
    Width = 24
    Height = 13
    Caption = #27627#31186
  end
  object Edit1: TEdit
    Left = 48
    Top = 5
    Width = 161
    Height = 21
    TabOrder = 0
    Text = '192.168.1.1'
    TextHint = #35831#36755#20837#19968#20010'IP'
  end
  object Button1: TButton
    Left = 215
    Top = 3
    Width = 75
    Height = 25
    Caption = #28155#21152#21040#21015#34920
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 26
    Width = 75
    Height = 25
    Caption = #24320#22987'Ping'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Nedit1: TRzNumericEdit
    Left = 136
    Top = 32
    Width = 41
    Height = 21
    MaxLength = 3
    TabOrder = 3
    Max = 255.000000000000000000
    Value = 1.000000000000000000
    DisplayFormat = '0;(0)'
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 32
    Width = 130
    Height = 17
    Caption = #25353#26368#21518#19968#27573#36830#32493#28155#21152
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 0
    Top = 88
    Width = 390
    Height = 254
    Align = alBottom
    BevelInner = bvLowered
    BevelKind = bkSoft
    Caption = 'Panel1'
    TabOrder = 5
    object Label5: TLabel
      Left = 2
      Top = 2
      Width = 382
      Height = 13
      Align = alTop
      Caption = 'Ping'#22320#22336#21015#34920'                                  Ping'#32467#26524
      ExplicitWidth = 214
    end
    object List1: TListBox
      Left = 2
      Top = 15
      Width = 160
      Height = 233
      Align = alLeft
      ItemHeight = 13
      PopupMenu = PopupMenu1
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 0
      ExplicitHeight = 229
    end
    object list2: TListBox
      Left = 168
      Top = 15
      Width = 216
      Height = 233
      Align = alRight
      ItemHeight = 13
      PopupMenu = PopupMenu2
      TabOrder = 1
    end
  end
  object Button3: TButton
    Left = 296
    Top = 58
    Width = 75
    Height = 25
    Caption = #20572' '#27490
    TabOrder = 6
    OnClick = Button3Click
  end
  object Nedit2: TRzNumericEdit
    Left = 62
    Top = 61
    Width = 48
    Height = 21
    TabOrder = 7
    Value = 1000.000000000000000000
    DisplayFormat = '0;(,0)'
  end
  object IdIcmp: TIdIcmpClient
    ReceiveTimeout = 1000
    Port = 10024
    Protocol = 1
    ProtocolIPv6 = 58
    IPVersion = Id_IPv4
    PacketSize = 32
    OnReply = IdIcmpReply
    Left = 200
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 168
    object N1: TMenuItem
      Caption = #21024#38500
      ShortCut = 16452
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #28165#31354
      ShortCut = 16453
      OnClick = N2Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 272
    Top = 144
    object N3: TMenuItem
      Caption = #21024#38500
      ShortCut = 16452
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #28165#31354
      ShortCut = 16453
      OnClick = N4Click
    end
  end
end
