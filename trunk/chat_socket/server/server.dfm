object Form1: TForm1
  Left = 340
  Top = 231
  Width = 429
  Height = 336
  Caption = #32842#22825#26381#21153#22120' - '#26446#28487#28487
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar1: TStatusBar
    Left = 0
    Top = 290
    Width = 421
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = True
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 161
    Height = 261
    Align = alLeft
    Caption = #22312#32447#29992#25143
    TabOrder = 1
    DesignSize = (
      161
      261)
    object ListBox1: TListBox
      Left = 8
      Top = 24
      Width = 143
      Height = 227
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 12
      TabOrder = 0
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 261
    Width = 421
    Height = 29
    Align = alBottom
    ButtonHeight = 25
    Caption = 'ToolBar1'
    TabOrder = 2
    object Button1: TButton
      Left = 0
      Top = 2
      Width = 75
      Height = 25
      Caption = #30417#21548'[&L]'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 75
      Top = 2
      Width = 110
      Height = 25
      Caption = #20851#38381#26381#21153#22120'[&C]'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 185
      Top = 2
      Width = 75
      Height = 25
      Caption = #20851#20110'[&A]'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button3: TButton
      Left = 260
      Top = 2
      Width = 75
      Height = 25
      Caption = #36864#20986'[&X]'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 161
    Top = 0
    Width = 260
    Height = 261
    Align = alClient
    Caption = #20449#24687
    TabOrder = 3
    DesignSize = (
      260
      261)
    object Memo1: TMemo
      Left = 8
      Top = 24
      Width = 243
      Height = 225
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clSilver
      ReadOnly = True
      TabOrder = 0
      WordWrap = False
    end
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 15000
    ServerType = stNonBlocking
    OnListen = ServerSocket1Listen
    OnAccept = ServerSocket1Accept
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    OnClientError = ServerSocket1ClientError
    Left = 32
    Top = 40
  end
  object Table1: TTable
    DatabaseName = 'chat'
    TableName = 'chat.db'
    Left = 64
    Top = 40
  end
end
