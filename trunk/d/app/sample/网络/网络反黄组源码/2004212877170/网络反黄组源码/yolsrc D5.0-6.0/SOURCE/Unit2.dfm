object password: Tpassword
  Left = 257
  Top = 213
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '身份确认'
  ClientHeight = 77
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 13
    Width = 120
    Height = 12
    Caption = '请正确输入你的密码：'
  end
  object passon: TFlatEdit
    Left = 16
    Top = 41
    Width = 193
    Height = 18
    ColorFlat = clBtnFace
    ParentColor = True
    PasswordChar = '*'
    TabOrder = 0
    OnKeyPress = passonKeyPress
  end
  object FlatButton1: TFlatButton
    Left = 232
    Top = 8
    Width = 49
    Height = 17
    Caption = '确定'
    TabOrder = 1
    OnClick = FlatButton1Click
  end
  object FlatButton2: TFlatButton
    Left = 232
    Top = 41
    Width = 49
    Height = 18
    Caption = '取消'
    TabOrder = 2
    OnClick = FlatButton2Click
  end
end
