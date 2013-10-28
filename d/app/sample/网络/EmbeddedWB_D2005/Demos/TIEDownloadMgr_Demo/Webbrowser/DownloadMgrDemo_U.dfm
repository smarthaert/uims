object Form1: TForm1
  Left = 269
  Top = 107
  Width = 696
  Height = 473
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 0
    Width = 688
    Height = 393
    Align = alTop
    TabOrder = 0
    DownloadOptions = [DownloadImages, DownloadVideos, DownloadBGSounds]
    UserInterfaceOptions = []
    About = 'Embedded Web Browser. http://bsalsa.com/ '
    MessagesBoxes.InternalErrMsg = False
    OnQueryService = EmbeddedWB1QueryService
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
      4C0000005E330000901A00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 312
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object edUrl: TEdit
    Left = 16
    Top = 416
    Width = 241
    Height = 21
    TabOrder = 2
    Text = 'http://www.techvanguards.com/products/eventsinkimp'
    OnKeyPress = edUrlKeyPress
  end
  object IEDownloadMgr1: TIEDownloadMgr
    Left = 408
    Top = 64
  end
end
