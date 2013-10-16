object Form1: TForm1
  Left = 440
  Top = 219
  Caption = 'Download Demo'
  ClientHeight = 514
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 495
    Width = 623
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 200
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 41
    Align = alTop
    TabOrder = 1
    object btnStart: TButton
      Left = 216
      Top = 15
      Width = 115
      Height = 21
      Caption = 'Start Download'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 337
      Top = 14
      Width = 112
      Height = 21
      Caption = 'btnStop'
      Enabled = False
      TabOrder = 1
      OnClick = btnStopClick
    end
    object IEAddress1: TIEAddress
      Left = 8
      Top = 13
      Width = 202
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      DefaultProtocol = 'http://'
      BorderColor = clInactiveCaptionText
      ArrowColor = clNavy
      ButtonColor = clSkyBlue
      ButtonPressedColor = clInactiveCaptionText
      FileOptions = []
      IconLeft = 4
      IconTop = 3
      Themes = tmXP
      BiDiMode = bdLeftToRight
      ItemHeight = 16
      ParentBiDiMode = False
      TabOrder = 2
    end
    object ProgressBar1: TProgressBar
      Left = 455
      Top = 13
      Width = 150
      Height = 17
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 193
    Height = 314
    Align = alLeft
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 21
      Height = 13
      Caption = 'Info:'
    end
    object Label2: TLabel
      Left = 8
      Top = 144
      Width = 75
      Height = 13
      Caption = 'Preview stream:'
    end
    object memo1: TMemo
      Left = 4
      Top = 25
      Width = 175
      Height = 113
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object memo2: TMemo
      Left = 4
      Top = 163
      Width = 183
      Height = 142
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 355
    Width = 623
    Height = 140
    Align = alBottom
    Caption = 'Panel3'
    TabOrder = 3
    object ListView: TListView
      Left = 1
      Top = 1
      Width = 621
      Height = 138
      Align = alClient
      Columns = <
        item
          Caption = 'URL'
          Width = 160
        end
        item
          Caption = 'Speed'
          Width = 75
        end
        item
          Caption = 'Downloaded'
          Width = 75
        end
        item
          Caption = 'Remaining Time'
          Width = 90
        end
        item
          Caption = 'Elapsed Time'
          Width = 90
        end
        item
          Caption = 'Status'
          Width = 150
        end>
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object Panel4: TPanel
    Left = 193
    Top = 41
    Width = 430
    Height = 314
    Align = alClient
    Caption = 'Panel4'
    TabOrder = 4
    object EmbeddedWB1: TEmbeddedWB
      Left = 1
      Top = 1
      Width = 428
      Height = 312
      Align = alClient
      TabOrder = 0
      DownloadOptions = [DownloadImages, DownloadVideos, DownloadBGSounds]
      UserInterfaceOptions = []
      About = 'Embedded Web Browser. http://bsalsa.com/ '
      MessagesBoxes.InternalErrMsg = False
      PrintOptions.Margins.Left = 19.050000000000000000
      PrintOptions.Margins.Right = 19.050000000000000000
      PrintOptions.Margins.Top = 19.050000000000000000
      PrintOptions.Margins.Bottom = 19.050000000000000000
      PrintOptions.Header = '&w&bPage &p of &P'
      PrintOptions.HTMLHeader.Strings = (
        '<HTML></HTML>')
      PrintOptions.Footer = '&u&b&d'
      PrintOptions.Orientation = poPortrait
      RightClickMenu.DisableAllMenus = False
      RightClickShortCuts.DisableOpenInNewWindow = True
      RightClickShortCuts.DisableOpenLink = True
      UserAgent = 'EmbeddedWB 14.56 from: http://www.bsalsa.com/'
      ExplicitLeft = 0
      ExplicitTop = 2
      ControlData = {
        4C000000852200000B1D00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object IEDownload1: TIEDownload
    TimeOut = 5000
    Codepage = Ansi
    DefaultProtocol = 'http://'
    Method = Get
    Options = [AsyncStorage, GetNewestVersion, NoWriteCache, PullData]
    UrlEncode = []
    Security.InheritHandle = False
    Range.RangeBegin = 0
    Range.RangeEnd = 0
    AdditionalHeader.Strings = (
      'Content-Type: application/x-www-form-urlencoded')
    UserAgent = 'IEDownload  14.56  From: http://bsalsa.com/ '
    OnBusyStateChange = IEDownload1BusyStateChange
    OnErrorText = IEDownload1ErrorText
    OnRespondText = IEDownload1RespondText
    OnStatusText = IEDownload1StatusText
    OnProgress = IEDownload1Progress
    OnBeginningTransaction = IEDownload1BeginningTransaction
    OnComplete = IEDownload1Complete
    OnData = IEDownload1Data
    Left = 240
    Top = 320
  end
end
