object MainForm: TMainForm
  Left = 192
  Top = 130
  Width = 774
  Height = 470
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnInit: TButton
    Left = 24
    Top = 64
    Width = 105
    Height = 33
    Caption = 'Init'
    TabOrder = 0
    OnClick = btnInitClick
  end
  object panLogin: TPanel
    Left = 8
    Top = 112
    Width = 745
    Height = 57
    TabOrder = 1
    Visible = False
    object btnLogin: TButton
      Left = 16
      Top = 8
      Width = 113
      Height = 41
      Caption = 'Login'
      TabOrder = 0
      OnClick = btnLoginClick
    end
    object btnLogoff: TButton
      Left = 144
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Logoff'
      TabOrder = 1
      OnClick = btnLogoffClick
    end
    object btnRegister: TButton
      Left = 336
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Register'
      TabOrder = 2
      OnClick = btnRegisterClick
    end
    object btnRecharge: TButton
      Left = 480
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Recharge'
      TabOrder = 3
      OnClick = btnRechargeClick
    end
  end
  object btnUninit: TButton
    Left = 144
    Top = 64
    Width = 105
    Height = 33
    Caption = 'Uninit'
    TabOrder = 2
    OnClick = btnUninitClick
  end
  object panAction: TPanel
    Left = 8
    Top = 176
    Width = 745
    Height = 257
    TabOrder = 3
    Visible = False
    object btnDecode: TButton
      Left = 24
      Top = 24
      Width = 129
      Height = 30
      Caption = 'Decode'
      TabOrder = 0
      OnClick = btnDecodeClick
    end
    object btnGetResult: TButton
      Left = 24
      Top = 64
      Width = 129
      Height = 30
      Caption = 'GetResult'
      TabOrder = 1
      OnClick = btnGetResultClick
    end
    object btnReport: TButton
      Left = 24
      Top = 104
      Width = 129
      Height = 30
      Caption = 'ReportResult'
      TabOrder = 2
      OnClick = btnReportClick
    end
    object btnDecodeWnd: TButton
      Left = 184
      Top = 24
      Width = 129
      Height = 30
      Caption = 'DecodeWnd'
      TabOrder = 3
      OnClick = btnDecodeWndClick
    end
    object btnDecodeBuf: TButton
      Left = 352
      Top = 24
      Width = 129
      Height = 30
      Caption = 'DecodeBuf'
      TabOrder = 4
      OnClick = btnDecodeBufClick
    end
    object btnRQueryBalance: TButton
      Left = 24
      Top = 160
      Width = 129
      Height = 30
      Caption = 'QueryBalance'
      TabOrder = 5
      OnClick = btnRQueryBalanceClick
    end
    object btnReadInfo: TButton
      Left = 184
      Top = 160
      Width = 129
      Height = 30
      Caption = 'ReadInfo'
      TabOrder = 6
      OnClick = btnReadInfoClick
    end
    object btnChangeInfo: TButton
      Left = 352
      Top = 160
      Width = 129
      Height = 30
      Caption = 'ChangeInfo'
      TabOrder = 7
      OnClick = btnChangeInfoClick
    end
    object btnDecodeSync: TButton
      Left = 24
      Top = 216
      Width = 129
      Height = 30
      Caption = 'DecodeSync'
      TabOrder = 8
      OnClick = btnDecodeSyncClick
    end
    object btnDecodeWndSync: TButton
      Left = 176
      Top = 216
      Width = 129
      Height = 30
      Caption = 'DecodeWndSync'
      TabOrder = 9
      OnClick = btnDecodeWndSyncClick
    end
    object btnDecodeBufSync: TButton
      Left = 336
      Top = 216
      Width = 129
      Height = 30
      Caption = 'DecodeBufSync'
      TabOrder = 10
      OnClick = btnDecodeBufSyncClick
    end
    object btnDecodeFileSync: TButton
      Left = 504
      Top = 216
      Width = 129
      Height = 30
      Caption = 'DecodeFileSync'
      TabOrder = 11
      OnClick = btnDecodeFileSyncClick
    end
  end
  object btnGetOrigError: TButton
    Left = 272
    Top = 64
    Width = 97
    Height = 33
    Caption = 'GetOrigError'
    TabOrder = 4
    OnClick = btnGetOrigErrorClick
  end
  object btnD2File: TButton
    Left = 32
    Top = 16
    Width = 289
    Height = 33
    Caption = 'D2File'
    TabOrder = 5
    OnClick = btnD2FileClick
  end
  object btnD2Buf: TButton
    Left = 400
    Top = 16
    Width = 345
    Height = 33
    Caption = 'D2Buf'
    TabOrder = 6
    OnClick = btnD2BufClick
  end
  object OpenDialog1: TOpenDialog
    Left = 704
    Top = 80
  end
end
