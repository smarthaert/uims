object Form1: TForm1
  Left = 268
  Top = 219
  Width = 586
  Height = 462
  Caption = #30701#20449#32593#20851#23458#25143#31471#26381#21153#22120
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 578
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 4
      Width = 168
      Height = 24
      Caption = #21414#38376#21830#24030#25968#30721#20844#21496
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = #21326#25991#20013#23435
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 22
      Top = 38
      Width = 140
      Height = 14
      Caption = #21338#34382#32593' www.pohoo.com'
      Font.Charset = ANSI_CHARSET
      Font.Color = clPurple
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 9
      Top = 32
      Width = 166
      Height = 2
    end
    object Button1: TButton
      Left = 342
      Top = 29
      Width = 108
      Height = 25
      Caption = #27880#20876'/'#26356#25442#29992#25143
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 230
      Top = 29
      Width = 107
      Height = 25
      Caption = #26816#27979#32593#20851'IP'#22320#22336
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 454
      Top = 29
      Width = 107
      Height = 25
      Caption = #37325#26032#30331#24405
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 57
    Width = 578
    Height = 378
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 8021
    OnRead = ClientSocketRead
    Left = 200
    Top = 80
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 232
    Top = 80
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer2Timer
    Left = 272
    Top = 80
  end
  object Database1: TADOConnection
    ConnectionString = 
      'FILE NAME=C:\Program Files\Common Files\System\Ole DB\Data Links' +
      '\DBDEMOS.udl'
    Mode = cmShareDenyNone
    Provider = 
      'C:\Program Files\Common Files\System\Ole DB\Data Links\DBDEMOS.u' +
      'dl'
    Left = 88
    Top = 120
  end
  object Query1: TADOQuery
    Connection = Database1
    Parameters = <>
    Left = 128
    Top = 120
  end
  object Query2: TADOQuery
    Connection = Database1
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Id, GateName, smid, smmobile, smcalled, smfee, smfeeno, s' +
        'mfmt, smmsgs, scheduletime, expiretime, mtflag, MsgId, reportfla' +
        'g, sendtime, extdata, smflag'
      'FROM msgcomm where smFlag = 0')
    Left = 160
    Top = 120
  end
  object qryTemp: TADOQuery
    Connection = Database1
    Parameters = <>
    Left = 192
    Top = 120
  end
end
