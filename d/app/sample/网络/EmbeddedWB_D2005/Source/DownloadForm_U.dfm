object DownloadForm: TDownloadForm
  Left = 300
  Top = 187
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsSingle
  Caption = 'IE & Delphi Downloadmanager Demo'
  ClientHeight = 230
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 16
    Height = 13
    Caption = 'Url:'
  end
  object Label2: TLabel
    Left = 24
    Top = 24
    Width = 45
    Height = 13
    Caption = 'Filename:'
  end
  object Label3: TLabel
    Left = 24
    Top = 184
    Width = 71
    Height = 13
    Caption = 'Estimated time:'
  end
  object Button1: TButton
    Left = 392
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 48
    Width = 425
    Height = 89
    TabOrder = 1
  end
  object ProgressBar1: TProgressBar
    Left = 26
    Top = 160
    Width = 423
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 2
  end
  object IEDownload1: TIEDownload
    TimeOut = 0
    Codepage = Ansi
    Method = Get
    Options = [Asynchronous, AsyncStorage, GetNewestVersion, NoWriteCache, PullData]
    UrlEncode = []
    Security.InheritHandle = False
    Range.RangeBegin = 0
    Range.RangeEnd = 0
    AdditionalHeader.Strings = (
      'Content-Type: application/x-www-form-urlencoded')
    UserAgent = 'Mozilla/4.0 (compatible; MSIE 6.0; Win32)'
    OnProgress = IEDownload1Progress
    OnComplete = IEDownload1Complete
    Left = 8
    Top = 120
  end
end
