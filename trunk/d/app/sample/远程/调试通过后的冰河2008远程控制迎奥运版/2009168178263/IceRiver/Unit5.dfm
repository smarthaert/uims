object shipin: Tshipin
  Left = 192
  Top = 136
  Width = 293
  Height = 344
  Caption = #36828#31243#35270#39057#26597#30475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 285
    Height = 255
    Align = alClient
    Color = clBlack
    TabOrder = 0
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 283
      Height = 253
      Align = alClient
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 296
    Width = 285
    Height = 18
    Panels = <>
  end
  object Panel2: TPanel
    Left = 0
    Top = 255
    Width = 285
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Button2: TButton
      Left = 158
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = #20572#27490
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 40
      Top = 8
      Width = 75
      Height = 25
      Caption = #24320#22987
      Default = True
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
