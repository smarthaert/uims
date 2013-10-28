object frmEnterpriseRegister: TfrmEnterpriseRegister
  Left = 100
  Top = 75
  BorderStyle = bsDialog
  Caption = '企业登记'
  ClientHeight = 408
  ClientWidth = 661
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 161
    Top = 37
    Width = 3
    Height = 283
    Cursor = crHSplit
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 661
    Height = 37
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    Caption = 'pnlTop'
    TabOrder = 0
    object lblTitle: TDRLabel
      Left = 3
      Top = 3
      Width = 655
      Height = 31
      Align = alClient
      Alignment = taCenter
      Caption = '委托企业登记'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = '楷体_GB2312'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      HiColor = clBlue
      LoColor = clNavy
      Border = boNone
      Ctl3D = True
      BlinkInterval = 300
      Blink = blNone
      Deep = 1
    end
  end
  object pnlEdit: TPanel
    Left = 0
    Top = 320
    Width = 661
    Height = 88
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    Caption = 'pnlEdit'
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 3
      Top = 3
      Width = 655
      Height = 82
      ActivePage = TabSheet1
      Align = alClient
      MultiLine = True
      TabOrder = 0
      TabPosition = tpRight
      object TabSheet1: TTabSheet
        Caption = 'TabSheet1'
        TabVisible = False
        object bbtnNew: TBitBtn
          Left = 12
          Top = 14
          Width = 80
          Height = 45
          Caption = '添加'
          TabOrder = 0
          OnClick = bbtnNewClick
        end
        object bbtnModify: TBitBtn
          Left = 103
          Top = 14
          Width = 80
          Height = 45
          Caption = '修改'
          TabOrder = 1
          OnClick = bbtnModifyClick
        end
        object bbtnDelete: TBitBtn
          Left = 193
          Top = 14
          Width = 80
          Height = 45
          Caption = '删除'
          TabOrder = 2
          OnClick = bbtnDeleteClick
        end
        object bbtnPrint: TBitBtn
          Left = 465
          Top = 14
          Width = 80
          Height = 45
          Caption = '打印'
          TabOrder = 3
          OnClick = bbtnPrintClick
        end
        object bbtnClose: TBitBtn
          Left = 556
          Top = 14
          Width = 80
          Height = 45
          Caption = '关闭'
          TabOrder = 4
          OnClick = bbtnCloseClick
        end
        object bbtnCharge: TBitBtn
          Left = 284
          Top = 14
          Width = 80
          Height = 45
          Caption = '收费'
          TabOrder = 5
          OnClick = bbtnChargeClick
        end
        object bbtnPreview: TBitBtn
          Left = 375
          Top = 14
          Width = 80
          Height = 45
          Caption = '预览'
          TabOrder = 6
          OnClick = bbtnPreviewClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 1
        TabVisible = False
        object Label1: TDRLabel
          Left = 37
          Top = 4
          Width = 60
          Height = 12
          Caption = '纳税代码：'
          HiColor = clBlue
          LoColor = clNavy
          Border = boNone
          Ctl3D = True
          BlinkInterval = 300
          Blink = blNone
          Deep = 1
        end
        object Label3: TDRLabel
          Left = 212
          Top = 4
          Width = 84
          Height = 12
          Caption = '委托企业全称：'
          HiColor = clBlue
          LoColor = clNavy
          Border = boNone
          Ctl3D = True
          BlinkInterval = 300
          Blink = blNone
          Deep = 1
        end
        object Label5: TDRLabel
          Left = 37
          Top = 56
          Width = 60
          Height = 12
          Caption = '电话号码：'
          HiColor = clBlue
          LoColor = clNavy
          Border = boNone
          Ctl3D = True
          BlinkInterval = 300
          Blink = blNone
          Deep = 1
        end
        object Label2: TDRLabel
          Left = 13
          Top = 30
          Width = 84
          Height = 12
          Caption = '税务登记证号：'
          HiColor = clBlue
          LoColor = clNavy
          Border = boNone
          Ctl3D = True
          BlinkInterval = 300
          Blink = blNone
          Deep = 1
        end
        object Label4: TDRLabel
          Left = 236
          Top = 30
          Width = 60
          Height = 12
          Caption = '详细地址：'
          HiColor = clBlue
          LoColor = clNavy
          Border = boNone
          Ctl3D = True
          BlinkInterval = 300
          Blink = blNone
          Deep = 1
        end
        object Label6: TDRLabel
          Left = 248
          Top = 56
          Width = 48
          Height = 12
          Caption = '联系人：'
          HiColor = clBlue
          LoColor = clNavy
          Border = boNone
          Ctl3D = True
          BlinkInterval = 300
          Blink = blNone
          Deep = 1
        end
        object lblAffiliateTown: TDRLabel
          Left = 454
          Top = 56
          Width = 96
          Height = 12
          Alignment = taRightJustify
          Caption = 'lblAffiliateTown'
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
          Deep = 1
        end
        object edtRatepayingNo: TEditN
          Left = 101
          Top = 0
          Width = 94
          Height = 20
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ImeMode = imClose
          MaxLength = 6
          ParentFont = False
          TabOrder = 0
          Text = 'edtRatepayingNo'
          OnExit = edtRatepayingNoExit
          OnKeyPress = edtRatepayingNoKeyPress
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
          ValueDate = 36942
          ValueTime = 0.118781365740741
          TimeSeconds = False
          FirstCharUpper = False
          FirstCharUpList = ' ('
          WidthOnFocus = 0
          TextHint = True
        end
        object edtEnterpriseName: TEditN
          Left = 300
          Top = 0
          Width = 250
          Height = 20
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ImeMode = imOpen
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          Text = 'edtEnterpriseName'
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
          ValueDate = 36942
          ValueTime = 0.118789699074074
          TimeSeconds = False
          FirstCharUpper = False
          FirstCharUpList = ' ('
          WidthOnFocus = 0
          TextHint = True
        end
        object edtTelephoneNo: TEditN
          Left = 101
          Top = 52
          Width = 94
          Height = 20
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ImeMode = imClose
          MaxLength = 13
          ParentFont = False
          TabOrder = 4
          Text = 'edtTelephoneNo'
          OnKeyPress = edtRatepayingNoKeyPress
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
          ValueDate = 36942
          ValueTime = 0.118798611111111
          TimeSeconds = False
          FirstCharUpper = False
          FirstCharUpList = ' ('
          WidthOnFocus = 0
          TextHint = True
        end
        object edtTaxRegisterNo: TEditN
          Left = 101
          Top = 26
          Width = 94
          Height = 20
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ImeMode = imClose
          MaxLength = 15
          ParentFont = False
          TabOrder = 2
          Text = 'edtTaxRegisterNo'
          OnExit = edtTaxRegisterNoExit
          OnKeyPress = edtRatepayingNoKeyPress
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
          ValueDate = 36942
          ValueTime = 0.118785185185185
          TimeSeconds = False
          FirstCharUpper = False
          FirstCharUpList = ' ('
          WidthOnFocus = 0
          TextHint = True
        end
        object edtDetailAddress: TEditN
          Left = 300
          Top = 26
          Width = 250
          Height = 20
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ImeMode = imOpen
          MaxLength = 50
          ParentFont = False
          TabOrder = 3
          Text = 'edtDetailAddress'
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
          ValueDate = 36942
          ValueTime = 0.118794097222222
          TimeSeconds = False
          FirstCharUpper = False
          FirstCharUpList = ' ('
          WidthOnFocus = 0
          TextHint = True
        end
        object edtLinkman: TEditN
          Left = 300
          Top = 52
          Width = 94
          Height = 20
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          ImeMode = imOpen
          MaxLength = 8
          ParentFont = False
          TabOrder = 5
          Text = 'edtLinkman'
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
          ValueDate = 36942
          ValueTime = 0.118802430555556
          TimeSeconds = False
          FirstCharUpper = False
          FirstCharUpList = ' ('
          WidthOnFocus = 0
          TextHint = True
        end
        object bbtnSave: TBitBtn
          Left = 564
          Top = 3
          Width = 75
          Height = 30
          Caption = '保存'
          TabOrder = 6
          OnClick = bbtnSaveClick
        end
        object bbtnCancel: TBitBtn
          Left = 564
          Top = 39
          Width = 75
          Height = 30
          Caption = '放弃'
          TabOrder = 7
          OnClick = bbtnCancelClick
        end
      end
    end
  end
  object pnlBrowse: TPanel
    Left = 164
    Top = 37
    Width = 497
    Height = 283
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    Caption = 'pnlBrowse'
    TabOrder = 2
    object sgEnterprise: TAdvStringGrid
      Left = 3
      Top = 3
      Width = 491
      Height = 277
      Align = alClient
      BorderStyle = bsNone
      Color = clInfoBk
      ColCount = 6
      Ctl3D = True
      DefaultColWidth = 80
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 2
      FixedRows = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentCtl3D = False
      TabOrder = 0
      OnKeyDown = sgEnterpriseKeyDown
      Bands.Active = False
      Bands.PrimaryColor = clInfoBk
      Bands.PrimaryLength = 1
      Bands.SecondaryColor = clWindow
      Bands.SecondaryLength = 1
      Bands.Print = False
      AutoNumAlign = False
      AutoSize = False
      VAlignment = vtaTop
      EnhTextSize = False
      EnhRowColMove = False
      SortFixedCols = False
      SortNormalCellsOnly = True
      SizeWithForm = False
      Multilinecells = False
      OnGetCellColor = sgEnterpriseGetCellColor
      OnGetAlignment = sgEnterpriseGetAlignment
      OnRowChanging = sgEnterpriseRowChanging
      OnPrintStart = sgEnterprisePrintStart
      OnClickCell = sgEnterpriseClickCell
      SortDirection = sdAscending
      SortFull = True
      SortAutoFormat = True
      SortShow = True
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
      PrintSettings.FooterSize = 100
      PrintSettings.HeaderSize = 100
      PrintSettings.Time = ppNone
      PrintSettings.Date = ppBottomRight
      PrintSettings.DateFormat = 'YYYY-MM-DD'
      PrintSettings.PageNr = ppBottomCenter
      PrintSettings.Title = ppTopCenter
      PrintSettings.TitleLines.Strings = (
        '委托代理企业名单')
      PrintSettings.Font.Charset = GB2312_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -12
      PrintSettings.Font.Name = '宋体'
      PrintSettings.Font.Style = []
      PrintSettings.HeaderFont.Charset = GB2312_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -24
      PrintSettings.HeaderFont.Name = '楷体_GB2312'
      PrintSettings.HeaderFont.Style = [fsBold]
      PrintSettings.FooterFont.Charset = GB2312_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -12
      PrintSettings.FooterFont.Name = '宋体'
      PrintSettings.FooterFont.Style = []
      PrintSettings.Borders = pbSingle
      PrintSettings.BorderStyle = psSolid
      PrintSettings.Centered = True
      PrintSettings.RepeatFixedRows = True
      PrintSettings.RepeatFixedCols = True
      PrintSettings.LeftSize = 100
      PrintSettings.RightSize = 100
      PrintSettings.ColumnSpacing = 0
      PrintSettings.RowSpacing = 0
      PrintSettings.TitleSpacing = 50
      PrintSettings.Orientation = poPortrait
      PrintSettings.PagePrefix = '第'
      PrintSettings.PageSuffix = '页'
      PrintSettings.FixedWidth = 0
      PrintSettings.FixedHeight = 0
      PrintSettings.UseFixedHeight = False
      PrintSettings.UseFixedWidth = False
      PrintSettings.FitToPage = fpShrink
      PrintSettings.PageNumSep = '/'
      PrintSettings.NoAutoSize = True
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
        '纳税代码'
        '税务登记证号'
        '委托企业全称'
        '详细地址'
        '联系电话'
        '联系人')
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
        86
        86
        62
        62
        127)
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 37
    Width = 161
    Height = 283
    Align = alLeft
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    Caption = 'pnlLeft'
    TabOrder = 3
    object TreeView: TTreeView
      Left = 3
      Top = 3
      Width = 155
      Height = 277
      Align = alClient
      BorderStyle = bsNone
      Color = clInfoBk
      Images = ilNodeImages
      Indent = 19
      ParentShowHint = False
      ReadOnly = True
      ShowHint = False
      TabOrder = 0
      OnChange = TreeViewChange
    end
  end
  object ilNodeImages: TImageList
    Left = 128
    Top = 109
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000001F00
      0000000000000000000000000000000000000000000000000000000000000000
      1F0000001F000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E000000000000000000001F000000
      1F0000000000000000000000000000000000000000000000000000001F001F00
      0000FF7F00001F00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000001F000000FF7F
      00001F00000000000000000000000000000000000000000000001F0000000000
      FF7F0000FF7F00001F0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000001F000000FF7FFF7F
      FF7F00001F000000000000000000000000000000000000001F0000000000FF7F
      FF7FFF7F0000FF7F00001F000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000001F001F001F000000FF7F
      FF7FFF7F00001F000000000000000000000000001F001F000000FF7FFF7FFF7F
      FF7FFF7FFF7F0000FF7F00001F00000000000000000000000000000000000000
      007C00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00001F001F001F001F001F000000
      FF7FFF7FFF7F00001F0000000000000000001F0000000000FF7F0000FF7FFF7F
      FF7FFF7FFF7FFF7F0000FF7F00001F0000000000000000000000000000000000
      007C007C007C000000000000000000000000FFFFFFFFEF3DEF3DFFFFFF7FFF7F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F001F001F001F001F001F001F00
      0000FF7FFF7FFF7F00001F0000000000000000000000FF7FFF7FFF7F0000FF7F
      FF7FFF7FFF7FFF7FFF7F0000FF7F00001F000000000000000000000000000000
      007C007C007C007C007C0000000000000000EF3DEF3DFFFFFF7FFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF7FFF7FFF7F1F000F001F001F001F001F001F00
      1F000000FF7FFF7FFF7F00001F00000000000000FF7FFF7FFF7FFF7FFF7F0000
      FF7FFF7FFF7FFF7FFF7FFF7F0000FF7F00000000007C007C007C007C007C007C
      007C007C007C007C007C007C007C00000000FFFFFFFFFFFFFFFFEF3DEF3DEF3D
      EF3DEF3DEF3DEF3DFF7FFFFFFFFFFFFFFF7F00001F000F001F001F0000001F00
      1F001F000000FF7FFF7FFF7F00001F00000000000000FF7FFF7FFF7FFF7FFF7F
      0000FF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000000000000000
      007C007C007C007C007C0000000000000000FFFFFFFFEF3DEF3DFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000001F000F001F001F001F00
      00001F001F000000FF7F00001F0000000000000000000000FF7FFF7FFF7FFF7F
      FF7F0000FF7FFF7FFF7F00000000000000000000000000000000000000000000
      007C007C007C000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000001F000F001F000000
      00001F001F001F00000000000000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000000000000000000000000000
      007C00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000001F000F001F00
      1F001F001F001F001F00000000000000000000000000000000000000FF7FFF7F
      FF7F000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03DE03DE03D
      E03DE03DE03DE03DE03DE03DE03DE03DE03D000000000000000000001F000F00
      1F001F001F001F00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03DE03DEF3D
      EF3DE03DFF7FFF7FE03DE03DE03DE03DE03D0000000000000000000000001F00
      0F001F0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EF3DFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FE03DE03DE03DE03DE03DFF7FEF3DEF3D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E03DE03DE03DE03DE03DE03DEF3D
      EF3DE03DE03DE03DE03DE03DE03DE03DE03D424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FDFFFE3FFFFF0000
      F8FFF81FFFFFFE06F07FF40FFFFF0000E03FE007FCFFFE06C01F8003FC3FA301
      800F4001FC0F0000000700000003A701000300000000FE068001800100030000
      C003C003FC0F0000E00FE00FFC3F0000F00FF07FFCFF3353F81FF8FFFFFF4F20
      FC7FFFFFFFFF0000FFFFFFFFFFFF2703}
  end
  object AdvPreviewDialog1: TAdvPreviewDialog
    Grid = sgEnterprise
    PreviewFast = True
    PreviewWidth = 350
    PreviewHeight = 300
    PreviewLeft = 100
    PreviewTop = 100
    PreviewCenter = True
    Left = 172
    Top = 109
  end
end
