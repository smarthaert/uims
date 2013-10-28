object Form1: TForm1
  Left = 241
  Top = 168
  Caption = #28120#23453'api'#27979#35797
  ClientHeight = 525
  ClientWidth = 963
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 256
    Top = 112
    Width = 510
    Height = 13
    Caption = '1'#12290#20808#28857#20987#33719#21462#25480#26435#30721#65292#20174#28120#23453#32593#24471#21040#19968#25480#26435#30721#65292#28982#21518#31896#36148#25480#26435#30721#21040#26694#65292#28982#21518#28857#20987#33719#21462#21334#20986#25968#25454#65306
  end
  object Label2: TLabel
    Left = 384
    Top = 392
    Width = 257
    Height = 19
    Caption = #31034#20363#31243#24207#21046#20316' ufo2003a@gmail.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 248
    Top = 64
    Width = 75
    Height = 25
    Caption = #33719#21462#25480#26435#30721
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 248
    Top = 137
    Width = 521
    Height = 241
    Hint = #31896#36148#25480#26435#30721#21040#36825#37324
    ParentShowHint = False
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 1
  end
  object Button2: TButton
    Left = 248
    Top = 392
    Width = 113
    Height = 25
    Caption = #33719#21462#21334#20986#25968#25454
    TabOrder = 2
    OnClick = Button2Click
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 112
    Top = 40
  end
end
