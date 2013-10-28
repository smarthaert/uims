object TMyPing: TTMyPing
  Left = 204
  Top = 144
  Width = 321
  Height = 254
  Caption = '执行Ping操作'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 313
    Height = 227
    Align = alClient
    TabOrder = 3
    object StaticText1: TStaticText
      Left = 16
      Top = 16
      Width = 38
      Height = 17
      Caption = '目标IP'
      TabOrder = 0
    end
    object StaticText2: TStaticText
      Left = 16
      Top = 56
      Width = 49
      Height = 17
      Caption = 'Ping结果'
      TabOrder = 1
    end
  end
  object PingEdit: TEdit
    Left = 72
    Top = 16
    Width = 209
    Height = 21
    TabOrder = 0
    Text = '166.111.8.28'
  end
  object StatusShow: TMemo
    Left = 16
    Top = 80
    Width = 273
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object exebtn: TButton
    Left = 120
    Top = 184
    Width = 75
    Height = 25
    Caption = '执行Ping'
    TabOrder = 2
    OnClick = exebtnClick
  end
end
