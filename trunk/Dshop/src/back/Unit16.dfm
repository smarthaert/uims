object Fr_KuCunYuJing: TFr_KuCunYuJing
  Left = 248
  Top = 104
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24211#23384#39044#35686
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
  OnActivate = FormActivate
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
      object Label6: TLabel
        Left = 236
        Top = 33
        Width = 210
        Height = 29
        Caption = #24211#12288#23384#12288#39044#12288#35686
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel5: TPanel
        Left = 62
        Top = 374
        Width = 558
        Height = 43
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object Button1: TButton
          Left = 149
          Top = 9
          Width = 98
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #25171#21360#36827#36135#21333
          ParentBiDiMode = False
          TabOrder = 0
        end
        object Button2: TButton
          Left = 311
          Top = 9
          Width = 98
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #36820#12288#22238
          ParentBiDiMode = False
          TabOrder = 1
          OnClick = Button2Click
        end
      end
      object Panel3: TPanel
        Left = 62
        Top = 77
        Width = 558
        Height = 297
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object DBGrid1: TDBGrid
          Left = 2
          Top = 2
          Width = 554
          Height = 293
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
          Columns = <
            item
              Expanded = False
              FieldName = 'BarCode'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#26465#30721
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'GoodsName'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#21517#31216
              Width = 155
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Unit'
              Title.Alignment = taCenter
              Title.Caption = #21333#20301
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PurchasePrice'
              Title.Alignment = taCenter
              Title.Caption = #36827#20215
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SellPrice'
              Title.Alignment = taCenter
              Title.Caption = #21806#20215
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'StockScalar'
              Title.Alignment = taCenter
              Title.Caption = #24211#23384#25968#37327
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'StockBaseline'
              Title.Alignment = taCenter
              Title.Caption = #24211#23384#24213#32447
              Width = 60
              Visible = True
            end>
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 11
    Top = 11
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 43
    Top = 11
  end
end
