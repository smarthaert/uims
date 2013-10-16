object VpnForm: TVpnForm
  Left = 381
  Top = 189
  Width = 413
  Height = 125
  BorderIcons = [biSystemMenu]
  Caption = 'VPN'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 58
    Height = 13
    Caption = #26381#21153#22120'IP'#65306
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 61
    Height = 13
    Caption = 'VPN'#29992#25143#21517':'
  end
  object Label3: TLabel
    Left = 208
    Top = 37
    Width = 27
    Height = 13
    Caption = #23494#30721':'
  end
  object Button1: TButton
    Left = 56
    Top = 64
    Width = 113
    Height = 25
    Caption = #20135#29983'VPN'#24182#36830#25509
    TabOrder = 0
    OnClick = Button1Click
  end
  object ServerIPEd: TEdit
    Left = 72
    Top = 8
    Width = 121
    Height = 21
    ImeName = #25340#38899#21152#21152
    TabOrder = 1
  end
  object UserEd: TEdit
    Left = 72
    Top = 32
    Width = 121
    Height = 21
    ImeName = #25340#38899#21152#21152
    TabOrder = 2
  end
  object PwdEd: TEdit
    Left = 240
    Top = 32
    Width = 137
    Height = 21
    ImeName = #25340#38899#21152#21152
    PasswordChar = '*'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 216
    Top = 64
    Width = 113
    Height = 25
    Caption = #26029#24320'VPN'#36830#25509
    TabOrder = 4
    OnClick = Button2Click
  end
  object DialUp: TDialUp
    DialMode = dmAsync
    Language = English
    OnNotConnected = DialUpNotConnected
    OnError = DialUpError
    OnActiveConnection = DialUpActiveConnection
    Left = 288
  end
end
