object chuanko: Tchuanko
  Left = 192
  Top = 136
  Width = 490
  Height = 322
  Caption = #31383#21475#31649#29702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 482
    Height = 292
    Align = alClient
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 112
    object N1: TMenuItem
      Caption = #26174#31034#31383#21475
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #38544#34255#31383#21475
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #20851#38381#31383#21475
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #21047#26032
      OnClick = N4Click
    end
  end
end
