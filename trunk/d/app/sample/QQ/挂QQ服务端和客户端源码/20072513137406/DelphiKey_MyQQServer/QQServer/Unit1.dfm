object FrmMain: TFrmMain
  Left = 241
  Top = 101
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25346'QQ'#26381#21153#22120
  ClientHeight = 420
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OnLineLab: TLabel
    Left = 17
    Top = 16
    Width = 256
    Height = 16
    AutoSize = False
    Caption = #22312#32447#20154#25968
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 15
    Top = 274
    Width = 293
    Height = 52
    Caption = 
      'MyQQ Server V3.00 [Touchboy]  '#19987#19994#25346#26426#24179#21488#27426#36814#26469#21040#25105#20204#30340#23478#13#10' http://www.Touchb' +
      'oy.com'#13#10'(C)2005-06 YUFAN.Net All Right Reserved'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object QQTCPServer: TWinsock
    Left = 192
    Top = 8
    Width = 28
    Height = 28
    OnConnectionRequest = QQTCPServerConnectionRequest
    ControlData = {
      2143341208000000E5020000E502000092D88D24000006000000000000000000
      000000004F460000}
  end
  object UpdateBtn: TBitBtn
    Left = 472
    Top = 352
    Width = 73
    Height = 25
    Caption = #21047#26032#21015#34920
    TabOrder = 1
    OnClick = UpdateBtnClick
  end
  object BitBtn3: TBitBtn
    Left = 560
    Top = 352
    Width = 65
    Height = 25
    Caption = #25443#20081#29992#25143
    TabOrder = 2
    OnClick = BitBtn3Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 401
    Width = 639
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = #29366#24577
        Width = 100
      end
      item
        Width = 150
      end
      item
        Text = #25346'QQ'#25968
        Width = 60
      end
      item
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 40
    Width = 357
    Height = 233
    Caption = #33258#21160#22238#22797#20449#24687
    TabOrder = 4
    object Memo1: TMemo
      Left = 14
      Top = 21
      Width = 329
      Height = 203
      Lines.Strings = (
        #25105#27491#22312#25346#26426#65292#35831#21247#25171#25200)
      MaxLength = 255
      TabOrder = 0
      OnChange = Memo1Change
    end
  end
  object RedScrollBar: TScrollBar
    Left = 16
    Top = 334
    Width = 356
    Height = 16
    Max = 255
    PageSize = 0
    TabOrder = 5
    OnChange = RedScrollBarChange
  end
  object GreenScrollBar: TScrollBar
    Left = 16
    Top = 355
    Width = 356
    Height = 16
    Max = 255
    PageSize = 0
    TabOrder = 6
    OnChange = RedScrollBarChange
  end
  object BlueScrollBar: TScrollBar
    Left = 16
    Top = 376
    Width = 356
    Height = 16
    Max = 255
    PageSize = 0
    TabOrder = 7
    OnChange = RedScrollBarChange
  end
  object QQLb: TListBox
    Left = 384
    Top = 46
    Width = 238
    Height = 283
    ItemHeight = 13
    TabOrder = 8
  end
  object StartBtn: TBitBtn
    Left = 392
    Top = 352
    Width = 75
    Height = 25
    Caption = #37325#26032#21551#21160
    TabOrder = 9
    OnClick = StartBtnClick
  end
  object MinuteTime: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = MinuteTimeTimer
    Left = 224
    Top = 8
  end
  object OnLineTime: TTimer
    Enabled = False
    OnTimer = OnLineTimeTimer
    Left = 256
    Top = 8
  end
  object RxTrayIcon1: TRxTrayIcon
    Enabled = False
    Icon.Data = {
      0000010001002020040000000000E80200001600000028000000200000004000
      0000010004000000000000020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      0000000000000000000000000000000000733333770000077733770000000000
      33BBBBBB33177733BBBBB337000000003BBBB3337888888733BBBBB300000000
      3BB3378FFFFFFF888733B3370000000003317FFFFFFFFF888873330000000000
      0708FFFFFFFFFFFF8888070000000000007FFFFFFFFFFFFF8888700000007700
      00FFF888FFFFFFFFF88887700000007707FF71918FFFFFFFF888870700000000
      08F899998FFFFFFFFF8888000000000008F899998FFFFFFFFF88880000007000
      08F899997888888FFF8887000000000007F89911999999977888870000000700
      07F8199999999999917880000700000000799999999999999911700000000000
      0199999911111111199111000000000019999111333333301111111000000000
      919913333BBBBBB33310111700000000791173B8BBBBBBBBB330011100000000
      010777773BBBBBB3330000070000000007077777333333331000000000000000
      07007777887777F8700000700000000007007777FF8778FF7000007000000000
      00007777F8077888710000000000000000007777F877787F7000000000000000
      00000777FF8778FF700007000000000000070077787777877000000000000000
      0000000777777777000000000000000000000000077770000000000000000000
      000000700000000007000000000000000000000077000077000000000000FFFF
      FFFFFC03E03FF000000FF000000FF000000FF800003FF800003FF800003F3000
      0013000000030000000300000003000000038000000380000003C0000007E000
      000FF000000FF000000FF000000FF800000FF800001FF800001FF800001FFC00
      003FFC00003FFE00003FFE00007FFF0000FFFF8001FFFFC003FFFFF00FFF}
    Interval = 500
    OnDblClick = RxTrayIcon1DblClick
    Left = 160
    Top = 8
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    Left = 288
    Top = 8
  end
  object QQDataBase: TDBISAMDatabase
    EngineVersion = '3.24'
    DatabaseName = 'QQUSER'
    SessionName = 'Default'
    Left = 320
    Top = 8
  end
end
