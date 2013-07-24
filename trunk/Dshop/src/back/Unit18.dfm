object Fr_GJTH_1: TFr_GJTH_1
  Left = 367
  Top = 239
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #37319#36141#21333#21495#26597#35810
  ClientHeight = 453
  ClientWidth = 992
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
    Width = 992
    Height = 453
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 986
      Height = 447
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 984
        Height = 445
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
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
        OnKeyPress = DBGrid1KeyPress
        Columns = <
          item
            Expanded = False
            FieldName = 'InvoiceID'
            Title.Alignment = taCenter
            Title.Caption = #37319#36141#21333#21495
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BarCode'
            Title.Alignment = taCenter
            Title.Caption = #21830#21697#26465#30721
            Width = 104
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GoodsName'
            Title.Alignment = taCenter
            Title.Caption = #21830#21697#21517#31216
            Width = 218
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FeederName'
            Title.Alignment = taCenter
            Title.Caption = #20379#36135#21830
            Width = 261
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PurchaseScalar'
            Title.Alignment = taCenter
            Title.Caption = #37319#36141#25968#37327
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PurchasePrice'
            Title.Alignment = taCenter
            Title.Caption = #37319#36141#20215#26684
            Width = 63
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Unit'
            Title.Alignment = taCenter
            Title.Caption = #21333#20301
            Width = 39
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PurchaseDate'
            Title.Alignment = taCenter
            Title.Caption = #37319#36141#26085#26399
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UserName'
            Title.Alignment = taCenter
            Title.Caption = #25805#20316#21592
            Visible = True
          end>
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = Fr_GJTH.ADOQuery2
    Left = 11
    Top = 11
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 11
    Top = 43
    object N1: TMenuItem
      Caption = #36873#25321#36820#22238
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #24403#22825#36827#36135
    end
    object N4: TMenuItem
      Caption = #24403#26376#36827#36135
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = #26085#26399#21319#24207
    end
    object N7: TMenuItem
      Caption = #26085#26399#38477#24207
    end
  end
end
