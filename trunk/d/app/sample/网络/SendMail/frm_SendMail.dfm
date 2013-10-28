object FrmSendMail: TFrmSendMail
  Left = 257
  Top = 178
  Width = 327
  Height = 310
  Caption = #21457#36865#37038#20214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnSend: TButton
    Left = 34
    Top = 248
    Width = 75
    Height = 25
    Caption = #21457#36865
    TabOrder = 0
    OnClick = BtnSendClick
  end
  object GroupBox1: TGroupBox
    Left = 5
    Top = 4
    Width = 305
    Height = 124
    Caption = #37038#20214#20449#24687
    TabOrder = 1
    object LblServer: TLabel
      Left = 7
      Top = 24
      Width = 48
      Height = 13
      Caption = #26381#21153#22120#65306
    end
    object LblUserName: TLabel
      Left = 7
      Top = 70
      Width = 48
      Height = 13
      Caption = #29992#25143#21517#65306
    end
    object LblSendTo: TLabel
      Left = 7
      Top = 48
      Width = 48
      Height = 13
      Caption = #21457#36865#21040#65306
    end
    object LabA: TLabel
      Left = 177
      Top = 46
      Width = 11
      Height = 13
      Caption = '@'
    end
    object Label1: TLabel
      Left = 155
      Top = 67
      Width = 36
      Height = 13
      Caption = #23494#30721#65306
    end
    object Label2: TLabel
      Left = 8
      Top = 96
      Width = 48
      Height = 13
      Caption = #20248#20808#32423#65306
    end
    object Label3: TLabel
      Left = 152
      Top = 96
      Width = 36
      Height = 13
      Caption = #35748#35777#65306
    end
    object EdServerName: TEdit
      Left = 55
      Top = 16
      Width = 242
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 0
    end
    object EdUserName: TEdit
      Left = 55
      Top = 64
      Width = 82
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 1
    end
    object EdToName: TEdit
      Left = 55
      Top = 40
      Width = 121
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 2
    end
    object EDToServer: TEdit
      Left = 191
      Top = 40
      Width = 105
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 3
    end
    object EdPass: TEdit
      Left = 192
      Top = 64
      Width = 105
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      PasswordChar = '*'
      TabOrder = 4
    end
    object CBxPrio: TComboBox
      Left = 56
      Top = 91
      Width = 84
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 5
      Text = #26497#39640
      Items.Strings = (
        #26497#39640
        #39640
        #19968#33324
        #20302
        #26497#20302)
    end
    object CBxAuth: TComboBox
      Left = 192
      Top = 91
      Width = 84
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = #38656#35201#35748#35777
      Items.Strings = (
        #38656#35201#35748#35777
        #26080#38656#35748#35777)
    end
  end
  object GBxText: TGroupBox
    Left = 5
    Top = 132
    Width = 305
    Height = 113
    Caption = #20869#23481
    TabOrder = 2
    object Label4: TLabel
      Left = 14
      Top = 15
      Width = 36
      Height = 13
      Caption = #20027#39064#65306
    end
    object MmText: TMemo
      Left = 2
      Top = 33
      Width = 301
      Height = 77
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 0
    end
    object EdTitle: TEdit
      Left = 51
      Top = 9
      Width = 250
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 1
    end
  end
  object BtnClose: TButton
    Left = 210
    Top = 248
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 3
    OnClick = BtnCloseClick
  end
  object SMTP: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 25
    AuthenticationType = atLogin
    Left = 269
    Top = 20
  end
end
