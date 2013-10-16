object Form1: TForm1
  Left = 405
  Top = 106
  Width = 484
  Height = 435
  Caption = 'Open In A New Window Demo (SDI)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 30
    Width = 476
    Height = 378
    Align = alClient
    TabOrder = 0
    OnNewWindow2 = EmbeddedWB1NewWindow2
    OnVisible = EmbeddedWB1Visible
    OnAddressBar = EmbeddedWB1AddressBar
    OnWindowSetResizable = EmbeddedWB1WindowSetResizable
    OnWindowSetLeft = EmbeddedWB1WindowSetLeft
    OnWindowSetTop = EmbeddedWB1WindowSetTop
    OnWindowSetWidth = EmbeddedWB1WindowSetWidth
    OnWindowSetHeight = EmbeddedWB1WindowSetHeight
    DownloadOptions = [DownloadImages, DownloadVideos, DownloadBGSounds]
    UserInterfaceOptions = []
    About = 'Embedded Web Browser. http://bsalsa.com/ '
    MessagesBoxes.InternalErrMsg = False
    OnMove = EmbeddedWB1Move
    OnMoveBy = EmbeddedWB1MoveBy
    OnResize = EmbeddedWB1Resize
    OnResizeBy = EmbeddedWB1ResizeBy
    PrintOptions.Margins.Left = 19.050000000000000000
    PrintOptions.Margins.Right = 19.050000000000000000
    PrintOptions.Margins.Top = 19.050000000000000000
    PrintOptions.Margins.Bottom = 19.050000000000000000
    PrintOptions.Header = '&w&bPage &p of &P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    UserAgent = 'EmbeddedWB 14,52 from: http://www.bsalsa.com/'
    VisualEffects.TextSize = 0
    ControlData = {
      4C00000032310000722900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object pnlAddressBar: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 30
    Align = alTop
    TabOrder = 1
    object edUrl: TEdit
      Left = 8
      Top = 4
      Width = 417
      Height = 21
      TabOrder = 0
      Text = 'http://devitco.de/coint/navtest'
      OnKeyPress = edUrlKeyPress
    end
    object btnGo: TButton
      Left = 432
      Top = 4
      Width = 33
      Height = 21
      Caption = 'Go'
      TabOrder = 1
      OnClick = btnGoClick
    end
  end
end
