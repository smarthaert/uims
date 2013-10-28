object Form1: TForm1
  Left = 302
  Top = 127
  Width = 452
  Height = 487
  Caption = 'Form1'
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
    Width = 444
    Height = 433
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
      4C000000072C0000732600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object MainMenu1: TMainMenu
    Left = 280
    Top = 152
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object RightClickMenu1: TMenuItem
      Caption = '   RightClickMenu'
      object EnableAllMenus: TMenuItem
        Caption = 'Enable All Menus'
        GroupIndex = 1
        RadioItem = True
        OnClick = EnableAllMenusClick
      end
      object N3: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object DisableAllMenu1: TMenuItem
        Caption = 'Diasble All Menus'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableAllMenu1Click
      end
      object DisableDefaultMenu1: TMenuItem
        Caption = 'Disable Default Menu (Document)'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableDefaultMenu1Click
      end
      object DisableImagesMenu1: TMenuItem
        Caption = 'Disable Images Menu'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableImagesMenu1Click
      end
      object DisableTable: TMenuItem
        Caption = 'Disable Table Menu'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableTableClick
      end
      object DisableSelectedText1: TMenuItem
        Caption = 'Disable Selected Text Menu'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableSelectedText1Click
      end
      object DisableControlsMenu1: TMenuItem
        Caption = 'Disable Controls Menu (TEdit..)'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableControlsMenu1Click
      end
      object DisableAnchorMenu1: TMenuItem
        Caption = 'Disable Anchor Menu (Links..)'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableAnchorMenu1Click
      end
      object DisableUnknownMenu1: TMenuItem
        Caption = 'Disable Unknown Menu'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableUnknownMenu1Click
      end
      object DisableImgDynSrcMenu1: TMenuItem
        Caption = 'Disable ImgDynSrc Menu'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableImgDynSrcMenu1Click
      end
      object DisableDebugMenu1: TMenuItem
        Caption = 'Disable Debug Menu'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableDebugMenu1Click
      end
      object DisableImageArtMenu1: TMenuItem
        Caption = 'Disable Image Art Menu'
        GroupIndex = 1
        RadioItem = True
        OnClick = DisableImageArtMenu1Click
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object N4: TMenuItem
        Caption = '------------------------'
        GroupIndex = 1
      end
      object Note1: TMenuItem
        Caption = 'NOTE: You can disable any menu item.'
        GroupIndex = 1
      end
      object Note2: TMenuItem
        Caption = 'See the source code for details!'
        GroupIndex = 1
      end
      object N2: TMenuItem
        Caption = '------------------------'
        GroupIndex = 1
      end
      object DisableViewSource1: TMenuItem
        Caption = 'Disable View Source'
        GroupIndex = 1
        OnClick = DisableViewSource1Click
      end
      object DisableOpenInANewWindow1: TMenuItem
        Caption = 'Disable Open In A New Window'
        GroupIndex = 1
        OnClick = DisableOpenInANewWindow1Click
      end
      object DisableOpenLink1: TMenuItem
        Caption = 'Disable Open Link'
        GroupIndex = 1
        OnClick = DisableOpenLink1Click
      end
    end
    object Shortcuts1: TMenuItem
      Caption = '  Shortcuts'
      object DisableCtrlN1: TMenuItem
        Caption = 'Disable Ctrl+N'
        OnClick = DisableCtrlN1Click
      end
    end
  end
end
