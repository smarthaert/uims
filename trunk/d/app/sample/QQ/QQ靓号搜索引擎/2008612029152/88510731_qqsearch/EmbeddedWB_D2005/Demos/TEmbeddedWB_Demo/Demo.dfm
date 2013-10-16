object frmMain: TfrmMain
  Left = 180
  Top = 116
  Caption = 'frmMain'
  ClientHeight = 582
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterACC: TSplitter
    Left = 401
    Top = 110
    Width = 2
    Height = 453
    ExplicitHeight = 413
  end
  object PanelWEB: TPanel
    Left = 403
    Top = 110
    Width = 403
    Height = 453
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 433
    object pctrlWB: TPageControl
      Left = 1
      Top = 1
      Width = 401
      Height = 451
      ActivePage = TabBrowser
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 431
      object TabBrowser: TTabSheet
        Caption = 'Web Browser'
        ExplicitHeight = 403
        object EmbeddedWB1: TEmbeddedWB
          Left = 0
          Top = 0
          Width = 393
          Height = 423
          Align = alClient
          DragMode = dmAutomatic
          TabOrder = 0
          OnStatusTextChange = EmbeddedWB1StatusTextChange
          OnProgressChange = EmbeddedWB1ProgressChange
          OnCommandStateChange = EmbeddedWB1CommandStateChange
          OnDownloadBegin = EmbeddedWB1DownloadBegin
          OnDownloadComplete = EmbeddedWB1DownloadComplete
          OnTitleChange = EmbeddedWB1TitleChange
          OnPropertyChange = EmbeddedWB1PropertyChange
          OnBeforeNavigate2 = EmbeddedWB1BeforeNavigate2
          OnNewWindow2 = EmbeddedWB1NewWindow2
          OnNavigateComplete2 = EmbeddedWB1NavigateComplete2
          OnDocumentComplete = EmbeddedWB1DocumentComplete
          OnVisible = EmbeddedWB1Visible
          OnFullScreen = EmbeddedWB1FullScreen
          About = 'Embedded Web Browser. http://bsalsa.com/ '
          DownloadOptions = [DownloadImages, DownloadVideos, DownloadBGSounds]
          MessagesBoxes.InternalErrMsg = False
          OnShowDialog = EmbeddedWB1ShowDialog
          UserInterfaceOptions = []
          OnRefresh = EmbeddedWB1Refresh
          OnScriptError = EmbeddedWB1ScriptError
          OnUnload = EmbeddedWB1Unload
          PrintOptions.Margins.Left = 19.050000000000000000
          PrintOptions.Margins.Right = 19.050000000000000000
          PrintOptions.Margins.Top = 19.050000000000000000
          PrintOptions.Margins.Bottom = 19.050000000000000000
          PrintOptions.Header = '&w&bPage &p of &P'
          PrintOptions.HTMLHeader.Strings = (
            '<HTML></HTML>')
          PrintOptions.Footer = '&u&b&d'
          PrintOptions.Orientation = poPortrait
          UserAgent = 'EmbeddedWB 14.33 from: http://www.bsalsa.com/'
          ExplicitHeight = 403
          ControlData = {
            4C000000EA370000742000000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
      object TabEditor: TTabSheet
        Caption = 'Editor'
        ImageIndex = 1
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object RichEditWB1: TRichEditWB
          Left = 17
          Top = 29
          Width = 376
          Height = 357
          Hint = 
            'File Name: Untitled. | '#10#13'Position: Line:   1   Col:   1. | '#10#13'Mod' +
            'ified. | '#10#13'Caps Lock: Off. | '#10#13'NumLock: On. | '#10#13'Insert: Off. | '#10 +
            #13'Total Lines Count: 0. |'
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ScrollBars = ssBoth
          ShowHint = True
          TabOrder = 0
          WordWrap = False
          OnKeyDown = RichEditWB1KeyDown
          OnMouseDown = RichEditWB1MouseDown
          AutoNavigate = True
          EmbeddedWB = EmbeddedWB1
          FileName = 'Untitled'
          GapLeft = 21
          GapTop = 20
          HighlightHTML = True
          HighlightURL = True
          HighlightXML = True
          Image = ImageViewer
          RTFText = 
            '{\rtf1\fbidis\ansi\deff0{\fonttbl{\f0\fnil Tahoma;}}'#13#10'{\colortbl' +
            ' ;\red0\green0\blue0;}'#13#10'\viewkind4\uc1\pard\ltrpar\cf1\lang1037\' +
            'f0\fs16\par'#13#10'}'#13#10
          SupprtMoreThen64KB = True
          TextAlignment = taLeftJustify
          HideCaret = False
          Themes = tDefault
        end
        object ProgressBar2: TProgressBar
          Left = 0
          Top = 29
          Width = 17
          Height = 377
          Align = alLeft
          Orientation = pbVertical
          TabOrder = 1
          ExplicitHeight = 337
        end
        object ProgressBar3: TProgressBar
          Left = 0
          Top = 406
          Width = 393
          Height = 17
          Align = alBottom
          TabOrder = 2
          ExplicitTop = 366
        end
        object ToolBar1: TToolBar
          Left = 0
          Top = 0
          Width = 393
          Height = 29
          ButtonHeight = 21
          ButtonWidth = 34
          Caption = 'ToolBar1'
          ShowCaptions = True
          TabOrder = 3
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            AutoSize = True
            Caption = 'File'
            MenuItem = File1
            ParentShowHint = False
            ShowHint = True
          end
          object ToolButton2: TToolButton
            Left = 27
            Top = 0
            Caption = 'Edit'
            MenuItem = Edit
          end
          object ToolButton3: TToolButton
            Left = 61
            Top = 0
            Caption = 'Tools'
            MenuItem = Tools
          end
          object ToolButton4: TToolButton
            Left = 95
            Top = 0
            Caption = 'Add'
            MenuItem = Add
          end
          object ToolButton5: TToolButton
            Left = 129
            Top = 0
            Caption = 'Fonts'
            MenuItem = Fonts
          end
          object Label3: TLabel
            Left = 163
            Top = 0
            Width = 605
            Height = 16
            Align = alBottom
            Caption = 
              '      This is a Toolbar Component which is placed INSIDE the TRi' +
              'chEditWB (As Well As The ProgressBars )'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
        end
      end
      object TabImage: TTabSheet
        Caption = 'Page Image'
        ImageIndex = 2
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object ImageViewer: TImage
          Left = 0
          Top = 0
          Width = 393
          Height = 363
          Align = alClient
        end
      end
      object TabLinks: TTabSheet
        Caption = 'Links Checker'
        ImageIndex = 3
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PanelLinksTop: TPanel
          Left = 0
          Top = 0
          Width = 393
          Height = 306
          Align = alClient
          TabOrder = 0
          object StringGrid1: TStringGrid
            Left = 1
            Top = 1
            Width = 391
            Height = 304
            Align = alClient
            ColCount = 3
            DefaultRowHeight = 15
            FixedCols = 0
            TabOrder = 0
            ColWidths = (
              258
              263
              118)
          end
        end
        object PanelLinksBottum: TPanel
          Left = 0
          Top = 306
          Width = 393
          Height = 57
          Align = alBottom
          TabOrder = 1
          object Button1: TButton
            Left = 282
            Top = 16
            Width = 103
            Height = 25
            Caption = 'Check Links'
            TabOrder = 0
            OnClick = Button1Click
          end
          object RadioButton1: TRadioButton
            Left = 16
            Top = 32
            Width = 113
            Height = 17
            Caption = 'Synchronous'
            TabOrder = 1
            OnClick = RadioButton1Click
          end
          object RadioButton2: TRadioButton
            Left = 16
            Top = 8
            Width = 113
            Height = 17
            Caption = 'Asynchronous'
            Checked = True
            TabOrder = 2
            TabStop = True
            OnClick = RadioButton2Click
          end
        end
      end
    end
  end
  object PanelAcc: TPanel
    Left = 0
    Top = 110
    Width = 401
    Height = 453
    Align = alLeft
    TabOrder = 1
    Visible = False
    ExplicitHeight = 433
    object Splitter2: TSplitter
      Left = 1
      Top = 25
      Width = 399
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object pnlFav: TPanel
      Left = 1
      Top = 1
      Width = 399
      Height = 24
      Align = alTop
      TabOrder = 0
      object sbRebuildView: TSpeedButton
        Left = 0
        Top = 0
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF003CA7839BCAFDF9F7FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F58BB1B
          93FF0050C75076B8E9EAF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF5C7EBB0056C71784F21985FF2692FF0984FF2472CD6283BFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0B4CAC118CFF2E98FF67B8FF6D
          B7FF0787FFA2DCFF295CAFF7F8FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          3061B01693FF5AB0FF57A0EA0E4BADA7D6FDC6EDFF1B4FA9FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFD4D6E50067DA55B4FF378ADF788FC1CCD0E462
          A9E4003CA2FFFFFFFFFFFFFFFFFFFFFFFF1A72BCD2D7E6FFFFFFFFFFFF5C7EBC
          1F99FF79C7FF5B7BBBFFFFFFECF0F72457ABFFFFFFFFFFFFFFFFFFFFFFFF225B
          AF2387F6004ED2E3E5EC001D980E73DF42B7FF8AB9E42C6EBF003A9EFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF1455B0D0F3FF1384FF30ACFF0032AAE4E6EF0045C4
          47C2FFB8E3FD205DB4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB3C6E36684BF0571
          D11E84FF0F5DC28AA3CEFFFFFFD2D4E53CACE61D56B0FFFFFFFFFFFFFFFFFFFF
          FFFD0543A2BCCBE4FFFFFF5F7FBA1E9BFF2B89FF4673BAFFFFFFFFFFFFFFFFFF
          B5C1DFFFFFFFFFFFFFFFFFFFFFFFFE004CA82CCFFF939DC9617BB71194EE318B
          FF2F79DDC6CEE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFB0C56AD3C
          D8FF39C0FF0E7BCD1BA6FD2C92FF88BFFF3463B1FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE6E7F10B69BD41E5FF3AC8FF36BBFF42BBFF7BC9FF91C3F52456
          ACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBEDD0E67BA33B9EC56
          E3FF61D4FF86B9E93A6EBB7794C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF9DA7D12664B477BAE53C81CAFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC5CCE4225CB0E7EBF5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = sbRebuildViewClick
      end
    end
    object PageCtrl: TPageControl
      Left = 1
      Top = 27
      Width = 399
      Height = 425
      ActivePage = TabEvents
      Align = alClient
      TabOrder = 1
      OnChange = PageCtrlChange
      ExplicitHeight = 405
      object TabEvents: TTabSheet
        Caption = 'Events Log'
        ExplicitHeight = 377
        object lvEventLog: TListBox
          Left = 0
          Top = 0
          Width = 391
          Height = 397
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          ExplicitHeight = 377
        end
      end
      object TabFavoritesLV: TTabSheet
        Caption = 'FavoritesLV'
        ImageIndex = 1
        ExplicitHeight = 377
        object FavoritesListView1: TFavoritesListView
          Left = 0
          Top = 0
          Width = 391
          Height = 377
          ResolveUrl = IntShCut
          Channels = False
          EmbeddedWB = EmbeddedWB1
          Align = alClient
          ParentShowHint = False
          TabOrder = 0
        end
      end
      object TabFavoritesTV: TTabSheet
        Caption = 'FavoritesTV'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object FavoritesTree1: TFavoritesTree
          Left = 0
          Top = 0
          Width = 391
          Height = 377
          EmbeddedWB = EmbeddedWB1
          ImportFavorites = ImportFavorite1
          ExportFavorites = ExportFavorite1
          Options = [foShowRoot, foShowItems, foShowOrganize, foShowAdd, foShowImport, foShowExport]
          Align = alClient
          Images = ilFavoritesTree
          Indent = 19
          ParentColor = False
          TabOrder = 0
          TabStop = True
          OnNodeAdded = FavoritesTree1NodeAdded
          OnExpanded = FavoritesTree1Expanded
        end
      end
      object TabHistoryLV: TTabSheet
        Caption = 'HistoryLV'
        ImageIndex = 3
        ExplicitHeight = 377
        object HistoryListView1: THistoryListView
          Left = 0
          Top = 0
          Width = 391
          Height = 377
          EmbeddedWB = EmbeddedWB1
          Align = alClient
          ParentShowHint = False
          TabOrder = 0
        end
      end
      object TabFTP: TTabSheet
        Caption = 'Local Folders'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object EmbeddedWB2: TEmbeddedWB
          Left = 0
          Top = 49
          Width = 391
          Height = 288
          Align = alClient
          DragMode = dmAutomatic
          TabOrder = 0
          OnCommandStateChange = EmbeddedWB2CommandStateChange
          About = 'Embedded Web Browser. http://bsalsa.com/ '
          DownloadOptions = [DownloadImages, DownloadVideos, DownloadBGSounds]
          MessagesBoxes.InternalErrMsg = False
          UserInterfaceOptions = []
          PrintOptions.Margins.Left = 19.050000000000000000
          PrintOptions.Margins.Right = 19.050000000000000000
          PrintOptions.Margins.Top = 19.050000000000000000
          PrintOptions.Margins.Bottom = 19.050000000000000000
          PrintOptions.Header = '&w&bPage &p of &P'
          PrintOptions.HTMLHeader.Strings = (
            '<HTML></HTML>')
          PrintOptions.Footer = '&u&b&d'
          PrintOptions.Orientation = poPortrait
          UserAgent = 'EmbeddedWB 14.33 from: http://www.bsalsa.com/'
          ControlData = {
            4C000000911400008C2900000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 391
          Height = 49
          Align = alTop
          TabOrder = 1
          object sbRefresh: TSpeedButton
            Left = 32
            Top = 0
            Width = 33
            Height = 41
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EB1908EB1908EB1908EB1908EB1908EB1908EB190
              8EB1908EB1908EB1908EB1908EB1908EB1908EB1908EB1908EB1908EB1908EB1
              908EB1908EB1908EB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
              FEFEFEFEFEFEFEFEB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFC
              FBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFE
              FCFBFEFCFBFEFCFBB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEFBF8FEFBF8FEFBF8FEFBF8007000FEFBF8FEFB
              F8ADD5AA3699360070000070000070001C881CADD5AAFEFBF8FEFBF8FEFBF8FE
              FBF8FEFBF8FEFBF8B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEFAF6FEFAF6FEFAF6FEFAF600700045A14455AA
              5300700000700000700000700000700000700000700088C283FEFAF6FEFAF6FE
              FAF6FEFAF6FEFAF6B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF8F3FEF8F3FEF8F3FEF8F30070000070000070
              0000700000700000700045A043ADD4A6ADD4A665B162077807ADD4A6FEF8F3FE
              F8F3FEF8F3FEF8F3B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF7F2FEF7F2FEF7F2FEF7F20070000070000070
              0000700000700076B870FEF7F2FEF7F2FEF7F2FEF7F2D4E5CB369835FEF7F2FE
              F7F2FEF7F2FEF7F2B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF6EFFEF6EFFEF6EFFEF6EF0070000070000070
              000070001C881BFEF6EFFEF6EFFEF6EFFEF6EFFEF6EFFEF6EFE9EDDCFEF6EFFE
              F6EFFEF6EFFEF6EFB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF4EDFEF4EDFEF4EDFEF4ED0070000070000070
              0000700000700088C07FFEF4EDFEF4EDFEF4EDFEF4EDFEF4EDFEF4EDFEF4EDFE
              F4EDFEF4EDFEF4EDB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF3EAFEF3EAFEF3EAFEF3EA0070000070000070
              00007000007000007000007000FEF3EAFEF3EAFEF3EAFEF3EAFEF3EAFEF3EAFE
              F3EAFEF3EAFEF3EAB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF3E7FEF3E7FEF3E7FEF3E7FEF3E7FEF3E7FEF3
              E7FEF3E7FEF3E7007000007000007000007000007000007000007000FEF3E7FE
              F3E7FEF3E7FEF3E7B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF2E6FEF2E6FEF2E6FEF2E6FEF2E6FEF2E6FEF2
              E6FEF2E6FEF2E6FEF2E688BF7B007000007000007000007000007000FEF2E6FE
              F2E6FEF2E6FEF2E6B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEF0E3FEF0E3FEF0E3FEF0E3E9E7D0FEF0E3FEF0
              E3FEF0E3FEF0E3FEF0E3FEF0E31C871A007000007000007000007000FEF0E3FE
              F0E3FEF0E3FEF0E3B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFEEFE1FEEFE1FEEFE1FEEFE1369631D4DEBCFEEF
              E1FEEFE1FEEFE1FEEFE176B569007000007000007000007000007000FEEFE1FE
              EFE1FEEFE1FEEFE1B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFEEDEFFEEDEFFEEDEFFEEDEADCC9807780666AC
              59ADCC98ADCC98469D3E007000007000007000007000007000007000FFEEDEFF
              EEDEFFEEDEFFEEDEB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFEDDCFFEDDCFFEDDCFFEDDCFFEDDC88BB760070
              0000700000700000700000700000700000700056A44A469D3D007000FFEDDCFF
              EDDCFFEDDCFFEDDCB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFEBDAFFEBDAFFEBDAFFEBDAFFEBDAFFEBDAADCA
              961C8618007000007000007000379530ADCA96FFEBDAFFEBDA007000FFEBDAFF
              EBDAFFEBDAFFEBDAB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FFEA
              D8FFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FFEAD8FF
              EAD8FFEAD8FFEAD8B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE9D5FFE9D5FFE9D5FFE9D5FFE9D5FFE9D5FFE9
              D5FFE9D5FFE9D5FFE9D5FFE9D5FFE9D5FFE9D5FFE9D5FEE9D4FEE7D4FEE7D4FE
              E7D4FEE7D4FEE7D4B1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE7D3FFE7D3FFE7D3FFE7D3FFE7D3FFE7D3FFE7
              D3FFE7D3FFE7D3FFE7D3FFE7D3FFE7D3FEE6D1E5CEBAE1CAB7DDC7B4D9C4B1D5
              C0ADD1BCABD0BBAAB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE6D0FFE6D0FFE6D0FFE6D0FFE6D0FFE6D0FFE6
              D0FFE6D0FFE6D0FFE6D0FFE6D0FFE6D0FBE3CCCCB7A3C2AD9AB7A492AD9A8AA3
              918299897A9D897EB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE5CFFFE5CFFFE5CFFFE5CFFFE5CFFFE5CFFFE5
              CFFFE5CFFFE5CFFFE5CFFFE5CFFFE5CFFFE5CFBDA996AC98889D8A7B8C7D6E7D
              6E62907F75BFA39CB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE3CCFFE3CCFFE3CCFFE3CCFFE3CCFFE3CCFFE3
              CCFFE3CCFFE3CCFFE3CCFFE3CCFFE3CCFFE3CCFAF0E7FEFEFEF7F6F4E9E5E1ED
              E0DACEB2ABB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE3CAFFE3CAFFE3CAFFE3CAFFE3CAFFE3CAFFE3
              CAFFE3CAFFE3CAFFE3CAFFE3CAFFE3CAFFE3CAEBD8C6FEFEFEFEFEFCF2E7E2CE
              B2ACB1908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE2C7FFE2C7FFE2C7FFE2C7FFE2C7FFE2C7FFE2
              C7FFE2C7FFE2C7FFE2C7FFE2C7FFE2C7FFE2C7D9C1ACFEFEFEFEF8F4D0B6B0B1
              908EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE1C5FFE1C5FFE1C5FFE1C5FFE1C5FFE1C5FFE1
              C5FFE1C5FFE1C5FFE1C5FFE1C5FFE1C5FFE1C5D1B7A1FEFAF7D0B7B1B1908EFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFE0C2FFE0C2FFE0C2FFE0C2FFE0C2FFE0C2FFE0
              C2FFE0C2FFE0C2FFE0C2FFE0C2FFE0C2FFE0C2D1BDABD0B7B1B1908EFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EFFDEC1FFDEC1FFDEC1FFDEC1FFDEC1FFDEC1FFDE
              C1FFDEC1FFDEC1FFDEC1FFDEC1FFDEC1FAD9BDC0A69EB1908EFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1908EB1908EB1908EB1908EB1908EB1908EB1908EB190
              8EB1908EB1908EB1908EB1908EB1908EB1908EB1908EFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            OnClick = sbRefreshClick
          end
          object sbConnect: TSpeedButton
            Left = 64
            Top = 2
            Width = 33
            Height = 39
            Glyph.Data = {
              9E020000424D9E0200000000000036000000280000000E0000000E0000000100
              1800000000006802000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFF79B17C2A882A0078000078002A892A79B27CFFFFFFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFA2C8A600780027A73340D3544DEE6248EC5A34CE
              401BA420007800A2C8A6FFFFFFFFFFFF0000FFFFFFA0C8A50A7F0D51DE6D53E5
              6F36BB4543CC5043CF4E41D14B41E44F33D33C057E06A0C8A5FFFFFF0000FFFF
              FF0078005AE17A5EE97A1A9120ADCEAD228B2337B63E42C54A3EC4453ED84933
              D33C007800FFFFFF000073AD7733AB466EF69457DC691B9120FFFFFFF2F7F280
              B5801A921E3FC1463EC34340E34D1AA31F73AD7700002586275FDD8266EA835C
              E1701D9323FFFFFFFFFFFFFFFFFFC9DEC943984327A32B3FD04933CE3E258627
              00000078007FFDAD69EC8563E87A1F9527FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              80B58029AD3145EB57007800000000780085FDB56FF18D6AF083229829FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF80B5802BAE354AED5F00780000002085226CDE93
              78F79A70F78D239A2DFFFFFFFFFFFFFFFFFFC9DEC9318F332DA83349D6593ED2
              502085220000579E5C3EAD548BFDBA73FA90249A2EFFFFFFF2F7F271AD712098
              274CCF5A4BCF5757EE7224A73064A46A0000FFFFFF00780079E7A384FCAE259A
              30ADCEAD258F2949C95957DB6851D6615AE7754DDD69007800FFFFFF0000FFFF
              FF82B28C0D801377E7A27CEEA952C96D64E57F63E77D61E67B69F48E56E07608
              7F0D82B28CFFFFFF0000FFFFFFFFFFFF7EB0890078003DAD5370E69A80FDB07A
              FDA95BDC7E30AB430078007EB088FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFAA
              C6BA559E5D19831C00780000780019831B499950FFFFFFFFFFFFFFFFFFFFFFFF
              0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = sbConnectClick
          end
          object sbUp: TSpeedButton
            Left = 0
            Top = 3
            Width = 33
            Height = 38
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FF0B7FBA
              0B7FBA0B7FBA0B7FBA0B7FBAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA1387BF
              A9DCEF42B5E735A9DD2399D00B7FBA0B7FBA0B7FBA0B7FBA0B7FBAFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA0B7FBA
              A0D3E757C7F657C7F657C7F657C7F651C1F04ABBED35A9DD279DD10B7FBA0B7F
              BA0B7FBA0B7FBA0B7FBAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA279DD1
              43A3CE90DAF757C7F657C7F657C7F657C7F657C7F657C7F657C7F656C6F451C1
              F045B7E935A9DD2398CF0B7FBA0B7FBA0B7FBA0B7FBA0B7FBAFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA39AFD9
              1688BFBFE9F857C7F657C7F657C7F657C7F657C7F657C7F657C7F657C7F657C7
              F657C7F657C7F657C7F656C6F451C1F045B7E931A4DA2398CF0B7FBA0B7FBA0B
              7FBA0B7FBA0B7FBAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA37ACD8
              188FC58FCAE260CBF657C7F657C7F657C7F657C7F657C7F657C7F657C7F657C7
              F657C7F657C7F657C7F657C7F657C7F657C7F657C7F657C7F656C6F451C1F041
              B4E52DA0D7168AC50B7FBAFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA37ACD8
              2EA4D43198C792DDF75ACBF65ACBF65ACBF65ACBF65ACBF65ACBF65ACBF65ACB
              F65ACBF65ACBF65ACBF65ACBF65ACBF65ACBF65ACBF65ACBF65ACBF65ACBF65A
              CBF652C4EF3CAFE10B7FBAFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA37ACD8
              3CADD71488BFC2EAF75ECFF65ECFF65ECFF65ECFF65ECFF65ECFF65ECFF65ECF
              F65ECFF65ECFF65ECFF65ECFF65ECFF65ECFF65ECFF65ECFF65ECFF65ECFF65E
              CFF657C9F247BAE90B7FBAFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA39AFD9
              3EADD91990C67DC9E273D8F763D3F663D3F663D3F663D3F663D3F663D3F663D3
              F663D3F663D3F663D3F663D3F663D3F663D3F663D3F663D3F663D3F663D3F663
              D3F65BCCF24CBFE935AADA0B7FBAFF00FFFF00FFFF00FFFF00FF0B7FBA39ADDA
              40AFDC34A9D72792C5A3E7F867D8F667D8F667D8F667D8F667D8F667D8F667D8
              F667D8F667D8F667D8F667D8F667D8F667D8F667D8F667D8F667D8F667D8F667
              D8F65FD1F24DC1E766D5F40F83BCFF00FFFF00FFFF00FFFF00FF0B7FBA3BAFDD
              41B0E041B0E01387BFC5E9F46ADCF76ADCF76ADCF76ADCF76ADCF76ADCF76ADC
              F76ADCF76ADCF76ADCF76ADCF76ADCF76ADCF76ADCF76ADCF76ADCF76ADCF76A
              DCF764D5F34DC1E76BDAF6289FCF0B7FBAFF00FFFF00FFFF00FF0B7FBA3CB0E0
              43B2E243B2E22198CC62B4D77EE2F86EE0F76EE0F76EE0F76EE0F76EE0F76EE0
              F76EE0F76EE0F76EE0F76EE0F76EE0F76EE0F76EE0F76EE0F76EE0F76EE0F76E
              E0F767D9F351C5E670E0F65DCFEB0B7FBAFF00FFFF00FFFF00FF0B7FBA3CB0E0
              46B4E646B4E63CB0E02390C4C7F2F873E3F773E3F773E3F773E3F773E3F72D92
              62004B000C651B26895262D0D073E3F773E3F773E3F773E3F773E3F773E3F773
              E3F76BDDF358CCE776E5F676E5F60B7FBAFF00FFFF00FFFF00FF0B7FBA3FB1E1
              48B5E948B5E948B5E91287BF95CEE3A5EFFA76E7F876E7F876E7F876E7F876E7
              F8349C80035406004B00004E00136E2862D0D076E7F876E7F876E7F876E7F876
              E7F86FE1F358CCE77BEBF77BEBF742B8DC0B7FBAFF00FFFF00FF0B7FBA48B4E3
              4AB6ED4AB6ED4AB6ED2DA0D71284BCA0D3E7D8F2F7DAF8FBD0F6FBB8F4FAB8F4
              FAA0F0FA65CBBC0D661B005B00006600004B003296637EEBF87EEBF87EEBF87E
              EBF877E5F362D1E786EFF786EFF786EFF70F83BCFF00FFFF00FF0B7FBA53B7E5
              4CB8EF4CB8EF4CB8EF4CB8EF39AAE11C92C90B7FBA0B7FBA0B7FBA0B7FBA0B7F
              BA6EBADAC0E3EFA6E7E5035406036D03047B0500550028834391EEFA91EEFA91
              EEFA89E7F473D4E99FF3F89FF3F89FF3F839A3CE0B7FBAFF00FF0B7FBA5FBBE6
              51BDF051BDF051BDF051BDF051BDF051BDF051BDF056C4F357C6F347BAE941B4
              E52DA3D41287BF79BFDD96C6AB004E00118C120E8B0F0156012D8343A5EFFAA5
              EFFA9DE9F486D7E9BBF6F8BBF6F8BBF6F899E1EE0B7FBAFF00FF0B7FBA83CFEF
              56C4F256C4F256C4F256C4F256C4F256C4F256C4F256C4F256C4F256C4F256C4
              F256C4F24BBBEA188FC539A3CE16651A0C780F229C231B961C005701499863BA
              F2FAB2EDF89DD8E9D8F8FAD8F8FAD8F8FAD8F8FA0B7FBAFF00FF0B7FBAAAE5F8
              5CCAF35CCAF35CCAF35CCAF35CCAF35CCAF35CCAF35CCAF35CCAF35CCAF35CCA
              F35CCAF35CCAF35CCAF32DA3D409694C06680637AB3B37AB3B1C9521004B0091
              CFBDBFF2FA9DD8E9E0F8FAE0F8FAE0F8FAE0F8FA72C0DD0B7FBA0B7FBAAAE5F8
              62CFF362CFF362CFF362CFF362CFF362CFF362CFF362CFF362CFF362CFF362CF
              F362CFF362CFF362CFF35ECFF6349C80005A0150B8534FBC554BBD540C780F1C
              6C25B4DCEBC5E3EFF7FBFCF7FBFCF7FBFCEFFBFBEFFBFB0B7FBA0B7FBAAFE9F8
              68D5F468D5F468D5F468D5F468D5F468D5F468D5F468D5F468D5F468D5F468D5
              F468D5F468D5F468D5F468D5F446B0A6015C0267C96F67C96F67C96F34B64201
              510108758C0B7FBA0B7FBA0B7FBA0B7FBA0B7FBA0B7FBA0B7FBA0B7FBAB2EDF8
              6DDCF46DDCF46DDCF46DDCF46DDCF46DDCF46DDCF46DDCF46DDCF46DDCF46DDC
              F46DDCF46DDCF46DDCF46DDCF42B8F6003670481D38880D5897FD88A6AD47908
              740F2486510B7FBAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBAB2EDF8
              74E2F674E2F674E2F674E2F674E2F674E2F674E2F674E2F674E2F674E2F674E2
              F674E2F674E2F674E2F674E2F6136E2818842199E0A199E0A197E3A397E3A322
              A131075B0F0B7FBAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBABFF2FA
              79E9F679E9F679E9F679E9F679E9F679E9F679E9F679E9F679E9F679E9F6004B
              00005200005A01015C02025E03025E034AB653B2EABAB2EABAAFEBB8ACEDBA6F
              E2882C9336004B00004B00004B00004B00FF00FFFF00FFFF00FF0B7FBAA9DCEF
              87EFF77FEEF77FEEF77FEEF77FEEF77FEEF77FEEF77FEEF77FEEF77FEEF7BBF4
              FA004F0072BA74D1EFD4D1EFD4D0F0D4D0F0D4CBF2D1C9F2D0C5F3CFC5F3CFBF
              F7CEBFF7CEBFF7CE5DD47A025403FF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA
              C4F7FA80EFF780EFF780EFF780EFF780EFF780EFF780EFF780EFF73EB5D80B7F
              BA0B7FBA004F0076BF7AD5F3D9D5F3D9D7F4DCD8F6DDD9F7E0D9F7E0D8F8E0D5
              FAE0D3FBE05DD47A025403FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B7FBA
              62B4D79DF3F880EFF780EFF780EFF780EFF780EFF780EFF780EFF71990C60B7F
              BAFF00FFFF00FF0050017AC481D7F4DCD8F6DDD9F7E0DAF8E1DCFAE3DDFBE5DE
              FCE75ABD6C025403FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              0B7FBA62B4D76EBADA8FCAE29DD8E996D8EA96D8EAC7F2F87DC9E20B7FBAFF00
              FFFF00FFFF00FFFF00FF0151017FC988D9F7E0DAF8E1DCFAE3DDFBE5D4FCE042
              B156004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF0B7FBA0B7FBA0B7FBA0B7FBA0B7FBA0B7FBA0B7FBA0B7FBAFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF0152024FB15CDCFAE3DDFBE5D4FCE03BB15000
              4B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FF004B0050AD5CD4FCE03BB150004B00FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004B00188421004B00FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004B00FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            OnClick = sbUpClick
          end
          object Label1: TLabel
            Left = 208
            Top = 8
            Width = 50
            Height = 13
            Caption = 'Password:'
          end
          object Label2: TLabel
            Left = 208
            Top = 32
            Width = 26
            Height = 13
            Caption = 'User:'
          end
          object edtUser: TEdit
            Left = 264
            Top = 0
            Width = 121
            Height = 21
            TabOrder = 0
            Text = 'anonymouse'
          end
          object edtPassword: TEdit
            Left = 264
            Top = 24
            Width = 121
            Height = 21
            TabOrder = 1
            Text = 'anonymouse'
          end
        end
      end
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 806
    Height = 110
    Align = alTop
    Alignment = taLeftJustify
    TabOrder = 2
    object MainToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 804
      Height = 36
      Cursor = crHandPoint
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 69
      EdgeBorders = [ebRight]
      Images = ilToolBar
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      Transparent = True
      object ToolbtnBack: TToolButton
        Left = 0
        Top = 0
        Hint = 'Navigate Back'
        AutoSize = True
        Caption = 'Back'
        Enabled = False
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolbtnBackClick
      end
      object ToolBtnForward: TToolButton
        Left = 33
        Top = 0
        Hint = 'Navigate Forward'
        AutoSize = True
        Caption = 'Forward'
        Enabled = False
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolBtnForwardClick
      end
      object ToolBtnStop: TToolButton
        Left = 84
        Top = 0
        Hint = 'Stop loading'
        AutoSize = True
        Caption = ' Stop'
        Enabled = False
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolBtnStopClick
      end
      object ToolButton10: TToolButton
        Left = 120
        Top = 0
        Width = 8
        Caption = 'ToolButton10'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolBtnRefresh: TToolButton
        Left = 128
        Top = 0
        Hint = 'Refresh Active Tab'
        AutoSize = True
        Caption = 'Refresh'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolBtnRefreshClick
      end
      object ToolBtnHome: TToolButton
        Left = 177
        Top = 0
        Hint = 'Go Home'
        AutoSize = True
        Caption = 'Home'
        ImageIndex = 1
        OnClick = ToolBtnHomeClick
      end
      object ToolButton11: TToolButton
        Left = 215
        Top = 0
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolBtnSearch: TToolButton
        Left = 223
        Top = 0
        Hint = 'Search...'
        AutoSize = True
        Caption = 'Search'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolBtnSearchClick
      end
      object ToolBtnAccesories: TToolButton
        Left = 267
        Top = 0
        Hint = 'Show Favorites'
        AutoSize = True
        Caption = 'Accessories'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolBtnAccesoriesClick
      end
      object tbBlock: TToolButton
        Left = 334
        Top = 0
        Hint = 'Block Popups'
        AutoSize = True
        Caption = 'Block Popups'
        ImageIndex = 9
        Style = tbsCheck
      end
      object Spacer: TToolButton
        Left = 407
        Top = 0
        Width = 10
        Caption = 'Spacer'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object PanelSecurity: TPanel
        Left = 417
        Top = 0
        Width = 298
        Height = 36
        Align = alLeft
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 1
          Top = 1
          Width = 296
          Height = 34
          Align = alLeft
          Caption = 'Page Security Status:'
          TabOrder = 0
          object imgZone: TImage
            Left = 56
            Top = 16
            Width = 25
            Height = 17
          end
          object ImgSSL: TImage
            Left = 128
            Top = 16
            Width = 25
            Height = 19
            Picture.Data = {
              055449636F6E0000010001001010000001002000680400001600000028000000
              1000000020000000010020000000000000000000130B0000130B000000000000
              0000000000000000000000000D162735131D327C111D337E111D337D111D337D
              111D337D111D337D111D337D111D337D111E337D121E337F0B101B5100000110
              000000000000000000000000345B8BDC3095D3FF1D92DBFF1D8EDAFF1B8BDAFF
              1987DAFF1783DAFF1680DAFF137CDAFF1179DBFF1274D4FF1E487EE80302022C
              0000000000000000000000003C7AADF525C7FFFF1ABCFFFF18B6FFFF15B1FFFF
              12ABFFFF0FA5FFFF0CA0FFFF099BFFFF0695FFFF0393FFFF165CA6FA04000032
              0000000000000000000000003977AAF023BFFFFF1EBDFFFF1CB8FFFF19B3FFFF
              16AEFFFF14A9FFFF11A3FFFF0E9EFFFF0C99FFFF0997FFFF175DA3F604000031
              0000000000000000000000003D7BA9F029C9FFFF21C3FFFF22C3FFFF21C1FFFF
              20C0FFFF20BEFFFF1BB6FFFF13A7FFFF0F9FFFFF0C9FFFFF1960A2F604000031
              0000000000000000000000003F84AFF032D9FFFF2AD3FFFF2BD3FFFF2BD3FFFF
              2BD3FFFF2BD4FFFF2CD4FFFF26CBFFFF17B0FFFF0FA4FFFF1B66A7F604000031
              0000000000000000000000004396C0F037E9FFFF30E3FFFF31E3FFFF31E3FFFF
              31E3FFFF31E3FFFF31E3FFFF32E5FFFF2EDFFFFF18BAFFFF1B73B7F604020332
              00000000000000000000000050A7D0FA5BFDFFFF46F7FFFF49F8FFFF4CFAFFFF
              4CF9FFFF4CF8FFFF4CF9FFFF49F8FFFF49FAFFFF47F3FFFF2C91CAFF0203072E
              0000000000000000000000003393D2A95FC1E5F46FD1EAFF68CAE6FF5EC9EAEF
              5ECFF3E85CC9EAE85DCAECEA67CAE6FE6ED0EAFF5CC5E8F72A7CADB10104080D
              0000000000000000000000001F8DD80354759A92CACDD6FF9C9DA9FC21283866
              104770232997E4232478B630838491F2C2C9D4FF404556A9020E170700000000
              000000000000000000000000000000008564637DF1EDEBFFBBAAA8FC200F0B47
              000000000000000006131D0594807CEFEAE4E3FF473330990000000000000000
              000000000000000000000000000000008C6D6C7FF2F2F2FFC6B9B9FE261A1A60
              00000000000000001A0C0A1FA69797F5EDEAEAFF493A3A970000000000000000
              000000000000000000000000000000008A6B6B53DED7D7FFF0EDEDFF756262C3
              120B0B430C07072D6B5555A9D7D2D2FFE2D8D8FF3D2E2E6A0000000000000000
              000000000000000000000000000000008C6D6D0CB29C9CD4FFFFFFFFE7E2E2FF
              B1A1A1EDAB9B9BEAD7D1D1FFFCFDFDFFA99696DD100B0B1A0000000000000000
              00000000000000000000000000000000000000009A7C7C3AC4B3B3E4F8F7F7FF
              FEFFFFFFFBFCFCFFFAF7F7FFC6B3B3EA3F323245000000000000000000000000
              000000000000000000000000000000000000000000000000A1848427B29A9A93
              C6B5B5CDC8B7B7CF9E89899B5343433200000000000000000000000000000000
              00000000FFFF0000C0030000C0030000C0030000C0030000C0030000C0030000
              C0030000C0030000E3C70000F3C70000F3C70000F18F0000F00FFFFFF81FFFFF
              FC3FFFFF}
            Visible = False
          end
          object lblZone: TLabel
            Left = 8
            Top = 16
            Width = 3
            Height = 13
            ParentShowHint = False
            ShowHint = True
          end
          object lblSSL: TLabel
            Left = 104
            Top = 16
            Width = 3
            Height = 13
          end
          object lblLevel: TLabel
            Left = 160
            Top = 16
            Width = 3
            Height = 13
          end
          object imgUn: TImage
            Left = 104
            Top = 16
            Width = 17
            Height = 17
            Picture.Data = {
              055449636F6E0000010001001010000001002000680400001600000028000000
              1000000020000000010020000000000000000000130B0000130B000000000000
              0000000000000000090F1A281B2C4B991F3A62B41D385FB01D385FB01D385FB0
              1D385FB01D385FB01D375FB01D375FB01D375FB01E3861B31728459F060A1245
              0000000500000000294572913E9BD4FF1FA8F0FF1A9FEBFF199BEBFF1797EBFF
              1594EBFF128FEBFF118BEBFF0F88EBFF0D84EBFF0881F0FF1572D2FF192D4D9E
              00000009000000002B49779738B6EEFF1BC2FFFF1BBAFFFF18B5FFFF15B0FFFF
              13AAFFFF10A5FFFF0EA1FFFF0B9CFFFF0997FFFF0496FFFF0B84EBFF1A2F51A2
              0000000A000000002B49769638B2EFFF1CC0FFFF1FBDFFFF1DBAFFFF1BB6FFFF
              19B2FFFF16ADFFFF12A6FFFF0FA0FFFF0E9DFFFF0A9CFFFF1089EBFF192F50A1
              00000009000000002B4975963FBFEEFF24CCFFFF25C8FFFF25C8FFFF25C7FFFF
              25C7FFFF25C7FFFF22C3FFFF1AB4FFFF12A3FFFF0DA2FFFF148FEBFF192F50A1
              00000009000000002C55869646CDF1FF2DDDFFFF2ED8FFFF2ED8FFFF2ED9FFFF
              2ED9FFFF2ED9FFFF2FDAFFFF2FDAFFFF26CBFFFF14AFFFFF1596EFFF1A375BA1
              00000009000000002E6CA29751E1F5FF33F1FFFF34ECFFFF34ECFFFF34ECFFFF
              34ECFFFF34ECFFFF34ECFFFF34ECFFFF35EFFFFF2CE4FFFF1EAFF6FF1B4770A2
              0000000A000000002D7FBE906BDBF2FF6AFFFFFF60FEFFFF61FEFFFF61FDFFFF
              5EF5FEFF5EF4FDFF5EF5FEFF58F6FFFF52F0FEFF5AFBFFFF4FD7FFFF1C588894
              00000000000000002A8FD5240000000000000000000000000000000000000000
              3698D880369FE37E3797D6815F8AABDD86B3CFFF6A8FADF326527390061C2A20
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000004F5D77018A655FB7D7CFCBFF997D7AE01005042400000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000005000001746161BBDAD9D9FF9D8B8BE3130B0B3100000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000140C0C1B8E7B7BDEECEDEDFF998787DB0B05052200000000
              0000000000000000000000000000000000000000998604FF998604FF998604FF
              2C2020602F2323547B6565BBCFC8C8FFF4F0F0FF756262AF0000000600000000
              0000000000000000000000000000000093747437998604FFFFFFFFFFF1EEEEFF
              CFC3C3FDCCC0C0FDE6E4E4FFFCFCFCFFC0ADADEE312525400000000000000000
              00000000000000000000000000000000000000009A7E7E44C1AEAEE0ECE7E7FF
              FDFDFDFFFFFFFFFFF1EBEBFFB9A6A6E040333351000000000000000000000000
              000000000000000000000000000000000000000000000000A3868616AA8F8F62
              BAA2A295837373937562625E5647471400000000000000000000000000000000
              00000000C0030000800100008001000080010000800100008001000080010000
              80010000FC830000FFC78044E3C70000E3C70000E1870000F00F0000F81F0000
              FE7F0000}
            Visible = False
          end
        end
      end
    end
    object PanelMiddle: TPanel
      Left = 1
      Top = 37
      Width = 804
      Height = 36
      Align = alTop
      TabOrder = 1
      object PanelSearch: TPanel
        Left = 587
        Top = 1
        Width = 216
        Height = 34
        Align = alRight
        TabOrder = 0
        DesignSize = (
          216
          34)
        object spdBtnGoogleSearch: TSpeedButton
          Left = 167
          Top = 7
          Width = 41
          Height = 18
          Hint = 'Navigate to a Webpage'
          Anchors = [akTop, akRight]
          Caption = 'GO'
          Flat = True
          Glyph.Data = {
            AA030000424DAA03000000000000360000002800000011000000110000000100
            1800000000007403000000000000000000000000000000000001FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF44B53C44B53C44B53C44B53C44B53C
            44B53C44B53C44B53C44B53C44B53C44B53C44B53C44B53C44B53C44B53C001A
            DC00FFFFFFD65B37FFF3FFE3FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFBF5FFFFFFFFF8FFF4F4FFFFFFFF00FFFFFFD26B15FFFFEEFF
            FFF7FFFFF7FFF6E4BC73578F251AA02C13C53113BF3F16CB2A0EB4421DA98462
            F6F6E4FFFFFF00000000FFFFFFDB5F19F4FFFEE1FFF8FCE6E08B2628A4160BD9
            8F89FFF9E7F3FFFCF3FFEFFFFFEEFAD2AF561300FFFFFF00000000000000FFFF
            FFF7561FFFFFFFFFF9E7C52E209F120FFFD7BCFBFFF7FFFFFFEDF4FFFFFFFFFF
            FAFBFFE5D0801F15FFFFFFFFFFFFFFFFFF00FFFFFFD96022EAFFF4D6A47ABD25
            00C78F7CF6FFEDFFFFF8FFF8FFF4FFFEFECEC2B13731AA2A15B63325D08F86F4
            FFFE1924D200FFFFFFD15E1BFFFFF3DB6E42962200F4FBF8FFFFFFFFF1F7FFFF
            FFFFFFF3F6FFE8E3DBC4F9EACAFFE5D0F2D3CAE9FFFD0023C700FFFFFFE16114
            FFFFEECB5B26B0491CF8FAFFF6F0FFF4FFFEFFFFF3FFF5FFF8FFFEF8FFFEFFFF
            F8FFFFFFE9FFFDD9F8FF2F20D600FFFFFFD65327FFFFEEB96E22B15A1CE9FFFD
            F8FFFEFFF8FFFFF5FFFFFFFFFFF8FFFAF5FFFFFFFFF4FFFEEAFFF4F8FAFF1218
            DD00FFFFFFE85821FFFFF7E99A6FB5381CFFF5FFF8FFFEF4FFFEFFF8FFFFFFF3
            FFFFF3F4F4FFFFFFF8F4FFFEEDFFF7FFF8FF0E14CB00FFFFFFE7681DFFFBF5DF
            9981933B17F9D9D3FFFFF7E6FFF8F7FFF0E1FFF8F3FFF4FFF5FFFFFAFBFFFFFF
            F3FFF4E9FFFD002ACD00FFFFFFCA5C20E3FFFEFFFFF8D88565993523FFF9EAE3
            FFFEEFFEFAFFFFFFFFFFF8FFFFFFF3DCCDD4D2CAF3FFF4F3F9FF0F28D200FFFF
            FFCF6315F8FFFEF6FFEDFFF5C1CA7446BA3313FFEBDDFFFFE9FFFFFFFFFFE9FF
            D7C98C381C743029FFEEEEFFF3FF0710D100FFFFFFF65C15FFFFF8FFFFF8FFFF
            EEFFF2D7E99E7EAF685AB13A24C6321AB13604B86031EFAC6FF0DEBFF3FFF4E6
            F8FF0026CE00FFFFFFD85B2FEBFAF6FFFFFFF7F5FBE3FFFEFFFFE9FFFFF8FFF6
            E4ECDFE1FFFFF3F8F0F0FFFFF8FFF5FFF8FAFFF9F1FF222ECC00FFFFFFE86307
            4AB65639B64855AD4F45B34D50B84339B35541B14D52B54D44B53C3DB8504AB9
            473BB44C40B72D44B53C44B53C00}
          ParentShowHint = False
          ShowHint = True
          OnClick = spdBtnGoogleSearchClick
        end
        object edtSearch: TEdit
          Left = 8
          Top = 4
          Width = 161
          Height = 21
          TabOrder = 0
          Text = 'Search In Google'
        end
      end
      object PaneAddress: TPanel
        Left = 1
        Top = 1
        Width = 586
        Height = 34
        Align = alClient
        TabOrder = 1
        DesignSize = (
          586
          34)
        object btnGo: TSpeedButton
          Left = 323
          Top = 5
          Width = 41
          Height = 22
          Hint = 'Navigate to a Webpage'
          Caption = 'GO'
          Flat = True
          Glyph.Data = {
            9E020000424D9E0200000000000036000000280000000E0000000E0000000100
            1800000000006802000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFF79B17C2A882A0078000078002A892A79B27CFFFFFFFFFFFFFFFF
            FFFFFFFF0000FFFFFFFFFFFFA2C8A600780027A73340D3544DEE6248EC5A34CE
            401BA420007800A2C8A6FFFFFFFFFFFF0000FFFFFFA0C8A50A7F0D51DE6D53E5
            6F36BB4543CC5043CF4E41D14B41E44F33D33C057E06A0C8A5FFFFFF0000FFFF
            FF0078005AE17A5EE97A1A9120ADCEAD228B2337B63E42C54A3EC4453ED84933
            D33C007800FFFFFF000073AD7733AB466EF69457DC691B9120FFFFFFF2F7F280
            B5801A921E3FC1463EC34340E34D1AA31F73AD7700002586275FDD8266EA835C
            E1701D9323FFFFFFFFFFFFFFFFFFC9DEC943984327A32B3FD04933CE3E258627
            00000078007FFDAD69EC8563E87A1F9527FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            80B58029AD3145EB57007800000000780085FDB56FF18D6AF083229829FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF80B5802BAE354AED5F00780000002085226CDE93
            78F79A70F78D239A2DFFFFFFFFFFFFFFFFFFC9DEC9318F332DA83349D6593ED2
            502085220000579E5C3EAD548BFDBA73FA90249A2EFFFFFFF2F7F271AD712098
            274CCF5A4BCF5757EE7224A73064A46A0000FFFFFF00780079E7A384FCAE259A
            30ADCEAD258F2949C95957DB6851D6615AE7754DDD69007800FFFFFF0000FFFF
            FF82B28C0D801377E7A27CEEA952C96D64E57F63E77D61E67B69F48E56E07608
            7F0D82B28CFFFFFF0000FFFFFFFFFFFF7EB0890078003DAD5370E69A80FDB07A
            FDA95BDC7E30AB430078007EB088FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFAA
            C6BA559E5D19831C00780000780019831B499950FFFFFFFFFFFFFFFFFFFFFFFF
            0000}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnGoClick
        end
        object ProgressBar1: TProgressBar
          Left = 376
          Top = 5
          Width = 203
          Height = 20
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          Visible = False
        end
        object IEAddress1: TIEAddress
          Left = 3
          Top = 5
          Width = 314
          Height = 22
          About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
          ArrowColor = clNavy
          BorderColor = clInactiveCaptionText
          ButtonPressedColor = clInactiveCaptionText
          EmbeddedWB = EmbeddedWB1
          HintColor = clYellow
          IconLeft = 4
          IconTop = 3
          ItemHeight = 16
          ParentBiDiMode = True
          TabOrder = 1
          Text = 'http://leumi.co.il/'
          Themes = tmXP
          UseAppIcon = True
          Items.Strings = (
            'http://leumi.co.il/'
            
              'http://www.experts-exchange.com/Programming/Programming_Language' +
              's/Delphi/Q_20986816.html'
            'C:\Documents and Settings'
            'Downloads/EmbeddedWB_D2005_Version_14.53.zip')
        end
      end
    end
    object LinksBar1: TLinksBar
      Left = 1
      Top = 86
      Width = 804
      Height = 23
      Align = alBottom
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 65
      Caption = 'LinksBar1'
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowCaptions = True
      ShowHint = True
      TabOrder = 2
      About = 'LinksBar by bsalsa : bsalsa@bsalsa.no-ip.info'
      MaxCaptionLength = 15
      ShowImages = False
      WebBrowser = EmbeddedWB1
    end
  end
  object stBar: TStatusBar
    Left = 0
    Top = 563
    Width = 806
    Height = 19
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitTop = 543
  end
  object MainMenu1: TMainMenu
    Left = 144
    Top = 240
    object MMFile: TMenuItem
      Caption = '&File'
      object Open: TMenuItem
        Caption = '&Open Page Dialog...'
        OnClick = OpenClick
      end
      object LoadFromStream: TMenuItem
        Caption = 'Load From Stream'
        OnClick = LoadFromStreamClick
      end
      object LoadFromStrings: TMenuItem
        Caption = 'Load From Strings'
        OnClick = LoadFromStringsClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object SavePageToStrings1: TMenuItem
        Caption = 'Save Page To Strings'
        OnClick = SavePageToStrings1Click
      end
      object SavePageToStream: TMenuItem
        Caption = 'Save Page To Stream'
        OnClick = SavePageToStreamClick
      end
      object SaveThePageTofile1: TMenuItem
        Caption = 'Save Page to file'
        OnClick = SaveThePageTofile1Click
      end
      object miSave: TMenuItem
        Caption = 'Save Dialog'
        OnClick = miSaveClick
      end
      object SaveAs1: TMenuItem
        Caption = '&Save page As...'
        OnClick = SaveAs1Click
      end
      object Savepagetext: TMenuItem
        Caption = 'Save page text'
        OnClick = SavepagetextClick
      end
      object SaveAllImages: TMenuItem
        Caption = 'Save Page Images'
        OnClick = SaveAllImagesClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Print: TMenuItem
        Caption = '&Print...'
        OnClick = PrintClick
      end
      object PrintPreview1: TMenuItem
        Caption = 'Print Previe&w'
        OnClick = PrintPreview1Click
      end
      object PageSetup1: TMenuItem
        Caption = 'Page &Setup'
        OnClick = PageSetup1Click
      end
      object PrintWithOptions: TMenuItem
        Caption = 'Print With Options'
        OnClick = PrintWithOptionsClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object OfflineMode1: TMenuItem
        Caption = 'Work Offline'
        OnClick = OfflineMode1Click
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object MMEdit: TMenuItem
      Caption = '&Edit'
      object Cut1: TMenuItem
        Caption = 'Cut To CLipboard'
        OnClick = Cut1Click
      end
      object Pastefromclipboard1: TMenuItem
        Caption = 'Paste from clipboard'
        OnClick = Pastefromclipboard1Click
      end
      object Copy: TMenuItem
        Caption = 'Cop&y to clipboard'
        OnClick = CopyClick
      end
      object SelectAll: TMenuItem
        Caption = 'Select &All'
        OnClick = SelectAllClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object FindDialog: TMenuItem
        Caption = '&Find Dialog (Current Page)...'
        OnClick = FindDialogClick
      end
      object SearchandHighlightall: TMenuItem
        Caption = 'Search and Highlight all'
        OnClick = SearchandHighlightallClick
      end
    end
    object MMView: TMenuItem
      Caption = '&View'
      object ViewSourceHtml: TMenuItem
        Caption = '&Page Source (Html)'
        OnClick = ViewSourceHtmlClick
      end
      object PageSourceText: TMenuItem
        Caption = 'Page Source (Text)'
        OnClick = PageSourceTextClick
      end
      object PageSourceHtmlasstrings1: TMenuItem
        Caption = 'Page Source (Html As Strings)'
        OnClick = PageSourceHtmlasstrings1Click
      end
      object PageSourceTextasstrings1: TMenuItem
        Caption = 'Page Source (Text  A Strings)'
        OnClick = PageSourceTextasstrings1Click
      end
      object ViewPageLinksAsAList1: TMenuItem
        Caption = 'View Page Links As A List'
        OnClick = ViewPageLinksAsAList1Click
      end
      object ViewPageImagesAsAList1: TMenuItem
        Caption = 'View Page Images As A List'
        OnClick = ViewPageImagesAsAList1Click
      end
      object ViewPageFieldsAsAList1: TMenuItem
        Caption = 'View Page Fields As A List'
        OnClick = ViewPageFieldsAsAList1Click
      end
      object ViewPagePropertiesAsAList1: TMenuItem
        Caption = 'View Page Properties As A List'
        OnClick = ViewPagePropertiesAsAList1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object CharacterSet1: TMenuItem
        Caption = 'Encoding'
        object CharSetAutomatic1: TMenuItem
          Caption = 'Automatic'
          Checked = True
          GroupIndex = 1
          Hint = '_autodetect_all'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object N7: TMenuItem
          Caption = '-'
          GroupIndex = 1
          RadioItem = True
        end
        object CentralEuropeanISO1: TMenuItem
          Caption = 'Central European (ISO)'
          GroupIndex = 1
          Hint = 'iso-8859-2'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object WesternEuropeanISO1: TMenuItem
          Caption = 'Western European (ISO)'
          GroupIndex = 1
          Hint = 'iso-8859-1'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object UnicodeUTF1: TMenuItem
          Caption = 'Unicode (UTF-8)'
          GroupIndex = 1
          Hint = 'utf-8'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object N8: TMenuItem
          Caption = '-'
          GroupIndex = 1
          RadioItem = True
        end
        object ArabicWindows1: TMenuItem
          Caption = 'Arabic (Windows)'
          GroupIndex = 1
          Hint = 'windows-1256'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object BalticWindows1: TMenuItem
          Caption = 'Baltic (Windows)'
          GroupIndex = 1
          Hint = 'windows-1257'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object ChineseSimplifiedGB1: TMenuItem
          Caption = 'Chinese Simplified (GB2312)'
          GroupIndex = 1
          Hint = 'gb2312'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object ChineseTraditionalBIG1: TMenuItem
          Caption = 'Chinese Traditional (Big5)'
          GroupIndex = 1
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object GreekWindows1: TMenuItem
          Caption = 'Greek (Windows)'
          GroupIndex = 1
          Hint = 'windows-1253'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object Korean1: TMenuItem
          Caption = 'Korean (ISO)'
          GroupIndex = 1
          Hint = 'iso-2022-kr'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object haiWindows1: TMenuItem
          Caption = 'Thai (Windows)'
          GroupIndex = 1
          Hint = 'windows-874'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
        object urkishWindows1: TMenuItem
          Caption = 'Turkish (Windows)'
          GroupIndex = 1
          Hint = 'windows-1254'
          RadioItem = True
          OnClick = CharSetAutomatic1Click
        end
      end
      object Zoom1: TMenuItem
        Caption = 'Text Size'
        OnClick = Zoom1Click
        object Largest1: TMenuItem
          Tag = 4
          Caption = 'Largest'
          OnClick = Smallest1Click
        end
        object Large1: TMenuItem
          Tag = 3
          Caption = 'Large'
          OnClick = Smallest1Click
        end
        object Medium1: TMenuItem
          Tag = 2
          Caption = 'Medium'
          OnClick = Smallest1Click
        end
        object Small1: TMenuItem
          Tag = 1
          Caption = 'Small'
          OnClick = Smallest1Click
        end
        object Smallest1: TMenuItem
          Caption = 'Smallest'
          OnClick = Smallest1Click
        end
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ScrollToTheTop1: TMenuItem
        Caption = 'Scroll to the top'
        OnClick = ScrollToTheTop1Click
      end
      object ScrolToPosition1: TMenuItem
        Caption = 'Scroll To Position'
        OnClick = ScrolToPosition1Click
      end
      object Scrolltothebottom1: TMenuItem
        Caption = 'Scroll to the bottom'
        OnClick = Scrolltothebottom1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object ViewHidethelinksbar1: TMenuItem
        Caption = 'View/Hide the links bar'
        OnClick = ViewHidethelinksbar1Click
      end
    end
    object MMNavigation: TMenuItem
      Caption = 'Navigation'
      object GoHome1: TMenuItem
        Caption = 'Go Home'
        OnClick = ToolBtnHomeClick
      end
      object GoBack1: TMenuItem
        Caption = 'Go Back'
        OnClick = ToolbtnBackClick
      end
      object GoForward1: TMenuItem
        Caption = 'Go Forward'
        OnClick = ToolBtnForwardClick
      end
      object GoAboutBlank1: TMenuItem
        Caption = 'Go About : Blank'
        OnClick = GoAboutBlank1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Stop1: TMenuItem
        Caption = 'Stop'
        OnClick = ToolBtnStopClick
      end
      object Refresh1: TMenuItem
        Caption = 'Refresh'
        OnClick = ToolBtnRefreshClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object GoDowloadMasked1: TMenuItem
        Caption = 'Go Dowload Masked'
        OnClick = GoDowloadMasked1Click
      end
      object GoWithQueryDetails1: TMenuItem
        Caption = 'Go With Query Details'
        OnClick = GoWithQueryDetails1Click
      end
      object Godownloadafile1: TMenuItem
        Caption = 'Go And Download A File'
        OnClick = Godownloadafile1Click
      end
    end
    object MMTools: TMenuItem
      Caption = '&Tools'
      object EmbeddedWBOptions1: TMenuItem
        Caption = 'EmbeddedWB Options'
        object FillFormWithPersonalDetails1: TMenuItem
          Caption = 'Fill Form With Personal Details'
          OnClick = FillFormWithPersonalDetails1Click
        end
        object GetDefaultWebBrowserFromResistry1: TMenuItem
          Caption = 'Get Default Web Browser From Resistry'
          OnClick = GetDefaultWebBrowserFromResistry1Click
        end
        object CreateAShortCutOnYourDeskTop1: TMenuItem
          Caption = 'Create A ShortCut On Your Desktop'
          OnClick = CreateAShortCutOnYourDeskTop1Click
        end
        object checkOnlineStatus2: TMenuItem
          Caption = 'Check Online Status'
          OnClick = checkOnlineStatus2Click
        end
        object GetHostAndIP1: TMenuItem
          Caption = 'Get Host And IP'
          OnClick = GetHostAndIP1Click
        end
        object GetSpecialFolderPath1: TMenuItem
          Caption = 'Get Special Folder Path'
          OnClick = GetSpecialFolderPath1Click
        end
        object N20: TMenuItem
          Caption = '-'
        end
        object DisableRightClickMenu: TMenuItem
          Caption = 'Disable Right Click Menu'
          OnClick = DisableRightClickMenuClick
        end
        object SetDesignMode: TMenuItem
          Caption = 'Set Design mode on/off'
          OnClick = SetDesignModeClick
        end
      end
      object Security1: TMenuItem
        Caption = 'Security'
        object AddToRestrictedZoneList: TMenuItem
          Caption = 'Add To Restricted Zone List'
          OnClick = AddToRestrictedZoneListClick
        end
        object CheckIfInResrictedZoneList1: TMenuItem
          Caption = 'Check If In Resricted Zone List'
          OnClick = CheckIfInResrictedZoneList1Click
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object AddToTrustedListZoneList1: TMenuItem
          Caption = 'Add To Trusted List Zone List'
          OnClick = AddToTrustedListZoneList1Click
        end
        object CheckIfInTrustedZoneList1: TMenuItem
          Caption = 'Check If In Trusted Zone List'
          OnClick = CheckIfInTrustedZoneList1Click
        end
        object N19: TMenuItem
          Caption = '-'
        end
        object CheckSiteSecurityLevel1: TMenuItem
          Caption = 'Check Site Security Level'
          OnClick = CheckSiteSecurityLevel1Click
        end
        object CheckSiteSecurityZone1: TMenuItem
          Caption = 'Check Site Security Zone'
          OnClick = CheckSiteSecurityZone1Click
        end
        object CheckPageSecurityEncryption1: TMenuItem
          Caption = 'Check Page Security Encryption'
          OnClick = CheckPageSecurityEncryption1Click
        end
      end
      object FavoritesTools1: TMenuItem
        Caption = 'Favorites Tools'
        object OpenOtherBrowsersFavorites1: TMenuItem
          Caption = 'Open Other Browsers Favorites'
          OnClick = OpenOtherBrowsersFavorites1Click
        end
        object Addsitetofavorites: TMenuItem
          Caption = 'Add site to favorites'
        end
        object ImportExportWizard1: TMenuItem
          Caption = 'Show Import / Export Wizard'
          OnClick = ImportExportWizard1Click
        end
        object ShowOrganizeFavorites1: TMenuItem
          Caption = 'Show Organize Favorites'
          OnClick = ShowOrganizeFavorites1Click
        end
        object ExportFavorites1: TMenuItem
          Caption = 'Export Favorites'
          OnClick = ExportFavorites1Click
        end
        object ImportFavorites1: TMenuItem
          Caption = 'Import Favorites'
          OnClick = ImportFavorites1Click
        end
        object AddToFavorites1: TMenuItem
          Caption = 'Add To Favorites'
          OnClick = AddToFavorites1Click
        end
        object GetFavoritesPath1: TMenuItem
          Caption = 'Get Favorites Path'
          OnClick = GetFavoritesPath1Click
        end
      end
      object HistoryTools1: TMenuItem
        Caption = 'History Tools'
        object GetHistoryPath1: TMenuItem
          Caption = 'Get History Path'
          OnClick = GetHistoryPath1Click
        end
        object DeleteHistory1: TMenuItem
          Caption = 'Delete History'
          OnClick = DeleteHistory1Click
        end
        object ClearAddressBarTypedURLs1: TMenuItem
          Caption = 'Clear Address Bar ( Typed URL'#39's)'
          OnClick = ClearAddressBarTypedURLs1Click
        end
      end
      object CacheTools1: TMenuItem
        Caption = 'Cache Tools'
        object GetCachedPath: TMenuItem
          Caption = 'Get Cached File Path'
          OnClick = GetCachedPathClick
        end
        object ClearCache1: TMenuItem
          Caption = 'Clear Cache'
          OnClick = ClearCache1Click
        end
      end
      object MailTools1: TMenuItem
        Caption = 'Mail Tools'
        object SendThePageInMail1: TMenuItem
          Caption = 'Send The Page In Mail'
          OnClick = SendThePageInMail1Click
        end
        object SendTheURL: TMenuItem
          Caption = 'Send The Url In Mail'
          OnClick = SendTheURLClick
        end
        object SavePageToEmail2: TMenuItem
          Caption = 'Save Page To Email'
        end
        object CreateNewMail1: TMenuItem
          Caption = 'Create New Mail'
          OnClick = CreateNewMail1Click
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object OpenYahooMail1: TMenuItem
          Caption = 'Open Yahoo Mail'
          OnClick = OpenYahooMail1Click
        end
        object OpenOutlook1: TMenuItem
          Caption = 'Open Outlook'
          OnClick = OpenOutlook1Click
        end
        object OpenOutlookExpress1: TMenuItem
          Caption = 'Open Outlook Express'
          OnClick = OpenOutlookExpress1Click
        end
        object OpenGoogleMail1: TMenuItem
          Caption = 'Open Google Mail'
          OnClick = OpenGoogleMail1Click
        end
        object OpenAddressBook1: TMenuItem
          Caption = 'Open Address Book'
          OnClick = OpenAddressBook1Click
        end
        object OpenHotmailMail1: TMenuItem
          Caption = 'Open Hotmail Mail'
          OnClick = OpenHotmailMail1Click
        end
      end
      object HomePage1: TMenuItem
        Caption = 'Home Page'
        object GetIEHomePage: TMenuItem
          Caption = 'Get IE Home Page'
          OnClick = GetIEHomePageClick
        end
        object SetIENewHomePage: TMenuItem
          Caption = 'Set IE New Home Page'
          OnClick = SetIENewHomePageClick
        end
      end
      object Cookies1: TMenuItem
        Caption = 'Cookies'
        object CookiesCheck1: TMenuItem
          Caption = 'Check the site for Cookies'
          OnClick = CookiesCheck1Click
        end
        object GetCookiesPath1: TMenuItem
          Caption = 'Get Cookies Path'
          OnClick = GetCookiesPath1Click
        end
      end
      object Images1: TMenuItem
        Caption = 'Images'
        object ShowTheImageEditor1: TMenuItem
          Caption = 'Show The Image Editor'
          OnClick = ShowTheImageEditor1Click
        end
        object GetAScreanCapture1: TMenuItem
          Caption = 'Get A Page Capture (Bmp)'
          OnClick = GetAScreanCapture1Click
        end
        object GetJpegPageCapture1: TMenuItem
          Caption = 'Get A Page Capture (Jpeg)'
          OnClick = GetJpegPageCapture1Click
        end
        object GetThumbnail: TMenuItem
          Caption = 'Get page to Thumbnail'
          OnClick = GetThumbnailClick
        end
      end
      object GoSearch1: TMenuItem
        Caption = 'Go Search'
        object SearchImMsn1: TMenuItem
          Caption = 'Search Im Msn'
          OnClick = SearchImMsn1Click
        end
        object SearchInGoogle1: TMenuItem
          Caption = 'Search In Google'
          OnClick = SearchInGoogle1Click
        end
        object SearchInYahoo1: TMenuItem
          Caption = 'Search In Yahoo'
          OnClick = SearchInYahoo1Click
        end
      end
      object Open1: TMenuItem
        Caption = 'Show / Open'
        object ShowInternetExplorerVersion1: TMenuItem
          Caption = 'Show Internet Explorer Version'
          OnClick = ShowInternetExplorerVersion1Click
        end
        object InternetOptions1: TMenuItem
          Caption = 'Show Internet &Options...'
          OnClick = InternetOptions1Click
        end
        object Properties: TMenuItem
          Caption = 'Show Page Properties'
          OnClick = PropertiesClick
        end
        object OpenNewsClient1: TMenuItem
          Caption = 'Open News Client'
          OnClick = OpenNewsClient1Click
        end
        object OpenCalender1: TMenuItem
          Caption = 'Open Calender'
          OnClick = OpenCalender1Click
        end
        object OpenNetMeeting: TMenuItem
          Caption = 'Open Net Meeting'
          OnClick = OpenNetMeetingClick
        end
        object OpenFoldersExplore1: TMenuItem
          Caption = 'Open Folders (Explore)'
          OnClick = OpenFoldersExplore1Click
        end
        object OpenRegistryEditor1: TMenuItem
          Caption = 'Open Registry Editor'
          OnClick = OpenRegistryEditor1Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object LinksList1: TMenuItem
        Caption = 'Links List'
        object AddTheSiteToTheList1: TMenuItem
          Caption = 'Add The Site To The List'
          OnClick = AddTheSiteToTheList1Click
        end
        object RemoveTheSiteFromTheList1: TMenuItem
          Caption = 'Remove The Site From The List'
          OnClick = RemoveTheSiteFromTheList1Click
        end
        object NavigateToLinkItem1: TMenuItem
          Caption = 'Navigate To Link Item'
          OnClick = NavigateToLinkItem1Click
        end
        object CheckTheLinks: TMenuItem
          Caption = 'Check the links'
          OnClick = CheckTheLinksClick
        end
        object N13: TMenuItem
          Caption = '-'
        end
        object ShowTheList1: TMenuItem
          Caption = 'Show The List'
          OnClick = ShowTheList1Click
        end
        object ShowHideTheLinksToolbar1: TMenuItem
          Caption = 'Show / Hide The Links Toolbar'
          OnClick = ViewHideTheLinksToolbar1Click
        end
        object N15: TMenuItem
          Caption = '-'
        end
        object ClearTheLinkList1: TMenuItem
          Caption = 'Clear The Link List'
          OnClick = ClearTheLinkList1Click
        end
      end
      object IEDownload: TMenuItem
        Caption = 'IE Download'
        object CheckURLsFromALinkList1: TMenuItem
          Caption = 'Check URL'#39's From A Link List'
          OnClick = CheckURLsFromALinkList1Click
        end
      end
      object RichViewWBDemo1: TMenuItem
        Caption = 'RichViewWB Demo'
        object ShowTheEditor2: TMenuItem
          Caption = 'Show The Editor'
          OnClick = ShowTheEditor2Click
        end
        object N28: TMenuItem
          Caption = '-'
        end
        object Fonts: TMenuItem
          Caption = 'Fonts'
          object SelectFonts1: TMenuItem
            Caption = 'Set Fonts'
            OnClick = SelectFonts1Click
          end
          object SetFontColor: TMenuItem
            Caption = 'Set Font Color'
            OnClick = SetFontColorClick
          end
          object SetSize1: TMenuItem
            Caption = 'Set Size'
            OnClick = SetSize1Click
          end
          object SetBold1: TMenuItem
            Caption = 'Set Bold'
            OnClick = SetBold1Click
          end
          object SetItalic1: TMenuItem
            Caption = 'Set Italic'
            OnClick = SetItalic1Click
          end
          object SetUnderLine1: TMenuItem
            Caption = 'Set UnderLine'
            OnClick = SetUnderLine1Click
          end
          object AddBackroundColor1: TMenuItem
            Caption = 'Add Backround Color To Selected Text'
            OnClick = AddBackroundColor1Click
          end
          object ResetFontsFormat1: TMenuItem
            Caption = 'Reset Fonts Format'
            OnClick = ResetFontsFormat1Click
          end
        end
        object File1: TMenuItem
          Caption = 'File'
          object New1: TMenuItem
            Caption = 'New'
            OnClick = New1Click
          end
          object Open2: TMenuItem
            Caption = 'Open'
            OnClick = Open2Click
          end
          object Save1: TMenuItem
            Caption = 'Save'
            OnClick = Save1Click
          end
          object SaveAs2: TMenuItem
            Caption = 'Save As..'
            OnClick = SaveAs2Click
          end
          object N27: TMenuItem
            Caption = '-'
          end
          object Print1: TMenuItem
            Caption = 'Print'
            OnClick = Print1Click
          end
        end
        object Tools: TMenuItem
          Caption = 'Tools'
          object CreateASnapshot1: TMenuItem
            Caption = 'Create A Snapshot'
            OnClick = CreateASnapshot1Click
          end
          object PreviewRichEditLinesInTheBrowser1: TMenuItem
            Caption = 'Preview Code In The Browser (Stream)'
            OnClick = PreviewRichEditLinesInTheBrowser1Click
          end
          object LoadCodeFromBrowserStream1: TMenuItem
            Caption = 'Load HTML Code From Browser (Stream)'
            OnClick = LoadCodeFromBrowserStream1Click
          end
          object N22: TMenuItem
            Caption = '-'
          end
          object MailSelectedText1: TMenuItem
            Caption = 'Mail Selected Text'
            OnClick = MailSelectedText1Click
          end
          object Mail1: TMenuItem
            Caption = 'Mail'
            OnClick = Mail1Click
          end
          object N23: TMenuItem
            Caption = '-'
          end
          object HighlighHTML1: TMenuItem
            Caption = 'Highligh HTML'
            OnClick = HighlighHTML1Click
          end
          object HighLightXML1: TMenuItem
            Caption = 'HighLight XML'
            OnClick = HighLightXML1Click
          end
          object HighLightURL1: TMenuItem
            Caption = 'HighLight URL'
            OnClick = HighLightURL1Click
          end
          object N25: TMenuItem
            Caption = '-'
          end
          object SetColor1: TMenuItem
            Caption = 'Set Color'
            OnClick = SetColor1Click
          end
          object hemes1: TMenuItem
            Caption = 'Sert Themes'
            OnClick = hemes1Click
          end
        end
        object Edit: TMenuItem
          Caption = 'Edit'
          object Find1: TMenuItem
            Caption = 'Find'
            OnClick = Find1Click
          end
          object Replace1: TMenuItem
            Caption = 'Replace'
            OnClick = Replace1Click
          end
          object GoToLineNumber1: TMenuItem
            Caption = 'Go To Line Number..'
            OnClick = GoToLineNumber1Click
          end
          object SetSelectionAsAHyperLink1: TMenuItem
            Caption = 'Set Selection As A HyperLink'
            OnClick = SetSelectionAsAHyperLink1Click
          end
          object SetWordAsAHyperLink1: TMenuItem
            Caption = 'Set Word As A HyperLink'
            OnClick = SetWordAsAHyperLink1Click
          end
          object WrapLongLines1: TMenuItem
            Caption = 'Wrap Long Lines'
            Checked = True
            OnClick = WrapLongLines1Click
          end
        end
        object Add: TMenuItem
          Caption = 'Add'
          object InsertFromImageList: TMenuItem
            Caption = 'Insert Smiles And Formated Text from image list Demo'
            OnClick = InsertFromImageListClick
          end
          object InsertFile: TMenuItem
            Caption = 'Insert File ( As Link)'
            OnClick = InsertFileClick
          end
          object InsertBitmap: TMenuItem
            Caption = 'Insert Bitmap'
            OnClick = InsertBitmapClick
          end
          object N21: TMenuItem
            Caption = '-'
          end
          object AddDateAndTime1: TMenuItem
            Caption = 'Add Date And Time'
            OnClick = AddDateAndTime1Click
          end
          object N26: TMenuItem
            Caption = '-'
          end
          object AddBullets1: TMenuItem
            Caption = 'Add Bullets'
            OnClick = AddBullets1Click
          end
          object AddRomanNumbers1: TMenuItem
            Caption = 'Add Roman Line Numbers'
            OnClick = AddRomanNumbers1Click
          end
          object AddLineNumbers1: TMenuItem
            Caption = 'Add Line Numbers'
            OnClick = AddLineNumbers1Click
          end
          object N24: TMenuItem
            Caption = '-'
          end
          object AddAButton1: TMenuItem
            Caption = 'Add A Button'
            OnClick = AddAButton1Click
          end
          object AddTEditBox1: TMenuItem
            Caption = 'Add TEdit Box'
            OnClick = AddTEditBox1Click
          end
          object AddARadioButton1: TMenuItem
            Caption = 'Add A Radio Button'
            OnClick = AddARadioButton1Click
          end
          object AddACheckBox1: TMenuItem
            Caption = 'Add A TCheckBox'
            OnClick = AddACheckBox1Click
          end
        end
      end
    end
  end
  object HistoryMenu: THistoryMenu
    EmbeddedWB = EmbeddedWB1
    MainMenu = MainMenu1
    MenuPosition = 6
    Caption = 'History'
    Left = 112
    Top = 208
  end
  object ilToolBar: TImageList
    Left = 46
    Top = 208
    Bitmap = {
      494C01010C000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE00FEFEFE00FEFEFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000626C81003E53
      73003E5271003F5371003F5371003F5371003F5371003F5271003F5271003F52
      71003E517200515B700000000000000000000000000000000000000000000000
      0000EEEDED00A9A49B0082775900817345008B816800C2C0BC00EDECEB00FDFD
      FD00000000000000000000000000000000000000000000000000000000000000
      0000F8F8F800D1D1D100A1A1A100898989008C8C8C00ADADAD00DCDCDC00FCFC
      FC000000000000000000000000000000000000000000000000004F719A003095
      D3001D92DB001D8EDA001B8BDA001987DA001783DA001680DA00137CDA001179
      DB001274D400325889000000000000000000000000008595AE003E9BD4001FA8
      F0001A9FEB00199BEB001797EB001594EB00128FEB00118BEB000F88EB000D84
      EB000881F0001572D2005F6B7F0000000000000000000000000000000000958E
      7E00998141008E773500846A1F00685E2800765E00006F56000086703600CBC8
      C600F8F8F8000000000000000000000000000000000000000000FEFEFE00D8D8
      D8006169AE000A1EB7000E24CC000E24CC00091DB2000719A2005D6184008F8F
      8F00EAEAEA000000000000000000000000000000000000000000437FB00025C7
      FF001ABCFF0018B6FF0015B1FF0012ABFF000FA5FF000CA0FF00099BFF000695
      FF000393FF001A5FA7000000000000000000000000008193AE0038B6EE001BC2
      FF001BBAFF0018B5FF0015B0FF0013AAFF0010A5FF000EA1FF000B9CFF000997
      FF000496FF000B84EB005B687E0000000000000000000000000092846500A490
      5C009C864E00947E42008D7532004A929D007E66150088712800AB976600AC95
      5D00BCB9B500FBFBFA0000000000000000000000000000000000C4C5CE001129
      E000142EF500142EF500142EF500142EF500142EF500142EF5000E25D1001627
      A7006D6D6D00E7E7E70000000000000000000000000000000000447FAF0023BF
      FF001EBDFF001CB8FF0019B3FF0016AEFF0014A9FF0011A3FF000E9EFF000C99
      FF000997FF001F62A6000000000000000000000000008293AE0038B2EF001CC0
      FF001FBDFF001DBAFF001BB6FF0019B2FF0016ADFF0012A6FF000FA0FF000E9D
      FF000A9CFF001089EB005B697E0000000000000000009E988C00B5A37700AC97
      6900A38F5B009C864F00947E43006191840077581400AE9A6B00AE996B00A38C
      58007A611300DCDBDA00000000000000000000000000E9E9E900142EF500142E
      F500142EF500142EF500142EF500142EF500142EF500142EF500142EF500132D
      F0001627A70084848400F9F9F9000000000000000000000000004882AE0029C9
      FF0021C3FF0022C3FF0021C1FF0020C0FF0020BEFF001BB6FF0013A7FF000F9F
      FF000C9FFF002165A5000000000000000000000000008293AD003FBFEE0024CC
      FF0025C8FF0025C8FF0025C7FF0025C7FF0025C7FF0022C3FF001AB4FF0012A3
      FF000DA2FF00148FEB005B697E000000000000000000CDBE9A00BBAA8300B3A2
      7600AC986900A48F5B009C864F0079693F0079B1B100B9A67B00AC9868007C64
      0E006F57000080755500F9F9F90000000000FCFCFC00223BF500142EF500142E
      F5004E62F700000000000000000000000000F0F0F000142EF500142EF500142E
      F500122AE500545DA200D0D0D0000000000000000000000000004A8BB30032D9
      FF002AD3FF002BD3FF002BD3FF002BD3FF002BD4FF002CD4FF0026CBFF0017B0
      FF000FA4FF00236BAA00000000000000000000000000829BB70046CDF1002DDD
      FF002ED8FF002ED8FF002ED9FF002ED9FF002ED9FF002FDAFF002FDAFF0026CB
      FF0014AFFF001596EF005C6E850000000000BAB8B200CEC2A400C3B49200BAAA
      8100B3A07400AA966700A9935E0081693500AFFCFF00AB926100836C23007F67
      1900775F01006C540100F0EFEF0000000000C4CAFC00142EF500142EF5008894
      F400000000000000000000000000000000003D51E700142EF500142EF500142E
      F500142EF5000719A200979797000000000000000000000000004E9CC30037E9
      FF0030E3FF0031E3FF0031E3FF0031E3FF0031E3FF0031E3FF0032E5FF002EDF
      FF0018BAFF002377B90000000000000000000000000083A7C70051E1F50033F1
      FF0034ECFF0034ECFF0034ECFF0034ECFF0034ECFF0034ECFF0034ECFF0035EF
      FF002CE4FF001EAFF6005C78920000000000A8A49900D6CDB500D6CCB400D2C7
      AB00CCBFA000C9B99400DFDEDD00FEFCFC0092E2F0006D785F008E773600866F
      28007F671900785F0000E4E4E30000000000223BF500142EF500142EF5000000
      00000000000000000000000000001E34DB00142EF500142EF500223BF500142E
      F500142EF5000F26D6007474740000000000000000000000000053A8D0005BFD
      FF0046F7FF0049F8FF004CFAFF004CF9FF004CF8FF004CF9FF0049F8FF0049FA
      FF0047F3FF002C91CA0000000000000000000000000088B6DA006BDBF2006AFF
      FF0060FEFF0061FEFF0061FDFF005EF5FE005EF4FD005EF5FE0058F6FF0052F0
      FE005AFBFF004FD7FF00688BA60000000000B4B0A700E3DECC00DDD4C000D7CE
      B500D2C5A900A6C5C600CAE6EA00B0E4EE0086E7FB0074DCEF0093793B008D76
      3600866E280080671400E4E3E20000000000142EF500142EF5000E24CC000000
      000000000000000000001E34DB00142EF500142EF500223BF500ECECEC003E53
      F500142EF500142EF5007070700000000000000000000000000077B7E10065C3
      E6006FD1EA0068CAE60068CCEB006CD3F4006ACDEB006ACEED0067CAE6006ED0
      EA0061C6E8006BA4C60000000000000000000000000000000000000000000000
      000000000000000000004692B20051B5E600000000004FB2E1006092B30086B3
      CF006A91AF00447596000000000000000000B2AFAA00EAE8DC00E3DDCD00DDD5
      C100D6CBB200D4E8EC00D8F7FF00B7F1FF00B1F5FF0090F6FF007D704900947E
      43008D763600866E2600F2F2F20000000000142EF500142EF5000B20BC000000
      0000000000001E34DB00142EF500142EF500223BF50000000000000000004C60
      F400142EF500142EF50086868600000000000000000000000000000000009DAF
      C500CACDD6009D9EAA0000000000000000000000000000000000898A9600C2C9
      D40080838E000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008A6F6E00D7CF
      CB00967D7C00000000000000000000000000F5F5F400FDFDF700E9E6DA00E5E0
      D000ECE7DA00D5E1E000CAF5FF00C4FAFF00A7947600A99C8000A89E8200AF9B
      6D009B854E0082744A00FDFDFD0000000000142EF500142EF5001027DB00DFE2
      F3002038EB00142EF500142EF500223BF5000000000000000000FEFEFE00142E
      F500142EF500132DF000BCBCBC00000000000000000000000000000000000000
      0000F1EDEB00BBABA900000000000000000000000000000000009A878400EAE4
      E30090848200000000000000000000000000000000000000000000000000A38C
      8B00CBBDBD007E696900000000000000000000000000000000007E6B6A00DAD9
      D9009B89890000000000000000000000000000000000BCBBB500F1F1EB00F2F0
      E700F0EBE100CCD5D300D4F6FF00CDF9FF00B0A69000C6B79500C0AF8A00BAA8
      7F00BBA77800D5D4D10000000000000000005D6FF800142EF500142EF500122A
      E500142EF500142EF500223BF500000000000000000000000000BBBCC900142E
      F500142EF5003546CC00EFEFEF00000000000000000000000000000000000000
      0000F2F2F200C6B9B90000000000000000000000000000000000A99B9B00EDEA
      EA00938A8A00000000000000000000000000000000000000000000000000B8A5
      A500FFFFFF00A594940000000000000000000000000000000000917F7F00ECED
      ED00988686000000000000000000000000000000000000000000FDFDFC00F4F5
      F000F1EEE600BEC1BB00DEF9FF00D5F6FF00AEB6AF00CBBF9F00C6B69500C4B3
      8D00A39D9100FEFEFE00000000000000000000000000142EF500142EF500142E
      F500142EF500223BF500000000000000000000000000A1A8DB00142EF500142E
      F500142EF500C8C8C80000000000000000000000000000000000000000000000
      0000DED7D700F0EDED009586860000000000000000009C8E8E00D7D2D200E2D8
      D80000000000000000000000000000000000000000000000000000000000B39E
      9E00F6F5F500E3DEDE007F6D6D00000000000000000084707000CFC8C800F4F0
      F00087787800000000000000000000000000000000000000000000000000E1E0
      DC00F8F8F300BEBDB600EAFDFF00DEF8FF00BCD3D700D3C7AB00D7C9A900AAA5
      9C0000000000000000000000000000000000000000008996F900142EF500142E
      F500142EF5000E25D100091CAC00091DB2000F26D600142EF500142EF500142E
      F500949ACC00FCFCFC0000000000000000000000000000000000000000000000
      0000BEACAC00FFFFFF00E7E2E200B6A7A700B1A3A300D7D1D100FCFDFD00B4A4
      A400000000000000000000000000000000000000000000000000000000000000
      0000C4B4B400FFFFFF00F1EEEE00CEC2C200CBBFBF00E6E4E400FCFCFC00BFAC
      AC00000000000000000000000000000000000000000000000000000000000000
      0000CDCBC800A7A59E0000000000F1FFFF00E3FBFE00A29C9000F6F6F6000000
      00000000000000000000000000000000000000000000000000007B89F900142E
      F500142EF500142EF500142EF500142EF500142EF500142EF500142EF5008E97
      E200FBFBFB000000000000000000000000000000000000000000000000000000
      000000000000CABBBB00F8F7F700FEFFFF00FBFCFC00FAF7F700CAB9B9000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C2AFAF00ECE7E700FDFDFD00FFFFFF00F1EBEB00BBA7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFEFE00F4F4F400E7E6E600D2D2D200FCFCFC00000000000000
      000000000000000000000000000000000000000000000000000000000000F0F1
      FE003148F600142EF500142EF500142EF500142EF5004E62F700F1F1F1000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D2C4C400D1C3C300D2C4C400C4B7B700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C3AFAF00A495950000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031AD52000063080000630800086B080000630800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002194
      BD00087BAD000000000000000000000000000000000000000000000000000884
      B5001084B5000000000000000000000000000000000000000000000000000000
      00000063080000941000108C310000941000108C310000941000086B18000063
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5A5A0052525200A5A5A50000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      80000000800000008000000000000000000000000000000000001884AD0073D6
      EF004AC6E700087BAD0000000000000000000000000000000000219CC6009CE7
      F70018A5CE001884AD0000000000000000000000000000000000000000000063
      080000941000108C310000B51000108C310021A54200108C310008BD1800108C
      3100009410000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4A004A4A4A008C8C8C007B7B7B0000000000000000000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000080000000
      FF000000800000000000000000000000000000000000000000000000000042AD
      CE007BF7FF0052C6E700087BAD00000000000000000031A5CE00B5F7FF005ADE
      FF0042ADCE0000000000000000000000000000000000000000000063080031C6
      4200086B180000941000108C3100009410000094100000941000108C310000B5
      1000086B18000094100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000393939009494
      9400CECECE009C9C9C00B5B5B5000000000000000000808080000000FF000000
      00000000000000000000000000000000000000000000000080000000FF000000
      0000000000000000000000000000000000000000000000000000000000001884
      AD0063DEF7006BEFFF0063D6EF001084B50039ADCE00C6F7FF006BEFFF0063DE
      F7000073A5000000000000000000000000000000000031AD520031C6420021A5
      4A0031C642000094100052CE7B00FFFFFF00FFFFFF0021C6630000941000108C
      310000B51000108C31007BD69C00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929005A5A5A00C6C6
      C600C6C6C600A5A5A500000000000000000000000000808080000000FF000000
      800000000000000000000000000000000000000080000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001884AD0052E7FF0073E7FF0073DEF700B5F7FF009CF7FF005AE7FF001884
      AD0000000000000000000000000000000000000000000094100031CE6B0031C6
      4200086B180052CE7B00DEF7EF00FFFFFF006BD6940000B51000108C31000094
      1000108C310000941000009410007BD69C000000000000000000000000000000
      00000000000000000000000000000000000000000000393939008C8C8C009494
      9400ADADAD0000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000080000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001884AD004ADEFF0073E7FF008CEFFF009CF7FF001884AD000000
      000000000000000000000000000000000000108C1800108C310031CE6B00108C
      310052CE7B00DEF7EF00FFFFFF006BD69400009410000094100000941000108C
      310000941000108C310000941000006308000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B004A4A4A006B6B6B00A5A5
      A500000000000000000000000000000000000000000000000000808080000000
      FF000000FF0000000000000080000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000087B
      AD001884AD0021D6FF0029D6FF004ADEFF0073E7FF0094F7FF007BDEEF001884
      AD001884AD00000000000000000000000000086B180031C6420031CE6B0031CE
      6B00FFFFFF00FFFFFF00FFFFFF00C6EFD6009CE7BD00C6EFD600C6EFD600C6EF
      D600C6EFD60031C64200108C3100006308000000000094949400524A39009C94
      8400B5ADA500A5948400846B5A001818180052524A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000073A5002994BD0073D6
      EF0063E7FF0031DEFF0018D6FF0031DEFF005ADEFF0073E7FF009CF7FF008CEF
      FF0042BDDE0042BDDE000073A50000000000108C180031CE6B0031CE6B00DEF7
      EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF006BD6940000B5100000630800000000004A42390094846B00FFFF
      EF00FFF7E700FFF7DE00FFE7D6004A4239006B6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      80000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000218CB50084CEDE00DEFFFF00CEFF
      FF0094F7FF006BEFFF0031DEFF0018D6FF0031DEFF005AE7FF007BF7FF00A5FF
      FF00A5FFFF0063DEF70084CEDE000073A50021A542005AD684006BD6940031C6
      42009CE7BD00FFFFFF00FFFFFF00ADEFCE006BD6940052CE7B006BD6940052CE
      7B0063CE840031C64200108C31000094100094949C00EFDECE00FFEFE700EFBD
      8C00EFBD9C00EFC69400DEBD9400FFEFD6007B6B5A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      80000000FF000000FF000000FF00000080000000000000000000000000000000
      0000000000000000000000000000000000000073A5000073A5000073A5000073
      A5000073A5000073A50073D6EF0029D6FF0018D6FF0029BDE7000073A5000073
      A5000073A5000073A5000073A5000073A5000000000021C66300A5E7AD0031CE
      6B0031CE6B009CE7BD00FFFFFF00DEF7EF0052CE7B00108C310031C64200108C
      310021A54200108C31000094100000000000A59C8C00FFE7CE00FFE7D600EFBD
      8C00EFBD9400EFBD8C00E7C69C00FFFFDE009C8C730000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      FF000000FF00808080000000FF000000FF000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073A50063E7FF0029D6FF00088CBD00000000000000
      000000000000000000000000000000000000000000007BD69C00ADEFCE00A5E7
      AD0021A54A0031CE6B009CE7BD00FFFFFF00FFFFFF0031CE6B0021A54A0031C6
      4200108C310010C6310031AD520000000000A59C8C00FFDEBD00FFDEC600F7D6
      BD00F7D6B500F7D6BD00FFDEC600FFEFCE00B5A5940000000000000000000000
      00000000000000000000000000000000000000008000000080000000FF000000
      FF000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073A5008CEFFF004ADEFF001084B500000000000000
      000000000000000000000000000000000000000000000000000052CE7B00DEF7
      EF00A5E7AD0031CE6B0031C642006BD69400ADEFCE0021C6630031C6420021A5
      4A0031C64200108C31000000000000000000A59C8C00F7D6B500FFD6B500FFEF
      D600FFF7DE00FFE7CE00F7D6BD00FFF7C600A5947B0000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00808080000000
      000000000000000000000000000000000000808080000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073A500ADF7FF005ACEEF00087BAD00000000000000
      00000000000000000000000000000000000000000000000000000000000073DE
      9C00FFFFFF00A5E7AD006BD6940052CE7B0031CE6B0031CE6B0042CE7B0031CE
      6B00108C310000000000000000000000000000000000B5AD9C00F7CEA500F7FF
      FF00F7FFFF00FFF7EF00FFDEC600ADA58C009C9C9C0000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      80000000FF000000FF0000008000000000000000000000000000000000000000
      000000000000000000000073A500BDF7FF005AB5D6000073A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031C64200ADEFCE00C6EFD600C6EFD600C6EFD6009CE7BD005AD6840000B5
      100000000000000000000000000000000000000000009CA5A500BDB59400FFEF
      D600FFFFE700FFE7BD00EFD6A5009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073A500CEEFF70063B5D6000073A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007BD69C0031CE6B0031CE6B0031AD520031C64200000000000000
      000000000000000000000000000000000000000000000000000000000000B5B5
      A500B5B5A500B5B5A500B5B5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000298CBD001884AD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006868640017181200020000000300010005010600706C70000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000986050009860500098605000986050000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F4850008F48
      50008F4850008F4850008F4850008F4850008F4850008F4850008F4850008F48
      50008F4850008F4850008F485000000000000000000000000000000000000000
      0000000000000000000031C6420031AD520031CE6B0031CE6B007BD69C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000171A1800222222002D2C32001E1D2100000000000000
      0000000000000000000000000000000000000000000000000000000000009860
      5000D48F6000EAB67B00E0B68F00D4A173009860500098605000986050009860
      50000000000000000000000000000000000000000000000000008F485000FFEA
      B600B6C07B00CAC07B00EAC08400E0C07B00EAB66A00EAAB6A00EAAB6000EAAB
      6A00EAAB6A00EAB66A008F485000000000000000000000000000000000000000
      000000B510005AD684009CE7BD00C6EFD600C6EFD600C6EFD600ADEFCE0031C6
      4200000000000000000000000000000000000000000000000000000000001313
      150046434B00A3A3AC00D6D9E600F0EFFF00E8E7FE00D5D3E9009A9DA7004044
      450014141400000000000000000000000000000000000000000098605000D4A1
      7300EAA16000EAB68400EACAA100EAC08F00B684580060313100733838009860
      50009860500098605000000000000000000000000000000000008F485000FFEA
      C00084AB58001684110050983100117B0600117B0600408F2300C0A15800EAAB
      6000EAAB6000EAB66A008F48500000000000000000000000000000000000108C
      310031CE6B0042CE7B0031CE6B0031CE6B0052CE7B006BD69400A5E7AD00FFFF
      FF0073DE9C000000000000000000000000000000000000000000131316000000
      0300E8E3EA00B4B2C5005C5981003F386800494273005D598300AEAFC900DADF
      EB00000000001213120000000000000000000000000098605000E0AB7B00EAB6
      7300EAA16000EAB68F00F4E0C000F4CA9800B6846A006031310060313100C08F
      6000EAAB7300CA8F6A00986050000000000000000000000000008F484000FFEA
      D400ABC0840006730300006A0000006A0000006A0000006A0000167B0B00D4AB
      6000EAAB6000EAB66A008F485000000000000000000000000000108C310031C6
      420021A54A0031C6420021C66300ADEFCE006BD6940031C6420031CE6B00A5E7
      AD00DEF7EF0052CE7B00000000000000000000000000000000004E4E4900DEE1
      EA000C1353003B42AE004048C1003B43C200363AC8003833BF002E2797000A06
      5100E1E0EB004B494D00000000000000000098605000F4C08400F4CA7B00EAB6
      7300EAA16000F4C09800FFEAD400FFE0B600C08F73006031310060313100C08F
      6000EAAB7300D4A16A00986050000000000000000000000000008F484000FFF4
      E000ABC084000B7B0600006A00000B7B060098AB580058983100006A00005898
      3100EAAB6A00EAB66A008F485000000000000000000031AD520010C63100108C
      310031C6420021A54A0031CE6B00FFFFFF00FFFFFF009CE7BD0031CE6B0021A5
      4A00A5E7AD00ADEFCE007BD69C00000000005B58590000000000A1A4A300AFB2
      C8004C57A300535FCE004956D0003E4CCE00373FD3003B3AD4003A34B9002C28
      8E00B1AAC9009D99A600050300005F5A5C0098605000F4CA8400F4CA7B00F4B6
      7300F4A15800F4C09800FFF4EA00FFEAD400C0988400582A2A0060313100C08F
      6000EAAB7300D4A16A00986050000000000000000000000000008F585000FFF4
      EA00ABCA8F0003730300006A0000006A00006AA14000EAC08F008FA150005098
      3100EAB67300EAB66A008F485000000000000000000000941000108C310021A5
      4200108C310031C64200108C310052CE7B00DEF7EF00FFFFFF009CE7BD0031CE
      6B0031CE6B00A5E7AD0021C6630000000000151515001C1E1B00CED2DA00545B
      7C006776CD005768D8005367E100475CDF003C48E3003B3FE5003C3AD4003836
      B8005E558700DCD8EB001B1B19000F0D050098605000F4CA8400FFCA7B00E0AB
      7B00A18F7B00F4C09800FFFFF400FFF4EA00D4B6A1007B4840006A383100C08F
      6A00EAAB7300D4A16A00986050000000000000000000000000008F585000FFFF
      FF00E0E0CA008FC07B0084B66A007BAB580084AB5800EACA9800EAC08F0084B6
      6000EAB67B00EAB673008F4850000000000000941000108C310031C6420063CE
      840052CE7B006BD6940052CE7B006BD69400ADEFCE00FFFFFF00FFFFFF009CE7
      BD0031C642006BD694005AD6840021A542000202020022232500EAEDFB00424C
      6F00798CE100677FE500607AE9005971EE004759F0003D45EC003B3BDE003939
      C70052478200F4F4FF00202322001011050098605000FFCA7B00CAC08F00388F
      E000116AF4006A98D400FFFFEA00FFF4EA00FFF4E000F4E0C000E0B68F00E0B6
      8400E0AB7B00D4A16A0098605000000000000000000000000000AB6A5000FFFF
      FF008FD48F00FFEAE000F4EACA0084B66A007BAB58007BAB580084AB5800EAC0
      8F00EAC08400F4C07B008F485000000000000063080000B510006BD69400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DEF7EF0031CE6B0031CE6B00108C18000000000022242500EEF2FC00535C
      78008FA5E600869FF000829CF3007290F3005A6FEF004A55EB004246DA003E3F
      C5003F3E7000E9EDFE0024292400000000009860500084B6B6002AA1FF001C98
      FF001C84FF000B6AFF006AABF400FFFFEA00FFF4EA00FFEAD400F4E0C000EACA
      A100EAB68400D4A173008F606000000000000000000000000000AB6A5000FFFF
      FF0058B6580098CA8F00FFEAE0006AB65800006A0000006A000003730300EACA
      9800EAC08F00F4CA8F008F4850000000000000630800108C310031C64200C6EF
      D600C6EFD600C6EFD600C6EFD6009CE7BD00C6EFD600FFFFFF00FFFFFF00FFFF
      FF0031CE6B0031CE6B0031C64200086B180013171C00191A1C00CFD2D900686E
      8000B3C5F500A9C1FC009EBAFC0081A0ED00647CE5005866E5004E53D6004547
      BE0053587B00C9D0DF00161A1A00151213002A84F4002A8FFF002A98FF002AA1
      FF00238FFF00167BFF000B6AFF0073B6F400FFFFEA00FFF4EA00FFEAD400FFE0
      B600D4B6A1007B737B0084606A00000000000000000000000000CA7B5000FFFF
      FF006AC06A00006A000060B6580098CA8F000B7B0B00006A000006730300F4CA
      A100F4CA9800EAC08F008F485000000000000063080000941000108C31000094
      1000108C31000094100000941000009410006BD69400FFFFFF00DEF7EF0052CE
      7B00108C310031CE6B00108C3100108C18006C6F7300000000009FA1A500A7AB
      B200BAC9E200CEE5FF00ABC3FC0087A4EA00677EDF005A68DB005B63D4003E41
      A700B0B2C3009DA2AD000000000072717600000000002A84FF002A8FFF002A98
      FF002AA1FF00238FFF00167BFF000B6AFF0073B6F400FFFFEA00FFFFEA00CACA
      CA005860980060587B0000000000000000000000000000000000CA7B5000FFFF
      FF00F4F4EA00168F1600006A0000006A0000006A0000006A000006730300FFEA
      C000D4C0A100A1987B008F485000000000007BD69C000094100000941000108C
      310000941000108C310000B510006BD69400FFFFFF00DEF7EF0052CE7B00086B
      180031C6420031CE6B0000941000000000000000000000000000373B3E00DFE6
      EA0049505800B6C6E100B2C4F5008FA3EA007385DC006473CE004C57A5000D13
      5400E9E4E80044404700000000000000000000000000000000002A84F4002A8F
      FF002A98FF002A98FF00238FFF00167BFF000B6AFF007BB6FF00A1C0E0003150
      AB0038508F000000000000000000000000000000000000000000D4845800FFFF
      FF00FFFFFF00D4F4D40048AB4800118411001184110058AB5000168411007B50
      38008F5040008F5040008F48500000000000000000007BD69C00108C310000B5
      1000108C31000094100021C66300FFFFFF00FFFFFF0052CE7B000094100031C6
      420021A54A0031C6420031AD52000000000000000000000000000A0B0D000104
      0900DFE5EB00A8ACAF00606971004753660045516B0057627900A5ADBA00DDE4
      E500000002001211140000000000000000000000000000000000000000002A8F
      FF002A98FF002AA1FF002A98FF001C84FF00167BFF000B6AFF001C50E0001C48
      B600000000000000000000000000000000000000000000000000D4845800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D4F4D400D4F4D400FFFFF40098A17B007350
      3800E0843800E0731C00A150310000000000000000000000000000941000086B
      180000B51000108C3100009410000094100000941000108C310000941000086B
      180031C642000063080000000000000000000000000000000000000000001011
      13003F434700A3A6AB00D8DCE200F0F3F800E8ECF900CFD2DB00AAADAE005253
      4D0019191B000000000000000000000000000000000000000000000000000000
      00002A8FFF002A98FF002AA1FF002398FF00237BF4000B1CA1002338D4000000
      0000000000000000000000000000000000000000000000000000E0986000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D4B6B6008F50
      4000FFA14000AB60400000000000000000000000000000000000000000000094
      1000108C310008BD1800108C310021A54200108C310000B51000108C31000094
      1000006308000000000000000000000000000000000000000000000000000000
      000000000000000000001A18230025242C0022222A0018171A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002A8FFF002A98FF0000000000000000000B067B002331D4000000
      0000000000000000000000000000000000000000000000000000E0986000F4F4
      EA00F4F4EA00F4F4EA00F4F4EA00F4F4EA00F4F4EA00F4F4EA00D4B6B6008F50
      4000AB6A50000000000000000000000000000000000000000000000000000000
      000000630800086B180000941000108C310000941000108C3100009410000063
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000006B6F72001E222600000000000000000021212100656363000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B0B84002331D4000000
      0000000000000000000000000000000000000000000000000000E0986000CA7B
      5000CA7B5000CA7B5000CA7B5000CA7B5000CA7B5000CA7B5000CA7B50008F50
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000630800086B0800006308000063080031AD52000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FC7FFFFFFFFFC003F00FF00FC0038001
      E007C007C0038001C003C003C003800180038001C003800180010701C0038001
      00010F01C003800100011E01C003800100011C01C003FC8300011861E3C7FFC7
      000100C1F3C7E3C7800301C1F3C7E3C7C0038383F18FE187E00F8003F00FF00F
      F21FC007F81FF81FF83FE01FFC3FFE7FF83FFFFFFFFFE7E7F00FFFF19FE3C3C3
      E007FFE19FC7E187C003FFC18F8FE0078001FF838F1FF00F8000FF87C63FF81F
      0000FF0FC07FE0070000807FE0FF80010000807FE1FF00000000007FE0FF0000
      8001007FC07FFC3F8001007F0E1FFC3FC003007F1F07FC3FE007807F7FC1FC3F
      F00F80FFFFFFFC3FF83FE1FFFFFFFE7FF81FF0FFC001FC1FF00FE00FC001F00F
      E007C003C001E007C0038001C001C00380010001C001800100000001C0018001
      00000001C001000000000001C001000000000001C001000000000001C0010000
      00008003C00100018001C007C0018001C003E00FC001C003E007F01FC003E007
      F00FF99FC007F00FF81FFF9FC00FFC1F00000000000000000000000000000000
      000000000000}
  end
  object ExportFavorite1: TExportFavorite
    About = 
      'TExportFavorites by bsalsa. Help & Support: http://www.bsalsa.co' +
      'm/'
    FavoritesPath = 'Auto'
    SuccessMessage.Strings = (
      'Your favorites have been exported to successfully!')
    TargetFileName = 'newbook.htm'
    TargetPath = 'C:\'
    Left = 16
    Top = 240
  end
  object ImportFavorite1: TImportFavorite
    About = 
      'TImportFavorites by bsalsa. Help & Support: http://www.bsalsa.co' +
      'm/'
    CurrentFileName = 'newbook.htm'
    CurrentFilePath = 'C:\'
    FavoritesPath = 'Auto'
    SuccessMessage.Strings = (
      'Your favorites have been ')
    TargetSubFolder = 'Imported Bookmarks'
    Left = 48
    Top = 240
  end
  object ilFavoritesTree: TImageList
    Left = 16
    Top = 208
    Bitmap = {
      494C010109000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4F2F000AE8D6F00966E4B009A85
      7200C7B7AA00F4F1EE00F6F3F100F9F7F500FAF8F600FCFBFA00FEFDFD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6902E00B9843F00FBF6F100EDD7
      BF00D8A77500A5866900A48E7B00A7948200AA998600C2B6AA00DFDAD300F5F3
      F000FEFEFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9AB2400927A650000000000DBD3
      CD00A27A5500C6823800DF984100E9AB4D00E7B45F00C69E5C00654D34009788
      7200E6E1DB00FCFCFB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9AC260071584300BEAEA100E296
      3500F4A33D00F39E3A00F19B3900F3A33900F6B44700FBD16B00FCE69C00BE9D
      670074625000E3DFDA00FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EBA533008A5E2B00E9A13300F2A6
      3800EC9A3200E8932F00EA933100EA913100EB963100F1A63800F9C65800FEF0
      9F00CFB0770092806B00F3F0ED00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DAB78700FCB93900F2AA3400EB9E
      2F00E5962B00E6922C00B38F6C00EFEBE700D3B09100E88F3000F0A13500F8BE
      4F00FEF3AA0082654400E2DDD600FEFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9BD3E00F0AC3300E69D
      2900E3942600925D2300F1EEEC000000000000000000C28E5E00C2854D00C890
      5000D2A86B00CDAE8200E5DFD800FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEB66800F4B83700E8A6
      2A00E29925009A601B008F5A2200925D2500925D2500915B2500925A2700965D
      29009A632D00976F3F00B9A79800FCFAF9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EEE7DB0000000000F6C74B00F1B5
      3300EAA72A00E69E2800E69B2A00E89B2C00E89A2E00E8972D00E9962F00EF99
      3500F5A03C00FCC26000BEB0A700FCFBFA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAF8F500E6D19F00E9DEC500F7D3
      5000F1B835009B692200BF996B00C6A17600C49F7600CD883000E6952C00E997
      2F00F09E3800DFA04700D6CEC700FEFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEE68E00E8DAAE00DFC8
      8300F7D65000AB782700E6E2DE0000000000D4CDC400DE952800E6982A00E899
      2D00F3A339009D6E3D00E9E4E000FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2D2AD00FFFDA400F2E0
      A600E4D29800F4D14B00B680250097672200D7942300E69E2800E59B2800EB9F
      3000F7B03F00C1B4AA00F3F0ED00FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFDC9E00FFFE
      AE00F4DA8A00F2E6BC00F7DD5700F4C23A00EDB02C00EBA92A00ECA82C00F3B0
      3700B2937200EBE3DA00CFC0B000F7F5F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E8D6
      A500FFFEB000FEF09200FEF77500FBE85F00F7C83F00F5C13A00EEB53D00CAB7
      9F000000000000000000CBB29200F2EDE7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFDFC00EDE0C100E9D5A300E7CF8D00DFC38200EAC969009D8B6F00CEC4
      B30000000000E8E1DA00B79A7100F3F0EB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE00FAF8F600D4AF6D00E0BB
      6700C09F6000DCA84100DAD2C600FBFAF9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006099
      6000307A30000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7E7E700D1D1D100E0E0E000F4F4
      F400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECEC00CFCFCF00D6D6D600E9E9
      E900FCFCFC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD00F1F1
      F100FCFCFC0000000000000000000000000000000000000000006099600000B0
      000000B60000307A300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000081BF000B76A9002B6683006464
      64007D7D7D00A7A7A700CDCDCD00E1E1E100F8F8F80000000000000000000000
      0000000000000000000000000000000000000C80BB000B7FBA001D6E97004562
      7100707070008F8F8F00B9B9B900D8D8D800ECECEC00FDFDFD00000000000000
      00000000000000000000000000000000000000000000000000007CB3F0006198
      D200CACACA00EEEEEE00FEFEFE0000000000000000005E9D5E0000C7000000CE
      000000CE000000CE000030823000000000000000000000000000CCE2F900006E
      E500BAD6F70000000000000000000000000000000000000000002061D1000044
      C60000000000000000000000000000000000ADDEEF0055CCFE0055CCFE0038B7
      ED000E93CF000184C1000A77AC0031657E006969690083838300AFAFAF00D4D4
      D400F7F7F7000000000000000000000000001E91C60057C7F60057C7F60057C7
      F60034A7DD00168AC4000B7FBA00236A8D004D636E007373730099999900C6C6
      C600E5E5E5000000000000000000000000000000000000000000DEECFB00007B
      FC000068E10089A2C100D3D3D300F2F2F200579F570000DE000000E6000000E6
      000000E6000000E6000000E6000060A860000000000000000000000000000089
      F8000083FF000065DF0000000000000000006398E400005FDE00008FFF000048
      C80000000000000000000000000000000000ADDEEF0055CCFE0055CCFE0055CC
      FE0055CCFE0055CCFE0055CCFE0055CCFE0035B5EA000C91CC000081BF00166E
      9900D3D3D30000000000000000000000000046BAE100C4EBFA0057C7F60057C7
      F60057C7F60057C7F60057C7F60057C7F60056C6F4002CA0D7001083BE000E7A
      B00074747400F6F6F60000000000000000000000000000000000000000000083
      F100009DFF000083F9000062DB005C8BC900007260000088400003FB030000F4
      000001FB010004FD040040A0400070B87000000000000000000000000000007C
      ED0000B0FF000099FF00007DF1000062DE00009FFF0000B0FF00009AFF0098B6
      EA0000000000000000000000000000000000ADDEEF0055CCFE0055CCFE0055CC
      FE0055CCFE0055CCFE0055CCFE0055CCFE0055CCFE0055CCFE0055CCFE000081
      BF00CFCFCF0000000000000000000000000045B7DE0091CBE3005BCCF6005BCC
      F6005BCCF6005BCCF6005BCCF6005BCCF6005BCCF6005BCCF6005BCCF60041B4
      E5002A658200D1D1D10000000000000000000000000000000000000000000076
      EB0000B6FF0001B5FF00059EFF0003A6FF0000B6FF0000B6FF0059FF59003CFF
      3C003CFF3C0059FF590000000000000000000000000000000000000000000078
      EC0005BEFF0005BEFF0007B3FF0005BEFF0005BEFF0005BEFF000390F8000000
      000000000000000000000000000000000000ADDEEF005BD4FE005BD4FE005BD4
      FE005BD4FE005BD4FE005BD4FE005BD4FE005BD4FE005BD4FE005BD4FE000081
      BF00CFCFCF0000000000000000000000000048BAE200249CCE006CD7F60064D5
      F60064D5F60064D5F60064D5F60064D5F60064D5F60064D5F60064D5F60049BC
      E5000E80BA008E8E8E00FEFEFE00000000000000000000000000000000002D90
      ED000AC6FF000AC6FF000AC6FF000AC6FF000AC6FF000AC6FF00D3FFD300E9FF
      E900E9FFE900D3FFD300000000000000000000000000000000000000000071B5
      F50011CDFF0011CDFF0011CDFF0011CDFF0011CDFF0011CDFF000073E4000000
      000000000000000000000000000000000000ADDEEF0063DCFE0063DCFE0063DC
      FE0063DCFE0063DCFE0063DCFE0063DCFE0063DCFE0063DCFE0063DCFE000081
      BF00CFCFCF000000000000000000000000004CBCE90045B5E300E0F6FB006CDD
      F7006CDDF7006CDDF7006CDDF7006CDDF7006CDDF7006CDDF7006CDDF70050C4
      E6005BCBED004E5D6400E7E7E700000000000000000000000000F7F7F700278D
      EA0017D4FF0017D4FF0017D4FF0017D4FF0017D4FF0017D4FF0006B3480006B3
      480006B3480006B3480000000000000000000000000000000000000000000085
      F2001DDBFF001DDBFF001DDBFF001DDBFF001DDBFF001FD9FF001CB3FC001061
      D60000000000000000000000000000000000ADDEEF006AE5FF006AE5FF006AE5
      FF006AE5FF006AE5FF006AE5FF006AE5FF006AE5FF006AE5FF006AE5FF000081
      BF00CFCFCF0000000000000000000000000051BFEE0048B5E90062B4D70075E6
      F80075E6F80075E6F80075E6F80075E6F80075E6F80075E6F80075E6F80058CC
      E70074E1F6001177AA00B3B3B3000000000000000000F4F4F4000C8BF40032E1
      FF0024E4FF0024E4FF0024E4FF0024E4FF0024E4FF0024E4FF0030D0FF00006D
      DE0095A5BC00DDDDDD00FDFDFD000000000000000000C8E7FE000EA6FC002BEC
      FF002BECFF002BECFF002BECFF002BECFF002BECFF002BECFF002DE7FF002ECD
      FF000055D200000000000000000000000000ADDEEF007BEEFF0072EDFF0072ED
      FF0072EDFF0072EDFF0072EDFF0072EDFF0072EDFF0072EDFF0072EDFF000081
      BF00CFCFCF000000000000000000000000006AC7F3004DB8EF0043B1E900379D
      CA0072BBDA00B4DCEB00EBFAFC008BEDFA008BEDFA008BEDFA008BEDFA006ED3
      E90096EDF7003EACD40072727200F8F8F800EFEFEF000090FD0055F8FF0032F2
      FF0032F2FF0032F2FF0032F2FF0032F2FF0032F2FF0032F2FF0032F2FF0035E6
      FF000584E500668AC200D6D6D600FCFCFC0070C5FF003DC3FF0039FBFF0039FB
      FF0039FBFF0039FBFF0039FBFF0039FBFF0039FBFF0039FBFF0039FBFF0039FB
      FF003DE4FF000054D20000000000000000009AD5EA00ACFCFF0091FAFF0084F7
      FF007BF4FF007AF4FF007AF4FF007AF4FF007AF4FF007AF4FF007AF4FF000081
      BF00CFCFCF000000000000000000000000007DD3F40058C5F20058C5F20058C5
      F20058C5F20058C5F20047B7E700A1D3E700C1F3FA00B6F0FA00B6F0FA0097D7
      E900CCF4F800CBF3F8002E607A00D9D9D900009AFF0098F0FF00CAFFFF00A5FF
      FF0081FFFF0058FFFF0041FFFF0041FFFF0041FFFF0078FFFF0081FFFF00A5FF
      FF00A5FFFF001E88E5004C7ECC00F5F5F500009CFF000096FF000090FD0015A8
      FD004BC4FD00BFF6FF0043FFFF0043FFFF0053FFFF004BB6F3002295EB00097D
      E200005BD8000057D400407DDC00000000006ACBEA002AACDC000D91C90066BD
      DE00B8FAFF00A6F7FF009DF6FF009DF6FF009DF6FF009DF6FF009DF6FF000081
      BF00CFCFCF0000000000000000000000000087DCF60065D1F30065D1F30065D1
      F30065D1F30065D1F30065D1F30065D1F3001389C100A1D3E700B4DCEB00FCFC
      FC00F6FBFC00F0FBFB000B7FBA00DDDDDD0000000000DEF1FE00BCE1FC007BC2
      F9003DA3F70015A1F80043FFFF0043FFFF0094FFFF000C72E1004A91E4007AAB
      E800BAD1F000FDFDFD0000000000000000000000000000000000000000000000
      0000000000000084F6004BFFFF0043FFFF00BFF5FF00B9D7F800000000000000
      00000000000000000000000000000000000091E6F70070E0F60070E0F6006EE0
      F600C1E6F300E3FEFF00D7FBFF00C9F8FF00BFF6FF00BDF6FF00BDF6FF000081
      BF00CFCFCF0000000000000000000000000091E6F70070E0F60070E0F60070E0
      F60070E0F60070E0F60070E0F60070E0F60070E0F60070E0F60070E0F6000B7F
      BA00CFCFCF000000000000000000000000000000000000000000000000000000
      0000000000001F93F70083FFFF0043FFFF004BBCF800DADADA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B6DCFC00C9FDFF004BFFFF000081ED0000000000000000000000
      000000000000000000000000000000000000D3F7FB007EEDF7007EEDF7007EED
      F70079EAF600D0EEF700FEFFFF00F7FEFF00F4FEFF00E2FBFF00DEFBFF000081
      BF00D7D7D700000000000000000000000000D3F7FB007EEDF7007EEDF7007EED
      F7007EEDF70093EFF8009AF0F8007EEDF7007EEDF7007EEDF7007EEDF7000B7F
      BA00D7D7D7000000000000000000000000000000000000000000000000000000
      000000000000EFF8FF004BC3FD0072FFFF000C7EEA00F4F4F400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000008EF800D1FFFF0060ADF60000000000000000000000
      000000000000000000000000000000000000228DBF0080EFF70080EFF70080EF
      F70080EFF700397A9B009FC8DD005CA9CE0052A4CC003597C6001E8CC20098C0
      D300FBFBFB00000000000000000000000000228DBF0080EFF70080EFF70080EF
      F70080EFF700397A9B00B3D0DF007DB8D50078B2D00078B2D0005DA6CA009FC3
      D600FBFBFB000000000000000000000000000000000000000000000000000000
      000000000000000000000089F80067D3FE00B8C8D600FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000060B6FB0015A2F9000000000000000000000000000000
      000000000000000000000000000000000000000000007EB9D6004097C3003F96
      C2002B95C600EAEAEA0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007EB9D6004097C3003F96
      C2002B95C600EAEAEA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEF0FD000087F700F0F0F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000309FF9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2E2E200CFCFCF00CFCF
      CF00CFCFCF00CFCFCF00CFCFCF00CFCFCF00CFCFCF00CFCFCF00CFCFCF00CFCF
      CF00E3E3E300EEEEEE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AAA7
      A7006359590079737300C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002E9DF800FBFBFB0000000000000000000000
      000000000000000000000000000000000000F9F9F900A87655009F6742009F67
      42009F6742009F6742009F6742009F6742009F6742009F6742009F6742009F67
      4200C19D8500E3E3E30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B9B5B500D19D
      9D00D19E9E009D727200D0CECE00000000000000000000000000000000000000
      000000000000E8E8E800DDDDDD00DDDDDD00DDDDDD00DDDDDD00F4F4F400F5F5
      F500000000000000000000000000000000000000000000000000000000000000
      000000000000000000005EB4F90015A2F900E1E1E10000000000000000000000
      000000000000000000000000000000000000EBEBEB00BF784C00FEE9DC00FEDB
      C600FEDBC600FDDAC300FECDAF00FECDAF00FECCAE00FECBAC00FECBAC00FECA
      A9009F674200CFCFCF000000000000000000000000000000000000000000006F
      E5001073E4000000000000000000000000000000000000000000AC868600D19E
      9F00817A7A00F2F2F200DADADA00AFAFAF000000000000000000000000000000
      0000F3F3F3000096000000960000009600000096000000960000DDDDDD00F5F5
      F500000000000000000000000000000000000000000000000000000000000000
      00000000000000000000008EF800B7FFFF004A97E000FBFBFB00000000000000
      000000000000000000000000000000000000EBEBEB00BF784C00FEEBDE009F53
      34009F533400FEE1CF009F5130009F5130009F4F2D009F4E2D009F4E2D00FECB
      AC009F674200CFCFCF0000000000000000000000000000000000000000002084
      EA00008FFF000070E9005396E80000000000FBFCFE001D68D7009D7D8600D9A7
      A70062575700888383008E666600939191000000000000000000000000000000
      0000F3F3F3000096000000BA3D0000B33B0000AC380000960000DDDDDD00F5F5
      F500000000000000000000000000000000000000000000000000000000000000
      0000000000009ED1FB00B0FDFF004BFFFF000081ED00E8E8E800000000000000
      000000000000000000000000000000000000EBEBEB00BF784C00FEECE000FEEB
      DE00FEE9DC00FEE9DC00FEE8DA00FDDAC300FDDAC300FDD9C100FECCAE00FECC
      AE009F674200CFCFCF00000000000000000000000000000000000000000097C7
      F70000B0FF0000AAFF000096FF000065DF00007AEE00228ABC00B0818100C996
      9600CF9C9C00C6939300A1757500DCDCDC000000000000000000F4F4F400F4F4
      F400F3F3F3000096000000C1400000BA3D0000B33B0000960000DDDDDD00F5F5
      F500F5F5F500F5F5F500F5F5F500000000000000000000000000000000000000
      0000000000000084F6004BFFFF0043FFFF00A8F2FF007FA9D500FDFDFD000000
      000000000000000000000000000000000000EBEBEB00BF784C00FEECE0009F53
      35009F533500FEE9DC009F5334009F5334009F5132009F5130009F503000FECC
      AE009F674200CFCFCF0000000000000000000000000000000000000000000000
      000000A7FD0005BEFF000DCEF4002B52640038677B00AF7F8000B27F8000B27F
      8100A47C7C00A8888800D5D3D3000000000000000000EAEAEA00E8E8E800E8E8
      E800E8E8E8000096000000C1400000C1400000BA3D0000960000D3D3D300DDDD
      DD00DDDDDD00DDDDDD00F4F4F400F5F5F500009CFF000096FF000090FD0015A8
      FD004BC4FD00A8F3FF0043FFFF0043FFFF0053FFFF004BB6F3002295EB00097D
      E200005BD8000057D4003B78D600FCFCFC00EBEBEB00BF784C00FEEEE300FEEC
      E000FEECE000FEEBDE00FEE9DC00FEE9DC00FEE8DA00F2C3AB00FDDAC300FDD9
      C1009F674200CFCFCF0000000000000000000000000000000000000000000000
      00000287E50094818400F8F6F600FCEBEB00DEB7B700B3808000B48383006875
      970000000000000000000000000000000000F3F3F30000AC190000AC190000AC
      190000A20E0000A20E0000C9420000C1400000BA3D0000960000009600000096
      00000096000000960000DDDDDD00F5F5F50060B5EF003DC3FF0039FBFF0039FB
      FF0039FBFF0039FBFF0039FBFF0039FBFF0039FBFF0039FBFF0039FBFF0039FB
      FF003DE4FF000054D200BFBFBF00F6F6F600EBEBEB00BF784C00FEEFE500BC82
      6A00BC826A00FEECE000BC826800BC816700BA7A600006090B00C07C5E00FDDA
      C3009F674200CFCFCF000000000000000000000000000000000000000000309A
      F5002191B300FAFAFA00A29BA100BCA3A800F8D5D500D6A4A4005D839400006D
      DE00F5F8FD00000000000000000000000000F3F3F30000BD2B0005E14B0001DD
      490000D7470000D0450000D0450000C9420000C1400000BA3D0000BA3D0000B3
      3B0000AC380000960000DDDDDD00F5F5F500FDFDFD0097C3E6000EA6FC002BEC
      FF002BECFF002BECFF002BECFF002BECFF002BECFF002BECFF002DE7FF002ECD
      FF000055D200C2C2C200F0F0F00000000000EBEBEB00BF784C00FEF1E7000000
      000006090B00FEEEE300FEECE000F8DBCB000000000022A0DF0006090B00E9B3
      99005D331900CFCFCF00F9F9F900F1F1F10000000000000000001093FB0038E7
      FF00359EA900BAAEB10020E7FB0021D5EF00F4CFCF00C39394002DC6D50033D9
      FF000484E600D4E2F7000000000000000000F3F3F30000BD2B0005E14B0005E1
      4B0001DD490000D7470000D0450000D0450000C9420000C1400000BA3D0000BA
      3D0000B33B0000960000DDDDDD00F5F5F50000000000FDFDFD00B7D0E5000085
      F2001DDBFF001DDBFF001DDBFF001DDBFF001DDBFF001FD9FF001CB3FC000B5B
      D100C8C8C800F5F5F5000000000000000000EBEBEB00BF784C00FEF1E7003048
      570057B8EC0006090B00F8DECF000000000022A0DF000000000022A0DF000609
      0B0006090B002D2F3100CFCFEB0000009C00000000000095FF0075FFFF0039FB
      FF003BE7EB003EB8BB0025A5B3007A818C00F9D5D5007078790038F4F80039FB
      FF003BF6FF00149FEE0080A9E60000000000F3F3F30000BD2B000AE54D0005E1
      4B0001DD490001DD490000D7470000D0450000D0450000C9420000C1400000BA
      3D0000BA3D0000960000DDDDDD00F5F5F5000000000000000000FEFEFE0065AA
      EA0011CDFF0011CDFF0011CDFF0011CDFF0011CDFF0011CDFF0099E0A000BEEB
      C300BEEBC300A9E5AF000000000000000000EBEBEB00BF784C00FEF2EA00FEF1
      E7003048570057B8EC000B111500959497000000000022A0DF00000000002090
      CA00208FC800208FC800000033000303A90050BBFF000099FF000094FF0009A2
      FD0022AFFC004BC3FD005ACCCC009E7E7E0068AEAE00D4F1F3004BB5F3001589
      E7000D66DB001567D8001D68D70000000000F3F3F30000BD2B0000BD2B0000BD
      2B0000BD2B0000BD2B0001DD490000D7470000D0450000960000009600000096
      00000096000000960000E8E8E800000000000000000000000000000000000078
      EC0005BEFF0005BEFF0007B3FF0005BEFF0005BEFF0005BEFF0096FF960096FF
      960096FF960096FF96000000000000000000F7F7F700C5845C00BF784C00BF78
      4C00BF784C003048570057B8EC000B1115009A847800000000002096D1002096
      D1002096D1002096D1000061C4000808B6000000000000000000000000000000
      000000000000D6EBFD00BBF7FF0043FFFF0053FFFF000071E700000000000000
      00000000000000000000000000000000000000000000F3F3F300F3F3F300F3F3
      F300E8E8E80000BD2B0001DD490001DD490000D7470000A20E00DDDDDD00F3F3
      F300F3F3F300F3F3F3000000000000000000000000000000000000000000007C
      ED0000B0FF000099FF00007DF1000062DE00009FFF0000B0FF0023FF230001FE
      010001FE01002FFF2F00000000000000000000000000F7F7F700EBEBEB00EBEB
      EB00EBEBEB00EBEBEB003048570057B8EC000B11150030A6E10030A6E10030A6
      E10030A6E10030A6E1000061C4001E1EEB000000000000000000000000000000
      000000000000000000000085F70043FFFF00D6FDFF0097C7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F30000BD2B0005E14B0001DD490001DD490000AD1900DDDDDD00F3F3
      F300000000000000000000000000000000000000000000000000000000000089
      F8000083FF000065DF00A2AEBE00D3D3D300007A000000D3000000F1000000EE
      000000F2000000F2000000D30000008100000000000000000000000000000000
      00000000000000000000EBEBEB004B606D004380A10053ADDD0057B8EC0057B8
      EC0057B8EC0057B8EC00000033002525FF000000000000000000000000000000
      000000000000000000008AC9FB00DEFFFF00008EF30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F30000BD2B000AE54D0005E14B0001DD490000AD1900DDDDDD000000
      0000000000000000000000000000000000000000000000000000ADD0F500006E
      E5007197C600CECECE00F1F1F100FEFEFE00FBFBFB000080000000DA000000DA
      000000DA000000DA000000950000000000000000000000000000000000000000
      0000000000000000000000000000F4F4F400697A8500475C6A0010181D001018
      1D0010181D0010181D00CFCFEB002525FF000000000000000000000000000000
      00000000000000000000000000000096F90050AAF70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F30000CD3C0000BD2B0000BD2B0000BD2B0000AD1900F3F3F3000000
      0000000000000000000000000000000000000000000000000000F9F9F900D2D2
      D200EAEAEA00FDFDFD00000000000000000000000000000000000070000000C2
      000000C2000000830000EFF5EF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000040A9FB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000006A
      000000790000EFF5EF000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000001F0000000000000007000000000000
      2003000000000000000100000000000000010000000000000000000000000000
      8180000000000000800000000000000040000000000000000000000000000000
      81000000000000008000000000000000C000000000000000E00C000000000000
      F008000000000000FF00000000000000FFE7FFFF0FFF07FFC7C3FFFF007F003F
      C181C7CF00070007C000E30F00070003E000E00F00070003E003E01F00070001
      E003E01F00070001C003E00F0007000180018007000700000000000300070000
      00000001000700008003F83F00070007F83FF87F00070007F83FFC7F00070007
      FC3FFCFF83FF83FFFC7FFEFFFFFFFFFF8003FFE1FFFFFE7F0003FFC1F80FFC7F
      0003E7C0F00FFC3F0003E100F00FF83F0003E000C001F81F0003F00180000000
      0003F00F000000000003E007000000010000C00300008003000080010000C003
      000000010001E0030000F83F8003E0038000FC3FF00FE000FC00FC7FF01FC001
      FE00FE7FF01FC3C1FFFFFEFFF83FFFE300000000000000000000000000000000
      000000000000}
  end
  object FavoritesMenu1: TFavoritesMenu
    EmbeddedWB = EmbeddedWB1
    Localization.AddFavorites = 'Add to Favorites'
    Localization.OrganizeFavorites = 'Organize Favorites'
    Localization.ImportFavorites = 'Import Favorites'
    Localization.ExportFavorites = 'Export Favorites'
    Options = [AddFavorites, OrganizeFavorites]
    MainMenu = MainMenu1
    MenuPosition = 7
    MaxWidth = 50
    Caption = 'Favorites'
    ResolveUrl = IntShCut
    Channels = False
    Left = 144
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 240
    object AddCurrentSiteToTheLinksList1: TMenuItem
      Caption = 'Add Current Site To The Links List'
      OnClick = AddTheSiteToTheList1Click
    end
    object RemoveTheCurrentSiteFromTheLinksList1: TMenuItem
      Caption = 'Remove The Current Site From The Links List'
      OnClick = RemoveTheSiteFromTheList1Click
    end
    object NavigateToLinkListItem1: TMenuItem
      Caption = 'Navigate To Link List Item'
      OnClick = NavigateToLinkItem1Click
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object ShowTheList2: TMenuItem
      Caption = 'Show The List'
      OnClick = ShowTheList1Click
    end
    object ViewHideTheLinksToolbar1: TMenuItem
      Caption = 'View/Hide The Links Toolbar'
      OnClick = ViewHideTheLinksToolbar1Click
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object ClearTheLinksList1: TMenuItem
      Caption = 'Clear The Links List'
      OnClick = ClearTheLinkList1Click
    end
  end
  object IEDownload1: TIEDownload
    TimeOut = 60000
    Codepage = Ansi
    DefaultProtocol = 'http://'
    Method = Get
    Options = [Asynchronous, AsyncStorage, GetNewestVersion, NoWriteCache, PullData]
    UrlEncode = []
    Security.InheritHandle = False
    Range.RangeBegin = 0
    Range.RangeEnd = 0
    AdditionalHeader.Strings = (
      'Content-Type: application/x-www-form-urlencoded')
    UserAgent = 'Mozilla/4.0 (compatible; MSIE 5.0; Win32)'
    OnProgress = IEDownload1Progress
    OnResponse = IEDownload1Response
    OnComplete = IEDownload1Complete
    Left = 112
    Top = 240
  end
  object ilsSmilies: TImageList
    Height = 19
    Width = 19
    Left = 80
    Top = 208
    Bitmap = {
      494C01012F003100040013001300FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000004C000000F700000001002000000000005025
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002F4F4F00386058000B3838000B3838001247
      3F00052F28000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B8982000B89820000000000000000000000
      00002F3F4700284747001A3F3F00002828000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B8982000B89
      82000B8982000B8982000B817A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B8982000B8982000B8982000B8982000B817A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012A49B000B9C930012A4
      9B0000000000000000000000000000000000585868003F4F58001A2938000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012A49B000B9C930012A49B000B9C930012A49B000B9289000B8982000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012A49B000B9C930000000000000000000000
      000000000000000000000B8982000A7A70000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012A49B0011ADA50011ADA50011ADA5000000000000000000000000004F4F
      60002F2838003F3F470000000000000000000000000000000000000000000000
      000000000000000000000000000012A49B0011ADA50011ADA50011ADA50011AD
      A50011ADA50011ADA5000B9289000B9289000B817A000A7A7000000000000000
      000000000000000000000000000000000000000000000000000012A49B0011AD
      A500000000002828FF002828FF0014144D002828FF002828FF00000000000B81
      7A000A7A70000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000011B5AC0011B5AC0011BEB50011BE
      B50011BEB5000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000011BE
      B50011B5AC0011B5AC0011B5AC0011B5AC0011B5AC0011ADA50011ADA50011AD
      A5000B8982000B89820000000000000000000000000000000000000000000000
      0000000000000000000011BEB500000000000000000000000000000000000000
      0000000000000000000000000000000000000B89820000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000011B5
      AC0011BEB50012D0C00012D1C70012D0C00012D1C70011BEB500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000011B5AC0011BEB50011BEB50012D1C70012D0C00012D1
      C70011BEB50011BEB50011B5AC0011ADA50012A49B000B8982000B817A000000
      0000000000000000000000000000000000000000000011B5AC0011BEB5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B8982000B817A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000011BEB50012D1C70019E3D20019E3D20019E3
      D20019E3D20019E3D20012D0C000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000011BEB50012D1
      C70019E3D20019E3D20019E3D20038E3D90019E3D20011BEB50011BEB50011B5
      AC0012A49B000B9289000B898200000000000000000000000000000000000000
      00000000000011BEB50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B898200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000012D0
      C00019E3D20028E3D90028E3D90028E3D90028E3D90019E3D20019E3D20012D0
      C00011B5AC0011ADA50012A49B000B8982000000000000000000000000000000
      0000000000000000000012D0C00019E3D20028E3D90028E3D90028E3D90038E3
      D90028E3D90038E3D90012D0C00011B5AC0011ADA50012A49B000B8982000000
      0000000000000000000000000000000000000000000012D0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B89820000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012D1C70028E3D90028E3D90038E3D90038E3
      D90038E3D90038E3D90019E3D20012D0C00011BEB50011ADA5000B9C93000B89
      820000000000000000000000000000000000000000000000000012D1C70019E3
      D20028E3D90038E3D90038E3D90038E3D90028E3D90038E3D90012D0C00011BE
      B50011ADA5000B9C93000B898200000000000000000000000000000000000000
      00000000000012D1C70000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B898200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000012D1
      C70019E3D20028E3D90038E3D90047EDE40038E3D90028E3D90019E3D2000000
      00000000000011ADA50012A49B000B8982000000000000000000000000000000
      0000000000000000000012D1C70019E3D20038E3D90038E3D90038E3D90038E3
      D90028E3D90019E3D20012D0C00011B5AC0011ADA50012A49B000B8982000000
      0000000000000000000000000000000000000000000012D1C700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B89820000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000019E3D20028E3D90038E3D90038E3
      D90038E3D90028E3D90019E3D200000000000000000011ADA50012A49B000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3D20012D0C00011B5
      AC0011ADA50012A49B0000000000000000000000000000000000000000000000
      0000000000000000000019E3D20000000000FFFFFF00FFEDD100FFFFFF00FFFF
      FF00FFEDD100FFFFFF00FFEDD1000000000012A49B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20028E3D90028E3D90028E3D90028E3D90028E3D90019E3D20012D0
      C00011B5AC0011ADA5000B9C9300000000000000000000000000000000000000
      000000000000000000000000000019E3D20028E3D90028E3D90028E3D90028E3
      D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C9300000000000000
      000000000000000000000000000000000000000000000000000019E3D2000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B9C93000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000019E3D20019E3D20028E3
      D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5
      AC0012A49B000000000000000000000000000000000000000000000000000000
      000000000000000000000000000019E3D20019E3D20028E3D90019E3D20019E3
      D20012D1C70011BEB50011B5AC0012A49B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012D1C70012D0C00012D0C00011BEB50011B5
      AC00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012D1C70012D0
      C00012D0C00011BEB50011B5AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000012D1C70012D0C00012D0C00011BEB50011B5AC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B282F00051A2100051A210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000125868001258
      6800125868000B21280012282F003F8A9C004FA5C000478A9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007AB6D10082C9
      ED00216893000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B89
      82000B8982000B8982000B8982000B817A000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B8982000B89
      82000B8982000B8982000B817A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001A688200217A93001A6882000B212800123A3C003F8A9C0047A5C0003F8A
      9C00213F47000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000093D1ED00A5E4FF002F82B60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000012A49B000B9C930012A49B000B9C930012A49B000B9289000B89
      82000B8982000A7A700000000000000000000000000000000000000000000000
      000012A49B0012A49B0012A49B0012A49B0012A49B000B9C93000B8982000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      000000000000000000001A688200217A93003FA5C0003FA5C000217A9300123A
      3C0028687A0038829300213F4700213F47003F93A5004FA5C000478A9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007AB6D100B6ED
      FF0060A5C9000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000011AD
      A5000000930000009300000093000B9C93000B9289000B817A000A7A70000000
      000000000000000000000000000012A49B0011ADA5000000000011ADA50011AD
      A50011ADA50012A49B0012A49B00000000000B8982000A7A7000000000000000
      0000000000000000000000000000000000000000000000000000388293003FA5
      C00047C0DA0047C0DA0047C0DA00388293000B2128001A3847003F8A9C004FA5
      C0004FA5C0001E47490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000093D1ED0060A5C90000000000000000000000
      000000000000000000000000000012A49B0012A49B000B817A000B8982000B81
      7A000B8982000B817A000B8982000000000000009C000000B90000009C000000
      93000B9C93000B9289000B8982000000000000000000000000000000000011B5
      AC0011BEB50011BEB500000000000000000000000000000000000000000012A4
      9B000B9289000B89820000000000000000000000000000000000000000000000
      000000000000000000003FA5C0004FC9E40068E4FF007BE5FF0068E4FF004FA5
      C0001A38470028687A0038829300213F4700213F47003F93A5004FA5C000478A
      9C00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000093D1
      ED0082C9ED003F8AAD00000000000000000000000000000000000000000011AD
      A50011ADA50012A49B000B9C930012A49B000B9C93000B9C93000B8982000000
      00000000000000000000000000000000000000000000000000000B8982000B81
      7A00000000000000000011BEB50011BEB50012D0C00012D1C70012D1C70012D1
      C70012D0C00011BEB50011BEB50011ADA50012A49B000B8982000B817A000000
      00000000000000000000000000000000000000000000000000004FC9E40068E4
      FF007BE5FF007BE5FF0060C9E40068E4FF00478A9C001A3847000B2128003882
      93004FA5C00047A5C0001E474900000000000000000000000000000000000000
      0000000000000000000068A5C90068A5C9002F7093001A2938000B282F003F70
      930082C9ED007AB6D1002F5C68007AB6D100A5E4FF0082C9ED004F8AB6000000
      000000000000000000000000000047EDE40011ADA50011ADA50011ADA50011AD
      A50011ADA50012A49B000B817A000000000028E3D90012D1C70012D1C70011BE
      B50011B5AC0012A49B00000000000B898200000000000000000011BEB50012D1
      C70019E3D20019E3D20019E3D20019E3D20019E3D20012D1C70011BEB50011B5
      AC0012A49B000B9C93000B898200000000000000000000000000000000000000
      0000000000000000000060C9E4007BE5FF007BE5FF0060C9E400386D7C0058AD
      C00068E4FF00478A9C001A3847003F8A9C0047A5C0002F5C6800388293003F8A
      9C000000000000000000000000000000000000000000000000004F8AB6003F8A
      AD00386D7C0068A5C9004F8AB6001A3847005D93B000A5E4FF007AB6D1003F70
      93007AB6D100B6EDFF00B6EDFF0093D1ED0000000000000000000000000047ED
      E40012D0C00012D0C00012D0C00012D0C00011ADA50012A49B000B817A000000
      000028E3D90019E3D20019E3D20012D0C00011B5AC0011ADA50012A49B000B89
      8200000000000000000012D0C00019E3D20028E3D90028E3D90028E3D90028E3
      D90028E3D90019E3D20012D0C00011BEB50011ADA50012A49B000B8982000000
      0000000000000000000000000000000000000000000000000000000000003F8A
      9C004FC9E40068E4FF0058ADC000284F5D0058ADC0004FC9E400386D7C000B21
      280012282F0028687A0047A5C00047A5C0000000000000000000000000000000
      000000000000000000001A293800284F5D0068A5C9006EADC6003F8AAD000B28
      2F001A3847005D93B000A5E4FF007AB6D1003F70930093D1ED00A5E4FF0082C9
      ED0000000000000000000000000047EDE4000000000012D0C00012A49B000000
      000011ADA50012A49B000B817A000000000038E3D90038E3D90019E3D20012D0
      C00011BEB50011ADA50012A49B000B898200000000000000000012D1C70019E3
      D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3D20012D1C70011BE
      B50011ADA50012A49B000B898200000000000000000000000000000000000000
      000000000000000000000000000000000000388293004FC9E40060C9E4000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005D93B0006EAD
      C6005D93B00021475800214758003F8AAD003F7093001A38470068A5C900A5E4
      FF0093D1ED00A5E4FF0082C9ED0060A5C90000000000000000000000000047ED
      E4000000000012D0C00012A49B000000000011B5AC00000000000B8982000000
      000038E3D90028E3D90019E3D20012D1C70011BEB50011ADA5000B9C93000B89
      8200000000000000000012D1C70019E3D20028E3D900000000000000000038E3
      D90028E3D90019E3D200000000000000000011ADA50012A49B000B8982000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000047A5C00060C9E400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001A384700284F5D006EADC6006EADC6004F8A
      B6001A3847001A2938003F8AAD0070C0E40070C0E40070C0E40060A5C9002F82
      B600000000000000000000000000000000000000000012D0C00012A49B000000
      000000000000000000000000000038E3D90038E3D90028E3D90019E3D20012D0
      C00011BEB5000000000012A49B000000000000000000000000000000000019E3
      D20028E3D900000000000000000038E3D90028E3D90019E3D200000000000000
      000011ADA50012A49B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000047A5C0007BE5FF0058AD
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005D93
      B0006EADC6005D93B00021475800214758003F8AAD002F7093001A384700287A
      AD0060A5C90060A5C900287AAD00216893000000000000000000000000000000
      00000000000012D0C00012A49B000000000019E3D20028E3D900000000000000
      00000000000028E3D90000000000000000000000000011ADA5000B9C93000000
      000000000000000000000000000019E3D20028E3D90028E3D90028E3D90028E3
      D90028E3D90019E3D20012D0C00011BEB50011ADA50012A49B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000047A5C0007BE5FF0060C9E4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001A384700214758004F8AB60068A5
      C9004F8AB6001A384700051A210021689300287AAD0021689300000000000000
      0000000000000000000000000000000000000000000012D0C00012A49B000000
      00000000000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BE
      B50011B5AC0012A49B0000000000000000000000000000000000000000000000
      000019E3D20019E3D20019E3D20019E3D20019E3D20012D1C70011BEB50011B5
      AC0012A49B000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003F8A9C0060C9E40058AD
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005D93B0006EADC6004F8AB6001A2938000B282F0012587A0012587A001258
      7A00000000000000000000000000000000000000000000000000000000000000
      00000000000012D0C00012A49B000000000000000000000000000000000012D1
      C70012D0C00012D0C00011BEB50011B5AC000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012D1C70012D1
      C70012D0C00011BEB50011BEB500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000001020F00000614000006140001050D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000061400000614000006140001020F000000000000000000000000000000
      000000000000000000000000000000000000000000000B8982000B8982000B89
      82000B8982000B817A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B8982000B8982000B8982000B8982000B817A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B8982000B8982000B8982000B8982000B817A00000000000000
      0000000000000000000000000000000000000000000000012800335FA600335F
      A600335FA6000006140000000000000000000B8982000B8982000B8982000B89
      82000B817A00000000000000000000061400335FA600335FA600335FA6000000
      1C00000000000000000000000000000000000000000000000000000000000B9C
      930012A49B0000000000000000000000000000000000000000000B8982000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B9C930012A49B000000000000000000000000000000
      0000000000000B8982000A7A7000000000000000000000000000000000000000
      000000000000000000000000000012A49B000B9C930012A49B000B9C930012A4
      9B000B9289000B8982000B8982000A7A70000000000000000000000000000000
      00000000000000001C00335FA600335FA600335FA6000000000012A49B000B9C
      930012A49B000B9C930012A49B000B9289000B8982000B8982000A7A70000000
      0000335FA600335FA600335FA600000122000000000000000000000000000000
      0000000000000000000012A49B0011ADA5000000000000000000FFFFFF00FFFF
      FF00FFEDD10000000000000000000B8982000A7A700000000000000000000000
      0000000000000000000000000000000000000000000012A49B0011ADA5000000
      000000000000FFFFFF00FFFFFF00FFEDD10000000000000000000B8982000A7A
      700000000000000000000000000000000000000000000000000012A49B0011AD
      A50011ADA50000000000000000000000000000000000000000000B9289000B81
      7A000A7A7000000122000000000000000000000000000000000001122100335F
      A6000001070012A49B0011ADA50011ADA5000000000000000000000000000000
      0000000000000B9289000B817A000A7A700000012200335FA60000132D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFEDD10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF000000
      00000B8982000000000000000000000000000000000000000000000000000000
      00000000000011B5AC0000000000FFEDD10000000000FFFFFF00FFFFFF00FFED
      D10000000000FFFFFF00000000000B8982000000000000000000000000000000
      0000000000000000000011B5AC0011B5AC000000000011BEB50011BEB50011B5
      AC0011B5AC0011ADA500000000000B9289000B89820000091A00000000000000
      0000000000000000000000131000335FA6000013100011B5AC0011B5AC000000
      000011BEB50011BEB50011B5AC0011B5AC0011ADA500000000000B9289000B89
      820000091A00335FA60001020F000000000000000000007A7A0000000000007A
      7A00007A7A0000000000007A7A0000000000FFEDD10000000000FFFFFF00FFFF
      FF00FFEDD10000000000FFFFFF00FFEDD100000000000B817A00000000000000
      000000000000000000007A0000007A0000007A0000007A0000007A000000FFED
      D10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00FFEDD1000000
      00000B817A000000000000000000000000000000000011B5AC0011BEB5000000
      000012D1C70012D0C00012D1C70012D0C00011BEB50011B5AC0011ADA5000000
      00000B8982000B817A00001A1600000000000000000000000000000107000519
      190011B5AC0011BEB5000000000012D1C70012D0C00012D1C70012D0C00011BE
      B50011B5AC0011ADA500000000000B8982000B817A00001A1600001A16000000
      000000000000007A7A0000000000007A7A00007A7A0000000000007A7A000000
      00000000000000000000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00FFED
      D100000000000B89820000000000000000000000000000000000000000000000
      00007A00000000000000FFFFFF00FFEDD10000000000FFFFFF00FFFFFF00FFED
      D10000000000FFFFFF00FFEDD100000000000B89820000000000000000000000
      00000000000011BEB50012D1C70019E3D20019E3D20019E3D20019E3D20019E3
      D20012D1C70011BEB50011B5AC0012A49B000B9289000B898200000E08000000
      000000000000000000001C1A1D000001070011BEB50012D1C70019E3D20019E3
      D20019E3D20019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B000B92
      89000B898200000E0800000E08000000000000000000007A7A0000000000007A
      7A00007A7A0000000000007A7A000000000012D1C70012D1C70000000000FFFF
      FF00FFEDD10000000000FFFFFF00FFEDD100000000000B898200000000000000
      00000000000000000000000000000000000012D1C70012D1C70000000000FFED
      D10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00FFEDD1000000
      00000B89820000000000000000000000000001050D0012D0C00019E3D20028E3
      D90028E3D90028E3D90028E3D90028E3D90012D1C70012D0C00011B5AC0011AD
      A50012A49B000B89820000131000000000000000000000000000000107000105
      0D0012D0C00019E3D20028E3D90028E3D90028E3D90028E3D90028E3D90012D1
      C70012D0C00011B5AC0011ADA50012A49B000B89820000131000000E08000000
      000000000000007A7A0000000000000000000000000000000000007A7A000000
      000012D1C70012D0C00000000000000000000000000000000000000000000000
      0000000000000B89820000000000000000000000000000000000000000000000
      000012D1C70012D0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000B89820000000000000000000001
      280001050D0012D1C70019E3D20028E3D90038E3D90038E3D90038E3D90028E3
      D90019E3D20012D0C00011BEB50011ADA5000B9C93000B898200000107000001
      280000000000000000000F121B0001050D0012D1C70019E3D20028E3D90038E3
      D90038E3D90038E3D90028E3D90019E3D20012D0C00011BEB50011ADA5000B9C
      93000B89820000010700001A1600000000000000000000000000007A7A00007A
      7A00007A7A00007A7A00000000000000000012D1C7000000000038E3D90028E3
      D90019E3D20012D0C00011BEB50011ADA5000B9C93000B898200000000000000
      00000000000000000000000000000000000012D1C7000000000028E3D90038E3
      D90047EDE40038E3D90028E3D90019E3D20012D0C00011BEB50011ADA5000B9C
      93000B8982000000000000000000000128000013100012D1C70019E3D20038E3
      D900000000000000000038E3D90028E3D90019E3D200000000000000000011AD
      A50012A49B000B89820000061400000128000000000000000000000000000013
      100012D1C70019E3D20038E3D900000000000000000038E3D90028E3D90019E3
      D200000000000000000011ADA50012A49B000B89820000061400051A21000000
      000000000000007A7A00007A7A00007A7A00007A7A00007A7A00007A7A000000
      000000000000000000000000000028E3D9000000000012D1C70011BEB5000000
      000012A49B000000000000000000000000000000000000000000000000007A00
      000000000000000000000000000038E3D90038E3D9000000000028E3D9000000
      000012D1C70011BEB5000000000012A49B000000000000000000000000000001
      280018222D000013100019E3D20028E3D900000000000000000038E3D90028E3
      D90019E3D200000000000000000011ADA50012A49B0001020F0018222D000001
      28000000000000000000000E0800335FA6000013100019E3D20028E3D9000000
      00000000000038E3D90028E3D90019E3D200000000000000000011ADA50012A4
      9B0001020F00335FA60001020F000000000000000000007A7A00007A7A00007A
      7A00007A7A00007A7A00007A7A0000000000000000000000000028E3D90028E3
      D90019E3D200000000000000000011ADA5000B9C930000000000000000000000
      000000000000000000007A000000007A7A000000FF00BFBFBF007A0000000000
      00000000000028E3D90028E3D90019E3D200000000000000000011ADA5000B9C
      93000000000000000000000000000001280018222D00001A160019E3D20028E3
      D90028E3D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5AC0011AD
      A5000B9C930000132D0018222D0000012800000000000000000001122100335F
      A600001A160019E3D20028E3D90028E3D90028E3D90028E3D90028E3D90019E3
      D20012D0C00011B5AC0011ADA5000B9C930000132D00335FA600172240000000
      000000000000007A7A00007A7A00FFFFFF00007A7A00007A7A00007A7A000000
      000019E3D2000000000019E3D20019E3D20012D1C70011BEB50011B5AC0012A4
      9B0000000000000000000000000000000000000000007A000000BFBFBF00007A
      7A00007A7A00BFBFBF00BFBFBF007A00000028E3D90019E3D20019E3D20012D1
      C70011BEB50011B5AC0012A49B00000000000000000000000000000000000001
      280018222D0018222D00000114000001140000132D000112210000091A000008
      210000011400000614000006140001050D000112210018222D0018222D000001
      2800000000000000000000011400335FA600335FA60000011400000114000013
      2D000112210000091A000008210000011400000614000006140001050D000112
      2100335FA600335FA600000114000000000000000000007A7A00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00007A7A00000000000000000012D1C70012D0C00012D0
      C00011BEB50011B5AC0000000000000000000000000000000000000000000000
      00007A000000BFBFBF00BFBFBF00BFBFBF00BFBFBF0000007A00BFBFBF00BFBF
      BF007A00000012D0C00012D0C00011BEB50011B5AC0000000000000000000000
      00000000000000000000000000000001140018222D0018222D0018222D001822
      2D0018222D0018222D0018222D0018222D0018222D0018222D0018222D001822
      2D0018222D0018222D0018222D00011221000000000000000000000114000013
      2D0025628900335FA600335FA600335FA600335FA600335FA600335FA600335F
      A600335FA600335FA600335FA600335FA600335FA60000082100011221000000
      000000000000007A7A00007A7A00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007A0000007A0000007A0000007A0000007A00
      00007A0000007A0000007A0000007A0000007A0000007A000000000000000000
      0000000000000000000000000000000000000000000000000000000000000001
      280018222D0018222D0018222D0018222D0018222D0018222D0018222D001822
      2D0018222D0018222D0018222D0018222D0018222D0018222D0018222D000001
      28000000000000000000000000000001140000193C00335FA600335FA600335F
      A600335FA600335FA600335FA600335FA600335FA600335FA60023609E00335F
      A6000008210001020F0000000000000000000000000000000000000000007878
      7800787878007878780078787800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000007A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000001280018222D0000010700000821001822
      2D0018222D0018222D0018222D0018222D0018222D0018222D0018222D000003
      390000001C0000091A0018222D00000128000000000000000000000000000000
      0000000107000008210000082100335FA600335FA600335FA600335FA600335F
      A600335FA600335FA6000003390000001C0000091A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000007A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000012800000128000001280018222D000008210000033900000128001822
      2D000003390018222D0018222D00000128000000000000012800000128000000
      0000000000000000000000000000000000000000000000000000000114000008
      2100000339000001280000012800000339000001280000012800000128000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000001280018222D001822
      2D00000128000001280018222D0018222D00000128000001280018222D001822
      2D00000128000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000012200000128000000000000000000000128000001
      2800000128000000000000012800000128000001280000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B8982000B8982000B8982000B8982000B817A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF00BFBFBF00000000000B8982000B89
      82000B817A000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B8982000B8982000B89
      82000B8982000B817A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B8982000B8982000B8982000B8982000B817A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B9C930012A49B0000000000000000000000
      000000000000000000000B8982000A7A70000000000000000000000000000000
      00000000000000000000000000000000000012D1C70012D1C7000000000000FF
      FF0000FFFF00BFBFBF00000000000B9289000B8982000B8982000A7A70000000
      00000000000000000000000000000000000000000000000000000000000012A4
      9B000B9C930012A49B000B9C930012A49B000B9289000B8982000B8982000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000012A49B000B9C930012A49B000B9C930012A49B000B92
      89000B8982000B8982000A7A7000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012A49B0011AD
      A5000000000000000000FFFFFF00FFFFFF00FFEDD10000000000000000000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      000012D1C70012D0C0000000000000FFFF0000FFFF0000FFFF00000000000000
      0000000000000B9289000B817A000A7A70000000000000000000000000000000
      0000000000000000000012A49B0011ADA50011ADA50011ADA50011ADA50011AD
      A50011ADA5000B9289000B9289000B817A000A7A700000000000000000000000
      0000000000000000000000000000000000000000000012A49B0011ADA50011AD
      A50011ADA50011ADA50011ADA50011ADA5000B9289000B9289000B817A000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFEDD10000000000FFFFFF00FFFF
      FF00FFEDD10000000000FFFFFF00000000000B89820000000000000000000000
      00000000000000000000BFBFBF000000000012D1C700000000000000000000FF
      FF0000FFFF000000000011B5AC0011B5AC0012A49B00000000000B9289000B89
      820000000000000000000000000000000000000000000000000011B5AC0011B5
      AC0011BEB50011BEB50011BEB50011B5AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000011B5AC0011AD
      A50011ADA50011ADA5000B8982000B8982000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFEDD1000000
      0000FFEDD10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00FFED
      D100000000000B817A00000000000000000000000000BFBFBF0000FFFF0000FF
      FF00000000000000000019E3D200000000000000000012D1C70012D0C00011BE
      B50011B5AC0011ADA5000B9C93000B8982000B817A0000000000000000000000
      00000000000011B5AC0011BEB50011BEB50012D1C70012D0C00012D1C7000000
      000011BEB50011B5AC0011ADA50012A49B000B8982000B817A00000000000000
      00000000000000000000000000000000000011B5AC0011BEB50011BEB50012D1
      C70012D0C00012D1C7000000000011BEB50011B5AC0011ADA50012A49B000B89
      82000B817A0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFEDD100000000000000000000000000FFFFFF00FFFF
      FF00FFEDD10000000000FFFFFF00FFEDD100000000000B898200000000000000
      0000BFBFBF0000FFFF0000FFFF00FFFFFF000000000012D1C70019E3D2000000
      00000000000019E3D20019E3D20012D1C700000000000000000012A49B000B92
      89000B8982000000000000000000000000000000000011BEB50012D1C70019E3
      D20019E3D20019E3D2000000000019E3D20012D1C70011BEB50011B5AC0012A4
      9B000B9289000B89820000000000000000000000000000000000000000000000
      000011BEB50012D1C70019E3D20019E3D20019E3D20038E3D90019E3D2000000
      000011BEB50011B5AC0012A49B000B9289000B89820000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFEDD1000000
      000012D1C70012D1C70000000000FFFFFF00FFEDD10000000000FFFFFF00FFED
      D100000000000B89820000000000007A7A0000FFFF0000FFFF00FFFFFF000000
      000012D0C00019E3D20000000000FFEDD100FFEDD1000000000028E3D9000000
      0000FFEDD100FFEDD100000000000B9C93000B89820000000000000000000000
      00000000000012D0C00019E3D20028E3D90028E3D90028E3D9000000000028E3
      D90012D1C70012D0C00011B5AC0011ADA50012A49B000B898200000000000000
      00000000000000000000000000000000000012D0C00019E3D20028E3D90028E3
      D90028E3D90038E3D90028E3D9000000000012D0C00011B5AC0011ADA50012A4
      9B000B8982000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012D1C70012D0C000000000000000
      000000000000000000000000000000000000000000000B89820000000000007A
      7A00FFFFFF0000FFFF00FFFFFF000000000012D1C70000000000FFEDD100FFFF
      FF00FFFFFF00FFEDD10000000000FFEDD100FFFFFF00FFFFFF00FFEDD1000000
      00000B8982000000000000000000000000000000000012D1C70019E3D20028E3
      D90038E3D90038E3D90038E3D90028E3D90019E3D20012D0C00011BEB50011AD
      A5000B9C93000B89820000000000000000000000000000000000000000000000
      000012D1C70019E3D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3
      D20012D0C00011BEB50011ADA5000B9C93000B89820000000000000000000000
      0000000000000000000000000000000000000000000019E3D20019E3D2000000
      0000000000000000000038E3D90028E3D90019E3D20012D0C00011BEB50011AD
      A5000B9C93000B89820000000000007A7A00FFFFFF0000FFFF0000FFFF00FFFF
      FF000000000000000000FFEDD1000000000000000000FFEDD10000000000FFED
      D1000000000000000000FFEDD100000000000B89820000000000000000000000
      00000000000012D1C70019E3D20038E3D90028E3D90028E3D90038E3D90028E3
      D90019E3D200000000000000000011ADA50012A49B000B898200000000000000
      00000000000000000000000000000000000012D1C70019E3D20038E3D9000000
      00000000000038E3D90028E3D90019E3D20012D0C00011B5AC0011ADA50012A4
      9B000B8982000000000000000000000000000000000078787800000000000000
      0000000000000000000019E3D2000000000019E3D20019E3D2000000000028E3
      D9000000000012D1C70011BEB5000000000012A49B0000000000000000000000
      0000007A7A00FFFFFF0000FFFF0000FFFF000000000019E3D200000000000000
      0000000000000000000028E3D9000000000000000000000000000000000012A4
      9B0000000000000000000000000000000000000000000000000019E3D20028E3
      D90028E3D90028E3D90038E3D90028E3D90019E3D200000000000000000011AD
      A50012A49B000000000000000000000000000000000000000000000000000000
      00000000000019E3D20028E3D900000000000000000038E3D90028E3D90019E3
      D20012D0C00011B5AC0011ADA50012A49B000000000000000000000000000000
      000000000000000000007878780000000000000000000000000019E3D20019E3
      D200000000000000000028E3D90028E3D90019E3D200000000000000000011AD
      A5000B9C930000000000000000000000000000000000007A7A00007A7A000000
      00000000000019E3D20028E3D90000000000494A4A0028E3D90028E3D90019E3
      D20000000000494A4A0011ADA5000B9C93000000000000000000000000000000
      0000000000000000000019E3D20028E3D90028E3D90028E3D90028E3D90028E3
      D90019E3D20012D0C00011B5AC0011ADA5000B9C930000000000000000000000
      0000000000000000000000000000000000000000000019E3D20028E3D90028E3
      D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C
      9300000000000000000000000000000000000000000000000000787878000000
      000000000000000000000000000019E3D20019E3D20019E3D20019E3D20019E3
      D20012D1C70011BEB50011B5AC0012A49B000000000000000000000000000000
      000000000000000000000000000000000000000000000000000019E3D20019E3
      D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A4
      9B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000019E3D20019E3D20028E3D90019E3D20019E3D20012D1
      C70011BEB50011B5AC0012A49B00000000000000000000000000000000000000
      0000000000000000000078787800000000007878780000000000000000000000
      00000000000012D1C70012D0C00012D0C00011BEB50011B5AC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012D1C70012D0C00012D0C00011BE
      B50011B5AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012D1C70012D0C00012D0
      C00011BEB50011B5AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012D1C70012D0C00012D0C00011BEB50011B5AC0000000000000000000000
      0000000000000000000000000000000000000000000078787800000000000000
      0000787878000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007878780000000000787878000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000078787800000000007878
      7800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000078787800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007878780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B8982000B8982000B8982000B8982000B81
      7A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000088C8400088C
      8400088C8400088C840008847B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B8982000B8982000B8982000B8982000B81
      7A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B8982000B8982000B8982000B8982000B817A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B9C930012A49B000000
      0000000000000000000000000000000000000B8982000A7A7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000010A59C00089C940010A59C00089C940010A59C0008948C00088C8400088C
      84000A7A70000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B9C930012A49B000B9C
      930012A49B000B9C93000B9289000B8982000B8982000A7A7000000000000000
      00000000000000000000000000000000000012A49B000B9C930012A49B000B9C
      930012A49B000B9289000B8982000B8982000A7A700000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012A49B0011ADA5000000000000000000FFFFFF00FFFFFF00FFEDD1000000
      0000000000000B8982000A7A7000000000000000000000000000000000000000
      000000000000000000000000000010A59C0011ADA50011ADA50011ADA50011AD
      A50011ADA50011ADA50008948C0008948C0008847B000A7A7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B9C930011ADA50012A49B00000000000000000000000000000000000000
      00000B9289000B817A000A7A70000000000000000000000000000000000012A4
      9B0011ADA50011ADA50000000000000000000000000000000000000000000B92
      89000B817A000A7A700000000000000000000000000000000000000000000000
      00000000000000000000000000000000000011B5AC0000000000FFEDD1000000
      0000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00000000000B8982000000
      00000000000000000000000000000000000000000000000000000000000011BE
      B50011B5AC000000000000000000000000000000000000000000000000000000
      0000088C8400088C8400000000000000000000000000000000000000000012D1
      C70012D1C70000000000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF0011ADA500000000000B9289000B8982000000
      000000000000000000000000000011B5AC0011B5AC000000000011BEB50011BE
      B50011B5AC0011B5AC0011ADA500000000000B9289000B898200000000000000
      00000000000000000000000000000000000000000000000000000000000011B5
      AC0000000000FFFFFF00FFEDD10000000000FFFFFF00FFFFFF00FFEDD1000000
      0000FFFFFF00FFEDD100000000000B817A000000000000000000000000000000
      0000000000000000000011B5AC0011BEB50011BEB50010D6C60010D6C60012D1
      C70012D0C00011BEB50011B5AC0011ADA50010A59C00088C840008847B000000
      000000000000000000000000000012D1C70012D0C00000000000000000000000
      00000000000000000000000000000000000000000000000000000000000011B5
      AC0011ADA5000B9C93000B8982000B817A00000000000000000011B5AC0011BE
      B5000000000012D1C70012D0C00012D1C70012D0C00011BEB50011B5AC0011AD
      A500000000000B8982000B817A00000000000000000000000000000000000000
      000000000000000000000000000011BEB50000000000FFFFFF00FFEDD1000000
      0000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00FFEDD100000000000B89
      820000000000000000000000000000000000000000000000000011BEB50010D6
      C60019E3D20019E3D20019E3D20019E3D20019E3D20012D1C70011BEB50011B5
      AC0010A59C0008948C00088C84000000000000000000000000000000000012D1
      C700000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000000000000000000011BEB50011B5AC0012A49B000B9289000B89
      8200000000000000000011BEB50012D1C70019E3D20019E3D20019E3D20019E3
      D20019E3D20012D1C70011BEB50011B5AC0012A49B000B9289000B8982000000
      0000000000000000000000000000000000000000000019E3D20019E3D2000000
      000000000000FFFFFF00FFEDD10000000000FFFFFF00FFFFFF00FFEDD1000000
      0000FFFFFF00FFEDD100000000000000000019E3D20019E3D200000000000000
      0000000000000000000010D6C60019E3D20028E3D90028E3D90028E3D90028E3
      D90028E3D90010D6C60012D0C00011B5AC0011ADA50010A59C00088C84000000
      000000000000000000000000000012D1C7000000000000000000000000000000
      000000000000FFFFFF00FF000000FF000000FFFFFF00000000000000000012D0
      C00011B5AC0011ADA50012A49B000B898200000000000000000012D0C00019E3
      D20028E3D90028E3D90028E3D90028E3D90028E3D90012D1C70012D0C00011B5
      AC0011ADA50012A49B000B898200000000000000000000000000000000000000
      00000000000019E3D20019E3D200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20019E3D2000000000000000000000000000000000010D6C60019E3
      D20028E3D90038E3D90038E3D90047EDE40028E3D90038E3D90010D6C60011BE
      B50011ADA500089C9400088C8400000000000000000000000000000000000000
      0000FFFF0000000000000000000000000000FFFFFF007878780078787800FF00
      0000FF000000FFFFFF000000000012D1C70011BEB50011ADA5000B9C93000B89
      8200000000000000000012D1C70019E3D20028E3D90038E3D90038E3D90038E3
      D90028E3D90019E3D20012D0C00011BEB50011ADA50012A49B000B8982000000
      0000000000000000000000000000000000000000000019E3D2000000000012D1
      C70019E3D20028E3D90038E3D90047EDE40038E3D90028E3D90019E3D20012D0
      C00011BEB50011ADA5000B9C93000B8982000000000019E3D200000000000000
      000038E3D90038E3D9000001070019E3D20038E3D900000000000000000038E3
      D90028E3D90019E3D200000107000000000011ADA50010A59C00088C84000000
      000000000000000000000000000000000000FFFF000000000000000000000000
      0000FFFFFF00787878007878780078787800FF000000FFFFFF00000000000000
      00000000000011ADA50012A49B000B898200000000000000000012D1C70019E3
      D20038E3D900000000000000000038E3D90028E3D90019E3D200000000000000
      000011ADA5000B9C93000B898200000000000000000000000000000000000000
      00000000000000000000000000000000000019E3D2000000000038E3D90038E3
      D9000000000028E3D9000000000012D1C70011BEB5000000000012A49B000000
      00000000000000000000000000000000000038E3D90038E3D90038E3D9000000
      000028E3D900000000000000000038E3D90028E3D90019E3D2002C2C2D002C2C
      2D002C2C2D002C2C2D002C2C2D002C2C2D002C2C2D002C2C2D00000000000000
      00000000000000000000000000000000000000000000FFFFFF00787878007878
      7800FFFFFF00000000000000000012D1C70011BEB50011ADA50012A49B000000
      000000000000000000000000000019E3D20028E3D900000000000000000038E3
      D90028E3D90019E3D200000000000000000011ADA50012A49B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20028E3D900000000000000000028E3D90028E3D90019E3D2000000
      00000000000011ADA5000B9C9300000000000000000000000000000000000000
      00000000000000000000000000002C2C2D002C2C2D002C2C2D002C2C2D002C2C
      2D002C2C2D002C2C2D002C2C2D002C2C2D0011305A0011305A0011305A001130
      5A002C2C2D000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000012D0
      C00011B5AC0011ADA5000B9C93000000000000000000000000000000000019E3
      D20028E3D90028E3D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5
      AC0011ADA5000B9C930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000019E3D20019E3D20028E3
      D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B00000000000000
      0000000000000000000000000000000000002C2C2D002C2C2D002C2C2D000B69
      47000B6947000B6947000B6947000B6947000B6947001C9153001C9153001C91
      53001C9153001C91530011305A0011305A002C2C2D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF0011BEB50011B5AC0012A49B00000000000000
      00000000000000000000000000000000000019E3D20019E3D20028E3D90019E3
      D20019E3D20012D1C70011BEB50011B5AC0012A49B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012D1C70012D0C00012D0C00011BEB50011B5
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000002C2C2D001C9153001C9153001C9153001C9153000B6947000B69
      47000B6947000B6947000B6947001C9153001C9153000B69470011305A001130
      5A002C2C2D00000000000000000000000000BFBFBF00BFBFBF00787878007878
      7800BFBFBF00BFBFBF00BFBFBF0000FFFF0000FFFF0000FFFF0000FFFF0011B5
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000012D1C70012D0C00012D0C00011BEB50011B5AC000000
      0000000000000000000078787800363636000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002C2C2D001C91
      53001C91530011305A0011305A0011305A0011305A000B6947000B6947000B69
      47000B6947000B6947000B6947002C2C2D000000000000000000000000000000
      000000FFFF0000FFFF00787878007878780000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000007A7A000000000000000000787878003636
      36000000000000000000007A7A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002C2C2D0011305A0011305A0011305A001130
      5A000B6947000B6947001C91530011305A0011305A000B6947002C2C2D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007A7A0000FFFF00FFFFFF00007A7A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002C2C2D002C2C2D0011305A000B6947000B6947000B6947001C9153001130
      5A002C2C2D002C2C2D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007A7A0000000000007A7A0000FFFF00FFFFFF00FFFF
      FF00FFFFFF00007A7A0000000000007A7A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002C2C2D002C2C
      2D002C2C2D002C2C2D002C2C2D002C2C2D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007A7A0000FFFF00FFFFFF00007A7A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000007A7A000000000000000000007A7A00007A
      7A000000000000000000007A7A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B8982000B8982000B8982000B8982000B817A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000B8982000B8982000B8982000B89
      82000B817A000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B8982000B89
      82000B8982000B8982000B817A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B8982000B8982000B8982000B8982000B817A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012A49B000B9C930012A49B000B9C930012A4
      9B000B9289000B8982000B8982000A7A70000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012A49B000B9C
      930012A49B000B9C930012A49B000B9289000B8982000B8982000A7A70000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B9C930012A49B000B9C930012A49B000B9289000B8982000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      0000000000000000000012A49B000B9C930012A49B000000B9000000B9000000
      B9000B8982000B8982000A7A7000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012A49B0011AD
      A50011ADA50000000000000000000000000000000000000000000B9289000B81
      7A000A7A70000000000000000000000000000000000000000000000000000000
      00000000000012A49B0011ADA50011ADA50011ADA50011ADA50011ADA50012A4
      9B0012A49B000B8982000B8982000A7A70000000000000000000000000000000
      00000000000019E3D20019E3D20019E3D20019E3D20000000000000000000000
      00000000000000000000000000000B9289000B817A000A7A7000000000000000
      0000000000000000000000000000000000000000000012A49B0011ADA50011AD
      A5000000B9000000B9000000B9000000B9000000B9000B9289000B817A000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      000011BEB500000000000000000011B5AC000000000011BEB50011BEB50011B5
      AC0011B5AC0011ADA500000000000B9289000B89820000000000000000000000
      000000000000000000000000000011BEB500000000000000000011B5AC000000
      000011BEB50011BEB50011B5AC0011B5AC0012A49B00000000000B9289000B89
      8200000000000000000000000000000000000000000019E3D20019E3D20019E3
      D2000000000011BEB50011BEB50011BEB50011B5AC0011B5AC0011ADA5000000
      00000B9289000B89820000000000000000000000000000000000000000000000
      00000000000011B5AC0011B5AC000000B9000000B90000000000000000000000
      00000000B9000000B9000B9289000B8982000000000000000000000000000000
      00000000000000000000000000000000000011BEB50011BEB500000000000000
      000012D1C70012D0C00012D1C70012D0C00011BEB50011B5AC0011ADA5000000
      00000B8982000B817A00000000000000000000000000000000000000000011BE
      B50011BEB5000000000012D0C00012D1C7000000000000000000000000000000
      00000000000011ADA5000B9C93000B8982000B817A0000000000000000000000
      00000000000000000000000000000000000012D0C00012D1C70012D0C00012D1
      C70012D0C00011BEB50011B5AC0011ADA5000B9C93000B8982000B817A000000
      00000000000000000000000000000000000011B5AC0011BEB50011BEB50012D1
      C7000000B9000000B90012D0C0000000B9000000B90011ADA5000B9289000B89
      82000B817A0000000000000000000000000000000000007A0000007A00000000
      000011BEB50011BEB5000000000019E3D20019E3D20019E3D20019E3D20019E3
      D20012D1C70011BEB50011B5AC0012A49B000B9289000B898200000000000000
      0000007A0000007A00000000000011BEB50011BEB5000000000019E3D20019E3
      D20019E3D20019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B000B92
      89000B898200000000000000000000000000000000000000000011BEB50012D1
      C70019E3D200000000000000000019E3D20019E3D20012D1C700000000000000
      000012A49B000B9289000B898200000000000000000000000000000000000000
      000011BEB50012D1C70019E3D20019E3D20019E3D20019E3D20019E3D20012D1
      C70011BEB50011B5AC0012A49B000B9289000B89820000000000000000000000
      000000000000007A0000007A00000000000011BEB50000000000007A0000007A
      000028E3D90028E3D90028E3D90028E3D90012D1C70012D0C00011B5AC0011AD
      A50012A49B000B8982000000000000000000007A0000007A00000000000011BE
      B50000000000007A0000007A000028E3D90028E3D90028E3D90028E3D90012D1
      C70012D0C00011B5AC0011ADA50012A49B000B89820000000000000000000000
      0000000000000000000012D0C00019E3D2000000000000000000FFEDD1000000
      000028E3D9000000000000000000FFEDD100000000000B9C93000B8982000000
      00000000000000000000000000000000000012D0C00019E3D20028E3D90028E3
      D90028E3D90028E3D90028E3D90012D1C70012D0C00011B5AC0011ADA50012A4
      9B000B898200000000000000000000000000007A0000007A0000000000000000
      00000000000000000000007A0000007A000038E3D90038E3D90038E3D90028E3
      D90019E3D20012D0C00011BEB50011ADA5000B9C93000B89820000000000007A
      0000007A000000000000000000000000000000000000007A0000007A00000000
      00000000000038E3D90028E3D90028E3D900000000000000000011ADA50012A4
      9B000B898200000000000000000000000000000000000000000012D1C7000000
      00000000000000000000FFFFFF00FFEDD100000000000000000000000000FFFF
      FF00FFEDD100000000000B898200000000000000000000000000000000000000
      000012D1C70019E3D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3
      D20012D0C00011BEB50011ADA5000B9C93000B89820000000000000000000000
      0000000000000000000000000000000000007A7A00000000000019E3D200007A
      0000007A00000000000038E3D90028E3D90019E3D200000000000000000011AD
      A50012A49B000B89820000000000000000000000000000000000000000007A7A
      00000000000019E3D200007A0000007A00000000000038E3D90028E3D90019E3
      D200000000000000000011ADA5000B9C93000B89820000000000000000000000
      0000000000000000000012D1C70000000000FFEDD100FFFFFF00FFFFFF00FFED
      D10000000000FFEDD100FFFFFF00FFFFFF00FFEDD100000000000B8982000000
      00000000000000000000000000000000000012D1C70019E3D2000000000038E3
      D90038E3D9000000000028E3D9000000000028E3D90011BEB5000000000012A4
      9B000B8982000000000000000000000000000000000000000000000000000000
      7A007A7A000000007A0019E3D20028E3D900000000000000000038E3D90028E3
      D90019E3D200000000000000000011ADA50012A49B0000000000000000000000
      0000000000000000000000007A007A7A000000007A0019E3D2000000000038E3
      D90038E3D90038E3D90028E3D90019E3D20012D0C00011BEB5000000000012A4
      9B000000000000000000000000000000000000000000000000000000000019E3
      D20000000000FFEDD100FFEDD1000000000028E3D90000000000FFEDD100FFED
      D1000000000012A49B0000000000000000000000000000000000000000000000
      00000000000019E3D20028E3D900000000000000000038E3D90028E3D90019E3
      D200000000000000000011ADA50012A49B000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF0028E3
      D90028E3D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5AC0011AD
      A5000B9C9300000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0028E3D9000000000028E3D90028E3D90028E3D90019E3
      D20012D0C0000000000011ADA5000B9C93000000000000000000000000000000
      000000000000000000000000000019E3D20028E3D900000000000000000028E3
      D90028E3D90019E3D200000000000000000011ADA5000B9C9300000000000000
      0000000000000000000000000000000000000000000019E3D20028E3D90028E3
      D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C
      930000000000000000000000000000000000000000000000000000007A000000
      FF000000FF000000FF0000007A0019E3D20019E3D20028E3D90019E3D20019E3
      D20012D1C70011BEB50011B5AC0012A49B000000000000000000000000000000
      00000000000000007A000000FF000000FF000000FF0000007A0019E3D20019E3
      D2000000000028E3D90019E3D20012D1C7000000000011B5AC0012A49B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5
      AC0012A49B000000000000000000000000000000000000000000000000000000
      0000000000000000000019E3D20019E3D20028E3D90019E3D20019E3D20012D1
      C70011BEB50011B5AC0012A49B00000000000000000000000000000000000000
      00000000000000007A000000FF000000FF000000FF000000FF000000FF000000
      7A000000000012D1C70012D0C00012D0C00011BEB50011B5AC00000000000000
      00000000000000000000000000000000000000007A000000FF000000FF000000
      FF000000FF000000FF0000007A000000000012D1C70012D0C00012D0C00011BE
      B50011B5AC000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012D1C70012D0
      C00012D0C00011BEB50011B5AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012D1C70012D0C00012D0C00011BEB50011B5AC0000000000000000000000
      0000000000000000000000000000000000000000000000007A000000FF000000
      FF000000FF000000FF000000FF0000007A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000007A000000FF000000FF000000FF000000FF000000FF0000007A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000088C8400088C8400088C8400088C84000884
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B8982000B89
      82000B8982000B8982000B817A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B8982000B8982000B8982000B8982000B81
      7A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B8982000B8982000B8982000B8982000B817A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010A59C00089C940010A5
      9C00089C940010A59C0008948C00088C8400088C84000A7A7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012A49B000B9C930012A49B000B9C930012A49B000B9289000B8982000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B9C930012A49B000000
      0000000000000000000000000000000000000B8982000A7A7000000000000000
      00000000000000000000000000000000000012A49B000B9C930012A49B000B9C
      930012A49B000B9289000B8982000B8982000A7A700000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000010A59C0011ADA50011ADA500000000000000000000000000000000000000
      000008948C0008847B000A7A7000000000000000000000000000000000000000
      000000000000000000000000000012A49B0011ADA50000000000000000000B9C
      930012A49B0012A49B0000000000000000000B8982000A7A7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012A49B0011ADA5000000000000000000FFFFFF00FFFFFF00FFEDD1000000
      0000000000000B8982000A7A70000000000000000000000000000000000012A4
      9B0011ADA50011ADA50000000000000000000000000000000000000000000B92
      89000B8982000A7A700000000000000000000000000000000000000000000000
      00000000000000000000000000000000000011B5AC0011B5AC0011BEB50011BE
      B50011BEB50011B5AC0011B5AC0011ADA50011ADA50008948C00088C84000000
      00000000000000000000000000000000000000000000000000000000000011B5
      AC000000000011B5AC0011BEB5000000000011B5AC000000000011ADA50011AD
      A500000000000B817A0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000011B5AC0000000000FFEDD1000000
      0000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00000000000B8982000000
      000000000000000000000000000011B5AC0011B5AC000000000011BEB50011BE
      B50011B5AC0011B5AC0011ADA500000000000B9289000B817A00000000000000
      00000000000000000000000000000000000000000000000000000000000011B5
      AC0011BEB50010D6C60010D6C60010D6C60010D6C60010D6C60011BEB50011B5
      AC0011ADA500089C9400088C840008847B000000000000000000000000000000
      0000000000000000000011B5AC0011BEB50012D0C00012D1C70012D0C00012D1
      C70012D0C00011BEB50011B5AC0011ADA5000B9C93000B8982000B817A000000
      00000000000000000000000000000000000000000000000000000000000011B5
      AC0000000000FFFFFF00FFEDD10000000000FFFFFF00FFFFFF00FFEDD1000000
      0000FFFFFF00FFEDD100000000000B817A00000000000000000011B5AC0011BE
      B50012D0C00012D1C70012D0C00012D1C70012D0C00011BEB50011B5AC0011AD
      A5000B9C93000B8982000B817A00000000000000000000000000000000000000
      000000000000000000000000000011BEB50010D6C60019E3D20028E3D90028E3
      D90019E3D20019E3D20010D6C60011B5AC0011B5AC0010A59C0008948C00088C
      840000000000000000000000000000000000000000000000000011BEB5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B898200000000000000000000000000000000000000
      00000000000012D1C70012D1C700000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFEDD10000000000FFFFFF00FFEDD100000000000B89
      8200000000000000000011BEB50012D1C70019E3D20019E3D20019E3D20019E3
      D20019E3D20012D1C70011BEB50011B5AC0012A49B000B9289000B8982000000
      00000000000000000000000000000000000000000000000000000000000010D6
      C60019E3D20028E3D90028E3D900000000000000000028E3D90028E3D90010D6
      C60011BEB5000000000000000000088C84000000000000000000000000000000
      0000000000000000000012D0C00000000000FFFFFF00FFEDD10000000000FFFF
      FF00FFFFFF00FFEDD10000000000FFFFFF00FFEDD100000000000B8982000000
      0000000000000000000000000000FFFFFF000000000012D1C70012D1C7000000
      000090FFFF008EC5C5000000000000000000FFFFFF00FFFFFF00FFEDD1000000
      0000FFFFFF00FFEDD100000000000B898200000000000000000012D0C00019E3
      D20028E3D90028E3D90028E3D90028E3D90028E3D90012D1C70012D0C00011B5
      AC0011ADA50012A49B000B898200000000000000000000000000000000000000
      000000000000000000000000000010D6C6000000000000010700000107000001
      07000001070028E3D9000001070000000000000000000000000000000000088C
      840000000000000000000000000000000000000000000000000012D1C7000000
      0000FFFFFF00FFEDD10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFF
      FF00FFEDD100000000000B89820000000000000000000000000000000000FFFF
      FF00905B2A000000000000000000FFFFFF00FFFFFF008EC5C500000000000000
      0000000000000000000000000000000000000000000000000000000000000B89
      8200000000000000000012D1C70019E3D20028E3D90038E3D90038E3D90038E3
      D90028E3D90019E3D20012D0C00011BEB50011ADA5000B9C93000B8982000000
      00000000000000000000000000000000000000000000000000000000000010D6
      C60028E3D90028E3D90028E3D90028E3D90028E3D90028E3D90028E3D90010D6
      C60011BEB50010A59C0010A59C00088C84000000000000000000000000000000
      0000000000000000000012D1C70000000000FFFFFF00FFEDD10000000000FFFF
      FF00FFFFFF00FFEDD10000000000FFFFFF00FFEDD100000000000B8982000000
      0000000000000000000000000000FFFFFF00905B2A00FFFFFF00FFFFFF00FFFF
      FF0090FFFF008EC5C5000000000047EDE40038E3D90028E3D90019E3D20012D0
      C00011BEB50011ADA5000B9C93000B898200000000000000000012D1C70019E3
      D20038E3D900000000000000000038E3D90028E3D90019E3D200000000000000
      000011ADA50012A49B000B898200000000000000000000000000000000000000
      00000000000000000000000000000000000028E3D90028E3D90028E3D90028E3
      D90028E3D90028E3D90028E3D90010D6C60011BEB50010A59C0010A59C000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20000000000FFEDD10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFF
      FF000000000012A49B000000000000000000000000000000000000000000FFFF
      FF00BFBFBF00FFFFFF00905B2A0090FFFF00905B2A008EC5C5000000000038E3
      D9000000000028E3D9000000000012D1C70011BEB5000000000012A49B000000
      000000000000000000000000000019E3D20028E3D900000000000000000038E3
      D90028E3D90019E3D200000000000000000011ADA50012A49B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20028E3D90028E3D90028E3D90028E3D90028E3D90019E3D20010D6
      C60011BEB50011ADA500089C9400000000000000000000000000000000000000
      000000000000000000000000000019E3D20028E3D9000000000000000000FFFF
      FF00FFFFFF00FFEDD100000000000000000011ADA5000B9C9300000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00905B2A00FFFF
      FF00905B2A008EC5C500000000000000000028E3D90028E3D90019E3D2000000
      00000000000011ADA5000B9C93000000000000000000000000000000000019E3
      D20028E3D90028E3D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5
      AC0011ADA5000B9C930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000019E3D20019E3D20028E3
      D90019E3D20019E3D20010D6C60011BEB50011B5AC0010A59C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20019E3D200000000000000000000000000000000000000000011B5
      AC0012A49B00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0090FFFF00905B2A0090FFFF00905B2A008EC5C5000000000028E3
      D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B00000000000000
      00000000000000000000000000000000000019E3D20019E3D20028E3D90019E3
      D20019E3D20012D1C70011BEB50011B5AC0012A49B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000010D6C60010D6C60010D6C60011BEB50011B5
      AC00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012D1C70012D0
      C00012D0C00011BEB50011B5AC00000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00905B2A00FFFF
      FF00905B2A008EC5C5000000000012D1C70012D0C00012D0C00011BEB50011B5
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000012D1C70012D0C00012D0C00011BEB50011B5AC000000
      00000000000000000000000000006C6C6C000B0B0B002C2C2D00ADC0B6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0090FFFF00905B2A0090FFFF00905B2A008EC5C500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005858
      5800000000001C1A1D00A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF004545FF002A2A900090FFFF00FFFF
      FF0090FFFF008EC5C50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF00A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000090FF
      FF002A2A90002A2A9000FFFFFF0090FFFF00FFFFFF008EC5C500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008EC5C5008EC5C5008EC5C5008EC5C5008EC5
      C5008EC5C5008EC5C50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF006C6C6C00494A
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF002C2C2D00BFBFBF003F4F4F002F3F3F009CADAD002F47
      47008AB6B6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000939C9C00ADC0B6009CADAD0093A5AD0093B6B60000000000000000000000
      0000000000000B8982000B8982000B8982000B8982000B817A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000707A7A00707A7A00707A7A00707A7A00707A7A00707A7A00707A7A00707A
      7A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B8982000B8982000B89
      82000B8982000B817A0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B8982000B89
      82000B8982000B8982000B817A00000000000000000000000000000000000000
      0000000000000000000000000000000000002838380028383800283838002F47
      470082A5AD00000000000000000012A49B000B9C930012A49B000B9C930012A4
      9B000B9289000B8982000B8982000A7A70000000000000000000000000000000
      000000000000000000000000000000000000707A7A00707A7A00707A7A00707A
      7A00707A7A00707A7A00707A7A00707A7A000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000012A4
      9B000B9C930012A49B000B9C930012A49B000B9289000B8982000B8982000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      000012A49B000B9C930012A49B000B9C930012A49B000B9289000B8982000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      00003F5858003F584F00213B39002F58580069ADB2000000000012A49B0011AD
      A50011ADA50011ADA50011ADA50011ADA50012A49B0012A49B000B8982000B89
      82000A7A7000000000000000000000000000000000000000000000000000707A
      7A00707A7A00707A7A00707A7A00707A7A00707A7A00707A7A00707A7A00707A
      7A00707A7A000000000000000000000000000000000000000000000000000000
      0000000000000000000012A49B0011ADA50011ADA50011ADA500000093000000
      9300000093000B9C93000B9289000B817A000A7A700000000000000000000000
      000000000000000000000000000012A49B0011ADA50011ADA500000000000000
      00000000000000000000000000000B9289000B8982000A7A7000000000000000
      0000000000000000000000000000000000008A9C9C008CADA50093ADAD00709E
      9E0069ADB2000000000000000000000000000000000011BEB50011BEB50011B5
      AC0011B5AC0012A49B0012A49B000B8982000B89820000000000000000000000
      0000000000000000000000000000707A7A00707A7A0000000000707A7A00707A
      7A00707A7A00707A7A0000000000707A7A00707A7A0000000000000000000000
      000000000000000000000000000000000000000000000000000011B5AC0011B5
      AC0011BEB5000000930000009C000000B90000009C00000093000B9C93000B92
      89000B89820000000000000000000000000000000000000000000000000011B5
      AC0011B5AC000000000011BEB50011BEB50011B5AC0011B5AC0011ADA5000000
      00000B9289000B817A0000000000000000000000000000000000000000000000
      00003B4F47002A473F008AADAD001E4749008AC0D1000000000011BEB50012D0
      C00012D1C700000000000000000012D0C00011BEB50011B5AC0011ADA5000B9C
      93000B8982000B817A0000000000000000000000000000000000000000000000
      000000000000707A7A00707A7A00707A7A00707A7A00707A7A00707A7A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000011B5AC0011BEB500000000000000000000000000000000000000
      0000000000000000000000000000000000000B8982000B817A00000000000000
      0000000000000000000011B5AC0011BEB50012D0C00012D1C70012D0C00012D1
      C70012D0C00011BEB50011B5AC0011ADA5000B9C93000B8982000B817A000000
      000000000000000000000000000000000000384F4F002A473F008AADAD001E47
      49007AA5B6000000000012D1C70019E3D20019E3D20019E3D20019E3D20019E3
      D20012D0C00011BEB50011B5AC0012A49B000B9289000B898200000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000011BEB5000000000019E3
      D20019E3D20019E3D20028E3D90012D1C70012D1C70011BEB50011B5AC0012A4
      9B00000000000B8982000000000000000000000000000000000011BEB50012D1
      C70019E3D20019E3D20019E3D20019E3D20012D1C70012D1C70011BEB50011B5
      AC0012A49B000B9289000B898200000000000000000000000000000000000000
      00007A9393008CADA5009CC0C000709E9E006EADC6000000000019E3D20028E3
      D90028E3D90028E3D90028E3D90019E3D20019E3D20012D0C00011B5AC0011AD
      A50012A49B000B8982000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000012D0C00019E3D20028E3D90028E3D90028E3D90028E3D90019E3
      D20019E3D20012D0C00011B5AC0011ADA50012A49B000B898200000000000000
      0000000000000000000012D0C00019E3D20028E3D90028E3D90028E3D90028E3
      D90019E3D20019E3D20012D0C00011B5AC0011ADA50012A49B000B8982000000
      000000000000000000000000000000000000283F3F002F4F4F001A3F38001E47
      490069ADB2000000000028E3D90028E3D90038E3D90038E3D90038E3D90038E3
      D90019E3D20012D0C00011BEB50011ADA50012A49B000B898200000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000012D1C70019E3D20038E3
      D90038E3D90038E3D90038E3D90038E3D90019E3D20012D0C00011BEB50011AD
      A50012A49B000B8982000000000000000000000000000000000012D1C70028E3
      D90028E3D90038E3D90038E3D90038E3D90038E3D90019E3D20012D0C00011BE
      B50011ADA5000B9C93000B898200000000000000000000000000000000000000
      0000213B3900284747001A3F3F001E47490069ADB2000000000019E3D2000000
      00000000000047EDE40038E3D90028E3D90019E3D20012D1C70011BEB50011AD
      A5000B9C93000B89820000000000000000000000000000000000607068006070
      6800FFFFFF00FFFFFF0068606000AEAEAE00AEAEAE0068606000FFFFFF00FFFF
      FF00607068006070680000000000000000000000000000000000000000000000
      00000000000012D1C70019E3D20028E3D900000000000000000038E3D90028E3
      D90019E3D200000000000000000011ADA5000B9C93000B898200000000000000
      0000000000000000000012D1C70019E3D20028E3D900000000000000000038E3
      D90028E3D90019E3D200000000000000000011ADA50012A49B000B8982000000
      00000000000000000000000000000000000093B6B6008AADAD0082B2B20082B2
      B20069ADB2000000000019E3D20028E3D900000000000000000038E3D90028E3
      D90019E3D20012D0C00011BEB50011ADA50012A49B0000000000000000000000
      00000000000000000000607068000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000060706800000000000000
      000000000000000000000000000000000000000000000000000019E3D20028E3
      D900000000000000000038E3D90028E3D90019E3D200000000000000000011AD
      A50012A49B0000000000000000000000000000000000000000000000000019E3
      D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3D20012D0C00011BE
      B50011ADA50012A49B0000000000000000000000000000000000000000000000
      0000213B39001A3F38008AADAD00123A3C008EC5C5000000000019E3D20028E3
      D90028E3D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5AC0011AD
      A5000B9C93000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000019E3D20028E3D90028E3D90028E3D90028E3D90028E3
      D90028E3D90012D1C70011BEB50011ADA5000B9C930000000000000000000000
      000000000000000000000000000019E3D20028E3D90028E3D90028E3D90028E3
      D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C9300000000000000
      0000000000000000000000000000000000002A473F002F4F47008CADA5001A3F
      3F00709E9E00000000000000000019E3D20019E3D20028E3D90019E3D20019E3
      D20012D1C70011BEB50011B5AC0012A49B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A4
      9B00000000000000000000000000000000000000000000000000000000000000
      000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5
      AC0012A49B000000000000000000000000000000000000000000000000000000
      000093A5A5008A9C9C008CADA5009CB6B60093A5AD0000000000000000000000
      00000000000012D1C70012D0C00012D0C00011BEB50011B5AC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A688100000000000000000012D1C70012D0C00012D0
      C00011BEB50011B5AC0000000000000000004A68810000000000000000000000
      000000000000000000000000000000000000000000000000000012D1C70012D0
      C00012D0C00011BEB50011B5AC00000000000000000000000000000000000000
      000000000000000000000000000000000000494A4A00384747002F3F3F003B4F
      4700A5B6B6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A68
      8100000000000000000000000000000000000000000000000000000000004A68
      8100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B218A000B218A000B218A000B2182000B21
      8200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F6F6F6000B81
      7A000B8982000B8982000B817A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B8982000B8982000B8982000B8982000B817A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B8982000B8982000B8982000B8982000B81
      7A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001228A5000B289C000000
      0000000000000000000000000000000000000B2182000B218200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B9C93009CD1D100F6F6F6009CD1D1000B9289000B9C93000B8982000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      0000000000000000000012A49B000B9C930012A49B000B9C930012A49B000B92
      89000B8982000B8982000A7A7000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012A49B000B9C930012A4
      9B000B9C930012A49B000B9289000B8982000B8982000A7A7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001228A5001228AD0000000000F6F6F600F6F6F600FFFFFF00F6F6F600F6F6
      F600000000000B2182000B217A00000000000000000000000000000000000000
      000000000000000000000000000012A49B009CD1D100D1D1E400F6F6F600D1D1
      E4009CD1D10000000000000000000B9289000B817A000A7A7000000000000000
      0000000000000000000000000000000000000000000012A49B0011ADA50011AD
      A50000000000000000000000000000000000000000000B9289000B817A000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      000012A49B0011ADA50011ADA50011ADA50011ADA50011ADA50012A49B0012A4
      9B000B8982000B8982000A7A7000000000000000000000000000000000000000
      000000000000000000000000000000000000122FB60000000000D1D1D100D1D1
      D100F6F6F600F6F6F600F6F6F600D1D1D100D1D1D100000000000B2182000000
      000000000000000000000000000000000000000000000000000000000000F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F6000000
      00000B9289000B89820000000000000000000000000000000000000000000000
      00000000000011B5AC0011B5AC000000000011BEB50011BEB50011B5AC0011B5
      AC0011ADA500000000000B9289000B8982000000000000000000000000000000
      00000000000000000000000000000000000011B5AC0011B5AC000000000011BE
      B50011BEB50011B5AC0011B5AC0012A49B00000000000B9289000B817A000000
      000000000000000000000000000000000000000000000000000000000000122F
      C00000000000AEAEAE0000000000000000000000000000000000000000000000
      000000000000AEAEAE00000000000B2182000000000000000000000000000000
      0000000000000000000011B5AC0011BEB5009CD1D100D1D1E400F6F6F600D1D1
      E4009CD1D100000000000000000000000000000000000B8982000B817A000000
      00000000000000000000000000000000000011B5AC0011BEB5000000000012D1
      C70012D0C00012D1C70012D0C00011BEB50011B5AC0011ADA500000000000B89
      82000B817A0000000000000000000000000000000000000000000000000011B5
      AC0011BEB50012D0C00012D1C700000000000000000000000000000000000000
      000011ADA5000B9C93000B8982000B817A000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001D3DE4001D3D
      E4001D3DE4001238D1001238D100122FC000122FB60000000000000000000000
      000000000000000000000000000000000000000000000000000011BEB50012D1
      C700000000009CD1D100F6F6F6009CD1D10012D1C70012D1C70011BEB50011B5
      AC00000000000B9289000B898200000000000000000000000000000000000000
      000011BEB50012D1C70019E3D20019E3D20019E3D20019E3D20019E3D20012D1
      C70011BEB50011B5AC0012A49B000B9289000B89820000000000000000000000
      000000000000000000000000000011BEB50012D1C70019E3D20019E3D20019E3
      D20019E3D20019E3D20012D0C00011BEB50011B5AC0012A49B000B9289000B89
      8200000000000000000000000000000000000000000000000000000000001238
      D100000000001D3DE4002847E4002847E4002847E4002847E4001D3DE400122F
      C000122FC0001228AD00000000000B218A000000000000000000000000000000
      0000000000000000000012D0C00019E3D20028E3D90028E3D900F6F6F60028E3
      D90019E3D20019E3D20012D0C00011B5AC0011ADA50012A49B000B8982000000
      00000000000000000000000000000000000012D0C00019E3D20028E3D90028E3
      D90028E3D90028E3D90028E3D90012D1C70012D0C00011B5AC0011ADA50012A4
      9B000B89820000000000000000000000000000000000000000000000000012D0
      C00019E3D20028E3D90028E3D90028E3D90028E3D90028E3D90012D1C70012D0
      C00011B5AC0011ADA50012A49B000B8982000000000000000000000000000000
      00000000000000000000000000001238D1001D3DE4002847E400000000000000
      0000000000002847E400000000000000000000000000122FB6000B289C000B21
      8A0000000000000000000000000000000000000000000000000012D1C70019E3
      D20028E3D90038E3D900F6F6F60038E3D90028E3D90019E3D20012D0C00011BE
      B50011ADA5000B9C93000B898200000000000000000000000000000000000000
      000012D1C70019E3D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3
      D20012D0C00011BEB50011ADA5000B9C93000B89820000000000000000000000
      000000000000000000000000000012D1C70019E3D20038E3D900000000000000
      000038E3D90028E3D90028E3D900000000000000000011ADA50012A49B000B89
      8200000000000000000000000000000000000000000000000000000000001238
      D1001D3DE4002847E40000000000000000003858E4002847E4001D3DE4000000
      0000000000001228AD001228A5000B218A000000000000000000000000000000
      0000000000000000000012D1C70019E3D20038E3D90000000000F6F6F60038E3
      D90028E3D90019E3D200000000000000000011ADA50012A49B000B8982000000
      00000000000000000000000000000000000012D1C70019E3D20038E3D9000000
      00000000000038E3D90028E3D90019E3D200000000000000000011ADA50012A4
      9B000B89820000000000000000000000000000000000000000000000000012D1
      C70019E3D20028E3D900000000000000000038E3D90028E3D90019E3D2000000
      00000000000011ADA5000B9C93000B8982000000000000000000000000000000
      0000000000000000000000000000000000001D3DE40000000000000000003858
      E4003858E4002847E4001D3DE4001238D10000000000000000000B289C000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20028E3D900000000000000000038E3D90028E3D90019E3D200000000000000
      000011ADA50012A49B0000000000000000000000000000000000000000000000
      00000000000019E3D20028E3D900000000000000000038E3D90028E3D90019E3
      D200000000000000000011ADA50012A49B000000000000000000000000000000
      00000000000000000000000000000000000019E3D2000000000038E3D90038E3
      D90038E3D90028E3D90019E3D20012D0C00011BEB5000000000012A49B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001D3DE4001D3DE4002847E4002847E4002847E4002847E4001D3DE400122F
      C000122FC0001228AD001228A500000000000000000000000000000000000000
      000000000000000000000000000019E3D20028E3D90028E3D90028E3D90028E3
      D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C9300000000000000
      0000000000000000000000000000000000000000000019E3D20028E3D90028E3
      D90028E3D90028E3D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C
      9300000000000000000000000000000000000000000000000000000000000000
      000019E3D20028E3D9000000000028E3D90028E3D90028E3D90019E3D20012D0
      C0000000000011ADA5000B9C9300000000000000000000000000000000000000
      000000000000000000000000000028C9C900000000001D3DE4001D3DE4001D3D
      E4001D3DE4001D3DE4001238D100122FC000122FB6001228A5000000000028C9
      C900000000000000000000000000000000000000000000000000000000000000
      000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5
      AC0012A49B000000000000000000000000000000000000000000000000000000
      0000000000000000000019E3D20019E3D20028E3D90019E3D20019E3D20012D1
      C70011BEB50011B5AC0012A49B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000019E3D20019E3D2000000
      000028E3D90019E3D20012D1C7000000000011B5AC0012A49B00000000000000
      000000000000000000000000000000000000000000000000000012C0C00070E4
      E400059C9C0000000000000000001238D1001238D100122FD100122FC000122F
      B6000000000000000000059C9C0070E4E40012C0C00000000000000000000000
      000000000000000000000000000000000000000000000000000012D1C70012D0
      C00012D0C00011BEB50011B5AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012D1C70012D0C00012D0C00011BEB50011B5AC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012D1C70012D0C00012D0C00011BEB50011B5
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000070E4E400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000070E4E4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000B900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000B9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000B9000000B9000000B900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000B900000000000000B900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000B9000000B9000000B9000000B9000000
      B900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000B9000000
      B900000000000000B9000000B900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      B9000000B9000000B9000000B9000000B9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B9000000B900000000000000B9000000B9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000B900000000000000B9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      B900000000000000B90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B89
      82000B8982000B8982000B8982000B817A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B8982000B8982000B8982000B8982000B817A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B8982000B8982000B89
      82000B8982000B817A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B8982000B8982000B8982000B8982000B817A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000012A49B000B9C930012A49B000B9C930012A49B000B9289000B89
      82000B8982000A7A700000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012A49B000B9C930012A49B000B9C
      930012A49B000B9289000B8982000B8982000A7A700000000000000000000000
      00000000000000000000000000000000000000000000000000000000000012A4
      9B000B9C930012A49B000B9C930012A49B000B9289000B8982000B8982000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000012A49B000B9C930012A49B000B9C930012A49B000B92
      89000B8982000B8982000A7A7000000000000000000000000000000000000000
      00000000000000000000000000000000000012A49B0011ADA50011ADA50011AD
      A50011ADA50011ADA50000000000000000000B9289000B8982000A7A70000000
      00000000000000000000000000000000000000000000000000000000000012A4
      9B0011ADA50011ADA50011ADA50011ADA50011ADA50012A49B0012A49B000B89
      82000B8982000A7A700000000000000000000000000000000000000000000000
      0000000000000000000012A49B0011ADA50011ADA50011ADA50011ADA50011AD
      A50012A49B0012A49B000B8982000B8982000A7A700000000000000000000000
      0000000000000000000000000000000000000000000012A49B0011ADA50011AD
      A50000000000000000000000000000000000000000000B9289000B817A000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      000011B5AC0011B5AC000000000011BEB50011BEB5000000000011B5AC0012A4
      9B00000000000B9289000B817A00000000000000000000000000000000000000
      000000000000000000000000000011B5AC0011B5AC000000000011BEB50011BE
      B50011B5AC0011B5AC0012A49B00000000000B9289000B817A00000000000000
      000000000000000000000000000000000000000000000000000011B5AC0011B5
      AC000000000011BEB50011BEB50011B5AC0011B5AC0012A49B00000000000B92
      89000B817A000000000000000000000000000000000000000000000000000000
      00000000000011B5AC0011B5AC0011BEB50011BEB50011BEB50011B5AC0011B5
      AC0011ADA500000000000B9289000B8982000000000000000000000000000000
      000000000000000000000000000011B5AC0011BEB50012D0C00012D1C7000000
      00000000000012D0C00011BEB50011B5AC0011ADA5000B9C93000B8982000B81
      7A0000000000000000000000000000000000000000000000000011B5AC0011BE
      B50012D0C00012D1C700000000000000000000000000000000000000000011AD
      A5000B9C93000B8982000B817A00000000000000000000000000000000000000
      00000000000011B5AC0011BEB50012D0C00012D1C70000000000000000000000
      0000000000000000000011ADA5000B9C93000B8982000B817A00000000000000
      00000000000000000000000000000000000011B5AC0011BEB50012D0C00012D1
      C70012D0C00012D1C70012D0C00011BEB50011B5AC0011ADA5000B9C93000B89
      82000B817A0000000000000000000000000000000000000000000000000011BE
      B50012D1C70019E3D20019E3D20019E3D20019E3D20019E3D20012D1C70011BE
      B50011B5AC0012A49B000B9289000B8982000000000000000000000000000000
      0000000000000000000011BEB50012D1C70019E3D20019E3D20019E3D20019E3
      D20019E3D20012D0C00011BEB50011B5AC0012A49B000B9289000B8982000000
      0000000000000000000000000000000000000000000011BEB50012D1C70019E3
      D20019E3D20019E3D20019E3D20019E3D20012D0C00011BEB50011B5AC0012A4
      9B000B9289000B89820000000000000000000000000000000000000000000000
      000011BEB50012D1C70019E3D200000000000000000019E3D20019E3D20012D1
      C700000000000000000012A49B000B9289000B89820000000000000000000000
      000000000000000000000000000012D0C00019E3D20028E3D90028E3D90028E3
      D90028E3D90028E3D90012D1C70012D0C00011B5AC0011ADA50012A49B000B89
      820000000000000000000000000000000000000000000000000012D0C00019E3
      D20028E3D90028E3D90028E3D90028E3D90028E3D90012D1C70012D0C00011B5
      AC0011ADA50012A49B000B898200000000000000000000000000000000000000
      00000000000012D0C00019E3D200FF36360028E3D90028E3D90028E3D90028E3
      D90012D1C70012D0C00011B5AC0011ADA50012A49B000B898200000000000000
      00000000000000000000000000000000000012D0C00019E3D20000000000FFED
      D100FFEDD1000000000028E3D90000000000FFEDD100FFEDD100000000000B9C
      93000B89820000000000000000000000000000000000000000000000000012D1
      C70019E3D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3D20012D0
      C00011BEB50011ADA5000B9C93000B8982000000000000000000000000000000
      0000000000000000000012D1C70019E3D20038E3D900000000000000000038E3
      D90028E3D90028E3D900000000000000000011ADA50012A49B000B8982000000
      0000000000000000000000000000000000000000000012D1C70019E3D20038E3
      D900000000000000000038E3D90028E3D90028E3D900000000000000000011AD
      A50012A49B000B89820000000000000000000000000000000000000000000000
      000012D1C70000000000FFEDD100FFFFFF00FFFFFF00FFEDD10000000000FFED
      D100FFFFFF00FFFFFF00FFEDD100000000000B89820000000000000000000000
      000000000000000000000000000012D1C70019E3D20038E3D900000000000000
      000038E3D90028E3D90019E3D200000000000000000011ADA50012A49B000B89
      820000000000000000000000000000000000000000000000000012D1C70019E3
      D20028E3D900000000000000000038E3D90028E3D90019E3D200000000000000
      000011ADA5000B9C93000B898200000000000000000000000000000000000000
      00000000000012D1C70019E3D20028E3D900000000000000000038E3D90028E3
      D90019E3D200000000000000000011ADA5000B9C93000B898200000000000000
      00000000000000000000000000000000000012D1C70000000000FFEDD1000000
      000000000000FFEDD10000000000FFEDD1000000000000000000FFEDD1000000
      00000B8982000000000000000000000000000000000000000000000000000000
      000019E3D20028E3D900000000000000000038E3D90028E3D90019E3D2000000
      00000000000011ADA50012A49B00000000000000000000000000000000000000
      000000000000000000000000000019E3D2000000000038E3D90038E3D90038E3
      D90028E3D90019E3D20012D0C00011BEB5000000000012A49B00000000000000
      000000000000000000000000000000000000000000000000000019E3D2000000
      000038E3D90038E3D90038E3D90028E3D90019E3D20012D0C00011BEB5000000
      000012A49B000000000000000000000000000000000000000000000000000000
      00000000000019E3D2000000000000000000000000000000000028E3D9000000
      000000000000000000000000000012A49B000000000000000000000000000000
      00000000000000000000000000000000000019E3D20028E3D90028E3D90028E3
      D90028E3D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C93000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20028E3D9000000000028E3D90028E3D90028E3D90019E3D20012D0C0000000
      000011ADA5000B9C930000000000000000000000000000000000000000000000
      0000000000000000000019E3D20028E3D9000000000028E3D90028E3D90028E3
      D90019E3D20012D0C0000000000011ADA5000B9C930000000000000000000000
      0000000000000000000000000000000000000000000019E3D20028E3D9000000
      0000494A4A0028E3D90028E3D90019E3D20000000000494A4A0011ADA5000B9C
      9300000000000000000000000000000000000000000000000000000000000000
      00000000000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BE
      B50011B5AC0012A49B0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000019E3D20019E3D2000000000028E3
      D90019E3D20012D1C7000000000011B5AC0012A49B0000000000000000000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20019E3D2000000000028E3D90019E3D20012D1C7000000000011B5AC0012A4
      9B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000019E3D20019E3D20028E3D90019E3D20019E3D20012D1
      C70011BEB50011B5AC0012A49B00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000012D1
      C70012D0C00012D0C00011BEB50011B5AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000012D1C70012D0C00012D0C00011BEB50011B5AC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012D1C70012D0C00012D0
      C00011BEB50011B5AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012D1C70012D0C00012D0C00011BEB50011B5AC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B8982000B8982000B8982000B8982000B81
      7A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B8982000B89
      82000B8982000B8982000B817A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000B218A000B218A000B218A000B2182000B218200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000B8982000B8982000B8982000B89
      82000B817A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012A49B000B9C930012A4
      9B000B9C930012A49B000B9289000B8982000B8982000A7A7000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012A49B000B9C930012A49B000B9C930012A49B000B9289000B8982000B89
      82000A7A70000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001228A5000B289C001228A5000B289C001228
      A5000B2193000B218A000B2182000B217A000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012A49B000B9C
      930012A49B000B9C930012A49B000B9289000B89820010838A0010737B000102
      0F00000000000000000000000000000000000000000000000000000000000000
      000012A49B0011ADA50011ADA50011ADA5000000930000009300000093000B9C
      93000B9289000B817A000A7A7000000000000000000000000000000000000000
      000000000000000000000000000012A49B0011ADA50011ADA500000000000000
      00000000000000000000000000000B9289000B817A000A7A7000000000000000
      00000000000000000000000000000000000000000000000000001228A5001228
      AD00122FB6001228AD00122FB6001228AD001228A5001228A5000B218A000B21
      8A000B217A000000000000000000000000000000000000000000000000000000
      00000000000012A49B0016A3AA0016A3AA0001020F0000000000000000000000
      0000000000001483990014758B00146E84000000000000000000000000000000
      00000000000000000000000000000000000011B5AC0011B5AC0011BEB5000000
      930000009C000000B90000009C00000093000B9C93000B9289000B8982000000
      00000000000000000000000000000000000000000000000000000000000011B5
      AC0011B5AC000000000011BEB50011BEB50011B5AC0011B5AC0011ADA5000000
      00000B9289000B89820000000000000000000000000000000000000000000000
      00000000000000000000122FB60000000000122FC000122FC000122FC000122F
      C000122FB6001228A5001228A500000000000B21820000000000000000000000
      000000000000000000000000000000000000000000001C98B500287AC3001D1D
      62002292C30011BEB50011B5AC0011B5AC001C8EAE0014144D00226DAD00147D
      92000000000000000000000000000000000000000000000000000000000011B5
      AC0011BEB5000000000000000000000000000000000000000000000000000000
      000000000000000000000B8982000B817A000000000000000000000000000000
      0000000000000000000011B5AC0011BEB50012D0C00012D1C70012D1C70012D0
      C00012D0C00011BEB50011B5AC0011ADA5000B9C93000B8982000B817A000000
      00000000000000000000000000000000000000000000122FC000122FC000122F
      C000000000001238D1001238D100122FD100122FC000122FB600000000001228
      A5000B2182000B21820000000000000000000000000000000000000000000000
      000016A3AA00287AC3002D2D9B00336CD8002888CF0012D1C70012D0C00011BE
      B5001C98B500287AC30025257F00226DAD001871910000000000000000000000
      000000000000000000000000000011BEB5000000000019E3D20019E3D20019E3
      D20028E3D90012D1C70012D1C70011BEB50011B5AC0012A49B00000000000B89
      820000000000000000000000000000000000000000000000000011BEB50012D1
      C70019E3D20019E3D20019E3D20028E3D90012D1C70012D1C70011BEB50011B5
      AC0012A49B000B9289000B898200000000000000000000000000000000000000
      000000000000122FC0001238D1001D3DE4001D3DE40000000000000000000000
      00000000000000000000122FB6001228A5000B289C000B218200000000000000
      00000000000000000000000000000000000016B3B9002888CF003664D9003664
      D9002F83D70019E3D20019E3D20012D1C7001D9FBF002E68C9002E5FC2002E5F
      C2001878980000000000000000000000000000000000000000000000000012D0
      C00019E3D20028E3D90028E3D90028E3D90028E3D90019E3D20019E3D20012D0
      C00011B5AC0011ADA50012A49B000B8982000000000000000000000000000000
      0000000000000000000012D0C00019E3D20028E3D900000000000000000028E3
      D90028E3D90019E3D200000000000000000011ADA50012A49B000B8982000000
      000000000000000000000000000000000000000000001238D1001D3DE4002847
      E4002847E4002847E4002847E4002847E4001238D1001238D100122FB600122F
      B6000B289C000B218A0000000000000000000000000000000000000000000000
      00001AB5C4002F9CD800336CD800377DDA002F9CD80028E3D90028E3D90012D1
      C70012D0C000287AC3002E68C9002E5FC2001878980000000000000000000000
      000000000000000000000000000012D1C70019E3D20038E3D90038E3D90038E3
      D90038E3D90038E3D90019E3D20012D0C00011BEB50011ADA50012A49B000B89
      820000000000000000000000000000000000000000000000000012D1C70019E3
      D2002C2C2D00494A4A000000000000000000000000002C2C2D00494A4A000000
      0000000000000B9C93000B898200000000000000000000000000000000000000
      0000000000001238D1001D3DE4002847E4003858E4003858E4003858E4002847
      E4001D3DE4001238D100122FC0001228AD001228A5000B218A00000000000000
      00000000000000000000000000000000000016C2CB0021C4D4002F9CD8003BAD
      DA003ABFDA0038E3D90028E3D90019E3D20012D0C0002292C300267CBD00226D
      AD0010838A0000000000000000000000000000000000000000000000000012D1
      C70019E3D20028E3D90038E3D90047EDE40038E3D90028E3D90019E3D20012D1
      C70011BEB50011ADA5000B9C93000B8982000000000000000000000000000000
      000000000000000000000000000000000000000000002C2C2D00494A4A000000
      000028E3D900000000002C2C2D00494A4A000000000000000000000000000000
      000000000000000000000000000000000000000000001238D1001D3DE4002847
      E40000000000000000003858E4002847E4001D3DE40000000000000000001228
      AD001228A5000B218A0000000000000000000000000000000000000000000000
      000016C2CB0021C4D4003ABFDA0001020F000000000038E3D90028E3D90019E3
      D2000000000001020F001C8EAE001C8EAE00147D920000000000000000000000
      00000000000000000000000000000000000019E3D2000000000038E3D90038E3
      D90038E3D90028E3D90019E3D20012D0C00011BEB5000000000012A49B000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20028E3D900000000002C2C2D0038E3D90028E3D90019E3D200000000002C2C
      2D0011ADA50012A49B0000000000000000000000000000000000000000000000
      000000000000000000001D3DE4002847E40000000000000000003858E4000000
      00001D3DE4000000000000000000122FB6000B289C0000000000000000000000
      0000000000000000000000000000000000000000000019E3D20028E3D9000000
      00000000000038E3D90028E3D90019E3D20000000000000000001C98B5001C8E
      AE000A0A22000000000000000000000000000000000000000000000000000000
      000019E3D20028E3D90000000000000000000000000028E3D900000000000000
      00000000000011ADA5000B9C9300000000000000000000000000000000000000
      000000000000000000000000000019E3D20028E3D90028E3D90028E3D90028E3
      D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C9300000000000000
      00000000000000000000000000000000000000000000000000001D3DE4001D3D
      E4002847E4002847E400000000001D3DE400000000001238D100122FB6001228
      AD001228A5000000000000000000000000000000000000000000000000000000
      00000000000019E3D20028E3D90028E3D90028E3D90028E3D90028E3D90019E3
      D20012D0C00011B5AC0016A3AA0010939A0001020F0000000000000000000000
      0000000000000000000000000000000000000000000019E3D20019E3D20028E3
      D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5
      AC0012A49B000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001D3DE4001D3DE400000000001D3DE4001D3D
      E4001238D10000000000122FB6001228A5000000000000000000000000000000
      000000000000000000000000000000000000000000000000000019E3D20019E3
      D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A49B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012D1C70012D0C00012D0C00011BEB50011B5
      AC00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000012D1C70012D0
      C00012D0C00011BEB50011B5AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001238D1001238D100122FD100122FC000122FB600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000012D1C70012D0C00012D0C00011BE
      B50011B5AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B89
      82000B8982000B8982000B8982000B817A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000B8982000B8982000B8982000B8982000B817A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B8982000B8982000B89
      82000B8982000B817A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008A470B008A470B00934F0B0082470B0082470B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000012A49B000B9C930012A49B000B9C930012A49B000B9289000B89
      82000B8982000A7A700000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000B9C930012A49B00000000000000
      00000000000000000000000000000B8982000A7A700000000000000000000000
      00000000000000000000000000000000000000000000000000000000000012A4
      9B000B9C930012A49B000B9C930012A49B000B9289000B8982000B8982000A7A
      7000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5581200A55812009C580B0000000000000000000000
      00008A470B0082470B007A3F0B00000000000000000000000000000000000000
      00000000000000000000000000000000000012A49B0011ADA50011ADA5000000
      0000000000000000000000000000000000000B9289000B817A000A7A70000000
      00000000000000000000000000000000000000000000000000000000000012A4
      9B0011ADA5000000000000000000FFFFFF00FFFFFF00FFEDD100000000000000
      00000B8982000A7A700000000000000000000000000000000000000000000000
      0000000000000000000012A49B0011ADA50011ADA50000000000000000000000
      000000000000000000000B9289000B817A000A7A700000000000000000000000
      00000000000000000000000000000000000000000000A5581200AD601200AD60
      1200AD601200000000000000930000000000A5581200934F0B0082470B008247
      0B00000000000000000000000000000000000000000000000000000000000000
      000011B5AC0011B5AC000000000011BEB50011BEB50011B5AC0011B5AC0011AD
      A500000000000B9289000B898200000000000000000000000000000000000000
      000000000000000000000000000011B5AC0000000000FFEDD10000000000FFFF
      FF00FFFFFF00FFEDD10000000000FFFFFF00000000000B898200000000000000
      000000000000000000000000000000000000000000000000000011B5AC0011B5
      AC000000000011BEB50011BEB50011B5AC0011B5AC0011ADA500000000000B92
      89000B8982000000000000000000000000000000000000000000000000000000
      000000000000B6601200C0681200C0681200C068120000000000000000000000
      0000AD601200A55812008A470B0082470B000000000000000000000000000000
      000000000000000000000000000011B5AC0011BEB5000000000012D1C70012D0
      C00012D1C70012D0C00011BEB50011B5AC0011ADA500000000000B8982000B81
      7A0000000000000000000000000000000000000000000000000011B5AC000000
      0000FFFFFF00FFEDD10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFF
      FF00FFEDD100000000000B817A00000000000000000000000000000000000000
      00000000000011B5AC0011BEB5000000000012D1C70012D0C00012D1C70012D0
      C00011BEB50011B5AC0011ADA500000000000B8982000B817A00000000000000
      000000000000000000000000000000000000C0681200C0681200C0681200D170
      1200D1701200000000000000000000000000C0681200A5581200A55812008A47
      0B0082470B0000000000000000000000000000000000000000000000000011BE
      B50012D1C70019E3D20019E3D20019E3D20019E3D20019E3D20012D1C70011BE
      B50011B5AC0012A49B000B9289000B8982000000000000000000000000000000
      0000000000000000000011BEB50000000000FFFFFF00FFEDD10000000000FFFF
      FF00FFFFFF00FFEDD10000000000FFFFFF00FFEDD100000000000B8982000000
      0000000000000000000000000000000000000000000011BEB50012D1C70019E3
      D20019E3D20019E3D20019E3D20012D1C70012D1C70011BEB50011B5AC0012A4
      9B000B9289000B817A0000000000000000000000000000000000000000000000
      0000C0681200D1701200E47C1B00E47C1B00E47C1B00E47C1B00D1701200D170
      1200C0681200AD601200A5581200934F0B008A470B0000000000000000000000
      000000000000000000000000000012D0C00019E3D20028E3D90028E3D90028E3
      D90028E3D90028E3D90012D1C70012D0C00011B5AC0011ADA50012A49B000B89
      820000000000000000000000000000000000000000000000000012D0C0000000
      0000FFFFFF00FFEDD10000000000FFFFFF00FFFFFF00FFEDD10000000000FFFF
      FF00FFEDD100000000000B898200000000000000000000000000000000000000
      00000000000012D0C00019E3D20028E3D90028E3D90028E3D90028E3D90028E3
      D90019E3D20011BEB50011BEB50011ADA50012A49B000B898200000000000000
      000000000000000000000000000000000000D1701200E47C1B00EDA55800EDA5
      5800EDA55800E47C1B00E47C1B00D1701200EDA55800EDA55800EDA55800934F
      0B008A470B0000000000000000000000000000000000000000000000000012D1
      C70019E3D20028E3D90038E3D90038E3D90038E3D90028E3D90019E3D20012D0
      C00011BEB50011ADA5000B9C93000B8982000000000000000000000000000000
      0000000000000000000012D1C700000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000B8982000000
      0000000000000000000000000000000000000000000012D1C70028E3D90028E3
      D90038E3D90038E3D90038E3D90028E3D90019E3D20012D1C70011BEB50011AD
      A5000B9C93000B89820000000000000000000000000000000000000000000000
      0000D1701200EDA55800FFFFFF00FFFFFF00FFFFFF00EDA55800E48A2800EDA5
      5800FFFFFF00FFFFFF00FFFFFF00EDA558008A470B0000000000000000000000
      000000000000000000000000000012D1C70019E3D20038E3D900000000000000
      000038E3D90028E3D90019E3D200000000000000000011ADA50012A49B000B89
      820000000000000000000000000000000000000000000000000012D1C70019E3
      D20028E3D90038E3D90047EDE40038E3D90028E3D90019E3D20012D0C00011BE
      B50011ADA5000B9C93000B898200000000000000000000000000000000000000
      00000000000012D1C70019E3D20028E3D90000000000000000000000000028E3
      D90019E3D200000000000000000011ADA50012A49B000B898200000000000000
      000000000000000000000000000000000000D1701200EDA55800FFFFFF000000
      0000FFFFFF00EDA55800E48A2800EDA55800FFFFFF0000000000FFFFFF00EDA5
      580082470B000000000000000000000000000000000000000000000000000000
      000019E3D20028E3D900000000000000000038E3D90028E3D90019E3D2000000
      00000000000011ADA50012A49B00000000000000000000000000000000000000
      000000000000000000000000000019E3D2000000000038E3D90038E3D9000000
      000028E3D9000000000012D1C70011BEB5000000000012A49B00000000000000
      000000000000000000000000000000000000000000000000000019E3D2000000
      000038E3D90038E3D90038E3D9000000000019E3D200000000000000000011AD
      A50012A49B000000000000000000000000000000000000000000000000000000
      000000000000EDA55800FFFFFF00FFFFFF00FFFFFF00EDA55800E48A2800EDA5
      5800FFFFFF00FFFFFF00FFFFFF00EDA558000000000000000000000000000000
      00000000000000000000000000000000000019E3D20028E3D90028E3D90028E3
      D90028E3D90028E3D90019E3D20012D0C00011B5AC0011ADA5000B9C93000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20028E3D900000000000000000028E3D90028E3D90019E3D200000000000000
      000011ADA5000B9C930000000000000000000000000000000000000000000000
      0000000000000000000019E3D20028E3D90028E3D90028E3D90028E3D90028E3
      D90019E3D20012D0C00011B5AC0011ADA5000B9C930000000000000000000000
      00000000000000000000000000000000000000000000E47C1B00EDA55800EDA5
      5800EDA55800E48A2800E47C1B00E47C1B00EDA55800EDA55800EDA558009C4F
      0B00000000000000000000000000000000000000000000000000000000000000
      00000000000019E3D20019E3D20028E3D90019E3D20019E3D20012D1C70011BE
      B50011B5AC0012A49B0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000019E3D20019E3D20028E3D90019E3
      D20019E3D20012D1C70011BEB50011B5AC0012A49B0000000000000000000000
      00000000000000000000000000000000000000000000000000000000000019E3
      D20019E3D20028E3D90019E3D20019E3D20012D1C70011BEB50011B5AC0012A4
      9B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E47C1B00E47C1B00E47C1B00E47C1B00E47C1B00D170
      1200C0681200AD601200A5581200000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000012D1
      C70012D0C00012D0C00011BEB50011B5AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000012D1C70012D0C00012D0C00011BEB50011B5AC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012D1C70012D0C00012D0
      C00011BEB50011B5AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D1701200D1701200D1701200C0681200C068120000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000004C000000F700000001000100
      00000000940B00000000000000000000000000000000000000000000FFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FE207FC1FFF83F8000000000F830FF007FE00F8000000000F071FE00
      3FC0078000000000E063FC001F80038000000000E03FFC001F80038000000000
      C01FF8000F00018000000000C00078000F00018000000000C00078000F000180
      00000000C00078000F00018000000000C00078000F00018000000000E000FC00
      1F80038000000000E000FC001F80038000000000F001FE003FC0078000000000
      F803FF007FE00F8000000000FE0FFFC1FFF83F8000000000FFFFFFFFFFFFFF80
      00000000FFFFFFFFFFFFFF8000000000FFFFFFFFFFFFFF8000000000FFFFFFFF
      FFFFFF8000000000FC03FFFC7FFE0FFC1FF00000F001FFF83FF803F007F00000
      C001FFF83FF001E003F00000C000FFF83E0000C001F00000C000FFFC3C0000C0
      01F00000C0007C001C00000000F00000C00078000C00000000F00000C0007800
      0C00000000F00000C00078000C00000000F00000E000F8000C00000000F00000
      F0FFFC000E0000C001F00000F07FFC000F0000C001F00000F07FFE000F0001E0
      03F00000F07FFE003F0803F007700000F8FFFF00FF9E0FFC1FF00000FFFFFFFF
      FFFFFFFFFF700000FFFFFFFFFFFFFFFFFFB00000FFFFFFFFFFFFFFFFFEB00000
      FFFFFFFFFFFFFFFFFF700000FF83FFF07FF83F8707000000FE00FFC01FE00F80
      00000000FC007F800FC0078000000000F8003F00078003C00010000080003F00
      078003C00010000000001C00030001C00010000000001E00030001C000100000
      00001E00030001C00010000000001E00020000C00010000000001E00020000C0
      0010000000003E00060000C00010000000003C00060000C00010000000007800
      0E0000C0001000000000F0001E0000C0001000000083E0007E0000E000300000
      00FFFFDFFE0000F000700000FFFFFFEFFF0009FC01F00000FFFFFFFFFF8007FF
      FFF00000FFFFFFFFFFCC47FFFFF00000FF83FF807FF83FFF07F00000FE00FF00
      1FE00FFC01F00000FC007E000FC007F800F00000F8003C00078003F000700000
      80003800078003F00070000000001000030001E00030000000000000030001E0
      0030000000000000030001E00030000000000000030001E000300000F0000000
      030001E000300000B8003000078003F000700000D8003800078003F000700000
      DC007F800FC007F800F00000D600FFC01FE00FFC01F00000B783FFF07FF83FFF
      07F00000AFFFFFFFFFFFFFFFFFF00000AFFFFFFFFFFFFFFFFFF00000FBFFFFFF
      FFFFFFFFFFF00000FBFFFFFFFFFFFFFFFFF00000FE0FFFC1FFFE0FFC1FF00000
      F803FF007FF803F007F00000F001FE003FF001E003F00000E000FC001C6000C0
      01F00000E000FC001C0000C001F00000C00078000C00000000F0000080003800
      0C00000000F00000000018000C00000000F00000000010000E00000000F00000
      000000000E00000000F00000A000A000020000C001F00000E000F000060000C0
      01F00000F001F000060001E003F00000F803F800070003F004F00000FE0FFC00
      0F0E0FFC0CD00000FFFFFE001FFFFFFFF8700000FFFFFF003FFFFFFFD0200000
      FFFFFFC0FFFFFFFFF8700000FFFFFFFFFFFFFFFFECD00000FF83FFF07FFC1FFF
      07F00000FE00FFC01FF007FC01F00000FC007F800F8003F800F00000F0003E00
      070001F000700000E0003C00070001F000700000E0001C00030000E000300000
      80001000038000E00030000080001000038000E00030000030000600038000E0
      00300000F0001E00038000E000300000E0003C0007C001F000700000C0003800
      07C001F000700000C00078000FE003F800F000008000F0001FF007FC01F00000
      8083F0107FFC1FFF07F00000C1FFF83FFFFFFFFFFFF00000FFFFFFFFFFFFFFFF
      FFF00000FFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000FE0FFFC1
      FFFE0FFC1FF00000F803FF007FF803F007F00000F001FE003FF001E003F00000
      E000FC001FE000C001F00000E000FC001FE000C001F00000C00078000F800000
      00F00000C00078000C00000000F00000C00078000C00000000F00000C0007800
      0C00000000F00000C00078000C00000000F00000E000FC001C0000C001F00000
      E000FC001C0000C001F00000F001FE003C0001E003F00000F803FF007C0003F0
      06100000FE0FFFC1FC000FFC1E100000FFFFFFFFFC01FFFFFF900000FFFFFFFF
      FC01FFFFFF900000FFFFFFFFFC01FFFFFF800000FFFFFFFFFC01FFFFFF800000
      0783FF00FFF83FFC1FF000000600FE007FE00FF007F0000004007C003FC007E0
      03F0000000003C003F8003C001F0000000003C003F8003C001F0000000001C00
      3F00018000F0000000001C003F00018000F0000000001C003F00018000F00000
      000000000700018000F0000000000C003700018000F0000000002C00378003C0
      01F0000000003E007F8003C001F00000040078001E0000E0020000000600F000
      0C000070077000000783F1E78C00007C1FB00000FFFFF3FFCC07C07FFFD00000
      FFFFF9FF9E0FE0FFFE000000FFFFFDFFBF1FF1FFFFF00000FFFFFFFFFFFFFFFF
      FFF00000FE0FFFC1FFF07FFE0FF00000F803FF007FC01FF803F00000F001FE00
      3F800FF001F00000E000FC001F0007E000F00000E000FC001F0007E000F00000
      C00078000E0003C000700000C00078000E0003C000700000C00078000E0003C0
      00700000C00078000E0003C000700000C00078000E0003C000700000E000FC00
      1F0007E000F00000E000FC001F0007E000F00000E000FE003F800FF001F00000
      C0007F007FC01FF803F00000DE0F7FC1FFF07BFE0F700000FFFFFFFFFFFFF1FF
      FEB00000FFFFFFFFFFFFE0FFFC900000FFFFFFFFFFFFE0FFFC900000FFFFFFFF
      FFFFF5FFFEB00000FE0FFFC1FFF83FFF07F00000F803FF007FE00FFC01F00000
      F001FE003FC007F800F00000E000FC001F8003F000700000E000FC001F8003F0
      00700000C00078000F0001E000300000C00078000F0001E000300000C0007800
      0F0001E000300000C00078000F0001E000300000C00078000F0001E000300000
      E000FC001F8003F000700000E000FC001F8003F000700000F001FE003FC007F8
      00F00000F803FF007FE00FFC01F00000FE0FFFC1FFF83FFF07F00000FFFFFFFF
      FFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000
      FFFFFFFFFFFFFFFFFFF00000FE0FFFC1FFF83FFF07F00000F803FF007FE00FFC
      01F00000F001FE003FC007F800F00000E000FC001F8003F000700000E000FC00
      1F8003F000700000C00078000F0001E000300000C00078000F0001E000300000
      C00078000F0001E000300000C00078000F0001E000300000C00078000F0001E0
      00300000E000FC001F8003F000700000E000FC001F8003F000700000F001FE00
      3FC007F800F00000F803FF007FE00FFC01F00000FE0FFFC1FFF83FFF07F00000
      FFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFF
      FFF00000FFFFFFFFFFFFFFFFFFF00000FE0FFFC1FFF83FFF07F00000F803FF00
      7FE00FFC01F00000F001FE003FC007F800F00000E000FC001F8003F000700000
      E000FC001F8003F000700000C00078000F0001E000300000C00078000F0001E0
      00300000C00078000F0001E000300000C00078000F0001E000300000C0007800
      0F0001E000300000E000FC001F8003F000700000E000FC001F8003F000700000
      F001FE003FC007F800F00000F803FF007FE00FFC01F00000FE0FFFC1FFF83FFF
      07F00000FFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000FFFFFFFF
      FFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFF00000000000000000000000000000
      00000000000000000000}
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 176
    Top = 208
  end
  object OpenDialog1: TOpenDialog
    Left = 176
    Top = 240
  end
end
