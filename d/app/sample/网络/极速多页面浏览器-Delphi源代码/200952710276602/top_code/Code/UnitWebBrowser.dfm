object FormWebBrowser: TFormWebBrowser
  Left = 493
  Top = 195
  Align = alClient
  BorderStyle = bsNone
  Caption = #31354#30333#39029
  ClientHeight = 256
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 56
    Top = 32
    Width = 265
    Height = 153
    TabOrder = 0
    Visible = False
    object WebBrowser2: TWebBrowser
      Left = 32
      Top = 40
      Width = 89
      Height = 65
      TabOrder = 0
      ControlData = {
        4C00000033090000B80600000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object WebBrowser1: TEmbeddedWB
      Left = 152
      Top = 32
      Width = 70
      Height = 84
      TabOrder = 1
      OnStatusTextChange = WebBrowser1StatusTextChange
      OnProgressChange = WebBrowser1ProgressChange
      OnCommandStateChange = WebBrowser1CommandStateChange
      OnDownloadBegin = WebBrowser1DownloadBegin
      OnDownloadComplete = WebBrowser1DownloadComplete
      OnTitleChange = WebBrowser1TitleChange
      OnBeforeNavigate2 = WebBrowser1BeforeNavigate2
      OnNewWindow2 = WebBrowser1NewWindow2
      OnNavigateComplete2 = WebBrowser1NavigateComplete2
      OnDocumentComplete = WebBrowser1DocumentComplete
      DownloadOptions = [DLCTL_DLIMAGES, DLCTL_VIDEOS, DLCTL_BGSOUNDS]
      UserInterfaceOptions = []
      OnScriptError = WebBrowser1ScriptError
      DisableRightClickMenu = False
      EnableDDE = False
      fpExceptions = False
      HideBorders = False
      HideScrollBars = False
      OnCloseQuery = WebBrowser1CloseQuery
      OnGetExternal = WebBrowser1GetExternal
      OnShowContextMenu = WebBrowser1ShowContextMenu
      PrintOptions.Margins.Left = 19.050000000000000000
      PrintOptions.Margins.Right = 19.050000000000000000
      PrintOptions.Margins.Top = 19.050000000000000000
      PrintOptions.Margins.Bottom = 19.050000000000000000
      PrintOptions.Header = '&w&bPage &p of &P'
      PrintOptions.HTMLHeader.Strings = (
        '<HTML></HTML>')
      PrintOptions.Footer = '&u&b&d'
      PrintOptions.Orientation = poPortrait
      ReplaceCaption = False
      ControlData = {
        4C000000EC2E0000021F00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E12620A000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
