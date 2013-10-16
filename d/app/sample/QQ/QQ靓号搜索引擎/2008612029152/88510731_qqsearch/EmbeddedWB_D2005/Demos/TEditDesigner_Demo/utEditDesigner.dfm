object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 414
  ClientWidth = 644
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
    Top = 226
    Width = 644
    Height = 150
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 6
      Width = 41
      Height = 13
      Caption = 'Doc Info'
    end
    object Label2: TLabel
      Left = 216
      Top = 6
      Width = 51
      Height = 13
      Caption = 'Inner Text'
    end
    object Label3: TLabel
      Left = 423
      Top = 6
      Width = 50
      Height = 13
      Caption = 'Inner Html'
    end
    object Memo1: TMemo
      Left = 0
      Top = 22
      Width = 210
      Height = 122
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object Memo2: TMemo
      Left = 216
      Top = 22
      Width = 201
      Height = 122
      Lines.Strings = (
        'Memo2')
      TabOrder = 1
    end
    object Memo3: TMemo
      Left = 423
      Top = 22
      Width = 221
      Height = 123
      Lines.Strings = (
        'Memo3')
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 33
    Align = alTop
    TabOrder = 1
    object btnGo: TButton
      Left = 351
      Top = 8
      Width = 75
      Height = 19
      Caption = 'Go'
      TabOrder = 0
      OnClick = btnGoClick
    end
    object IEAddress1: TIEAddress
      Left = 7
      Top = 8
      Width = 338
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      IconLeft = 4
      IconTop = 3
      ItemHeight = 16
      ParentBiDiMode = True
      TabOrder = 1
    end
    object btnRemoveDesigner: TButton
      Left = 536
      Top = 8
      Width = 97
      Height = 19
      Caption = 'Remove Designer'
      Enabled = False
      TabOrder = 2
      OnClick = btnRemoveDesignerClick
    end
    object btnConnectDesigner: TButton
      Left = 432
      Top = 8
      Width = 98
      Height = 19
      Caption = 'Connect Designer'
      TabOrder = 3
      OnClick = btnConnectDesignerClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 376
    Width = 644
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 70
      end
      item
        Width = 100
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 90
      end
      item
        Width = 90
      end
      item
        Width = 70
      end
      item
        Width = 70
      end>
  end
  object StatusBar2: TStatusBar
    Left = 0
    Top = 395
    Width = 644
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 70
      end
      item
        Width = 70
      end
      item
        Width = 70
      end
      item
        Width = 70
      end
      item
        Width = 70
      end
      item
        Width = 70
      end>
  end
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 33
    Width = 644
    Height = 193
    Align = alClient
    TabOrder = 4
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
    UserAgent = 'Mozilla/4.0(Compatible-EmbeddedWB 14.59 http://bsalsa.com/ '
    ExplicitTop = 0
    ExplicitWidth = 652
    ExplicitHeight = 448
    ControlData = {
      4C0000008F420000651500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object EditDesigner1: TEditDesigner
    About = 'TEditDesigner - from http://www.bsalsa.com/'
    EmbeddedWB = EmbeddedWB1
    OnPreDrag = EditDesigner1PreDrag
    OnError = EditDesigner1Error
    OnInnerText = EditDesigner1InnerText
    OnInnerHtml = EditDesigner1InnerHtml
    OnKeyPress = EditDesigner1KeyPress
    OnKeyState = EditDesigner1KeyState
    OnPreHandle = EditDesigner1PreHandleEvent
    OnPostHandle = EditDesigner1PostHandleEvent
    OnPostEditorNotify = EditDesigner1PostEditorEventNotify
    OnTranslateAccelerator = EditDesigner1TranslateAccelerator
    OnMousePosition = EditDesigner1MousePosition
    OnMouseButton = EditDesigner1MouseButton
    OnEvtDispId = EditDesigner1EvtDispId
    OnSnapRect = EditDesigner1SnapRect
    OnType_ = EditDesigner1Type_
    OnToString = EditDesigner1ToString
    OnTagName = EditDesigner1TagName
    Top = 128
  end
end
