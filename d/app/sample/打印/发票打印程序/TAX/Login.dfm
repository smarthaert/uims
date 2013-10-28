object FrmLogin: TFrmLogin
  Left = 256
  Top = 246
  BorderIcons = []
  BorderStyle = bsNone
  Caption = '系统登录'
  ClientHeight = 150
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 150
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 4
    TabOrder = 0
    object Label1: TLabel
      Left = 35
      Top = 20
      Width = 54
      Height = 12
      Caption = '编  号：'
      FocusControl = edName
    end
    object Label2: TLabel
      Left = 35
      Top = 68
      Width = 54
      Height = 12
      Caption = '口  令：'
      FocusControl = edWord
    end
    object Label3: TLabel
      Left = 35
      Top = 44
      Width = 54
      Height = 12
      Caption = '用  户：'
    end
    object edName: TOvrEdit
      Left = 106
      Top = 40
      Width = 113
      Height = 20
      Enabled = False
      TabOrder = 1
    end
    object edWord: TOvrEdit
      Left = 106
      Top = 64
      Width = 113
      Height = 20
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 32
      Top = 104
      Width = 75
      Height = 25
      Caption = '确 认'
      TabOrder = 3
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 144
      Top = 104
      Width = 75
      Height = 25
      Caption = '取 消'
      TabOrder = 4
      TabStop = False
      OnClick = BitBtn2Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object edCode: TOvrEdit
      Left = 106
      Top = 16
      Width = 113
      Height = 20
      TabOrder = 0
      OnExit = edCodeExit
    end
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'TaxDB'
    TableName = 'Pword.DB'
    Left = 112
    Top = 104
  end
end
