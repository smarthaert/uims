object Form1: TForm1
  Left = 323
  Top = 192
  Width = 676
  Height = 480
  Caption = #22810#32447#31243#32472#22270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 14
    Top = 13
    Width = 640
    Height = 385
  end
  object Bevel1: TBevel
    Left = 14
    Top = 12
    Width = 643
    Height = 389
  end
  object btnThdDraw: TButton
    Left = 272
    Top = 414
    Width = 90
    Height = 30
    Caption = #32447#31243#32472#21046
    TabOrder = 0
    OnClick = btnThdDrawClick
  end
  object btnClean: TButton
    Left = 376
    Top = 414
    Width = 90
    Height = 30
    Caption = #25830#38500
    TabOrder = 1
    OnClick = btnCleanClick
  end
  object btnMainDraw: TButton
    Left = 168
    Top = 414
    Width = 90
    Height = 30
    Caption = #20027#32447#31243#32472#21046
    TabOrder = 2
    OnClick = btnMainDrawClick
  end
  object btnExit: TButton
    Left = 480
    Top = 414
    Width = 90
    Height = 30
    Caption = #36864#20986
    TabOrder = 3
    OnClick = btnExitClick
  end
end
