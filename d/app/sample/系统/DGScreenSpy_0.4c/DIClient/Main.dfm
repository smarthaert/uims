object frmMain: TfrmMain
  Left = 308
  Top = 224
  Width = 400
  Height = 280
  Caption = 'DGScreenSpy - Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvA: TListView
    Left = 0
    Top = 22
    Width = 392
    Height = 231
    Align = alClient
    Columns = <
      item
        Caption = 'Socket'
        Width = 100
      end
      item
        Caption = 'IP'
        Width = 160
      end
      item
        Caption = 'Port'
        Width = 100
      end>
    ColumnClick = False
    Ctl3D = False
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    PopupMenu = pmA
    TabOrder = 0
    ViewStyle = vsReport
    OnContextPopup = lvAContextPopup
    OnDblClick = miStartSpyClick
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 22
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    object btnListen: TSpeedButton
      Left = 4
      Top = 0
      Width = 70
      Height = 22
      Caption = '&Listen'
      Flat = True
      OnClick = btnListenClick
    end
    object btnStop: TSpeedButton
      Left = 78
      Top = 0
      Width = 70
      Height = 22
      Caption = '&Stop'
      Enabled = False
      Flat = True
      OnClick = btnStopClick
    end
    object btnAbout: TSpeedButton
      Left = 152
      Top = 0
      Width = 70
      Height = 22
      Caption = '&About'
      Flat = True
      OnClick = btnAboutClick
    end
  end
  object idtsA: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = idtsAConnect
    OnExecute = idtsAExecute
    OnDisconnect = idtsADisconnect
    OnException = idtsAException
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    TerminateWaitTime = 3000
    Left = 8
    Top = 54
  end
  object pmA: TPopupMenu
    Left = 40
    Top = 54
    object miStartSpy: TMenuItem
      Caption = '&Start Spy'
      OnClick = miStartSpyClick
    end
    object miStopSpy: TMenuItem
      Caption = '&Stop Spy'
      OnClick = miStopSpyClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miCSvr: TMenuItem
      Caption = '&Close Server'
      OnClick = miCSvrClick
    end
  end
end
