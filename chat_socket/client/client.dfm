object Form1: TForm1
  Left = 308
  Top = 209
  AutoScroll = False
  Caption = #32842#22825#23458#25143#31471' - '#26446#28487#28487
  ClientHeight = 297
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    541
    297)
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar1: TStatusBar
    Left = 0
    Top = 277
    Width = 541
    Height = 20
    Panels = <
      item
        Width = 50
      end>
    ParentFont = True
    SimplePanel = True
    UseSystemFont = False
  end
  object GroupBox1: TGroupBox
    Left = 344
    Top = 96
    Width = 189
    Height = 135
    Anchors = [akTop, akRight, akBottom]
    Caption = #29992#25143#21517#21015#34920
    TabOrder = 1
    DesignSize = (
      189
      135)
    object ListBox1: TListBox
      Left = 9
      Top = 26
      Width = 169
      Height = 73
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 12
      TabOrder = 0
    end
    object RadioButton1: TRadioButton
      Left = 26
      Top = 107
      Width = 62
      Height = 18
      Anchors = [akLeft, akBottom]
      Caption = #20844#32842
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 104
      Top = 107
      Width = 53
      Height = 18
      Anchors = [akLeft, akBottom]
      Caption = #31169#32842
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 89
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 42
      Height = 12
      Caption = #29992#25143#21517' '
    end
    object Label2: TLabel
      Left = 128
      Top = 8
      Width = 24
      Height = 12
      Caption = #23494#30721
    end
    object Label3: TLabel
      Left = 248
      Top = 8
      Width = 60
      Height = 12
      Caption = #26381#21153#22120#22320#22336
    end
    object Edit1: TEdit
      Left = 16
      Top = 24
      Width = 97
      Height = 20
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 128
      Top = 24
      Width = 96
      Height = 20
      PasswordChar = '*'
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 248
      Top = 24
      Width = 175
      Height = 20
      TabOrder = 2
      Text = '127.0.0.1'
    end
    object Button2: TButton
      Left = 16
      Top = 48
      Width = 97
      Height = 25
      Caption = #30331#38470'[&L]'
      Enabled = False
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button7: TButton
      Left = 128
      Top = 48
      Width = 96
      Height = 25
      Caption = #27880#20876'[&N]'
      Enabled = False
      TabOrder = 4
      OnClick = Button7Click
    end
    object Button1: TButton
      Left = 248
      Top = 48
      Width = 79
      Height = 25
      Caption = #36830#25509'[&C]'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 344
      Top = 48
      Width = 81
      Height = 25
      Caption = #26029#24320'[&D]'
      Enabled = False
      TabOrder = 6
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 448
      Top = 48
      Width = 73
      Height = 25
      Caption = #36864#20986'[&X]'
      TabOrder = 7
      OnClick = Button4Click
    end
    object Button8: TButton
      Left = 448
      Top = 16
      Width = 73
      Height = 25
      Caption = #20851#20110'[&A]'
      TabOrder = 8
      OnClick = Button8Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 237
    Width = 541
    Height = 40
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    DesignSize = (
      541
      40)
    object Edit4: TEdit
      Left = 9
      Top = 9
      Width = 328
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyPress = Edit4KeyPress
    end
    object Button6: TButton
      Left = 347
      Top = 7
      Width = 71
      Height = 27
      Anchors = [akTop, akRight]
      Caption = #21457#36865'[&O]'
      Enabled = False
      TabOrder = 1
      OnClick = Button6Click
    end
    object Button5: TButton
      Left = 434
      Top = 7
      Width = 96
      Height = 27
      Anchors = [akTop, akRight]
      Caption = #28165#31354#35760#24405'[&Q]'
      TabOrder = 2
      OnClick = Button5Click
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 96
    Width = 326
    Height = 135
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 15000
    OnConnecting = ClientSocket1Connecting
    OnConnect = ClientSocket1Connect
    OnRead = ClientSocket1Read
    Left = 80
    Top = 144
  end
end
