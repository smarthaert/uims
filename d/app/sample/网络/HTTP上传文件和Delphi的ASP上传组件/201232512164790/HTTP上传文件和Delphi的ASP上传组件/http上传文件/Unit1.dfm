object Form1: TForm1
  Left = 192
  Top = 107
  Width = 696
  Height = 480
  Caption = 'http'#19978#20256#25991#20214
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 368
    Top = 8
    Width = 56
    Height = 14
    Caption = #36873#25321#25991#20214
  end
  object SpeedButton1: TSpeedButton
    Left = 616
    Top = 3
    Width = 51
    Height = 22
    Caption = #25991#20214
    OnClick = SpeedButton1Click
  end
  object Button1: TButton
    Left = 288
    Top = 4
    Width = 75
    Height = 25
    Caption = #19978#20256
    TabOrder = 0
    OnClick = Button1Click
  end
  object memoHTML: TMemo
    Left = 0
    Top = 40
    Width = 688
    Height = 217
    ImeName = #26497#21697#20116#31508#36755#20837#27861'5.0'
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 0
    Top = 272
    Width = 681
    Height = 153
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object cbURL: TComboBox
    Left = 8
    Top = 8
    Width = 273
    Height = 22
    ImeName = #26497#21697#20116#31508#36755#20837#27861'5.0'
    ItemHeight = 14
    TabOrder = 3
    Items.Strings = (
      'http://localhost/up/demo.asp')
  end
  object edit1: TEdit
    Left = 429
    Top = 4
    Width = 180
    Height = 22
    ReadOnly = True
    TabOrder = 4
  end
  object HTTP: TIdHTTP
    RecvBufferSize = 1024
    HandleRedirects = True
    ProtocolVersion = pv1_0
    Request.Accept = 'text/html, */*'
    Request.ContentLength = 0
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.Password = '1'
    Request.ProxyPort = 8080
    Request.ProxyServer = '212.56.15.196'
    Request.ProxyUsername = '1'
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Left = 64
    Top = 64
  end
  object LogDebug: TIdLogDebug
    Active = True
    LogTime = False
    OnLogItem = LogDebugLogItem
    Target = ltDebugOutput
    Left = 96
    Top = 64
  end
  object OpenDialog1: TOpenDialog
    Left = 400
    Top = 56
  end
end
