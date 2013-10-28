object FrmEPriseReg: TFrmEPriseReg
  Left = 124
  Top = 74
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '企业登记'
  ClientHeight = 423
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 627
    Height = 382
    Align = alClient
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 0
    object Panel3: TPanel
      Left = 4
      Top = 4
      Width = 619
      Height = 180
      Align = alClient
      BevelInner = bvLowered
      BorderWidth = 2
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 31
        Width = 70
        Height = 14
        Caption = '纳税代码：'
      end
      object Label2: TLabel
        Left = 227
        Top = 31
        Width = 98
        Height = 14
        Caption = '税务登记证号：'
      end
      object Label3: TLabel
        Left = 16
        Top = 66
        Width = 70
        Height = 14
        Caption = '企业全称：'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 16
        Top = 100
        Width = 70
        Height = 14
        Caption = '详细地址：'
      end
      object Label5: TLabel
        Left = 16
        Top = 135
        Width = 70
        Height = 14
        Caption = '电话号码：'
      end
      object Label6: TLabel
        Left = 272
        Top = 135
        Width = 56
        Height = 14
        Caption = '联系人：'
      end
      object Panel5: TPanel
        Left = 484
        Top = 4
        Width = 131
        Height = 172
        Align = alRight
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        object btnCancel: TBitBtn
          Left = 18
          Top = 134
          Width = 97
          Height = 25
          Caption = '放 弃'
          TabOrder = 4
          Glyph.Data = {
            36020000424D3602000000000000360000002800000010000000100000000100
            10000000000000020000000000000000000000000000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C007C007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            007C007C007C007C007C007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C007C
            007C1F7C1F7CEF3D0000EF3D1F7C007C007C007C1F7C1F7C1F7C1F7C007C007C
            007C007C1F7C0000000000001F7C1F7C007C007C007C1F7C1F7C1F7C007C1F7C
            007C007C007CEF3D0000EF3D1F7C1F7C1F7C007C007C1F7C1F7C007C007C1F7C
            1F7C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C007C007C1F7C007C007C1F7C
            1F7C1F7C007C007C00001F7C1F7C1F7C1F7C1F7C007C007C1F7C007C007C1F7C
            1F7C1F7C1F7CEF3D0000EF3D1F7C1F7C1F7C1F7C007C007C1F7C007C007C1F7C
            1F7C1F7C1F7C003C0000003C007C1F7C1F7C1F7C007C007C1F7C007C007C1F7C
            1F7C1F7C1F7C000000000000007C007C1F7C1F7C007C007C1F7C1F7C007C007C
            1F7C1F7C1F7C000000000000007C007C007C1F7C007C1F7C1F7C1F7C007C007C
            007C1F7C1F7C0000000000001F7C007C007C007C007C1F7C1F7C1F7C1F7C007C
            007C007C1F7CEF3D0000EF3D1F7C1F7C007C007C1F7C1F7C1F7C1F7C1F7C1F7C
            007C007C007C007C007C007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C007C007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C}
          Spacing = 12
        end
        object btnSave: TBitBtn
          Left = 18
          Top = 104
          Width = 97
          Height = 25
          Caption = '保 存'
          TabOrder = 3
          OnClick = btnSaveClick
          Glyph.Data = {
            36020000424D3602000000000000360000002800000010000000100000000100
            10000000000000020000000000000000000000000000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00000000EF3D0000EF3DEF3D000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00000000F75E0000F75EF75E000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00000000F75EF75EF75EF75E000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000FF7FFF7F
            FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7F00000000FF7FFF7F
            FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7F00000000FF7F0000
            0000FF7F00000000F75E00001F001F001F00007C1F001F0000000000FF7FFF7F
            FF7FFF7FFF7FFF7FFF7FFF7F00001F7C007C007C007C1F7C1F7C0000FF7F0000
            000000000000FF7F0000FF7F0000007C007C007C007C007C1F7C0000FF7FFF7F
            FF7FFF7FFF7FFF7FFF7FFF7F007C007C007C007C007C007C007C0000FF7F0000
            0000FF7F000000000000000000001F7C007C007C007C1F7C1F7C0000FF7FFF7F
            FF7FFF7F0000FF7FFF7F00001F7C1F7C007C007C007C1F7C1F7C0000FF7F0000
            F75EFF7F0000FF7F00001F7C1F7CEF3D007C007C007C1F7C1F7C0000FF7FFF7F
            FF7FFF7F000000001F7C007C007C007C007C007C1F7C1F7C1F7C000000000000
            0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
          Spacing = 12
        end
        object btnDelete: TBitBtn
          Left = 18
          Top = 73
          Width = 97
          Height = 25
          Caption = '删 除'
          TabOrder = 2
          OnClick = btnDeleteClick
          Glyph.Data = {
            36020000424D3602000000000000360000002800000010000000100000000100
            10000000000000020000000000000000000000000000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C007C007C
            007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C
            007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F001F001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F001F00
            1F001F001F001F001F001F001F001F001F7C007C007C1F7C1F7C1F7C1F001F00
            1F001F001F001F001F001F001F001F001F7C007C007C1F7C1F7C1F7C1F7C1F7C
            1F001F001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
          Spacing = 12
        end
        object btnModify: TBitBtn
          Left = 18
          Top = 43
          Width = 97
          Height = 25
          Caption = '修 改'
          TabOrder = 1
          OnClick = btnModifyClick
          Glyph.Data = {
            36020000424D3602000000000000360000002800000010000000100000000100
            10000000000000020000000000000000000000000000000000001F7C1F7C1F7C
            1F7C1F7C1F7C00000000000000000000000000000000000000001F7C1F7C1F7C
            1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000001F7C
            00000000000000000000FF7FFF7F0000FF7F00000000FF7F0000FF0300000000
            E07FFF7FE07FFF7FE07F0000FF7FFF7FFF7FFF7FFF7FFF7F0000FF030000E07F
            FF7FE07FFF7F000000000000FF7FFF7FFF7FFF7F0000FF7F0000FF030000FF7F
            E07FFF7FE07FFF7FE07FFF7F0000FF7F00000000FF7FFF7F0000FF030000E07F
            FF7FE07FFF7F00000000000000000000E07F0000FF7FFF7F0000FF030000FF7F
            E07FFF7FE07FFF7FE07FFF7FE07FFF7F0000FF7FFF7FFF7F0000FF030000E07F
            FF7F0000000000000000000000000000FF7FFF7FFF7FFF7F0000000000000000
            E07FFF7FE07F00000000E07F0000FF7FFF7F00000000FF7F00001F7C1F7C1F7C
            0000000000000000E07F0000FF7FFF7FFF7FFF7FFF7FFF7F00001F7C1F7C1F7C
            1F7C1F7C0000E07F0000FF7FFF7FFF7FFF7F00000000000000001F7C1F7C1F7C
            1F7C0000E07F0000FF7FFF7F00000000FF7F0000FF7FFF7F00001F7C1F7C1F7C
            0000E07F00000000FF7FFF7FFF7FFF7FFF7F0000FF7F00001F7C1F7C1F7C0000
            007C00001F7C0000FF7FFF7FFF7FFF7FFF7F000000001F7C1F7C1F7C1F7C1F7C
            00001F7C1F7C00000000000000000000000000001F7C1F7C1F7C}
          Spacing = 12
        end
        object btnAdd: TBitBtn
          Left = 18
          Top = 12
          Width = 97
          Height = 25
          Caption = '添 加'
          TabOrder = 0
          OnClick = btnAddClick
          Glyph.Data = {
            36020000424D3602000000000000360000002800000010000000100000000100
            10000000000000020000000000000000000000000000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C
            007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C007C007C
            007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C
            007C007C007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            007C007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F001F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F001F001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F001F00
            1F001F001F001F001F001F001F001F001F7C007C007C1F7C1F7C1F7C1F001F00
            1F001F001F001F001F001F001F001F001F7C007C007C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F001F001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F001F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C}
          Spacing = 12
        end
      end
      object edRateNo: TOvrEdit
        Left = 96
        Top = 27
        Width = 121
        Height = 22
        MaxLength = 6
        TabOrder = 1
        Text = 'edRateNo'
      end
      object edRegNO: TOvrEdit
        Left = 336
        Top = 27
        Width = 129
        Height = 22
        MaxLength = 15
        TabOrder = 2
        Text = 'edRegNO'
      end
      object edEPrise: TOvrEdit
        Left = 96
        Top = 62
        Width = 369
        Height = 22
        ImeMode = imOpen
        MaxLength = 50
        TabOrder = 3
        Text = 'edEPrise'
      end
      object edAddress: TOvrEdit
        Left = 96
        Top = 96
        Width = 369
        Height = 22
        ImeMode = imOpen
        MaxLength = 50
        TabOrder = 4
        Text = 'edAddress'
      end
      object edPhone: TOvrEdit
        Left = 96
        Top = 131
        Width = 121
        Height = 22
        AutoSelect = False
        MaxLength = 12
        TabOrder = 5
        Text = '0573-'
      end
      object edLinkman: TOvrEdit
        Left = 336
        Top = 131
        Width = 129
        Height = 22
        ImeMode = imOpen
        MaxLength = 8
        TabOrder = 6
        Text = 'edLinkman'
        OnExit = edLinkmanExit
      end
    end
    object Panel4: TPanel
      Left = 4
      Top = 184
      Width = 619
      Height = 194
      Align = alBottom
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvLowered
      BorderWidth = 2
      TabOrder = 1
      object DBNavigator1: TDBNavigator
        Left = 4
        Top = 4
        Width = 611
        Height = 25
        DataSource = DataSource1
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
        Align = alTop
        Flat = True
        TabOrder = 0
        OnClick = DBNavigator1Click
      end
      object DBGrid1: TDBGrid
        Left = 4
        Top = 29
        Width = 611
        Height = 161
        Align = alClient
        DataSource = DataSource1
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = '宋体'
        TitleFont.Style = []
        OnCellClick = DBGrid1CellClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 627
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 1
    object Label3D1: TLabel3D
      Left = 223
      Top = 6
      Width = 180
      Height = 29
      Caption = '企业税务登记'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -29
      Font.Name = '楷体_GB2312'
      Font.Style = []
      ParentFont = False
      CaptionStyle = csHeavyRaised
    end
    object BitBtn6: TBitBtn
      Left = 506
      Top = 8
      Width = 97
      Height = 25
      Caption = '返回'
      TabOrder = 0
      TabStop = False
      OnClick = BitBtn6Click
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
      Spacing = 12
    end
  end
  object Table1: TTable
    Active = True
    AfterScroll = Table1AfterScroll
    DatabaseName = 'TaxDB'
    Filter = 'State='#39'1'#39
    TableName = 'EPrise.DB'
    Left = 212
    Top = 281
    object Table1Ratepaying_No: TStringField
      DisplayLabel = '纳税代码'
      DisplayWidth = 8
      FieldName = 'Ratepaying_No'
      Size = 6
    end
    object Table1Register_No: TStringField
      DisplayLabel = '税务登记证号'
      DisplayWidth = 15
      FieldName = 'Register_No'
      Size = 15
    end
    object Table1Enterprise: TStringField
      DisplayLabel = '企业全称'
      DisplayWidth = 27
      FieldName = 'Enterprise'
      Size = 50
    end
    object Table1Address: TStringField
      DisplayLabel = '详细地址'
      DisplayWidth = 8
      FieldName = 'Address'
      Size = 50
    end
    object Table1Phone_No: TStringField
      DisplayLabel = '电话号码'
      DisplayWidth = 12
      FieldName = 'Phone_No'
      Size = 12
    end
    object Table1Linkman: TStringField
      DisplayLabel = '联系人'
      DisplayWidth = 8
      FieldName = 'Linkman'
      Size = 8
    end
    object Table1State: TStringField
      DisplayLabel = '状态'
      FieldName = 'State'
      Visible = False
      Size = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 244
    Top = 281
  end
end
