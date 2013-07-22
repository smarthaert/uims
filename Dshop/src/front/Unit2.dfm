object Main: TMain
  Left = 224
  Top = 75
  Width = 804
  Height = 597
  ActiveControl = RzEdit4
  Caption = 'Main'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWhite
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 796
    Height = 25
    Align = alTop
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 736
      Top = 3
      Width = 58
      Height = 19
      Caption = 'Esc.'#36864#20986
      Flat = True
      ParentShowHint = False
      ShowHint = False
      OnClick = SpeedButton1Click
    end
    object Label1: TLabel
      Left = 8
      Top = 7
      Width = 216
      Height = 12
      Caption = #32593#32852#31185#25216#36229#24066#31649#29702#31995#32479'('#21333#26426#29256')'#8212#8212#21069#21488
    end
    object RzFormShape1: TRzFormShape
      Left = 2
      Top = 2
      Width = 654
      Height = 21
      Align = alCustom
    end
    object SpeedButton2: TSpeedButton
      Left = 656
      Top = 3
      Width = 79
      Height = 19
      Caption = 'F12.'#31383#21475#23621#20013
      Flat = True
      ParentShowHint = False
      ShowHint = False
      OnClick = SpeedButton2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 590
    Height = 481
    Align = alClient
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 586
      Height = 477
      TabStop = False
      Align = alClient
      BorderStyle = bsNone
      Color = clBlack
      Ctl3D = False
      DataSource = DataSource1
      FixedColor = clBlack
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnKeyUp = DBGrid1KeyUp
      OnMouseUp = DBGrid1MouseUp
      Columns = <
        item
          Expanded = False
          FieldName = 'BarCode'
          Title.Alignment = taCenter
          Title.Caption = #21830#21697#26465#30721
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GoodsName'
          Title.Alignment = taCenter
          Title.Caption = #21830#21697#21517#31216
          Width = 130
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Unit'
          Title.Alignment = taCenter
          Title.Caption = #21333#20301
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SellPrice'
          Title.Alignment = taCenter
          Title.Caption = #21333#20215
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SellScalar'
          Title.Alignment = taCenter
          Title.Caption = #25968#37327
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Agio'
          Title.Alignment = taCenter
          Title.Caption = #25240#25187
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Gift'
          Title.Alignment = taCenter
          Title.Caption = #36192#21697
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Subtotal'
          Title.Alignment = taCenter
          Title.Caption = #23567#35745
          Width = 55
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 506
    Width = 796
    Height = 64
    Align = alBottom
    BevelInner = bvLowered
    Color = clBlack
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    object Label2: TLabel
      Left = 15
      Top = 10
      Width = 168
      Height = 16
      Caption = 'F1.'#21830#21697#26465#30721'/'#25340#38899#31616#30721':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 223
      Top = 38
      Width = 48
      Height = 12
      Caption = 'F4.'#25968#37327':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 119
      Top = 38
      Width = 48
      Height = 12
      Caption = 'F3.'#21333#20215':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 339
      Top = 22
      Width = 66
      Height = 21
      Caption = #24212#25910': '
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 387
      Top = 15
      Width = 111
      Height = 33
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 499
      Top = 22
      Width = 22
      Height = 21
      Caption = #20803
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 327
      Top = 4
      Width = 2
      Height = 56
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Label17: TLabel
      Left = 15
      Top = 38
      Width = 48
      Height = 12
      Caption = 'F2.'#25240#25187':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 532
      Top = 4
      Width = 2
      Height = 56
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Label25: TLabel
      Left = 543
      Top = 22
      Width = 77
      Height = 21
      Caption = #21333#21495':'#8470
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 624
      Top = 15
      Width = 160
      Height = 33
      Caption = '0411070001'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RzEdit1: TRzEdit
      Left = 64
      Top = 35
      Width = 42
      Height = 20
      Text = '100'
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 0
      OnKeyPress = RzEdit1KeyPress
    end
    object RzEdit2: TRzEdit
      Left = 167
      Top = 35
      Width = 42
      Height = 20
      Text = '5'
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 1
      OnKeyPress = RzEdit2KeyPress
    end
    object RzEdit3: TRzEdit
      Left = 272
      Top = 35
      Width = 42
      Height = 20
      Text = '1'
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 2
      OnKeyPress = RzEdit3KeyPress
    end
    object RzEdit4: TRzEdit
      Left = 184
      Top = 7
      Width = 129
      Height = 22
      AutoSize = False
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      OnKeyPress = RzEdit4KeyPress
    end
  end
  object Panel4: TPanel
    Left = 590
    Top = 25
    Width = 206
    Height = 481
    Align = alRight
    BevelInner = bvLowered
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label5: TLabel
      Left = 9
      Top = 379
      Width = 90
      Height = 19
      Caption = #19978#21333#24212#20184':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 9
      Top = 411
      Width = 90
      Height = 19
      Caption = #19978#21333#23454#20184':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 9
      Top = 443
      Width = 90
      Height = 19
      Caption = #19978#21333#25214#38646':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 177
      Top = 379
      Width = 20
      Height = 19
      Caption = #20803
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 177
      Top = 411
      Width = 20
      Height = 19
      Caption = #20803
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 177
      Top = 443
      Width = 20
      Height = 19
      Caption = #20803
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 96
      Top = 379
      Width = 80
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 96
      Top = 411
      Width = 80
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 96
      Top = 443
      Width = 80
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 4
      Top = 360
      Width = 197
      Height = 2
      Shape = bsBottomLine
      Style = bsRaised
    end
    object Label18: TLabel
      Left = 17
      Top = 21
      Width = 90
      Height = 19
      Caption = #25805' '#20316' '#21592':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 108
      Top = 21
      Width = 11
      Height = 19
      Caption = '0'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 17
      Top = 53
      Width = 90
      Height = 19
      Caption = #30331#24405#26102#38388':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 108
      Top = 53
      Width = 11
      Height = 22
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Bevel4: TBevel
      Left = 4
      Top = 88
      Width = 197
      Height = 2
      Shape = bsBottomLine
      Style = bsRaised
    end
    object Label23: TLabel
      Left = 26
      Top = 101
      Width = 154
      Height = 14
      Caption = #25353'"'#65291#12289#65293'"'#35843#25972#21830#21697#25968#37327
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 26
      Top = 126
      Width = 154
      Height = 14
      Caption = #25353'"'#8593#12289#8595'"'#36873#25321#32534#36753#35760#24405
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 26
      Top = 151
      Width = 154
      Height = 14
      Caption = 'Space('#31354#26684#38190').'#32467#36134#25910#27454
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 27
      Top = 200
      Width = 154
      Height = 14
      Caption = 'F5. '#23450#20041#25110#21462#28040#36192#21697#36873#25321
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 27
      Top = 224
      Width = 154
      Height = 14
      Caption = 'F6 .'#25346#21333#12288#12288#12288'F7. '#21462#21333
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 27
      Top = 176
      Width = 154
      Height = 14
      Caption = 'Delete. '#21024#38500#24050#24405#20837#21830#21697
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 27
      Top = 248
      Width = 154
      Height = 14
      Caption = 'F8 .'#36864#36135#12288'F9 .'#21069#21488#35774#32622
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel5: TPanel
    Left = 19
    Top = 270
    Width = 242
    Height = 213
    Color = clBlack
    TabOrder = 4
    Visible = False
    object QuickRep1: TQuickRep
      Left = 11
      Top = 12
      Width = 220
      Height = 190
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      DataSet = ADOQuery1
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
      OnStartPage = QuickRep1StartPage
      Options = [FirstPageHeader, LastPageFooter]
      Page.Columns = 1
      Page.Orientation = poPortrait
      Page.PaperSize = Custom
      Page.Values = (
        0.000000000000000000
        502.700000000000000000
        0.000000000000000000
        582.000000000000000000
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
          521.229166666666700000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbDetail
        object QRDBText1: TQRDBText
          Left = 6
          Top = 3
          Width = 83
          Height = 13
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            34.395833333333330000
            15.875000000000000000
            7.937500000000000000
            219.604166666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
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
        object QRExpr1: TQRExpr
          Left = 89
          Top = 2
          Width = 31
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.333333333333330000
            235.479166666666700000
            5.291666666666667000
            82.020833333333320000)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Color = clWhite
          ParentFont = False
          ResetAfterPrint = False
          Transparent = False
          WordWrap = True
          Expression = 'FORMATNUMERIC('#39'0.00'#39',ADOQuery1.SellPrice)'
          FontSize = 9
        end
        object QRExpr2: TQRExpr
          Left = 120
          Top = 2
          Width = 31
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.333333333333330000
            317.500000000000000000
            5.291666666666667000
            82.020833333333320000)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Color = clWhite
          ParentFont = False
          ResetAfterPrint = False
          Transparent = False
          WordWrap = True
          Expression = 'FORMATNUMERIC('#39'0.0'#39',ADOQuery1.SellScalar)'
          FontSize = 9
        end
        object QRExpr3: TQRExpr
          Left = 153
          Top = 2
          Width = 33
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.333333333333330000
            404.812500000000000000
            5.291666666666667000
            87.312500000000000000)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Color = clWhite
          ParentFont = False
          ResetAfterPrint = False
          Transparent = False
          WordWrap = True
          Expression = 'FORMATNUMERIC('#39'0.00'#39',ADOQuery1.Subtotal)'
          FontSize = 9
        end
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
          Left = 151
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
            399.520833333333300000
            0.000000000000000000
            5.291666666666667000)
          Pen.Style = psDot
          Shape = qrsVertLine
          VertAdjust = 0
        end
        object QRShape4: TQRShape
          Left = 120
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
            317.500000000000000000
            0.000000000000000000
            5.291666666666667000)
          Pen.Style = psDot
          Shape = qrsVertLine
          VertAdjust = 0
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
          521.229166666666700000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbPageHeader
        object QRLabel1: TQRLabel
          Left = 6
          Top = 8
          Width = 185
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            15.875000000000000000
            21.166666666666670000
            489.479166666666700000)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = #36196#23792#30334#19968#36229#24066
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 11
        end
        object QRLabel2: TQRLabel
          Left = 6
          Top = 32
          Width = 185
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            15.875000000000000000
            84.666666666666680000
            489.479166666666700000)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = #30334#19968#28040#36153#12288#26102#23578#21697#20301
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 11
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
            34.395833333333330000
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
        object QRLabel4: TQRLabel
          Left = 104
          Top = 56
          Width = 25
          Height = 13
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            34.395833333333330000
            275.166666666666700000
            148.166666666666700000
            66.145833333333330000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21806#20215
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
        object QRShape2: TQRShape
          Left = 5
          Top = 24
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
            13.229166666666670000
            63.500000000000000000
            484.187500000000000000)
          Pen.Style = psDot
          Shape = qrsHorLine
          VertAdjust = 0
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
          Left = 131
          Top = 56
          Width = 25
          Height = 13
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            34.395833333333330000
            346.604166666666700000
            148.166666666666700000
            66.145833333333330000)
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
          Left = 162
          Top = 56
          Width = 25
          Height = 13
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            34.395833333333330000
            428.625000000000000000
            148.166666666666700000
            66.145833333333330000)
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
      end
      object SummaryBand1: TQRBand
        Left = 12
        Top = 85
        Width = 197
        Height = 92
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
          243.416666666666700000
          521.229166666666700000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbSummary
        object QRLabel7: TQRLabel
          Left = 7
          Top = 6
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            18.520833333333330000
            15.875000000000000000
            177.270833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #24212#25910':999.99'
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
        object QRLabel9: TQRLabel
          Left = 7
          Top = 19
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            18.520833333333330000
            50.270833333333330000
            177.270833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25214#38646':999.99'
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
        object QRLabel8: TQRLabel
          Left = 95
          Top = 6
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            251.354166666666700000
            15.875000000000000000
            177.270833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #23454#25910':999.99'
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
        object QRLabel10: TQRLabel
          Left = 95
          Top = 19
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            251.354166666666700000
            50.270833333333330000
            177.270833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25910#27454':'#26446#29233#25991
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
        object QRLabel12: TQRLabel
          Left = 7
          Top = 45
          Width = 103
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            18.520833333333330000
            119.062500000000000000
            272.520833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21333#21495':'#8470'0411070001'
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
        object QRLabel11: TQRLabel
          Left = 7
          Top = 32
          Width = 169
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            18.520833333333330000
            84.666666666666670000
            447.145833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #26085#26399':2004'#24180'11'#26376'28'#26085' 10:33:26'
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
        object QRLabel13: TQRLabel
          Left = 7
          Top = 58
          Width = 186
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            18.520833333333330000
            153.458333333333300000
            492.125000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = #30005#35805':0476-8220123'
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
        object QRShape8: TQRShape
          Left = 4
          Top = 70
          Width = 189
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
            185.208333333333300000
            500.062500000000000000)
          Pen.Style = psDot
          Shape = qrsHorLine
          VertAdjust = 0
        end
        object QRLabel14: TQRLabel
          Left = 4
          Top = 75
          Width = 189
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            10.583333333333330000
            198.437500000000000000
            500.062500000000000000)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = #20973#31080#19971#26085#20869#36864#25442#37096#20998#36135#12289#24403#26376#24320#21457#31080
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
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 40
    Top = 81
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Sell_Minor')
    Left = 8
    Top = 81
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Stock')
    Left = 8
    Top = 113
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Documents and Se' +
      'ttings\user\'#26700#38754'\NewShop\Data.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 8
    Top = 49
  end
  object ADOQuery3: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 8
    Top = 145
  end
end
