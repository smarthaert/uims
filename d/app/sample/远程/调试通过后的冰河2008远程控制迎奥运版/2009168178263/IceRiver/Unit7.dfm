object jincheng: Tjincheng
  Left = 204
  Top = 145
  Width = 565
  Height = 373
  Caption = #36827#31243#31649#29702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 557
    Height = 343
    Align = alClient
    Columns = <
      item
        Caption = #36827#31243#21517
        Width = 150
      end
      item
        Caption = #36827#31243'ID'
        Width = 80
      end
      item
        Caption = #32447#31243#25968
        Width = 80
      end
      item
        Caption = #20248#20808#32423
        Width = 80
      end
      item
        Caption = #29238#36827#31243'ID'
        Width = 80
      end>
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
  end
  object PopupMenu1: TPopupMenu
    Left = 192
    Top = 176
    object N1: TMenuItem
      Caption = #32456#27490#36827#31243
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21047#26032
      OnClick = N2Click
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 224
    Top = 176
  end
end
