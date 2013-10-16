object fmUserSet: TfmUserSet
  Left = 207
  Top = 169
  BorderStyle = bsDialog
  Caption = #24080#25143#35774#32622
  ClientHeight = 257
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 16
    Width = 361
    Height = 217
    Caption = #35831#36755#20837#24080#25143#35774#32622
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 64
      Top = 24
      Width = 45
      Height = 15
      Caption = #24080#25143#21517
    end
    object Label2: TLabel
      Left = 64
      Top = 48
      Width = 45
      Height = 15
      Caption = #29992#25143#21517
    end
    object Label3: TLabel
      Left = 49
      Top = 72
      Width = 60
      Height = 15
      Caption = #30331#38470#23494#30721
    end
    object Label4: TLabel
      Left = 31
      Top = 96
      Width = 78
      Height = 15
      Caption = #29992#25143'E-Mail'
    end
    object Label5: TLabel
      Left = 10
      Top = 120
      Width = 99
      Height = 15
      Caption = 'POP'#26381#21153#22120#22320#22336
    end
    object Label6: TLabel
      Left = 2
      Top = 144
      Width = 107
      Height = 15
      Caption = 'SMTP'#26381#21153#22120#22320#22336
    end
    object edtUserName: TEdit
      Left = 128
      Top = 24
      Width = 161
      Height = 23
      TabOrder = 0
    end
    object edtUserID: TEdit
      Left = 128
      Top = 48
      Width = 161
      Height = 23
      TabOrder = 1
    end
    object edtPwd: TEdit
      Left = 128
      Top = 72
      Width = 161
      Height = 23
      PasswordChar = '*'
      TabOrder = 2
    end
    object edtUserAddress: TEdit
      Left = 128
      Top = 96
      Width = 161
      Height = 23
      TabOrder = 3
    end
    object edtPopHost: TEdit
      Left = 128
      Top = 120
      Width = 161
      Height = 23
      TabOrder = 4
    end
    object edtSmtpHost: TEdit
      Left = 128
      Top = 144
      Width = 161
      Height = 23
      TabOrder = 5
    end
    object btnSet: TBitBtn
      Left = 48
      Top = 176
      Width = 75
      Height = 25
      Caption = #30830#23450
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnSetClick
    end
    object btnOK: TBitBtn
      Left = 232
      Top = 176
      Width = 75
      Height = 25
      Caption = #23436#25104
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = btnOKClick
    end
  end
end
