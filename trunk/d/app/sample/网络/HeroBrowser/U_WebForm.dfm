object FrmWeb: TFrmWeb
  Left = 252
  Top = 189
  Width = 696
  Height = 480
  Caption = 'about:blank'
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object WebBrowser: TEmbeddedWB
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    Align = alClient
    TabOrder = 0
    OnStatusTextChange = WebBrowserStatusTextChange
    OnProgressChange = WebBrowserProgressChange
    OnCommandStateChange = WebBrowserCommandStateChange
    OnBeforeNavigate2 = WebBrowserBeforeNavigate2
    OnNewWindow2 = WebBrowserNewWindow2
    OnNavigateComplete2 = WebBrowserNavigateComplete2
    OnDocumentComplete = WebBrowserDocumentComplete
    DownloadOptions = [DLCTL_DLIMAGES, DLCTL_VIDEOS, DLCTL_BGSOUNDS]
    UserInterfaceOptions = [FLAT_SCROLLBAR]
    OnTranslateAccelerator = WebBrowserTranslateAccelerator
    OnGetDropTarget = WebBrowserGetDropTarget
    PrintOptions.Margins.Left = 19.050000000000000000
    PrintOptions.Margins.Right = 19.050000000000000000
    PrintOptions.Margins.Top = 19.050000000000000000
    PrintOptions.Margins.Bottom = 19.050000000000000000
    PrintOptions.Header = '&w&b'#39029#30721#65292'&p/&P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    ReplaceCaption = True
    HideBorders = False
    HideScrollBars = False
    DisableRightClickMenu = False
    EnableDDE = False
    fpExceptions = True
    ControlData = {
      4C0000001B470000D22E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
