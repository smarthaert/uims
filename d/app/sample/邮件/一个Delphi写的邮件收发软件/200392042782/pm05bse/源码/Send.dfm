object fmSend: TfmSend
  Left = 189
  Top = 198
  BorderStyle = bsDialog
  Caption = #20889#26032#37038#20214
  ClientHeight = 432
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 361
    Height = 153
    Caption = #37038#20214#20449#24687
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 26
      Height = 13
      Caption = #20027#39064
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 39
      Height = 13
      Caption = #25910#20214#20154
    end
    object Label3: TLabel
      Left = 24
      Top = 88
      Width = 26
      Height = 13
      Caption = #25220#36865
    end
    object Label4: TLabel
      Left = 16
      Top = 120
      Width = 39
      Height = 13
      Caption = #20248#20808#32423
    end
    object cobPriority: TComboBox
      Left = 56
      Top = 120
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        #32039#24613
        #24555
        #26222#36890)
    end
    object edtSubject: TEdit
      Left = 56
      Top = 24
      Width = 185
      Height = 21
      TabOrder = 1
    end
    object edtToAddress: TEdit
      Left = 56
      Top = 56
      Width = 185
      Height = 21
      TabOrder = 2
    end
    object edtCToAddress: TEdit
      Left = 56
      Top = 88
      Width = 185
      Height = 21
      TabOrder = 3
    end
    object btnAddFNote1: TButton
      Left = 248
      Top = 56
      Width = 81
      Height = 25
      Caption = #20174#22320#22336#31807#21152#20837
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnAddFNote1Click
    end
    object btnAddFNote2: TButton
      Left = 248
      Top = 88
      Width = 81
      Height = 25
      Caption = #20174#22320#22336#31807#21152#20837
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnAddFNote2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 384
    Top = 8
    Width = 201
    Height = 153
    Caption = #38468#20214
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lbAF: TListBox
      Left = 8
      Top = 16
      Width = 185
      Height = 97
      ItemHeight = 13
      TabOrder = 0
    end
    object btnAddAF: TButton
      Left = 8
      Top = 120
      Width = 75
      Height = 25
      Caption = #28155#21152
      TabOrder = 1
      OnClick = btnAddAFClick
    end
    object btnDeleAF: TButton
      Left = 112
      Top = 120
      Width = 75
      Height = 25
      Caption = #28165#38500
      TabOrder = 2
      OnClick = btnDeleAFClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 168
    Width = 577
    Height = 217
    Caption = #37038#20214#27491#25991
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object meSend: TMemo
      Left = 8
      Top = 16
      Width = 553
      Height = 193
      Lines.Strings = (
        '')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object btnSend: TBitBtn
    Left = 56
    Top = 392
    Width = 75
    Height = 25
    Caption = #21457#36865
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnSendClick
  end
  object btnCanel: TBitBtn
    Left = 160
    Top = 392
    Width = 75
    Height = 25
    Caption = #21462#28040
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnCanelClick
  end
  object IdMessage1: TIdMessage
    BccList = <>
    CCList = <>
    Recipients = <>
    ReplyTo = <>
    Left = 344
    Top = 88
  end
  object IdSmtp1: TIdSMTP
    Left = 272
    Top = 136
  end
  object OpenDialog1: TOpenDialog
    Left = 320
    Top = 40
  end
end
