object Form1: TForm1
  Left = 224
  Top = 71
  AutoScroll = False
  Caption = 'do r'
  ClientHeight = 445
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox6: TGroupBox
    Left = 5
    Top = 3
    Width = 532
    Height = 93
    TabOrder = 0
    object Label1: TLabel
      Left = 312
      Top = 16
      Width = 48
      Height = 13
      Caption = #29992#25143#21517#65306
    end
    object Label2: TLabel
      Left = 421
      Top = 16
      Width = 36
      Height = 13
      Caption = #23494#30721#65306
    end
    object Label3: TLabel
      Left = 8
      Top = 43
      Width = 36
      Height = 13
      Caption = #20027#39064#65306
    end
    object Label4: TLabel
      Left = 8
      Top = 67
      Width = 36
      Height = 13
      Caption = #20869#23481#65306
    end
    object Label5: TLabel
      Left = 384
      Top = 43
      Width = 73
      Height = 13
      Caption = 'FORMHASH'#65306
    end
    object Button2: TButton
      Left = 6
      Top = 11
      Width = 65
      Height = 25
      Caption = #29992#25143#30331#24405
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 73
      Top = 11
      Width = 75
      Height = 25
      Caption = #24320#21047
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button6: TButton
      Left = 152
      Top = 11
      Width = 41
      Height = 25
      Caption = #26242#20572
      TabOrder = 2
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 197
      Top = 11
      Width = 41
      Height = 25
      Caption = #21551#21160
      TabOrder = 3
      OnClick = Button7Click
    end
    object Edit1: TEdit
      Left = 360
      Top = 13
      Width = 57
      Height = 21
      TabOrder = 4
      Text = 'dhtfish1'
    end
    object Edit2: TEdit
      Left = 456
      Top = 13
      Width = 70
      Height = 21
      TabOrder = 5
      Text = 'fangfish1'
    end
    object Edit3: TEdit
      Left = 43
      Top = 40
      Width = 334
      Height = 21
      TabOrder = 6
    end
    object Edit4: TEdit
      Left = 42
      Top = 64
      Width = 415
      Height = 21
      TabOrder = 7
    end
    object Button3: TButton
      Left = 240
      Top = 11
      Width = 62
      Height = 25
      Caption = #20445#23384
      TabOrder = 8
      OnClick = Button3Click
    end
    object Edit5: TEdit
      Left = 456
      Top = 40
      Width = 69
      Height = 21
      TabOrder = 9
      Text = '7e19913d'
    end
    object Button4: TButton
      Left = 460
      Top = 63
      Width = 66
      Height = 25
      Caption = #27880#20876
      TabOrder = 10
      OnClick = Button4Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 5
    Top = 96
    Width = 532
    Height = 346
    TabOrder = 1
    object Memo1: TMemo
      Left = 4
      Top = 8
      Width = 525
      Height = 334
      Color = clNone
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 560
    Top = 16
  end
  object IdHTTP1: TIdHTTP
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
    Left = 354
    Top = 86
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 382
    Top = 94
  end
  object Timer1: TTimer
    Interval = 300000
    OnTimer = Timer1Timer
    Left = 120
    Top = 67
  end
end
