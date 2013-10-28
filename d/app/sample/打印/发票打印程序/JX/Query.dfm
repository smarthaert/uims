object FrmQuery: TFrmQuery
  Left = 0
  Top = 105
  Width = 803
  Height = 436
  Caption = '数据查询'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 795
    Height = 81
    Align = alTop
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 0
    object DRLabel1: TDRLabel
      Left = 548
      Top = 10
      Width = 12
      Height = 12
      Caption = '至'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      HiColor = clBlue
      LoColor = clNavy
      Border = boNone
      Ctl3D = True
      BlinkInterval = 300
      Blink = blNone
      ShadowColor = clSilver
      Deep = 1
    end
    object cbQYBM: TCheckBox
      Left = 15
      Top = 8
      Width = 77
      Height = 17
      Caption = '企业编码：'
      TabOrder = 0
      OnClick = cbQYBMClick
    end
    object cbFPDM: TCheckBox
      Left = 207
      Top = 8
      Width = 77
      Height = 17
      Caption = '发票代码：'
      TabOrder = 2
      OnClick = cbFPDMClick
    end
    object cbFPHM: TCheckBox
      Left = 398
      Top = 8
      Width = 77
      Height = 17
      Caption = '发票号码：'
      TabOrder = 4
      OnClick = cbFPHMClick
    end
    object cbSWDM: TCheckBox
      Left = 15
      Top = 32
      Width = 135
      Height = 17
      Caption = '对方企业税务登记号：'
      TabOrder = 7
      OnClick = cbSWDMClick
    end
    object cbJX: TCheckBox
      Left = 463
      Top = 32
      Width = 57
      Height = 17
      Caption = '进/销：'
      TabOrder = 11
      OnClick = cbJXClick
    end
    object cbSSSQ: TCheckBox
      Left = 263
      Top = 32
      Width = 86
      Height = 17
      Caption = '所属时期：'
      TabOrder = 9
      OnClick = cbSSSQClick
    end
    object EdtQYBM: TEditN
      Left = 93
      Top = 6
      Width = 100
      Height = 20
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 1
      OnKeyPress = EdtQYBMKeyPress
      ColorOnFocus = clWhite
      ColorOnNotFocus = clSilver
      FontColorOnFocus = clRed
      FontColorOnNotFocus = clBlack
      FontColorOnOverWrite = clBlue
      EditType = etString
      EditKeyByTab = #13
      EditAlign = etAlignNone
      EditLengthAlign = 0
      EditPrecision = 0
      ValueInteger = 0
      ValueDate = 36910
      ValueTime = 0.464763657407407
      TimeSeconds = False
      FirstCharUpper = False
      FirstCharUpList = ' ('
      WidthOnFocus = 0
      TextHint = True
    end
    object EdtFPDM: TEditN
      Left = 285
      Top = 6
      Width = 100
      Height = 20
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      OnKeyPress = EdtQYBMKeyPress
      ColorOnFocus = clWhite
      ColorOnNotFocus = clSilver
      FontColorOnFocus = clRed
      FontColorOnNotFocus = clBlack
      FontColorOnOverWrite = clBlue
      EditType = etString
      EditKeyByTab = #13
      EditAlign = etAlignNone
      EditLengthAlign = 0
      EditPrecision = 0
      ValueInteger = 0
      ValueDate = 36910
      ValueTime = 0.464853356481481
      TimeSeconds = False
      FirstCharUpper = False
      FirstCharUpList = ' ('
      WidthOnFocus = 0
      TextHint = True
    end
    object EdtFPHM: TEditN
      Left = 480
      Top = 6
      Width = 60
      Height = 20
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      OnKeyPress = EdtQYBMKeyPress
      ColorOnFocus = clWhite
      ColorOnNotFocus = clSilver
      FontColorOnFocus = clRed
      FontColorOnNotFocus = clBlack
      FontColorOnOverWrite = clBlue
      EditType = etString
      EditKeyByTab = #13
      EditAlign = etAlignNone
      EditLengthAlign = 0
      EditPrecision = 0
      ValueInteger = 0
      ValueDate = 36910
      ValueTime = 0.46488125
      TimeSeconds = False
      FirstCharUpper = False
      FirstCharUpList = ' ('
      WidthOnFocus = 0
      TextHint = True
    end
    object EdtSWDM: TEditN
      Left = 153
      Top = 30
      Width = 100
      Height = 20
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 15
      ParentFont = False
      TabOrder = 8
      OnKeyPress = EdtQYBMKeyPress
      ColorOnFocus = clWhite
      ColorOnNotFocus = clSilver
      FontColorOnFocus = clRed
      FontColorOnNotFocus = clBlack
      FontColorOnOverWrite = clBlue
      EditType = etString
      EditKeyByTab = #13
      EditAlign = etAlignNone
      EditLengthAlign = 0
      EditPrecision = 0
      ValueInteger = 0
      ValueDate = 36910
      ValueTime = 0.464918865740741
      TimeSeconds = False
      FirstCharUpper = False
      FirstCharUpList = ' ('
      WidthOnFocus = 0
      TextHint = True
    end
    object EdtSSSQ: TEditN
      Left = 349
      Top = 30
      Width = 100
      Height = 20
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      ColorOnFocus = clWhite
      ColorOnNotFocus = clSilver
      FontColorOnFocus = clRed
      FontColorOnNotFocus = clBlack
      FontColorOnOverWrite = clBlue
      EditType = etDate
      EditKeyByTab = #13
      EditAlign = etAlignNone
      EditLengthAlign = 0
      EditPrecision = 0
      ValueInteger = 0
      ValueDate = 36910
      ValueTime = 0.464967708333333
      TimeSeconds = False
      FirstCharUpper = False
      FirstCharUpList = ' ('
      WidthOnFocus = 0
      TextHint = True
    end
    object CmbJX: TComboBox
      Left = 525
      Top = 30
      Width = 100
      Height = 20
      Style = csDropDownList
      Color = clSilver
      ItemHeight = 12
      TabOrder = 12
      Items.Strings = (
        '进'
        '销')
    end
    object BBtnQuery: TBitBtn
      Left = 635
      Top = 6
      Width = 75
      Height = 20
      Caption = '查询'
      TabOrder = 19
      OnClick = BBtnQueryClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object BBtnPrint: TBitBtn
      Left = 194
      Top = 54
      Width = 59
      Height = 20
      Hint = '打印'
      Caption = '打印'
      TabOrder = 15
      OnClick = BBtnPrintClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
    object BBtnBack: TBitBtn
      Left = 635
      Top = 54
      Width = 75
      Height = 20
      Caption = '返回'
      TabOrder = 21
      OnClick = BBtnBackClick
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
    object EdtTitle: TEditN
      Left = 93
      Top = 54
      Width = 100
      Height = 20
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      ImeMode = imOpen
      ParentFont = False
      TabOrder = 14
      ColorOnFocus = clWhite
      ColorOnNotFocus = clSilver
      FontColorOnFocus = clRed
      FontColorOnNotFocus = clBlack
      FontColorOnOverWrite = clBlue
      EditType = etString
      EditKeyByTab = #13
      EditAlign = etAlignNone
      EditLengthAlign = 0
      EditPrecision = 0
      ValueInteger = 0
      ValueDate = 36910
      ValueTime = 0.59078587962963
      TimeSeconds = False
      FirstCharUpper = False
      FirstCharUpList = ' ('
      WidthOnFocus = 0
      TextHint = True
    end
    object cbTitle: TCheckBox
      Left = 15
      Top = 56
      Width = 76
      Height = 17
      Caption = '表头标题：'
      TabOrder = 13
      OnClick = cbTitleClick
    end
    object BBtnSave: TBitBtn
      Left = 450
      Top = 54
      Width = 59
      Height = 20
      Hint = '保存'
      Caption = '保存'
      TabOrder = 18
      OnClick = BBtnSaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
    object cbSaveToFile: TCheckBox
      Left = 263
      Top = 56
      Width = 90
      Height = 17
      Caption = '保存到文件：'
      TabOrder = 16
      OnClick = cbSaveToFileClick
    end
    object CmbFileType: TComboBox
      Left = 349
      Top = 54
      Width = 100
      Height = 20
      Style = csDropDownList
      Color = clSilver
      ItemHeight = 12
      TabOrder = 17
      Items.Strings = (
        '.TXT|ASCII文件'
        '.CSV|CSV文件'
        '.DOC|WORD文件'
        '.HTM|HTML文件'
        '.XLS|EXCEL文件')
    end
    object EdtFPHM2: TEditN
      Left = 565
      Top = 6
      Width = 60
      Height = 20
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '宋体'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 6
      OnKeyPress = EdtQYBMKeyPress
      ColorOnFocus = clWhite
      ColorOnNotFocus = clSilver
      FontColorOnFocus = clRed
      FontColorOnNotFocus = clBlack
      FontColorOnOverWrite = clBlue
      EditType = etString
      EditKeyByTab = #13
      EditAlign = etAlignNone
      EditLengthAlign = 0
      EditPrecision = 0
      ValueInteger = 0
      ValueDate = 36911
      ValueTime = 0.181204513888889
      TimeSeconds = False
      FirstCharUpper = False
      FirstCharUpList = ' ('
      WidthOnFocus = 0
      TextHint = True
    end
    object BBtnAppend: TBitBtn
      Left = 635
      Top = 30
      Width = 75
      Height = 20
      Caption = '导入'
      TabOrder = 20
      OnClick = BBtnAppendClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 81
    Width = 795
    Height = 279
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 1
    object sgFPJB: TAdvStringGrid
      Left = 4
      Top = 4
      Width = 787
      Height = 271
      Align = alClient
      BorderStyle = bsNone
      Color = clInfoBk
      ColCount = 13
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 2
      FixedRows = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnSelectCell = sgFPJBRowChanging
      Bands.Active = False
      Bands.PrimaryColor = clInfoBk
      Bands.PrimaryLength = 1
      Bands.SecondaryColor = clWindow
      Bands.SecondaryLength = 1
      Bands.Print = False
      AutoNumAlign = True
      AutoSize = False
      VAlignment = vtaTop
      EnhTextSize = False
      EnhRowColMove = False
      SortFixedCols = False
      SortNormalCellsOnly = False
      SizeWithForm = False
      Multilinecells = False
      OnGetCellColor = sgFPJBGetCellColor
      OnGetAlignment = sgFPJBGetAlignment
      OnRowChanging = sgFPJBRowChanging
      SortDirection = sdAscending
      SortFull = True
      SortAutoFormat = True
      SortShow = False
      SortIndexShow = False
      EnableGraphics = False
      EnableHTML = True
      EnableWheel = True
      Flat = False
      SortColumn = 0
      HintColor = clYellow
      SelectionColor = clHighlight
      SelectionTextColor = clHighlightText
      SelectionRectangle = False
      SelectionRTFKeep = False
      HintShowCells = False
      HintShowLargeText = False
      OleAcceptFiles = True
      OleAcceptText = True
      PrintSettings.FooterSize = 200
      PrintSettings.HeaderSize = 200
      PrintSettings.Time = ppNone
      PrintSettings.Date = ppBottomRight
      PrintSettings.DateFormat = 'YYYY-MM-DD'
      PrintSettings.PageNr = ppBottomCenter
      PrintSettings.Title = ppTopCenter
      PrintSettings.Font.Charset = GB2312_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -12
      PrintSettings.Font.Name = '宋体'
      PrintSettings.Font.Style = []
      PrintSettings.HeaderFont.Charset = GB2312_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -21
      PrintSettings.HeaderFont.Name = '宋体'
      PrintSettings.HeaderFont.Style = [fsBold]
      PrintSettings.FooterFont.Charset = GB2312_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -12
      PrintSettings.FooterFont.Name = '宋体'
      PrintSettings.FooterFont.Style = []
      PrintSettings.Borders = pbSingle
      PrintSettings.BorderStyle = psSolid
      PrintSettings.Centered = False
      PrintSettings.RepeatFixedRows = True
      PrintSettings.RepeatFixedCols = False
      PrintSettings.LeftSize = 200
      PrintSettings.RightSize = 200
      PrintSettings.ColumnSpacing = 10
      PrintSettings.RowSpacing = 10
      PrintSettings.TitleSpacing = 200
      PrintSettings.Orientation = poPortrait
      PrintSettings.FixedWidth = 0
      PrintSettings.FixedHeight = 0
      PrintSettings.UseFixedHeight = False
      PrintSettings.UseFixedWidth = False
      PrintSettings.FitToPage = fpShrink
      PrintSettings.PageNumSep = '/'
      PrintSettings.NoAutoSize = False
      PrintSettings.PrintGraphics = False
      HTMLSettings.Width = 100
      Navigation.AllowInsertRow = False
      Navigation.AllowDeleteRow = False
      Navigation.AdvanceOnEnter = False
      Navigation.AdvanceInsert = False
      Navigation.AutoGotoWhenSorted = False
      Navigation.AutoGotoIncremental = False
      Navigation.AutoComboDropSize = False
      Navigation.AdvanceDirection = adLeftRight
      Navigation.AllowClipboardShortCuts = False
      Navigation.AllowSmartClipboard = False
      Navigation.AllowRTFClipboard = False
      Navigation.AllowClipboardAlways = False
      Navigation.AllowClipboardRowGrow = True
      Navigation.AllowClipboardColGrow = True
      Navigation.AdvanceAuto = False
      Navigation.InsertPosition = pInsertBefore
      Navigation.CursorWalkEditor = False
      Navigation.MoveRowOnSort = False
      Navigation.ImproveMaskSel = False
      Navigation.AlwaysEdit = False
      Navigation.CopyHTMLTagsToClipboard = True
      Navigation.LineFeedOnEnter = False
      ColumnSize.Save = False
      ColumnSize.Stretch = False
      ColumnSize.Location = clRegistry
      CellNode.Color = clSilver
      CellNode.NodeType = cnFlat
      CellNode.NodeColor = clBlack
      SizeWhileTyping.Height = False
      SizeWhileTyping.Width = False
      MaxEditLength = 0
      MouseActions.AllSelect = False
      MouseActions.ColSelect = False
      MouseActions.RowSelect = False
      MouseActions.DirectEdit = False
      MouseActions.DirectComboDrop = False
      MouseActions.DisjunctRowSelect = False
      MouseActions.AllColumnSize = False
      MouseActions.AllRowSize = False
      MouseActions.CaretPositioning = False
      IntelliPan = ipVertical
      URLColor = clBlue
      URLShow = False
      URLFull = False
      URLEdit = False
      ScrollType = ssNormal
      ScrollColor = clNone
      ScrollWidth = 18
      ScrollSynch = False
      ScrollProportional = False
      ScrollHints = shNone
      OemConvert = False
      FixedFooters = 0
      FixedRightCols = 0
      FixedColWidth = 62
      FixedRowHeight = 18
      FixedFont.Charset = GB2312_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = '宋体'
      FixedFont.Style = []
      FixedAsButtons = False
      FloatFormat = '%.2f'
      WordWrap = False
      ColumnHeaders.Strings = (
        '企业编码'
        '发票种类'
        '发票代码'
        '发票号码'
        '对方企业税务登记号'
        '进/销'
        '所属时期'
        '销售额'
        '税率'
        '税额'
        '开票日期'
        '录入日期'
        '操作员')
      Lookup = False
      LookupCaseSensitive = False
      LookupHistory = False
      BackGround.Top = 0
      BackGround.Left = 0
      BackGround.Display = bdTile
      BackGround.Cells = bcNormal
      Filter = <>
      ColWidths = (
        62
        62
        62
        62
        122
        44
        62
        80
        38
        80
        62
        62
        50)
      RowHeights = (
        18
        18)
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 360
    Width = 795
    Height = 49
    Align = alBottom
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 2
    object Gauge1: TGauge
      Left = 597
      Top = 23
      Width = 180
      Height = 18
      BackColor = clSilver
      ForeColor = clBlue
      Progress = 0
      Visible = False
    end
    object CheckBox1: TCheckBox
      Left = 10
      Top = 4
      Width = 70
      Height = 17
      Caption = '企业编码'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Tag = 1
      Left = 100
      Top = 4
      Width = 70
      Height = 17
      Caption = '发票种类'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object CheckBox3: TCheckBox
      Tag = 2
      Left = 189
      Top = 4
      Width = 70
      Height = 17
      Caption = '发票代码'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object CheckBox4: TCheckBox
      Tag = 3
      Left = 279
      Top = 4
      Width = 70
      Height = 17
      Caption = '发票号码'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = CheckBox1Click
    end
    object CheckBox5: TCheckBox
      Tag = 4
      Left = 370
      Top = 4
      Width = 130
      Height = 17
      Caption = '对方企业税务登记号'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox1Click
    end
    object CheckBox6: TCheckBox
      Tag = 5
      Left = 514
      Top = 4
      Width = 70
      Height = 17
      Caption = '进/销'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBox1Click
    end
    object CheckBox7: TCheckBox
      Tag = 6
      Left = 597
      Top = 4
      Width = 70
      Height = 17
      Caption = '所属时期'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = CheckBox1Click
    end
    object CheckBox8: TCheckBox
      Tag = 7
      Left = 10
      Top = 24
      Width = 70
      Height = 17
      Caption = '销售额'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = CheckBox1Click
    end
    object CheckBox9: TCheckBox
      Tag = 8
      Left = 100
      Top = 24
      Width = 70
      Height = 17
      Caption = '税率'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBox1Click
    end
    object CheckBox10: TCheckBox
      Tag = 9
      Left = 189
      Top = 24
      Width = 70
      Height = 17
      Caption = '税额'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBox1Click
    end
    object CheckBox11: TCheckBox
      Tag = 10
      Left = 279
      Top = 24
      Width = 70
      Height = 17
      Caption = '开票日期'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBox1Click
    end
    object CheckBox12: TCheckBox
      Tag = 11
      Left = 370
      Top = 24
      Width = 70
      Height = 17
      Caption = '录入日期'
      Checked = True
      State = cbChecked
      TabOrder = 11
      OnClick = CheckBox1Click
    end
    object CheckBox13: TCheckBox
      Tag = 12
      Left = 514
      Top = 24
      Width = 70
      Height = 17
      Caption = '操作员'
      Checked = True
      State = cbChecked
      TabOrder = 12
      OnClick = CheckBox1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.DBF'
    Filter = 'BDF数据库文件(*.DBF)|*.DBF'
    InitialDir = 'A:\'
    Title = '请选择一个DBF数据库文件:'
    Left = 760
  end
end
