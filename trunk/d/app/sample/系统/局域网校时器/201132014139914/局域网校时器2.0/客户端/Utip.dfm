object tip: Ttip
  Left = 168
  Top = 459
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26174#31034#24403#21069#26102#38388
  ClientHeight = 165
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 274
    Height = 67
    Caption = #20114#32852#32593#26102#38047
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object STWebTime: TStaticText
      Left = 3
      Top = 13
      Width = 268
      Height = 52
      Alignment = taCenter
      AutoSize = False
      Caption = #32593#32476#26102#38047
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -53
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 68
    Width = 274
    Height = 67
    Caption = #31995#32479#26102#38047
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    object STLocalTime: TStaticText
      Left = 3
      Top = 13
      Width = 268
      Height = 52
      Alignment = taCenter
      AutoSize = False
      Caption = #26412#22320#26102#38047
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -53
      Font.Name = #40657#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object BitBtn2: TBitBtn
    Left = 196
    Top = 139
    Width = 75
    Height = 22
    Cursor = crHandPoint
    Cancel = True
    Caption = #20851#38381
    Default = True
    TabOrder = 0
    OnClick = BitBtn2Click
  end
  object Button1: TButton
    Left = 105
    Top = 139
    Width = 89
    Height = 22
    Caption = #21516#27493#26412#26426#26102#38388
    TabOrder = 3
    OnClick = Button1Click
  end
  object STD: TStaticText
    Left = 2
    Top = 145
    Width = 87
    Height = 12
    AutoSize = False
    Caption = '20090228'
    TabOrder = 4
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 224
    Top = 52
  end
end
