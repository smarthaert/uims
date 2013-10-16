object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = #30331#24405
  ClientHeight = 498
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 72
    Width = 36
    Height = 13
    Caption = #29992#25143#21517
  end
  object Label2: TLabel
    Left = 15
    Top = 99
    Width = 24
    Height = 13
    Caption = #23494#30721
  end
  object Label3: TLabel
    Left = 15
    Top = 45
    Width = 50
    Height = 13
    Caption = 'AppSecret'
  end
  object Label4: TLabel
    Left = 15
    Top = 18
    Width = 37
    Height = 13
    Caption = 'AppKey'
  end
  object Edit1: TEdit
    Left = 76
    Top = 69
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 76
    Top = 96
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 15
    Top = 123
    Width = 75
    Height = 25
    Caption = #30331#24405
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 109
    Top = 123
    Width = 75
    Height = 25
    Caption = #36864#20986
    TabOrder = 3
    OnClick = Button2Click
  end
  object RequestTokenButton: TButton
    Left = 221
    Top = 8
    Width = 84
    Height = 25
    Caption = 'RequestToken'
    TabOrder = 4
    OnClick = RequestTokenButtonClick
  end
  object AuthButton: TButton
    Left = 311
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Authorize'
    TabOrder = 5
    OnClick = AuthButtonClick
  end
  object RequestAccessButton: TButton
    Left = 392
    Top = 8
    Width = 89
    Height = 25
    Caption = 'RequestAccess'
    TabOrder = 6
    OnClick = RequestAccessButtonClick
  end
  object Button3: TButton
    Left = 495
    Top = 8
    Width = 90
    Height = 25
    Caption = #26174#31034#29992#25143#20449#24687
    TabOrder = 7
    OnClick = Button3Click
  end
  object EWBAuthorize: TWebBrowser
    Left = 8
    Top = 160
    Width = 577
    Height = 321
    TabOrder = 8
    ControlData = {
      4C000000A23B00002D2100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Edit3: TEdit
    Left = 76
    Top = 42
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object Edit4: TEdit
    Left = 76
    Top = 15
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 607
    Top = 8
  end
end
