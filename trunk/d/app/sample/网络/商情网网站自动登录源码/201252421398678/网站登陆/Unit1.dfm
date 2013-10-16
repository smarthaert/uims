object Form1: TForm1
  Left = 264
  Top = 86
  Width = 707
  Height = 613
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 272
    Top = 8
    Width = 57
    Height = 25
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = #30331#38470
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Caption = #39564#35777#30721
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 40
    Width = 153
    Height = 21
    TabOrder = 2
    Text = 'xiaoding'
  end
  object Edit2: TEdit
    Left = 168
    Top = 40
    Width = 89
    Height = 21
    TabOrder = 3
    Text = '278586293'
  end
  object Edit3: TEdit
    Left = 168
    Top = 10
    Width = 89
    Height = 21
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 8
    Top = 64
    Width = 689
    Height = 513
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object Button3: TButton
    Left = 344
    Top = 8
    Width = 75
    Height = 25
    Caption = #33719#21462'COOK'
    TabOrder = 6
    OnClick = Button3Click
  end
  object aIdHTTP: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 272
    Top = 32
  end
  object IdCookieManager1: TIdCookieManager
    Left = 304
    Top = 32
  end
end
