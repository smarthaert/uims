object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Syant Software'
  ClientHeight = 520
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 0
    Width = 953
    Height = 520
    Align = alClient
    TabOrder = 0
    OnBeforeNavigate2 = EmbeddedWB1BeforeNavigate2
    OnDocumentComplete = EmbeddedWB1DocumentComplete
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    About = ' EmbeddedWB http://bsalsa.com/'
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
    ExplicitTop = 8
    ControlData = {
      4C000000163A0000B12400000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 568
    Top = 328
  end
  object MainMenu1: TMainMenu
    Left = 576
    object ools1: TMenuItem
      Caption = 'Tools'
      object Connect123061: TMenuItem
        Caption = 'Connect 12306('#23450#31080')'
        OnClick = Connect123061Click
      end
      object C1: TMenuItem
        Caption = 'Connect 12306('#26597#31080')'
        OnClick = C1Click
      end
      object NagivateInfo1: TMenuItem
        Caption = 'Navigate Info'
        OnClick = NagivateInfo1Click
      end
      object Executecommand1: TMenuItem
        Caption = 'Execute command'
        OnClick = Executecommand1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Config1: TMenuItem
        Caption = 'Config'
        OnClick = Config1Click
      end
    end
  end
  object Timer2: TTimer
    Interval = 10
    OnTimer = Timer2Timer
    Left = 680
    Top = 280
  end
end
