object ftp: Tftp
  Left = 215
  Top = 138
  BorderStyle = bsDialog
  Caption = 'FTP   IP'#26356#26032
  ClientHeight = 265
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 0
    Top = 252
    Width = 386
    Height = 13
    Align = alBottom
    Caption = #23601#32490
    Color = clActiveBorder
    ParentColor = False
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 386
    Height = 252
    Align = alClient
    Caption = 'FTP   IP'#26356#26032
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 81
      Height = 16
      AutoSize = False
      Caption = 'FTP'#26381#21153#22120#65306
    end
    object Label2: TLabel
      Left = 248
      Top = 24
      Width = 41
      Height = 16
      AutoSize = False
      Caption = #31471#21475#65306
    end
    object Label3: TLabel
      Left = 27
      Top = 56
      Width = 57
      Height = 16
      AutoSize = False
      Caption = #29992#25143#21517#65306
    end
    object Label4: TLabel
      Left = 16
      Top = 88
      Width = 81
      Height = 16
      AutoSize = False
      Caption = #30331#38470#23494#30721#65306
    end
    object Label5: TLabel
      Left = 195
      Top = 88
      Width = 65
      Height = 16
      AutoSize = False
      Caption = #30830#35748#23494#30721#65306
    end
    object Label6: TLabel
      Left = 7
      Top = 120
      Width = 89
      Height = 16
      AutoSize = False
      Caption = #23384#25918'IP'#25991#20214#65306
    end
    object Label8: TLabel
      Left = 8
      Top = 184
      Width = 73
      Height = 16
      AutoSize = False
      Caption = 'IP'#25991#20214#20869#23481#65306
    end
    object Label9: TLabel
      Left = 16
      Top = 152
      Width = 97
      Height = 13
      AutoSize = False
      Caption = 'HTTP'#22320#22336#65306
    end
    object ComboBox1: TComboBox
      Left = 80
      Top = 176
      Width = 297
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 80
      Top = 16
      Width = 161
      Height = 21
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 288
      Top = 16
      Width = 89
      Height = 21
      TabOrder = 2
    end
    object Edit3: TEdit
      Left = 80
      Top = 48
      Width = 297
      Height = 21
      TabOrder = 3
    end
    object Edit4: TEdit
      Left = 80
      Top = 80
      Width = 113
      Height = 21
      PasswordChar = '*'
      TabOrder = 4
    end
    object Edit5: TEdit
      Left = 256
      Top = 80
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 5
    end
    object Edit6: TEdit
      Left = 80
      Top = 112
      Width = 297
      Height = 21
      TabOrder = 6
    end
    object Button1: TButton
      Left = 136
      Top = 208
      Width = 89
      Height = 33
      Caption = #26356#26032'IP'
      TabOrder = 7
      OnClick = Button1Click
    end
    object Edit7: TEdit
      Left = 80
      Top = 144
      Width = 193
      Height = 21
      TabOrder = 8
    end
    object Button2: TButton
      Left = 280
      Top = 141
      Width = 99
      Height = 25
      Caption = #26597#30475#26356#26032#20869#23481
      TabOrder = 9
      OnClick = Button2Click
    end
  end
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 272
    Top = 208
  end
end
