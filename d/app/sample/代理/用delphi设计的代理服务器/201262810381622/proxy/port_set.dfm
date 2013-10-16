object port_setup: Tport_setup
  Left = 276
  Top = 162
  Width = 290
  Height = 95
  Caption = '端口号设置(请尽量用大于1000的端口)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 126
    Height = 14
    Caption = '请输入欲设端口号：'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 141
    Top = 4
    Width = 97
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 40
    Width = 75
    Height = 25
    Caption = '确 定'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 40
    Width = 75
    Height = 25
    Caption = '默 认'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 192
    Top = 40
    Width = 75
    Height = 25
    Caption = '关 闭'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button3Click
  end
end
