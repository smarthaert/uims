object Fr_Stock: TFr_Stock
  Left = 197
  Top = 94
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20837#21152#39564#25910
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 682
      Height = 447
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label1: TLabel
        Left = 236
        Top = 43
        Width = 210
        Height = 29
        Caption = #20837#12288#24211#12288#39564#12288#25910
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 85
        Top = 86
        Width = 512
        Height = 277
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 2
          Width = 508
          Height = 273
          Align = alClient
          BorderStyle = bsNone
          Color = 15723503
          Ctl3D = False
          DataSource = DataSource1
          FixedColor = 15723503
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          OnDblClick = DBGrid1DblClick
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'InvoiceID'
              Title.Alignment = taCenter
              Title.Caption = #21333#12288#21495
              Width = 80
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'BarCode'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#26465#30721
              Width = 95
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GoodsName'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#21517#31216
              Width = 180
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PurchaseScalar'
              Title.Alignment = taCenter
              Title.Caption = #36827#36135#25968#37327
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PurchasePrice'
              Title.Alignment = taCenter
              Title.Caption = #36827#36135#21333#20215
              Width = 60
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Unit'
              Title.Caption = #21333#20301
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FeederName'
              Title.Alignment = taCenter
              Title.Caption = #20379#36135#21830
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'PurchaseDate'
              Title.Alignment = taCenter
              Title.Caption = #36827#36135#26085#26399
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UserName'
              Title.Alignment = taCenter
              Title.Caption = #25805#20316#21592
              Width = 60
              Visible = True
            end>
        end
      end
      object Panel5: TPanel
        Left = 85
        Top = 363
        Width = 512
        Height = 41
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Button1: TButton
          Left = 161
          Top = 8
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #20837#12288#24211
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 275
          Top = 8
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 1
          OnClick = Button2Click
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Purchase')
    Left = 11
    Top = 11
  end
  object ADOQuery2: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    Parameters = <>
    Left = 11
    Top = 43
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 11
  end
end
