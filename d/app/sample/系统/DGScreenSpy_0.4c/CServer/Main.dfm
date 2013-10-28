object frmMain: TfrmMain
  Left = 192
  Top = 107
  Width = 256
  Height = 127
  Caption = 'DGScreenSpy - Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMinimized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlA: TPanel
    Left = 0
    Top = 0
    Width = 248
    Height = 22
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    object btnAbout: TSpeedButton
      Left = 4
      Top = 0
      Width = 60
      Height = 22
      Caption = '&About'
      Flat = True
      OnClick = btnAboutClick
    end
    object lblA: TLabel
      Left = 68
      Top = 5
      Width = 3
      Height = 13
    end
  end
  object mmoA: TMemo
    Left = 0
    Top = 22
    Width = 248
    Height = 78
    Align = alClient
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 1
  end
  object tmrA: TTimer
    OnTimer = tmrATimer
    Left = 152
    Top = 64
  end
  object wscksA: TWSocketServer
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalPort = '0'
    LastError = 0
    MultiThreaded = False
    MultiCast = False
    MultiCastIpTTL = 1
    ReuseAddr = False
    ComponentOptions = []
    ListenBacklog = 5
    ReqVerLow = 1
    ReqVerHigh = 1
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    KeepAliveOnOff = wsKeepAliveOff
    KeepAliveTime = 0
    KeepAliveInterval = 0
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    Banner = 'Welcome to OverByte ICS TcpSrv'
    BannerTooBusy = 'Sorry, too many clients'
    MaxClients = 0
    OnClientDisconnect = wscksAClientDisconnect
    OnClientConnect = wscksAClientConnect
    Left = 120
    Top = 64
  end
end
