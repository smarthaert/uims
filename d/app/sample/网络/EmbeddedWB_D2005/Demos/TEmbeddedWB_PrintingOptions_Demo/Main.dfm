object MainFrm: TMainFrm
  Left = 178
  Top = 132
  Width = 480
  Height = 394
  Caption = 'Printing Using EmbeddedWB Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 0
    Width = 472
    Height = 340
    Align = alClient
    TabOrder = 0
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
      4C000000C8300000242300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object MainMenu1: TMainMenu
    Left = 384
    Top = 248
    object FileMenu: TMenuItem
      Caption = 'File'
      object PrintWithDlg: TMenuItem
        Caption = 'Print With Dialog'
        object Print: TMenuItem
          Caption = 'Print'
          OnClick = PrintClick
        end
        object PrintPreview: TMenuItem
          Caption = 'Print Preview'
          OnClick = PrintPreviewClick
        end
        object PrintPreviewMaximized: TMenuItem
          Caption = 'Print Preview Maxiimized'
          OnClick = PrintPreviewMaximizedClick
        end
        object PrintSetup: TMenuItem
          Caption = 'Print Setup'
          OnClick = PrintSetupClick
        end
        object PrintWithOptions: TMenuItem
          Caption = 'PrintWithOptions'
          OnClick = PrintWithOptionsClick
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object LanscapeDlg: TMenuItem
          Caption = 'Lanscape'
          OnClick = LanscapeDlgClick
        end
        object PortraitDlg: TMenuItem
          Caption = 'Portrait'
          OnClick = PortraitDlgClick
        end
      end
      object PrintWithOutDlg: TMenuItem
        Caption = 'Print Without Dialog'
        object LandscapeNoDlg: TMenuItem
          Caption = 'Landscape'
          OnClick = LandscapeNoDlgClick
        end
        object PortraiteNoDlg: TMenuItem
          Caption = 'Portraite'
          OnClick = PortraiteNoDlgClick
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit: TMenuItem
        Caption = 'Exit'
        OnClick = ExitClick
      end
    end
  end
end
