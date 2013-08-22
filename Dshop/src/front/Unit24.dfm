object CF: TCF
  Left = 637
  Top = 389
  BorderStyle = bsNone
  Caption = #30913#21345#32467#31639
  ClientHeight = 134
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 418
    Height = 93
    Align = alClient
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 0
    object Label4: TLabel
      Left = 43
      Top = 32
      Width = 70
      Height = 20
      Caption = #25286#20998#25968':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 203
      Top = 32
      Width = 50
      Height = 20
      Caption = #31867#22411':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object RzEdit1: TRzEdit
      Left = 115
      Top = 28
      Width = 77
      Height = 28
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      FrameColor = clWhite
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyDown = RzEdit1KeyDown
    end
    object ComboBox1: TComboBox
      Left = 256
      Top = 29
      Width = 89
      Height = 27
      Color = clBlack
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ItemHeight = 19
      ParentFont = False
      TabOrder = 1
      Text = #36864#36135
      OnKeyDown = RzEdit1KeyDown
      Items.Strings = (
        #36864#36135
        #32500#20462
        '-')
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = #35760'  '#24405'  '#25286'  '#20998
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = #20223#23435'_GB2312'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object RzFormShape1: TRzFormShape
      Left = 2
      Top = 2
      Width = 414
      Height = 37
    end
  end
  object ADOQuerySQL: TADOQuery
    Connection = Main.ADOConnection1
    Parameters = <>
    Left = 8
    Top = 8
  end
end
