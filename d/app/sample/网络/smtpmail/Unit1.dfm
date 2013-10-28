object Form1: TForm1
  Left = 202
  Top = 151
  Width = 519
  Height = 389
  Caption = #36890#36807'SMTP'#26381#21153#22120#21457#36865#37038#20214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 128
    Width = 74
    Height = 13
    Caption = #37038#20214#27491#25991'      '
  end
  object Label6: TLabel
    Left = 8
    Top = 56
    Width = 40
    Height = 13
    Caption = #20027#39064'    '
  end
  object Label7: TLabel
    Left = 8
    Top = 96
    Width = 51
    Height = 13
    Caption = #21457#20214#20154'   '
  end
  object Label8: TLabel
    Left = 8
    Top = 16
    Width = 54
    Height = 13
    Caption = #25910#20214#20154'    '
  end
  object Label1: TLabel
    Left = 368
    Top = 40
    Width = 54
    Height = 13
    Caption = #26381#21153#22120'    '
  end
  object Label2: TLabel
    Left = 368
    Top = 104
    Width = 46
    Height = 13
    Caption = #31471#21475'      '
  end
  object Label4: TLabel
    Left = 368
    Top = 168
    Width = 46
    Height = 13
    Caption = #24080#21495'      '
  end
  object Label5: TLabel
    Left = 368
    Top = 232
    Width = 40
    Height = 13
    Caption = #23494#30721'    '
  end
  object Bevel1: TBevel
    Left = 360
    Top = 24
    Width = 145
    Height = 273
  end
  object Button1: TButton
    Left = 256
    Top = 112
    Width = 81
    Height = 33
    Caption = #21457#36865#37038#20214
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 368
    Top = 256
    Width = 129
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    PasswordChar = '*'
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 368
    Top = 192
    Width = 129
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 64
    Top = 144
    Width = 273
    Height = 161
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 368
    Top = 64
    Width = 129
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    TabOrder = 4
  end
  object Button2: TButton
    Left = 64
    Top = 320
    Width = 81
    Height = 25
    Caption = #28155#21152#38468#20214
    TabOrder = 5
    OnClick = Button2Click
  end
  object Edit4: TEdit
    Left = 64
    Top = 48
    Width = 273
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    TabOrder = 6
  end
  object Edit5: TEdit
    Left = 64
    Top = 88
    Width = 273
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    TabOrder = 7
  end
  object Edit6: TEdit
    Left = 64
    Top = 16
    Width = 273
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    TabOrder = 8
  end
  object Edit7: TEdit
    Left = 368
    Top = 128
    Width = 129
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    TabOrder = 9
  end
  object Button3: TButton
    Left = 392
    Top = 320
    Width = 81
    Height = 25
    Caption = #36864#20986
    TabOrder = 10
    OnClick = Button3Click
  end
  object SMTP1: TIdSMTP
    ASCIIFilter = True
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 25
    AuthenticationType = atNone
    Left = 16
    Top = 160
  end
  object IdMsg: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 16
    Top = 224
  end
  object OpenDialog1: TOpenDialog
    Left = 16
    Top = 192
  end
end
