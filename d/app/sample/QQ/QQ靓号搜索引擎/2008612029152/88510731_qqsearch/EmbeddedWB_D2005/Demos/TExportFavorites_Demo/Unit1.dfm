object Form2: TForm2
  Left = 177
  Top = 57
  Width = 490
  Height = 473
  Caption = 'Export IE Favorites'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 379
    Width = 482
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Export Favorites'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 420
    Width = 482
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 0
    Width = 482
    Height = 379
    Align = alClient
    TabOrder = 2
    DownloadOptions = [DownloadImages, DownloadVideos, DownloadBGSounds]
    UserInterfaceOptions = []
    About = 'Embedded Web Browser. http://bsalsa.com/ '
    MessagesBoxes.InternalErrMsg = False
    PrintOptions.Margins.Left = 19.05
    PrintOptions.Margins.Right = 19.05
    PrintOptions.Margins.Top = 19.05
    PrintOptions.Margins.Bottom = 19.05
    PrintOptions.Header = '&w&bPage &p of &P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    UserAgent = 'EmbeddedWB 14.55 from: http://www.bsalsa.com/'
    ControlData = {
      4C000000D1310000112A00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object ExportFavorite1: TExportFavorite
    About = 
      'TExportFavorites by bsalsa. Help & Support: http://www.bsalsa.co' +
      'm/'
    ExploreFavFileOnComplete = True
    FavoritesPath = 'Auto'
    NarigateOnComplete = True
    StatusBar = StatusBar1
    SuccessMessage.Strings = (
      'Your favorites have been exported to successfully!')
    TargetFileName = 'newbook.htm'
    TargetPath = 'C:\'
    WebBrowser = EmbeddedWB1
    Left = 8
    Top = 8
  end
end
