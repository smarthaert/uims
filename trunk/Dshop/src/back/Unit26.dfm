object Fr_YingShouYingFu: TFr_YingShouYingFu
  Left = 268
  Top = 108
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24212#25910#24212#20184
  ClientHeight = 465
  ClientWidth = 659
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 659
    Height = 465
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 653
      Height = 459
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label6: TLabel
        Left = 236
        Top = 33
        Width = 210
        Height = 29
        Caption = #24211#12288#23384#12288#30424#12288#28857
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 62
        Top = 77
        Width = 558
        Height = 297
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
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
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'id'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#26465#30721
              Width = 108
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'name'
              Title.Alignment = taCenter
              Title.Caption = #21830#21697#21517#31216
              Width = 190
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'note'
              Title.Alignment = taCenter
              Title.Caption = #25340#38899#31616#30721
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'StockScalar'
              Title.Alignment = taCenter
              Title.Caption = #24211#23384#25968#37327
              Width = 80
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Unit'
              Title.Alignment = taCenter
              Title.Caption = #21333#20301
              Width = 80
              Visible = True
            end>
        end
      end
      object Panel5: TPanel
        Left = 62
        Top = 374
        Width = 558
        Height = 43
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Button1: TButton
          Left = 135
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #25171#12288#21360
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 241
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #39044#12288#35272
          ParentBiDiMode = False
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 348
          Top = 9
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #36820#12288#22238
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object Panel4: TPanel
        Left = 619
        Top = 1
        Width = 33
        Height = 457
        Align = alRight
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
        object QuickRep1: TQuickRep
          Left = 8
          Top = 8
          Width = 911
          Height = 529
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          DataSet = ADOQuery1
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          Functions.Strings = (
            'PAGENUMBER'
            'COLUMNNUMBER'
            'REPORTTITLE')
          Functions.DATA = (
            '0'
            '0'
            #39#39)
          Options = [FirstPageHeader, LastPageFooter]
          Page.Columns = 1
          Page.Orientation = poPortrait
          Page.PaperSize = Custom
          Page.Values = (
            200.000000000000000000
            1400.000000000000000000
            200.000000000000000000
            2410.000000000000000000
            200.000000000000000000
            200.000000000000000000
            0.000000000000000000)
          PrinterSettings.Copies = 1
          PrinterSettings.OutputBin = Auto
          PrinterSettings.Duplex = False
          PrinterSettings.FirstPage = 0
          PrinterSettings.LastPage = 0
          PrinterSettings.UseStandardprinter = False
          PrinterSettings.UseCustomBinCode = False
          PrinterSettings.CustomBinCode = 0
          PrinterSettings.ExtendedDuplex = 0
          PrinterSettings.UseCustomPaperCode = False
          PrinterSettings.CustomPaperCode = 0
          PrinterSettings.PrintMetaFile = False
          PrinterSettings.PrintQuality = 0
          PrinterSettings.Collate = 0
          PrinterSettings.ColorOption = 0
          PrintIfEmpty = True
          SnapToGrid = True
          Units = MM
          Zoom = 100
          PrevFormStyle = fsNormal
          PreviewInitialState = wsNormal
          PrevInitialZoom = qrZoomToFit
          object DetailBand1: TQRBand
            Left = 76
            Top = 173
            Width = 760
            Height = 26
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            AlignToBottom = False
            Color = clWhite
            TransparentBand = False
            ForceNewColumn = False
            ForceNewPage = False
            Size.Values = (
              68.791666666666670000
              2010.833333333333000000)
            PreCaluculateBandHeight = False
            KeepOnOnePage = False
            BandType = rbDetail
            object QRShape7: TQRShape
              Left = 636
              Top = 0
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666670000
                1682.750000000000000000
                0.000000000000000000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape6: TQRShape
              Left = 4
              Top = 21
              Width = 635
              Height = 9
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                23.812500000000000000
                10.583333333333330000
                55.562500000000000000
                1680.104166666667000000)
              Shape = qrsHorLine
              VertAdjust = 0
            end
            object QRShape5: TQRShape
              Left = 0
              Top = -1
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666680000
                0.000000000000000000
                -2.645833333333333000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape19: TQRShape
              Left = 112
              Top = -1
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666680000
                296.333333333333400000
                -2.645833333333333000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape18: TQRShape
              Left = 248
              Top = -1
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666680000
                656.166666666666800000
                -2.645833333333333000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape17: TQRShape
              Left = 328
              Top = -1
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666680000
                867.833333333333500000
                -2.645833333333333000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape16: TQRShape
              Left = 408
              Top = -1
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666680000
                1079.500000000000000000
                -2.645833333333333000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape15: TQRShape
              Left = 464
              Top = -1
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666680000
                1227.666666666667000000
                -2.645833333333333000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape14: TQRShape
              Left = 536
              Top = -1
              Width = 9
              Height = 26
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                68.791666666666680000
                1418.166666666667000000
                -2.645833333333333000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRDBText5: TQRDBText
              Left = 416
              Top = 6
              Width = 49
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                1100.666666666667000000
                15.875000000000000000
                129.645833333333300000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = Fr_KuCunPanDian.ADOQuery1
              DataField = 'Unit'
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRDBText4: TQRDBText
              Left = 336
              Top = 6
              Width = 73
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                889.000000000000000000
                15.875000000000000000
                193.145833333333300000)
              Alignment = taRightJustify
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = Fr_KuCunPanDian.ADOQuery1
              DataField = 'StockScalar'
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object qrdbtxtnote: TQRDBText
              Left = 256
              Top = 6
              Width = 73
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                677.333333333333400000
                15.875000000000000000
                193.145833333333300000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = ADOQuery1
              DataField = 'note'
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object qrdbtxtname: TQRDBText
              Left = 120
              Top = 6
              Width = 129
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                317.500000000000000000
                15.875000000000000000
                341.312500000000000000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = ADOQuery1
              DataField = 'name'
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object qrdbtxtid: TQRDBText
              Left = 8
              Top = 6
              Width = 105
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                21.166666666666670000
                15.875000000000000000
                277.812500000000000000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = ADOQuery1
              DataField = 'id'
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
          end
          object PageHeaderBand1: TQRBand
            Left = 76
            Top = 76
            Width = 760
            Height = 97
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            AlignToBottom = False
            Color = clWhite
            TransparentBand = False
            ForceNewColumn = False
            ForceNewPage = False
            Size.Values = (
              256.645833333333400000
              2010.833333333333000000)
            PreCaluculateBandHeight = False
            KeepOnOnePage = False
            BandType = rbPageHeader
            object QRLabel1: TQRLabel
              Left = 220
              Top = 8
              Width = 204
              Height = 30
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                79.375000000000000000
                582.083333333333400000
                21.166666666666670000
                539.750000000000000000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Caption = #24211#23384#30424#28857#26126#32454#34920
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -29
              Font.Name = #40657#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 22
            end
            object QRShape1: TQRShape
              Left = 4
              Top = 64
              Width = 635
              Height = 9
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                23.812500000000000000
                10.583333333333330000
                169.333333333333300000
                1680.104166666667000000)
              Shape = qrsHorLine
              VertAdjust = 0
            end
            object QRShape2: TQRShape
              Left = 0
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                0.000000000000000000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape3: TQRShape
              Left = 4
              Top = 92
              Width = 635
              Height = 9
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                23.812500000000000000
                10.583333333333330000
                243.416666666666700000
                1680.104166666667000000)
              Shape = qrsHorLine
              VertAdjust = 0
            end
            object QRShape4: TQRShape
              Left = 634
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                1677.458333333333000000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRSysData1: TQRSysData
              Left = 264
              Top = 48
              Width = 67
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                698.500000000000000000
                127.000000000000000000
                177.270833333333300000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              Color = clWhite
              Data = qrsDateTime
              Transparent = False
              FontSize = 9
            end
            object QRLabel3: TQRLabel
              Left = 8
              Top = 76
              Width = 105
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                21.166666666666670000
                201.083333333333300000
                277.812500000000000000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #21830#21697#26465#30721
              Color = clWhite
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape8: TQRShape
              Left = 112
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                296.333333333333400000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRLabel4: TQRLabel
              Left = 120
              Top = 76
              Width = 129
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                317.500000000000000000
                201.083333333333300000
                341.312500000000000000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #21830#21697#21517#31216
              Color = clWhite
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape9: TQRShape
              Left = 248
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                656.166666666666800000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRLabel5: TQRLabel
              Left = 256
              Top = 76
              Width = 73
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                677.333333333333400000
                201.083333333333300000
                193.145833333333300000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #25340#38899#31616#30721
              Color = clWhite
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape10: TQRShape
              Left = 328
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                867.833333333333500000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRLabel6: TQRLabel
              Left = 336
              Top = 76
              Width = 73
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                889.000000000000000000
                201.083333333333300000
                193.145833333333300000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #24211#23384#25968#37327
              Color = clWhite
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape11: TQRShape
              Left = 408
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                1079.500000000000000000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRLabel7: TQRLabel
              Left = 416
              Top = 76
              Width = 49
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                1100.666666666667000000
                201.083333333333300000
                129.645833333333300000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #21333#12288#20301
              Color = clWhite
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape12: TQRShape
              Left = 464
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                1227.666666666667000000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRLabel8: TQRLabel
              Left = 472
              Top = 76
              Width = 65
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                1248.833333333333000000
                201.083333333333300000
                171.979166666666700000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #23454#23384#25968#37327
              Color = clWhite
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape13: TQRShape
              Left = 536
              Top = 68
              Width = 9
              Height = 29
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                76.729166666666680000
                1418.166666666667000000
                179.916666666666700000
                23.812500000000000000)
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRLabel9: TQRLabel
              Left = 544
              Top = 76
              Width = 91
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                1439.333333333333000000
                201.083333333333300000
                240.770833333333300000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #22791#12288#12288#27880
              Color = clWhite
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
          end
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 11
    Top = 11
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Pass' +
      'word=root;Data Source=ashop'
    Parameters = <>
    Left = 75
    Top = 27
  end
end
