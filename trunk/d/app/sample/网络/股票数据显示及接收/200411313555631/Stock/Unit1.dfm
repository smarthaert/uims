object Form1: TForm1
  Left = 298
  Top = 121
  Width = 415
  Height = 368
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 33
    Width = 407
    Height = 301
    Align = alClient
    Color = clWhite
    ColCount = 12
    FixedCols = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 407
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clBlack
    TabOrder = 1
    object Button1: TButton
      Left = 204
      Top = 4
      Width = 75
      Height = 17
      Caption = #25509#25910#25968#25454
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 296
      Top = 4
      Width = 75
      Height = 17
      Caption = #20851#38381#25509#25910
      TabOrder = 1
      OnClick = Button2Click
    end
    object Stockrec1: TStockrec
      Left = 40
      Top = 8
      Width = 100
      Height = 17
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 116
    Top = 212
  end
end
