object FormPublic: TFormPublic
  Left = 371
  Top = 248
  Width = 490
  Height = 298
  Caption = 'FormPublic'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBoxNewly: TListBox
    Left = 339
    Top = 70
    Width = 97
    Height = 77
    ItemHeight = 13
    TabOrder = 0
    Visible = False
  end
  object MainMenu1: TMainMenu
    BiDiMode = bdLeftToRight
    Images = ImageListMenu
    ParentBiDiMode = False
    Left = 192
    Top = 88
    object NFile: TMenuItem
      Caption = #25991#20214'(&F)'
      object NAddNew: TMenuItem
        Caption = #26032#24314'...'
        ImageIndex = 9
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NAddNewBlank: TMenuItem
          Caption = #31354#30333#39029
          ImageIndex = 9
          ShortCut = 16450
          OnClick = NAddNewBlankClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NAddNewHomePage: TMenuItem
          Caption = #20027#39029
          ShortCut = 16456
          OnClick = NAddNewHomePageClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCopyCurrentPage: TMenuItem
          Caption = #22797#21046#24403#21069#39029
          ShortCut = 49219
          OnClick = NCopyCurrentPageClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NOpenFile: TMenuItem
        Caption = #25171#24320#25991#20214'(&O)'
        ImageIndex = 18
        OnClick = NOpenFileClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSavaAsImage: TMenuItem
        Caption = #21478#23384#20026#22270#29255'...'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NSaveImgMode1: TMenuItem
          Caption = #27169#24335#19968'('#21333#26694#26550')'
          OnClick = NSaveImgMode1Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSaveImgMode2: TMenuItem
          Caption = #27169#24335#20108'('#24403#21069#23631')'
          OnClick = NSaveImgMode2Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NSaveAs: TMenuItem
        Caption = #21478#23384#20026'(&A)...'
        ImageIndex = 24
        ShortCut = 16467
        OnClick = NSaveAsClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object MenuItem1: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NPageSetup: TMenuItem
        Caption = #39029#38754#35774#32622'(&U)'
        OnClick = NPageSetupClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NPrintView: TMenuItem
        Caption = #25171#21360#39044#35272'(&V)'
        ImageIndex = 30
        OnClick = NPrintViewClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NPrint: TMenuItem
        Caption = #25171#21360
        ImageIndex = 7
        ShortCut = 16464
        OnClick = NPrintClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object MenuItem2: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSend: TMenuItem
        Caption = #21457#36865'(&E)'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NNewMail: TMenuItem
          Caption = #30005#23376#37038#20214#39029#38754'(&P)'
          ImageIndex = 11
          OnClick = NNewMailClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSendPage: TMenuItem
          Caption = #30005#23376#37038#20214#38142#25509'(&L)'
          ImageIndex = 44
          OnClick = NSendPageClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSendLink: TMenuItem
          Caption = #26700#38754#24555#25463#26041#24335'(&S)'
          OnClick = NSendLinkClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NImport: TMenuItem
        Caption = #23548#20837#21644#23548#20986'(&I)'
        ImageIndex = 39
        OnClick = NImportClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N12: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCloseCurrent: TMenuItem
        Caption = #20851#38381#24403#21069#31383#21475
        ShortCut = 16471
        OnClick = NCloseCurrentClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAllClose: TMenuItem
        Caption = #20840#37096#20851#38381#31383#21475
        ImageIndex = 27
        ShortCut = 49239
        OnClick = NAllCloseClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object MenuItem3: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAttribute: TMenuItem
        Caption = #23646#24615'(&R)'
        OnClick = NAttributeClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NOffline: TMenuItem
        Caption = #33073#26426#24037#20316
        ImageIndex = 43
        OnClick = NOfflineClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N38: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NQuickExit: TMenuItem
        Caption = #24555#36895#36864#20986'-'#19981#20445#23384
        Visible = False
        OnClick = NQuickExitClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NExit: TMenuItem
        Caption = #36864#20986'(&E) '
        ShortCut = 16453
        OnClick = NExitClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
    end
    object NEdit: TMenuItem
      Caption = #32534#36753'(&E)'
      object NOpenNewlyOne: TMenuItem
        Caption = #25764#28040#26368#21518#20851#38381
        ImageIndex = 23
        ShortCut = 16458
        OnClick = NOpenNewlyOneClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NNewlyCloseList: TMenuItem
        Caption = #21487#25764#28040#20851#38381#21015#34920
        ShortCut = 49226
        OnClick = NNewlyCloseListClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N46: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCut: TMenuItem
        Caption = #21098#20999'(&T)'
        ImageIndex = 37
        ShortCut = 16472
        OnClick = NCutClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCopy: TMenuItem
        Caption = #22797#21046'(&C)'
        ImageIndex = 25
        ShortCut = 16451
        OnClick = NCopyClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NPaste: TMenuItem
        Caption = #31896#36148'(&P)'
        ImageIndex = 34
        ShortCut = 16470
        OnClick = NPasteClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N14: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSelectAll: TMenuItem
        Caption = #20840#36873'(&A)'
        ShortCut = 16449
        OnClick = NSelectAllClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NFind: TMenuItem
        Caption = #26597#25214'('#22312#24403#21069#39029')(&F)...'
        ImageIndex = 30
        ShortCut = 16454
        OnClick = NFindClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object MenuItem4: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAddressSetFocus: TMenuItem
        Caption = #22320#22336#26639#33719#28966#28857
        ShortCut = 117
        OnClick = NAddressSetFocusClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NDocmentSetFocus: TMenuItem
        Caption = #32593#39029#25991#26723#33719#28966#28857
        ShortCut = 118
        OnClick = NDocmentSetFocusClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCleanCurrentAd: TMenuItem
        Caption = #28165#38500#24403#21069#39128#28014#21450'IE'#24377#20986#24191#21578
        ShortCut = 119
        OnClick = NCleanCurrentAdClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N299: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NEditSource: TMenuItem
        Caption = #32534#36753'...'
        OnClick = NEditSourceClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
    end
    object NView: TMenuItem
      Caption = #26597#30475'(&V)'
      object NToolCote: TMenuItem
        Caption = #24037#20855#26639
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NShowMenu: TMenuItem
          AutoCheck = True
          Caption = #33756#21333#26639
          OnClick = NNShowMenuClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NShowButton: TMenuItem
          Caption = #26631#20934#25353#38062
          Checked = True
          Visible = False
          OnClick = NShowButtonClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NShowSearch: TMenuItem
          Caption = #25628#32034#26639
          Checked = True
          OnClick = NShowSearchClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSideCote: TMenuItem
          Caption = #20391#36793#26639
          OnClick = NSideCoteClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NFavoritCote: TMenuItem
          Caption = #25910#34255#26639
          OnClick = NFavoritCoteClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N2: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NStatusBarV: TMenuItem
          Caption = #29366#24577#26639
          Checked = True
          OnClick = NStatusBarVClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NStatusBarE: TMenuItem
          AutoCheck = True
          Caption = #29366#24577#26639#25193#23637
          Checked = True
          Visible = False
          OnClick = NStatusBarEClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N47: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NFontSize: TMenuItem
        Caption = #25991#23383#22823#23567'(&X)'
        ImageIndex = 8
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NLargest: TMenuItem
          Tag = 4
          Caption = #26368#22823'(&G)'
          RadioItem = True
          OnClick = NLargestClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NLarger: TMenuItem
          Tag = 3
          Caption = #36739#22823'(&L)'
          RadioItem = True
          OnClick = NLargerClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NMiddle: TMenuItem
          Tag = 2
          Caption = #20013'(&M)'
          RadioItem = True
          OnClick = NMiddleClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSmall: TMenuItem
          Tag = 1
          Caption = #36739#23567'(&S)'
          RadioItem = True
          OnClick = NSmallClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSmallest: TMenuItem
          Caption = #26368#23567'(&A)'
          RadioItem = True
          OnClick = NSmallestClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NPageView: TMenuItem
        Caption = #32593#39029#32553#25918'(&Z)'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object N50: TMenuItem
          Caption = '50%'
          OnClick = N50Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N75: TMenuItem
          Caption = '75%'
          OnClick = N75Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N100: TMenuItem
          Caption = '100%'
          OnClick = N100Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N110: TMenuItem
          Caption = '110%'
          OnClick = N110Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N120: TMenuItem
          Caption = '120%'
          OnClick = N120Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N125: TMenuItem
          Caption = '125%'
          OnClick = N125Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N130: TMenuItem
          Caption = '130%'
          OnClick = N130Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N150: TMenuItem
          Caption = '150%'
          OnClick = N150Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N200: TMenuItem
          Caption = '200%'
          OnClick = N200Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N13: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NStop: TMenuItem
        Caption = #20572#27490
        ShortCut = 27
        OnClick = NStopClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NTOPageHome: TMenuItem
        Caption = #21040#32593#39029#25991#26723#22836
        OnClick = NTOPageHomeClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NTOPageEnd: TMenuItem
        Caption = #21040#32593#39029#25991#26723#23614
        OnClick = NTOPageEndClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N54: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NRefresh: TMenuItem
        Caption = #21047#26032
        ShortCut = 116
        OnClick = NRefreshClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N31: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAllStop: TMenuItem
        Caption = #20840#37096#20572#27490
        ImageIndex = 27
        OnClick = NAllStopClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAllRefresh: TMenuItem
        Caption = #20840#37096#21047#26032
        ImageIndex = 28
        ShortCut = 8308
        OnClick = NAllRefreshClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N18: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NPreviousPage: TMenuItem
        Caption = #21069#19968#39029#38754
        ShortCut = 16465
        OnClick = NPreviousPageClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NNextPage: TMenuItem
        Caption = #21518#19968#39029#38754
        ShortCut = 16461
        OnClick = NNextPageClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N3: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSource: TMenuItem
        Caption = #28304#25991#20214'(&C)'
        ImageIndex = 29
        OnClick = NSourceClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
    end
    object NFavorit: TMenuItem
      Caption = #25910#34255'(&A)'
      OnClick = NFavoritClick
      object NAddFavorite: TMenuItem
        Caption = #28155#21152#21040#25910#34255#22841'(&F)'
        ImageIndex = 38
        ShortCut = 16452
        OnClick = NAddFavoriteClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NTrimFavorite: TMenuItem
        Caption = #25972#29702#25910#34255#22841'(&O)...'
        ImageIndex = 41
        OnClick = NTrimFavoriteClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NOpenFavoriteDir: TMenuItem
        Caption = #25171#24320#25910#34255#22841#30446#24405
        ImageIndex = 39
        OnClick = NOpenFavoriteDirClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object MenuItem5: TMenuItem
        Caption = 'NHide'
        Visible = False
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N28: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
    end
    object NGroup: TMenuItem
      Caption = #32676#32452'(&G)'
      Visible = False
      OnClick = NGroupClick
      object NSetGroup: TMenuItem
        Caption = #35774#32622#32676#32452'...'
        ImageIndex = 47
        OnClick = NSetGroupClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSaveToGroup: TMenuItem
        Caption = #20445#23384#25152#26377#31383#21475#20026#32676#32452
        OnClick = NSaveToGroupClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAddToGroup: TMenuItem
        Caption = #28155#21152#21040#32676#32452'...'
        ImageIndex = 48
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N27: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
    end
    object NSet: TMenuItem
      Caption = #35774#32622'(&O)'
      object NPopup: TMenuItem
        Caption = #24191#21578#23631#34109
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NStopPopup: TMenuItem
          Caption = #21551#29992#24377#20986#31383#21475#36807#28388
          OnClick = NStopPopupClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NStopFloatAd: TMenuItem
          Caption = #21551#29992#28418#28014#24191#21578#36807#28388
          OnClick = NStopFloatAdClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NStopFlashAd: TMenuItem
          Caption = #21551#29992'FLASH'#36807#28388
          OnClick = NStopFlashAdClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NDisableShowGIF: TMenuItem
          Caption = #31105#27490#26174#31034'GIF'#22270#29255
          Visible = False
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NDisableShowImage: TMenuItem
          Caption = #31105#27490#26174#31034#25152#26377#22270#29255
          Visible = False
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N1: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSetWhiteList: TMenuItem
          Caption = #35774#32622#30333#21517#21333
          OnClick = NSetWhiteListClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NDownControl: TMenuItem
        Caption = #39029#38754#19979#36733#25511#21046
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NNoImage: TMenuItem
          AutoCheck = True
          Caption = #31105#27490#19979#36733#22270#20687
          OnClick = NNoImageClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NNoVideo: TMenuItem
          AutoCheck = True
          Caption = #31105#27490#35270#39057
          OnClick = NNoVideoClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NNoBgsound: TMenuItem
          AutoCheck = True
          Caption = #31105#27490#25773#25918#22768#38899
          OnClick = NNoBgsoundClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NNoJava: TMenuItem
          AutoCheck = True
          Caption = #31105#27490'Java'
          OnClick = NNoJavaClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NNoScript: TMenuItem
          AutoCheck = True
          Caption = #31105#27490'Scripts'
          OnClick = NNoScriptClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NNoActivex: TMenuItem
          AutoCheck = True
          Caption = #31105#27490'ActiveX'
          OnClick = NNoActivexClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N33: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCallBackMemory_: TMenuItem
        Caption = #39640#25928#22238#25910#20869#23384#21344#29992
        Visible = False
        OnClick = NCallBackMemory_Click
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAtMemThrift: TMenuItem
        Caption = #21551#29992#20869#23384#33410#32422#27169#24335
        OnClick = NAtMemThriftClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N37: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NProxy: TMenuItem
        Caption = #20195#29702#26381#21153#22120
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NSetProxy: TMenuItem
          Caption = #35774#32622#24182#20351#29992#33258#24049#30340#20195#29702
          OnClick = NSetProxyClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object MenuItem6: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NUseIEProxy: TMenuItem
          Caption = #20351#29992'IE'#20195#29702#35774#32622
          OnClick = NUseIEProxyClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NNoUseProxy: TMenuItem
          Caption = #19981#20351#29992#20195#29702
          OnClick = NNoUseProxyClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object MenuItem7: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCheckDefaultBrowser: TMenuItem
        Caption = #26816#26597#40664#35748#27983#35272#22120#35774#32622
        OnClick = NCheckDefaultBrowserClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSetDefBrowser: TMenuItem
        Caption = #35774#32622#40664#35748#27983#35272#22120
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NSetBrowserTOP: TMenuItem
          Caption = #35774#32622' Browser '#20026#40664#35748#27983#35272#22120
          OnClick = NSetBrowserTOPClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSetBrowserIE: TMenuItem
          Caption = #35774#32622' IE '#20026#40664#35748#27983#35272#22120
          OnClick = NSetBrowserIEClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N16: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NFaceSkin: TMenuItem
        Caption = #30382#32932#26679#24335
        Visible = False
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NFaceStyle0: TMenuItem
          AutoCheck = True
          Caption = #40664#35748
          Checked = True
          RadioItem = True
          OnClick = NFaceStyle0Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NFaceStyle1: TMenuItem
          AutoCheck = True
          Caption = #26679#24335#19968
          RadioItem = True
          OnClick = NFaceStyle1Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NFaceStyle2: TMenuItem
          AutoCheck = True
          Caption = #26679#24335#20108
          RadioItem = True
          OnClick = NFaceStyle2Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N15: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NFaceStyle3: TMenuItem
          AutoCheck = True
          Caption = 'face 3'
          RadioItem = True
          OnClick = NFaceStyle3Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NTabStyle: TMenuItem
        Caption = #26631#31614#26679#24335
        Visible = False
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NTabStyle0: TMenuItem
          AutoCheck = True
          Caption = #40664#35748
          Checked = True
          RadioItem = True
          OnClick = NTabStyle0Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabStyle1: TMenuItem
          AutoCheck = True
          Caption = #26679#24335#19968
          RadioItem = True
          Visible = False
          OnClick = NTabStyle1Click
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabStyle2: TMenuItem
          AutoCheck = True
          Caption = #26679#24335#20108
          RadioItem = True
          Visible = False
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabStyle4: TMenuItem
          AutoCheck = True
          Caption = #26679#24335#22235
          RadioItem = True
          Visible = False
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N20: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabAutoWidth: TMenuItem
          Caption = #33258#36866#24212#26631#31614
          OnClick = NTabAutoWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NTabWidthP: TMenuItem
        Caption = #26631#31614#38271#24230
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NTabWidth60: TMenuItem
          Tag = 60
          AutoCheck = True
          Caption = '60'
          RadioItem = True
          OnClick = NTabWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabWidth80: TMenuItem
          Tag = 80
          AutoCheck = True
          Caption = '80'
          RadioItem = True
          OnClick = NTabWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabWidth100: TMenuItem
          Tag = 100
          AutoCheck = True
          Caption = '100'
          RadioItem = True
          OnClick = NTabWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabWidth120: TMenuItem
          Tag = 120
          AutoCheck = True
          Caption = '120'
          RadioItem = True
          OnClick = NTabWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabWidth150: TMenuItem
          Tag = 150
          AutoCheck = True
          Caption = '150'
          RadioItem = True
          OnClick = NTabWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabWidth: TMenuItem
          Tag = 180
          AutoCheck = True
          Caption = '180'
          RadioItem = True
          OnClick = NTabWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NTabWidth200: TMenuItem
          Tag = 200
          AutoCheck = True
          Caption = '200'
          RadioItem = True
          OnClick = NTabWidthClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object NTabOption: TMenuItem
        Caption = #26631#31614#36873#39033
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NShowLogo: TMenuItem
          Caption = #26174#31034#32593#31449'LOGO *'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
          object NShowWebIconY: TMenuItem
            AutoCheck = True
            Caption = #26174#31034
            RadioItem = True
            OnClick = NShowWebIconYClick
            OnAdvancedDrawItem = DrawMainItem
            OnMeasureItem = MeasureMainItem
          end
          object NShowWebIconN: TMenuItem
            AutoCheck = True
            Caption = #19981#26174#31034
            RadioItem = True
            OnClick = NShowWebIconNClick
            OnAdvancedDrawItem = DrawMainItem
            OnMeasureItem = MeasureMainItem
          end
        end
        object NTabCloseShow: TMenuItem
          Caption = #26174#31034#20851#38381#23567#25353#38062
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
          object NShowTabCloseY: TMenuItem
            AutoCheck = True
            Caption = #26174#31034
            Checked = True
            RadioItem = True
            OnClick = NShowTabCloseYClick
            OnAdvancedDrawItem = DrawMainItem
            OnMeasureItem = MeasureMainItem
          end
          object NShowTabCloseN: TMenuItem
            AutoCheck = True
            Caption = #19981#26174#31034
            RadioItem = True
            OnClick = NShowTabCloseNClick
            OnAdvancedDrawItem = DrawMainItem
            OnMeasureItem = MeasureMainItem
          end
        end
      end
      object NButtonImg: TMenuItem
        Caption = #26631#20934#25353#38062#22270#26631
        Visible = False
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NDefaultSite: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NRunOne: TMenuItem
        Caption = #21482#20801#35768#36816#34892#19968#20010'x'#23454#20363
        OnClick = NRunOneClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N39: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NLanguage: TMenuItem
        Caption = 'Language'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NChinese: TMenuItem
          Caption = 'Chinese'
          Checked = True
          RadioItem = True
          OnClick = NChineseClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NEnglish: TMenuItem
          Caption = 'English'
          RadioItem = True
          OnClick = NEnglishClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N40: TMenuItem
          Caption = '-'
          RadioItem = True
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NOther: TMenuItem
          Caption = 'Other'
          RadioItem = True
          OnClick = NOtherClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N10: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NInternetOption: TMenuItem
        Caption = 'Internet'#36873#39033
        ImageIndex = 49
        OnClick = NInternetOptionClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NTOPOption: TMenuItem
        Caption = 'Browser '#36873#39033'...'
        ImageIndex = 46
        OnClick = NTOPOptionClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
    end
    object NTools: TMenuItem
      Caption = #24037#20855'(&T)'
      object NQuickLink: TMenuItem
        Caption = #24555#25463#32593#22336
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NWeather: TMenuItem
          Caption = #22825#27668#39044#25253
          ShortCut = 16468
          OnClick = NWeatherClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N57: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NQuickClearMemory: TMenuItem
        Caption = #24555#36895#28165#29702#20869#23384
        ShortCut = 120
        OnClick = NQuickClearMemoryClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N11: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NPlayMusic: TMenuItem
        Caption = #25773#25918#27468#26354
        OnClick = NPlayMusicClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NMTV: TMenuItem
        Caption = #22312#32447#32593#32476#30005#21488#30005#35270
        OnClick = NMTVClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N32: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NLockToolBar: TMenuItem
        Caption = #38145#23450#24037#20855#26639
        Checked = True
        Enabled = False
        Visible = False
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NTabLock: TMenuItem
        AutoCheck = True
        Caption = #38145#23450#26631#31614'(&L)'
        RadioItem = True
        ShortCut = 16460
        OnClick = NTabLockClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N59: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAutoFullForm: TMenuItem
        Caption = #33258#21160#22635#34920
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NSInput: TMenuItem
          Caption = #22635#20889#24403#21069#34920#21333
          ShortCut = 32849
          OnClick = NSInputClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NSaveForm: TMenuItem
          Caption = #20445#23384#24403#21069#34920#21333
          ShortCut = 32817
          OnClick = NSaveFormClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N19: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NInputTable: TMenuItem
          Caption = #26631#20934#22635#34920
          ShortCut = 49233
          OnClick = NInputTableClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N9: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NGetScreen: TMenuItem
        Caption = #21306#22495#25130#23631
        ShortCut = 123
        OnClick = NGetScreenClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N25: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSetZoom: TMenuItem
        Caption = #33258#21160#21518#32493#32553#25918
        OnClick = NSetZoomClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N23: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NWebAutoRefresh: TMenuItem
        Caption = #33258#21160#21047#26032#39029#38754
        ShortCut = 8311
        OnClick = NWebAutoRefreshClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N22: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAutoHintAndShutdown: TMenuItem
        Caption = #33258#21160#25552#37266#19982#23450#26102#20851#26426
        OnClick = NAutoHintAndShutdownClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N5: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NUnLockWebPage: TMenuItem
        Caption = #35299#38500#40736#26631#24038#21491#38190#38480#21046
        OnClick = NUnLockWebPageClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N8: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCurrNoSilent: TMenuItem
        Caption = #24403#21069#39029#38750#23433#38745#26041#24335#27983#35272
        OnClick = NCurrNoSilentClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N7: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NProgram: TMenuItem
        Caption = #25171#24320#31243#24207
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NMyComputer: TMenuItem
          Caption = #25105#30340#30005#33041
          OnClick = NMyComputerClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NNotepad: TMenuItem
          Caption = #35760#20107#26412
          OnClick = NNotepadClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NMspaint: TMenuItem
          Caption = #23567#30011#23478
          OnClick = NMspaintClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NRunControl: TMenuItem
          Caption = #25511#21046#38754#26495
          OnClick = NRunControlClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NAddDeleteControl: TMenuItem
          Caption = #28155#21152'/'#21024#38500#31243#24207
          OnClick = NAddDeleteControlClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCommandLine: TMenuItem
          Caption = #21629#20196#34892#31383#21475
          OnClick = NCommandLineClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NRegedit: TMenuItem
          Caption = #27880#20876#34920#32534#36753#22120
          OnClick = NRegeditClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N29: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NFollowTOPClose: TMenuItem
          Caption = #38543' Browser '#20851#38381
          Visible = False
          OnClick = NFollowTOPCloseClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
      object N52: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NCleanHisttoryM: TMenuItem
        Caption = #28165#38500#27983#35272#35760#24405
        ImageIndex = 33
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
        object NCleanAddress: TMenuItem
          Caption = #28165#38500#22320#22336#26639#21382#21490
          OnClick = NCleanAddressClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NClearSearchHistory: TMenuItem
          Caption = #28165#38500#25628#32034#26639#21382#21490
          OnClick = NClearSearchHistoryClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanNewly: TMenuItem
          Caption = #28165#38500#26368#36817#27983#35272
          OnClick = NCleanNewlyClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object MenuItem8: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanHistory: TMenuItem
          Caption = #28165#38500#27983#35272#21382#21490
          OnClick = NCleanHistoryClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanCache: TMenuItem
          Caption = #28165#38500#32531#23384'(Cache)'
          OnClick = NCleanCacheClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanCookies: TMenuItem
          Caption = #28165#38500' Cookies'
          OnClick = NCleanCookiesClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N35: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanTempDir: TMenuItem
          Caption = #28165#31354#20020#26102#30446#24405
          OnClick = NCleanTempDirClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanFavorite: TMenuItem
          Caption = #28165#31354#25910#34255#22841
          Visible = False
          OnClick = NCleanFavoriteClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanRecent: TMenuItem
          Caption = #28165#38500#26368#36817#27983#35272#30340#25991#26723' '
          OnClick = NCleanRecentClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object N34: TMenuItem
          Caption = '-'
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
        object NCleanAll: TMenuItem
          Caption = #20840#37096#28165#38500
          ImageIndex = 37
          OnClick = NCleanAllClick
          OnAdvancedDrawItem = DrawMainItem
          OnMeasureItem = MeasureMainItem
        end
      end
    end
    object NHelp: TMenuItem
      Caption = #24110#21161'(&H)'
      object NSubHelp: TMenuItem
        Caption = #24110#21161
        ImageIndex = 42
        OnClick = NSubHelpClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NHelpOnline: TMenuItem
        Caption = #22312#32447#24110#21161
        OnClick = NHelpOnlineClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object MenuItem9: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NBrowserHomePage: TMenuItem
        Caption = 'Browser '#20027#39029
        OnClick = NBrowserHomePageClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NBrowserBBS: TMenuItem
        Caption = 'Browser '#35770#22363
        OnClick = NBrowserBBSClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N17: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NSustain: TMenuItem
        Caption = #25424#21161
        Visible = False
        OnClick = NSustainClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NDaoHang: TMenuItem
        OnClick = NDaoHangClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N24: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NUpdateOnline: TMenuItem
        Caption = #22312#32447#21319#32423
        OnClick = NUpdateOnlineClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAutoUpdateHint: TMenuItem
        Caption = #33258#21160#26356#26032#25552#31034
        Checked = True
        Enabled = False
        RadioItem = True
        OnClick = NAutoUpdateHintClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object N21: TMenuItem
        Caption = '-'
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
      object NAbout: TMenuItem
        Caption = #20851#20110
        ImageIndex = 35
        OnClick = NAboutClick
        OnAdvancedDrawItem = DrawMainItem
        OnMeasureItem = MeasureMainItem
      end
    end
  end
  object PopupMenuIcon: TPopupMenu
    Left = 120
    Top = 217
    object NShowORHide: TMenuItem
      Caption = #26174#31034'/'#38544#34255
      OnClick = NShowORHideClick
    end
    object N45: TMenuItem
      Caption = '-'
    end
    object NPopupExit: TMenuItem
      Caption = #36864#20986'  Browser'
      ImageIndex = 4
      OnClick = NPopupExitClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'HTML'#25991#20214'(*.htm;*.html)|*.htm;*.html|'#22270#29255#25991#20214'(*.jpg;*.jpeg;*.gif;*.bmp)' +
      '|*.jpg;*.jpeg;*.gif;*.bmp|'#25152#26377#25991#20214'(*.*)|*.*'
    Left = 224
    Top = 144
  end
  object SaveDialogToImage: TSaveDialog
    Filter = 
      'JPEG'#25991#20214'(*.jpg;*.jpeg)|*.jpg;*.jpeg|'#20301#22270#25991#20214'(*.bmp)|*.bmp|'#25152#26377#25991#20214'(*.*)|*.' +
      '*'
    Left = 162
    Top = 40
  end
  object TimerUpdate2: TTimer
    Enabled = False
    Interval = 10000
    Left = 92
    Top = 145
  end
  object PopupMenuMenuFavorite: TPopupMenu
    Left = 48
    Top = 156
    object MenuItem10: TMenuItem
      Caption = '-'
    end
  end
  object PopupMenuShowCote: TPopupMenu
    Left = 248
    Top = 48
    object NNShowMenu: TMenuItem
      Caption = #33756#21333#26639
      Checked = True
      OnClick = NNShowMenuClick
    end
    object NNShowButton: TMenuItem
      Caption = #26631#20934#25353#38062
      Checked = True
      Visible = False
      OnClick = NNShowButtonClick
    end
    object NSearchShow: TMenuItem
      AutoCheck = True
      Caption = #25628#32034#26639
      Checked = True
      OnClick = NSearchShowClick
    end
    object NNFavoritCote: TMenuItem
      Caption = #25910#34255#22841
      OnClick = NNFavoritCoteClick
    end
    object NNStatusBarV: TMenuItem
      Caption = #29366#24577#26639
      Checked = True
      OnClick = NNStatusBarVClick
    end
  end
  object PopupMenuMenuFavorit: TPopupMenu
    Left = 48
    Top = 94
  end
  object ImageListOther: TImageList
    Height = 18
    Left = 272
    Top = 112
    Bitmap = {
      494C010105000900040010001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003600000001002000000000000036
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010C6100008AD
      0800398C39000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6C6
      BD00BD948400C68C6B00BDA59400E7D6D600C6CEE7004A73CE0084E7840073DE
      730021AD3100298CEF00A5B5D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7AD9400EF6B
      2900F78C6B00FF9C8400EF944A0039CE4A005ABD5A0029C642009CEF9C0084E7
      840021BD210042944200398C3900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFA57B00FF8C
      6B00FFAD9400FFB59C00FFE7BD0063DE6300C6F7C600B5F7B5009CEF9C0094E7
      940084E7840073DE730008B50800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7C6B500FF94
      7300FFBDA500FFBD9400FFF7DE0094E79400CEF7CE00C6F7C600ADEFAD009CEF
      9C009CEF9C0084E7840010C61000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      C6006329100010187B001029BD00944A7B00E7D6C600DEEFEF00C6F7C600B5F7
      B50029C64200184ACE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000184A002163CE002973DE000031BD00DEDEEF00F7EFEF00CEF7CE00C6F7
      C60039CE4A002184DE00F7EFEF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424242002121
      10002963B500399CEF003994E7002984DE00639CCE00CECED60094E7940063DE
      630042D65A0039A5EF00D6CEDE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000101010004A42
      3100317BBD004AB5F7004AB5F70039ADEF00739CC600CECEE70052C6FF0052C6
      FF0052C6FF004ABDFF00B5B5D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5006363
      63008484840084849C00296BCE00185AB500BDCED600000000003163B5004A5A
      9C008C8494006B636B00C6B5B500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009494
      94008C8C8C00CECEC600948C8C00635A520000000000000000005A525A00B5AD
      A500C6BDBD008C8C8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE009C9C9C007B7B7B00000000000000000000000000A59CA500847B
      840094949C009484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E7E700DEE7E700CECE
      DE00BDC6DE00BDBDDE00D6D6E700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001884B5001884B500107B
      B500107BAD00107BAD000873A5000873A500006BA50000639C0000639C000063
      9C0000639C006363630063636300000000000000000000000000000000008C5A
      5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A000000000000000000D6C6BD00BD948400C68C
      6B00C68C7300BDA59400E7D6D600000000004A73CE00106BDE0042ADDE0042AD
      EF00298CEF00298CEF00086BE700A5B5D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001884BD0063CEFF001884BD009CFF
      FF006BD6FF006BD6FF006BD6FF006BD6FF006BD6FF006BD6FF006BD6FF0039AD
      DE009CFFFF0000639C00636363000000000000000000F7D6AD00DEB57300DEAD
      7300FFD6CE00E7BDA500DEB5A500EFC6B500FFD6C600FFD6C600FFDECE00FFDE
      CE00FFDECE00FFCEAD008452520000000000E7AD9400EF6B2900F78C6B00FF9C
      8400FF9C8C00EF944A00B594AD00086BDE00319CF70031B5F700DEEFF700CEE7
      EF0042BDFF004AB5F700399CF700085AD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000218CBD0063CEFF00218CBD009CFF
      FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0039AD
      DE009CFFFF0000639C006363630000000000FFCE7B00C6A58400FFFFFF00C68C
      4A008C5A31006B422100634221005A3929008C6B4A00DEB59C00F7D6C600FFD6
      CE00FFDECE00FFCEAD008452520000000000EFA57B00FF8C6B00FFAD9400FFB5
      9C00F7AD8400FFE7BD00B5A5BD00218CEF004ABDFF005AC6F700FFFFFF00FFFF
      FF006BCEF7004AC6FF0039B5FF005A84D6000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF0000000000000000000000000000000000218CBD0063CEFF00218CBD009CFF
      FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0039AD
      DE009CFFFF0000639C006363630000000000B58C4A00C6AD9C00C6B5AD00AD6B
      2900EF9C3900EF9C3100F7AD3900EFC66B00EFC66B005A422900D6B59400FFDE
      BD00FFDEBD00FFCEAD008452520000000000F7C6B500FF947300FFBDA500FFBD
      9400FFD6AD00FFF7DE00E7C6B5004273D60042BDFF0084D6F700FFFFEF00FFF7
      EF00EFEFDE006BCEF70031A5F700D6D6E7000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF0000000000000000000000000000000000218CC60063CEFF002994C6009CFF
      FF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF004AB5
      E7009CFFFF0000639C006363630000000000B58C4A00DEA53900B57B3900EF9C
      3100EF943100B5733100E7C6A500CE8C3100CE8C3100CE8C31008C6B4A00F7D6
      B500FFE7C600FFCEAD008452520000000000DEEFEF00F7C6A500FFB58C00E7A5
      8C00DEBDBD00EFD6C600FFC68C00E79C8C007BADE7008CC6E700ADA5C6005263
      B5007B73BD007B9CC600D6D6E700000000000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF0000000000000000000000000000000000218CC60063CEFF00319CCE009CFF
      FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0052C6
      EF009CFFFF0000639C006363630000000000CEBDA500FFD67B00F7AD3100E794
      29009C631800E7C6A500FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00E7C6
      AD00FFE7CE00FFCEB5008C5A5A0000000000DEEFEF00CECEC600632910001018
      7B000029C6001029BD00944A7B00E7D6C600DEEFEF009C8CBD000052D6001863
      D6001052D600184ACE00C6C6D600000000000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF00000000000000000000000000000000002994C6006BD6FF00319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF0063CE
      FF009CFFFF00006BA5006363630000000000FFFFFF00C6AD7B00FFC64A00E79C
      21009C6318009C6318009C6318009C6318009C6318009C6318008C634200E7CE
      BD00FFEFD600FFCEB5009463630000000000000000000000000000184A002163
      CE002973D6002973DE000031BD00DEDEEF00DEEFEF00316BCE00298CE700318C
      E7003194DE002184DE00396BCE00000000000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF00000000000000000000000000000000002994C60084E7FF002994C6000000
      00000000000000000000000000000000000000000000000000000000000084E7
      FF00000000000873A5006363630000000000BD945A00FFFFFF00C6AD7B00F7B5
      3100D6942100E7A54A00E7A55200DE8C3100EF9C3100FFAD4200A57B4200E7CE
      BD00FFEFDE00FFCEB500946B6B000000000042424200212110002963B500399C
      EF00399CE7003994E7002984DE00639CCE00CECED6002184E7004AA5EF0039A5
      EF0039A5EF0039A5EF00187BDE00D6CEDE000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF0000000000000000000000000000000000319CCE0084EFFF0084E7FF002994
      C6002994C6002994C6002994C6002994C600218CC600218CBD001884BD001884
      B5001884B5001884B5000000000000000000FFF7EF00BD945A00FFFFFF00C6AD
      7B009C731800E7C6A500FFFFFF00C67B2900FFAD4200DE943100B5947300FFEF
      DE00FFF7E700FFCEBD009C736B0000000000101010004A423100317BBD004AB5
      F7004ABDF7004AB5F70039ADEF00739CC600CECEE70031ADF70052C6FF0052C6
      FF0052C6FF004ABDFF0029A5EF00B5B5D6000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF0000000000000000000000000000000000319CCE0094F7FF008CF7FF008CF7
      FF008CF7FF008CF7FF008CF7FF0000000000000000000000000000000000107B
      AD006363630000000000000000000000000000000000D6C69C00BD945A00F7EF
      CE00DEAD3100C68C2100C68C2100E79C2900EFA52900AD844A00FFFFFF00FFF7
      EF00FFF7EF00FFCEBD00A57B730000000000393939006B6B630042638C0039AD
      F70052C6FF005ACEFF004AC6FF005AADD600BDBDD60031B5F7005AC6FF005AC6
      FF0042A5EF0042A5E7002963A500949494000000000000000000000000000000
      0000000000000000000000000000ADC6CE00000000000000000000000000FFFF
      FF0000000000000000000000000000000000319CCE00000000009CFFFF009CFF
      FF009CFFFF009CFFFF0000000000218CBD001884B5001884B5001884B500107B
      B500000000000000000000000000000000000000000000000000D6C69C00BD94
      5A00FFEF9400FFF76B00FFCE3900EFBD3900C6945200FFFFFF00E7C66B00F7EF
      E700FFFFF700FFCEBD00A57B7B0000000000A5A5A50063636300848484008484
      9C004A63A500296BCE00185AB500BDCED60000000000213973003163B5004A5A
      9C008C8494006B636B004A293100C6B5B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319CCE00000000009CFFFF009CFF
      FF009CFFFF009CFFFF0000000000218CBD001884B5001884B5001884B500107B
      B50000000000000000000000000000000000000000000000000000000000DEAD
      8400BD945A00BD945A00BD945A00BD945A00BD945A00FFFFFF00EFBD39009C6B
      63009C6B6B009C6B6B00AD847B000000000000000000949494008C8C8C00CECE
      C600D6D6CE00948C8C00635A52000000000000000000B5ADB5005A525A00B5AD
      A500C6BDBD008C8C8C005A4A5200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319CCE00000000000000
      00000000000000000000218CC600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEAD
      8400FFFFFF00FFFFFF00F7F7EF00E7D6BD00D6B58400D6B58400EFDEB500B584
      7300FFCEBD00E7944200C6C6C600000000000000000000000000000000009C9C
      9C00848484007B7B7B0000000000000000000000000000000000A59CA500847B
      840094949C009484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000319CCE00319C
      CE00319CCE002994C60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEAD
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B584
      7300CEA57300C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8C00D6A58400B584
      7300DEDEDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000360000000100010000000000B00100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFF000000000000FFFF000000000000FFFF000000000000FFC7000000000000
      E001000000000000C001000000000000C001000000000000C001000000000000
      E003000000000000E001000000000000C001000000000000C001000000000000
      C041000000000000E0C3000000000000F1C3000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFC003FFFFFF81FFFF8001E0018100FFFF000180010000FFFF000100010000
      FEEF000100010000FEEF000100010001FEEF000100010001FEEF000100018001
      FEEF1FE900010000FEEF000300010000FEEF01E780010000FEEF420FC0010080
      FFFF420FE0018181FFFFBDFFE001E3C3FFFFC3FFE003FFFFFFFFFFFFE007FFFF
      00000000000000000000000000000000000000000000}
  end
  object TimerWebAutoRefresh2: TTimer
    Enabled = False
    Interval = 60000
    Left = 136
    Top = 104
  end
  object TimerMemoryThrift: TTimer
    Enabled = False
    OnTimer = TimerMemoryThriftTimer
    Left = 160
    Top = 184
  end
  object PopupMenuRight: TPopupMenu
    Left = 168
    Top = 128
    object N4: TMenuItem
      Caption = #20851#38381#39029#38754
    end
    object N6: TMenuItem
      Caption = #21047#26032#39029#38754
    end
  end
  object IECache1: TIECache
    FilterOptions = [NORMAL_ENTRY, STICKY_ENTRY, COOKIE_ENTRY, URLHISTORY_ENTRY, TRACK_OFFLINE_ENTRY, TRACK_ONLINE_ENTRY]
    SearchPattern = spAll
    Left = 192
    Top = 208
  end
  object ImageListMenu: TImageList
    Left = 280
    Top = 160
    Bitmap = {
      494C010133003600040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000E0000000010020000000000000E0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008C5A
      5A008C5A5A008C5252008C5252008C5252008C5A5A008C5252008C5A5A008C52
      52008C5A5A008C5252008C5A5A008C5252000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEAD
      7300FFCECE00FFCECE00FFCECE00E7CEBD00E7CEBD00FFCECE00FFE7C600FFCE
      CE00FFE7C600FFCECE00FFCEBD008C5252000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEAD7300DEAD7300DEAD
      7300FFCECE00E7C6A500DEB59C00E7CEBD00FFCECE00F7DEBD00FFCECE00FFE7
      C600FFCECE00FFE7CE00FFCEAD00845252000000000000000000636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010C6100008AD
      0800398C3900000000000000000000000000DEAD7300C6A5840000000000CE8C
      39008C5A2900633918006B4231006339180084634200DEB59C00F7D6BD00FFCE
      CE00FFE7C600FFE7CE00FFCEAD0084525200000000001884B5001884B500107B
      B500107BAD00107BAD000873A5000873A500006BA50000639C0000639C000063
      9C0000639C006363630063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7AD9400EF6B
      2900F78C6B00FF9C8400EF944A0039CE4A005ABD5A0029C642009CEF9C0084E7
      840021BD210042944200398C390000000000DE9C310000000000CE8C3900A573
      2900EF9C3100EF943100F7AD3900EFD67300EFBD6B005A423100D6BD9400FFDE
      BD00FFDEBD00FFE7CE00FFCEAD0084525200218CBD0063CEFF00218CBD009CFF
      FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0039AD
      DE009CFFFF0000639C0063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFA57B00FF8C
      6B00FFAD9400FFB59C00FFE7BD0063DE6300C6F7C600B5F7B5009CEF9C0094E7
      940084E7840073DE730008B5080000000000BD8C5200DE943900A5732900E794
      2900EF942900B5733100E7C6A500CE842900CE842900CE84290084634200EFD6
      B500FFE7C600FFE7CE00FFCEAD0084525200218CBD0063CEFF00218CBD009CFF
      FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0039AD
      DE009CFFFF0000639C0063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7C6B500FF94
      7300FFBDA500FFBD9400FFF7DE0094E79400CEF7CE00C6F7C600ADEFAD009CEF
      9C009CEF9C0084E7840010C6100000000000C6A58400FFD67300A5732900E794
      29008C5A2900FFC69400FFE7C600FFE7C600FFE7C600FFE7C600FFE7CE00EFCE
      AD00FFE7CE00FFE7CE00FFCEB5008C5A5A00218CC60063CEFF002994C6009CFF
      FF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF004AB5
      E7009CFFFF0000639C0063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CECE
      C6006329100010187B001029BD00944A7B00E7D6C600DEEFEF00C6F7C600B5F7
      B50029C64200184ACE00000000000000000000000000C6A58400FFCE4200E79C
      21008C5A29008C5A29008C5A29008C5A29008C5A29008C5A2900946B3900E7CE
      BD00FFEFD600FFE7CE00FFCEB50094636300218CC60063CEFF00319CCE009CFF
      FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0052C6
      EF009CFFFF0000639C0063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000184A002163CE002973DE000031BD00DEDEEF00F7EFEF00CEF7CE00C6F7
      C60039CE4A002184DE00F7EFEF0000000000BD8C520000000000C6A58400F7B5
      2900CE8C2100EFAD4A00EFAD4A00DE8C3100EF9C3100FFAD4200AD7B4A00E7CE
      BD00FFEFDE00FFE7CE00FFCEBD009C6B6B002994C6006BD6FF00319CCE009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF0063CE
      FF009CFFFF00006BA50063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424242002121
      10002963B500399CEF003994E7002984DE00639CCE00CECED60094E7940063DE
      630042D65A0039A5EF00D6CEDE000000000000000000BD8C520000000000C6A5
      8400A5732900E7C6A500FFFFFF00BD7B2100FFAD4200DE943900AD8C6B00FFEF
      DE00FFF7E700FFF7E700FFCEBD009C6B6B002994C60084E7FF002994C6000000
      00000000000000000000000000000000000000000000000000000000000084E7
      FF00000000000873A50063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000101010004A42
      3100317BBD004AB5F7004AB5F70039ADEF00739CC600CECEE70052C6FF0052C6
      FF0052C6FF004ABDFF00B5B5D6000000000000000000B5946300CE9C6300F7E7
      C600EFAD3100C68C2900C68C2900E79C2100EFA52900AD7B4A00FFFFFF00FFF7
      EF00FFF7EF00FFF7E700FFCEBD00A5737300319CCE0084EFFF0084E7FF002994
      C6002994C6002994C6002994C6002994C600218CC600218CBD001884BD001884
      B5001884B5001884B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5006363
      63008484840084849C00296BCE00185AB500BDCED600000000003163B5004A5A
      9C008C8494006B636B00C6B5B500000000000000000000000000BD8C5200BD8C
      5200FFEF8C00FFF77300FFCE4200F7BD3100CE9C6300FFFFFF00EFBD6B00F7EF
      E700FFFFF700FFFFF700FFCEBD00AD847B00319CCE0094F7FF008CF7FF008CF7
      FF008CF7FF008CF7FF008CF7FF0000000000000000000000000000000000107B
      AD00636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE009C9C9C007B7B7B00000000000000000000000000A59CA500847B
      840094949C00948484000000000000000000000000000000000000000000D6AD
      8C00CE9C6300BD8C5200CE9C6300BD8C5200BD8C5200FFFFFF00F7BD3100F7EF
      E7009C6B6B009C6B6B009C6B6B00AD847B00319CCE00000000009CFFFF009CFF
      FF009CFFFF009CFFFF0000000000218CBD001884B5001884B5001884B500107B
      B500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6AD
      8C00FFFFFF00FFFFFF00F7EFE700EFD6C600D6AD8C00D6AD8C00EFD6B500FFFF
      FF00B5847300FFCEBD00E79C39000000000000000000319CCE00000000000000
      00000000000000000000218CC600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6AD
      8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B5847300CE9C630000000000000000000000000000000000319CCE00319C
      CE00319CCE002994C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6AD
      8C00D6AD8C00D6AD8C00D6AD8C00D6AD8C00D6AD8C00D6AD8C00D6AD8C00D6AD
      8C00B58473000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C9C00CE9C9C00CE9C
      9C00C6C6C600CECECE000000000000000000000000000000000000000000849C
      8C005A9473009C8C840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7FFF7009CEF9C0010D6100000DE000000DE000021DE2100A5F7A500FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C9C00CE9C9C00F7CE
      A500FF9C9C00CE9C9C00CE9C9C00CE9C9C00C6C6C600CECECE00000000005A84
      6B0008CE520042946300AD947B0000000000000000001894210000AD100000A5
      180000A51000009C1000009C0800009408000094080000940000008C0000008C
      0000008C0000008C0000106B1000000000000000000000000000FFFFFF008CE7
      8C0000CE000000D6000000DE000000E7000000E7000000E7000000DE000008D6
      0800B5F7B500FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C9C00F7CEA500CE9C
      9C00F7CEA500FFCE9C00FFCE9C00F7CEA50063846B00219C4A00299C520021AD
      520000E7520000DE520031AD5A00738C6B000000000008AD18005ACE7B005ACE
      730052CE6B004AC6630039BD4A0029BD420029BD420029BD420021B5390018B5
      310010B5290010AD2100009400000000000000000000FFFFFF004ACE4A0000C6
      000000CE000000DE000031E731004AF74A004AF74A0021F7210000E7000000DE
      000000D6000073E77300FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E7E700DEE7E700CECE
      DE00BDC6DE00BDBDDE00D6D6E7000000000000000000CE9C9C00F7CEA500F7CE
      A500F7CEA500FFEFCE00FFEFCE00FFEFCE00528C630000F7520000FF5A0000F7
      520000E7520000EF520000EF520010B55A000000000008AD18006BD684006BD6
      84005ACE7B0052CE6B0084DE9400BDEFC60052CE6B0029BD4A0029BD420021BD
      390018B5310010B529000094000000000000FFFFFF005ACE5A0000B5000000C6
      000039DE3900B5F7B5004AEF4A0042F7420042FF420052F75200B5F7B50021E7
      210000D6000000C6000094E794000000000000000000D6C6BD00BD948400C68C
      6B00C68C7300BDA59400E7D6D600000000004A73CE00106BDE0042ADDE0042AD
      EF00298CEF00298CEF00086BE700A5B5D60000000000CE9C9C00FFEFCE00FFEF
      CE00CE9C9C00FFEFCE00FFEFCE00FFEFCE005A846B0010C66B0018C6730018D6
      730000EF630000F7630010CE7300A5BDA5000000000008B5210073D68C0073D6
      8C0063D684005ACE7300BDEFC60000000000DEF7E7005ACE7B0031BD4A0029BD
      420021BD390018B531000094000000000000EFF7EF0000AD000000B500006BDE
      6B005ADE5A0000DE000000E70000DEFFDE00EFFFEF0000EF000000E7000063EF
      630052DE520000C6000000BD0000F7FFF700EFA57B00FF8C6B00FFAD9400FFB5
      9C00F7AD8400FFE7BD00B5A5BD00218CEF004ABDFF005AC6F700FFFFFF00FFFF
      FF006BCEF7004AC6FF0039B5FF005A84D60000000000CE9C9C00FFEFCE00FFEF
      CE00FFEFCE00CE9C9C00FFFFCE00FFFFCE00FFFFCE00FFEFCE00FFEFCE005A8C
      6B0000E75A0042B57B00B5B5AD00000000000000000010B521007BD6940073D6
      94006BD68C005ACE7B006BD68400DEF7E70000000000DEF7E7005AD68C0031C6
      520029BD420021B5310000940000000000004ABD4A0000AD000029C6290052D6
      520000CE000000D6000000DE0000DEFFDE00EFFFEF0000E7000000DE000000D6
      000063DE630021CE210000B5000084D68400F7C6B500FF947300FFBDA500FFBD
      9400FFD6AD00FFF7DE00E7C6B5004273D60042BDFF0084D6F700FFFFEF00FFF7
      EF00EFEFDE006BCEF70031A5F700D6D6E70000000000CE9C9C00FFFFCE00FFFF
      CE00FFFFCE00F7CEA500F7CEA500F7F7F700F7F7F700FFFFCE00FFEFCE007B94
      84004A946B00C6B5AD00CE9C9C00000000000000000010B5210084DE9C008CDE
      A5008CDEA50084DE9C0073D6940084DEA500EFFFF70000000000DEF7EF0063D6
      940031C6520029BD39000094080000000000089C080000A50000B5E7B50000BD
      000000C6000000CE000000D60000DEFFDE00EFFFEF0000DE000000D6000000CE
      000008CE0800ADEFAD0000B5000000AD0000DEEFEF00F7C6A500FFB58C00E7A5
      8C00DEBDBD00EFD6C600FFC68C00E79C8C007BADE7008CC6E700ADA5C6005263
      B5007B73BD007B9CC600D6D6E7000000000000000000CE9C9C00F7F7F700F7F7
      F700F7CEA500B5B5B500B5B5B500F7CEA500DEDEDE00DEDEDE00CE9C9C00FFEF
      CE00FFEFCE00FFEFCE00CE9C9C00000000000000000010B5210094DEAD00E7F7
      E700F7FFF700F7FFF700F7FFF700EFFFF700F7FFF7000000000000000000E7FF
      EF005ACE840029BD4200009C0800000000000094000008A50800A5E7A50000B5
      000000BD000000C6000000CE0000DEF7DE00EFFFEF0000D6000000CE000000C6
      000000BD0000ADE7AD0000AD000000A50000DEEFEF00CECEC600632910001018
      7B000029C6001029BD00944A7B00E7D6C600DEEFEF009C8CBD000052D6001863
      D6001052D600184ACE00C6C6D6000000000000000000CE9C9C00FFEFCE00CE9C
      9C00CECECE00F7FFFF00F7FFFF00C6D6EF00CECECE00C6C6C600B5B5B500F7CE
      A500FFFFCE00FFEFCE00CE9C9C00000000000000000010BD21009CDEAD00E7F7
      EF00F7FFFF00F7FFFF00F7FFF700EFFFF700FFFFFF000000000000000000E7FF
      EF0063CE8C0031BD4A00009C08000000000000940000089C08009CDE9C0094DE
      940084DE840000BD000000C60000DEF7DE00EFFFEF0000C6000000C600005AD6
      5A0073DE7300A5E7A50000A50000009C0000000000000000000000184A002163
      CE002973D6002973DE000031BD00DEDEEF00DEEFEF00316BCE00298CE700318C
      E7003194DE002184DE00396BCE000000000000000000CE9C9C00CE9C9C00C6D6
      EF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00F7FFFF00CEFFFF00C6C6
      C600F7CEA500FFEFCE00CE9C9C00000000000000000010BD290094DEAD00A5E7
      BD009CE7B50094E7B5008CDEAD00ADE7C600F7FFFF0000000000E7F7EF0073D6
      9C004ACE6B0042C65A00009C100000000000008C000000940000C6E7C600C6EF
      C600F7FFF70008B5080000B50000DEF7DE00EFFFEF0000BD000008BD0800EFFF
      EF00CEEFCE00BDEFBD00009C00000094000042424200212110002963B500399C
      EF00399CE7003994E7002984DE00639CCE00CECED6002184E7004AA5EF0039A5
      EF0039A5EF0039A5EF00187BDE00D6CEDE0000000000CECECE00CE9C9C00C6D6
      EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00C6D6EF00C6D6
      EF0094ADAD00F7CEA500CE9C9C00000000000000000010BD29009CDEB5009CE7
      B50094DEAD0084DEA5009CE7B500EFFFF70000000000E7F7EF007BDEA5005ACE
      7B0052CE6B004AC6630000A510000000000029942900008C00007BC67B0052BD
      5200F7FFF700C6EFC60018B51800DEF7DE00EFFFEF0018B51800D6F7D600F7FF
      F70052BD520063C663000094000042AD4200101010004A423100317BBD004AB5
      F7004ABDF7004AB5F70039ADEF00739CC600CECEE70031ADF70052C6FF0052C6
      FF0052C6FF004ABDFF0029A5EF00B5B5D6000000000000000000C6C6C600B5B5
      B500CEFFFF00C6D6EF00C6D6EF009CCEFF009CCEFF009C9CCE00B5B5B500B5B5
      B500B5B5B500CE9C9C00CE9C9C00000000000000000010BD29009CE7BD00A5E7
      BD009CE7B5008CDEAD00C6EFD60000000000E7F7EF008CDEB5006BD68C0063D6
      84005ACE7B0052CE6B0000A5100000000000B5D6B50000840000219C2100BDE7
      BD0084CE8400F7FFF7006BCE6B00E7F7E700FFFFFF00F7FFF700F7FFF7007BCE
      7B00C6E7C600189C1800008C0000D6EFD600393939006B6B630042638C0039AD
      F70052C6FF005ACEFF004AC6FF005AADD600BDBDD60031B5F7005AC6FF005AC6
      FF0042A5EF0042A5E7002963A50094949400000000000000000000000000C6C6
      C600B5B5B5009CFFFF009CFFFF009CCEFF009CCEFF009CCEFF009CCEFF009CCE
      FF00B5B5B500CE9C9C0000000000000000000000000010BD2900A5E7BD00ADE7
      C600A5E7BD009CE7B500A5E7BD00BDEFD6009CE7B50084DEA50073D6940073D6
      8C006BD684005ACE730000A5180000000000FFFFFF00218C210052AD520063B5
      6300C6E7C6007BC67B0073C67300CEEFCE00DEF7DE00CEEFCE0084CE8400C6E7
      C60063BD630052AD5200319C3100FFFFFF0000000000949494008C8C8C00CECE
      C600D6D6CE00948C8C00635A52000000000000000000B5ADB5005A525A00B5AD
      A500C6BDBD008C8C8C005A4A5200000000000000000000000000000000000000
      0000C6C6C600B5B5B5009CFFFF009CFFFF009CCEFF009CCEFF009CCEFF00CE9C
      9C00C6C6C6000000000000000000000000000000000010C621009CDEB500A5E7
      BD009CDEB5009CDEB50094DEAD008CDEA50084D69C0084D69C007BD6940073D6
      8C006BCE840063CE7B0000AD10000000000000000000F7FFF70084BD840084C6
      84008CC68C00ADD6AD00DEEFDE00E7F7E700E7F7E700DEEFDE00B5DEB5008CC6
      8C0084C6840073B57300FFFFFF00000000000000000000000000000000009C9C
      9C00848484007B7B7B0000000000000000000000000000000000A59CA500847B
      840094949C009484840000000000000000000000000000000000000000000000
      000000000000C6C6C600B5B5B500C6D6EF009CFFFF009CCECE00CE9C9C000000
      0000000000000000000000000000000000000000000021A5290010BD210018BD
      290018B5210010B5210010B5210010B5210010B5210010AD210010AD210010AD
      180010AD180008AD1000188C2100000000000000000000000000EFF7EF00ADCE
      AD00B5D6B500B5D6B500B5DEB500B5DEB500B5DEB500B5DEB500B5DEB500B5D6
      B500A5CEA500F7FFF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CECECE00B5B5B500CE9C9C00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00EFF7EF00E7EFE700E7EFE700E7EFE700E7EFE700E7EFE700DEEFDE00E7EF
      E700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000217B2100088C08000073
      0000215A21000000000000000000000000000000000000000000C6C6C6005A9C
      BD00A5BDCE00000000000000000000000000000000000000000084ADC60084AD
      C60084ADC6000000000000000000000000000000000000000000000000000000
      0000000000004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      7300B5B5B5000000000000000000000000000000000000000000BDCED600639C
      BD00B5C6CE00000000000000000000000000000000002984290042BD420039B5
      39001073180000000000000000000000000000000000000000005A9CBD009CDE
      EF00009CCE0084ADC60000000000000000000000000084ADC60084ADC600DEFF
      FF004A84A500000000000000000000000000000000000000000000000000CE9C
      6300CE9C9C00FFEFCE00DEDEDE00DEDEDE00EFEFEF00FFEFCE00CE9C9C004A4A
      4A004A4A4A000000000000000000000000000000000000000000000000000000
      000000000000000000009C6331009C3131009C3131009C313100D6D6D6000000
      00009C6363004A4A4A0000000000000000000000000000000000639CBD0094DE
      F7000894C6008CB5C6000000000000000000000000001894210052C6520042BD
      4200107318000000000000000000000000000000000000000000A5BDCE00BDD6
      EF0039C6FF0018A5CE00009C00000000000084ADC600BDBDA5007BB573007BB5
      730084ADC6000000000000000000000000000000000000000000CE9C9C00EFEF
      EF00F7F7F700DEDEDE00CECE9C00CE9C9C00F7CEA500EFEFEF00EFEFEF00FFEF
      CE00F7CEA5004A4A4A0000000000000000000000000000000000000000000000
      00009C633100CE6331009C6363009C6363009C6331009C633100000000000000
      00009C6363008484840000000000000000000000000000000000B5C6CE00BDDE
      E70031D6FF0021A5D600219C2900318C310018942100189C180063CE630052C6
      520010841000215A2100215A2100215A210000000000000000000000000073A5
      C60094E7FF0018D6FF00298429007BB573006B9C4A0084DE840084DE840084DE
      840084DE84006B9C4A00000000000000000000000000CE9C9C00EFEFEF00FFFF
      FF00CE9C6300CE633100CE633100CECE9C00CE633100CE633100CE9C9C00EFEF
      EF00EFEFEF00CECECE004A4A4A0000000000000000000000000000000000CE31
      00009C3100009C310000F7CEA500EFEFEF009C636300DEDEDE00EFEFEF00CE9C
      9C006331310000000000000000000000000000000000000000000000000073A5
      C6009CEFFF0010D6FF0039B539008CE78C007BDE7B0073D6730063CE63005ABD
      5A0052C6520042BD420039B53900007B000000000000000000000000000084AD
      C600D6F7FF0018D6FF002984290084DE840084DE840084DE840084DE840084DE
      840084DE840084DE84006B9C4A000000000000000000CE9C9C00FFFFFF00CE63
      3100CE633100CE633100CE9C9C00FFFFFF00CE9C6300CE633100CE633100CE9C
      6300F7F7F700FFEFCE004A4A4A000000000000000000000000009C3100009C31
      00009C3100009C310000FFEFCE00EFEFEF00FFCECE00EFEFEF00C6C6C6009C63
      31009C3131006331310000000000000000000000000000000000000000008CB5
      C600DEEFF70029D6FF005ABD5A0094EF94008CE78C0084DE840073D6730063CE
      630063CE630052C6520042BD4200088C08000000000000000000000000000000
      00005A9CBD0084E7FF002984290084DE840084DE840084DE8400299421007BB5
      73007BB5730008941800009C0000BDBDA500CE9C9C00FFFFFF00CE9C6300CE63
      3100CE633100CE633100CE633100CE9C6300CE633100CE633100CE633100CE63
      3100F7CEA500EFEFEF00CECECE004A4A4A0000000000CE9C3100CE310000CE63
      0000CE630000CE630000FFEFCE00FFEFCE00FFEFCE00FFEFCE00CE9C9C009C63
      63009C6363009C633100CE633100000000000000000000000000000000000000
      00005AA5C6006BE7FF0052C673006BCE7B006BCE7B005ABD5A0084DE840073D6
      7300189C180029842900298429002984290000000000000000009CADC600319C
      CE0010C6F70018D6FF002984290084DE840084DE840084DE84007BB573001884
      B50084ADC6000000000029BD42006B9C4A00CECECE00F7F7F700CE633100CE63
      3100CE633100CE633100CE9C6300EFEFEF00CE633100CE633100CE633100CE63
      3100CE633100FFFFFF00F7CEA5004A4A4A0000000000CE633100CE630000CE63
      0000CE630000CE633100FFEFCE00FFEFCE00FFEFCE00FFEFCE00FFEFCE00FFEF
      CE009C63310063633100CE63000000000000000000000000000094B5C60021A5
      CE0000C6FF0010D6FF0008CEFF0039DEFF007BF7FF0073CE7B008CE78C007BDE
      7B0018942100000000000000000000000000A5BDCE004AADCE0010C6F70039C6
      FF006BDEEF0039C6FF0029842900298429002984290029842900009C0000009C
      000010C6F7001884B5009CADC60029942100CECECE00FFEFCE00CE633100CE63
      3100CE633100CE633100CE9C6300FFFFFF00CE9C9C00CE633100CE633100CE63
      3100CE633100EFEFEF00FFEFCE004A4A4A0000000000CE633100CE630000CE63
      0000639C00009C9C6300FFEFCE00FFEFCE00FFEFCE00FFEFCE00636331003163
      000000630000316331006363310000000000B5C6CE004AADCE0000BDEF0042E7
      FF005AEFFF0031DEFF0008CEFF0021D6FF0063EFFF0073CE7B0094EF94008CE7
      8C00219C29002184B50094B5C60000000000319CCE0084E7FF009CFFFF00C6FF
      FF00DEFFFF00C6FFFF006BDEEF0018D6FF0039C6FF00C6FFFF00DEFFFF009CFF
      FF008CF7FF008CF7FF00319CCE0000000000CECECE00FFCECE00CE633100CE63
      3100CE633100CE633100CE633100CE9C9C00F7F7F700FF9C6300CE633100CE63
      3100CE633100EFEFEF00DEDEDE004A4A4A0000000000CE9C3100CE6300008484
      0000319C3100CE9C9C00FFEFCE00FFEFCE00F7CEA500CE9C6300316300000084
      000031630000316300009C3100000000000039A5CE0084E7FF00ADF7FF00CEFF
      FF00D6FFFF00CEF7FF0063DEFF0008D6FF0042E7FF006BCE7B005ABD5A0039B5
      390021A5310084E7FF00399CBD000000000073A5C60073A5C600319CCE00319C
      CE00319CCE00319CCE00C6FFFF0010C6F70018D6FF002984BD00319CCE00319C
      CE00319CCE00319CCE0084ADC60000000000CECECE00EFEFEF00CE633100CE63
      3100CE633100CE633100CE633100CE633100CECECE00FFFFFF00CE633100CE63
      3100CE633100FFFFFF00FFEFCE004A4A4A0000000000F7CEA50063636300319C
      31006363CE00F7CEA5009C9CCE00CE9C9C00CE9C3100FF9C0000848400000084
      00000084000031630000CE9C3100000000007BADBD0073A5C600319CC600319C
      C600319CC600319CC600C6F7FF0000CEFF0029DEFF00398CAD00319CC600319C
      C600319CC600319CC60084ADC600000000000000000000000000000000000000
      0000000000008CCE9400319CCE0018D6FF0010C6F70084ADC600009C00002984
      290029842900298429002984290000000000CECECE00FFFFFF00FF9C6300CE63
      3100CE9C6300EFEFEF00CE9C6300CE633100CE9C6300FFFFFF00CE9C6300CE63
      3100FF9C6300FFFFFF00CECECE004A4A4A0000000000000000003163CE00319C
      9C006363CE009C9CCE0063639C009C9C6300FFCE6300FF9C310084840000639C
      0000008400003163000000000000000000000000000000000000000000000000
      000000000000A5BDCE00319CC60008D6FF0008BDEF007BADBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000089418006BDEEF00009CCE00A5BDCE0000000000009C
      000052C6520094EF9400298429000000000000000000CECECE00FFEFCE00FF9C
      6300CE9C6300EFEFEF00FFFFFF00F7CEA500FFFFFF00EFEFEF00CE633100CE63
      3100EFEFEF00EFEFEF004A4A4A0000000000000000009CCEFF00319C9C003163
      FF009C9C63003163FF00639CCE00639CCE0031CE630063CE3100CE9C0000CE63
      0000639C0000CE9C630000000000000000000000000000000000000000000000
      00000000000000000000319CC6005AE7FF00009CCE00B5C6CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000029BD4200009C00007BB573000000000000000000009C
      000094EF940094EF9400298429000000000000000000CECECE00FFFFFF00FFEF
      CE00FF9C6300FF9C9C00DEDEDE00EFEFEF00EFEFEF00FF9C6300FF9C6300FFEF
      CE00FFFFFF00CECECE0000000000000000003163FF003163FF006363CE003163
      FF003163FF009CCE9C006363FF006363CE0031CE630031CE3100FF9C0000CE63
      0000CE9C63000000000000000000000000000000000000000000000000000000
      00000000000000000000319CC6009CEFFF002194C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084ADC6005ABD5A00009C00002984290052C6520094EF
      940094EF940052C6520029842900000000000000000000000000CECECE00FFFF
      FF00FFFFFF00FFEFCE00F7CEA500FFCE9C00FFCE9C00F7CEA500FFFFFF00FFFF
      FF00CECECE0000000000000000000000000000000000000000003163FF003163
      FF003163FF003163FF00639CCE0063CE630031CE310031CE3100CECE63000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007BADBD008CCEDE004A94B50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005ABD5A0094EF940094EF940094EF940094EF
      940052C65200009C00002984290000000000000000000000000000000000CECE
      CE00CECECE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE00CECE
      CE000000000000000000000000000000000000000000000000003163FF000000
      00006363CE00C6C6C600CE9C6300CE9C6300CECE9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000009CCE00BDCED60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005ABD5A0021A5310021A5310021A5
      31005ABD5A0000000000009C0000000000000000000000000000000000000000
      000000000000CECECE00CECECE00CECECE00CECECE00CECECE00000000000000
      000000000000000000000000000000000000000000003163FF00000000000000
      0000000000003163FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007373730073737300737373007373730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000217B2100088C08000073
      0000215A21000000000000000000000000000000000000000000C6C6C6005A9C
      BD00A5BDCE00000000000000000000000000000000000000000084ADC60084AD
      C60084ADC6000000000000000000000000000000000000000000000000000000
      000008A5D60010A5D60010A5D60010A5D60039637300525A5A00737373000000
      000000000000000000000000000000000000000000000000000000000000CE63
      6300CE6331009C6363000000000000000000000000009C636300CE633100CE63
      6300000000000000000000000000000000000000000000000000BDCED600639C
      BD00B5C6CE00000000000000000000000000000000002984290042BD420039B5
      39001073180000000000000000000000000000000000000000005A9CBD009CDE
      EF00009CCE0084ADC60000000000000000000000000084ADC60084ADC600DEFF
      FF004A84A50000000000000000000000000000000000000000000000000039B5
      DE0008A5D600C6F7FF0073DEFF0073DEFF0010A5D60010A5D600398CAD00525A
      5A00000000000000000000000000000000000000000000000000C6C6C600CE31
      0000CE6331009C310000CE9C630000000000CE9C63009C310000CE633100CE63
      0000C6C6C6000000000000000000000000000000000000000000639CBD0094DE
      F7000894C6008CB5C6000000000000000000000000001894210052C6520042BD
      4200107318000000000000000000000000000000000000000000A5BDCE00BDD6
      EF0039C6FF0018A5CE005A9CBD000000000084ADC600ADD6D600ADDEFF004ABD
      EF0084ADC60000000000000000000000000000000000000000000000000039B5
      DE0021ADDE00A5FFFF007BE7FF007BE7FF005ACEF7006BDEFF0008A5D60042BD
      E700737373000000000000000000000000000000000000000000B5B5B5009C31
      000000000000CE636300CE633100000000009C633100CE9C6300000000009C31
      0000B5B5B5000000000000000000000000000000000000000000B5C6CE00BDDE
      E70031D6FF0021A5D600219C2900318C310018942100189C180063CE630052C6
      520010841000215A2100215A2100215A210000000000000000000000000073A5
      C60094E7FF0018D6FF0031B5DE005A9CBD00BDD6EF00C6FFFF0018D6FF001884
      B5000000000000000000000000000000000000000000000000000000000039B5
      DE0031B5E700ADF7FF008CEFFF008CEFFF004294B5007BD6EF008CEFFF00009C
      CE00737373000000000000000000000000000000000000000000000000009C31
      0000CE9C6300CE636300CE630000000000009C310000CE6363009C636300CE63
      00000000000000000000000000000000000000000000000000000000000073A5
      C6009CEFFF0010D6FF0039B539008CE78C007BDE7B0073D6730063CE63005ABD
      5A0052C6520042BD420039B53900007B000000000000000000000000000084AD
      C600D6F7FF0018D6FF0039C6FF008CF7FF00C6FFFF0084E7FF0039C6FF005A9C
      BD000000000000000000000000000000000000000000000000000000000039B5
      DE0052C6F700C6F7FF0094FFFF0094FFFF005AADC6006BC6E70094FFFF00009C
      CE0073737300000000000000000000000000000000000000000000000000CE63
      6300CE630000CE630000CE63000000000000CE630000CE630000CE630000CE63
      6300000000000000000000000000000000000000000000000000000000008CB5
      C600DEEFF70029D6FF005ABD5A0094EF94008CE78C0084DE840073D6730063CE
      630063CE630052C6520042BD4200088C08000000000000000000000000000000
      00005A9CBD0084E7FF0018D6FF006BDEEF0094FFFF0094FFFF0029ADDE00A5BD
      CE000000000000000000000000000000000000000000000000000000000039B5
      DE0073D6FF00E7FFFF00B5FFFF00ADFFFF007BCEE70084E7F7009CFFFF00009C
      CE00737373000000000000000000000000000000000000000000000000000000
      0000CE9C9C00CE9C63009C3131009C6331009C313100CE636300CE9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005AA5C6006BE7FF0052C673006BCE7B006BCE7B005ABD5A0084DE840073D6
      7300189C180029842900298429002984290000000000000000009CADC600319C
      CE0010C6F70018D6FF0018D6FF0039C6FF0084E7FF009CFFFF006BDEEF001884
      B50084ADC60000000000000000000000000000000000000000000000000039B5
      DE0052BDE70073B5BD008CD6EF00A5E7FF00D6EFFF00DEFFFF00CEF7FF000094
      CE00737373000000000000000000000000000000000000000000000000000000
      000000000000000000009C636300000000009C63630000000000000000000000
      000000000000000000000000000000000000000000000000000094B5C60021A5
      CE0000C6FF0010D6FF0008CEFF0039DEFF007BF7FF0073CE7B008CE78C007BDE
      7B0018942100000000000000000000000000A5BDCE004AADCE0010C6F70039C6
      FF006BDEEF0039C6FF0010C6F70018D6FF006BDEEF0094FFFF0094FFFF0039C6
      FF0010C6F7001884B5009CADC600000000000000000000000000000000000000
      000018ADD6004294B500398CAD0010A5D60010A5D60042BDEF009CDEEF00009C
      CE00737373000000000000000000000000000000000000000000000000000000
      00000000000094949400A5A5A500848484009494940094949400000000000000
      000000000000000000000000000000000000B5C6CE004AADCE0000BDEF0042E7
      FF005AEFFF0031DEFF0008CEFF0021D6FF0063EFFF0073CE7B0094EF94008CE7
      8C00219C29002184B50094B5C60000000000319CCE0084E7FF009CFFFF00C6FF
      FF00DEFFFF00C6FFFF006BDEEF0018D6FF0039C6FF00C6FFFF00DEFFFF009CFF
      FF008CF7FF008CF7FF00319CCE00000000000000000000000000000000000000
      00000000000018ADD60010A5D6006BD6FF006BD6FF00398CAD00427B9C00009C
      CE00000000000000000000000000000000000000000000000000000000000000
      00000000000084848400A5A5A50084848400A5A5A50094949400000000000000
      00000000000000000000000000000000000039A5CE0084E7FF00ADF7FF00CEFF
      FF00D6FFFF00CEF7FF0063DEFF0008D6FF0042E7FF006BCE7B005ABD5A0039B5
      390021A5310084E7FF00399CBD000000000073A5C60073A5C600319CCE00319C
      CE00319CCE00319CCE008CCE940010C6F70018D6FF002984BD00319CCE00319C
      CE00319CCE00319CCE0084ADC600000000000000000000000000000000000000
      00000000000018ADD6006363630000000000000000005ABDDE0031ADD600529C
      AD00000000000000000000000000000000000000000000000000000000000000
      0000A5A5A500C6C6C600949494000000000084848400B5B5B500A5A5A5000000
      0000000000000000000000000000000000007BADBD0073A5C600319CC600319C
      C600319CC600319CC600C6F7FF0000CEFF0029DEFF00398CAD00319CC600319C
      C600319CC600319CC60084ADC600000000000000000000000000000000000000
      000000000000A5BDCE008CCE9400BDCEC60010C6F70084ADC60000000000009C
      0000298429002984290029842900298429000000000000000000000000000000
      00000000000018ADD6006363630000000000000000005ABDDE00529CAD0018AD
      D600000000000000000000000000000000000000000000000000000000000000
      000094949400A5A5A500000000000000000000000000B5B5B500949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5BDCE00319CC60008D6FF0008BDEF007BADBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319CCE0008941800009CCE00A5BDCE00000000000000
      0000009C000052C6520094EF9400298429000000000000000000000000000000
      00000000000018ADD6006BDEF700636363006363630052CEEF00529CAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C63630094949400000000000000000000000000949494009C6363000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319CC6005AE7FF00009CCE00B5C6CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319CCE0029BD4200009C00007BB57300000000000000
      0000009C000094EF940094EF9400298429000000000000000000000000000000
      0000000000000000000018ADD60063DEEF007BEFF70063DEEF0018ADD6000000
      000000000000000000000000000000000000000000000000000000000000B5B5
      B5009C63630000000000000000000000000000000000000000009C636300B5B5
      B500000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319CC6009CEFFF002194C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084ADC6008CCEDE005ABD5A00009C00002984290052C6
      520094EF940094EF940052C65200298429000000000000000000000000000000
      000000000000000000000000000018ADD60018ADD60018ADD600000000000000
      000000000000000000000000000000000000000000000000000000000000B5B5
      B500B5B5B5000000000000000000000000000000000000000000C6C6C600B5B5
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000000000007BADBD008CCEDE004A94B50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000009CCE005ABD5A0094EF940094EF940094EF
      940094EF940052C65200009C0000298429000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000009CCE00BDCED60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005ABD5A0021A5310021A5
      310021A531005ABD5A0000000000009C00000000000000000000000000006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363006363630063636300000000000000000000000000000000000000
      00000000000000000000DEE7E70094948C00948C8C00D6D6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AD7B7B00AD7B7300AD7B7300AD7B7300AD7B7300AD7B
      7300AD7B7300AD7B7300AD7B7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5736B00D6A5
      9400D6A59400D6A59400D6A59400CEA59400C69C9400C69C9400C69C9400C69C
      9400BD948C00B58C840063636300000000000000000000000000000000000000
      0000D6E7EF009CA5A500848484009C8C8C0073635A005A5252007B7B7300B5C6
      C60000000000000000000000000000000000000000000000000094C6D600009C
      CE00009CCE00009CCE00AD847B00FFD6A500FFD6A500FFD6A500FFD6A500FFCE
      9C00FFCE9C00FFCEB500AD7B730000000000A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      73009C6B5A000000000000000000000000000000000000000000B5847300FFE7
      CE00FFE7CE00FFDEC600FFDEC600FFDEBD00FFDEBD00FFD6BD00FFD6B500FFD6
      B500FFD6AD00E7BDA500636363000000000000000000EFF7F700B5BDC6008C8C
      8C00948C8C00A59C9C00ADADAD00ADA5A500524A4A00524A4A00635A52006B5A
      5A00736B630094948C00000000000000000000000000B5CED600009CCE006BDE
      F7006BDEF7006BDEF700B5847B00FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700FFD6BD00AD7B730000000000A57B7300FFE7D600FFE7D600FFE7
      D600FFDECE00FFE7C600FFE7C600FFE7C600FFDEAD00FFDEAD00FFD69C00FFD6
      9C009C6B5A000000000000000000000000000000000000000000B5847300FFE7
      CE00FFE7CE00FFE7D600E7B59400E7B59400E7B59400E7B59400E7B59400E7B5
      9400FFD6BD00E7BDA5006363630000000000B5BDBD00948C8C00A59C9C00B5B5
      B500B5BDBD00B5B5B500B5B5B50094949400524A4A00635A5A007B7B7B009494
      94009C948C009C7B7B007B636300ADB5B5000000000042B5DE008CF7FF0073D6
      FF0073D6FF0073D6FF00B58C7B00FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700FFD6BD00AD7B730000000000A57B7300FFE7D600FFE7D600F7E7
      D600F7E7D600FFE7C600FFE7C600FFDEAD00FFDEAD00FFDEAD00FFD69C00FFD6
      9C009C6B5A000000000000000000000000000000000000000000C68C7B00FFE7
      D600FFF7E7006363C6000010B50021219400E7B59400635AA50010107B00A57B
      8400FFDEBD00F7CEA50063636300000000009C949400BDBDBD00CEC6C600BDBD
      BD00C6BDBD00CEC6C600D6D6D600CECECE00A5A5A5008C8484007B7B7B008484
      8400ADA5A500DEB5B500CEA5A5007B6B63000000000042B5DE008CF7FF007BE7
      FF007BE7FF007BE7FF00C6948400FFF7E700FFD6AD00FFD6AD00FFD6A500FFD6
      A500FFD6A500FFD6C600AD7B730000000000B5847B00F7E7D600F7E7D600F7E7
      D600F7E7D600F7E7D600F7E7D600FFE7C600FFDEAD00FFDEAD00FFDEAD00FFDE
      AD009C6B5A000000000000000000000000000000000000000000C6947B00FFEF
      DE00FFF7E7000021D6000021CE008C7BAD004A39940021219400000884004231
      8400D6A59400F7CEA5006363630000000000A5A5A500C6C6C600C6BDBD00D6D6
      D600EFEFEF00EFEFEF00E7DEDE00D6D6D600B5B5B500ADA5A500B5B5B500A5A5
      A500948C8C00A5949400AD949400736B63000000000042B5DE008CF7FF0084EF
      FF0084EFFF0084EFFF00C6948400FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700FFD6C600AD7B730000000000B5847B00F7E7D600F7E7D600FFF7
      E700FFF7E700F7E7D6000000000018212900D6843900DE8C3100D6843900FFDE
      AD009C6B5A000000000000000000000000000000000000000000C6948400FFEF
      DE00FFF7E7001031DE000021D600CEA59400A59CC6005A52AD0000089400C69C
      9400CEB5BD00F7CEB5006363630000000000A5A5A500D6D6D600FFFFFF00FFFF
      FF00EFE7E700C6C6C6008CADBD005A8CAD001873A500396B9400CEC6C600FFFF
      FF00E7D6D6009C94940073737300B5B5B5000000000042B5DE0094F7FF008CF7
      FF008CF7FF008CF7FF00CE9C8400FFF7E700FFDEB500FFD6AD00FFD6AD00FFD6
      AD00FFD6AD00FFD6C600AD7B730000000000C6948400FFF7E700FFF7E700FFF7
      E700FFF7E700FFF7E700F7E7D60052737B00FFE7CE00EFC68C00DE8C3100D684
      3900CE630000525252007B7B7B00000000000000000000000000DEA58400FFEF
      E700FFF7E7005A63DE000031FF00635AA500FFEFDE003139BD000010AD008463
      8C00FFE7CE00F7CEB5006363630000000000DEDEDE00CECECE00BDBDBD00A5B5
      BD006B9CBD00398CC6002184CE00218CDE0039A5EF00399CEF006B7B9400ADA5
      A500A5A5A500BDBDBD00D6D6D600000000000000000042B5DE00A5F7FF0094FF
      FF0094FFFF0094FFFF00CE9C8400FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFD6CE00FFADA500AD7B730000000000C6948400FFF7E700FFF7E700FFF7
      F700FFF7F700FFF7E700FFF7E700F7E7D600DE8C3100FFE7C600FFE7C600FFD6
      A500D67B31001042C60052525200000000000000000000000000DEA58400FFF7
      E700009C0000009C0000009C0000009C0000F7DEBD00CEBDCE000018C6003131
      A500FFE7CE00F7CEB5006363630000000000000000000000000084A5C6002994
      EF0031A5F70042ADFF0052BDFF0063CEFF005ACEFF004ABDFF00317BBD00736B
      6B00DEE7E7000000000000000000000000000000000042B5DE00B5FFFF009CFF
      FF009CFFFF009CFFFF00D6A58400FFFFF700FFFFFF00FFFFFF00FFFFF700FFF7
      EF00AD7B7300AD7B7300AD7B730000000000C6948400FFF7F700FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700F7E7D600F7E7D600D6843900DE8C3100FFE7
      CE002163DE002984F7001042C600000000000000000000000000DEA58400FFF7
      EF009CCE9C00009C0000009C0000009C0000635AA500F7CEA5001021C6000018
      BD00F7CEA500F7CEB50063636300000000000000000000000000BDD6E7005ABD
      F7004ABDFF004ABDFF0052BDFF0042ADFF0042ADFF0031A5FF004294DE00425A
      6B00A59C94000000000000000000000000000000000042B5DE00C6FFFF00A5FF
      FF00A5FFFF00A5FFFF00DEAD8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7
      EF00AD7B7300CEB5A5000000000000000000D69C9C00FFF7F700FFF7F700FFFF
      FF00FFFFFF00FFF7F700FFF7F700FFF7E700FFF7E700F7E7D600FFE7C600DE8C
      3100D684390008109C0000000000000000000000000000000000DEA58400FFF7
      EF0063CE6300009C0000009C0000009C0000314ADE000021D6003139BD002939
      C600D6BDB500F7CEB5006363630000000000000000000000000000000000CED6
      DE0084BDE7004294DE00318CDE00399CE700429CE7005A9CCE00739CB500AD94
      7B008C5A3900C6C6C60000000000000000000000000042B5DE00D6FFFF00BDFF
      FF00BDFFFF00C6FFF700DEAD8C00DEAD8400DEAD8400DEAD8400DEAD8400DEAD
      8400AD7B7300000000000000000000000000EFAD9400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7F700E7DEDE00FFDECE00FFDE
      CE00A57B73000000000000000000000000000000000000000000DEA58400FFFF
      F700319C3100009C0000CECE9C00009C0000FFF7E700FFF7E700FFF7E700FFF7
      E700FFE7D600F7CEB50063636300000000000000000000000000000000000000
      000000000000CED6DE0073A5C60084A5B500BDAD9400D69C6300DE842900EF8C
      2900C6845200BDB5B50000000000000000000000000042B5DE00DEFFFF00D6FF
      FF009CE7F7009CE7F7009CE7F7009CE7F7009CE7F7009CE7F700B5F7FF00D6FF
      FF00009CCE00000000000000000000000000EFAD9400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7E7D600FFD6C600E7B5
      AD00B5847B000000000000000000000000000000000000000000DEA58400FFFF
      F70063CE6300009C0000FFF7EF00FFF7EF00FFF7E700FFEFE700FFD6CE00FFD6
      CE00FFB5AD00B584730063636300000000000000000000000000000000000000
      0000000000000000000000000000CEB59C00E7A55A00E7944A00E7842900AD52
      0800AD947B000000000000000000000000000000000042B5DE00EFFFFF00D6E7
      DE00A58C8400A58C8400A58C8400A58C8400A58C8400A58C840084ADAD00CEF7
      FF00009CCE00000000000000000000000000EFAD9400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFDED600B5847B00B584
      7B00B5847B000000000000000000000000000000000000000000DEA58400FFFF
      FF00FFFFF700639C3100319C0000FFF7EF00FFF7EF00FFF7E700F7A54200F7A5
      4200E79442006363630000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DED6CE00DECEC600C68C5A00AD52
      180084635200DEDEDE000000000000000000000000000000000042B5DE0063D6
      E700739C9C00CEBDBD00DED6D600DED6D600DED6D60084949400299CBD0021A5
      D60000000000000000000000000000000000F7C69C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFDED600B5847B00EF94
      5200C6AD94000000000000000000000000000000000000000000DEA58400FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7EF00DEA58400EFB5
      7300636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEDE00C68C
      5A00AD5210008463520000000000000000000000000000000000000000000000
      000000000000A58C8400AD9C8C00AD9C8C00AD9C8C00B5ADA500000000000000
      000000000000000000000000000000000000F7C69C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7F700F7F7F700EFEFEF00EFDED600B5847B00D6AD
      9C00000000000000000000000000000000000000000000000000DEA58400DEA5
      8400DEA58400DEA58400DEA58400DEA58400DEA58400DEA58400DEA584006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7DE
      DE00AD734200A58C730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7C69C00E7A57B00E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00B5847B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B73000000000000000000A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B73009C6B5A000000000000000000000000000000000000000000A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B73009C6B5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A57B7300FFCEBD00F7DECE00F7DECE00FFCEBD00FFCEBD00FFCE
      BD00FFCEBD00FFCEBD00A57B73000000000000000000A57B7300FFE7D600FFE7
      D600FFE7D600FFDECE00FFE7C600FFE7C600FFE7C600FFDEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A00000000000000000000000000BDC6CE009C84A500A57B
      7300FFDECE00FFDECE00FFDECE00FFD6C600FFD6C600FFD6C600FFD6C600FFD6
      C600FFDEAD00F7CEAD009C6B5A0000000000D6731000D66B0800CE6B0000CE6B
      0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B
      0000CE6B0000CE6B0000CE6B0000000000000000000000000000000000000000
      000000000000A57B7300FFE7CE00FFE7CE00FFE7CE006BC663006BC66300FFE7
      CE00FFE7CE00FFCEBD00A57B73000000000000000000A57B7300FFE7D600FFE7
      D600F7E7D600F7E7D600FFE7C600FFE7C600FFDEAD00FFDEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A000000000000000000000000009CB5D6004A7BCE009C84
      A500EFCEBD00FFEFD600FFDECE00FFE7C600FFD6C600FFD6C600FFDEAD00FFDE
      AD00FFDEAD00FFD69C009C6B5A0000000000D6731000FFF7EF00FFF7E700FFF7
      E700FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7CE00FFE7CE00FFE7C600FFE7
      C600FFDEBD00FFDEBD00CE6B0000000000000000000000000000000000000000
      000000000000AD8C8C00FFE7CE00009C00006BC66300009C0000009C0000B5B5
      B500FFE7CE00FFCEBD00A57B73000000000000000000B5847B00F7E7D600F7E7
      D60000FF000000FF000000FF000000FF000000FF000000FF000000FF0000FFDE
      AD00FFDEAD009C6B5A00000000000000000000000000CED6D6005AC6FF004A7B
      CE009C84A500EFCEBD00FFEFD600FFDECE00FFE7C600FFD6C600FFD6C600FFDE
      AD00FFDEAD00FFDEAD009C6B5A0000000000DE7B1800FFF7EF00FFF7EF00FFF7
      E700FFF7E700FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7CE00FFE7CE00FFE7
      C600FFDEC600FFDEBD00CE6B00000000000000000000A57B7300A57B7300A57B
      7300A57B7300BD948400FFEFDE00009C0000009C0000FFE7CE00B5B5B500009C
      0000FFE7CE00FFCEBD00A57B73000000000000000000B5847B00F7E7D600F7E7
      D60084848400848484008484840084848400848484008484840084848400FFDE
      AD00FFDEAD009C6B5A0000000000000000000000000000000000CED6D60073B5
      EF004A7BCE009C84A500FFE7D600F7DEBD00EFCEBD00FFD6C600FFD6C600FFD6
      C600FFDEAD00FFDEAD009C6B5A0000000000DE7B2100FFFFF700FFF7EF00FFF7
      EF00FFF7E700FFEFE700FFEFDE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7
      C600FFE7C600FFDEC600CE6B00000000000000000000A57B7300F7DECE00F7DE
      CE00F7DECE00BD948400FFEFDE00FFEFDE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFCEBD00A57B73000000000000000000C6948400FFF7E700FFF7
      E70000FF000000FF000000FF000000FF000000FF000000FF000000FF0000FFDE
      AD00FFDEAD00A57373000000000000000000000000000000000000000000C694
      840073B5EF007B84AD00D6AD9C00D6AD9C00E7A57B00D6AD9C00D6AD9C00FFD6
      C600FFD6C600FFDEAD009C736B0000000000E7842900FFFFF700FFF7EF00FFF7
      EF00FFF7EF00FFF7E700FFEFDE00FFEFDE00FFEFD600FFEFD60021942100FFE7
      CE00FFE7C600FFE7C600CE6B00000000000000000000BD948400FFE7CE00FFE7
      CE00FFE7CE00BD948400FFEFD600009C0000B5B5B500FFE7CE00009C0000009C
      0000FFE7CE00FFCEBD00A57B73000000000000000000C6948400FFF7E700FFF7
      E70084848400848484008484840084848400848484008484840084848400FFE7
      C600FFE7C600A57373000000000000000000000000000000000000000000C694
      8400FFFFF700D6AD9C00E7CE9C00FFE7B500FFFFDE00F7E7D600E7B5AD00D6AD
      9C00FFE7C600FFD6C6009C736B0000000000E78C2900FFFFF700FFFFF700FFF7
      EF00FFF7EF00FFF7E700FFF7E700FFEFDE00FFEFDE00FFEFD600219421002194
      2100FFE7CE00FFE7C600CE6B00000000000000000000BD948400FFE7CE00FFE7
      CE00FFE7CE00CE9C8400FFEFDE00B5B5B500009C0000009C00006BC66300009C
      0000FFE7CE00FFCEBD00A57B73000000000000000000C6948400FFF7F700FFF7
      F70000FF000000FF000000FF000000FF000000FF000000FF000000FF0000FFE7
      C600FFE7C600A57373000000000000000000000000000000000000000000C694
      8400FFFFF700D6AD9C00FFD69C00FFF7BD00FFFFE700FFFFF700FFE7C600D6AD
      9C00FFE7C600FFD6C600A573730000000000E78C3100FFFFFF00FFFFF700FFFF
      F700FFF7EF00FFF7EF00FFF7E700FFF7E7002194210021942100219421004ADE
      730021942100FFE7CE00CE6B00000000000000000000BD948400FFE7CE00FFE7
      CE00FFE7CE00CE9C8400FFF7E700FFFFFF006BC663006BC66300FFF7E700FFEF
      DE00FFE7CE00FFCEBD00A57B73000000000000000000D69C9C00FFF7F700FFF7
      F70084848400848484008484840084848400848484008484840084848400FFE7
      C600FFE7C600A57B73000000000000000000000000000000000000000000E7A5
      7B00FFFFFF00E7A57B00FFE7B500FFF7BD00FFFFDE00FFFFDE00FFFFD600E7A5
      7B00EFDED600FFE7C600A57B730000000000EF943900FFFFFF00FFFFF700FFFF
      F700FFFFF700FFF7EF00FFF7EF00FFF7E7002194210031C6520039CE5A004ADE
      73004ADE730021942100CE6B00000000000000000000BD948400FFEFD600FFEF
      D600FFEFD600DEA58C00FFF7F700FFFFFF00FFFFFF00FFFFF700FFF7EF00FFF7
      E700A57B7300A57B7300A57B73000000000000000000EFAD9400FFFFFF00FFFF
      FF0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000FFDE
      CE00FFDECE00A57B73000000000000000000000000000000000000000000E7A5
      7B00FFFFFF00D6AD9C00FFDECE00FFE7C600FFF7BD00FFF7BD00F7DEBD00D69C
      9C00E7DEDE00FFDECE00A57B730000000000EF9C4200FFFFFF00FFFFFF00FFFF
      F700FFFFF700FFF7EF00FFF7EF00FFF7E7002194210021942100219421004ADE
      730021942100FFEFD600CE6B00000000000000000000CE9C8400FFE7CE00FFE7
      CE00FFE7CE00DEA58C00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      EF00A57B7300DEA58C00000000000000000000000000EFAD9400FFFFFF00FFFF
      FF0000FF000000FF00008484840084848400848484008484840084848400FFD6
      C600E7B5AD00B5847B000000000000000000000000000000000000000000EFAD
      9400FFFFFF00DEBDB500DEBDB500EFE7CE00FFF7BD00FFDEAD00EFAD9400DEBD
      B500FFE7D600FFDECE00A57B730000000000F79C4A00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7E700FFF7E700219421002194
      2100FFEFD600FFEFD600CE6B00000000000000000000CE9C8400FFF7E700FFF7
      E700FFF7E700DEA58C00DEA58C00DEA58C00DEA58C00DEA58C00DEA58C00DEA5
      8C00A57B730000000000000000000000000000000000EFAD9400FFFFFF00FFFF
      FF0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000B584
      7B00B5847B00B5847B000000000000000000000000000000000000000000EFB5
      8400FFFFFF00FFFFFF00EFCEBD00D6AD9C00E7A57B00D6AD9C00DEBDB500FFDE
      CE00EFCEBD00EFAD9400B5847B0000000000F7A54A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7EF00FFF7E70021942100FFEF
      DE00FFEFDE00FFEFD600CE6B00000000000000000000DEA58C00FFF7EF00FFFF
      FF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00FFEFD600EFBD9400A57B73000000
      00000000000000000000000000000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFDED600B584
      7B00EF945200C6AD94000000000000000000000000000000000000000000F7C6
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700B584
      7B00B5847B00B5847B00B5847B0000000000DE842900DE842900DE842900DE84
      2900DE842900DE842900DE842900DE842900DE842900DE842900DE842900DE84
      2900DE842900DE842900C66B10000000000000000000DEA58C00FFFFF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00A57B7300A57B7300A57B73000000
      00000000000000000000000000000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700EFEFEF00EFDED600B584
      7B00D6AD9C00000000000000000000000000000000000000000000000000F7C6
      9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700B584
      7B00FFD69C00D6AD9C000000000000000000C66B1000C66B1000C66B1000C66B
      1000C66B1000C66B1000C66B1000C66B1000C66B1000C66B1000C66B1000C66B
      1000C66B1000C66B1000C66B10000000000000000000DEA58C00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7F700EFEFEF00A57B7300EFBD9400EFE7D6000000
      00000000000000000000000000000000000000000000F7C69C00E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00B584
      7B0000000000000000000000000000000000000000000000000000000000F7C6
      9C00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00B584
      7B00E7CE9C0000000000000000000000000000000000BD5A0000BD5A0000BD5A
      0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A
      0000BD5A0000BD5A0000000000000000000000000000EFBD9400DEA58C00DEA5
      8C00DEA58C00DEA58C00DEA58C00DEA58C00A57B7300EFE7D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300000000000000000000000000A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B73009C6B5A0000000000000000000000000000000000000000000000
      000000000000A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B73000000000000000000000000008C6B29008C6B
      29008C6B2900ADA5A500ADA5A500ADA5A500ADA5A500ADA5A500ADA5A5008C6B
      29008C6B29008C6B29008C6B2900000000000000000000000000000000000000
      000000000000A57B7300FFD6C600FFDECE00FFDECE00FFD6C600FFD6C600FFD6
      C600FFD6C600F7CEAD00A57B73000000000000000000000000009C636300FFE7
      D600FFDECE00FFDECE00FFD6C600FFD6C600FFD6C600FFDEAD00FFDEAD00FFDE
      AD00F7CEAD009C6B5A0000000000000000000000000000000000000000000000
      000000000000A57B7300FFCEBD00F7DECE00F7DECE00FFCEBD00FFCEBD00FFCE
      BD00FFCEBD00FFCEBD00A57B73000000000000000000D68C6300C67B5200C67B
      52008C6B29009CA59400D68C6300C6BDBD00EFEFEF00E7E7E700E7DEDE008C6B
      29008C6B2900C67B52008C6B2900000000000000000000000000000000000000
      000000000000B5847B00FFE7C600FFD69C00FFD69C00FFD69C00FFD69C00FFD6
      9C00FFD69C00EFCEBD00A57B7300000000000000000000000000A5737300FFEF
      DE00FFEFD600FFDECE00FFE7C600FFE7C600FFD6C600FFDEAD00FFDEAD00FFDE
      AD00FFD69C009C6B5A0000000000000000000000000000000000000000000000
      000000000000A57B7300FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFCEBD00A57B73000000000000000000D68C6300C67B5200C67B
      52008C6B2900C6BDBD00D6522900D68C6300CECECE00EFEFEF00E7E7E7008C6B
      29008C6B2900C67B52008C6B2900000000000000000000000000000000000000
      000000000000B5847B00FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600FFE7
      C600FFE7C600EFCEBD00A57B7300000000000000000000000000A57B7300FFEF
      DE00FFEFDE00FFEFD600EFDED6008C9CE700F7DEBD00FFD6C600FFDEAD00FFDE
      AD00FFDEAD009C63630000000000000000000000000000000000000000000000
      000000000000AD8C8C00FFE7CE00FFE7CE005A84EF00FFE7CE00FFE7CE005A84
      EF00FFE7CE00FFCEBD00A57B73000000000000000000D68C6300C67B5200C67B
      52008C6B2900F7CEAD008C6B29009C6B5A00ADA5A500CECECE00EFEFEF008C6B
      29008C6B2900C67B52008C6B29000000000000000000A57B7300A57B7300A57B
      7300A57B7300B5847B00FFDECE00FFDEAD00FFDEAD00FFDEAD00FFD69C00FFD6
      9C00FFD69C00EFCEBD00A57B7300000000000000000000000000B5847B00FFF7
      E700FFEFDE00ADBDEF00214AFF000031FF008C9CE700FFE7C600FFD6C600FFDE
      AD00FFDEAD009C636300000000000000000000000000A57B7300A57B7300A57B
      7300A57B7300BD948400FFEFDE00ADBDEF000031FF00ADBDEF00ADBDEF000031
      FF00ADBDEF00FFCEBD00A57B73000000000000000000D68C6300C67B5200C67B
      52008C6B2900F7CEAD00C69C9400C6BDBD009CA59400ADA5A500CECECE008C6B
      29008C6B2900C67B52008C6B29000000000000000000B5847B00FFDECE00FFDE
      CE00FFDECE00C6948400FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEF
      D600FFEFD600EFCEBD00A57B7300000000000000000000000000B5847B00FFF7
      EF00637BF7000031FF001042FF00214AFF000031FF00CECECE00FFE7C600FFD6
      C600FFDEAD009C736B00000000000000000000000000A57B7300F7DECE00F7DE
      CE00F7DECE00BD948400FFEFDE00FFEFDE00ADBDEF000031FF000031FF00ADBD
      EF00FFE7CE00FFCEBD00A57B73000000000000000000D68C6300C67B5200C67B
      5200C67B5200C67B5200C67B5200C67B5200C67B5200C67B5200C67B5200C67B
      5200C67B5200C67B52008C6B29000000000000000000B5847B00FFE7C600FFD6
      9C00FFD69C00C6948400FFEFDE00FFD69C00FFD69C00FFD69C00FFD69C00FFD6
      9C00FFD69C00EFCEBD00A57B7300000000000000000000000000C6948400FFFF
      F700B5C6F700637BF700EFDED600CED6D6000031FF00315AF700FFE7C600FFE7
      C600FFD6C6009C736B00000000000000000000000000BD948400FFE7CE00FFE7
      CE00FFE7CE00BD948400FFEFD600FFEFDE005A84EF000031FF000031FF005A84
      EF00FFE7CE00FFCEBD00A57B73000000000000000000D68C6300C67B5200C67B
      5200D68C6300D68C6300D68C6300D68C6300D68C6300D68C6300D68C6300D68C
      6300C67B5200C67B52008C6B29000000000000000000B5847B00FFDECE00FFDE
      CE00FFDECE00C6948400FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700EFCEBD00A57B7300000000000000000000000000C6948400FFFF
      F700FFFFF700FFF7EF00FFF7E700FFEFDE00637BF7000031FF009CB5D600FFE7
      C600FFD6C600A5737300000000000000000000000000BD948400FFE7CE00FFE7
      CE00FFE7CE00CE9C8400FFEFDE00ADBDEF000031FF00ADBDEF00ADBDEF000031
      FF00ADBDEF00FFCEBD00A57B73000000000000000000D68C6300C67B5200D68C
      6300EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00D68C6300C67B52008C6B29000000000000000000C6948400FFEFD600FFDE
      AD00FFDEAD00C6948400FFF7EF00FFFFFF00FFFFFF00FFFFF700FFF7E700FFF7
      E700FFE7D600EFCEBD00A57B7300000000000000000000000000E7A57B00FFFF
      FF00FFFFF700FFFFF700FFF7EF00FFF7E700EFDED6001042FF00214AFF00EFDE
      D600FFE7C600A57B7300000000000000000000000000BD948400FFE7CE00FFE7
      CE00FFE7CE00CE9C8400FFF7E700FFFFFF00ADBDEF00FFF7EF00FFF7E700ADBD
      EF00FFE7CE00FFCEBD00A57B73000000000000000000D68C6300C67B5200D68C
      6300EFEFEF00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00EFEF
      EF00D68C6300C67B52008C6B29000000000000000000C6948400FFEFDE00FFEF
      DE00FFEFDE00E7A57B00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      E700B5847B00B5847B00B5847B00000000000000000000000000E7A57B00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7E7009CA5EF00315AF700E7DE
      DE00FFDECE00A57B7300000000000000000000000000BD948400FFEFD600FFEF
      D600FFEFD600DEA58C00FFF7F700FFFFFF00FFFFFF00FFFFF700FFF7EF00FFF7
      E700A57B7300A57B7300A57B73000000000000000000D68C6300C67B5200D68C
      6300EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00D68C6300C67B52008C6B29000000000000000000C6948400FFF7E700FFD6
      9C00FFD69C00EFAD9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700B5847B00E7A57B0000000000000000000000000000000000EFAD9400FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7E700FFEFDE00FFE7
      D600FFDECE00A57B7300000000000000000000000000CE9C8400FFE7CE00FFE7
      CE00FFE7CE00DEA58C00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      EF00A57B7300DEA58C00000000000000000000000000D68C6300C67B5200D68C
      6300EFEFEF00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00EFEF
      EF00D68C6300C67B52008C6B29000000000000000000E7A57B00FFF7EF00FFF7
      EF00FFF7EF00EFAD9400E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A5
      7B00B5847B000000000000000000000000000000000000000000EFB58400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFE7D600EFCE
      BD00EFAD9400B5847B00000000000000000000000000CE9C8400FFF7E700FFF7
      E700FFF7E700DEA58C00DEA58C00DEA58C00DEA58C00DEA58C00DEA58C00DEA5
      8C00A57B730000000000000000000000000000000000D68C6300C67B5200D68C
      6300EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00D68C6300C67B52008C6B29000000000000000000D69C9C00FFFFF700FFFF
      FF00FFFFFF00FFFFF700FFF7EF00FFE7D600EFB58400B5847B00000000000000
      0000000000000000000000000000000000000000000000000000F7C69C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700B5847B00B584
      7B00B5847B00B5847B00000000000000000000000000DEA58C00FFF7EF00FFFF
      FF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00FFEFD600EFBD9400A57B73000000
      00000000000000000000000000000000000000000000D68C63008C6B2900D68C
      6300C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BD
      BD00D68C63008C6B2900848484000000000000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700B5847B00B5847B00B5847B00000000000000
      0000000000000000000000000000000000000000000000000000F7C69C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700B5847B00FFD6
      9C00D6AD9C0000000000000000000000000000000000DEA58C00FFFFF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00A57B7300A57B7300A57B73000000
      00000000000000000000000000000000000000000000D68C6300D68C6300D68C
      6300D68C6300D68C6300D68C6300D68C6300D68C6300D68C6300D68C6300D68C
      6300D68C6300D68C6300000000000000000000000000EFB58400FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7EF00B5847B00EFAD940000000000000000000000
      0000000000000000000000000000000000000000000000000000F7C69C00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00B5847B00D6AD
      9C000000000000000000000000000000000000000000DEA58C00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7F700EFEFEF00A57B7300EFBD9400EFE7D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFAD9400E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00B5847B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFBD9400DEA58C00DEA5
      8C00DEA58C00DEA58C00DEA58C00DEA58C00A57B7300EFE7D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ADADAD00635A
      5A005A424200634A4A004A424200424242004A4A4A0084848400D6D6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010A5CE0010A5
      CE0010A5CE0010A5CE005AC6FF005AC6FF000000000000000000000000000000
      0000000000000000000000000000000000000000000010A5CE0010A5CE0010A5
      CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE00009C
      D6000000000000000000000000000000000000000000AD949400B5A5A500DED6
      D600DED6D600DED6D600D6B5B500BD949400845A5A004A4A4A007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010A5CE006BB5
      F7005AC6FF0073B5EF0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5
      CE00000000000000000000000000000000000000000010A5CE005AC6FF005AC6
      FF005AC6FF005AC6FF005AC6FF005AC6FF005AC6FF005AC6FF005AC6FF0010A5
      CE0010A5CE00000000000000000000000000DEC6C600E7E7E700F7FFFF00EFEF
      EF00E7E7E700DECECE00DED6D600CEC6C600CEA5A500A57B73005A5A5A00DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5633900AD520000C694
      84000000000000000000000000000000000010A5CE0010A5CE0010A5CE0010A5
      CE00DEEFEF008CFFFF008CFFFF008CFFFF008CFFFF005AC6FF0073B5EF0010A5
      CE0010A5CE000000000000000000000000000000000010A5CE0084DEF70084DE
      F70084DEF70084DEF70084DEF70084DEF70084DEF70084DEF70084DEF70010A5
      CE00ADF7FF0010A5CE000000000000000000D6BDBD00FFFFFF00FFFFFF00F7FF
      FF00E7EFEF00DEC6C600DEB5B500D69C9C00CE9C9C00DEA5A50052525200A5A5
      A500CECECE00E7E7E70000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B55A2100CE630000AD52
      0000BDADB50000000000000000000000000010A5CE008CFFFF0010A5CE005AC6
      FF00DEEFEF0094FFFF008CFFFF008CFFFF008CFFFF008CFFFF009CEFFF005ADE
      FF0010A5CE0073B5EF0000000000000000000000000010A5CE0084DEF70084DE
      F70084DEF70084DEF70084DEF70084DEF70084DEF70084DEF70084DEF70010A5
      CE0010A5CE0010A5CE0010A5CE0000000000F7E7E700EFEFEF00F7DEE700EFE7
      F700E7F7F700DEB5B500CE737300A56B6B0094737B00AD7B8C005A4A52004A4A
      4A00525252006B6B6B00A5A5A500000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6CECE00CE630000CE63
      0000B55A2100C6CECE00000000000000000010A5CE00CED6D60010A5CE005AC6
      FF005AC6FF008CFFFF0094FFFF0094FFFF008CFFFF0094FFFF008CFFFF009CEF
      FF005AC6FF0010A5CE0000000000000000000000000010A5CE0084DEF70084DE
      F70084DEF70084DEF70084DEF70084DEF70084DEF70084DEF70084DEF70084DE
      F70084DEF70084DEF70010A5CE000000000000000000FFF7F700C6847300E7A5
      7300D6ADB500BD737B009C8C8C00CEDED600D6DEDE00318C39004A8C5200BDB5
      C6008C949C0052525A0052525200848484000000000000000000AD520000C663
      0800C6630800C6630800C6630800C6630800AD5200009C6B5A00BDADB500AD52
      0000CE630000AD520000000000000000000010A5CE005AC6FF0010A5CE005AC6
      FF005AC6FF00EFFFFF00EFFFFF00EFFFFF0094FFFF008CFFFF0094FFFF008CFF
      FF009CEFFF0010A5CE00CED6D600000000000000000010A5CE008CFFFF008CFF
      FF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFF
      FF008CFFFF008CFFFF0010A5CE000000000000000000F7EFF700D68C5A00FFAD
      0000FFAD2100B5A59400FFFFFF00FFFFFF00F7FFF70031A5290073C67B00EFE7
      EF00A5735A00A58C7B00525A5A004A4A4A000000000000000000AD520000D673
      0000D66B0000CE630000CE630000CE630000CE630000A563390000000000B584
      7B00C6630800CE630000000000000000000010A5CE005AC6FF0010A5CE009CFF
      FF005AC6FF0073B5EF0010A5CE005AC6FF005AC6FF00EFFFFF00EFFFFF0094FF
      FF008CFFFF005AC6FF0010A5CE00000000000000000010A5CE008CFFFF008CFF
      FF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFF
      FF008CFFFF008CFFFF0010A5CE000000000000000000DECED600E7A55A00FFBD
      1800FFB51800ADBDDE000818EF00394AD600FFFFFF00FFFFFF00FFFFFF00EFCE
      BD00C6420000E7A57300B5BDC600525252000000000000000000C6630800DE73
      0000DE730000CE630000B5847B00B5847B00B5847B00C6BDBD0000000000C6CE
      CE00AD520000CE630000000000000000000010A5CE005AC6FF0010A5CE008CFF
      FF0094FFFF008CFFFF008CFFFF009CEFFF005AC6FF005AC6FF005AC6FF005AC6
      FF005AC6FF00CED6D60010A5CE00000000000000000010A5CE009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0010A5CE000000000000000000CEB5BD00EFB55200FFCE
      3900F7B54200D6DEE700A5B5FF009CADFF00FFFFFF00FFFFFF00E7E7EF00F7F7
      FF00FFFFFF00FFFFFF00E7E7E7008C8C8C000000000000000000CE630000F794
      0800AD520000AD520000D66B0000A5633900C6CECE0000000000000000000000
      0000A5633900CE630000C6CECE000000000010A5CE009CFFFF0010A5CE008CFF
      FF008CFFFF0094FFFF00EFFFFF008CFFFF00DEEFEF0094FFFF0094FFFF0010A5
      CE0010A5CE0010A5CE0010A5CE00000000000000000010A5CE009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF0010A5CE000000000000000000C6A5AD00FFBD5200FFD6
      5A00FFCE5A00CEBDA500FFFFFF00E7EFEF00C6D6E700FFFFFF0073737300636B
      6300D6DEDE00B5B5B500BDB5BD00000000000000000000000000D66B0000F794
      0800CE7B3100C6948400E7840000D66B0000B55A2100BDADB50000000000BDAD
      B500AD520000CE630000000000000000000010A5CE008CFFFF0010A5CE00EFFF
      FF0094FFFF00EFFFFF00EFFFFF0031BDDE0008A5EF00398CEF0010A5CE0010A5
      CE00000000000000000000000000000000000000000010A5CE00C6FFFF00C6FF
      FF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FF
      FF00C6FFFF00C6FFFF0010A5CE000000000000000000CEADA500FFCE5A00FFDE
      7B00FFE77B00EFCE7300D6D6D6003994F700006BE700FFFFFF00FFEFE700DED6
      D600848484005A5A5A00D6D6D600000000000000000000000000CE7B3100FF9C
      3100CE7B310000000000C6630800E7840000E7840000AD5200009C736B00AD52
      0000CE630000CE630000000000000000000010A5CE008CFFFF008CFFFF0008A5
      EF0008A5EF0008A5EF0008A5EF008CFFFF008CFFFF0010A5CE00000000000000
      0000000000000000000000000000000000000000000010A5CE00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF0010A5CE0000000000DEDEDE00D6BD9C00FFDE6B00FFE7
      8C00FFE79C00FFEF9400E7CE8C00CED6D600CEEFFF00D6FFFF0018A5CE00D6FF
      FF00E7DED6006B6B6B00E7E7E700000000000000000000000000B5847B00C67B
      5200C6AD94000000000000000000C6CECE00B5847B00C6630800D66B0000C663
      0800A5633900BDADB500000000000000000010A5CE008CFFFF00EFFFFF00EFFF
      FF0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE00000000000000
      0000000000000000000000000000000000000000000010A5CE00DEFFFF00DEFF
      FF00DEFFFF00DEFFFF00DEFFFF00DEFFFF00DEFFFF00DEFFFF00DEFFFF00DEFF
      FF00DEFFFF00DEFFFF0010A5CE0000000000C6C6CE00E7C68C00FFEF7B00FFF7
      A500FFFFB500FFFFBD00FFFFAD00F7DE8C00E7D6AD00C6E7EF0063E7FF00D6FF
      FF00CEC6C600DEDEDE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDA5A500C6BD
      BD00000000000000000000000000000000000000000010A5CE0010A5CE0010A5
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010A5CE00EFFFFF00EFFF
      FF00EFFFFF00EFFFFF00EFFFFF00EFFFFF00EFFFFF00EFFFFF00EFFFFF00EFFF
      FF00EFFFFF00EFFFFF0010A5CE0000000000D6CED600ADA59C00B59C8C00CEB5
      9400DED6AD00F7F7CE00FFFFCE00FFFFBD00FFF78C009C6B63009C949400CECE
      CE00F7F7F7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010A5CE0010A5CE0010A5
      CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5CE0010A5
      CE0010A5CE0010A5CE0010A5CE0000000000E7E7E700DEDEE700CEC6CE00B5A5
      AD00AD949C00AD8C9400B5949400CEAD9400DEBD8C009C6B6B00B5B5B500F7F7
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7EFEF00DED6D600CEBDBD00BD949C00D6BDBD00F7F7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6CECE00CEA5A500C69C94009CA59400ADA5A500C6CECE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEC6CE00D6B5B500CEADAD00BDB5B500C6CECE000000
      0000000000000000000000000000000000000000000010A5CE0010A5CE0010A5
      CE003194B50084C6EF009CB5D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010A5CE0010A5CE0010A5
      CE003194B50084C6EF009CB5D600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDC6
      CE00CEA5A500D69C9C00D69C9C00CEA5A5009CA594009CA5940094848C00ADA5
      A500C6CECE000000000000000000000000000000000000000000000000000000
      0000CEC6C600D6B5B500D6B5B500DEBDBD00C6B5B500ADADAD00ADA5A500BDB5
      B500000000000000000000000000000000000000000010A5CE0073B5EF005AC6
      FF0031BDDE0010A5CE001094C6001094C6003194B50042B5C60042B5C6000000
      0000000000000000000000000000000000000000000010A5CE0073B5EF005AC6
      FF0031BDDE0010A5CE001094C6001094C6003194B50042B5C60042B5C6000000
      00000000000000000000000000000000000000000000C6BDBD00CEA5A500D69C
      9C00CEA5A500CEA5A500D69C9C00C694840073635A009C736B0094AD7B0094AD
      7B00BDADB5000000000000000000000000000000000000000000CEC6C600D6B5
      B500D6B5B500DEC6C600DEC6C600D6B5B500BD8C8C00A58C8C00ADA5A5009CBD
      9C00B5A5A5000000000000000000000000000000000010A5CE0042B5C600A5EF
      FF005ADEFF005ADEFF005ADEFF005ADEFF0031C6E70031BDDE0010A5CE0010A5
      CE00000000000000000000000000000000000000000010A5CE0042B5C600A5EF
      FF005ADEFF005ADEFF005ADEFF005ADEFF0031C6E70031BDDE0010A5CE0010A5
      CE0000000000000000000000000000000000C6BDBD00CEA5A500DEBDB500DEBD
      B500C69C9400B5847B00D69C9C00CEA5A500A57373009C6B5A0073635A009C6B
      5A00BDADB500000000000000000000000000CECECE00D6BDBD00D6B5B500E7CE
      CE00E7CECE00D6B5B500CEA5A500D6A5A500C69C9C00A57B7B009C6B6B00A594
      8400B59C9C000000000000000000000000000000000010A5CE0031BDDE00B5E7
      FF007BF7FF007BF7FF007BF7FF007BF7FF007BF7FF007BF7FF005AC6FF0010A5
      CE0094C6EF000000000000000000000000000000000010A5CE0031BDDE00B5E7
      FF007BF7FF007BF7FF007BF7FF007BF7FF007BF7FF007BF7FF005AC6FF0010A5
      CE0094C6EF00000000000000000000000000D69C9C00CEA5A500C69C9400CEA5
      A500DEBDB500DEBDB500DEBDB500CEA5A500A5737300B5847B00A57373009C6B
      5A00BDADB500000000000000000000000000D6ADAD00E7CECE00E7CECE00D6A5
      A500D6ADAD00DEBDBD00DEC6C600DEBDBD00C6A5A500B5848400AD848400A57B
      7B00A58484000000000000000000000000000000000010A5CE005AC6FF0073B5
      EF0094FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF005ADEFF0031BD
      DE0010A5CE000000000000000000000000000000000010A5CE005AC6FF0073B5
      EF0094FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF005ADEFF0031BD
      DE0010A5CE00000000000000000000000000D69C9C00DEBDB500E7DEDE00CECE
      CE00DEBDB500DEBDB500DEBDB500CEA5A500A5737300B5847B00B5847B00A573
      7300BDADB500000000000000000000000000D6ADAD00D6ADAD00DECECE00E7DE
      DE00E7D6D600E7CECE00DEC6C600DEBDBD00CEA5A500BD8C8C00CE9C9C00C694
      9400AD8C8C000000000000000000000000000000000010A5CE005AC6FF0010A5
      CE00C6FFFF00CEFFFF00C6FFFF00ADF7FF009CFFFF009CFFFF0084DEF70084DE
      F70010A5CE008CADD60000000000000000000000000010A5CE005AC6FF0010A5
      CE00C6FFFF00CEFFFF00C6FFFF00ADF7FF009CFFFF009CFFFF0084DEF70084DE
      F70010A5CE008CADD6000000000000000000D69C9C00E7E7E700E7DEDE00CECE
      CE00DEBDB500DEBDB500DEBDB500CEA5A500A57373009C6B5A009C6B5A009C6B
      5A00BDADB500000000000000000000000000D6ADAD00EFEFEF00EFE7E700EFDE
      DE00E7D6D600E7CECE00DEC6C600DEBDBD00CE9C9C00AD7B7B00AD737300BD8C
      8C00AD8C8C000000000000000000000000000000000010A5CE0084DEF7005ADE
      FF0031BDDE0031BDDE0031BDDE008CC6EF00DEFFFF00CEFFFF0084DEF70039AD
      4A0073B5EF0010A5CE0000000000000000000000000010A5CE0084DEF7005ADE
      FF0031BDDE0031BDDE0031BDDE008CC6EF00DEFFFF00CEFFFF0084DEF70094E7
      FF0073B5EF0010A5CE000000000000000000D69C9C00E7E7E700E7DEDE00CECE
      CE00DEBDB500DEBDB500DEBDB500CEA5A5009C6B5A00A57373009C6B5A007B7B
      73008CA5BD00000000000000000000000000D6ADAD00EFEFEF00EFE7E700EFDE
      DE00E7D6D600E7CECE00DEC6C600DEBDBD00C6949400B5848400A5737300B584
      8400AD8484000000000000000000000000000000000010A5CE0094FFFF007BF7
      FF007BF7FF007BF7FF007BF7FF004AE7FF0031BDDE0039D6730039AD4A0018AD
      100018AD100010A5CE0000000000000000000000000010A5CE0094FFFF007BF7
      FF007BF7FF007BF7FF007BF7FF004AE7FF00ADBDEF0052ADF70073B5EF0073B5
      EF00ADD6EF0010A5CE000000000000000000D69C9C00E7E7E700E7DEDE00CECE
      CE00DEBDB500DEBDB500DEBDB500C69C94009C6B5A009C6B5A00525ABD00525A
      BD00637BEF00637BEF00B5BDD60000000000D6ADAD00EFEFEF00EFE7E700EFDE
      DE00E7D6D600E7CECE00DEC6C600DEBDBD00C6848400635AB500314AE700BD8C
      9C00B5848400000000004A6BEF004263F7000000000010A5CE00ADF7FF008CFF
      FF008CFFFF00ADF7FF00ADF7FF00C6FFFF009CEFFF0039AD4A0018AD100039AD
      4A0039AD4A0039AD4A0000000000000000000000000010A5CE00ADF7FF008CFF
      FF008CFFFF00ADF7FF00ADF7FF00ADBDEF001042FF00637BEF0031BDDE006373
      E7003152F70010A5CE000000000000000000D69C9C00E7E7E700E7DEDE00CECE
      CE00DEBDB500DEBDB500DEBDB500DEBDB500B5847B009C6B5A001039FF001042
      FF001042FF000031FF00B5BDD60000000000D6ADAD00EFEFEF00EFE7E700EFDE
      DE00E7D6D600E7CECE00DEC6C600DEBDBD00CE848400A5638C000839F7002142
      EF009C7394004263F7000839FF007B94E7000000000010A5CE0084C6EF0084DE
      F700CEFFFF008CC6EF0010A5CE0010A5CE0010A5CE0010A5CE0039AD4A0039D6
      730039D673000000000000000000000000000000000010A5CE0084C6EF0084DE
      F700CEFFFF008CC6EF0010A5CE0010A5CE003152F7000031FF00214AFF000031
      FF003152F700000000000000000000000000D69C9C00E7E7E700E7DEDE00E7DE
      DE00EFDED600EFDED600F7EFEF00F7EFEF00DEEFEF003152F7001039FF005ADE
      FF005ADEFF00214AFF003152F700B5BDD600D6ADAD00EFEFEF00EFE7E700EFDE
      DE00EFDEDE00EFE7E700F7E7E700FFF7F700FFFFFF00F7DEDE00BDA5CE001039
      FF000031FF000839FF00A5B5DE0000000000000000000000000010A5CE0010A5
      CE0010A5CE0010A5CE000000000000000000000000000000000039AD4A0039D6
      730000000000000000000000000000000000000000000000000010A5CE0010A5
      CE0010A5CE0010A5CE000000000000000000000000001042FF000031FF001042
      FF0000000000000000000000000000000000D69C9C00CEA5A500CEA5A500CEA5
      A500CEA5A500CEA5A500CEA5A500C69C9400CEA5A5007B84AD00315AF70039A5
      FF0039A5FF00315AF7008C9CE70000000000D6ADAD00E7D6D600E7CECE00E7CE
      CE00E7CECE00E7CECE00E7CECE00E7CECE00E7CECE00DEC6C600CEB5C6002952
      FF000031FF000839FF00A5B5DE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000039AD4A0039D6730039D6
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000637BF7000031FF000031FF000031
      FF00637BEF000000000000000000000000000000000000000000C6BDBD00CEA5
      A500BDA5A500C6BDBD00BDC6CE0000000000000000009CB5D6000031FF00315A
      F700315AF7000031FF009CB5D6000000000000000000CEC6CE00CEBDBD00CEAD
      B500CEADAD00CEADAD00CEBDBD00CEBDC600C6BDBD00A5B5DE001842FF002152
      F700A5B5DE002152F7000839FF00A5B5DE000000000000000000000000000000
      00000000000000000000000000000000000039AD4A0039D6730039D673000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADBDEF000031FF003152F700000000003152
      F7001042FF00ADBDEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5BDD600637B
      EF00637BEF00B5BDD60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006384EF002152F700BDC6
      DE0000000000BDC6DE004263F7004263F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADBDEF0000000000000000000000
      0000ADBDEF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      D600B5BDD6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009CBDBD00218C21000000
      0000000000000000000000000000000000000000000031BDDE0031BDDE009CB5
      D600BDC6CE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDBDC6007B8484006B6B6B00848C8C00A5ADAD00ADB5
      B500B5B5BD00BDBDC600C6C6CE00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000039AD4A00009C
      1000000000000000000000000000000000000000000031BDDE00ADD6EF0010A5
      CE00009CD60010A5CE0042B5C6009CB5D600ADC6D60000000000000000000000
      000000000000000000000000000000000000D6730000D6730000D6730000D673
      0000D6730000D6730000D6730000D6730000D6730000D6730000D6730000D673
      0000D6730000D6730000D6730000000000000000000000000000000000000000
      00000000000000000000E7BD9C00F7C69400A5846B005A5A63006B6B6B006B6B
      6B006B6B6B00737B7B008C8C9400ADB5B5000000000000000000000000000000
      0000000000000000000000000000000000007BB55A007BB55A0039AD4A00009C
      10007BB55A0039AD4A007BB55A00000000000000000031BDDE0084C6EF00A5EF
      FF0084DEF7005AC6FF0031BDDE001094C600009CD60010A5CE0042B5C6009CB5
      D60000000000000000000000000000000000D6730000FFF7EF00FFF7E700FFEF
      DE00FFEFD600FFE7CE00FFE7C600FFDEC600FFDEBD00FFDEB500FFD6AD00FFD6
      AD00FFD6A500FFD6A500D673000000000000000000000000000000000000C6CE
      CE00BDBDC600ADB5B500B5A59C00EFCEAD00FFDEB500F7CEAD00F7CEA500EFCE
      A500D6AD8C00A58C7B005A635A00737B7B0000000000B5BDD600B5BDD6000000
      0000BDC6CE009CB5D600000000000000000000000000000000007BB55A0094AD
      7B00000000000000000000000000000000000000000031BDDE0052ADF700C6FF
      FF008CFFFF008CFFFF008CFFFF00187B180039AD4A005ADEFF0052BDFF0031BD
      DE00BDC6CE00000000000000000000000000D6730000FFF7EF00FFF7E700FFEF
      E700FFEFDE00FFEFD600FFE7CE00FFE7C600FFDEBD00FFDEBD00FFDEB500FFD6
      AD00FFD6AD00FFD6A500D6730000000000000000000000000000C6C6CE00A5AD
      AD00737B7B00735A42006B5239005A4A420073635A007B6B6300A5948400BDA5
      9400D6BDAD00FFDEB500D6AD8C006B6B6B00637BEF002973DE00315AF7004A7B
      CE006373E700214AFF004A7BCE009CBDBD000000000000000000000000000000
      000031C631000000000000000000000000000000000031BDDE005AC6FF00C6FF
      FF008CFFFF008CFFFF008CFFFF0039D67300218C2100218C210084DEF70084DE
      F7008CADD600000000000000000000000000D6730000FFFFF700FFF7EF00FFF7
      E700FFEFDE00FFEFDE00FFEFD600FFE7CE00FFE7C600FFDEBD00FFDEB500FFD6
      B500FFD6AD00FFD6A500D67300000000000000000000C6C6CE00A59C8C00AD63
      3100CE633100BD634200CE634A00C6633900AD522900634229004A4A4A00525A
      5A006B6B6B00E7C6A500EFC69C00949494002973DE002973DE008CADD600637B
      EF00315AF700214AFF006373E7009CB5D600000000007BB55A007BB55A007BB5
      5A00218C210031C6310000000000000000000000000031BDDE0084DEF7007BBD
      EF00ADF7FF009CFFFF009CFFFF0084DEF700218C210039D6730039AD4A00ADF7
      FF0031BDDE00000000000000000000000000D6730000FFFFF700FFFFEF00FFF7
      EF00FFF7E700FFEFDE0042AD4A0008A5180008A51800008C0000FFDEBD00FFDE
      B500FFD6AD00FFD6AD00D673000000000000C6CECE00ADA58C00BD5A1800AD42
      10009C421000735A2100A53908009C390800B55A3100E7B58C00E7AD8400A57B
      6300CEB59C00FFEFC600A59C8C00BDBDC6002973DE00398CEF00000000000000
      00006373E700315AF700000000006BAD940039AD4A0000000000000000000000
      0000000000000000000039AD4A00000000000000000031BDDE0084DEF70031BD
      DE00ADD6EF00E7FFFF00DEFFFF00C6FFFF00187B180039D67300218C2100ADD6
      EF00B5E7FF009CB5D6000000000000000000D6730000FFFFFF00FFFFF700FFF7
      EF00FFF7EF00FFF7E70042AD4A0029CE6B0039DE8C00008C0000FFDEBD00FFDE
      BD00FFDEB500FFD6AD00D673000000000000C6BDB500B55A1000A5390000AD42
      0000AD4A0000106B08005A520000A55A3100E7B58C00F7CEA500DEAD8400EFCE
      AD00F7E7CE0084736B008C8C9400C6C6CE00637BEF00315AF7008C9CE7000000
      00006373E700315AF700000000000000000018AD10007BB55A0039AD4A0039AD
      4A007BB55A0039AD4A007BB55A00000000000000000031BDDE0094E7FF0084DE
      F7005ADEFF0031C6E70031BDDE00ADD6EF00529C310039D6730039AD4A006BAD
      9400F7FFFF0073B5EF000000000000000000D6730000FFFFFF00FFFFF700FFFF
      F700FFF7EF00FFF7E70031A5390029CE6B0031D68400008C0000FFE7C600FFDE
      BD00FFDEBD00FFDEB500D673000000000000CE9C6300AD420000B5520000C65A
      0000AD630000007B0000738C4200DEA58400E7BD9400F7D6AD00F7DEB500E7B5
      9400E7AD84007B635A0094949400C6CECE00000000009CB5D6006373E700315A
      F7002973DE00315AF700000000000000000000000000000000006BAD94007BB5
      5A00000000000000000000000000000000000000000031BDDE009CFFFF0094FF
      FF0094FFFF0094FFFF0094FFFF0031BDDE000063310039D6730039D6730039AD
      4A0031BDDE0031BDDE000000000000000000D6730000FFFFFF00FFFFFF00FFFF
      F70031AD3100008C000018A521006BDE940031D67B0008A51800008C0000008C
      0000FFDEBD00FFDEB500D673000000000000CE732100BD520000CE630000DE73
      00006B840000008C00006B943900DEA58400EFCEAD00F7DEBD00FFF7CE00FFEF
      C600FFE7BD009C847300B5B5BD0000000000637BEF00398CEF0000000000B5BD
      D6002973DE00315AF700C6BDBD00C6630800C67B520000000000CEA5A500AD52
      0000D68C63000000000000000000000000000000000031BDDE00C6FFFF009CFF
      FF009CFFFF00C6FFFF00D6FFFF00C6FFFF000884180039D6730039D67300297B
      290000000000000000000000000000000000D6730000FFBD7300FFBD7300FFBD
      7300FFBD730031AD310031AD3100BDEFC60073E7AD0010AD2900008C0000FFBD
      7300FFBD7300FFBD7300D673000000000000CE7B2100CE6B0000B57B00005A94
      080010A51000319C0800EF941800EFCEAD00EFCEAD00FFDEB500F7D6A500E7C6
      9C009C7B5A00848C8C00C6C6CE0000000000637BEF00398CEF00B5BDD600BDC6
      CE00315AF700315AF70000000000CE7B3100CE630000CECECE00CEA5A500AD52
      0000D68C63000000000000000000000000000000000031BDDE00ADD6EF00CEFF
      FF00C6FFFF0031BDDE0031BDDE0031BDDE00218C210039D6730039D67300297B
      290000000000000000000000000000000000D6730000FFBD7300FFBD7300FFBD
      7300FFBD7300FFBD730031AD310052B5520073C67B00008C0000FFBD7300FFBD
      7300FFBD7300FFBD7300D673000000000000DE842900CE7B000018A5210018B5
      310018BD3900CEBD3900FFB52900F79C2100CEA54A00B5B57300ADAD7300296B
      1000735A290094949400C6CECE0000000000B5BDD600398CEF00398CEF00315A
      F700315AF7008C9CE70000000000C6AD9400C6630800D68C6300C6948400AD52
      0000D68C6300000000000000000000000000000000000000000031BDDE0031BD
      DE0031BDDE0000840000008400000884180039AD4A0039D6730039D67300187B
      180008841800088418000000000000000000D6730000FFBD7300FFBD7300FFBD
      7300FFBD7300FFBD7300FFBD730031A53900008C0000FFBD7300FFBD7300FFBD
      7300FFBD7300FFBD7300D673000000000000E7A54A00B58C080021BD420031CE
      630042CE6B005AD67300E7D67300FFB53900CE940000008C0000007B0000106B
      000084634200ADB5B50000000000000000009CADF700637BEF009CB5D6009CB5
      D600B5BDD6000000000000000000CE7B3100D66B0000CE630000C6630800C663
      0800D68C63000000000000000000000000000000000000000000000000000000
      00000000000039AD4A000894100031C6310039AD4A0039AD4A0039D67300218C
      2100008400007BB55A000000000000000000D6730000DE730000DE730000DE73
      0000DE730000DE730000DE730000DE730000DE730000DE730000DE730000DE73
      0000DE730000DE730000D66B000000000000E7D6B50031AD310031CE5A0063DE
      84009CEF9C0084E79C00C6EFA500D6C65A00C69C1000738C0000008400005A73
      000094949400C6C6CE000000000000000000000000008C9CE700637BEF000000
      00000000000000000000CEA5A500E7840000C67B520000000000C6948400CE63
      0000D68C63000000000000000000000000000000000000000000000000000000
      000000000000BDC6CE00187B1800009C100031C6310039AD4A00218C2100297B
      29009CBDBD00000000000000000000000000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE6B080000000000D6D6D6008CD6840039CE6B007BE7
      9400BDF7BD00ADF7B50084E7940029C65A008CA51800E7840000528400009C8C
      6300BDBDC6000000000000000000000000000000000000000000000000000000
      00000000000000000000C6BDBD00E7840000CE7B3100C6AD9400C6948400D66B
      0000D68C63000000000000000000000000000000000000000000000000000000
      000000000000000000009CBDBD0000840000009C1000187B18006BAD94000000
      000000000000000000000000000000000000CEC6BD00D6731000D6731000D673
      1000D6731000D6731000D6731000D6731000D6731000D6731000D6731000D673
      1000D6731000D6731000CECECE000000000000000000D6D6D600ADDE9C007BE7
      940094EFA5008CEF9C0052DE7B0029C65200849C1800EF8C0800C6A56B00C6C6
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D68C6300DE730000D66B0000D66B0000D66B
      0000D68C63000000000000000000000000000000000000000000000000000000
      000000000000000000000000000039AD4A00297B2900BDC6CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6DE
      BD00ADDEAD00ADDE8400B5C6520084C66300C6B56B00C6C6B500C6CECE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C69C9400000000000000000000000000000000000000000000000000C69C
      94000000000000000000000000000000000000000000A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B73009C6B5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D69C9C00D69C9C00CEA5
      A500C6BDBD00C6CECE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C694
      8400C6630800BDA5A500BDA5A500BDA5A500BDA5A500BDA5A500BDA5A500B55A
      2100C67B520000000000000000000000000000000000A57B7300FFE7D600FFE7
      D600FFE7D600FFDECE00FFE7C600FFE7C600FFE7C600FFDEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A0000000000000000000000000000000000000000000000
      0000C6CECE00ADA5A5009CA59400ADA5A500BDA5A500ADA5A500ADA5A500ADAD
      BD000000000000000000000000000000000000000000D69C9C00D69C9C00F7C6
      9C00EFAD9400D6AD9C00D69C9C00CEA5A500C6BDBD00C6CECE00000000000000
      0000000000000000000000000000000000000000000000000000C6BDBD00CE7B
      3100F7940800CE7B3100CE7B3100CE7B3100CE7B3100CE7B3100CE7B3100C663
      0800C6630800C6BDBD00000000000000000000000000A57B7300FFE7D600FFE7
      D600F7E7D600F7E7D600FFE7C600FFE7C600FFDEAD00FFDEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A000000000000000000000000000000000000000000BDC6
      CE009CA594009CA594009CA59400BDA5A500BDA5A500BDA5A500CEA5A500DEBD
      B5009CA5940000000000000000000000000000000000D69C9C00F7C69C00D6AD
      9C00FFDEAD00FFD69C00FFD69C00F7C69C00EFAD9400D6AD9C00D69C9C00CEA5
      A500C6BDBD00C6CECE0000000000000000000000000000000000000000000000
      0000A5633900000000000000000000000000000000000000000000000000A563
      3900BDADB50000000000000000000000000000000000B5847B00F7E7D600F7E7
      D600F7E7D600F7E7D600F7E7D600F7E7D600FFE7C600FFDEAD00FFDEAD00FFDE
      AD00FFDEAD009C6B5A0000000000000000000000000000000000BDC6CE00297B
      290084848400D6CEAD00FFEFCE00F7EFE700637BF700FFF7EF00F7F7D600ADA5
      A500DEBDB500ADA5A500000000000000000000000000D69C9C00FFDEAD00E7B5
      AD00F7CEAD00FFF7BD00FFE7B500FFE7B500FFDEAD00FFD69C00FFD69C00F7C6
      9C00EFAD9400D69C9C00D69C9C0000000000BDADB500A5633900A5633900A563
      3900000000000000000000000000A5633900A5633900A5633900A56339000000
      00000000000000000000000000000000000000000000B5847B00F7E7D600F7E7
      D600FFF7E700FFF7E700F7E7D600F7E7D600F7E7D600FFDEAD00FFDEAD00FFDE
      AD00FFDEAD009C6B5A000000000000000000000000000000000039AD4A0039D6
      7300218C2100FFE7B500FFE7B500FFDEAD00FFDEAD00FFE7B500FFF7E700FFFF
      E700ADA5A500CEA5A500BDC6CE000000000000000000D69C9C00FFF7BD00FFF7
      BD00D6AD9C00FFE7C600FFF7BD00FFF7BD00FFF7BD00FFF7BD00FFE7B500FFE7
      B500F7C69C00D69C9C00D69C9C000000000000000000C6948400A5390000C694
      84000000000000000000000000009C736B00C6630800AD520000BDA5A5000000
      00000000000000000000000000000000000000000000C6948400FFF7E700FFF7
      E700FFF7E700FFF7E700FFF7E700F7E7D600F7E7D600F7E7D600EFCEBD00FFDE
      AD00FFDEAD00A573730000000000000000000000000039AD4A0039AD4A0039D6
      730039D67300529C3100FFE7B500FFE7B500FFE7B500FFDEAD00FFDEAD00FFF7
      F700F7DEBD00CEA5A500ADA5A5000000000000000000D69C9C00FFF7BD00FFF7
      BD00FFE7C600D6AD9C00FFFFDE00FFFFD600FFFFD600FFF7BD00FFF7BD00F7DE
      BD00D69C9C00F7C69C00D69C9C00000000000000000000000000B55A2100B55A
      2100AD520000AD520000AD520000AD520000C6630800B5847B0039AD4A0039AD
      4A0039AD4A0039AD4A006BAD94000000000000000000C6948400FFF7E700FFF7
      E700FFF7F700FFF7F700FFF7E700FFF7E700F7E7D600F7E7D600FFE7C600FFE7
      C600FFE7C600A5737300000000000000000039AD4A0039AD4A0039D6730039D6
      730039D6730039D673007BB55A00FFF7BD00FFE7B500FFE7B500FFDEAD00FFE7
      C600FFFFE700CEA5A500ADA5A5000000000000000000D69C9C00FFFFDE00FFFF
      D600FFFFD600EFCEBD00EFCEBD00FFF7EF00FFFFE700FFFFDE00FFEFCE00D6AD
      9C00FFE7B500F7CEAD00D69C9C00000000000000000000000000C6948400A539
      0000A56339007B520000A5390000C6630800AD520000000000007BB55A00009C
      1000009C100039AD4A009CBDBD000000000000000000C6948400FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700F7E7D600F7E7D600F7E7D600FFE7
      C600FFE7C600A57373000000000000000000187B1800187B1800187B180039D6
      730039D67300187B1800529C310094AD7B005A5A5A009C736B00A57B7300A57B
      7300ADBDEF009CA59400BDA5A5000000000000000000D69C9C00FFFFE700FFFF
      E700EFCEBD00BDADB500BDADB500DEBDB500EFDED600EFDED600D69C9C00FFE7
      C600FFF7BD00F7DEBD00D69C9C0000000000000000000000000000000000B55A
      2100B5847B0000000000A5390000C66308008C6B29009CBDBD0039AD4A0018AD
      100018AD100000000000000000000000000000000000D69C9C00FFF7F700FFF7
      F700FFFFFF00FFFFFF00FFF7F700FFF7F700FFF7E700FFF7E700F7E7D600FFE7
      C600FFE7C600A57B7300000000000000000000000000BDC6CE00187B180039AD
      4A0008841800BDD6B500FFFFDE00C6BDBD007B7B730042393900F7F7D600E7CE
      9C00ADBDEF009CA59400ADA5A5000000000000000000D69C9C00F7E7D600D6AD
      9C00CECECE00EFFFFF00E7FFFF00C6DEEF00C6CECE00BDC6CE00BDADB500DEBD
      B500FFFFD600FFE7C600D69C9C0000000000000000000000000000000000C694
      8400AD520000A57B7300CE630000AD520000529C3100218C210018AD100018AD
      10006BAD940000000000000000000000000000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7F700E7DEDE00FFDE
      CE00FFDECE00A57B7300000000000000000000000000C6CECE00187B180039AD
      4A0008841800BDD6B500FFF7EF00FFFFE700F7F7D60052524A0073635A00FFE7
      B500FFEFCE009CA594009CA594000000000000000000D69C9C00D69C9C00C6DE
      EF00FFFFFF00FFFFFF00FFFFFF00EFFFFF00EFFFFF00E7FFFF00D6FFFF00C6BD
      BD00DEBDB500F7E7D600D69C9C00000000000000000000000000000000000000
      0000AD520000AD520000E78400008C6B29000000000039AD4A0039AD4A0018AD
      10000000000000000000000000000000000000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7E7D600FFD6
      C600E7B5AD00B5847B00000000000000000000000000000000007B7B73000894
      100039AD4A0008841800FFFFFF00FFF7F700FFFFE700FFEFCE0052524A00A57B
      7300D6AD9C009CA59400ADADBD000000000000000000C6CECE00CEA5A500C6DE
      EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFFFFF00C6DEEF00B5E7
      FF008CA5BD00DEBDB500D69C9C00000000000000000000000000000000000000
      0000B5847B00F7940800CE630000108C00006BAD9400009C100039AD4A007BB5
      5A000000000000000000000000000000000000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFDED600B584
      7B00B5847B00B5847B0000000000000000000000000000000000BDC6CE0039AD
      4A000894100018AD100039AD4A009CBDBD00BDD6B500BDD6B500C6AD9400E7CE
      9C009CA594009CA5940000000000000000000000000000000000C6BDBD00ADAD
      BD00C6FFFF00B5E7FF00B5E7FF008CC6F7008CC6F7008CADD600ADADBD00BDAD
      B500BDA5A500D69C9C00D69C9C00000000000000000000000000000000000000
      000000000000B55A2100A563390018AD1000009C100039AD4A00009C10000000
      00000000000000000000000000000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFDED600B584
      7B00EF945200C6AD94000000000000000000000000000000000000000000BDC6
      CE0094AD7B00218C21000894100008841800187B18007BB55A00D6CEAD00ADA5
      A500ADA5A500BDC6CE000000000000000000000000000000000000000000C6BD
      BD00BDADB5009CEFFF009CEFFF0094E7FF0094D6FF0094D6FF0094D6FF008CC6
      F700ADADBD00CEA5A50000000000000000000000000000000000000000000000
      000000000000C6948400BDADB5006BAD940031C6310039AD4A0039AD4A000000
      00000000000000000000000000000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700EFEFEF00EFDED600B584
      7B00D6AD9C000000000000000000000000000000000000000000000000000000
      0000ADA5A500ADA5A500D6D6CE00C6BDBD00CECECE00C6BDBD00C6BDBD00ADA5
      A500BDC6CE000000000000000000000000000000000000000000000000000000
      0000C6BDBD00BDADB5009CEFFF009CEFFF0094E7FF0094D6FF009CC6EF00CEA5
      A500C6BDBD000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018AD100031C63100BDD6B5000000
      00000000000000000000000000000000000000000000F7C69C00E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00B584
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000C6CECE00ADA5A500ADA5A500ADA5A500ADA5A500ADA5A500C6CE
      CE00000000000000000000000000000000000000000000000000000000000000
      000000000000C6BDBD00BDADB500ADD6EF009CEFFF00ADC6D600CEA5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006BAD94007BB55A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6CECE00BDADB500CEA5A500C6BDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C69C9400BDA5A500ADA5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEC6C600BDAD
      A500C6BDB500000000000000000000000000C6B5B500B5ADA500CECEC6000000
      0000000000000000000000000000000000000000000000000000000000007B84
      AD00000000000000000000000000000000000000000000000000000000008CA5
      BD009CB5D6000000000000000000000000000000000000000000000000000000
      000000000000C6CECE00C6BDBD00CED6D600C6BDBD00ADADBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C69C9400EFB58400EFDED600EFE7CE00DEBDB500D69C9C00C69C9400C6BD
      BD000000000000000000000000000000000000000000BDA59C00BD9C9400B59C
      84009C846B009484730000000000BD9C9400B59C8C00AD8C7B00846B5A00A59C
      94000000000000000000000000000000000000000000000000007B84AD0094E7
      FF001094C6008CA5BD000000000000000000000000009CB5D6008CA5BD00E7FF
      FF003194B5000000000000000000000000000000000000000000000000000000
      0000ADA5A500ADA5A500C6BDBD00ADA5A50094848C00BDADB500ADADBD00ADAD
      BD00ADADBD00000000000000000000000000000000000000000000000000D6AD
      9C00F7C69C00EFB58400F7EFE700EFDED600EFE7CE00C6948400A57B7300B584
      7B00D6AD9C00C69C9400C69C9400BDADB500D6C6BD00D6BDAD00B59C8C00CEBD
      A5007B5A42005231210052392900735A4200AD947B00CEBDAD00C6A59400846B
      5A00A57B7300A57B7300A57B730000000000000000000000000000000000ADC6
      D60031DEFF0010A5CE007B84AD00000000008CA5BD00ADCEDE00ADEFFF0031C6
      E7008CA5BD000000000000000000000000000000000000000000ADA5A500ADA5
      A500F7F7F700EFEFEF00C6BDBD00ADADBD0052524A0073635A0084849400C6BD
      BD00E7DEDE00ADADBD00ADADBD00000000000000000000000000D6AD9C00FFD6
      9C00F7C69C00F7C69C00F7EFE700F7EFE700F7E7D600C69484009C736B00A573
      7300D6AD9C00E7CE9C00E7CE9C00ADA5A500CEBDAD00DED6CE0084736300A57B
      7300A57B6B00EFDED600EFD6CE00E7CEBD00947B6300FFD6C600CEBDA500947B
      6B00FFD6C600F7CEAD00A57B7300000000000000000000000000000000008CA5
      BD009CEFFF0018D6FF0031BDDE003194B500C6DEEF00ADF7FF0000CEFF001094
      C6000000000000000000000000000000000000000000ADA5A500FFFFFF00F7F7
      F700EFEFEF00E7E7E700ADADBD00ADA5A5009CA594007B7B7300737373008484
      9400ADA5A500C6BDBD00848494000000000000000000D6AD9C00FFDEAD00FFD6
      9C00FFD69C00F7C69C00FFF7E700F7EFE700F7EFE700C69484009C6B5A009C6B
      5A00D6AD9C00F7CEAD00E7CE9C00ADA5A500D6CEC600D6C6BD00B5A59C009C84
      7B00BDAD9C00BD948C00AD948400D6C6B500B5AD9C00B5A59400BDAD9C009C8C
      7B00FFD69C00EFCEBD00A57B7300000000000000000000000000000000008CA5
      BD00DEEFEF0018D6FF0031DEFF008CFFFF00C6FFFF007BF7FF0031C6E7007B84
      AD000000000000000000000000000000000000000000ADA5A500F7F7F700E7E7
      E700ADADBD009CA59400848494008484840084849400ADA5A500C6BDBD00ADA5
      A5008484840084849400000000000000000000000000D6AD9C00FFE7B500FFDE
      AD00FFD69C00FFD69C00FFF7F700FFF7E700F7EFE700C69484009C6B5A009C6B
      5A00DEBDB500F7DEBD00F7CEAD00ADA5A50000000000C68C7300D6BDA500D6CE
      BD00B59C8C00527B31007B633900B5948C00DECEBD00D6C6B500B5A59400FFE7
      C600FFE7C600EFCEBD00A57B7300000000000000000000000000000000000000
      000042B5C60063EFFF0018D6FF0063EFFF0094FFFF008CFFFF0010A5CE009CB5
      D6000000000000000000000000000000000000000000ADA5A500ADA5A500ADA5
      A500CECECE00E7DEDE00E7DEDE00ADADBD00ADA5A50084849400848494008484
      9400ADA5A50084849400000000000000000000000000D6AD9C00FFE7B500E7CE
      9C008CA5BD00ADA5A500FFFFFF00FFF7F700F7F7E700DEBDB500C6948400A57B
      7300DEBDB500F7DEBD00F7DEBD00ADA5A500C69C8400FF945A00AD7B5A00528C
      3900529C2900848C2100AD6B39005A5A3900948C7B00FFD69C00FFD69C00FFD6
      9C00FFD69C00EFCEBD00A57B73000000000000000000000000009CBDBD0010A5
      CE0000C6FF0018D6FF0000CEFF004AE7FF007BF7FF009CFFFF005ADEFF001094
      C6008CA5BD0000000000000000000000000000000000ADA5A500E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00ADADBD00ADADBD00ADADBD00E7DEDE00E7DEDE00C6BD
      BD00ADA5A50084849400000000000000000000000000D6AD9C00D6CEAD0052AD
      F700319CFF00319CFF0094BDEF00FFFFFF00FFF7F700F7F7E700F7EFE700EFDE
      D600F7E7D600F7DEBD00F7DEBD00ADA5A500E79C7300CE8C63005284420063A5
      39009CA54A00EF8C5A00AD7B4A00317B29006B735200FFE7C600FFE7C600FFE7
      C600FFE7C600EFCEBD00A57B7300000000000000000042B5C60000BDEF004AE7
      FF0063EFFF0031DEFF0000CEFF0018D6FF0063EFFF0094FFFF008CFFFF004AE7
      FF0008B5E7002184B5009CBDBD000000000000000000ADA5A500E7DEDE00E7DE
      DE00E7DEDE00ADADBD00E7E7E700EFEFEF00E7E7E700ADADBD00ADADBD00ADAD
      BD00C6BDBD00848494000000000000000000000000009CB5D6005AC6FF0052BD
      FF0042ADFF0039A5FF00319CFF00B5D6F700FFFFFF00FFF7E700F7F7E700F7EF
      E700EFDED600F7E7D600DEBDB500CEA5A500E7947300738C520031BD4A0063A5
      5A00C6946B00E7946300C69442004AA518005A633900FFDEAD00FFD69C00FFD6
      9C00FFD69C00EFCEBD00A57B73000000000042B5C6007BF7FF00ADF7FF00CEFF
      FF00D6FFFF00CEFFFF005ADEFF0000CEFF004AE7FF00C6FFFF00E7FFFF00ADF7
      FF0094E7FF0094E7FF003194B500000000000000000000000000ADADBD00ADAD
      BD00ADADBD00CECECE00E7DEDE00EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7
      E700ADADBD00C6CECE00000000000000000042ADFF0042ADFF005AC6FF005AC6
      FF005AC6FF0042ADFF0039A5FF00319CFF00B5D6F700FFFFFF00FFF7E700F7EF
      E700F7EFE700C6BDBD009C84A50000000000AD8C6B0052B55A005ADE840073D6
      940094C68400C69C6300F78C5A007B9431006B7B5200FFEFD600FFEFD600FFEF
      D600FFEFD600EFCEBD00A57B7300000000008CA5BD008CA5BD003194B5003194
      B5003194B5003194B500C6FFFF0000CEFF0031DEFF003194B5003194B5003194
      B5003194B5003194B5008CA5BD00000000000000000000000000000000000000
      0000E7A57B00C6BDBD00C6BDBD00C6BDBD00C6BDBD00C6BDBD00CECECE00ADAD
      BD00C6BDBD000000000000000000000000000000000052ADF70042ADFF0052BD
      FF005AC6FF005AC6FF0042ADFF0039A5FF00319CFF00B5D6F700FFFFFF00FFF7
      E700B5BDD6007B84AD000000000000000000A5A5840039C663008CE79C00CEF7
      C600DEF7CE00A5D69400AD945200A58C31009CA58C00FFD69C00FFD69C00FFD6
      9C00FFD69C00EFCEBD00A57B7300000000000000000000000000000000000000
      0000000000009CB5D6003194B50000CEFF0000BDEF008CA5BD00000000000000
      000000000000000000000000000000000000000000000000000000000000C6BD
      BD00E7A57B00FFDEAD00FFE7C600FFE7D600F7E7D600E7A57B00C6BDBD000000
      00000000000000000000000000000000000000000000000000006BB5F70042AD
      FF0052BDFF005AC6FF005AC6FF004AB5FF0039A5FF00319CFF00B5D6F700ADD6
      EF004A7BCE000000000000000000000000000000000094B5840094DE8C00D6F7
      BD0094CE8C0052CE7B005A944A00A58C7300FFF7E700FFF7E700FFF7E700FFF7
      E700FFF7E700EFCEBD00A57B7300000000000000000000000000000000000000
      000000000000000000003194B5005ADEFF00009CD60000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7A5
      7B00FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600E7A57B00000000000000
      00000000000000000000000000000000000000000000000000000000000073B5
      EF0042ADFF0052BDFF005AC6FF005AC6FF0052BDFF0042ADFF00319CFF00398C
      EF00000000000000000000000000000000000000000000000000BDBD9C00A5BD
      8C0094BD8C007BAD7300B5A59400FFFFFF00FFFFFF00FFFFF700FFF7E700FFF7
      E700FFE7D600EFCEBD00A57B7300000000000000000000000000000000000000
      000000000000000000003194B5009CEFFF001094C60000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7A5
      7B00FFE7D600FFE7D600FFE7D600FFE7D600FFE7D600E7A57B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073B5EF0042ADFF0052BDFF005AC6FF005AC6FF0052ADF7002973DE00315A
      F70000000000000000000000000000000000000000000000000000000000E7A5
      7B00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      E700B5847B00B5847B00B5847B00000000000000000000000000000000000000
      000000000000000000008CA5BD008CC6EF003194B50000000000000000000000
      0000000000000000000000000000000000000000000000000000E7A57B00E7A5
      7B00FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700E7A57B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073B5EF006BB5F7008CC6EF00000000008CA5BD0000009C00315A
      F70000000000000000000000000000000000000000000000000000000000EFAD
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700B5847B00E7A57B0000000000000000000000000000000000000000000000
      0000000000000000000000000000009CD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7A57B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7A57B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B84AD007B84
      AD0000000000000000000000000000000000000000000000000000000000EFAD
      9400E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A5
      7B00B5847B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      BD005A7B5A00185A1800005A000000630800006B0800297329007BA584000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007BA5840029732900006B080000630800005A0000185A18005A7B
      5A00B5BDBD0000000000000000000000000000000000A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B73009C6B5A00000000000000000000000000A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B73009C6B5A00000000000000000000000000000000007B9C84000863
      10000094080000AD080000B5100008B5180008B5210010B53100089C21002984
      2900A5BDAD00000000000000000000000000000000000000000000000000A5BD
      AD0029842900089C210010B5310008B5210008B5180000B5100000AD08000094
      0800086310007B9C8400000000000000000000000000A57B7300FFE7D600FFE7
      D600FFE7D600FFDECE00FFE7C600FFE7C600FFE7C600FFDEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A00000000000000000000000000A57B7300EFDED600EFDE
      D600FFE7D600F7DEBD00FFE7C600FFE7C600FFE7C600FFDEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A000000000000000000000000007B9C8400006B000000AD
      080000AD100008B5180008B521007BD68C005ACE730018BD390018BD420018B5
      4200108C2100B5C6BD0000000000000000000000000000000000B5C6BD00108C
      210018B5420018BD420018BD39005ACE73007BD68C0008B5210008B5180000AD
      100000AD0800006B00007B9C84000000000000000000A57B7300FFE7D600FFE7
      D600FFDECE00FFE7C600FFE7C600FFE7C600FFDEAD00FFDEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A00000000000000000000000000A57B7300F7E7D600F7E7
      D600009C1000A5E7AD007BB55A0039AD4A007BB55A00F7CEAD00FFDEAD00FFD6
      9C00FFD69C009C6B5A000000000000000000B5BDBD000863100000AD080008B5
      180008B5180008B52100A5E7B500FFFFFF00D6F7DE0018BD420021BD520021BD
      5A0021B55200319C390000000000000000000000000000000000319C390021B5
      520021BD5A0021BD520018BD4200D6F7DE00FFFFFF00A5E7B50008B5210008B5
      180008B5180000AD080008631000B5BDBD0000000000B5847B00F7E7D600F7E7
      D600FFE7D600FFDECE00FFE7C600FFE7C600FFE7C600FFDEAD00FFDEAD00FFDE
      AD00FFDEAD009C6B5A00000000000000000000000000B5847B00F7EFE700F7EF
      E700009C1000009C1000009C1000009C1000009C1000529C3100FFDEAD00FFDE
      AD00FFDEAD009C6B5A0000000000000000004A7B52000094100008B5180008B5
      210010B52900A5E7B500FFFFFF00FFFFFF0073D6940018BD4A0021BD5A0029C6
      630029C66B0018A5390094C6A500000000000000000094C6A50018A5390029C6
      6B0029C6630021BD5A0018BD4A0073D69400FFFFFF00FFFFFF00A5E7B50010B5
      290008B5210008B51800009410004A7B520000000000B5847B00F7E7D600F7E7
      D600F7E7D600E7DEDE00FFDECE00FFE7C600FFE7C600EFCEBD00FFDEAD00FFDE
      AD00FFDEAD009C6B5A00000000000000000000000000B5847B00F7EFE700F7EF
      E700009C1000009C1000009C1000D6CEAD00FFDECE0018AD1000FFDEAD00FFDE
      AD00FFDEAD009C6B5A0000000000000000001873210008B5180010B5290010B5
      3100A5E7B500FFFFFF00FFFFFF0073D6940021BD5A0018BD4A0018BD4A0029C6
      6B0029C66B0029BD5A005AAD5A0000000000000000005AAD5A0029BD5A0029C6
      6B0029C66B0018BD4A0018BD4A0021BD5A0073D69400FFFFFF00FFFFFF00A5E7
      B50010B5310010B5290008B518001873210000000000C6948400FFF7E700FFF7
      E700CED6D6001042FF00637BEF00FFDECE006373E7003152F700EFCEBD00FFDE
      AD00FFDEAD00A5737300000000000000000000000000C6948400EFEFEF00EFEF
      EF00009C1000009C1000009C1000009C1000FFDECE00F7DEBD00FFDEAD00FFDE
      AD00FFDEAD00A57373000000000000000000007B100010B5310010B53100ADE7
      B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0063D6940029C66B0031A53100000000000000000031A5310029C66B0063D6
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00ADE7B50010B5310010B53100007B100000000000C6948400FFF7E700FFF7
      E700E7E7E7003152F7000031FF00214AFF000031FF003152F700EFCEBD00FFE7
      C600FFE7C600A5737300000000000000000000000000C6948400FFF7E700FFF7
      E700FFF7E700FFF7E700FFF7E700FFF7E700F7DEBD00F7DEBD00FFDECE00FFE7
      C600FFE7C600A57373000000000000000000088C180018BD390018BD4200D6F7
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0063D6940029C66B0031AD3100000000000000000031AD310029C66B0063D6
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D6F7DE0018BD420018BD3900088C180000000000C6948400FFF7F700FFF7
      F700FFF7E700E7E7E7001042FF000031FF001042FF00EFDED600FFE7C600FFE7
      C600FFE7C600A5737300000000000000000000000000C6948400FFF7F700FFFF
      FF00FFF7E700FFF7E700FFF7E700009C1000009C1000009C1000FFE7D600FFE7
      C600FFE7C600A573730000000000000000000884100018BD420021BD520029C6
      6B00D6F7E700FFFFFF00FFFFFF008CDEAD0029C66B0029C66B0029C66B0029C6
      6B0029C66B0031C66B0031AD3100000000000000000031AD310031C66B0029C6
      6B0029C66B0029C66B0029C66B0029C66B008CDEAD00FFFFFF00FFFFFF00D6F7
      E70029C66B0021BD520018BD42000884100000000000D69C9C00FFF7F700FFF7
      F700FFF7F700637BF7000031FF000031FF000031FF00637BEF00FFDECE00FFE7
      C600FFE7C600A57B7300000000000000000000000000D69C9C00FFFFFF00FFFF
      FF00009C1000A5E7AD00FFF7E700A5E7AD00009C1000009C1000FFE7D600FFDE
      CE00FFE7C600A57B73000000000000000000298C310021BD5A0021BD5A0029C6
      630029C66B00DEF7E700FFFFFF00F7FFF70052CE840029C66B0029C66B0029C6
      6B0042C6730042C6630063C66B00000000000000000063C66B0042C6630042C6
      730029C66B0029C66B0029C66B0052CE8400F7FFF700FFFFFF00DEF7E70029C6
      6B0029C6630021BD5A0021BD5A00298C310000000000EFAD9400FFFFFF00FFFF
      FF00ADBDEF000031FF003152F700E7DEDE003152F7001042FF00E7DEDE00FFDE
      CE00FFDECE00A57B7300000000000000000000000000EFAD9400FFFFFF00FFFF
      FF007BB55A00009C1000009C1000009C1000009C1000009C1000FFE7D600FFE7
      D600FFDECE00A57B7300000000000000000073AD7B0018A5390029C66B0029C6
      6B0029C66B0029C66B00DEF7E700FFFFFF00BDEFD60029C66B0031C6730052CE
      840073D6940031BD3900B5CEBD000000000000000000B5CEBD0031BD390073D6
      940052CE840031C6730029C66B00BDEFD600FFFFFF00DEF7E70029C66B0029C6
      6B0029C66B0029C66B0018A5390073AD7B0000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF00ADBDEF00EFEFEF00FFF7E700E7E7E700CED6D600F7E7D600FFD6
      C600E7B5AD00B5847B00000000000000000000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF007BB55A00009C1000009C1000A5E7AD00009C1000FFE7D600FFD6
      C600E7B5AD00B5847B000000000000000000BDCECE001894210029BD630029C6
      6B0029C66B0029C66B0029C66B0094E7B50029C66B0029C66B0063D68C0084DE
      A50073D684005AC65A00000000000000000000000000000000005AC65A0073D6
      840084DEA50063D68C0029C66B0029C66B0094E7B50029C66B0029C66B0029C6
      6B0029C66B0029BD630018942100BDCECE0000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7F700FFF7E700EFDED600B584
      7B00B5847B00B5847B00000000000000000000000000EFAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7F700FFF7E700EFDED600B584
      7B00B5847B00B5847B00000000000000000000000000A5C6AD00109C210029BD
      5A0029C66B0029C66B0029C66B0039C673005ACE840073D69C009CE7AD007BD6
      840031C63100BDD6CE0000000000000000000000000000000000BDD6CE0031C6
      31007BD684009CE7AD0073D69C005ACE840039C6730029C66B0029C66B0029C6
      6B0029BD5A00109C2100A5C6AD000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7F700EFDED600B584
      7B00EF945200C6AD9400000000000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7F700EFDED600B584
      7B00EF945200C6AD940000000000000000000000000000000000A5C6AD0031AD
      390018B5310029BD63004ACE84006BD694008CDEA50084DE94004ACE4A005AC6
      5A00BDD6CE00000000000000000000000000000000000000000000000000BDD6
      CE005AC65A004ACE4A0084DE94008CDEA5006BD694004ACE840029BD630018B5
      310031AD3900A5C6AD00000000000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700EFEFEF00EFDED600B584
      7B00D6AD9C0000000000000000000000000000000000F7C69C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700EFEFEF00EFDED600B584
      7B00D6AD9C000000000000000000000000000000000000000000000000000000
      000094C6A5005ABD5A0031B5310031B5310031BD310063C66B00B5CEBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5CEBD0063C66B0031BD310031B5310031B531005ABD5A0094C6
      A5000000000000000000000000000000000000000000F7C69C00E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00B584
      7B000000000000000000000000000000000000000000F7C69C00E7A57B00E7A5
      7B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00E7A57B00B584
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000E00000000100010000000000000700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFE000FFFF0000FFFFE000FFFF0000
      FFFF8000C0030000FFC7200080010000C001400000010000C001000000010000
      C001000000010000E003800000010000E001400000010000C001A0001FE90000
      C001800000030000C041C00001E70000F1C3E000420F0000FFFFE001BDFF0000
      FFFFE003C3FF0000FFFFE007FFFF000083E3FFFFF00FFFFF80218001C003FFFF
      800080018001FF81800080010001810080008101000000008001808100000000
      8001804100000001800180610000000180018061000080018001804100000000
      8001808100000000C001810100000000E003800100008181F00780018001E3C3
      F81F8001C003FFFFFC3FFFFFE007FFFFFF87C7C7F81FFFE7C787C387E007FC13
      C387C107C003F033C000E0038001E007E000E0018001C003E000F00000008001
      F000C00400008001C00700000000800100010001000080010001000100008001
      0001F8010000C003F83FFC2180018003FC3FFC6180030007FC7FFC01C007C01F
      FC7FFE01E00FD07FFE7FFF05F83FBBFFF87FFFFFFF87C7C7F01FE38FC787C387
      E00FC107C387C107E007C927C000E00FE007E10FE000E00FE007E10FE000F00F
      E007F01FF000C007E007FD7FC0070001F007F83F00010001F80FF83F00010001
      F98FF11F0001F820F98FF39FF83FFC30F81FF39FFC3FFC30FC1FE7CFFC7FFC00
      FE3FE7CFFC7FFE00FFFFFFFFFE7FFF82E001FC3FFC01FFFFC001F00FC0010007
      C001800380010007C001000080010007C001000080010007C001000080010007
      C001000080010001C001000180010001C001C00780010001C001C00780030003
      C001E00380070007C001F80380070007C001FE0780070007C003FF03C00F0007
      C007FFC3F83F000FC00FFFE3FFFF001FF8018003E001FFFFF801800380010001
      F801800380010001F80180038001000180018003C001000180018003E0010001
      80018003E001000180018003E001000180018003E001000180018003E0010001
      80038003E001000180078003E0010001801F8003E0010001801F8007E0030001
      801F800FE0078003803FFFFFFFFFFFFFFFFFF801C003F801C001F801C003F801
      8001F801C003F8018001F801C003F80180018001C003800180018001C0038001
      80018001C003800180018001C003800180018001C003800180018001C0038001
      80018003C003800380018007C00380078001803FC003801F8001803FC007801F
      8003807FC00F801FFFFF80FFFFFF803FFFFFFFFFC01FFFFFC0FF800F801FFFFF
      C00F8007000FFF8F000780030003FF87000380010001FF83000380018000C003
      000180018000C023000180018000C023000180018000C071000180018001C023
      000F80018001C403003F80010001C603003F80010003FFCF8FFF80010007FFFF
      FFFF8001000FFFFFFFFFFFFFF81FFFFFFFFFFFFFFFFFFFFFF81FFC1F81FF81FF
      E007F00F801F801F8007C007800F800F00070007800780070007000780078007
      0007000780038003000700078003800300070007800380030001000480038003
      000100008007800700000001C3CFC38F00010001FF8FFF07C1818000FF1FFE23
      FFC3FF88FFFFFF77FFE7FFFFFFFFFFFFFF9F87FFFFFFFC01FFCF807F0001FC00
      FF01800F0001E00093CF80070001C00000F78007000180000083800700010000
      327D800300010000130180030001000083CF8003000100012047800F00010001
      0207800F000100010207C003000100030607F803000100039C47F80700010007
      FC07FC1F0001800FFE07FE3FFFFFE01FF7EF8003FFFF83FFE0078003F00F803F
      C0038003E0078003F7E78003C00380010E1F8003C00180018E1F800380018001
      C001800300018001C041800300018001E407800380018001E007800380018001
      F08F8003C0018001F00F8003C003C001F81F8003E003E003F81F8007F007F007
      FF1F800FF80FF81FFF3FFFFFFFFFFC3FF8FFC71FEFE7F83FF00F820FC387F007
      E0000001E107C001C0000001E00F800180000001E00F800380008001F00F8003
      80000001C00780038000000180018003800000010001C003000100010001F007
      80030001F83FE01FC0078001FC7FE03FE00FC001FC7FE03FF00FE001FC7FC03F
      F88FE003FEFFC07FFFCFE007FFFFC0FFE01FF80780038003C007E00380038003
      8003C001800380030003C0008003800300018000800380030001800080038003
      0001800080038003000180008003800300018000800380030001800080038003
      00018000800380030003C000800380038003C00180038003C007E00380078007
      F01FF80F800F800FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object TimerUpdateShow: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerUpdateShowTimer
    Left = 248
    Top = 96
  end
  object PMFavDropList: TPopupMenu
    Left = 272
    Top = 192
  end
  object ImageListFavDrop: TImageList
    Height = 19
    Width = 19
    Left = 216
    Top = 184
    Bitmap = {
      494C010103000400040013001300FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000004C0000001300000001002000000000009016
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7D6C600F7D6C600F7D6C600F7D6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7D6C600F7D6
      C600F7D6C600F7D6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFCEBD00EFCEBD00EFC6
      B500EFC6B500EFC6B500EFC6B500EFCEBD00EFCEBD00F7D6C600000000000000
      000000000000000000000000000000000000000000000000000000000000F7D6
      C600EFC6B500E7BDA500E7B5A500E7B5A500E7B5A500E7B5A500E7BDA500EFC6
      B500F7D6C6000000000000000000000000000000000000000000000000000000
      00000000000000000000F7D6C600EFC6B500E7BDA500E7B5A500E7B5A500E7B5
      A500E7B5A500E7BDA500EFC6B500F7D6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7D6
      C600EFC6B500E7BDA500E7C6AD00EFCEBD00EFCEBD00EFCEBD00EFCEBD00E7C6
      AD00E7BDA500EFC6B500EFCEC600000000000000000000000000000000000000
      00000000000000000000EFCEBD00DEB59C00D69C7B00D69C7B00DE9C8400DEA5
      8400DEA58400DE9C8400D69C7B00D69C7B00DEAD9400EFCEBD00000000000000
      00000000000000000000000000000000000000000000EFCEBD00DEB59C00D69C
      7B00D69C7B00DEAD9400E7B59C00E7B59C00DEAD9400DEA58400D69C7B00DEAD
      9400EFCEBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFCEC600E7BDAD00E7BDA500EFD6C600F7EFE700FFF7
      EF00FFF7EF00FFF7EF00FFEFEF00F7E7DE00EFD6C600E7BDAD00E7BDAD00EFCE
      BD000000000000000000000000000000000000000000EFCEBD00DEA58C00D694
      7300DEAD8C00EFBDA500EFBDAD00EFC6AD00EFBDAD00EFBDA500E7B59C00DEA5
      8C00D6947300DEA58C00EFC6B500000000000000000000000000000000000000
      0000EFCEBD00DEA58C00D6947300E7B59C00EFD6C600F7DED600F7E7D600F7E7
      DE00F7E7DE00F7DECE00E7BDAD00D69C7B00DEA58C00EFC6B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7D6C600E7BDAD00E7BD
      AD00F7DED600FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00F7DED600E7BDAD00E7BDAD00F7D6C60000000000000000000000
      0000EFCEBD00DEA58C00D6947300E7B59C00F7CEB500F7CEBD00F7D6C600F7D6
      C600F7D6C600F7CEBD00F7CEB500EFC6AD00E7AD9400D69C7B00DEA58C00EFCE
      BD00000000000000000000000000EFCEBD00DEA58C00D6947B00E7BDAD00F7D6
      CE00F7D6C600F7D6C600F7D6C600F7D6C600F7D6CE00F7DED600F7E7D600EFC6
      B500D69C7B00DEA58C00EFCEBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFC6B500E7BDA500F7DED600FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00A5390000FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7DED600E7BD
      AD00EFCEB500000000000000000000000000E7B59C00D6947300E7BDA500F7D6
      C600F7D6CE00FFDED600FFE7D600A5390000FFE7D600FFDED600F7DECE00F7D6
      C600EFC6B500E7AD9400D69C7B00E7BDA500F7D6C6000000000000000000E7B5
      9C00D6947300E7BDA500EFCEC600EFCEBD00EFCEBD00EFC6B500A5390000EFC6
      B500EFCEB500EFCEBD00F7D6CE00F7DED600E7C6AD00D69C7B00E7BDA500F7D6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7D6C600E7BDA500EFCEC600FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00A5390000A5390000A5390000FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFEFEF00EFCEBD00E7C6AD00F7D6C60000000000EFCE
      BD00D69C7B00E7AD9400F7D6CE00F7DECE00FFE7D600FFE7DE00A5390000A539
      0000A5390000FFE7DE00FFE7DE00FFDED600F7D6C600EFC6B500DEA58C00DEA5
      8C00EFCEC60000000000EFCEBD00D69C7B00DEA58C00EFCEB500EFCEBD00EFCE
      BD00EFC6B500A5390000A5390000A5390000EFC6B500EFC6B500EFCEBD00F7D6
      C600F7D6CE00DEAD9400DEA58C00EFCEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFCEBD00E7BDAD00F7E7DE00FFF7EF00FFF7EF00FFF7EF00A5390000A539
      0000FFF7EF00A5390000A5390000FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7DE
      D600E7BDAD00EFCEC60000000000EFC6B500D69C7B00F7CEBD00FFE7D600FFE7
      DE00FFE7DE00A5390000A5390000FFEFDE00A5390000A5390000FFEFDE00FFE7
      DE00FFDED600F7D6C600EFBDA500D69C8400EFCEBD0000000000EFC6B500D694
      7B00E7BDA500EFC6B500EFC6B500EFC6B500A5390000A5390000EFC6B500A539
      0000A5390000EFC6B500EFCEB500EFCEBD00F7D6C600E7BDAD00D69C8400EFCE
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFCEBD00EFC6B500FFEFEF00FFF7
      EF00FFF7EF00A5390000A5390000FFF7EF00FFF7EF00FFF7EF00A5390000A539
      0000FFF7EF00FFF7EF00FFF7EF00F7E7DE00E7C6AD00EFCEC60000000000E7BD
      AD00DEA58C00FFE7D600FFE7DE00FFEFE700A5390000A5390000FFEFE700FFEF
      E700FFEFE700A5390000A5390000FFEFE700FFE7DE00F7DECE00EFC6B500DEA5
      8400EFCEBD0000000000E7BDAD00D69C7B00E7BDAD00EFC6B500EFC6B500A539
      0000A5390000EFC6B500EFC6B500EFC6B500A5390000A5390000EFC6B500EFCE
      BD00EFCEBD00EFC6B500D69C8400EFCEBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFCEBD00EFCEBD00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00A5390000FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7EF
      E700E7C6AD00EFCEC60000000000E7BDA500DEAD9400FFEFE700FFEFE700FFEF
      E700FFEFE700FFEFE700FFEFE700A5390000FFEFE700FFEFE700FFEFE700FFEF
      E700FFEFDE00FFE7D600EFCEC600DEA58400EFCEBD0000000000E7BDA500D69C
      8400E7BDAD00EFC6B500EFC6B500EFCEB500EFCEB500EFCEB500A5390000EFCE
      B500EFCEB500EFCEB500EFCEB500EFCEBD00EFCEBD00EFC6B500D6A58400EFCE
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFCEBD00EFCEBD00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00A5390000A5390000A5390000FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00F7E7DE00E7BDAD00EFCEC60000000000E7BD
      A500DEB59C00FFEFEF00FFEFE700FFEFE700FFEFE700FFEFE700A5390000A539
      0000A5390000FFEFE700FFEFE700FFEFE700FFEFE700FFE7DE00F7D6C600DEA5
      8400EFCEBD0000000000E7BDA500D69C8400E7BDA500EFC6AD00EFC6B500EFCE
      B500EFCEB500A5390000A5390000A5390000EFCEB500EFCEB500EFCEB500EFCE
      B500EFCEB500E7BDAD00D69C8400EFCEBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFCEBD00EFC6B500FFEFE700FFF7EF00FFF7EF00FFF7EF00A5390000A539
      0000FFF7EF00A5390000A5390000FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7DE
      D600E7BDAD00F7D6C60000000000E7BDA500DEAD9400FFEFE700FFF7EF00FFF7
      EF00FFEFE700A5390000A5390000FFEFE700A5390000A5390000FFEFE700FFEF
      E700FFEFE700FFEFE700EFCEBD00D69C8400EFCEBD0000000000E7BDA500D69C
      7B00E7B59C00E7BDAD00EFC6B500EFCEBD00A5390000A5390000EFCEBD00A539
      0000A5390000EFCEBD00EFCEBD00EFC6B500EFC6B500E7B59C00D69C7B00EFCE
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFCEBD00E7BDAD00F7E7DE00FFF7
      EF00FFF7EF00A5390000A5390000FFF7EF00FFF7EF00FFF7EF00A5390000A539
      0000FFF7EF00FFF7EF00FFF7EF00EFCEBD00E7BDAD00F7D6C60000000000E7C6
      AD00D6A58400F7DED600FFF7F700FFF7EF00A5390000A5390000FFF7EF00FFF7
      EF00FFF7EF00A5390000A5390000FFF7EF00FFF7EF00FFF7EF00E7B5A500DEA5
      8400F7D6C60000000000E7C6AD00D69C7B00DEAD8C00E7BDA500E7C6AD00A539
      0000A5390000EFCEBD00EFCEBD00EFCEBD00A5390000A5390000EFCEB500EFC6
      B500E7C6AD00DEA58C00DEA58400F7D6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFCEC600E7BDAD00EFCEBD00FFEFEF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7E7DE00E7BD
      A500EFC6B5000000000000000000EFCEBD00DEA58400E7BDA500FFF7EF00FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
      F700FFF7F700F7DED600D69C7B00E7B5A5000000000000000000EFCEBD00D6A5
      8400D69C8400DEB59C00E7BDA500E7C6B500EFCEBD00EFCEBD00EFCEBD00EFCE
      BD00EFCEBD00EFCEBD00E7C6B500E7BDAD00DEB59C00D6947300E7B5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7D6C600EFC6B500E7BDAD00F7D6
      CE00FFEFEF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00F7E7DE00E7C6AD00E7BDAD00F7D6C6000000000000000000F7D6
      C600E7B5A500D69C7B00EFCEBD00FFFFF700FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFFF00FFFFFF00F7EFE700DEA58C00D69C8400EFCE
      BD000000000000000000F7D6C600E7B5A500D6947300D6A58400DEB59C00E7BD
      AD00E7C6B500E7C6B500EFCEBD00EFCEBD00E7C6B500E7C6AD00E7BDAD00DEB5
      9C00D69C7B00D69C8400EFCEBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7D6C600EFC6B500E7BDAD00EFD6C600FFEFE700FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFEFEF00F7DED600E7C6AD00E7BDA500EFCE
      BD0000000000000000000000000000000000EFCEBD00DEAD9400D69C7B00EFCE
      BD00FFF7EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7DE
      D600DEA58C00D69C7B00EFC6B50000000000000000000000000000000000EFCE
      BD00DEAD9400D6947300D6A58400DEAD9400E7B5A500E7BDA500E7BDAD00E7BD
      AD00E7BDA500E7B5A500DEAD9400D69C7B00D69C7B00EFC6B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFCEC600EFC6
      B500E7BDA500EFC6B500F7D6CE00F7DED600F7E7DE00F7E7DE00F7DECE00EFCE
      BD00E7BDA500E7BDAD00EFCEBD00000000000000000000000000000000000000
      000000000000EFCEBD00DEB59C00D69C8400DEAD9400EFCEBD00F7DED600F7E7
      DE00F7E7DE00EFD6C600DEB59C00D6947300DEA58C00EFC6B500000000000000
      000000000000000000000000000000000000EFCEBD00DEAD9400D69C7B00D69C
      7B00D6A58400DEA58C00DEAD9400DEAD9400D6A58C00D69C7B00D6947300DEA5
      8C00EFC6B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7D6C600EFCEBD00EFC6B500EFC6AD00E7BD
      AD00E7C6AD00E7BDAD00E7BDAD00EFC6AD00EFCEBD00F7D6C600000000000000
      00000000000000000000000000000000000000000000F7D6C600EFCEBD00E7BD
      AD00DEAD9400DEA58C00DEA58400DEA58C00DEA58C00DEA58400DEAD9400E7BD
      AD00EFCEC6000000000000000000000000000000000000000000000000000000
      0000F7D6C600EFCEBD00E7BDAD00DEAD9400DEA58C00D69C8400D6A58400D6A5
      8400D6A58400DEAD9400E7BDAD00EFCEC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7D6C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7D6C600F7D6C600EFCEC600EFCEBD00EFCE
      C600EFCEC600EFCEBD00F7D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7D6C600F7D6
      C600EFCEC600EFCEBD00EFCEBD00EFCEBD00EFCEBD00F7D6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000004C0000001300000001000100
      00000000E40000000000000000000000000000000000000000000000FFFFFF00
      FE1FFFC3FFFFFF8000000000F803FE007FC00F8000000000E001FC003F800780
      00000000C000F8001F00038000000000800070000E0001800000000080007000
      0600008000000000000020000400008000000000000020000400008000000000
      0000200004000080000000000000200004000080000000000000200004000080
      0000000000002000040000800000000000002000040000800000000000006000
      0C00018000000000000060000C000180000000008000F0001E00038000000000
      C001F8003F00078000000000E003F8007F000F8000000000F80FFE01FFC03F80
      0000000000000000000000000000000000000000000000000000}
  end
  object PopupMenuFavBar: TPopupMenu
    Images = ImageListOther
    Left = 104
    Top = 56
  end
end
