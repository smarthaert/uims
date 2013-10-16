object jianpan: Tjianpan
  Left = 192
  Top = 136
  Width = 388
  Height = 362
  Caption = #38190#30424#35760#24405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 380
    Height = 332
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 80
    object N1: TMenuItem
      Caption = #21551#21160#38190#30424#35760#24405
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #32456#27490#38190#30424#35760#24405
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #26597#30475#38190#30424#35760#24405
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #28165#31354#38190#35760#24405
      OnClick = N4Click
    end
  end
end
