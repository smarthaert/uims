object Form1: TForm1
  Left = 209
  Top = 35
  Caption = 'Form1'
  ClientHeight = 396
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlAddressBar: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      562
      41)
    object Button1: TButton
      Left = 512
      Top = 13
      Width = 41
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'GO'
      TabOrder = 0
      OnClick = Button1Click
    end
    object IEAddress1: TIEAddress
      Left = 1
      Top = 13
      Width = 505
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      IconLeft = 4
      IconTop = 3
      ItemHeight = 16
      ParentBiDiMode = True
      ShowFavicon = True
      TabOrder = 1
      Themes = tmXP
      UseAppIcon = True
    end
  end
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 41
    Width = 562
    Height = 355
    Align = alClient
    TabOrder = 1
    OnNewWindow2 = EmbeddedWB1NewWindow2
    OnVisible = EmbeddedWB1Visible
    OnAddressBar = EmbeddedWB1AddressBar
    OnWindowSetResizable = EmbeddedWB1WindowSetResizable
    OnWindowSetLeft = EmbeddedWB1WindowSetLeft
    OnWindowSetTop = EmbeddedWB1WindowSetTop
    OnWindowSetWidth = EmbeddedWB1WindowSetWidth
    OnWindowSetHeight = EmbeddedWB1WindowSetHeight
    OnNewWindow3 = EmbeddedWB1NewWindow3
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
    UserAgent = 'Mozilla/4.0(Compatible-EmbeddedWB 14.56 http://bsalsa.com/ '
    ExplicitLeft = 1
    ControlData = {
      4C000000163A0000B12400000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
