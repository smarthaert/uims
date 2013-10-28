object psPrintParamsFmt: TpsPrintParamsFmt
  Left = 202
  Top = 87
  Width = 660
  Height = 543
  BorderStyle = bsSizeToolWin
  Caption = 'Barcode print parameters'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 282
    Top = 0
    Height = 474
  end
  object Panel1: TPanel
    Left = 0
    Top = 474
    Width = 652
    Height = 35
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object btnOK: TBitBtn
      Left = 8
      Top = 6
      Width = 77
      Height = 25
      TabOrder = 0
      OnClick = btnOKClick
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 91
      Top = 6
      Width = 78
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object btnHelp: TBitBtn
      Left = 175
      Top = 6
      Width = 89
      Height = 25
      TabOrder = 2
      Kind = bkHelp
    end
    object btnPrint: TBitBtn
      Left = 488
      Top = 6
      Width = 94
      Height = 25
      Caption = '&Print'
      TabOrder = 3
      OnClick = btnPrintClick
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDD7777777777DDDDD0000DDDD
        000000000007DDDD0000DDD07878787870707DDD0000DD0000000000000707DD
        0000DD0F8F8F8AAA8F0007DD0000DD08F8F8F999F80707DD0000DD0000000000
        0008707D0000DD08F8F8F8F8F080807D0000DDD0000000000F08007D0000DDDD
        0BFFFBFFF0F080DD0000DDDDD0F00000F0000DDD0000DDDDD0FBFFFBFF0DDDDD
        0000DDDDDD0F00000F0DDDDD0000DDDDDD0FFBFFFBF0DDDD0000DDDDDDD00000
        0000DDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDD
        DDDDDDDDDDDDDDDD0000}
    end
    object btnPrinterSetup: TBitBtn
      Left = 388
      Top = 6
      Width = 94
      Height = 25
      Caption = '&Setup'
      TabOrder = 4
      OnClick = btnPrinterSetupClick
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DD000DDDDDDDDDD000DD0000D000
        000000000000000D0000D0F8888888888888880D0000D0F8888888888888880D
        0000D0F8888888822899880D0000D0FFFFFFFFFFFFFFFF0D0000D70077777777
        7777007D0000DDD00000000000000DDD0000DDD00FFFFFFFFFF00DDD0000DDDD
        0F00000000F0DDDD0000DDDD0FFFFFFFFFF0DDDD0000DDDD0F00000000F0DDDD
        0000DDDD0FFFFFFFFFF0DDDD0000DDDD0F00FFFFFFF0DDDD0000DDDD0FFFFFFF
        FFF0DDDD0000DDDD000000000000DDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDD
        DDDDDDDDDDDDDDDD0000}
    end
    object btnPageSetup: TBitBtn
      Left = 288
      Top = 6
      Width = 94
      Height = 25
      Caption = 'Pa&ge'
      TabOrder = 5
      OnClick = btnPageSetupClick
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC00000000000000000000001000000010000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777770000000777777770000000770000000777777770FFFFF07700000007777
        77770FCCCF0770000000777777770FFFFF0770000000777000000FCCCF077000
        0000777077770FFFFF077000000070007CCC0FCCCF0770000000706077770FFF
        FF077000000070607CCC00000007700000007060777770777777700000007060
        7CCC707777747000000070607777707777444000000070600000007777747000
        0000706666607774777470000000700000007777444770000000777777777777
        777770000000}
    end
  end
  object pnlPreview: TPanel
    Left = 285
    Top = 0
    Width = 367
    Height = 474
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lblPaperSize: TLabel
      Left = 0
      Top = 461
      Width = 367
      Height = 13
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblPaperSize'
    end
    object lblPrinter: TLabel
      Left = 0
      Top = 448
      Width = 367
      Height = 13
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblPrinter'
    end
    object lblDocumentTitle: TLabel
      Left = 0
      Top = 0
      Width = 367
      Height = 20
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblDocumentTitle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TabPages: TTabControl
      Left = 0
      Top = 20
      Width = 367
      Height = 428
      Align = alClient
      HotTrack = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Tabs.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16')
      TabIndex = 0
      OnChange = TabPagesChange
      object PreviewBox: TPaintBox
        Left = 4
        Top = 24
        Width = 359
        Height = 400
        Align = alClient
        OnPaint = PreviewBoxPaint
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 474
    Align = alLeft
    TabOrder = 2
    object ZAL: TPageControl
      Left = 1
      Top = 1
      Width = 280
      Height = 407
      ActivePage = SH_PARAMS
      Align = alClient
      TabOrder = 0
      object SH_PARAMS: TTabSheet
        Caption = 'Parameters'
        object Label9: TLabel
          Left = 11
          Top = 357
          Width = 52
          Height = 13
          Caption = 'Predefined'
        end
        object Panel4: TPanel
          Left = 3
          Top = 3
          Width = 241
          Height = 346
          BevelOuter = bvNone
          TabOrder = 0
          object Label14: TLabel
            Left = 8
            Top = 3
            Width = 24
            Height = 13
            Caption = 'Units'
          end
          object Label15: TLabel
            Left = 8
            Top = 30
            Width = 54
            Height = 13
            Caption = 'Label width'
          end
          object Label16: TLabel
            Left = 8
            Top = 57
            Width = 58
            Height = 13
            Caption = 'Label height'
          end
          object Label17: TLabel
            Left = 8
            Top = 84
            Width = 51
            Height = 13
            Caption = 'Margin left'
          end
          object Label18: TLabel
            Left = 8
            Top = 111
            Width = 51
            Height = 13
            Caption = 'Margin top'
          end
          object Label19: TLabel
            Left = 8
            Top = 138
            Width = 57
            Height = 13
            Caption = 'Margin rigth'
          end
          object Label20: TLabel
            Left = 8
            Top = 165
            Width = 69
            Height = 13
            Caption = 'Margin bottom'
          end
          object Label21: TLabel
            Left = 8
            Top = 192
            Width = 79
            Height = 13
            Caption = 'Space horizontal'
          end
          object Label22: TLabel
            Left = 8
            Top = 219
            Width = 67
            Height = 13
            Caption = 'Space vertical'
          end
          object Label23: TLabel
            Left = 8
            Top = 246
            Width = 24
            Height = 13
            Caption = 'Style'
          end
          object Label3: TLabel
            Left = 8
            Top = 273
            Width = 29
            Height = 13
            Caption = 'Count'
          end
          object Label4: TLabel
            Left = 8
            Top = 300
            Width = 49
            Height = 13
            Caption = 'Start from'
          end
          object Label5: TLabel
            Left = 8
            Top = 327
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object ED_Width: TMaskEdit
            Left = 112
            Top = 27
            Width = 121
            Height = 21
            TabOrder = 0
            OnExit = CB_UNITSChange
          end
          object ED_Height: TMaskEdit
            Left = 112
            Top = 54
            Width = 121
            Height = 21
            TabOrder = 1
            OnExit = CB_UNITSChange
          end
          object ED_LEFT: TMaskEdit
            Left = 112
            Top = 81
            Width = 121
            Height = 21
            TabOrder = 2
            OnExit = CB_UNITSChange
          end
          object ED_TOP: TMaskEdit
            Left = 112
            Top = 108
            Width = 121
            Height = 21
            TabOrder = 3
            OnExit = CB_UNITSChange
          end
          object ED_RIGHT: TMaskEdit
            Left = 112
            Top = 135
            Width = 121
            Height = 21
            TabOrder = 4
            OnExit = CB_UNITSChange
          end
          object ED_BOTTOM: TMaskEdit
            Left = 112
            Top = 162
            Width = 121
            Height = 21
            TabOrder = 5
            OnExit = CB_UNITSChange
          end
          object ED_SPACEX: TMaskEdit
            Left = 112
            Top = 189
            Width = 121
            Height = 21
            TabOrder = 6
            OnExit = CB_UNITSChange
          end
          object ED_SPACEY: TMaskEdit
            Left = 112
            Top = 216
            Width = 121
            Height = 21
            TabOrder = 7
            OnExit = CB_UNITSChange
          end
          object CB_UNITS: TComboBox
            Left = 112
            Top = 0
            Width = 121
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 8
            OnChange = CB_UNITSChange
            Items.Strings = (
              'Milimetres'
              'Inches')
          end
          object CB_STYLE: TComboBox
            Left = 112
            Top = 243
            Width = 121
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 9
            OnChange = CB_UNITSChange
            Items.Strings = (
              'Simple label'
              'Sheet of labels'
              'Iincremental'
              'Symbologies list'
              'Table data'
              'Only selected rows')
          end
          object ED_COUNT: TMaskEdit
            Left = 112
            Top = 270
            Width = 121
            Height = 21
            TabOrder = 10
            OnExit = CB_UNITSChange
          end
          object ED_STARTFROM: TMaskEdit
            Left = 112
            Top = 297
            Width = 121
            Height = 21
            TabOrder = 11
            OnExit = CB_UNITSChange
          end
          object ED_Title: TMaskEdit
            Left = 113
            Top = 324
            Width = 121
            Height = 21
            TabOrder = 12
            OnChange = ED_TitleChange
            OnExit = CB_UNITSChange
          end
        end
        object cb_SheetsDatabase: TComboBox
          Left = 115
          Top = 354
          Width = 122
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = cb_SheetsDatabaseChange
        end
      end
      object SH_DATA: TTabSheet
        Caption = 'Data'
        ImageIndex = 1
        object DBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 272
          Height = 360
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ParentCtl3D = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = DBGridCellClick
        end
        object DBNav: TDBNavigator
          Left = 0
          Top = 360
          Width = 272
          Height = 19
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          Align = alBottom
          TabOrder = 1
        end
      end
      object SH_PreviewParams: TTabSheet
        Caption = 'Preview params'
        ImageIndex = 2
        object Label2: TLabel
          Left = 14
          Top = 59
          Width = 25
          Height = 13
          Caption = 'Label'
        end
        object Label7: TLabel
          Left = 14
          Top = 87
          Width = 24
          Height = 13
          Caption = 'Page'
        end
        object Label8: TLabel
          Left = 11
          Top = 115
          Width = 38
          Height = 13
          Caption = 'Shadow'
        end
        object CB_LivePreview: TCheckBox
          Left = 14
          Top = 24
          Width = 89
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Live preview'
          TabOrder = 0
          OnClick = CB_UNITSChange
        end
        object cb_ColorLabel: TColorBox
          Left = 85
          Top = 56
          Width = 132
          Height = 22
          ItemHeight = 16
          TabOrder = 1
          OnChange = CB_UNITSChange
        end
        object cb_ColorPage: TColorBox
          Left = 86
          Top = 84
          Width = 131
          Height = 22
          ItemHeight = 16
          TabOrder = 2
          OnChange = CB_UNITSChange
        end
        object cb_ColorShadow: TColorBox
          Left = 86
          Top = 112
          Width = 131
          Height = 22
          ItemHeight = 16
          TabOrder = 3
          OnChange = CB_UNITSChange
        end
        object ListBox1: TListBox
          Left = 16
          Top = 152
          Width = 201
          Height = 129
          ItemHeight = 13
          TabOrder = 4
          OnDblClick = ListBox1DblClick
        end
        object Button1: TButton
          Left = 8
          Top = 296
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 5
          OnClick = Button1Click
        end
      end
      object SH_LABELS: TTabSheet
        Caption = 'Labels'
        ImageIndex = 3
        object Panel5: TPanel
          Left = 0
          Top = 344
          Width = 272
          Height = 35
          Align = alBottom
          TabOrder = 0
          object btnOpenSheets: TBitBtn
            Left = 5
            Top = 8
            Width = 100
            Height = 25
            Caption = '&Load'
            TabOrder = 0
            OnClick = btnOpenSheetsClick
          end
          object BitBtn2: TBitBtn
            Left = 116
            Top = 6
            Width = 109
            Height = 25
            Caption = '&Use'
            TabOrder = 1
          end
        end
        object TV_SHEETS: TTreeView
          Left = 0
          Top = 0
          Width = 272
          Height = 344
          Align = alClient
          Indent = 19
          TabOrder = 1
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 408
      Width = 280
      Height = 65
      Align = alBottom
      TabOrder = 1
      object Label6: TLabel
        Left = 7
        Top = 10
        Width = 36
        Height = 13
        Caption = 'Pages :'
      end
      object Label1: TLabel
        Left = 8
        Top = 29
        Width = 76
        Height = 13
        Caption = 'Labels per page'
      end
      object lblSelectedHeader: TLabel
        Left = 8
        Top = 47
        Width = 69
        Height = 13
        Caption = 'Selected/Total'
      end
      object lblDataSelectedCount: TLabel
        Left = 138
        Top = 48
        Width = 103
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblDataSelectedCount'
      end
      object lblLabelsPerPage: TLabel
        Left = 168
        Top = 29
        Width = 73
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblLabelsPerPage'
      end
      object lblPagesCount: TLabel
        Left = 191
        Top = 6
        Width = 50
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '1 / 1'
      end
      object ud: TUpDown
        Left = 168
        Top = 2
        Width = 16
        Height = 21
        Associate = e1
        Min = 1
        Position = 1
        TabOrder = 0
        OnClick = udClick
      end
      object e1: TEdit
        Left = 120
        Top = 2
        Width = 48
        Height = 21
        ReadOnly = True
        TabOrder = 1
        Text = '1'
        OnChange = e1Change
        OnExit = CB_UNITSChange
      end
    end
  end
  object PrintDialog: TPrintDialog
    Left = 472
    Top = 120
  end
  object PrinterPageSetup: TPageSetupDialog
    MinMarginLeft = 0
    MinMarginTop = 0
    MinMarginRight = 0
    MinMarginBottom = 0
    MarginLeft = 1000
    MarginTop = 1000
    MarginRight = 1000
    MarginBottom = 1000
    PageWidth = 8500
    PageHeight = 11000
    Left = 472
    Top = 72
  end
  object OD: TOpenDialog
    DefaultExt = '.ini'
    Filter = 'Label database files (*.ini)|*.ini'
    Left = 472
    Top = 176
  end
end
