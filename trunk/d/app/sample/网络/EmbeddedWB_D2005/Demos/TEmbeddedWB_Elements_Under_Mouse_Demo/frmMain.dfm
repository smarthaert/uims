object Form2: TForm2
  Left = 233
  Top = 29
  Caption = 'Elements Demo by bsalsa'
  ClientHeight = 515
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 32
    Width = 521
    Height = 288
    Align = alClient
    TabOrder = 0
    About = 'Embedded Web Browser. http://bsalsa.com/ '
    DownloadOptions = [DownloadImages, DownloadVideos, DownloadBGSounds]
    MessagesBoxes.InternalErrMsg = False
    UserInterfaceOptions = []
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
    ControlData = {
      4C000000E2330000021C00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 521
    Height = 195
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 37
      Width = 15
      Height = 13
      Caption = 'ID:'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 55
      Height = 13
      Caption = 'Inner Text:'
    end
    object Label4: TLabel
      Left = 8
      Top = 120
      Width = 59
      Height = 13
      Caption = 'Class Name:'
    end
    object Label5: TLabel
      Left = 8
      Top = 147
      Width = 28
      Height = 13
      Caption = 'HRef:'
    end
    object Label6: TLabel
      Left = 8
      Top = 6
      Width = 22
      Height = 13
      Caption = 'Tag:'
    end
    object Label3: TLabel
      Left = 8
      Top = 96
      Width = 54
      Height = 13
      Caption = 'Inner Html:'
    end
    object Label7: TLabel
      Left = 8
      Top = 176
      Width = 34
      Height = 13
      Caption = 'Frame:'
    end
    object edtTag: TEdit
      Left = 88
      Top = 6
      Width = 409
      Height = 21
      TabOrder = 0
    end
    object edtID: TEdit
      Left = 88
      Top = 33
      Width = 409
      Height = 21
      TabOrder = 1
    end
    object edtInnerText: TEdit
      Left = 88
      Top = 60
      Width = 409
      Height = 21
      TabOrder = 2
    end
    object edtInnerHtml: TEdit
      Left = 88
      Top = 87
      Width = 409
      Height = 21
      TabOrder = 3
    end
    object edtHref: TEdit
      Left = 88
      Top = 141
      Width = 409
      Height = 21
      TabOrder = 4
    end
    object edtClassName: TEdit
      Left = 88
      Top = 114
      Width = 409
      Height = 21
      TabOrder = 5
    end
    object edtFrame: TEdit
      Left = 88
      Top = 168
      Width = 409
      Height = 21
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 32
    Align = alTop
    TabOrder = 2
    object Button1: TButton
      Left = 464
      Top = 2
      Width = 33
      Height = 25
      Caption = 'Go'
      TabOrder = 0
      OnClick = Button1Click
    end
    object IEAddress1: TIEAddress
      Left = 8
      Top = 4
      Width = 450
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      ButtonColor = clBlack
      ButtonPressedColor = clBlack
      IconLeft = 4
      IconTop = 3
      ItemHeight = 16
      ParentBiDiMode = True
      TabOrder = 1
    end
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 32
    Top = 64
  end
end
