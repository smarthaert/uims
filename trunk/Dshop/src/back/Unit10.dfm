object Fr_MXSP: TFr_MXSP
  Left = 248
  Top = 121
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26126#26143#21830#21697
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
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
        Top = 33
        Width = 210
        Height = 29
        Caption = #26126#12288#26143#12288#21830#12288#21697
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        ParentFont = False
      end
      object Gauge1: TGauge
        Left = 85
        Top = 318
        Width = 511
        Height = 3
        BackColor = 15723503
        BorderStyle = bsNone
        Color = clBlack
        ForeColor = 10841402
        ParentColor = False
        Progress = 50
        ShowText = False
      end
      object Panel3: TPanel
        Left = 85
        Top = 76
        Width = 512
        Height = 242
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 2
          Width = 508
          Height = 238
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
              Width = 140
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SellScalar'
              Title.Alignment = taCenter
              Title.Caption = #25968#37327
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PurchasePrice'
              Title.Alignment = taCenter
              Title.Caption = #36827#20215
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SellPrice'
              Title.Alignment = taCenter
              Title.Caption = #21806#20215
              Width = 50
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Gift'
              Title.Alignment = taCenter
              Title.Caption = #36192#21697
              Width = 33
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UntreadFlag'
              Title.Alignment = taCenter
              Title.Caption = #36864#36135
              Width = 33
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Unit'
              Title.Alignment = taCenter
              Title.Caption = #21333#20301
              Width = 33
              Visible = True
            end>
        end
      end
      object Panel4: TPanel
        Left = 337
        Top = 322
        Width = 260
        Height = 47
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 1
        object Label2: TLabel
          Left = 124
          Top = 25
          Width = 12
          Height = 12
          Caption = #33267
        end
        object Label3: TLabel
          Left = 12
          Top = 7
          Width = 78
          Height = 12
          Caption = #26085#26399#21306#38388#33539#22260':'
        end
        object RzDateTimeEdit1: TRzDateTimeEdit
          Left = 13
          Top = 21
          Width = 104
          Height = 20
          EditType = etDate
          Format = 'yyyy-mm-dd'
          Alignment = taRightJustify
          DropButtonVisible = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          TabOrder = 0
        end
        object RzDateTimeEdit2: TRzDateTimeEdit
          Left = 141
          Top = 21
          Width = 104
          Height = 20
          EditType = etDate
          Format = 'yyyy-mm-dd'
          Alignment = taRightJustify
          DropButtonVisible = False
          FrameHotColor = 14593668
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
          TabOrder = 1
        end
      end
      object Panel5: TPanel
        Left = 85
        Top = 322
        Width = 252
        Height = 47
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 2
        object RadioButton1: TRadioButton
          Left = 21
          Top = 5
          Width = 97
          Height = 17
          Caption = #24403#22825#20986#36135#32479#35745
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RadioButton2: TRadioButton
          Left = 21
          Top = 24
          Width = 97
          Height = 17
          Caption = #24403#26376#20986#36135#32479#35745
          TabOrder = 1
        end
        object RadioButton3: TRadioButton
          Left = 133
          Top = 5
          Width = 97
          Height = 17
          Caption = #20840#37096#20986#36135#32479#35745
          TabOrder = 2
        end
        object RadioButton4: TRadioButton
          Left = 133
          Top = 24
          Width = 97
          Height = 17
          Caption = #25351#23450#26085#26399#21306#38388
          TabOrder = 3
        end
      end
      object Panel6: TPanel
        Left = 337
        Top = 369
        Width = 260
        Height = 42
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 3
        object Button1: TButton
          Left = 12
          Top = 8
          Width = 75
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #32479#12288#35745
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 93
          Top = 8
          Width = 75
          Height = 25
          Caption = #25171#12288#21360
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 174
          Top = 8
          Width = 75
          Height = 25
          Caption = #36820#12288#22238
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object Panel7: TPanel
        Left = 85
        Top = 369
        Width = 252
        Height = 42
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 15723503
        TabOrder = 4
        object RadioButton5: TRadioButton
          Left = 21
          Top = 13
          Width = 97
          Height = 17
          Caption = #38144#21806#25968#37327#25490#34892
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RadioButton6: TRadioButton
          Left = 133
          Top = 13
          Width = 97
          Height = 17
          Caption = #38144#21806#37329#39069#25490#34892
          TabOrder = 1
        end
      end
      object Panel8: TPanel
        Left = 91
        Top = 114
        Width = 238
        Height = 191
        Color = clBlack
        TabOrder = 5
        Visible = False
        object QuickRep1: TQuickRep
          Left = 9
          Top = 9
          Width = 220
          Height = 176
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          DataSet = ADOQuery2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
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
            0.000000000000000000
            465.666666666666800000
            0.000000000000000000
            582.083333333333400000
            31.000000000000000000
            31.000000000000000000
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
          ShowProgress = False
          SnapToGrid = True
          Units = MM
          Zoom = 100
          PrevFormStyle = fsNormal
          PreviewInitialState = wsNormal
          PrevInitialZoom = qrZoomToFit
          object DetailBand1: TQRBand
            Left = 12
            Top = 70
            Width = 197
            Height = 15
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
              39.687500000000000000
              521.229166666666800000)
            PreCaluculateBandHeight = False
            KeepOnOnePage = False
            BandType = rbDetail
            object QRShape6: TQRShape
              Left = 187
              Top = 0
              Width = 2
              Height = 15
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                39.687500000000000000
                494.770833333333300000
                0.000000000000000000
                5.291666666666667000)
              Pen.Style = psDot
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape5: TQRShape
              Left = 141
              Top = 0
              Width = 2
              Height = 15
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                39.687500000000000000
                373.062500000000000000
                0.000000000000000000
                5.291666666666667000)
              Pen.Style = psDot
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRShape4: TQRShape
              Left = 104
              Top = 0
              Width = 2
              Height = 15
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                39.687500000000000000
                275.166666666666700000
                0.000000000000000000
                5.291666666666667000)
              Pen.Style = psDot
              Shape = qrsVertLine
              VertAdjust = 0
            end
            object QRDBText1: TQRDBText
              Left = 6
              Top = 1
              Width = 97
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                15.875000000000000000
                2.645833333333333000
                256.645833333333400000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = ADOQuery2
              DataField = 'GoodsName'
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRDBText2: TQRDBText
              Left = 107
              Top = 0
              Width = 34
              Height = 16
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                42.333333333333340000
                283.104166666666700000
                0.000000000000000000
                89.958333333333340000)
              Alignment = taRightJustify
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = ADOQuery2
              DataField = 'SellScalar'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Mask = '#,##0.0'
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRDBText3: TQRDBText
              Left = 144
              Top = 0
              Width = 42
              Height = 16
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                42.333333333333340000
                381.000000000000000000
                0.000000000000000000
                111.125000000000000000)
              Alignment = taRightJustify
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Color = clWhite
              DataSet = ADOQuery2
              DataField = 'SellPrice'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Mask = '#,##0.0'
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
          end
          object PageHeaderBand1: TQRBand
            Left = 12
            Top = 0
            Width = 197
            Height = 70
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
              185.208333333333300000
              521.229166666666800000)
            PreCaluculateBandHeight = False
            KeepOnOnePage = False
            BandType = rbPageHeader
            object QRLabel2: TQRLabel
              Left = 6
              Top = 10
              Width = 185
              Height = 22
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                58.208333333333340000
                15.875000000000000000
                26.458333333333330000
                489.479166666666700000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = #20986#24211#26126#32454#34920
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = #20223#23435'_GB2312'
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 16
            end
            object QRLabel3: TQRLabel
              Left = 6
              Top = 56
              Width = 49
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                15.875000000000000000
                148.166666666666700000
                129.645833333333300000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Caption = #21830#21697#21517#31216
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape1: TQRShape
              Left = 4
              Top = 48
              Width = 183
              Height = 5
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Frame.Style = psDashDot
              Size.Values = (
                13.229166666666670000
                10.583333333333330000
                127.000000000000000000
                484.187500000000000000)
              Pen.Style = psDot
              Shape = qrsHorLine
              VertAdjust = 0
            end
            object QRLabel5: TQRLabel
              Left = 92
              Top = 56
              Width = 25
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                243.416666666666700000
                148.166666666666700000
                66.145833333333340000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Caption = #25968#37327
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRLabel6: TQRLabel
              Left = 138
              Top = 56
              Width = 25
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                365.125000000000000000
                148.166666666666700000
                66.145833333333340000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Caption = #23567#35745
              Color = clWhite
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRShape3: TQRShape
              Left = 4
              Top = 67
              Width = 183
              Height = 5
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                13.229166666666670000
                10.583333333333330000
                177.270833333333300000
                484.187500000000000000)
              Shape = qrsHorLine
              VertAdjust = 0
            end
            object QRSysData1: TQRSysData
              Left = 6
              Top = 36
              Width = 185
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                15.875000000000000000
                95.250000000000000000
                489.479166666666700000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              Color = clWhite
              Data = qrsDateTime
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Text = #25171#21360#26085#26399':'
              Transparent = False
              FontSize = 9
            end
          end
          object SummaryBand1: TQRBand
            Left = 12
            Top = 85
            Width = 197
            Height = 84
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            AlignToBottom = False
            Color = clWhite
            TransparentBand = True
            ForceNewColumn = False
            ForceNewPage = False
            Size.Values = (
              222.250000000000000000
              521.229166666666800000)
            PreCaluculateBandHeight = False
            KeepOnOnePage = False
            BandType = rbSummary
            object QRShape7: TQRShape
              Left = 4
              Top = -2
              Width = 183
              Height = 5
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Frame.Style = psDashDot
              Size.Values = (
                13.229166666666670000
                10.583333333333330000
                -5.291666666666667000
                484.187500000000000000)
              Shape = qrsHorLine
              VertAdjust = 0
            end
            object QRLabel1: TQRLabel
              Left = 8
              Top = 6
              Width = 79
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
                209.020833333333300000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Caption = #32479#35745#26085#26399#21306#38388':'
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRLabel4: TQRLabel
              Left = 8
              Top = 22
              Width = 49
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                21.166666666666670000
                58.208333333333340000
                129.645833333333300000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Caption = 'QRLabel4'
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRLabel7: TQRLabel
              Left = 8
              Top = 38
              Width = 49
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                21.166666666666670000
                100.541666666666700000
                129.645833333333300000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Caption = 'QRLabel7'
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRLabel8: TQRLabel
              Left = 8
              Top = 70
              Width = 181
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                21.166666666666670000
                185.208333333333300000
                478.895833333333400000)
              Alignment = taCenter
              AlignToBand = False
              AutoSize = False
              AutoStretch = False
              Caption = 'QRLabel7'
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              Transparent = False
              WordWrap = True
              FontSize = 9
            end
            object QRExpr1: TQRExpr
              Left = 8
              Top = 54
              Width = 205
              Height = 13
              Frame.Color = clBlack
              Frame.DrawTop = False
              Frame.DrawBottom = False
              Frame.DrawLeft = False
              Frame.DrawRight = False
              Size.Values = (
                34.395833333333340000
                21.166666666666670000
                142.875000000000000000
                542.395833333333400000)
              Alignment = taLeftJustify
              AlignToBand = False
              AutoSize = True
              AutoStretch = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              Color = clWhite
              ParentFont = False
              ResetAfterPrint = False
              Transparent = False
              WordWrap = True
              Expression = #39#21512#12288#35745':'#39'+SUM(ADOQuery2.SellPrice)'
              FontSize = 9
            end
          end
        end
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'Select GoodsName,Min(BarCode) as BarCode,Sum(SellScalar) as Sell' +
        'Scalar,'
      'Sum(PurchasePrice) as PurchasePrice,Sum(Subtotal) as SellPrice,'
      
        'Min(Gift) as Gift,Min(UntreadFlag) as UntreadFlag,Min(Unit) as U' +
        'nit '
      'from Sell_Minor Group BY GoodsName,Gift Order BY Min(BarCode)')
    Left = 11
    Top = 11
  end
  object ADOQuery2: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from MXSP')
    Left = 11
    Top = 43
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery2
    Left = 43
    Top = 11
  end
end
