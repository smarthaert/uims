object frm_main: Tfrm_main
  Left = 3
  Top = 3
  AutoScroll = False
  BorderIcons = []
  Caption = '                    '#32593#39029#25991#26412#25628#32034#22120'    '
  ClientHeight = 677
  ClientWidth = 1006
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SknMainMnuBar1: TspSkinMainMenuBar
    Left = 0
    Top = 0
    Width = 1006
    Height = 22
    TabOrder = 0
    DrawDefault = True
    SkinData = SknDat_main
    SkinDataName = 'mainmenubar'
    Transparent = False
    TransparentValue = 50
    UseSkinCursor = False
    DefItemFont.Charset = DEFAULT_CHARSET
    DefItemFont.Color = clBtnText
    DefItemFont.Height = 14
    DefItemFont.Name = 'Arial'
    DefItemFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 22
    PopupToUp = False
    DynamicSkinForm = SkinFrm_main
    MainMenu = mnu_main
  end
  object pagecontrol_main: TspSkinPageControl
    Left = 0
    Top = 76
    Width = 1006
    Height = 579
    ActivePage = TabSheet_search
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clBtnText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultItemHeight = 20
    SkinData = SknDat_main
    SkinDataName = 'tab'
    object TabSheet_search: TspSkinTabSheet
      Caption = #32593#39029#25628#32034
      object pagecontrol_search_sub: TspSkinPageControl
        Left = 0
        Top = 0
        Width = 1004
        Height = 557
        ActivePage = TabSheet_searchkeys
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBtnText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clBtnText
        DefaultFont.Height = 14
        DefaultFont.Name = 'Arial'
        DefaultFont.Style = []
        DefaultItemHeight = 20
        SkinData = SknDat_main
        SkinDataName = 'tab'
        object TabSheet_searchkeys: TspSkinTabSheet
          Caption = '                            '#25628#32034#20851#38190#23383'                           '
          object spSkinSplitter1: TspSkinSplitter
            Left = 233
            Top = 25
            Width = 10
            Height = 510
            MinSize = 10
            DefaultSize = 10
            SkinDataName = 'vsplitter'
            SkinData = SknDat_main
          end
          object spSkinPanel2: TspSkinPanel
            Left = 0
            Top = 0
            Width = 1002
            Height = 25
            TabOrder = 0
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'panel'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            Caption = 'spSkinPanel2'
            Align = alTop
            object spSkinButton2: TspSkinButton
              Left = 233
              Top = 1
              Width = 768
              Height = 23
              TabOrder = 0
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'button'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clBlue
              DefaultFont.Height = -14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              AllowAllUp = False
              CanFocused = False
              Down = False
              GroupIndex = 0
              Caption = #25628#32034#32467#26524
              NumGlyhps = 2
              Align = alClient
              Spacing = 1
            end
            object spSkinButton3: TspSkinButton
              Left = 1
              Top = 1
              Width = 232
              Height = 23
              TabOrder = 1
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'button'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clBlue
              DefaultFont.Height = -14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              AllowAllUp = False
              CanFocused = False
              Down = False
              GroupIndex = 0
              Caption = #38190#20837#20320#35201#25628#32034#30340#20851#38190#23383'('#22238#36710#38388#38548')'
              NumGlyhps = 2
              Align = alLeft
              Spacing = 1
            end
          end
          object spSkinPanel3: TspSkinPanel
            Left = 0
            Top = 25
            Width = 233
            Height = 510
            TabOrder = 1
            DrawDefault = True
            SkinDataName = 'panel'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            Caption = 'spSkinPanel3'
            Align = alLeft
            object memo_keys: TspSkinMemo
              Left = 1
              Top = 1
              Width = 231
              Height = 120
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              BitMapBG = False
              SkinData = SknDat_main
              SkinDataName = 'memo'
              Transparent = False
              TransparentValue = 0
            end
            object memo_KeywordsLimiter: TspSkinMemo
              Left = 1
              Top = 336
              Width = 231
              Height = 173
              Align = alBottom
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              Lines.Strings = (
                '')
              ParentFont = False
              TabOrder = 1
              OnChange = memo_KeywordsLimiterChange
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              BitMapBG = False
              SkinData = SknDat_main
              SkinDataName = 'memo'
              Transparent = False
              TransparentValue = 0
            end
            object check_KeywordsLimiter: TspSkinCheckRadioBox
              Left = 1
              Top = 311
              Width = 231
              Height = 25
              TabOrder = 2
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'checkbox'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 0
              CanFocused = False
              Radio = False
              Checked = False
              GroupIndex = 0
              Flat = False
              Caption = #20851#38190#23383#38480#21046#22120'('#38190#20837#38480#21046#20851#38190#23383')'#12288
              OnClick = check_KeywordsLimiterClick
              Align = alBottom
            end
            object memo_KeywordsFilter: TspSkinMemo
              Left = 1
              Top = 171
              Width = 231
              Height = 140
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              Lines.Strings = (
                '')
              ParentFont = False
              TabOrder = 3
              OnChange = memo_KeywordsFilterChange
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              BitMapBG = False
              SkinData = SknDat_main
              SkinDataName = 'memo'
              Transparent = False
              TransparentValue = 0
            end
            object check_KeywordsFilter: TspSkinCheckRadioBox
              Left = 1
              Top = 146
              Width = 231
              Height = 25
              TabOrder = 4
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'checkbox'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 0
              CanFocused = False
              Radio = False
              Checked = False
              GroupIndex = 0
              Flat = False
              Caption = #20851#38190#23383#36807#28388#22120'('#38190#20837#36807#28388#20851#38190#23383')'
              OnClick = check_KeywordsFilterClick
              Align = alTop
            end
            object check_only_mail: TspSkinCheckRadioBox
              Left = 1
              Top = 121
              Width = 231
              Height = 25
              TabOrder = 5
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'checkbox'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 0
              CanFocused = False
              Radio = False
              Checked = False
              GroupIndex = 0
              Flat = False
              Caption = 'Email'#36807#28388'('#21482#25628#21547'Email'#38142#25509','#23384#21040#25991#20214')'
              OnClick = check_only_mailClick
              Align = alTop
            end
          end
          object spSkinPanel4: TspSkinPanel
            Left = 243
            Top = 25
            Width = 759
            Height = 510
            TabOrder = 2
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'panel'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            Caption = 'spSkinPanel4'
            Align = alClient
            object listbox_results: TspSkinListBox
              Left = 1
              Top = 1
              Width = 757
              Height = 419
              TabOrder = 0
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'listbox'
              Transparent = False
              TransparentValue = 1
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -15
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 0
              HorizontalExtent = False
              Columns = 0
              RowCount = 0
              ImageIndex = -1
              NumGlyphs = 1
              Spacing = 2
              CaptionMode = False
              DefaultCaptionHeight = 20
              DefaultCaptionFont.Charset = DEFAULT_CHARSET
              DefaultCaptionFont.Color = clWindowText
              DefaultCaptionFont.Height = 14
              DefaultCaptionFont.Name = 'Arial'
              DefaultCaptionFont.Style = []
              DefaultItemHeight = 20
              ItemIndex = -1
              MultiSelect = False
              ListBoxFont.Charset = DEFAULT_CHARSET
              ListBoxFont.Color = clWindowText
              ListBoxFont.Height = -15
              ListBoxFont.Name = 'Arial'
              ListBoxFont.Style = []
              ListBoxTabOrder = 0
              ListBoxTabStop = True
              ExtandedSelect = True
              Sorted = False
              ListBoxPopupMenu = mnu_pop_listbox
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Arial'
              Font.Style = []
              Align = alClient
            end
            object memo_status: TspSkinMemo
              Left = 1
              Top = 420
              Width = 757
              Height = 89
              Align = alBottom
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              Lines.Strings = (
                '')
              ParentFont = False
              TabOrder = 1
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              BitMapBG = False
              SkinData = SknDat_main
              SkinDataName = 'memo'
              Transparent = False
              TransparentValue = 0
            end
          end
        end
        object TabSheet_reportweb: TspSkinTabSheet
          Caption = 
            '                              '#25628#32034#25253#21578'                              ' +
            '          '
          object memo_searched: TspSkinMemo
            Left = 0
            Top = 0
            Width = 985
            Height = 535
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Style = []
            Lines.Strings = (
              '')
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            BitMapBG = False
            VScrollBar = scroll_memo_searched
            SkinData = SknDat_main
            SkinDataName = 'memo'
            Transparent = False
            TransparentValue = 0
          end
          object scroll_memo_searched: TspSkinScrollBar
            Left = 985
            Top = 0
            Width = 17
            Height = 535
            TabOrder = 1
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'vscrollbar'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            Both = False
            BothMarkerWidth = 0
            BothSkinDataName = 'bothhscrollbar'
            CanFocused = False
            Align = alRight
            Kind = sbVertical
            PageSize = 0
            Min = 0
            Max = 0
            Position = 0
            SmallChange = 1
            LargeChange = 1
          end
        end
        object TabSheet_set: TspSkinTabSheet
          Caption = 
            '                              '#36873#39033#35774#32622'                              ' +
            '      '
          object RadioGroup_link: TspSkinRadioGroup
            Left = 0
            Top = 0
            Width = 1002
            Height = 81
            TabOrder = 0
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'groupbox'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -16
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = True
            RollUpMode = False
            RollUpState = False
            Caption = #38142#25509#36873#39033
            Align = alTop
            OnClick = RadioGroup_linkClick
            ButtonSkinDataName = 'radiobox'
            Columns = 4
            ItemIndex = 0
            Items.Strings = (
              #25628#32034#32593#31449#25152#26377#38142#25509'(&A)'
              #25628#32034#23376#30446#24405'(&P)'
              #25972#20010#32593#31449'('#20869#37096')'#38142#25509'(&B)')
          end
          object RadioGroup_LinksReport: TspSkinRadioGroup
            Left = 0
            Top = 81
            Width = 1002
            Height = 112
            TabOrder = 1
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'groupbox'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = True
            RollUpMode = False
            RollUpState = False
            Caption = #25253#21578#31867#22411
            Align = alTop
            OnClick = RadioGroup_LinksReportClick
            ButtonSkinDataName = 'radiobox'
            Columns = 4
            ItemIndex = 0
            Items.Strings = (
              #25253#21578#25152#26377#38142#25509'(&D)'
              #25253#21578#23376#30446#24405#38142#25509'(&E)'
              #25253#21578#25972#20010#31449#28857#38142#25509'(&F)')
          end
          object spSkinButton5: TspSkinButton
            Left = 0
            Top = 193
            Width = 1002
            Height = 32
            TabOrder = 2
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'button'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            AllowAllUp = False
            CanFocused = False
            Down = False
            GroupIndex = 0
            Caption = #20195#29702#35774#32622
            NumGlyhps = 2
            Align = alTop
            Spacing = 1
          end
          object RadioGroup_proxy: TspSkinRadioGroup
            Left = 0
            Top = 225
            Width = 161
            Height = 310
            TabOrder = 3
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'groupbox'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = True
            RollUpMode = False
            RollUpState = False
            Caption = #20195#29702#36873#39033#35774#32622
            Align = alLeft
            OnClick = RadioGroup_proxyClick
            ButtonSkinDataName = 'radiobox'
            ItemIndex = 2
            Items.Strings = (
              #30452#25509#36830#25509'(&G)'
              #20195#29702#26381#21153#22120'(&H)'
              #37319#29992' I E '#40664#35748'(&I)')
          end
          object GroupBox_par: TspSkinGroupBox
            Left = 161
            Top = 225
            Width = 528
            Height = 310
            TabOrder = 4
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'groupbox'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = True
            RollUpMode = False
            RollUpState = False
            Caption = #20195#29702#21442#25968#35774#32622
            Align = alClient
            Enabled = False
            object Label1: TLabel
              Left = 8
              Top = 33
              Width = 121
              Height = 16
              Caption = #20195#29702#26381#21153#22120#22320#22336':(&K)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label2: TLabel
              Left = 4
              Top = 73
              Width = 135
              Height = 16
              Caption = #20195#29702#26381#21153#22120#31471#21475#21495'(&N):'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label3: TLabel
              Left = 8
              Top = 105
              Width = 75
              Height = 16
              Caption = #29992#25143#21517'(&U)'#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label4: TLabel
              Left = 8
              Top = 137
              Width = 75
              Height = 16
              Caption = #23494#12288#30721'(&P)'#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object edt_proxy_ipaddress: TspSkinEdit
              Left = 144
              Top = 32
              Width = 153
              Height = 20
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object edt_proxy_port: TspSkinEdit
              Left = 144
              Top = 72
              Width = 153
              Height = 20
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object edt_proxy_user: TspSkinEdit
              Left = 144
              Top = 104
              Width = 153
              Height = 20
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object edt_proxy_password: TspSkinEdit
              Left = 144
              Top = 136
              Width = 153
              Height = 20
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
          end
          object spSkinGroupBox2: TspSkinGroupBox
            Left = 689
            Top = 225
            Width = 313
            Height = 310
            TabOrder = 5
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'groupbox'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = True
            RollUpMode = False
            RollUpState = False
            Caption = #20854#23427#21442#25968#35774#32622
            Align = alRight
            object Label5: TLabel
              Left = 0
              Top = 33
              Width = 161
              Height = 16
              Caption = #20195#29702#26381#21153#22120#37325#35797#27425#25968'(&Q)'#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label6: TLabel
              Left = 0
              Top = 57
              Width = 147
              Height = 16
              Caption = #20195#29702#26381#21153#22120#24310#36831'('#31186')(&Q):'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label7: TLabel
              Left = 0
              Top = 145
              Width = 131
              Height = 16
              Caption = #25628#32034#32467#26524#20445#23384#20110'(&F)'#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label8: TLabel
              Left = 0
              Top = 113
              Width = 89
              Height = 16
              Caption = #25628#32034#28145#24230'(&Y)'#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label9: TLabel
              Left = 0
              Top = 81
              Width = 89
              Height = 16
              Caption = #19979#36733#25968#30446'(&T)'#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBtnText
              Font.Height = -14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object edt_proxy_cs: TspSkinEdit
              Left = 160
              Top = 32
              Width = 89
              Height = 20
              Text = '3'
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object edt_proxy_timeout: TspSkinEdit
              Left = 160
              Top = 56
              Width = 89
              Height = 20
              Text = '300'
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object edt_searchresults: TspSkinEdit
              Left = 128
              Top = 144
              Width = 105
              Height = 20
              Text = 'c:\results.txt'
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object spSkinButton6: TspSkinButton
              Left = 232
              Top = 144
              Width = 17
              Height = 20
              TabOrder = 3
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'button'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 0
              AllowAllUp = False
              CanFocused = False
              Down = False
              GroupIndex = 0
              Caption = '...'
              NumGlyhps = 2
              Spacing = 1
              OnClick = spSkinButton6Click
            end
            object edt_leverl: TspSkinEdit
              Left = 128
              Top = 112
              Width = 121
              Height = 20
              Text = '3'
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object edt_currentdownloads: TspSkinEdit
              Left = 128
              Top = 88
              Width = 121
              Height = 20
              Text = '6'
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 20
              ButtonMode = False
              SkinData = SknDat_main
              SkinDataName = 'edit'
              Transparent = False
              TransparentValue = 0
              EditPasswordChar = #0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
          end
        end
      end
    end
    object spSkinTabSheet3: TspSkinTabSheet
      Caption = #25991#26412#25628#32034
      object spSkinSplitter2: TspSkinSplitter
        Left = 185
        Top = 0
        Width = 10
        Height = 557
        MinSize = 10
        DefaultSize = 10
        SkinDataName = 'vsplitter'
        SkinData = SknDat_main
      end
      object spSkinPanel6: TspSkinPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 557
        TabOrder = 0
        DrawDefault = True
        SkinData = SknDat_main
        SkinDataName = 'panel'
        Transparent = False
        TransparentValue = 50
        UseSkinCursor = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 14
        DefaultFont.Name = 'Arial'
        DefaultFont.Style = []
        UseSkinFont = True
        DefaultWidth = 0
        DefaultHeight = 0
        NumGlyphs = 1
        Spacing = 2
        DefaultAlignment = taLeftJustify
        DefaultCaptionHeight = 22
        BorderStyle = bvRaised
        CaptionMode = False
        RollUpMode = False
        RollUpState = False
        Caption = 'spSkinPanel6'
        Align = alLeft
        object DirectoryListBox: TspSkinDirectoryListBox
          Left = 1
          Top = 49
          Width = 183
          Height = 199
          TabOrder = 0
          DrawDefault = True
          SkinData = SknDat_main
          SkinDataName = 'listbox'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = False
          DefaultWidth = 0
          DefaultHeight = 0
          HorizontalExtent = False
          Columns = 0
          RowCount = 0
          ImageIndex = -1
          NumGlyphs = 1
          Spacing = 2
          CaptionMode = False
          DefaultCaptionHeight = 20
          DefaultCaptionFont.Charset = DEFAULT_CHARSET
          DefaultCaptionFont.Color = clWindowText
          DefaultCaptionFont.Height = 14
          DefaultCaptionFont.Name = 'Arial'
          DefaultCaptionFont.Style = []
          DefaultItemHeight = 20
          Items.Strings = (
            'G:\'
            'html-txt-scanner'
            'skin'
            #31532#19977#26041#25511#20214)
          ItemIndex = 1
          MultiSelect = False
          ListBoxFont.Charset = DEFAULT_CHARSET
          ListBoxFont.Color = clWindowText
          ListBoxFont.Height = -14
          ListBoxFont.Name = 'Arial'
          ListBoxFont.Style = []
          ListBoxTabOrder = 0
          ListBoxTabStop = True
          ExtandedSelect = True
          Sorted = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          Align = alTop
          FileList = FileListBox
        end
        object FileListBox: TspSkinFileListBox
          Left = 1
          Top = 248
          Width = 183
          Height = 288
          TabOrder = 1
          DrawDefault = True
          SkinData = SknDat_main
          SkinDataName = 'listbox'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          HorizontalExtent = False
          Columns = 1
          RowCount = 0
          ImageIndex = -1
          NumGlyphs = 1
          Spacing = 2
          CaptionMode = False
          DefaultCaptionHeight = 20
          DefaultCaptionFont.Charset = DEFAULT_CHARSET
          DefaultCaptionFont.Color = clWindowText
          DefaultCaptionFont.Height = 14
          DefaultCaptionFont.Name = 'Arial'
          DefaultCaptionFont.Style = []
          DefaultItemHeight = 20
          Items.Strings = (
            'htmltxtscanner.cfg'
            'htmltxtscanner.dof'
            'htmltxtscanner.dpr'
            'htmltxtscanner.drc'
            'htmltxtscanner.gex'
            'htmltxtscanner.res'
            'htmltxtscanner'#31243#24207'.exe'
            'main.dcu'
            'main.ddp'
            'main.dfm'
            'main.pas'
            'readme.txt'
            'tomore'#35831#35835'.txt')
          ItemIndex = 0
          MultiSelect = True
          ListBoxFont.Charset = DEFAULT_CHARSET
          ListBoxFont.Color = clWindowText
          ListBoxFont.Height = 14
          ListBoxFont.Name = 'Arial'
          ListBoxFont.Style = []
          ListBoxTabOrder = 0
          ListBoxTabStop = True
          ExtandedSelect = True
          Sorted = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          Align = alClient
        end
        object FilterComboBo: TspSkinFilterComboBox
          Left = 1
          Top = 536
          Width = 183
          Height = 20
          TabOrder = 2
          DrawDefault = True
          SkinData = SknDat_main
          SkinDataName = 'combobox'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          HorizontalExtent = False
          ImageIndex = -1
          ListBoxCaptionMode = False
          ListBoxDefaultFont.Charset = DEFAULT_CHARSET
          ListBoxDefaultFont.Color = clWindowText
          ListBoxDefaultFont.Height = 14
          ListBoxDefaultFont.Name = 'Arial'
          ListBoxDefaultFont.Style = []
          ListBoxDefaultCaptionFont.Charset = DEFAULT_CHARSET
          ListBoxDefaultCaptionFont.Color = clWindowText
          ListBoxDefaultCaptionFont.Height = 14
          ListBoxDefaultCaptionFont.Name = 'Arial'
          ListBoxDefaultCaptionFont.Style = []
          ListBoxDefaultItemHeight = 20
          ListBoxCaptionAlignment = taLeftJustify
          Text = #25152#26377#25991#20214' (*.*)'
          Align = alBottom
          Items.Strings = (
            #25152#26377#25991#20214' (*.*)'
            #25991#26412#25991#20214' (*.txt)'
            #32593#39029#25991#20214' (*.htm)'
            'asp'#32593#39029#25991#20214' (*.asp)'
            'WORD'#25991#26723' (*.doc)'
            'RTF'#25991#20214' (*.rtf)')
          ItemIndex = 0
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Style = []
          Sorted = False
          Style = spcbFixedStyle
          FileList = FileListBox
          Filter = 
            #25152#26377#25991#20214' (*.*)|*.*|'#25991#26412#25991#20214' (*.txt)|*.txt|'#32593#39029#25991#20214' (*.htm)|*.htm|asp'#32593#39029#25991#20214' (*.' +
            'asp)|(*.asp)|WORD'#25991#26723' (*.doc)|*.doc|RTF'#25991#20214' (*.rtf)|*.rtf'
          ParentFont = False
        end
        object DriveComboBox: TspSkinDriveComboBox
          Left = 1
          Top = 25
          Width = 183
          Height = 24
          TabOrder = 3
          DrawDefault = True
          SkinData = SknDat_main
          SkinDataName = 'combobox'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = False
          DefaultWidth = 0
          DefaultHeight = 0
          HorizontalExtent = False
          ImageIndex = -1
          ListBoxCaptionMode = False
          ListBoxDefaultFont.Charset = DEFAULT_CHARSET
          ListBoxDefaultFont.Color = clWindowText
          ListBoxDefaultFont.Height = 14
          ListBoxDefaultFont.Name = 'Arial'
          ListBoxDefaultFont.Style = []
          ListBoxDefaultCaptionFont.Charset = DEFAULT_CHARSET
          ListBoxDefaultCaptionFont.Color = clWindowText
          ListBoxDefaultCaptionFont.Height = 14
          ListBoxDefaultCaptionFont.Name = 'Arial'
          ListBoxDefaultCaptionFont.Style = []
          ListBoxDefaultItemHeight = 20
          ListBoxCaptionAlignment = taLeftJustify
          Text = 'g: ['#32508#21512']'
          Align = alTop
          Items.Strings = (
            'a:'
            'c: [w98-2k]'
            'd: [winxp]'
            'e: ['#36719#20214']'
            'f: ['#24433#38899']'
            'g: ['#32508#21512']'
            'h: [backup]'
            'i: []'
            'j: []')
          ItemIndex = 5
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = 'Arial'
          Font.Style = []
          Sorted = False
          Style = spcbFixedStyle
          DirList = DirectoryListBox
          ParentFont = False
        end
        object spSkinButton8: TspSkinButton
          Left = 1
          Top = 1
          Width = 183
          Height = 24
          TabOrder = 4
          DrawDefault = True
          SkinData = SknDat_main
          SkinDataName = 'button'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clBlue
          DefaultFont.Height = -14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = False
          DefaultWidth = 0
          DefaultHeight = 0
          AllowAllUp = False
          CanFocused = False
          Down = False
          GroupIndex = 0
          Caption = #35831#36873#25321#36335#24452#21644#25991#20214
          NumGlyhps = 2
          Align = alTop
          Spacing = 1
        end
      end
      object spSkinPanel7: TspSkinPanel
        Left = 195
        Top = 0
        Width = 809
        Height = 557
        TabOrder = 1
        DrawDefault = True
        SkinData = SknDat_main
        SkinDataName = 'panel'
        Transparent = False
        TransparentValue = 50
        UseSkinCursor = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 14
        DefaultFont.Name = 'Arial'
        DefaultFont.Style = []
        UseSkinFont = True
        DefaultWidth = 0
        DefaultHeight = 0
        NumGlyphs = 1
        Spacing = 2
        DefaultAlignment = taLeftJustify
        DefaultCaptionHeight = 22
        BorderStyle = bvRaised
        CaptionMode = False
        RollUpMode = False
        RollUpState = False
        Caption = 'spSkinPanel2'
        Align = alClient
        object spSkinSplitter4: TspSkinSplitter
          Left = 234
          Top = 26
          Width = 10
          Height = 530
          MinSize = 10
          DefaultSize = 10
          SkinDataName = 'vsplitter'
          SkinData = SknDat_main
        end
        object spSkinPanel8: TspSkinPanel
          Left = 1
          Top = 1
          Width = 807
          Height = 25
          TabOrder = 0
          DrawDefault = True
          SkinData = SknDat_main
          SkinDataName = 'panel'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          NumGlyphs = 1
          Spacing = 2
          DefaultAlignment = taLeftJustify
          DefaultCaptionHeight = 22
          BorderStyle = bvRaised
          CaptionMode = False
          RollUpMode = False
          RollUpState = False
          Caption = 'spSkinPanel2'
          Align = alTop
          object spSkinButton4: TspSkinButton
            Left = 233
            Top = 1
            Width = 573
            Height = 23
            TabOrder = 0
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'button'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clBlue
            DefaultFont.Height = -14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = False
            DefaultWidth = 0
            DefaultHeight = 0
            AllowAllUp = False
            CanFocused = False
            Down = False
            GroupIndex = 0
            Caption = #25628#32034#32467#26524
            NumGlyhps = 2
            Align = alClient
            Spacing = 1
          end
          object spSkinButton7: TspSkinButton
            Left = 1
            Top = 1
            Width = 232
            Height = 23
            TabOrder = 1
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'button'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clBlue
            DefaultFont.Height = -14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = False
            DefaultWidth = 0
            DefaultHeight = 0
            AllowAllUp = False
            CanFocused = False
            Down = False
            GroupIndex = 0
            Caption = #38190#20837#20320#35201#25628#32034#30340#20851#38190#23383'('#22238#36710#38388#38548')'
            NumGlyhps = 2
            Align = alLeft
            Spacing = 1
          end
        end
        object spSkinPanel9: TspSkinPanel
          Left = 244
          Top = 26
          Width = 564
          Height = 530
          TabOrder = 1
          DrawDefault = True
          SkinData = SknDat_main
          SkinDataName = 'panel'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          NumGlyphs = 1
          Spacing = 2
          DefaultAlignment = taLeftJustify
          DefaultCaptionHeight = 22
          BorderStyle = bvRaised
          CaptionMode = False
          RollUpMode = False
          RollUpState = False
          Caption = 'spSkinPanel4'
          Align = alClient
          object spSkinSplitter3: TspSkinSplitter
            Left = 1
            Top = 299
            Width = 562
            Height = 5
            Cursor = crVSplit
            Align = alBottom
            AutoSnap = False
            MinSize = 5
            ResizeStyle = rsUpdate
            DefaultSize = 5
            SkinDataName = 'vsplitter'
            SkinData = SknDat_main
          end
          object listbox_txt_result: TspSkinListBox
            Left = 1
            Top = 1
            Width = 562
            Height = 298
            TabOrder = 0
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'listbox'
            Transparent = False
            TransparentValue = 1
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -15
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            HorizontalExtent = False
            Columns = 0
            RowCount = 0
            ImageIndex = -1
            NumGlyphs = 1
            Spacing = 2
            CaptionMode = False
            DefaultCaptionHeight = 20
            DefaultCaptionFont.Charset = DEFAULT_CHARSET
            DefaultCaptionFont.Color = clWindowText
            DefaultCaptionFont.Height = 14
            DefaultCaptionFont.Name = 'Arial'
            DefaultCaptionFont.Style = []
            DefaultItemHeight = 20
            ItemIndex = -1
            MultiSelect = False
            ListBoxFont.Charset = DEFAULT_CHARSET
            ListBoxFont.Color = clWindowText
            ListBoxFont.Height = -15
            ListBoxFont.Name = 'Arial'
            ListBoxFont.Style = []
            ListBoxTabOrder = 0
            ListBoxTabStop = True
            ExtandedSelect = True
            Sorted = False
            Caption = #27491#25628#32034#30340#25991#20214#25991#20214
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            Align = alClient
            OnClick = listbox_txt_resultClick
            OnDblClick = listbox_txt_resultDblClick
          end
          object spSkinPanel12: TspSkinPanel
            Left = 1
            Top = 304
            Width = 562
            Height = 225
            TabOrder = 1
            DrawDefault = True
            SkinDataName = 'panel'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            Caption = 'spSkinPanel12'
            Align = alBottom
            object memo_txt_text: TspSkinMemo
              Left = 1
              Top = 1
              Width = 543
              Height = 223
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              BitMapBG = False
              VScrollBar = ScrollBar_txt_text
              SkinData = SknDat_main
              SkinDataName = 'memo'
              Transparent = False
              TransparentValue = 0
            end
            object ScrollBar_txt_text: TspSkinScrollBar
              Left = 544
              Top = 1
              Width = 17
              Height = 223
              TabOrder = 1
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'vscrollbar'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 0
              Both = False
              BothMarkerWidth = 0
              BothSkinDataName = 'bothhscrollbar'
              CanFocused = False
              Align = alRight
              Kind = sbVertical
              PageSize = 0
              Min = 0
              Max = 0
              Position = 0
              SmallChange = 1
              LargeChange = 1
            end
          end
        end
        object spSkinPanel10: TspSkinPanel
          Left = 1
          Top = 26
          Width = 233
          Height = 530
          TabOrder = 2
          DrawDefault = True
          SkinDataName = 'panel'
          Transparent = False
          TransparentValue = 50
          UseSkinCursor = False
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = 14
          DefaultFont.Name = 'Arial'
          DefaultFont.Style = []
          UseSkinFont = True
          DefaultWidth = 0
          DefaultHeight = 0
          NumGlyphs = 1
          Spacing = 2
          DefaultAlignment = taLeftJustify
          DefaultCaptionHeight = 22
          BorderStyle = bvRaised
          CaptionMode = False
          RollUpMode = False
          RollUpState = False
          Caption = 'spSkinPanel3'
          Align = alLeft
          object memo_txt_keys: TspSkinMemo
            Left = 1
            Top = 1
            Width = 231
            Height = 120
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Style = []
            Lines.Strings = (
              'chenshaizi')
            ParentFont = False
            TabOrder = 0
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            BitMapBG = False
            SkinData = SknDat_main
            SkinDataName = 'memo'
            Transparent = False
            TransparentValue = 0
          end
          object check_txt_mail: TspSkinCheckRadioBox
            Left = 1
            Top = 121
            Width = 231
            Height = 25
            TabOrder = 1
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'checkbox'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            CanFocused = False
            Radio = False
            Checked = False
            GroupIndex = 0
            Flat = False
            Caption = 'Emai'#25628#32034
            OnClick = check_only_mailClick
            Align = alTop
          end
          object spSkinPanel11: TspSkinPanel
            Left = 1
            Top = 311
            Width = 231
            Height = 218
            TabOrder = 2
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'panel'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            Caption = 'spSkinPanel11'
            Align = alBottom
            object btn_txt_search: TspSkinButton
              Left = 60
              Top = 30
              Width = 118
              Height = 35
              TabOrder = 0
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'button'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              AllowAllUp = False
              CanFocused = False
              Down = False
              GroupIndex = 0
              Caption = #24320#22987#25628#32034
              NumGlyhps = 1
              Spacing = 1
              OnClick = btn_txt_searchClick
            end
            object btn_txt_stop: TspSkinButton
              Left = 57
              Top = 83
              Width = 120
              Height = 32
              TabOrder = 1
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'button'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              AllowAllUp = False
              CanFocused = False
              Down = False
              GroupIndex = 0
              Caption = #20572#27490#25628#32034
              NumGlyhps = 1
              Spacing = 1
              OnClick = btn_txt_stopClick
            end
          end
          object spSkinPanel13: TspSkinPanel
            Left = 1
            Top = 146
            Width = 231
            Height = 165
            TabOrder = 3
            DrawDefault = True
            SkinData = SknDat_main
            SkinDataName = 'panel'
            Transparent = False
            TransparentValue = 50
            UseSkinCursor = False
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = 14
            DefaultFont.Name = 'Arial'
            DefaultFont.Style = []
            UseSkinFont = True
            DefaultWidth = 0
            DefaultHeight = 0
            NumGlyphs = 1
            Spacing = 2
            DefaultAlignment = taLeftJustify
            DefaultCaptionHeight = 22
            BorderStyle = bvRaised
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            Caption = 'spSkinPanel11'
            Align = alClient
            object memo_mailresults: TspSkinMemo
              Left = 1
              Top = 1
              Width = 212
              Height = 163
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Style = []
              Lines.Strings = (
                '')
              ParentFont = False
              TabOrder = 0
              OnChange = memo_KeywordsFilterChange
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              BitMapBG = False
              VScrollBar = ScrollBar_mailresults
              SkinData = SknDat_main
              SkinDataName = 'memo'
              Transparent = False
              TransparentValue = 0
            end
            object ScrollBar_mailresults: TspSkinScrollBar
              Left = 213
              Top = 1
              Width = 17
              Height = 163
              TabOrder = 1
              DrawDefault = True
              SkinData = SknDat_main
              SkinDataName = 'vscrollbar'
              Transparent = False
              TransparentValue = 50
              UseSkinCursor = False
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = 14
              DefaultFont.Name = 'Arial'
              DefaultFont.Style = []
              UseSkinFont = True
              DefaultWidth = 0
              DefaultHeight = 0
              Both = False
              BothMarkerWidth = 0
              BothSkinDataName = 'bothhscrollbar'
              CanFocused = False
              Align = alRight
              Kind = sbVertical
              PageSize = 0
              Min = 0
              Max = 0
              Position = 0
              SmallChange = 1
              LargeChange = 1
            end
          end
        end
      end
    end
    object TabSheet_url: TspSkinTabSheet
      Caption = #32593#39029#27983#35272
      object WebBrowser: TEmbeddedWB
        Left = 0
        Top = 0
        Width = 788
        Height = 415
        Align = alClient
        TabOrder = 0
        OnDownloadBegin = WebBrowserDownloadBegin
        DownloadOptions = [DLCTL_DLIMAGES, DLCTL_VIDEOS, DLCTL_BGSOUNDS]
        UserInterfaceOptions = []
        PrintOptions.Header = ' '
        PrintOptions.HTMLHeader.Strings = (
          '<HTML></HTML>')
        PrintOptions.Footer = ' '
        PrintOptions.Orientation = poPortrait
        ReplaceCaption = False
        EnableDDE = False
        fpExceptions = True
        ControlData = {
          4C0000002F6200000C3C00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object spSkinPanel1: TspSkinPanel
    Left = 0
    Top = 49
    Width = 1006
    Height = 27
    TabOrder = 2
    DrawDefault = True
    SkinData = SknDat_main
    SkinDataName = 'panel'
    Transparent = False
    TransparentValue = 50
    UseSkinCursor = False
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    UseSkinFont = True
    DefaultWidth = 0
    DefaultHeight = 0
    NumGlyphs = 1
    Spacing = 2
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 22
    BorderStyle = bvRaised
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    Caption = 'spSkinPanel1'
    Align = alTop
    object combo_url: TspSkinComboBox
      Left = 76
      Top = 1
      Width = 807
      Height = 25
      TabOrder = 0
      DrawDefault = True
      SkinData = SknDat_main
      SkinDataName = 'combobox'
      Transparent = False
      TransparentValue = 50
      UseSkinCursor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -16
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      HorizontalExtent = True
      ImageIndex = -1
      ListBoxCaptionMode = False
      ListBoxDefaultFont.Charset = DEFAULT_CHARSET
      ListBoxDefaultFont.Color = clWindowText
      ListBoxDefaultFont.Height = 14
      ListBoxDefaultFont.Name = 'Arial'
      ListBoxDefaultFont.Style = []
      ListBoxDefaultCaptionFont.Charset = DEFAULT_CHARSET
      ListBoxDefaultCaptionFont.Color = clWindowText
      ListBoxDefaultCaptionFont.Height = 14
      ListBoxDefaultCaptionFont.Name = 'Arial'
      ListBoxDefaultCaptionFont.Style = []
      ListBoxDefaultItemHeight = 20
      ListBoxCaptionAlignment = taLeftJustify
      Align = alClient
      ItemIndex = -1
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Arial'
      Font.Style = []
      Sorted = True
      Style = spcbEditStyle
    end
    object btn_search: TspSkinButton
      Left = 883
      Top = 1
      Width = 59
      Height = 25
      Hint = #24320#22987#25628#32034
      TabOrder = 1
      DrawDefault = True
      SkinData = SknDat_main
      SkinDataName = 'button'
      Transparent = False
      TransparentValue = 50
      UseSkinCursor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -12
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      AllowAllUp = False
      ShowHint = True
      CanFocused = False
      Down = False
      GroupIndex = 0
      Caption = #25628' '#32034'(&S)'
      NumGlyhps = 1
      Align = alRight
      Spacing = 1
      OnClick = btn_searchClick
    end
    object btn_zd: TspSkinButton
      Left = 942
      Top = 1
      Width = 63
      Height = 25
      Hint = #25171#24320#31449#28857
      TabOrder = 2
      DrawDefault = True
      SkinData = SknDat_main
      SkinDataName = 'button'
      Transparent = False
      TransparentValue = 50
      UseSkinCursor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      AllowAllUp = False
      ShowHint = True
      CanFocused = False
      Down = False
      GroupIndex = 0
      Caption = #27983#35272
      Glyph.Data = {
        42050000424D4205000000000000360000002800000016000000130000000100
        1800000000000C05000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FEFE
        FE298829147F141C821C228722268826278927258925248B24248B24238B2218
        93191592140F950F0B950A059205038B02017B01207320FFFFFFD8E9ECD8E9EC
        0000FFFFFF0F840F1D8C1D299229309630349834359935329932329A31329832
        2A9A2A229D221B9F1A14A1140EA60E09A408039D03018901016801FFFFFFD8E9
        ECD8E9EC0000FFFFFF158A152693263298323A9D3A3E9F3E3EA03E3CA03C3AA1
        3AA4D4A4FFFFFF29A32821A52019A91912AA120CAB0C06A506039203026C02FF
        FFFFD8E9ECD8E9EC0000FFFFFF198C192F972F3B9D3B43A14347A34746A44644
        A44440A542FFFFFFFFFFFFFFFFFF25AB251DAD1D16B0160FAF0F0BA90A069506
        036F03FFFFFFD8E9ECD8E9EC0000FFFFFF1F8F1F379B3743A0434AA44A4DA64D
        4BA64B48A64945A74641A843FFFFFFFFFFFFFFFFFF1FB12019B21913B0130EA9
        0E0C960C077107FFFFFFD8E9ECD8E9EC0000FFFFFF2693263E9E3E49A3494FA6
        4F51A8514FA84F4CA74C48A84847A8483EAA40FFFFFFFFFFFFFFFFFF1BB01B17
        AF1714A7141197110B720BFFFFFFD8E9ECD8E9EC0000FFFFFF2C952C45A1454F
        A74F53A85354A95452A9524EA84E49A74947A84741AA3E34AC34FFFFFFFFFFFF
        FFFFFF19AC1918A619179715107610FFFFFFD8E9ECD8E9EC0000FFFFFF2C952C
        45A1454FA74FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF19A619179816107512FFFFFFD8E9ECD8E9EC0000FFFF
        FF2C952C45A1454FA74FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF19A519179817107412FFFFFFD8E9ECD8E9EC
        0000FFFFFF3398334CA54C55A95557AA5756AA5653A8534FA74E4AA64A46A646
        40A74038A738FFFFFFFFFFFFFFFFFF1EA51D1DA11D1C961D167413FFFFFFD8E9
        ECD8E9EC0000FFFFFF389B3852A85258AB585AAB5A58AA5854A85350A7514DA6
        4D49A64943A643FFFFFFFFFFFFFFFFFF29A12725A025239F23229422187217FF
        FFFFD8E9ECD8E9EC0000FFFFFF4EA64E6FB76F71B9716BB56B63AF635CAB5B55
        A85651A7514DA74DFFFFFFFFFFFFFFFFFF36A1352F9E2E2D9B2C2E972D2D8E2D
        1E721EFFFFFFD8E9ECD8E9EC0000FFFFFF53A8537ABD7A7DBE7D72B97268B368
        61AE615DAB5C58A858FFFFFFFFFFFFFFFFFF44A4443EA13E389E38339A333197
        312D8D2D1E721EFFFFFFD8E9ECD8E9EC0000FFFFFF59AC5989C4898DC68D80BF
        8072B8726BB46B65B1655FAE5FB5DAB5FFFFFF51A9524BA64C46A34641A0413B
        9D3B3599352B8C2B196F19FFFFFFD8E9ECD8E9EC0000FFFFFF66B26697CB979A
        CD9A89C4897BBD7B73B9736EB66E69B36966B2675EAF6057AB5850A8524DA74E
        4BA44B44A144389A38298B29166C16FFFFFFD8E9ECD8E9EC0000FFFFFF77BB77
        90C89094CA9485C28576BB766FB76F69B46967B26767B16765B26556AC5953A9
        5550A64F4AA54A40A040339833248924317F31FDFEFED8E9ECD8E9EC0000EEF5
        F7DCEDDC74B97461B06156AA564EA64E49A34943A04345A14545A24546A1463D
        9D3C359A35349A3431983229942A208D20358F35D2E3D2EEF5F7D8E9ECD8E9EC
        0000DBEBEEEEF5F7FDFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF6F7DBEBEED8E9
        ECD8E9EC0000}
      NumGlyhps = 1
      Align = alRight
      Spacing = 1
      OnClick = btn_zdClick
    end
    object spSkinButton1: TspSkinButton
      Left = 1
      Top = 1
      Width = 75
      Height = 25
      TabOrder = 3
      DrawDefault = True
      SkinData = SknDat_main
      SkinDataName = 'button'
      Transparent = False
      TransparentValue = 50
      UseSkinCursor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      AllowAllUp = False
      CanFocused = False
      Down = False
      GroupIndex = 0
      Caption = #22320#22336'(D)'
      NumGlyhps = 2
      Align = alLeft
      Spacing = 1
    end
  end
  object memotemP: TMemo
    Left = 280
    Top = 0
    Width = 25
    Height = 17
    Lines.Strings = (
      '')
    TabOrder = 3
    Visible = False
  end
  object Memo_tmp_mail: TMemo
    Left = 312
    Top = 0
    Width = 25
    Height = 17
    TabOrder = 4
    Visible = False
  end
  object spSkinPanel5: TspSkinPanel
    Left = 0
    Top = 22
    Width = 1006
    Height = 27
    TabOrder = 5
    DrawDefault = True
    SkinData = SknDat_main
    SkinDataName = 'panel'
    Transparent = False
    TransparentValue = 50
    UseSkinCursor = False
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    UseSkinFont = True
    DefaultWidth = 0
    DefaultHeight = 0
    NumGlyphs = 1
    Spacing = 2
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 22
    BorderStyle = bvRaised
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    Caption = 'spSkinPanel5'
    Align = alTop
    object btn_stop: TspSkinButtonLabel
      Left = 225
      Top = 1
      Width = 64
      Height = 25
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0005B70005B70005B7FF00FFFF00FFFF00FF0005B70005B70005
        B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0005B70005B70005B7FF00FFFF00FFFF00FFFF00FF
        0005B70005B70005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0005B70005B70005B70005B7FF00FFFF00FFFF
        00FFFF00FFFF00FF0005B70005B70005B70005B70005B7FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B70005B70005B7FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B70005B70005B700
        05B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B70005B7
        0005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006
        F60005B70005B70005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FF0005B700
        05B70005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0005B70005B70005B70005B7FF00FFFF00FF0005
        B70005B70005B70005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B70005B7
        0005B70005B70005B70005B70005B70005B7FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF0005B70005B70006F60005B70006F60005B70005B7FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0005B70005B70005B70006F60005B7FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B70006F60005B70005
        B70006F60006F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B70006F6
        0005B70006F60006F60006F60005B70006F6FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006F600
        06F60006F60005B70006F6FF00FFFF00FF0006F60006F60006F60006F6FF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0006F60006F60005B70006F60006F6FF00FFFF00FFFF00FFFF00FF0006F600
        06F60006F60006F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0006F60006F60006F60006F60006F6FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF0006F60006F60006F6FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0006F60006F60006F60006F60006F6FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006F60006F60006F6FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0006F60006F60006F60006F60006F6FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0006F6FF00FFFF00FFFF00FFFF00FFFF00FF0006F60006F60006F60006
        F60006F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006F6
        0006F60006F60006F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF0006F60006F60006F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 1
      Spacing = 0
      UseSkinFont = True
      DefaultActiveFontColor = clBlue
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      SkinData = SknDat_main
      SkinDataName = 'stdlabel'
      Align = alLeft
      Caption = #20572#27490
      OnClick = btn_stopClick
    end
    object btn_tool_pre: TspSkinButtonLabel
      Left = 57
      Top = 1
      Width = 40
      Height = 25
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0132020132020135020140030140
        03013502013302013202FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF012F01013302014403026A06
        037F09038709038709038109027007014B04013502013202FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF02460401430302
        7507039A0B03A70C03A40C03A10C03A10C03A40C03A70C039E0C027E08024E04
        013502FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF034F
        07025606039D0D03A60C03A10C039E0C039E0C039E0C039E0C039E0C039E0C03
        9F0C03A60C03A10C026606013602FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF04540B055F0C07A91805A512049E0D039E0C039E0B019C08019C07039E
        0B039E0C039E0C039E0C039E0C03A10C03A70C026C07013602FF00FFFF00FFFF
        00FFFF00FFFF00FF023D04055F0E0CAD2709A61D07A11706A012039E0D029D0A
        039E0C039E0C039E0C039E0C039E0C039E0C039E0C039E0C039F0C03A70C026A
        06013502FF00FFFF00FFFF00FFFF00FF0341060FA62C0FB02D0BA52309A61D07
        A317029D0C039E0C039E0C64CB6CEDF8EDEDF8ED97DD9D07A111039E0C039E0C
        039E0C03A00C03A40C014904FF00FFFF00FFFF00FF034D050A761C14B83C10AA
        300DA9280AA41F049F11059F0F039E0C039E0C6ECF77FFFFFFFFFFFFFFFFFF9A
        DEA007A111039E0C039E0C039E0C03A70C037B09013502FF00FFFF00FF034E06
        15A63C18B14113AC370EA72A05A014049F0E049F0D049E0D039E0C0AA31392DC
        99FFFFFFFFFFFFFFFFFF93DC9A06A00F039E0C039E0C039F0C03A00C014403FF
        00FF0255040767131CB85017B04616AD3E0CA72907A113039E0C039E0C039E0C
        039E0C039E0C039E0C7ED486FEFFFEFFFFFFFFFFFF8CD993059F0E039E0C039E
        0C03A70C025E050138020256040D802321BA561BB24C14AF412DB8522DB64321
        AF2D26B23728B43B23B13124B13423B0321FAD2AA5E2AAFFFFFFFFFFFFFFFFFF
        84D78B039E0C039E0B03A70C027507013802035D0613902F2ABF601EB55022B6
        53DDF4E6F8FCFAF7FCF8F7FCFAF7FCFAF7FCFAF7FCFAF8FCFAF3FBF4EEFAEFFF
        FFFFFFFFFFFFFFFFFFFFFF77D17F039E0B03A70C037F090136020366071D9A39
        43C57326B65721B553FEFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEFAEF039E0C03A40C03810901
        4604046D081D9A395CD08939BF6821B553BAEACCDDF4E6DCF4E6DCF4E6DCF4E6
        DCF4E6DCF4E6DCF4E3CFF0D5DEF4E1FFFFFFFFFFFFFFFFFFF3FBF44AC157049F
        0F03A70D037F090138020375091A96306DD5975ACE8620B45123B65528B75928
        B75928B75928B75928B75821B44C13AC382DB84DC1EDCCFFFFFFFFFFFFEEFAF2
        47C1620DA72906A11403A70D027007013802FF00FF0E8B1C6CD49588DCA63BC4
        6D16AF4A22B55421B55321B55321B55322B5541FB45042C26AD3F2DCFFFFFFFF
        FFFFE6F7EB40C05E0DA92C0AA52105A01203A70C015905FF00FFFF00FF0F921C
        49C16CA7E6C076D59829B85915B0481FB55121B55321B55321B55358CA81EFFB
        F3FFFFFFFFFFFFE0F6E636BB530CA7260BA52108A31906A415049E0F014003FF
        00FFFF00FFFF00FF1BA0319AE3BAB1E9C65DCB8623B55414AF461FB45121B553
        21B553A1E3BBFFFFFFFFFFFFD7F3E034BA5610A92F0FA92B0CA7240AA41F09B0
        1C04750DFF00FFFF00FFFF00FFFF00FF28A13249C16CB5EACEB1E9C659CB8229
        B85916AF491FB45121B5534DC678E2F7EABDEBCF2DB85713AC3E13AB3611AA31
        0FA92B0CAD270AA51F024405FF00FFFF00FFFF00FFFF00FFFF00FF149C246BD1
        8BC5EFD5BDEDD073D4983EC06C1FB4511CB24E28B85A21B5531AB14C1BB24C19
        B04518B14116AC3A12AD340FB02D055F0FFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF1597246CD495C5EFD5D0F2DDA4E3BC6FD39350C67939BF6830BC
        6235BC6437BF6737BF672EBA5A20B74C16B23D076713FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C9E284FC4739AE3BABDEDD0C5EFD5
        B2E9C99DE1B78CDCAA81D9A473D49858CC843BC46D1FAF49076914FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C9E2819
        A33150C67981D9A495E2B595E2B58ADEAC76D89D5ACE8635BC64169132055F0C
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF1C9E2819A02F26A94326A94328A94623A14014912B06
        700FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 1
      Spacing = 0
      UseSkinFont = True
      DefaultActiveFontColor = clBlue
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      SkinData = SknDat_main
      SkinDataName = 'stdlabel'
      Align = alLeft
      AutoSize = True
      OnClick = btn_tool_preClick
    end
    object btn_tool_back: TspSkinButtonLabel
      Left = 1
      Top = 1
      Width = 56
      Height = 25
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0132020132020135020140030140
        03013502013302013202FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF012F01013302014403026A06
        037F09038709038709038109027007014B04013502013202FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF02460401430302
        7507039A0B03A70C03A40C03A10C03A10C03A40C03A70C039E0C027E08024E04
        013502FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF034F
        07025606039D0D03A60C03A10C039E0C039E0C039E0C039E0C039E0C039E0C03
        9F0C03A60C03A10C026606013602FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF04540B055F0C07A91805A512049E0D039E0C039E0B019C08019C07039E
        0B039E0C039E0C039E0C039E0C03A10C03A70C026C07013602FF00FFFF00FFFF
        00FFFF00FFFF00FF023D04055F0E0CAD2709A61D07A11706A012039E0D029D0A
        039E0C039E0C039E0C039E0C039E0C039E0C039E0C039E0C039F0C03A70C026A
        06013502FF00FFFF00FFFF00FFFF00FF0341060FA62C0FB02D0BA52309A61D07
        A317029D0C08A11197DD9DEDF8EDEDF8ED64CB6C039E0C039E0C039E0C039E0C
        039E0C03A00C03A40C014904FF00FFFF00FFFF00FF034D050A761C14B83C10AA
        300DA9280AA41F049F110AA3149ADEA0FFFFFFFFFFFFFFFFFF6ECF77039E0C03
        9E0C039E0C039E0C039E0C039E0C03A70C037B09013502FF00FFFF00FF034E06
        15A63C18B14113AC370EA72A05A01407A11195DC9AFFFFFFFFFFFFFFFFFF92DC
        990AA313039E0C039E0C039E0C039E0C039E0C039E0C039F0C03A00C014403FF
        00FF0255040767131CB85017B04616AD3E0CA72909A3168ED995FFFFFFFFFFFF
        FEFFFE7ED486039E0C039E0C039E0C039E0C039E0C039E0C039E0C039E0C039E
        0C03A70C025E050138020256040D802321BA561BB24C14AF411CB1428EDA9CFF
        FFFFFFFFFFFFFFFFA7E3AD24B13423B0321FAD2A1EAD291EAD291EAD291EAD29
        1FAF2A12A71C039E0B03A70C027507013802035D0613902F2ABF601EB55022B6
        538EDDABFFFFFFFFFFFFFFFFFFFFFFFFF0FBF4F6FCF7F8FCFAF6FCF7F6FCF7F6
        FCF7F6FCF7F6FCF7F6FCF7D5F2D8039E0B03A70C037F090136020366071D9A39
        43C57326B65721B553F2FBF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFE039E0C03A40C03810901
        4604046D081D9A395CD08939BF6821B55364CF8BF6FCF8FFFFFFFFFFFFFFFFFF
        E3F7EBD5F3E1DCF4E3D7F3DDD5F2D9D5F2D9D5F2D9D5F2D8D7F2D9ACE5B4049F
        0F03A70D037F090138020375091A96306DD5975ACE8620B45121B5535ACB83F0
        FBF4FFFFFFFFFFFFC9EFD739BF6213AC3816AD3515AD3515AC3514AC3313AB2F
        13AB2F0FA92B06A11403A70D027007013802FF00FF0E8B1C6CD49588DCA63BC4
        6D16AF4A22B55451C77DEAF8EFFFFFFFFFFFFFD7F3E142C26A12AB350FAA300F
        AA300FAA2F0FAA2F0DA92C0AA52105A01203A70C015905FF00FFFF00FF0F921C
        49C16CA7E6C076D59829B85915B0481FB55149C576E3F7EBFFFFFFFFFFFFEFFB
        F352C77810AA320FAA300EA92B0CA7260BA52108A31906A415049E0F014003FF
        00FFFF00FFFF00FF1BA0319AE3BAB1E9C65DCB8623B55414AF461FB45142C26F
        DAF4E5FFFFFFFFFFFFA1E2B813AC3813AB3610A92F0FA92B0CA7240AA41F09B0
        1C04750DFF00FFFF00FFFF00FFFF00FF28A13249C16CB5EACEB1E9C659CB8229
        B85916AF491FB4513CC06BBDEBCFE2F7EA4DC77713AC3E13AC3E13AB3611AA31
        0FA92B0CAD270AA51F024405FF00FFFF00FFFF00FFFF00FFFF00FF149C246BD1
        8BC5EFD5BDEDD073D4983EC06C1FB4511CB24E28B85A21B5531AB14C1BB24C19
        B04518B14116AC3A12AD340FB02D055F0FFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF1597246CD495C5EFD5D0F2DDA4E3BC6FD39350C67939BF6830BC
        6235BC6437BF6737BF672EBA5A20B74C16B23D076713FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C9E284FC4739AE3BABDEDD0C5EFD5
        B2E9C99DE1B78CDCAA81D9A473D49858CC843BC46D1FAF49076914FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C9E2819
        A33150C67981D9A495E2B595E2B58ADEAC76D89D5ACE8635BC64169132055F0C
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF1C9E2819A02F26A94326A94328A94623A14014912B06
        700FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 1
      Spacing = 0
      UseSkinFont = True
      DefaultActiveFontColor = clBlue
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      SkinData = SknDat_main
      SkinDataName = 'stdlabel'
      Align = alLeft
      Caption = #21518#36864
      OnClick = btn_tool_backClick
    end
    object btn_tool_refresh: TspSkinButtonLabel
      Left = 97
      Top = 1
      Width = 32
      Height = 25
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFA87D78B78183B78183B78183B78183B78183B78183B78183B78183B781
        83B78183B78183B78183B78183B78183B78183B78183B78183B78183FF00FFFF
        00FFFF00FFFF00FFFF00FFA97F79F3DDC4F8E3C6F6DFBFF5DCB8F4D9B2F3D7AC
        F3D4A7F2D2A0F0CF9AF0CE98F0CE98F0CE98F0CE98F0CE98F0CE98F1CF98EFCD
        97B3897BFF00FFFF00FFFF00FFFF00FFFF00FFA97F7AF2DEC8F7E3CAF5DFC2F4
        DCBCB8CA8AE7D4A9E6D1A3F1D2A5F0CF9FEFCD9AEECC97EECC97EECC97EECC97
        EECC97EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FFFF00FFA97F7AF2E0
        CEF8E7CFF5E2C8F5DEC2CED29F029A03E7D4A96DB44E3CA82A3CA7296CB147C3
        C37CE3CA90EECC97EECC97EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FF
        FF00FFA97F7AF3E3D2F9E9D4F6E4CDF5E1C7EADBB8029A030F9D0D029A03029A
        03029A03029A03029A0393B95EE3CA90EECC97EFCD97EDCB96B3897BFF00FFFF
        00FFFF00FFFF00FFFF00FFA97F7BF4E6D8FAECDAF8E7D3F6E4CCEADEBE029A03
        029A03029A03029A03029A03029A03029A03029A03C0C27AEECC97EFCD97EDCB
        96B3897BFF00FFFF00FFFF00FFFF00FFFF00FFAA807BF5E9DDFBEFE0F8EAD9F7
        E6D2EBE1C3029A03029A03029A033DA92FC3CB8FC2C98B6DB34C029A033BA627
        EECC97EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FFFF00FFAD837DF5EC
        E3FBF2E6F9EDDEF8E9D7EBE3C8029A03029A03029A0330A626E8D6AEE7D4A9E6
        D1A3A6C0720F9D0CEECC99EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FF
        FF00FFB2887EF7EFE8FCF5ECFAEFE4F9ECDDECE5CE029A03029A03029A03029A
        03029A03E8D6AFF1D7B0F1D4ABF0D2A57ACE7FEFCD9AEDCA96B3897BFF00FFFF
        00FFFF00FFFF00FFFF00FFB68B80F8F2EEFDF8F1FAF3EAF9EFE3EDE8D3ECE5CE
        EBE2C8EBE1C3EADEBDE9DCB8E9D9B3F3D9B6F2D6B0F1D4AA7ACE7FF0D09FEDCB
        98B3897BFF00FFFF00FFFF00FFFF00FFFF00FFBA8E82FAF6F4FEFCF8FCF6F07A
        CE7FFAF0E4F9EDDDF8E9D8EBE3C8EBE1C3EADEBEEADBB9E9D9B2E8D6AEE6D4A8
        F1D4AAF1D2A5EECD9EB3897CFF00FFFF00FFFF00FFFF00FFFF00FFBE9283FBF8
        F7FFFFFEFEFAF67ACE7FFAF2EAFAF0E3F9ECDDEDE5CE029A03029A03029A0302
        9A03029A03E8D6AEF2D7B0F2D5ABEFCFA4B48A7DFF00FFFF00FFFF00FFFF00FF
        FF00FFC29685FBF8F7FFFFFFFFFEFCFEF9F4109F10ADD7A2EEEBD8EDE9D3ECE5
        CD30A82A029A03029A03029A03E9D9B2F3D9B5F2D7B0F0D2A8B48B7EFF00FFFF
        00FFFF00FFFF00FFFF00FFC69986FBF8F7FFFFFFFFFFFFFFFDFC3FB13E029A03
        71C16AC9DFB8C9DCB23EAD37029A03029A03029A03EADBB7F4DCBBF4DAB6F1D5
        AEB18A7FFF00FFFF00FFFF00FFFF00FFFF00FFCA9C88FBF8F7FFFFFFFFFFFFFF
        FFFFCDEACB029A03029A03029A03029A03029A03029A03029A03029A03EADEBD
        F4DEC0F3DBBAD9C4A7A0847DFF00FFFF00FFFF00FFFF00FFFF00FFCEA089FCF9
        F7FFFFFFFFFFFFFFFFFFF3FAF39ED89C029A03029A03029A03029A03029A0310
        9E0F029A03EBE1C3EBD9C0D1C1ABB5A89798817CFF00FFFF00FFFF00FFFF00FF
        FF00FFD2A38AFCF9F7FFFFFFFFFFFFFFFFFFFFFFFFF3FAF3D1EBCF72C56F3FB0
        3C3EAF3B71C067EEE9D4029A03C3D1AAC8BDAFBAB0A2B7AC9D9C837EFF00FFFF
        00FFFF00FFFF00FFFF00FFD7A78CFCF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFEFCFDF9F4FCF5EEFCF5EBE3DAC7AA827183865AAA7F76AB7F76AB7F
        76AD8274FF00FFFF00FFFF00FFFF00FFFF00FFDAAB8DFCF9F8FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFDF9F4FFFBF3E3CEC6B38176E3B585
        E5AD6AE9A654EFA039B88285FF00FFFF00FFFF00FFFF00FFFF00FFDEAD8EFDFA
        F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFFFEF9E5
        D1CBB38176EFC48DF3BB6DF8B450B88285FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFDEAD8EFDFAF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFE5D4D0B38176EFC38CF3BA6CB88285FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFDEAD8EFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9DBD9B38176F1C58BB88285FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDAA482DAA482DAA482DAA482DA
        A482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482B38176B88285
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 1
      Spacing = 0
      UseSkinFont = True
      DefaultActiveFontColor = clBlue
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      SkinData = SknDat_main
      SkinDataName = 'stdlabel'
      Align = alLeft
      OnClick = btn_tool_refreshClick
    end
    object btn_tool_stop: TspSkinButtonLabel
      Left = 129
      Top = 1
      Width = 40
      Height = 25
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFA87D78B78183B78183B78183B78183B78183B78183B78183B78183B781
        83B78183B78183B78183B78183B78183B78183B78183B78183B78183FF00FFFF
        00FFFF00FFFF00FFFF00FFA97F79F3DDC4F8E3C6F6DFBFF5DCB8F4D9B2F3D7AC
        F3D4A7F2D2A0F0CF9AF0CE98F0CE98F0CE98F0CE98F0CE98F0CE98F1CF98EFCD
        97B3897BFF00FFFF00FFFF00FFFF00FFFF00FFA97F7AF2DEC8F7E3CAF5DFC2F4
        DCBCF3DAB6F2D7B1F1D4ABF1D2A5F0CF9FEFCD9AEECC97EECC97EECC97EECC97
        EECC97EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FFFF00FFA97F7AF2E0
        CEF8E7CFF5E2C8F5DEC2F4DCBCF3DAB7F2D7B1F1D4ABF1D2A5F0CFA0EFCD9AEE
        CC97EECC97EECC97EECC97EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FF
        FF00FFA97F7AF3E3D2F9E9D4F6E4CDF5E1C7F5DEC1F4DCBCF3D9B6F2D7B0F1D4
        AAF1D2A5F0CFA0EECC99EECC97EECC97EECC97EFCD97EDCB96B3897BFF00FFFF
        00FFFF00FFFF00FFFF00FFA97F7BF4E6D8FAECDAF8E7D3F6E4CCF5E1C7F5DFC2
        F4DCBCF3D9B6F2D7B0F1D4ABF1D2A6F0CFA0EECD9AEECC97EECC97EFCD97EDCB
        96B3897BFF00FFFF00FFFF00FFFF00FFFF00FFAA807BF5E9DDFBEFE0F8EAD9F7
        E6D29CA3DE526DEAF4DEC2F4DCBCF3D9B6F2D7B15069E19998C5F0CFA0EECC99
        EECC97EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FFFF00FFAD837DF5EC
        E3FBF2E6F9EDDEF8E9D7254EF50335FB526DEAF5DFC1F4DCBB516AE50335FB25
        4BF0F1D2A5F0CFA0EECC99EFCD97EDCB96B3897BFF00FFFF00FFFF00FFFF00FF
        FF00FFB2887EF7EFE8FCF5ECFAEFE4F9ECDDC9C6DF0F3EF90335FB526DEA526C
        E80335FB0F3DF8C3B8BEF1D4ABF0D2A5F0CF9FEFCD9AEDCA96B3897BFF00FFFF
        00FFFF00FFFF00FFFF00FFB68B80F8F2EEFDF8F1FAF3EAF9EFE3F9ECDDC8C6DF
        0F3EF90335FB0335FB0F3EF8C5BBC8F3D9B6F2D6B0F1D4AAF0D1A4F0D09FEDCB
        98B3897BFF00FFFF00FFFF00FFFF00FFFF00FFBA8E82FAF6F4FEFCF8FCF6F0FA
        F2EAFAF0E4F9EDDD4364F20335FB0335FB4362EDF5DEC2F4DCBBF3D9B6F1D7B0
        F1D4AAF1D2A5EECD9EB3897CFF00FFFF00FFFF00FFFF00FFFF00FFBE9283FBF8
        F7FFFFFEFEFAF6FCF5EFFAF2EA5372F30335FB0D3CFA0D3CF90335FB526DEAF5
        DEC1F4DCBCF3D9B6F2D7B0F2D5ABEFCFA4B48A7DFF00FFFF00FFFF00FFFF00FF
        FF00FFC29685FBF8F7FFFFFFFFFEFCFEF9F44064F80335FB103EFAC9C9E3C8C6
        DE0F3EF90335FB3E5FEEF5DEC1F4DCBBF3D9B5F2D7B0F0D2A8B48B7EFF00FFFF
        00FFFF00FFFF00FFFF00FFC69986FBF8F7FFFFFFFFFFFFFFFDFC2651FA103FFA
        CACDEDFAF0E4F9ECDDC8C7DF0F3EF9254EF4F6E1C6F5DEC0F4DCBBF4DAB6F1D5
        AEB18A7FFF00FFFF00FFFF00FFFF00FFFF00FFCA9C88FBF8F7FFFFFFFFFFFFFF
        FFFFC9D3FCCDD3F6FCF6EFFBF2EAFAEFE3F9ECDDC8C6DEC3C0DAF6E3CBF5E1C6
        F4DEC0F3DBBAD9C4A7A0847DFF00FFFF00FFFF00FFFF00FFFF00FFCEA089FCF9
        F7FFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFEF9F5FCF5EFFBF2E9FAF0E3F9ECDDF8
        E9D7F8E6D1F6E4CCEBD9C0D1C1ABB5A89798817CFF00FFFF00FFFF00FFFF00FF
        FF00FFD2A38AFCF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFDFAF5FCF6
        EFFAF2E9FAEFE2FAEDDEFBEEDBE7DBC9C8BDAFBAB0A2B7AC9D9C837EFF00FFFF
        00FFFF00FFFF00FFFF00FFD7A78CFCF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFEFCFDF9F4FCF5EEFCF5EBEEDDD1B28176AD8076AA7F76AB7F76AB7F
        76AD8274FF00FFFF00FFFF00FFFF00FFFF00FFDAAB8DFCF9F8FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFDF9F4FFFBF3E3CEC6B38176E3B585
        E5AD6AE9A654EFA039B88285FF00FFFF00FFFF00FFFF00FFFF00FFDEAD8EFDFA
        F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFFFEF9E5
        D1CBB38176EFC48DF3BB6DF8B450B88285FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFDEAD8EFDFAF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFE5D4D0B38176EFC38CF3BA6CB88285FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFDEAD8EFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9DBD9B38176F1C58BB88285FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDAA482DAA482DAA482DAA482DA
        A482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482B38176B88285
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 1
      Spacing = 0
      UseSkinFont = True
      DefaultActiveFontColor = clBlue
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      SkinData = SknDat_main
      SkinDataName = 'stdlabel'
      Align = alLeft
      OnClick = btn_tool_stopClick
    end
    object btn_tool_search: TspSkinMenuButton
      Left = 169
      Top = 1
      Width = 56
      Height = 25
      TabOrder = 0
      DrawDefault = True
      SkinData = SknDat_main
      SkinDataName = 'toolmenubutton'
      Transparent = False
      TransparentValue = 50
      UseSkinCursor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      UseSkinFont = True
      DefaultWidth = 0
      DefaultHeight = 0
      AllowAllUp = True
      CanFocused = False
      Down = False
      GroupIndex = 1
      Caption = #25628#32034
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FF92635DA46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769A46769A46769A46769A46769A46769A46769A46769FF00FFFF
        00FFFF00FFFF00FF646365314B62AC7D7EF6DAB6F3D5ADF2D1A5F0CE9EEFCB97
        EFC791EEC589EBC182EBC080EBC080EBC080EBC080EBC080EBC080EDC180EABF
        7F9F6F60FF00FFFF00FFFF00FFFF00FF5084B20F6FE1325F8CB87E7AF2D5B1F0
        D1AAEFCFA3EECB9DEDC796EDC58FEBC188EABF82E9BD7FE9BD7FE9BD7FE9BD7F
        E9BD7FEABF7FE7BC7E9F6F60FF00FFFF00FFFF00FFFF00FF32A0FE37A1FF106F
        E2325F8BB67D79F2D4B1F0D1AAEFCFA4EECB9DEDC796EDC58FEBC189EABF82E9
        BD7FE9BD7FE9BD7FE9BD7FEABF7FE7BC7E9F6F60FF00FFFF00FFFF00FFFF00FF
        FF00FF37A4FE379FFF0E6DDE355F89BB7F79F2D4B0F0D1AAEFCEA3EECB9CEDC7
        95EDC58FEBC189E9BD81E9BD7FE9BD7FE9BD7FEABF7FE7BC7E9F6F60FF00FFFF
        00FFFF00FFFF00FFFF00FF93656037A4FE359EFF0F6FDE35608BA67B7FF2D5B1
        F0D1AAEFCEA3EECB9CEDC796EDC590EBC189E9BF82E9BD7FE9BD7FEABF7FE7BC
        7E9F6F60FF00FFFF00FFFF00FFFF00FFFF00FF956660F2E2D338A5FE329DFF15
        6DCE444F5BDAB8A0925D5A986660935E5B9A6663B88A74D7AB82EBC189E9BD81
        E9BD7FEABF7FE7BC7E9F6F60FF00FFFF00FFFF00FFFF00FFFF00FF986963F2E6
        DAFAEEDE3BABFFA1CAE78F6D6B96665FC2A38CE9DCB7FBF8CBE7DCB6BF9A899D
        6B66CB9E7BEBC189E9BD81EABF7FE7BC7E9F6F60FF00FFFF00FFFF00FFFF00FF
        FF00FF9E6E64F4EAE1FBF2E6F8EADCB49291A06D66EDD4A4FFFCCAFFFFCFFFFF
        CFFFFFD5FFFFEAE3D3CC96635FD5AB82EBC188EABF82E7BB7E9F6F60FF00FFFF
        00FFFF00FFFF00FFFF00FFA37266F6EEE9FCF6EDF8EFE3A16C67C79F81F6D095
        FCF4C2FFFFCFFFFFD8FFFFEEFFFFFAFFFFFFB79387B88A73EBC48EEBC288E7BC
        809F6F60FF00FFFF00FFFF00FFFF00FFFF00FFA77568F8F3F0FEFBF6FBF3EB9D
        6A64E7C28EEEB87FFBF0BDFFFFD0FFFFDCFFFFF7FFFFFAFFFFE6DCCEAD996560
        EDC795EDC58FE9BF879F6F62FF00FFFF00FFFF00FFFF00FFFF00FFAC7969FAF6
        F4FFFFFEFEF8F3935F5BF7D495EAA76CF7DAA3FFFFCEFFFFD4FFFFE1FFFFE3FF
        FFD7F6F2C9935E5BEECB9CEEC996EAC18EA07063FF00FFFF00FFFF00FFFF00FF
        FF00FFB17E6BFAF6F4FFFFFFFFFEFB9E6B65E9C793EAA96AEFBD80FAE9B4FFFF
        D0FFFFD3FFFFD1FFFFD1E1D1B0996660EFCEA1EECB9CEBC592A07264FF00FFFF
        00FFFF00FFFF00FFFF00FFB6816CFAF6F4FFFFFFFFFFFFA4706BCBA989F8E2B5
        F0C690F0C286F7DCA5FEF3C1FEF8C6FFFFCFBB9984BB8F7EF0D1A9F0CFA3EDC9
        999D7065FF00FFFF00FFFF00FFFF00FFFF00FFBB846EFAF6F4FFFFFFFFFFFFE5
        D5D5A07068EDE3E2FFF4E2EFBD80EBAB6FF0C086FBDEA3EBD9A9986760DAB89F
        F0D4AFEFD0A7CEB491896A63FF00FFFF00FFFF00FFFF00FFFF00FFC0896FFBF7
        F4FFFFFFFFFFFFFFFFFFD7C0BF9E6F6BC6A999EAD19EFADA9CE9C793C59D829D
        6A64D0AC9CF3DCBDE5CEAFC4B096A1927F806762FF00FFFF00FFFF00FFFF00FF
        FF00FFC58C70FBF7F4FFFFFFFFFFFFFFFFFFFFFFFFE5D5D5A4766A9A6862935F
        5B9E6A64BD988FE0C4B5FAE9D0E0D0BAB8AB9AA79C8BA49786846964FF00FFFF
        00FFFF00FFFF00FFFF00FFCB9173FBF7F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFEFBFCF7F0FBF2E9FBF2E5E9D3C49E675B98665B95655B96655B9665
        5B986859FF00FFFF00FFFF00FFFF00FFFF00FFCF9674FBF7F6FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFAFCF7F0FFFAEFDAC0B69F675BDAA16B
        DD984FE2903AEA8923A5686BFF00FFFF00FFFF00FFFF00FFFF00FFD49875FCF8
        F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFBFFFEF7DD
        C4BC9F675BEAB474EFA952F6A036A5686BFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFD49875FCF8F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFDDC7C29F675BEAB273EFA751A5686BFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFD49875FFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2D0CE9F675BEDB572A5686BFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCF8E68CF8E68CF8E68CF8E68CF
        8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E689F675BA5686B
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyhps = 1
      Align = alLeft
      Spacing = 1
      OnClick = btn_searchClick
      TrackButtonMode = False
    end
  end
  object btn_status: TspSkinLabel
    Left = 0
    Top = 655
    Width = 1006
    Height = 22
    TabOrder = 6
    DrawDefault = True
    SkinData = SknDat_main
    SkinDataName = 'label'
    Transparent = False
    TransparentValue = 50
    UseSkinCursor = False
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -12
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    UseSkinFont = False
    DefaultWidth = 0
    DefaultHeight = 0
    BorderStyle = bvLowered
    AutoSize = False
    Align = alBottom
    Caption = #20934#22791#23601#32490
  end
  object SkinFrm_main: TspDynamicSkinForm
    ShowObjectHint = False
    UseSkinCursors = False
    DefCaptionFont.Charset = DEFAULT_CHARSET
    DefCaptionFont.Color = clBtnText
    DefCaptionFont.Height = 14
    DefCaptionFont.Name = 'Arial'
    DefCaptionFont.Style = [fsBold]
    DefInActiveCaptionFont.Charset = DEFAULT_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = 14
    DefInActiveCaptionFont.Name = 'Arial'
    DefInActiveCaptionFont.Style = [fsBold]
    DefMenuItemHeight = 20
    DefMenuItemFont.Charset = DEFAULT_CHARSET
    DefMenuItemFont.Color = clWindowText
    DefMenuItemFont.Height = 14
    DefMenuItemFont.Name = 'Arial'
    DefMenuItemFont.Style = []
    UseDefaultSysMenu = True
    MainMenuBar = SknMainMnuBar1
    SupportNCArea = True
    AlphaBlendSupport = True
    AlphaBlendValue = 0
    AlphaBlend = False
    MenusTransparent = False
    MenusTransparentValue = 20
    MainMenu = mnu_main
    SkinData = SknDat_main
    MenusSkinData = SknDat_main
    MinHeight = 0
    MinWidth = 0
    Sizeable = True
    DraggAble = False
    Magnetic = False
    MagneticSize = 10
    BorderIcons = [biSystemMenu, biMinimize, biMaximize, biRollUp, biMinimizeToTray]
    Left = 496
  end
  object SknDat_main: TspSkinData
    CompressedStoredSkin = StoredSkn_main
    Left = 432
  end
  object StoredSkn_main: TspCompressedStoredSkin
    FileName = 'skin.ini'
    Left = 384
    CompressedData = {
      78DAEC5D07401447179EE330261654EC51A320F672A2626FD8F00754EC4614DB
      99808906434C541413D1D810A3A2889C15B01010032A9668C4206241A423D29B
      88F4AA08F8BF99DDBBDBBB5B64EF1063E27D70EDCDCC9BD937DFCEBE793BBBCB
      4380F153B5ED11C1404D847AC2676B1E423FC0270F7D4AE4C976086937A65E6F
      10F5C278F3E60D2A4E8C4685C931A8103E732303D19BAA37E84D35BC2A2A5155
      F94B54595C825EE6E7A397C5C5A8EC79162ACDCA44E72D17A00BDF2C443E2BCD
      51717C0C2A4E4B462F9F67A2B267E9A834330D15E5E6206FCB79E8BCD57CC8B7
      00F27D89FEF8D61C5DFCCE0279592D40F93161A8B220175557BC42952FCB5176
      6606F25A391FF9AE5E883CE1F3FC2A73E46B6D812EDB2C45D77E14A29B1BAD50
      C0E66F5161CC63549A108D4A52E25171F253549EF31C15419D65F9B9E8BAEDD7
      E832E42B8C8B402F62C3516E723CFA7BDB77E8E62FDFA2E09D3FA010C775E8F1
      FE8DC8EFE7EFD095DF7E41FEFBECD1F95D9BD0EFBB7F46F9B18F515CD05FA824
      29161580FE94B007A820E9097AF1340A956567A2BCB424F42A2F1B95C2F7E7C9
      09E875513E7A5598878AB29FA16FC7F4414F8EFC82220FFF826EEFB3437EBBD6
      A3CB7B7F46FE2E7B50D6FD9B283FFA21CA8F0B4759110F50514214E88F4245C9
      4FD0B3E850B05532CA7812898A325350D4517BF4E8F0667447B4135DDAF70BBA
      F8DBCFC87BB72D3AEFB0095D3DB80D255F7647979CB6A12BC7F6A3D2C44894FB
      E4314A7C1888F2E223C1FEF1E865560A2AC94844153999A83C3B1D953C4F4709
      918F51F29368746FFF3A147D6A3BF2D8B4125DFECD0E74DBA1639BBF43D70F6F
      47BEFB7E46E7A00E5FE79DA8F04908CA8EB88B72A3EFA3EAB222F4BAB408BD2A
      2E40156525C08B4A545DF91A55429F2578FD862E1FDC82AEBBEE42179DB7A3BF
      3C9CD16DCFA3282F3208E546DC4177FFF04079B10FD1832BE751715224702B02
      85065C45D505983F29C87BCF7A7466CF2694177507E544FC8DE26E5F44F909E1
      A810F296663C45C5E94F5161EA13549491805E409F94E764A0D8C70F506A421C
      AA2C2F4189BE4EE81CF4A9CFC1ADE8057036272A08654606A357F9A0FF453A2A
      7E9E8A1E0507A2942B2E28FDCF63282F3A10E546FD8DB2215FDE93FBA8343D06
      15A544A282E44824DA6081B283CEA2738EEB51DE83F32807F2BE80BCB9B17751
      4658004A7AF8272A498B021B47A3A2D428E4E371145DF1398B7C9D36A0CCDB27
      D1F34077F43CF8777472FF56E8D7C7E8DCD1FD282B2E0415411D05A9D1A8A2F0
      397A535E00F6CC47CF823C20EF199473DF13E53FF6457E277F431BBE13A282C4
      1074F2F05EF4AA241FD92F1D894E6DFB1AE53C3A8F8AA2FC51564C20CA7E027D
      127F1F15403B8EECDF89FE3754176D5B3D0B793AD9A2FC083FB4DD761572B4FF
      111DD8B5199525DF46CF9EFC8DCAF39251494911AA827EAB7A53892AAAABE0F3
      0DAAAEAE463C291A5A195A12CC63C2B24EA074D8D9D96DDE2C2B12EBFDFAEBB1
      F3E66DA6807F6FB62399D9F1F6BABEFE9ABDF65A6047B0D2D070AEC41278BC94
      9AC5D06DC90FC7D64D357EF7980AA83553D3A64DA7D2307ECF68656CAC6FF23F
      B77DFBAC58EC62F8EBE2012DDBB469D3BA8DB2684D834B064946FC2E16C1FF31
      0C1625AD5BD7AA5D9AF1981C6A6A606B39DDC7D669191B9B9A9AEAAFF9C64ADE
      2E8613F81F39F44D1B9BB53960E5C0B44B43ABED1FBD5DDA5CFE695097A90756
      32ED62E536E4A3B7CBF736829F4C1BB75CC5B48BFDAF1FB75D34E135415BFBEC
      317DD335860CBBAC1C623EA1F384852E4EAB3F4A1CB8DFAF5F3F30C0F7365AFA
      3FED63D8C5926FDE79C222ED238B16697C7458B4689226A0730380F65A635337
      2BA95DEC160FE9FCEBA445AE9A1F9F5DB4B517011B2C16DDEF0776193260E9D4
      25860CBBF0CDB7392F5A7444F3E383AB8787878585A685D3AF6097099A6B8FF1
      A576393E6F40E77EAB2D348E58681EF9D8807724786938F9825DFA7D2F38776E
      A5D82E8183B72C1ED26FBEC5220D6DD78F8F3016F0EF71C4D5E920D8C5EFB0C5
      191B4BDA2EC7FB8CFC7AD29005FB35B15D3EBAF1C5C3030FAA8BB4095FEEDE74
      3D7BFA6BCA2EC7078F1C3976B1B5DFD623D8741A1F2B885D82B6599CB5D94CEC
      62653072E428BBC5D6BE5B3530A93E6EBB1C3AEC4ADB05B365D4A8798BAD0F6D
      D5C0C3B2DA2EC42EC7070F07BB8C9E3705DB45536D17B15DBE16CE1E45F862DE
      80F045536D17629779D7F66E9C356BB6DDF7DB1B60BE58A8ED42D9C512EC229C
      3DDBCEFD26E18B8686DA2E3276F91EDB450326486ABB30ED32EFFB60B55D58EC
      62E9BE5D6D17B55DD47651DB456D17B55DD47651DB456D978FDA2EDA9ADA9AAE
      F0BE88E0DF660C8B239AF5641777D723169ADF2D0AA062C8FF36BBF4B7F0A827
      BBF40FF84E73B2C6BF359E15A0A9CDD12EAE47FE8B83876B7F8BF73CBEFC3BA0
      E9BAA8AE76F94F5A669176401DEDF2D146786BB1CB77FDD57661B38B859A2FE4
      3C89825DD47C119F2791B18BB685DA2E6C76F96FFA2F751F5F3EDA89A3AC5D36
      2B8C2F8BD47661B38BB6DA2ED82E76F276F1501FA759EDA2A1E68BDA2E4A1CA7
      2DD4FE8B3ABEABB68BDA2E6ABBBC57BF4E6D1762972D6ABBA8EDA2C27EE4AAB6
      4B0DF1BA435B1769AAD7A9CAAFC754DB456D1725C617B08B1FD845536D1739BF
      CEF5B01FBEFE6891DA2EB276D19CB01D5F37A1B68B825D16A8EDA2187FD9C2C7
      76B170FDD8ED72F0F0F752FF659670B69DE684CEFB2D3C1669FC73678F2C0834
      35C9DB7B0D8F9153CF8B68BE689E91EE47609749133A6FD5F458B4E89F3FAB46
      CC42CC4361513D035FBC88FB42BC1FF1658ED38BAD3B6FD55EA4B148E39FBBBC
      9B36C8FB5FBC08352EB2B0A0F6A3ED1E67CF30E3DE9AD60BB61E396231F91FBF
      FADDE37D57882F2A07CB4C968CBB52BBCC9A6DB7F8FB053F9F00D8FF63F8A7EA
      3E41E1CB2F69BE9C39C3381E8DED67D1400DCC178BB36B19FECB9C898BD546C1
      76D96EC1381ECD9EB5E22B81DA2800DF9B16D4F8B299F25F56CC71E9DC8F60C2
      3F85C318DBB76FF703F802DE33517C7FF56DE07B48C62E30EEC29EB46042BFCE
      132674FEC7306142BF7E0B162C2086F17D8F68D0C0AF418353B84A05BBCCC698
      F3CB1A4D1B810D4000C0EFE40BFE186063430403E0DB0092817AC981CADEB2A5
      0D57502A5A0E183060B2B9357409E915B179B6FBF91E3C74C8D7F74F8C06870E
      1D0296FBFE79F24F459CF2A5738937F54FC8E64B0B4FF952454E9D6216C149A7
      FE3C744A42CC93642F62B30BEC4B63B76CDE6C29BEBBE966BBCDE406A55F838C
      FC6FDE3C4F728BD2AF2DC75A4A6E5F2AFEA2F46D50BFFE7ADEBCB196BF38BB2D
      B119B058DBDC9AA2CD84090B30B6FF8A79838DE17B50B2BDD806D2AD3B84ED46
      6FBFF853FC1D36F3BA9F2F532A06B0E3D7ED43270F3359BEFC1CDF7CFBA106D7
      4F9EC246817D49D12EB346CFA6315A82511823478DC4FF80E1F04FA12FC688BE
      7D307A0F1EDC7B706F825EBD7BF5EAD58942374047C0E7800EED6B4087761D3A
      B4D7EBD16BCCDC7D6E43D70ED01E42DB65C28225843187C8E6F9FA12AAE00E3D
      D5E0E45D5FDF53F27C516410C90C1909C7C04E27697BC1DB495FDF854BBE9F72
      B6E5F281539BEAEBAF5B7C134C0274F1F365B1CB8AD9B3857BBF8DF8F2CB2FBF
      DD3B9A328DAC6C2485E17DC12AC3C126803E7DFA8A0D43DBA517B14B2FB15DBA
      D5669716CD002D9A7D01063298EB34D4669205B18B3561CC767600E5A5BCB871
      F8FBC52D4D96DB4CB170B7BE192C1E97FCFC826F1EB6864D5FAE657C6C6D88F5
      8D1B34A5A842BF5E5C32F47FCBD67B79ADF15AE23DADADE94F936FF812BB1C64
      DB8F845FFD515A525C12E974DF4D480C23271313A62FCD97117D29BEC8D1050C
      D38B335FDA77C09C69DFBE593BBDF67A06735D160B1693A15FB22FB1E2949813
      A7960C5D42366FFD329375E4FEBDEB08E06320FC7BE26D5FBF615A4B93B41B52
      BBF8DEBB68B4D048E4F2283A3D3DFD51A868FDB4418DFFDAEE2BBF1FD989ED72
      A138D2C9EDBEC829FA84F3971B69BBC8CA085F085DFA8A09236317B159A47CE9
      46D9A545FBDAD00E9BAEBBC1FE852D279BF7EB47D9E5708D38045BD8C0EFD4AF
      464613F1E6E591CD33D1329E6AACD5548B60DDBAE59EEB45A18FC8A65FD93070
      58F0AFBFC2AE74E8EE9FA7D6AC8162A19125C5809292D2BC47A20D3306990437
      380503F4A106BEE0EFDAD849E30CB37F4E75B91893969673F39E4BB1D3977870
      91CA826919D98F28BEB0D985E20B451725ED4299A67BAF31136D169B8B7DA8C3
      3553067AFEDEBD35139DF3189BE78D870B2DFA0ECCCB9789D22569A157A69D89
      F1FBD3D70F28B666E29A892E79C5A529CE6EF7DC9C53224B4AF242D7CF303B03
      0769381C49ED429D879DF573EA44F7805BB77EB89596F6C2ADD8F95B308CA26C
      243DF09261B76F1FDA2EBDFB48F8D25B6E7CE16C970E648F6ADFACC718B79653
      865084A979573A0907DD7B13278AD28B8BA39DDDEEC3E6C1E6A7BB2C6B8D2D02
      96D1D21AB82CBA245592569A2EF236B9092ECA7528B666626849AAD3BDC337D3
      D2D26E66DF7386646C985B60173F6297338C38E69C5497B336677E7CBA63C7CB
      A86DC12EA56EC017B16C3E2D9B387A381977FBD2E34B1FF6FDA8978C5D3EE76A
      173D3D78D7EBD07E8C0B18467C54DA2E6B0FC9CF3F0F9E9A38D1A53435E53ED0
      196FDEFD03D0EF2ECBD669B50268190F5C969E9A72EF450EA4E5E03430CCB4B3
      70303EF5EB9A89139D8B23D7B8BBBB7B4445A545A5E5BCB89F0286D9D0D6F866
      03EC15F81DD63C43E68D63895D7ECE1BB6745D97F8468D1AC5FF1895762FFA00
      108696CD9C39532C1B498FBB7D65C6DDDE7D7A4BA060176E7CD1C32F604C3318
      64C0308BE9C3B5CC9CA49F14877D1BDC7703B3B8C4B8BABBE2AD83AD77292E49
      170D6BDDAA75EBD6ADD679A6A73AC7B806C0B663CBDC85B4E82B03ADE1987311
      58569C77710AFFE18307B76EB9BABB47A561C3E489BA367E7817EF4A12BBD891
      FB4B95889A9A4EDF012698397F477C5AB053A4DBA8D1440666D98A0D4364145F
      24C38B982F83FBC88EBB2A8D2F1DDAB7C33B52B3F61D6057D29038785263306D
      E47BD2CD253DD5E57F0F17FF959B7BCB1D6F7DB64B49C923A3E5D82C6D8E85A6
      BA7CBF78F1D9874F6E45E1B472480BDD60F26B835FD7AC9998976A34CC66EDB9
      73A76363CFDE0A80F49BF78B4B1EAD6F3B23B8819F1FB68B0DB1CB38323F2AF1
      9EDEE4296597F81D51392E2511A347631998257E077E8B82112642767C91F045
      B21FF566DF8F3A70D98FF07F3BBD6690B5C39835024DF184A906DC7771497DE4
      79CE349EC0D4C3030C7300BA7D4AEB36F037ACF8D130D3A7F1D0F2A7F13B9FC6
      FF9E560E6940985F17AE59E3921ADA72F9B14B7171C77E587B0E3ECF81D99CA1
      E4C041DF9F04C7476217BC1FCDDA58326887E3678D28BB1C0D48BB5F0C030C91
      C5EF38AFB3339E96D1C7A3BE52D35084E923B31FC95006BB301D9B77A81D7AF4
      7B8B1E2D7ADA1909B4C954B25F0D9639E4E61C99BA6CB9D6CE94034E80F8071E
      AE6939D0EDA1CBF05DEF5B85425A7CCA81032904ABE3715A69E834FEC28B6B26
      46970E6B6D6CFAA820254E7FE08F2F1F3FBBF8302AE75E24A40EB239E8C7B0CB
      96301FE04B69D7CF3ED921DE8F9E04888A617CC1324C95CF404EC9C02E7D29C2
      C852860CBE8435B46B27990E88F726AEF81C5E3D7AF4FACD5AF03DB831D635D1
      E5908B73C923637DFD786ACBE36D423061526077D08283D1BABC475A900474D9
      81D994124FA56D386764B4666269A8B1FEA02ED1F9F98F33CC5E3ECB9C69F417
      0C31387590FFAF7E40980960177C3F55CB709F8D1B3746AE77ACD0899F8F111F
      F797F58192BDA34747AEAF0419586AE6CCE997888CDA8D644C23B1CB60D99D09
      A327463765D003FEF0BBC13EED014386D6B817F53BE8EC5C7CC5D46C173079C7
      8EA7F15D969E0981438B7371BA17B68B56E9954166F1294F77EE3433335DF734
      65874714495BBEC668A2A88494DB51929FFFACFC5966E6A3A3B91E69379D4BD2
      D70F9A711026AADB27F06D969271F7EF6B7BF70AE78BF634ACD2814A76EC883F
      66B3B0D46AC5E8D95B458E58061CC2B28BA5F62B468A27498011F007EF803E7D
      46486D33983121E8D513DB86328F120092F534382098F47DE79A0DE3E4543C6D
      D76E5D5DC73D8E9FEDDEA5FFD3DAD85B513922D8769808EA4F2D9966B6F369CA
      CE3D8EE7774C1F04068AA2D2064E84A351C9B4C68D741D75CF97CCCC0438C79D
      3B1B702BC70D5207B53D88A75FD6FCB5C42E565960978D1BD3BB56BDE6E98259
      CE0F5AE7E99CFAD5ACD92B40D610CBE6C71359F19C59A36C478D1A3992691D0A
      23FA8EA000161A4C6030D8C040CC1E2981B802EC39C6A925DF5CECDFC9A39F9F
      9353C9A0DD9FE9ECA9A8767070DC3D5DFFD89958571801D3D79B825DF44B1AEB
      EAEC4889E735DCA3D30488137F36000698742F93896E229792B660CE3D0E7B9E
      0662B3C4EBFB9F8E758DC225DBCEF0C376315F4CD9657C44D2359FBD1B0FA4BF
      AAE2F15EEBE89C6F3C7062EA05981A08F77EA5205B613BDA76F4285B5B5B788D
      847F051B8D90830179C318CCE93598CA0B8C03376692B9353BC02E0760F4DBF3
      BA218F57CD03C398FEB4F4CCAD34B7E247EBB159F44BBBEAEC0173383474D803
      078D03F16743202D7AFD3091C8C5A574E06E9D3D0D1B3AAE2FC89C995F70A9F1
      4FE720550425DB0EBC89FDC6210328BBCCBD56F4F7559FBD570FA477ADACAC74
      70DC354394FAF3DE8D402139999000472456D0B085BFD1F85D8C91F84F6A2B26
      A394F8A38C6B35D76DED8021E6ECF0733E50BAA1D2810776A9AAAADEA3BBCBF8
      D89987D64EC5A1DE4D674C6D3A356F836305F0858653FC991077485BFF3F919B
      8B73E906C73DD53C5DAFCCCC99A9F9F905FEA66BCF861C76869233966F3F3CE1
      F084450396527C3950F63CE9DA559F30A774D186B6AFBA5E892E0E843D8B405E
      B6510ACA4AC21535008C44996B0EFC298F9173868F3C3E77CDD2C5354C90B6BB
      1DC8135534A4EF65EFA0B3CBF4D8DA9017E925A26103311E5DA9A88EA70EE1E4
      30BED606A76D58E2E6E6EC9C7EC5D181B7C70B464D517C3A368CFFE9C531D125
      A2693386E1B88FF9649BA53F90FB7BCF2D2A7B9E151E76ED5A9853745E696964
      F4D56B57C510CBB65EBDEA73D5C7C7672F7EEDF5D9AB808DD45F0D100A372AF1
      87FFB1C1571A2E6C23D8C68E2F5747E7E9F2780DAB6047E755EBEC34FD69EDD9
      35A979573CA70D1B366D9A28CFB1617C748A183BA9B40D4BEEDF77728A0E75AC
      E0E9C0717A8D6E95CEA3FC7CD1EFA73DEE95E479759DE1E93E04C05F7B8CB28B
      E12F656565CF8BB2EE24DD798E111191F47704BC45FC4D90F8F7DFE17F2724FC
      9D102E465858187E615C93C555FC6298557560F36F5C6935B9CDB6212C301F62
      EE7220DDAB1293A50AF365E720ADB531D1B0AB2C5BB601FE37447B55EA82B38B
      FD5D389474393734BAD8C56B89F9E105CE079CF2BC2B790ECB44CBC0ACD5E7BD
      44FEEB965A84A6867A773599AC6D31D962F294A5C7D6D991FB7BDB7FF51C0C23
      8F22F827AFA264783D4F2E4A96222B394B823BF45BD29D24F84F4C4A4A8AC0FF
      8911118960DB44559044CA25845D5B69356C322B342DEE1F989FD7B50A465DBC
      1F39EE34D5F70C4DCD13ADA1E1020323B58F55C03E663C2C3435FDCAFAA19327
      2F723B7000885659F57A0F1E9C8068F1FAAD054026AFAE5D874DD1D45CBC5873
      409B63C6945D7886E37D2803C840BAF177B2EE0099B292A4206D878F88BF6103
      FEFE3B013E815109E1F01F164698857F84858B79A51C407B56114696D55C13E3
      C52C98B2788A1B6C60D72A00AFA18E6E137D1397D4121711F827D45F2818A661
      4348ABD06D3208D24A455E4BF8506E89F3810330C254F3AA3E69C87370D069D4
      B8ED40A3BC6291F7B469C3160F002CB669BD4E6C171ECF6AEE81AB61E1B0C348
      7716856DBA26B7DF5CAD7997216391EAC0031B0C770949C9CF0DAD5A4EFD41A0
      081B01EC49D1795E1555957038D26D3CED516A89B30B038FD2D75754573B7CE2
      B8BBB109A489BCD64F21E5261E38B01A0C530544AB700083369EB13E0FF6BF0D
      1B8691D3653682B5AD7E97DA85C71B6F68B5D270A5D5CAB19BEDE66D9967B965
      ECE6795BECC6CEFB7ACBD7F3EC365B5A6EDE42CE21D12789E6D97D0D42BBAFE1
      DB63CBB19676F0638BDD3C9058CEB3836F765BC65A6E013D961C9FA3C7389F44
      DE575A191A1AD2D4B1325CF7FBBA36C796028EE1BF634BD7E2EF4B4D960E7539
      90929E77C51B8E975EA1C5C5914ECE3278C4484B174D341AB6F4075C72AD080C
      130D634C43870A47DDDDBB06BAA416875E59BFDEF387A514961BFFA8BF794A03
      E6730A3F28E07EC27BA4A1A1FEA59FDAB4D25AB76E9DD6B1D66D5A1F3BB61CFE
      8E1D5BB71C7625E87B385C969494463A3939C39F0C52E8B4746791C8C804CAAD
      C3C5CE42A903D1E9A160B4265DD787E615E78926AEF1DAB0FCD83AACF9D8D275
      C697F4376FD8B081F701C3D0D02A22E1B8A1E9207DEAE985ADA8A8F65463E356
      ADA61A4FBDBCD005B6D1E980AC390E507F12B9B3B3CBC4FF91E7204EFDE92763
      2D63BC2B1D708A06A395D046BB3271D940E39F40EB6563E375C6FAA6C61FBA5D
      086DDC0C0D079991690FC0585F8CDF7FC46FCB26BA004B9C5DDCD6182DF11CB6
      1CB6CA78AABEF1BAE5C33C9718AD11E13417D11A4F4919EADDC8195BC689EC78
      782C9AB84CBF15A9005B4FDFD474A0958383038FF7C15BC6CAB0C9AE4BA6A697
      F4E1CDD4541FFEEA02286FB2065B86368D68494B49CA257DFD4B834C9758C151
      96F7E1C3F0F8CAE9BB1A9B75E9623AC80C30C8ACB199CAA0347459B784229A68
      CD32FF3849621733D33853335337C367CF9EF1FE0D3034DCBDB309347CFAF4E9
      F8DDAC2ED845FE294D19D331F06F33A2B7F1F4417166EB7EE1FD3BF8821F1768
      3868F7CE578D3276ED6AB46B67C64E55B16BD7CE5DF883FC93DF18741AFC8385
      76357633FCF7D80546197DDDF33B779E279BB07B671DB17B37AD6407F9BE432C
      DFB1636786E76FBC7F915D80316B747574C036BAE7EB8A9DF0AFABABBB1BFECF
      9F0775F00116C768B47B67AB7D2BFF1D7669F809BC2A790DAD56AE5E725E47B7
      6E00CBEA121D600D19314ED005990936CBBF832F30FBAB6A88E32C303D9868A2
      FBE9A77B1C75EA084747F226AF67F7CE89D47396B7FC8078FF2658C1ECC0D9CD
      68D99E5AF1A903BC3E852F153A9F3AE838EC7170DCA3033FF63860095B019D19
      D344BF58D18F2C4766FF2EBBF0AA1B3A18AE3434AC6DFE69B7D96EF3BCB15B1E
      E32F5BC6DA6DB1B38469EFD77676309FB5B4DB328E7AC4BB74BDE43C9C61D3ED
      CC6A7135E32721347EAA63734430065E3DE1D59A87D00F78AA8D78446E06E981
      5AD44B0349F1E6CD1BF4A600BD1DCD5EA237C9B5E4E1419E5BB5E441EBD09B9F
      6BCB330CBDA92D0B6A87AADF499E4FDF511EF4CEF25472C8F392439E020E7992
      39E4B9C521CFCF480D35D450430D35D450430D35D47897F8F91DE5E1E2CF7399
      177099837099EFBC5104973C051CF25473C8A3301D65CB93CC21CF4BB939235B
      9E4A0E79AAE5E6B06C79DE70C9F3B3DC9CBAD60D5BC79EE7A5DC1CBFB6CA9ABD
      443CDE2778D1D9D4CB96946888261593580CAF263C1C93F894E2AB501A93A0C3
      149298446575357A5356808A5222514E64207AFA87137A53598D2ACBCBD1CB92
      12F4BAA202559414A3B267E9A8EC79262A7F91854AF1677E2E2ACD7D818AB2E1
      77F633F4DDC83EE8DE8E1F50C89E75283B2E0A95662443FE0C7467870D7ABC6F
      234ABBE183E28303507248102A4E8D4785C971E8594C184A890A4365D999E845
      723C2ACFC9422550E655412ECACB48455515AFD0ABB25214E1FC338A166D45FE
      2E7B5056F07514FAE7451415740B3D0DBD8FF25213A07C062ACA4C412FF3B251
      E1B334949B9589623DF6A080D347D0EDB32214E8791C055FF040F7FDCEA1D8C0
      EBE859C47D1479FB1A2A488C4629E10F505CC85D9493188B0AD3135169562A4A
      7F1289E22342C12E45A8BAB41065243E45AF8AF251A2D77E1424DA81D22E1D45
      7FB93BA323DB6CD11DEF93E879E86D14FDD745F4E8AA0FAA7E598A0AF3F3507E
      7C18CA8E094179099128E8FA255405BA7222EFA0EC883B2837E61E2A4A8D45C5
      E94F517166227A9D97891E045C073BA6A1A2DC6C541CFF10253FB8817C8E3BA1
      B4C77FA3BCB8105496F914DDBE7C1E5595E4A1A2D04BE8E4BE6DA0231A6C968E
      326F8AD0F33B675061C243B06B382A498F81B428F42A270585DE0B446F2ACAD0
      892D96E8DC6FEBD159170774F3FC715494F8101540F9EBBE9EE8B2B7077A535E
      80F2C3FC5061C425F42C0AEA8CBF8F0A931E818D42D0E57322E4ED7114555755
      A2AACAD768B3C570B468526FB4C2A43FDA636588164D1988661AF647E1574428
      E1B607F23DE18022037D81538FD0F3D82074E698133A71782F9A314A0F4D1EDC
      1959CF1A88EC978D446BE719A095D307A0B9E37AA08DDF2D467BB7D8A0FBD7CE
      A098BB1751E02577949FFC0839EDDE8C529E84A06D9B562117A75D2832FC11DA
      BDC31655BC2A46916137D1C307FE08EFCDFB9C36A2F8845814107C16FDF2EB5A
      74EDAFF3E8D2CD93E837A7EDE8D8993DE8FEE3DBA8B82C1F9DBDE482EE275E46
      B7227DD00F9BBF410F32AEA1BB69FE28332B03DDCBBA8ED28B135150D635F477
      D615B4F3D41614987003DDCEBE864E079D407FDDBB81EEE4FC857C1F79A39BD9
      57D1AD9C3FD1FA433F21FF0C686FDA6DE41CE88C2C7EB04059A559E866FE5FE8
      56D11D74A9E04FE4E8B71FDDCA0C445ECF2EA2A0D2C7E86AE95D742DEB0E7A54
      168B8EC75C407FA4DD422FAB2BD0A5ECBBE8EA8BFB68D339479458918D6EC73C
      40F955A5E8626E08CAAA2C4425552FD1AE5B6EC8EBC53D14599E8E4212A3D071
      D07B3D3F1A5D89BE8B2AAA2B617FAE42A7F31FA1F38511E88FF41074A73C055D
      2A894355B09F57C3ABAAAA0A7DD5EA727D8778DF83FE0E1D3AB4E9D006035F4F
      D2FA73F8FFBC36591B5AC6493F5EE7DF77EAF48EB366F5EF38AC0F51282BEBA0
      209B4EE7E3AABFEFB44D333CBC3CAC375B76EC8BDB4BC99CE5657DFB4EB3F6F1
      0AF0F7DEDD899271D5BFC9CB7AF361CBC39BED3CCFF6C7CDC5BA365DBCFEF0D6
      AD5B972F5FFE432CEB332320FC69E8ADD09BDE17B7101937FD7D37BAAF3AF2E5
      CFBB76ECD87EDA6373FF0E1D5AB7E9D36763F8C38488E0E0DB7FFD852BA0645E
      D1790969C9C991F7EF5FF5DF8D659CF483FA31F317686AAED75CBBF6C861AFB3
      1D3BB4065978545C5CD8A3A03B776EFF75EBF21F44E6119D57949F9119141F1F
      79FF72C01690F971D1FFB9BB7997CE4B976FF5FBDF7A97AF179FF61CD3E17390
      4525C4C506F16DF94150C1E5CB44169D575EFE92C8A082AB1741C6A9FD1BBD07
      2EEBDE83EFE7E7C75FBE73C776BBCDD35B77D8189E90F40454D952155CC5B219
      E145E5AF63281954700D649CF47B089B1AACE6E38B35FB192F3FB778B375C7CF
      3B783C7D921843C9A082BF2F1359DEEB0A892CFEFE4D9071D36F62FAD9563F52
      CECFF8C71D873D3AB6EEE0119A92C5B725325BFEA3E050227B5551F03FB12C3E
      1ECB38E9F769BEB0D1A774BB966B9EB3F4025D3EA1053917C46D7D147C8BC82A
      B2A4B2CCE4502F8EFA3D87F66AB89A6E3FFF971F0F7B4DFFBC83E795A05C69FB
      1F8712594A8E549699F110649CF45B4F71ACB6352697E8F819FCF4CD6E8FA9AD
      3B583B04A6DBF2898C1F141BF190C89E6797D2B2FFC5BC487B0A322EFAFB389B
      F7E255DA62FEFC6FF5E4A5633D377568DDC7D97A436F9E2DE14A4C626CC23D22
      BB92AD41C98C638A5F14856FE2B67FF519260AAC2AF39BFB3F3FBF85F306E9AD
      729FD6A74D9F6133769B34C2CAF8375292E2A22E12D9B5400D1E9619F7AE785D
      9E170D320EFAFDFA0E3313DD6808ADEFD56B6EF3C103DC37E14BCB86F59BB1CA
      A47775C3B9B9392949A9E194CCF95A4C258FE7D72837ABE2656AF40C107169FF
      B0A9D3CD44810D1B96356C74435BE8BE91A89AFAC9A619F6FA436F64E714C43F
      0CB83895C8A63B7B07965697A6676715E7457B611997F161EAD4A936235C432E
      CDEBDD7383ABD7A6E9F07B1896F59B616D6FFE67C8D57B20EB4B64D36DCCBCAF
      14066615A63E0BB8381D320EE3A21FAF06B239B4D9D5DBC7D3DAF9A0CD27D33F
      F9E4939A64D30FED165DF3F7BF687D10BE838C8B7D7EA803B8E8FF9506B95682
      BC7FB78DABEC43F01F940466A8CAFE499BB7F82252591B89CFA2AC7F329DC53F
      5194F597F831DCFD133BEC8BD8D5E29F80CCDA93F82763EAEC9FF4D974AF66FF
      E4BA12FE491BEC9F9C26FEC962B17FD2A103F64F2264FC930EC43F494B4B8E7F
      37FE496A829C7FD247D13FE129E39FF463FA2701E09F8003014797DB32FE493E
      9189FD133F25FC1338EEC9FA2749414446FC93DDC43F29C7FE099129E19FB4F1
      106A11FFA45FAB56E09F1C91F14FFA910A64FD132253D63F69D56AB5319465F8
      2705F0937F03BF3D0ABE2CF14FC432A5FD13E3B9BD166E65F827D817E1CFCDBE
      C197F34F6899B2FE49AB565B6DE14DC63F819FB6F0B695E99FD032E5FD1362D7
      D5063FCDA7FD1393525BCAD65B19FE49192DE3C7642AE39F3862FF047801FE49
      67F04FFAB4EED0CFFA3CF64F40B695F24FB08CF24F307F28FFA40F67FF8487FD
      937E7CF04F26CAFA27FDC03F4994FA27A53C2293F8275CF84FFC131EE59FF490
      F8279B887FE2672BEB9FCCABACE4F9F552CA3FF1A3FD93CAEAEA46A652FF643A
      E59FDC00FF242AC043EC9F5C0B74D428CDCD91F827BCFAF04F72EAD73FB9E8EF
      EF6347FB277EFF79FF44A39EFD93BADE0EB9F6F67F220F1E671917FD9F282C6C
      FE44E39307F2F884359FCAFAC55FC5EA77D6937E3919F38ECB9CF52BDCABF913
      CEB27FA37E32BF565EBFB49854179B4CADBF16FD24FEA0BC7E6931A92E36D9BF
      9E9F6AFD35E86719B355D1DF96453F25534D7F7D1FBFD4C7DF7FD1F1D7804FA0
      ECF197514CC27F369926FFE8717C071265F72F9962B42E369926FFD8513780D2
      FA99C5C4FA5964EAF14DAD5FAD5F7DFC551F7FD5C7DFFA9DFFAE5372FEFB2355
      EA2726FF5964BBDD9D7BC0A179FDA68DE395D9BFA862DF53C5685D6C324DBB63
      4737AD5EFEEDC613FBF495D16F77CC0D8AADDFB81717A375B1C934177A1CFB6D
      E3CA8DFB8F6F5EAE8C7E71B193B818AD8B4DA6A939D763DFDEFDFBF79FFE7199
      52E38FB898E632A92E3699E68F7337ED3FB177E66ACDC9CA8D6F8C62D2B6B2C8
      7AE9ECDFBBEF37F7F59A2B94D26FFBBBB4985817AB6CFC8993BFB91F3BEAFEAD
      8132FAA5C5A4B66693694E38F0DB3EE15C6091BB52F617173BE62E6D2B9B0C48
      E534C156D376F7B16342E5F8C92826E1A7A24CD34868648B7B6682708832FA65
      8AD1BAD864EAE3AFFAF8FB711C7FE5D4BFA7E3EFCE7A8F3FBB1DDF0793CA7DE4
      D8AC847E6631B12E3699A61B9974BB69AE51523FA398443F8B0C848D4D7BF0F7
      293B3E308B49F52BCAE84A4FEC3DA94AFBA962B2ED9795691E3D7EE2C489BD7B
      49B54AE8671613EB6293691E3BBA6FEFC953A7F8A794D3CF2C26D6C526936E96
      B2E3B3B49854179B4C930AABEC5556BFB49854179B4C930AABB829AB5F5A4CAA
      8B4DA69EFFBEDBE32F8FF3F15745FDF57CFCE2F1BAD318AC67A4ABAF3F45D764
      C8C0F9D46305C529DD9B746FBF42AB5BB716CD97C9A5D0658C4C864EA25314F5
      E3C775356B32586F8AD0DE41247275D82234EAB9843CE093A44C9EDCC4F7F2D5
      9B57AFFAFE6164D0BCF952698AA48C885146517FD7AE4D9BB61F6C2414F97801
      3C3C3CBDED37E84DFA06F29294EF8537AFDF0CA5177A4D34359D2C498132DEFE
      0101015EFE3E3E92322CFA9B366D3AC4C8D5C3DDF9EC19CB33679DBD3C3C5DCD
      4D26416B20A5597BFB7B51A1118F83EFDEC6EBB02EFF0E155029B88C7FC0BD9B
      64391954419751D4DFBE7DFBC946D65E562BBFFC66D7AE1D3B8E58EEF6F01009
      4DBA346800292B768747253C063CB87B972C14870A969294C946D7A29FA5A6A5
      C5C74746DEBF75D3CB4764AED7854D7F93264D268ADC477FF92300DFFA0C2FA2
      F771DDD0737E0348D902EAE3E2626363C3C21E04930A4C4C9B9314BD6B643559
      46467232AEE1AA3F55864DFF647B77F3054B00EB3471153B8E9CF6F0B4379AD4
      A0C9E4C9179F25C40551916E7ED083BB50C11FA63D0683FE2137B1FAFC171974
      0DF7AF7AF9E0326CFAF5BC1C264EA2E3E5FCEFA182EDBB3DBC37F4FC069A1F90
      9A94C4A78FF4FC30A8E0D655A31ECDBF6932592FE059517996B8665CC14D7F5C
      864DFF1677A3C1EDF9F43D5FF9780B2CBD3CB798183669E27D3D2331712B1C07
      566FE5BBF163C3EEDE810D68DE1C52ECA38BCA5F1A8B6BCE840A6E79F94019B6
      FEF5B66FD6CD80EF4C9AE2CC5FF3E3CE5D479C7D1C8C26B56FEFF33031A50034
      6765A5F0F7110BFD7DF972F31693DAB7BCF6ECF5EB0A4831C63E06FF454672FC
      FDEBFE5046517FD3A63E1B9AF73005CDD85F805A96FFB873C7590FD729839B36
      F50A2DC8CAE14B8EF460A1E05B575BB418DC54DB3FB5A282D45C50406A863EB8
      E9056514F56B6979989836FE54DC7EB090E68FBB0E7B89CEF7D4D2F20AC9CAC9
      E64B8EF460A1E05B37BB690FD16A19502C5B3358283440A4DF5351BF81817FF3
      DEBD7AF19D5D319CA19E253FEEB2F482BC06061E5762724BF992233DE87F1C7A
      B3657748F12F90AD39333919F49F67D1DFAD85E7D05E8E5592FE05FD9AD07E87
      F37ADDBA79DA07A6F36CF9E276F26363231EDED41EAAD7AD857F418E4CCD40D4
      D00087297A8AFA5BB6145DEAB5076B71A57B78E9BAF99BBDEC75DBB66C696577
      A911E4A2CFC5ECE53F098B88BAA2DDB36D4BED6B85D93235BFC84F7B1A603FA5
      ADA2FE21431C84D5F896657C57DA42CB967C69E7616EA4336488F90CF3799044
      9F8B71E33F894BBDE73BD404521C4272CB9835BF7891762F4068A4A3A85F4F4F
      78ED53867E57D0FF85BBF706DD2FF5F4F4ECACA67C5685DB49ED4749094FAFF7
      D433FA1297C9C6C71649CD2FF253A3AF411945FD4646460EE7F1DDADC45A7A2C
      D371F55A354577BE91918EF90C7BA3CF70E5BCF49C2C7C2540F81513231D4831
      723D5F2A2EF3BF850BB3CA8B9E05E0328AFA274C98B04A1448FFDED3AB71F396
      1357B98B364CD131C48FEFD83DC37ECA3C471ECF313BA72025292ADCC148974A
      59E52D2E939B9345D6F379E3328AFAC701EC4581A491558E9F366EA167EEEE29
      D4D7E9D205A78CB39A6125349977233B272B117AF0FA9429E2147BEF4072F42D
      CDCD29A800F5FEA48CA2FE39180EA2F38E951AD5A0BE879EBDBB8F70826E97CE
      9D49CA9CDDD633ACB60837FC79E5A68F8F03345C920265D22BC972BE82574F41
      3D4951D44F1E543A6AB7C87B83C9BCCF869EB7F7F2B2331F30BE4BBB76ED46D1
      B0B29EE101F074158C1BC74C8132219762720A4AF20202BCE9328AFAC58FD4B0
      12797BFAF8F878DAAD128C1B3F09DFA95EFAB88D993341DDE8D173E453AC44D7
      7CFCFDFD7D4492328AFA47309E6A029A404FA7B65D09544961191FB49A0D1E38
      51677CA77173468D18397ADC1713258F145221E5FD5F5F207E08F4E22F177499
      3478F0D22586F3BFF966F1E2458B1AD49E62A19052937E8B2F7574C6EB4F98A0
      AF6B34B07BCB962DC13FEB2E4E696BD8A5F3B2C193BB376BA9259FA250865DBF
      C5CAF15F0C5865EF8A7D3D7BA1EEC0EE5AA0A9199DA223B84AF987BFAFE88A9F
      BB294DC165AC28FF505C8655FFAC2F20A7B587D83F741860849BD395A48C3F7B
      FDFA43B17F68D4122BA153BE18B38AF60FFD7DBC1D84541936FDB33A751A6707
      BB95D83F0457CC085A035A665976B292F50FC916E0944E03C6890224FEA197B8
      0C9B7ECB71733CDDC13FDC21F10FBDCD759AB46F0F2963AE53FEE103B17F387E
      057EB41C2E23F021FE6132E51FFAD36558F45B0A049E72FE2138A07A4D9A408A
      5580D43FA42AD001DF10A7807A19FFD0CB9F9461D13F5B60A7E01FFA388C9FDC
      A4C1EC395E52FF30E801F10F7D89FED9026F79FFD0DF039751D46F397AB4BBD4
      3F5CFE23E51F5A9BEB35B11C6D07FE617B897FF8E34EEC1FFE0EFAA14C34F887
      E29A9369FF10CA28EA9F3DCADABDAD827FE863AFD364F6288FA7C98906F431DC
      0D3C3BEC1FE20D983DCA1BFCC3668C9A897F086558C6FF511E2CFEA187836EFB
      39A3BC1EA6A498F2E948106C1CF10FA17FE78CF207FFB039A366CA3FD465E9DF
      5133BDD8FC43917E534801FFF05379FFB07D53480900FF905933F10FA10CDBF8
      EFA527EF1FEE00FF505F6BE408EC1FF692F70F6107183912FB87CC9A3328FF50
      8B6DFCF769C1E61F4E31183102FB8755B2FE21F89F069082FD434705FF708A01
      4BFB87FB28F8873BC13FD4ED3672B8877D8C8C97F6E431F88730CA8F1C8EFDC3
      2A05FF505771FCF71B6DE679A991A27FB8C5A4FB68B319F2FE612CF887308A8D
      36F391F70F5F60FFD0A4A5A2FED966DEC23D2CFEA1DE90D966763384F3985E5A
      2CF60F870C81146F79FF303FED9E3F9461D9BFCCACBC3FF593F50F3BB97B4FD0
      D3B334339B6135A5A1C4B3DBDA03FB87E035428ADDB5EC4A66CD2FB17F086514
      F5CF1F6D2692F30FDB5A79ADD2D73182947E3376CBFB87463A24C5FB7C3AC33F
      ECF112FB87504651BF6127D80079FFD05A38417F02A48085B07F5845FCC3C48C
      A870D72FF4F5498A95AC7F5894177D0D9751D4DF65C96C9C59EC1F9A361F68EE
      EEB30A7B8038052A10FB87298F9F06780F1830864E71A5FCC34AE21FBE04FF90
      9451D4DFB973DB3966AED83FACDA03FE61733D07778F99C401242966FD24FE21
      4CD105028124C5154C54594AF987CFA2FD3793328AFAC1A983CCE0BD6DB834AF
      37F10FAD6752CFB7A752CC86DBD1FEA11D79C4BB34C58AE11F5EA3CB28EAC75E
      DDC471C3CDC4FEA1F508FC084DECFD8953B0A3867D440ACC14B17FE82D29C316
      FFC1188F1B2AF7EC3B555258FC431A6D3B81AF3762D49C719DC6EB4C1C38B899
      56375552FE09FF70D1E2C58BBF99BFC0B0F3E0EEDD074F32FC46E2FEC9A44CE6
      94526BFCD0C864A842FC7048FBF62BBAB56C61C0163F9C42CA48628EDCE2875D
      1851C2262B7C4FD3FE61F31E0AF1C32D92F86197DAE287947FE883E38726D2F8
      E10A5F07A97F68F296F8A1C95BE28793751D3CA4FEA1A7AB501C3F6CBFE26DF1
      C300CEF143913B337E8863814B98F1C3B00735C60F9325F143A1C9921AE2877A
      F2F1430FB6F8215581490F123F6CA644FCB01D5BFC5077126899ECF3541A3F04
      474D1A3F1CECA05CFCD040A284BF5E123F9CCC8C1F623F4D367E58202D13F4F6
      F861DBC11225A085113F04FF30118EE15BB76E5D8D8FE577EFD2F1436D1C3F64
      96A92D7E483B02C4DBA3FC431C3FF410C70F835252703D92F861771C3F04C142
      6363AA4C6DF143ECEA81AFD76D057CA1FC4366FC108E5E0529F0099D7CEB6AB7
      169082E387FFC381CB82828A62A23FF2A6BF883D7EE80FFE2164E9D5EBD3C6A6
      D85BA6FCC3F343C4F143377E697A764C0189B0827FD802C70FFDC13F241543CD
      380E9A9981FDC3F32CFE8981964FF3DEBD208B5FD59E5EBDB1CF2A1F3F74E383
      FB909D45F99FA1375B6AF7346811406D5859696E7616AE99F20FD9E293DDBAE1
      F8215182DD07D042F98792F8A1A46B4EE0F81E153FECE603FE215586AA99F20F
      CFD7183F94F6EF09FED235387E38A56DCB66247E28F6D1C4FEE1D09E6D5BB6C4
      F1436619CA3FAC217E1802EEAD44C95EF9F8A1D84793C40FF57486F4C4F14366
      19CA3FAC217EE8DDC84FAAC44D2E7ED85BECD7F1B7CAC60F2B99656A8B1FDA4A
      F7453A7E48A284AB66D81BF5668F1F16361297315E684CC70F756A8C1F3694FA
      87CDBA28C40FAB48142F3116FC4346FC903EB996AE54FCD0B445CF55ECF1C394
      E4A73043993245367E28F50F6B8B1F56D1FE216BFCF04FE21FCAC70F4B2B351A
      61FFF0E5332EF143E21F6EF1F21209D8E387566CF1C32CE5E387736A8E1F0A15
      E3873ED83F1C6D5E5BFC70B83816385A3E4AA854CA7F377E68A142FC70B112F1
      C3B635C50FC7B69DD8A5F3B24920918F1F8E55327E68C5163F1CABE3BB19FC43
      F0DE7E1F24173F1CAF588653FC50C8881F7E21133F1CC48C1F0E58E5C9357E28
      908F1F0E51881FFE4DFCC341E2F8A1652766FCD0DFE3ADF14381A78C7FE8E16D
      DE56267E182639BF3CBE690DF1431FEF5546CAC70F9D15E287BF8BE387FEC481
      93C60F7DDE1A3F9CCF1A3F14BC3D7E582EEB1F3A4C51257E98B4953A0C82F3F0
      40367EF8326821557306153FF414B0C70F45247E486B59231F3F4CDC4A1D06E1
      E01E261B3F7C292E93499F5F668B1FFA89E387B496A5B2F143F00F6F9063EFD6
      A0274F6265E38715C6749917E2F3CB6F891F1AD307DF76B8023A7E3812FB8731
      39D9D9C43F4C840D90891F16E4C0B197FF3F7C370EBC016F8F1FF6EA45F9872B
      962DA1CE2FEB6B410AF60FD34BCB887F9892F888F88783C4F1C31CBAE68A6252
      41CDF1437C7E794F15E51F769BBC54367E584A1DC4B363C8063C0EBD69606030
      623839BF8C6BC6FE614571666606F887AE6F891F8ADD871E839631E38781E954
      463F388AA724C68631E387E29A710535C60F79A3CC3CF1F965DA3FF9146FC09A
      6F70FCB0D928B319AE247E484E336667A53CC1FEE1966E2D5B8EA2E287E2F815
      D10FFEE11696F8216FB699B5906E3E3828BD1AE31E90C60FC9F9658C32D09FA8
      103F243583FF538CCF2FD71C3F6C24BE51871FF85783887F28891F52EE1BCF11
      EB97891F6A48B7ACE2F58BDAE38754FB7B37EF4AFC437D700371FC90F60FFDC4
      FEE12AF00D7548FCB094A99FF887FA466CF1434BF9F8A19E387E68298E1F3604
      25D0BFA0DE559FC40F9965C4FE614DF1C32E60675160A5E4FCB2347ED845367E
      9886E38763C6D0297654CCB10AFB87AF6B8B1FDA49CE2F37EFE9E0EE318A193F
      9CF196F8A106757EB918FCC351B5C60F4DE6F5EEA954FCD0FBBDC50F87ABE387
      AAFA876AFD6FD52F3D97BEF89B055D060F1E3C69C9FCC50D14A04A2A53BFC5D8
      2F27761938787033E080C18A25723A6452DBB3A7B65328CBD06F3156A76D5B1D
      5DE26C9BF46CD17C90A1AC021DF0D1272D6B37B989968141739654ECA8EBCB97
      95E89FB5F28BB13AE06CEFA69D6DFD9E2D7A2C953483A4B6D5F13D7BF52AF1D2
      BBF7E8219F0AAEF46E5791B75C59B17E8B2FBE183F7E9CBDD841F7C0CEB6768F
      65B40A8B955F8CFFB22DC34BF7FDBD470F53662A94BDE6EF2575D4C565C5FA2D
      3B7DD1C9DCDACBD3F93438E8A7775B7BF8786F9932B4C7524A03A48E1D77FD1E
      B9DB1F8EE2E2FBFD0D2151563AB593E05A80FF3DA83DF4EAF58BFEB8AC76F3A5
      0CFD2B3B75EAB4D9C37DF3CAC59483BEF2AC9787A7FD146D53624748FD4270F1
      5E6A847415E82D528138B5937D40F4D334BC1014DF58F0A697BFA42CA5DF02B2
      CCF4B2B69C2F71D08F583A7B786E316AD1F59B45247525A88FA3BD74A8E2F66D
      A8C0D4549C6A1F109E2A0EE4420DB7AEFB7B6EB944CA52FAA109E3BCACC71B2E
      59B2668D2671D077ED800ABC853D7B2C5984532DBDC35389F6278C0AA00FA854
      6140384C03A48E7A2454409725FA177DD1A993B7BB7EE7CE4B31968073482AF0
      F27098D2A2E5629C3ADBFF695C524A103F28F1C993C4A0D5410F8817DDA20795
      7A2D3AB5BCFC0505A8219E38D25459A27FEC179DE6B8AF9AD46EB2C1728315ED
      962D9BBC7CF5B7E0409F850D18DA7C3EA47672F54F484A8A713F7A36263125A8
      DFDEDD41C1641AD09CA49A939B3617C4041583139A18139342AD242065C5FAED
      3CF59AB5EC812F08EDB6825C5BFAD3CE1D2BAD3DB79834EF8CF57B3ECD4C4C89
      F13CE6763626C679EFA9D32961D84DFFA307A44EE8E41D5EFEF26501948DA928
      2EC065139323EF5FF4216529FD9DC6786E69696060CAB8B6F4DB1F771DB1F270
      306A3E786CA74E63C82420EB86C7B1DF4E4FDBBF7773109E67C034A00749F57F
      FABAA2220B97BD1184CB4E48A423C5904AF47FD1698CCF06D8611A33AE2D5D43
      AF306DA10DA963A84940EE8519C74FECDF7F3A463C0D68DE1CA70614C13C8054
      4E950D7A919C1C89579A4259A2BFD3B87194FFFFA9F882D0E5640670063CF416
      2D2075369904E4963AF2F79F38BEE9460AF672F134C080A4C23C007BEA17E8B2
      41E299002E4BF48F993DC7A739A8DF53B587BE20B4EB643C85C1338016DA902A
      F0B812949D5EB6672ED8FEA8DBD91BE26940739C2AC071625C395536063BBA19
      642501A412FDB3E7CCF1190AEAFDFCC4D796F6C0531868BF83EE574320758E87
      7D506EA99FEDA693FB767B1CC32C02FD11A1375B9054FF0A9866544ACA661563
      4F1DCF042095D23F7A34F8FFE0A033AE2D5DB654F39BB35EF6265F4D82D4D1D6
      AE9772FDE67A1E3DBADBD6162A58051D8CC3C4DA24D5A730071C7569D902AC3F
      2A8094A5EC336AA648D8688FDF1EC6B5A53045C233809E430742EA28AB191B6E
      54CE753FB6DB96B7072AB08389645CC23DDF79DA38D53B243B5DA62C3D13C065
      897ECB9123ADECF1FA587241A81FB920B4DBD2252B3DBCCF0F1D3AD112FB6433
      1C4C1A39CEE5DBE259C085AD31294F9212A2AEEB699354D79B781D04A36CCA8B
      FCA2806BA42CD1FFE5A8E1C3BD2F81F9F105A1E0E7E30B42DB2F5BB0DB6B95C9
      D09E86903A62A4DD8C55431D79E2695E4162525C6AF8156D2A75B87761BAB86C
      656F284B66025B4859A2DF70CCF0E13081A9E4F9EDF123138C4F4D0D264F8209
      CCF9C0403D439C3A62A6B5B590AAA02C9D9AC5DCBB3E74289DEA7A2DBB9A2E0B
      7384AC8A97E5A9D13E5459A2BFCB97A3CC868B841A95D4FC08CF20BB0D1EEFE9
      25BC64A2D7A533491D31DCDADADCE4B332F0C5C92AD6D4F06B7F9848524521E9
      D4ECA7924C345E1685076CA0CA12FD9D3B77323333832EE6F9F1F00C186600DA
      BADE5E5BA61899E875EE4C52710533766F1047A11F865F141A4953CD4421B91A
      1A95951AB8F28AD7A0DE9E2E4BF4832B3F0E32B97A5F72ACAC72C4EA8798BB7B
      D94F9832C5A41DC1385CC14CBB19E228F4451F98233153CD44DE97D24BD373C9
      543E2F3A405296E8074F1E4F83865B89EC375CC20B5857797B790B064C986034
      7832014905FF5FBA8A754027B954576F7B3A101D1E704D28294BF463477ED218
      ECC88B2718A2B3388E6D34A42B0D2A75040903C3EE2C604B75F5A6271A5B18A9
      443FE5C87F319AD68195AC9A2318D0B61B032AA612FD061406761A4DE622245A
      3D4E77B0810C544B25FA7B88D15D67CC9C5123478E164C68DBAC870254497D1F
      FEF9F8A9933B524F210AA29FA43C1F3F3D19319E5AD40121EDC6D44B0F512FF1
      538B5EE664A197B9CF5145513E2A4E8E45A599C9A83C3B0395BFC844AFF25F90
      27015DFA6D332A4A884425A971A824ED292ACD484425E909A8EC19E47D9E86CA
      B2525145612E7A5590830AE3C351515234CA8F7D800AE21EA1FC2721A8E0E963
      941B15449EDA931B7517E5C5DC43B9D1C1E429496FDE94917634AE2FE8D60B40
      6F53AD662DB43FE57FD60ADF27B075238D862D3F69DEB441DB266D3AB4FFBC5D
      E72E5F74ECA4FC93D6D57AD57AD57AD57AD57AD57AD57AD57AD57AD57AD57AD5
      7AD57AD57AD57AD57AD57AD57AD57AD57AD57AD57AD57AD57AD57A3F5CBDF574
      DEA99E307E6A5967EAAC60771E75167122BC7E609C457CFC85F42CE22844BDC4
      6711E3FF388B6ED92C41F9318F51C193085492128FF263C3E07B382A7C1A890A
      E2225051622C2A4A7A824AD2F0D9C324549A918C0AE3A3506142342A4E798A8A
      92E350716A3C2ACD4C41655969A8F4596A8D6727CB9EA7CB9CA1E47A76F28C83
      5DCD672823036B3C4B991C1F4BB673C4BB401D4FF8523AFAD605621D9FA80EB5
      0EB50EB50EB58E0F42C73B180BDFC598FCC18CEB8354875A875A875A875AC707
      A1E30319D735EB8277A8A3615DF00E757C5A17D03A1AD405B48E467501ADE3B3
      BA80D6D1BC2EA075B4A80B681D750A00D03A9AD405B48E967501AD43BB2EA075
      B4AA0B681D4DEB025A87565D40EB685617D03A5AD705B48EB67501ADA34D5D40
      EBF8A22EE08DF8AFA1AB5EB71E3D3BB7EFD2FBF3CF3FEFDD47A75DA75E1DBB77
      EDD05FB7DFC001FA82A1C3860C36185E1BDE8D0E7E5D31FCC3D916B50EB50EB5
      0EB50EB58E77728CE2D71D23F8757D9AA6865A875A875A875AC73FACE31D8C85
      EF00E3A7AED4A4CEE29FA2AF1DEE0DAF368CB3FEC17CE959FF0E887A89CFFA57
      BF7E8D42FD2EA0F2BC5C54515C845E9795A2D2E799E8657E2E2A875769F63354
      F22C0D95E53C47C519C9A82C371BBD2A2E44C589D1204F85FC25A828F5292A4A
      8B87F42454817FA73D456FAAAB5035BC701DDCED8110BFBD8676B3CF9A346CD1
      BAEDDB632E54DE36CD3471DE96EABCFFD5BCED343E69F0A956A3C64D5B71D10B
      DCD16AD8B8695B8E79D53C5366DF1C3FF5C8080D32720CD1A4461A4DF8D99E27
      1D6984433450A016222F104A8047013C62E091A6B4B81CBDA97A83820283D09B
      D7D5282D2109E53D4D44CF636251415232CA894F402599CF50DCEDDB28252404
      3D8B8D45CF9F3E45558585E8797232AA2A2D456F5EBE4425B9B9A8242F0F74BC
      4695F0BB107EBF2A2B03DD55A80A6427E7CD4617BE5A8EFC57AD448FB6D9238F
      A5162835EC318AB8721965C644A38CE828F43CFE297AF9221BBD484A44D98909
      28272519BD484E425E1BD6A2A407F7507C7010CA8E894279E96928372D155597
      969091323F3303DDB23447154585A830FB39CAB8E6879EC5C5A29CE444549891
      06EDCA4595E56528037425DC0B4485C9F1304A26A2D2AC0C32BA16A4A7A05785
      F928F3E11D541217818A9F84937557C529F1A830290E5516E6A1B2175964F465
      5B83255E7F559E9D4946E6AB7B7F468FCF1C46454F2324EBB1E2826F93F55885
      494FC89AAC37F9CFC9BAAC123C8A67A5A19CB464540275E4419982842854969E
      205997550AE978747F535A882A4A8B91FF6F76E8F25E3B721789E8AB5EA03796
      8CFA8529719291FF797C347A53920F6DCE40B9E9D04F250560A7547467EB7214
      E0750A653CBA8DB223EEA2678F035166E8DFA834210C15C63D4279310F504ED4
      3DD8BEC728F1C16DF4A6BC18153ECF406F5E95A1A8B0507244F1DF6F872EEEDB
      849E87DE42F7FD4EA3A4E0EBA8281EEC9508F648084705F161281FCA172745A2
      929468549A8AB9148D5E65A7A2F2AC64545D988DFED867873C1C36A2F3877781
      4D225159066E7F0C2A4C7D825EE765A2F2DC67D02739E84D45394A0DBD0D7922
      80870960AB2454067ADE9415A0D7608FEBFE175151DE0B74E5D46FA82011EA4C
      8B86BE2E4607571BA3D39B66035FEE40D947A03B0CE5A644A1D21729B03D29E8
      05D8A818EAC0EBD072807336A3109A62D0057D377320E47F8872931E431BA09E
      F23CB4533802458706018F5F22EF23B668A5702EDAB87605DAF3EB8FA8BAAA02
      8944BFA1AC2CC8FBA69A1C65ABAA2BD18F0EAB917FBA2F3AF8C77EB4D5D31EF9
      C5FAA1874F1FA20AC8EF9379019D8874433B03F7A103F75DD15F4977D089A24B
      E8F7D29BC8A72C00F99507A26BE5F7D199D23F51C0CB3074FF552C8A7E9D827C
      0A0351DC9B4294FDA60A15C03E5C515D8DAAE0F315EC5F4111D128253B0FFD16
      9C86621353505068347A965F8E9E3DCB4795959528353515E9EAEE471A6AA8A1
      861A6AA801F36626147EF66342E1E7DB332BA5F95DB643EEA71AB572A083142C
      B667FCC2B66764EE575B66A5342BD90EB99AE43820AB4A0DA53920FD456C2FFD
      C9C60185CC0B3A90172B0758342F106B56B21DB23FE532AB39A03C0710EA40BD
      51B617FFA46CAFB96081A6267E137300D12FDAF6F44F090716E07F0607906CAF
      22995E5D80F372E600CEBC6001CD01EA879A03EF8C0354585AC201EA276D7BE8
      A74ADC57120EA040C4E400F593A55BA93E4788D9ABD44F16C268F0691E4ADB21
      FEC9C8DD41DC0ED99F3838465399E280E4A79A035C8F05244ED881617B846476
      ED05E29EEAC7E8D67EACDDCA18DEE95E95D52C4318C6814343DAE7CCF188919B
      B9E3CB0D0B7299E554A9C1C91F78EBDECAD8B5FB3186F77EACC3BB9C3F203E70
      F0590F1CB2FE80CCCE2BB76BD7360EC80C1A72438A1A9CC781E81AC6813172E3
      40FDF9036F1F07DEEE0FA8C7813AFB03E5B2FE40B9AC3FD041D61F8896F507A2
      DFB13F102DEB0F44739917A8FD8177332FD0A46CAF09DF345F3339D0413A06D7
      D91F287F8B3FA09E1BFE7BE2036FF307983D83D33EFFFC732607A89F2C99D51C
      50C709D57142F5F902F5F90235D450E35D21E6836F55CCC7D319424E808C5F75
      157040FFBE1A7DFB73C928F88A73ED32D9B837449A0F1AC5B955D27C5DBFFAE7
      ACD3F52BF6DE3AAAE1626EEE2CF9293AAA417EB4E369388B9CA5720DF8817F89
      AE5C11591D162788348E8A347E7556D43A6FDAB469F3F0DB5B019B2910E87180
      40A0D15FA05FFBE5D47D05FD39D72ED490E698C7BD21D27CD028CEAD92E4232D
      E4D43E6853FD58470133C3C2C2E51011019D3A0BE461F272570DD1F930850211
      11BF2A0C03D338017300CC032FFC2EF990FFD25F4B4FA02118D86674EDD01770
      AE5D28946909AE8E4B4348830574A338B74A9A0F5A5827EBC87CA3BE2A671D05
      988585FF622887916E11CE5DC3E2D233E5901A81E561096972488888903FCC29
      B195DDBA77270F38A4DEC51FB25F9A01D3057D877181EA1CE0D81092AF3BDD28
      CEAD62E413D4CD3A8CE689BF2A671D796C080B1BAF8875E111616199CF9ECB22
      2B3313CB13D2D35365919E161EA1300ECCC363DDBC5A80B7B2778FDAD1B5196C
      65F33E061C20E05CBB5028CD8139C0B121927CB8519C5BC5C827E0D8BE695CAD
      D34339EB281C0982A3E6B290C02922383D3FA7501E2FD22382E35E28223D21C2
      5C8E03F338016F65AF5EBD09E84FF14F992FDDFBC35676EFA5CF0102CEB50B85
      322DE1DA10493EDC28CEAD62E413D4CD3A926FD2AFCA5947016123C7B3213C2C
      33275781035999E161092C1C484D0B971F07E67DFBEDB7F3F0DB5B4198CE01DD
      9B29C9012EB50B85D21C98031C1B2260364A550E7069DF3CAED6E9DDAC4E1C58
      14C6360C8C9F1B1E96CFC281E7DC39F0ED8A152BBEC56F6F05670E28390E70AA
      5D2894E6F856C8B9210266A354E400A7F671DE437AD76D1C981DB69A8D03ABC3
      C3B272F3EAC28115CB972F5F81DFDE0AA5C681AE3D38738053ED42A134C70A95
      C7018EAD62E413706CDF0AA5C601EED6513C164CA88103F9B90575E100585888
      CD5C6B18A45E38C0B1F6E58C6FEF95039CDAB7FCBD71601A1B072684873DAF81
      03F1DC38209C33670E797B2B94E4C0400E1070AE5DC8C821AC030738B58A914F
      C0B97DCA7180AB75148F0513D93830313C2C3BAF488103D9DC3930C7C4C4640E
      7E7B2BEA8B039C6A170AA539E6BC5F0E706ADF9CF7C481A3ECE3C034E0400177
      0E24A62B70C08413B86E65B7AECA71805BE5429996706D8880D9281539F06EAD
      D3BB6B9D38A01136B8260EE41573E780E238B09813A81970ED684EB6B205670E
      70AB5C28D312AE0D11301BC5B9558C7C82776D9D5ECA5947910393D93830383C
      3CBBE089321C908F11CDE604AE5B3982DACA3E1C20E05CBB5028D312AE0D1130
      1BC5B9558C7C82776D9D5ECA5947F158500307C2B2EFC428702087FB38B09013
      F05672B9E33DC581119C39C0AD72A14C4BB83644C06C14E75631F209DEB575FA
      2A671D7998BC651CE071E780A23F309313B86E650B2539C0AD72A14C4BB83644
      C06C948A1C78B7D61173E06D59FAF4E9D7A72F3B0734C2ACD938301473806D1C
      080BE7C881599CA01C079A73E600B7CA85322D519503CD3972A0799F8103FBF5
      25FD506BFBF81CAD437A56629DB7E6ECD7AF5F8D1CE8C0C601EBF0F0FC825836
      0E84C53FE3C481199CC09503CD95E400B7CA85322DE1DA10920FDCABBECD95E6
      00F403350EBCBD61B3F87C3E37EB909E9558E76D39C9F25B760E2C0C67E540DB
      F0F0D45C4D459F309D7D1CC8480F93E780192728C9012E59059C6B1752D9F874
      4B94E2403F060738B50AE723FD805B584BFBC882684ED6A1348AAD532B1329EB
      28C48822C21B2B52C0342C2C223C5FF17C412A96476428202E4C8103C69C80B7
      92CB6EA42C07B8554EB281B9A996706D08CE07961FD847690EE0C183B4B09EAC
      A32207343422A23EA9EAD4A9B4BDF8AA8CF6F02D2C6C964644426A7EB60C32D3
      E3B03C3C225E0EE138FF7BE0408B7AE000D9E794E50035B08AE3031C39D042DA
      C27AB28ECA1CD08888905D1D18164675A9BC3C9C551E1626CE5F9F1C18516F1C
      90B6846B4304CC467D101CA0ACD3B70E1C60474D8F95E3BAB4BC3EB672C407C9
      81111C3930A2DE39C0D13A0A109DB391C18576B542BE8448014AF9845CB6928E
      0F70899929ED138A5BC2B5210266A338B78A914F503FD6E9C5D53A8A1CB0713D
      C480AB4DED1C902F41F53B8F277D29C5012E616E7A065CBF1CE0D81001B3519C
      5BC5C827A81FEBD48503BC2D0CF0B8708067CF008FE28093134FF21229151FE0
      B2953DC85676E3720E4DF5F800C78608988DE2DC2A463E41FD58A73757EBD4C8
      011FBFF5CA71E082EF05590E485FF5C48166DD3F440E706C15235FFD70A0599D
      39B07E6888AF0FE18057AD201CB8F030982201CD01797F807BACB83E38A052AC
      F83D72A03EAC53570EF8388484043B100ED4FE98551BDECE9D3B7DEFDE0D7638
      015F981C60F803DCCF8A705906A72C07543A67C4B1210266A354E4407D58A74E
      1CD8B6CDC72E1828E0B36DDB369E8D63ADB0E1EDDAB5EBB8EFDDE0608707BB76
      3138C0F407B89F1DAD0F0EA874EEF83D72A03EAC53270ED89F981C1C12E27B82
      1AD9B970E034E01C9020C4E1DC69190E48FD81459CC0752B7B7587ADECCF9D03
      DC2A17CAB4846B4304CC46716E15239FA07EAC53270E1CB283DEF43D4E667A3C
      1B875A61C33B89F1D011060FDF9335F803DC57CA70DE4A25C60195D611A9C601
      95C681FAB04E9D3880776938B89FC37B37CFE6BB5A61C3C3B303075F183CEC1C
      DAC97380F607967082B21C60BD0690F99B8E0F70AB5C28D312D539C0A555120E
      90F8407D58877141A2E2B5894CEBB071E0DCB9A9E4E03EF5DCB9733C1BDB5A61
      8363C68EBED88570846FB21C10FB03DC574D72B95CB64F73BC955D395C82DB5B
      F535A51C1B2260368A73ABA4F97A0BEAC73A3DB85A878D03D0ADBE7824F0852F
      3C9B93B582708014C01450E000752CE0BE7A9AD375F37D612B05CD6AB82980F4
      A37BF76EAAAF2DE7D81001B3519C5B45E5EB4EB5B05EACC3725F0276EBB07100
      8FEC8EBE777D1DE19367B3AC56D0E3C05D8A0235F8034B39818C761CEE9FD166
      206CA59E96F89E1C92BB7230EF1942DD28A43FE100B7CA85322DE1DA10493EDC
      288EADC237B0D1A26F5F022DAC17EB28DC9D84F98D691D360EF0A83EA57B9423
      0724056AE0C01C4E10E21BFAF4ADFD463AFA82FEDC6FCDC3B576998BBD849C1B
      22C9871BA5DA5D8CFE59EBB0706007F3D4F00E2E1C902BC1C60125EEBC25A887
      3B6FA9745F3241FDDD97ACEB077D5F32D176D933C1DB6BE7807C09560EA8F1EF
      81A83E50AF2DD6528046158B4C8DFF30B4E4C6A10B98037AB2323EE140A002D8
      44DCF3A9F1CF40BEC38103B2FE88AB0DE680CDF6125E8C58E464634371407EC5
      53209B08F2C93328904DA4C63F05F90EC71C205FDB9D3CBD6BA7BDBDFD218A03
      0E07779E3E292501C501F9154F816C229CCFC689011B924F41F4DFC50155F03E
      3980FB3446DAE1620EC4383A9C6372E03BE0C0542F0747590EC8AD91C27D2BB7
      088AE2801393684E249F82E83FCC81F754A64E1CE0493B5CCC81317EC10EC7E5
      C681A97E54F45A9E033E0F7DE438E06377418603544F7B3DF4A2221E816291A3
      9D3808A2E6C03FCC01473B4987D31C7074080909B13BC1E480FD39227354E080
      8F6FF0C30B321CB86017FCFB05050E38423E2F190E40BDBF7BA939F02170C0D1
      1777EE0506071CF1A297E010870B0C0E9CA0658E721CF0F10BBE16EC2BE50059
      04151CEC7B9C2C829272C091E493E100C9E7F57170A0BAAAEA03E6804C87130E
      38FE8E972EDCBD1B0CC41073E0AC44E6C8E0C0B66D3E4343404EAD91227D2B5E
      0465771C2F829270C091E473941D07483EC78F8103F8A4FFFBE38072411CE8F0
      A974E7FA5E107380748D2D79977080EA2EF2CEE080FD89A98C3552A46F258BA0
      86E24550620E38927C8EF2FE00C9E7F88171E0ABAE7C3674FD4A9A50D3C32A6A
      E68093D3FBE4C09856437B8EE2CE01D90EA7C601DFBBBE0E27A1237DA5E3C019
      7222933A9D29E5C021B23242BC468AF42D39FF6D4B7C8793520E907C520750EC
      26527EC707C681FE7CB613497DF9FDA509FCFECA7340A434078C55804A1C90ED
      70DA1FF0756CF7FBE9E3BE527F60D0C1130F6DC5A733A51C206BA4421ED26BA4
      48DF924550F8F0E28B174149C6019CCFC13126466E5E104C1D203E280EF0D94F
      28EBF3A509FAFC7ADEA7EBCE81AF2771E700E9F093E20EAF294644E2030A3122
      6A8DD4DD605B6A8D94E438FF3BDDB5120E9C9C6A4BF2D94E3D3995CA1703DF6C
      493E5B4AF40171A086A5247C46C27BE180990AA03930485B99718074F8EFF231
      22B638210B07A83552F86082D74831FD7D3B471E8303B48F106C271D2FE01B91
      9CA3451F10076A5853C6672428CB01957C42D539D05A050E9C549103B26BA418
      FEBED4FD23F97692ABE7EE12E7513C87944AEC3FB463013BF88C04A539A08A4F
      384305D0E380DFD0AFF5EBC201D673463291DDFD620EC8AE9162F8FBCCF81F08
      0F629CF53D8B3FE87C0CC9C18F8203A2F7C881DF601CD8C499038AE78CE44E25
      9EC31CD8222BD3A33920B7E229904D84F36D675E3FB19DE45310FDB739A0923F
      304B05A8302F90EF7065D69004CAAF780A6413413E790605B289D41C50283353
      05A8C001C5A51C550A601155B195FDAFAC21792B07C895C8EF89030B55001B07
      B46A408D1C6041D5C7B5EC875FC335E87C9C806F5DDA07BEBF8F79C12215C0CA
      8151A3268D1AA5BF69148DCD93C88716FBB1E002ABA88A7DD94F2007FCE73880
      6F86AAAF0207549917CC5601AC1CE8D9F36BF22F06F555AB469F904554152837
      2FA05C38C58563AC4BC9FE5B1C20F74E548903CACF0B96A800560E0C1D3A545B
      7BA8F6501AF4172DE9DCB09DEDB9D387ECB7E1A500876C5845C0018783F6CCB5
      64140714168EB12E25FB8F8D03D81D509E032AF9038B55002B075AB56A356890
      DFA05634E82FCA7360270B07E4D792B12E2553BD2F54455DCB326F4C3750FA95
      CFC79E00F109FABC170E98A800560E8C01B41EF3DB1831A86FCA7240EE7C810C
      077C7C7D643920BD9F56DD38C0530DA41F17A80652B6869B0BF01909EF85034B
      5580F47CC166AEF302E8F0AB7653A1C32FE04581620EC889C838E063672B5E13
      28CB011FDF60071F26072E38043FBCC09D0331914F16C93ED73DA6A3121C7892
      1C29F91EE95825E1804A65EB8D032ACD0BE6A8003A4EA8DC7943BCA8EFDCA113
      B8DFC41C9017610E9C256BFF1C1DF09A40190EF8D849D79205CADF4FAB260EBC
      0E9241F942058939570E94FF12222D1672F975472538A050B6FE38A0CABC60AE
      0A5069FD003E7937F9B803E9489A03F222CC013F2C7324320607B66DF3F163AC
      25A39792D941DEEF244BC9D8F03853068F9D631E47A432F1D8992307621E5FFB
      A54C8C8A8BD71E4772E78062D9FAE480F2F302A10A5089038EF876498EA423A5
      E380AC881A07C432470607EC61B060AC250B94BF9F560D1C080DC92C60203344
      C3392482F1D08ECCD410AEC782D010ADE62368746BDEE3628812C702C5B21F96
      3FB05C05A8C401B2C487DC3B4FEA0FC889883F7082963932FD814358E828594B
      265D4A46DF4FABA671204896034120899079B26B10677F20A85CD28F2346347F
      15A48C3FA05096E280F4FE4232371BE23312DE0B0756AB00D538D08E5A05E2C3
      9C17C88AA8F8C039C9D2102907A89521E2FB6D0506CADF4F4B190E3C6340190E
      684AEE18DD7B64AF4AE538205F961E07D86F36C49726BC9F7160850A509103B6
      537DEF52D33BE9DC504644C5078EDA8A9786483940AD250BF1A5D792054AEFA7
      E5FBD625E36C1CC86240190EBCDE2C8E836FD21F55AE1C07E4CB521CC0771662
      DC66487CB3213E23E1BD70E05B15C09C0C2AC38173E77C4FC8C7079822717C40
      BC3444CA01D9FB6D0506CADF4F4B190E3C6740A971801907579203F265290EF4
      EFCFB8D190F466437C69427FA538F0E15F73CA394EC81223925B4BC6BA94AC26
      0E144AFE290E309FEDA40C073A30E2E0DA4A1E0BE4CB120E08F8AC371BE20BA4
      097C81C67F07AA9D33DA2FE680DC5A32D6A5643570404A81823A72401A07F71B
      A4E438205F9670E05D5F63F2A143711D118BA88A7DD98FE2C231D6A564EC1C28
      2C2894FC531CC89142390E30C2E0AD95E5805CD905FCFA307294A0FF388185B2
      108CEB3F2EEA83214A0D6B4814178EB12E25AB81030C28702047290E44864AA1
      2C07E4CAD61307FA37EBDF4C7940A9A80F7D0C517D0D89B33C07629C83227219
      E0CE818E41C5254F68C43EE9D841190E28942DA138C0E16E7B4A1D31A2BA756B
      D46880B268D4A85BB7288DFF2E42320B8B0A8B68146686B86884C872202492EB
      381072B0F489B4232D429488152B96251C1072785A9F5019CF31EAB3268D7B34
      51163D1A37F9EC3FCC8145BFC89E2FF805241132F885EB38F0E497EBBB3B4A7E
      1DB9FE8B12E38062592538C0674E1B05323348E9779A038D55C4A4FF300762CA
      1F334FD8FD52AEA1A128E178CE48F6DCDFE3F21825CE192994A538C0E1697DC2
      B7469224DF690E4C1AD554158C1A1555A7B5347CFEBF9E29AAAD211173204695
      B2CA70807B4439AAA7AA88AACB5A1A6A44FC183950F77544420E4FEB132A7366
      E91FE5C0321B052CFB1771E01F5A4FC89103DCCF3047E155BD5395052EF40E38
      207B2748EA6E901A6AD402218727362AC78156DAAD548176AB77C1012779A993
      9A03B57380C3131B95E340EB769DDA290F28F32E38C0EB288B763C9B0F62B4E6
      E2B11AEF5542DD238F77C8010E4F6C548E034F62634A94EEC09298D827EF8403
      0EBEBEBE0EF80D7FC2DF3BE6403D7AACC616CA78B57C0BAE3967CF5E3B7BD192
      254B66D7CC010E4F6C5492034F4AE4381013530288A57FC5E21F317233999292
      27EF840331D8B938C97034FE390EC85CC28B5B27372C288C12CA4D6CF8E6CEEE
      5C7119E358CD1C78EB131B17F117916723F259AF43A1AE44E983AF4C6D29B912
      25AA63A786B2976D4B07FCAA9AD1B053C777320E9C3B7EFCDCB973C7257FFF34
      078282E438101424C30168B7121C20ABF6A9A5FB7CCD88CB9F736F8DA6DEE525
      3572E0AD4F6C84D6916723BEED8A347DFD7EFDFA694AAE488B6AD8AE63A4F2E8
      D8AEE1BBE48004FF3007703C4E860358C0E00069B8121CC0ABF6A9A5FBFCD711
      B79531CFA5B770E06D4F6C24CDC4CF467C2B0764AF4C8D6AD7B14A159FB063E8
      3BE1C0D1A3A2A352888ED21C5844FFBD670E50415906072881840374CB95E180
      885EBACFD774FBBB23F7D8608CE6E59A8F051C9ED828ACFDCAD481520E14A88A
      77C2811D72A038D0C09DFA7BCF1C20FD4FDE680E90FE276FE427E97FF2A6823F
      F0DA2D20B4134C7DFEDFDEB9804951DD899E99C6C4CB5E8CEBC60DDC201B1511
      4DC37455575777E336DE08E26B19948762547466BA613ACE2BD3CD0021E15390
      5CCD72F9E62E8CB82B01751432828C816430FB453777AFC13141DD99B986319B
      C7C60751272A46EEFDEEFDEE67F69EFF39F53875EAD4BBFA31C01FA6BBEA9CAA
      EAAA737EF53FAFFFF99F51279936EDF8F1E3A313AD1F3EEB62C5464F0CF886E0
      F5DAD23150531106947200BE08034A39005FB0AB94036AABC1230313FFE59FF6
      FF68EA6B6EF5EC0F6D1870B16263D68BD7A23FD5BEEE4FD0992130B065D31632
      337CCB962D9BF08430C200A1E0CE32EB01A55EA8EB01A55EA8EA01A55EE84F0F
      3CF9B39F3FBD7F7F4747B793CC9B376FEAD4D493960D83ACD55CBEAC1E930DDD
      7355A95AE04607016482B8CA00FC3B2DDA866ABBE0C99FFDE4270882854927E9
      004E124F5AD686DCCDEB1B3F0CF4305239063C8F6ABA664069170C3CB8F7D9EF
      3FBD427294FD0B1127824D596035972FABC7786220A04D6940060C9E20893748
      CC401FF977BA3080DB054F3EB8B7FFD9EF7FB3BE7E8583600C56F55AB70DADE6
      F265F5186F0C04B3292DCBD8F1A3B6BB360754533FE1FF1BF8F173DFEBCFB6B5
      CE9FBFC05616D7030657D9D407ACE6F265F598AC17CFD6016D4A4BF2A6B1DEC3
      58CF73CE0754619D7022620041D09F6D729A9A3B1F30F8E75EEBB2C06A2E5F56
      8FC97AF1701FD0A6B4247A80F51EC62E38E97C4015B60D911E78E1B9E7BAD62D
      5FBEDE56507D0E28B8DC8601976581EB952E02DA9406AC0F3CCCD609951985C6
      A6826A66705C3531B03A80B541A8A63E22A4075E78E1D1E7BEF7BD2E0759B7EE
      9A5BB36DDFE8BD2B585960B3E28DBE1D8E4D69C076C1038CD4500CF46F7D56C9
      6275712165B1C15AD5D954FF26FA007D1A61B5F415330CBCFCC20B079FDABDCF
      49D6AE5D7BCDFA99BD77D47A6D1CFA9E6352497B42701864148A01DD9F98B606
      25814061408D570F80F86DC118087BCC88290B5E7EFEF923470E3AC8534F3DB5
      7BF73D7FF3D048F90C932ACCC0030F6C466FFFE6CD9BF1C7664A0FF46F05E742
      7A161FC0FB1403D88D000509E556A05AC68E593DF0F2CB080247397830BF7BF7
      03C36564A0A236A5FCF102EC4F6C237638845543812C43FA8AF29E1788FEE8C7
      CB90F6AB07901529897B91A06D43F10BE1B70D270E6C7F19E47907C114E4F37F
      3B727DF918A8A84D69CD238F3CB293168581CDB072ADE64F4C59EC545B83B296
      B81B7D0CDC8B1DDAB3592F2C60FF804F0668593831C43E228D811D3F7ED98D00
      068F6C1E18DE553E062A6B536AC1C0C3C405A1E24F4C598372A156E5430780EC
      39F4CA3F0E1E7A58AF34B6BF82972C2E94C5A6D42303B5B5AAA5980B4332240E
      030356753E2273A2D13936D18C8B8A0ADB94EE654461606FDF46E2421007613D
      F01259CF5A6100BB19C42B50F6910350C3515F91B22C6FCFAB5E20F8C1AB3EEC
      87EDD68ACC5ACC2B566714CF89085FB09228B30C6A656D4A6BF630A230A0AC4D
      A9F8132BD42C7A7C03712D85D7A0C407F42D828590B72E520F58B4012F8CBC21
      6CBBD4906CCB6F0C9B01A3672AF25DA7CE2F9E1189887F99B11466C0B0C236A5
      160C18D7A664D7A0540E80FD43FA01D48A94553A3964F76E6D351747DBF2DD36
      734BF1A452665E31F956B667D64522D1948D300C54D8A694118501A33F31760D
      4A72801AAF1E40AD48599504DCE1CDB6FCAEBB1C18E0CF2B26822A03E77F3961
      2D0C0395B529B560C0E84F8C5D83B296ED176457A4AC4604AEF7645B9EFCCC80
      F5DC523CA9D438AF187F5FA16E5FF1B94864E61582B5181978EB5DBFF25628F3
      8C18A9317B9F7BB0C02E38E97C4035CAC8B78E8F8E1E7725A3C76BFED3C03207
      06AEB49139DE18F00BC15BFF2704060EB0A10720FF58EF61ACE7B95D8E075423
      03BDFFE38D01D7329A1CB8276BB75EA83D03DEF4C09FDEF22B21D8948E6FFF03
      5E19F8EFDB06AC07090C5B4706A64D7CD27A7E319E58ECC4C0A597BB66A01AAD
      B5581311E7EA499F7919C4AA937FF9A7FD03FB5CCAC0453F7DD27A7E319E586C
      C7C0E5978E1F065CDA903833C09E518D0C3CF9B39F0F58DA0C305B03F3524FEE
      CEDAAD17EAC8C0CC2B446B61DA0515B529756743E2820166CDBAEA64E02703FD
      96C643C6AD818EFFFA649E37BF18A6969239C6C615EE8C62C7C06C0E0395B429
      75B02139BCDE1B03FA9A7555C9C0837B07DCAEF63100B6E516F38B23648EB1D5
      5CB2D90A03975ECE8F86B9A62C0395B429B5B521599F7C45310F38E02864CDBA
      6383879E353070AA8A105832F0E0730396B6C4C6AD968185FFDCCB9F5F7C0F9E
      567CF7DD560CE03CB66680BB146E456D4A1D6D48B662062E741476CD3AE5E166
      FB15723AA7457CB33BE14130F0E3E7061CE71610A91FD87FD5937771E717E3D1
      0798581C11ADF3F88A991C060C8E288C0C54D4A6D49D0DC93647216BD6E1B58B
      7E0E6BD6A90CF8F4021884013CA263C580E452069EBEAAF79EACDD7AA1966501
      0861C0A6D2C83050599B524B1B9285940D891B068C6BD6690CF8BA351B066E74
      277C065E1848BA9481C597F7DE95B55B2F341BB169FA91B2C03D0395B527B4B2
      21D9884D84141B92AD8EA2AC59776C9BB2665D1532B073E0C7CF0F74BB93C303
      6D337BADE717E389C54E0C7CEECAF1C280A50D092EDC151B92764761D7ACAB4E
      3DF0F2C0FFB4F23BC16C0DAC8B213D602B760C405930C7030395B529B5B32119
      C416227D35850D8EA2AF59B795362AAD0403367542CCC0F1E38E9E488E1F1FB8
      E7D2916F67EDD60B7564C08B1EA8AC4DA9AD0D89BA26DDE38E62615C1E3E03CE
      75423CAA67C5806BD9BD79F88EAC5D0F82330357A823CB5798479923D56453EA
      CA86A4D151D835EB4AC6C02D8E8247F5B80C78B42DB79E53862793456C4C44BE
      7C3E62C0C6C484D50395B529756543E29201F364B3F01958EA2878548FCB804B
      DBF29755DBF2ACDD7AA1D9889DAD583412A99B693231332D5E511D36A5AE6C48
      5C30C09C51320696380A1ED5E377161B6CC79DC4667EB1521658DB8CFEA51889
      CCA8630C4D0D0BDA54914DA93B1B126706D8334AC6C09D8E82477442E95DB62F
      0BF8F38A890891390EA6E7A1DA94069AC5516A1B92F01958E628B8573F9CDB2F
      DB1C934036A5637652F9719AF019B8DB5170AFFEF8B2700AE6A774CCF00E337B
      A7230337B9937166E6F6BA3F9352E2A774AC40D97F1498BDD39181E5CB9DB21F
      F7E68F2F0482F92945B9AEA51C6680DEE3FDDC8BF56590174BC740D676208738
      8CC56E404298F21AE68CD9122E2EC86340B661A02C08D4D7978E017004692FB8
      27574978FF669A219C6EB2FB1C9DD29D94562C685BDFB5EFE091E79F0F9181E3
      06068ED7C8B26CCD407D7D5921089F815CAEC94170CB6D7C31F0BA7F210CBC76
      91E2961F33F09A2C1308AA8D817920C1196869C93908EEC51B570C2C1BF06B57
      5C374018E89E37156130AA30D02DCBAF6108AA8481B0ED886EBBADC5416E0319
      5F7A60C0B75DB1C2C0FE85C90EC0600A6660BF8CF6100453AC18B8BC0CA23310
      BA3DE16DEE649C3170BE5FBBE2816598816FD6AF000CBAA76206C89E2C4FB562
      E0AB6510BD52585919370CF8B62B56F4C0F26C2BCA7869611233A0ECC9492B06
      66974134064E9D65C0557DC0AF5DB1A03070CF3D5D28E35B6E5B8119A0F72A5E
      1F3875B62C70A70704BF76C5033EFA09CB5D27F439A679A6D5097DDB9492FA80
      B7F18271CFC0E9D8360CC2808F71C371CFC0E9D847B46CC0B75DF1808F9B2B77
      5F71E80C8CE7BEE2699881C56DD975FB9E3A7284D603BEED8A31039EAD07CA89
      400918F03666549D7A20DBC53230D5A75DF145501F0006963CD1B3B1E70992F1
      3BC79EE8394C76AAA1811E3E039EC68E2BC980C156995316181898E8D3AE78A2
      A2077A9576402F643CB5737A32E0C986649C30B0F307BFF06957FC8B1F600676
      157BA0AFF8A29E9EBBC660A7E3F3175E3805764E4F063CD992559281830E0CD0
      ED82DFCEF8E1A99A539FD0FF3EF904B29DECFC1BDE465FF08F086C9D3AF5C319
      BFC50CF4F6480B09044F801A58786FF192A2043BA727039E6C4AC78FFDC0FD03
      7EE4FEDFFE5FCC40B1A75EDA0F10F4F48CA11D29FDA5BF9A5EBC10ED9C9E0C78
      B22D1F2F0CFCE9EAABCFBDFA4F66B9FA6A8BEB9FAB0AF64F38B6B4A79540D073
      786C6C774FFDC5175FFC57974CEDE9F0C7C0D8D888517A713563FA7453F07424
      D64DD09231E0698EC97861E0DCABAFFE93BF1F3A1767DA8E9EF50402A2076E4B
      7FF5E22F15E779D203636378B40FAA916323286B7F40C925B30780819177DE79
      870E1E1B1B601978B12C6D434F73CDCE0C5B32A80F74AD6F7D5A5AB890D407DA
      966FBF38FDCD24AF3E002FF4AB384BC7E0257E1567E3741C31FBFAEBAFD718B8
      E43C5D661208A68F7CF8FE3B86600C8165EF53E9F480A739A7E3A58FA8CE511C
      DEE11D0041FDFE9E9E47C660A7ED9B482BF4F4DCC965E0D5D9CA7B0D0868EFB2
      91814B6653992D10085806040281B9EF69F6572F2F6D5FB1A7B9E7E3A58FA8EE
      3313CD5247873A30D0BB03F7081449FFC00EEBFE018CC04CF25E030233D57799
      656026250402CC00138CCEAE00039E7C505473596064C09C04C0404DCDA5581C
      CB72C8F8664200DE29AE213BE6430101E5BD0604B477D98E81999FCE44D89818
      8060E34F540D03942F9AF1CF405DDD79E8BF0B065C8E179C07087C0A10F49E07
      087C0A10F43A30801178D5C4004660E02C03E1D409AD19B09F8CB2DD5E3867CC
      C0088072EF9D31A66C7219A00A258200A90F18832B541F38CB008580432B9903
      C10CFCFA42CE8F509B0C03BD97CCBE9D72734010189BDE8B1830049BDA055553
      273C9D1838C79E0187DE322E039F4E44197FDE79C080B6C93230FBF6015AE963
      04080374B0B97F80CF40657DD58E7F3DB0E3AB91FB77DC6FC5C05DF6E2910124
      8481B1FB8DFE33CEC3758BE94CE88CF306A6BB61A0C232FE19B81F8B15030E23
      275E1808454AC3805F473BA70B03E48DB362E01E7BD98E7B1EB4C327D6D9EA81
      103C979C65A0140CCC99036EACAC187018455719B8FE8C66A08AFC0FD83360D5
      4FF817582CFA09B73B18D26006FE62CE8CFBE18EEA2EB565409F2476BA31F0BC
      5F898470BA170638524787F21968B0178581C80E170CCC562F6AC9800BD4790C
      BCC88AC9135A232F243C06C0E7A8852B52E3069F017334136275BE5706FC8D19
      6D77B0AEF5A2075C30606EBDB96180F15AF8EC8BAC47445841ABF05F34133AD4
      162A14C266C097443C9F7ED099018B7143DFBEE5B6DF6A2F8481BAB0F4C06C56
      0BB862C0E8BDF4D1C28BD8336A5FDF9E3D7B1F79E4C107B63CD0030C6CEDD9B4
      E5C107BFDBD7B768EB340441980CE84B57F257B4B4883F783062713A1342EDB6
      1D3CDA86378EB6B5B5456AB12FD3A347894F53FB7143DFBEE5B63BCCB4F0A407
      54B163602EC8F997295F2E19C0F931E5F1BDDF8175D31FB666601362604FDFE3
      A133B0CFAF443C9F8E32FC28C9F7A32A034795A036FB31A3B10275E30566CF96
      018719573C06066EC7397DC9F49119EFA8E2AE5DA032A0891706B61E7B9CCBC0
      66831ED8B567CFA2436133B0CE6145CB75566B5E462C4E5F67B9ABE43EC976CC
      C0D1A32A04A562C061813ED236A45A9BE8366E9F7D09C8F4E92391F71571CFC0
      1520575DA97C796060DBD6C18D7B4C0CECDCC9EA81529405FAD295FC152D2DE2
      D7AF8F589CCE8450BB864C07062824ECEB843C0664570C38CCBEE530703FD200
      4446EEFF509177DCF513A22CFF6B10E15BCA977B060E6C5317C7726420FCB2A0
      CDAF447C9DAE297FC4005D34383130ED38CDC034CDB79C13030EB3F0B733ADCE
      3A180FEA55AC82C7A66B9BD3DD3280A73AAF9EA57CB96600D6B779657070EBB3
      15D1038B1D56B45C6CB5E665C4E2F4C5D6BB74253052BB4092F42AA213035335
      DF72C0C054CDB75C086501D3C2A45A1CD37571CB0059F3ED02E5CB2D036489A3
      9730042C039BD93A61F8F581157E25E2F97406A105F46A894E0C7468BEE58081
      0ECDB75C0865817BCB54170CE0C9CE87E3CA975B06C89A48F8D391813DAA1EA8
      3907494D180C487E25E2F9F4EEEEA3645D3CF88AD476C35D1C3D3A3A3A5AD3DD
      EDC4C00ACDB7DCB402ECA9BEE5A639F89C76B62332F442076600FB989CD7AD7C
      B9D7032F1DDAFA781FFA74D4037D7BD4FA401F5E6F240C06927E25E2F9F46E54
      F26304E00B3180721FAA0753A64CD118B0EA232AB46ABEE5A616B43D5986BDDA
      DA253CFF948FBACC38B64E188C015F7D447889A329FBF7EE39645F1FD862D403
      353521E9816EBF12F1713ACE7D42026260CA14D24C8018A73EA22ECDB75C4741
      DF9361AFF6C6952BF35F61E42A0502873E2247064C9DFF76A3013EFB8A6DFA88
      380C68F501A207EE0C8181297E25E2E7743DD323B55368249CFA07F29A3739A9
      C0ECD522044C0C74E557AE04041CEC09B38E0CB0191AB11900F7396664CFC066
      4B3D00D58150F4C03487554DA759AD7219B1387D9AEDAEA2FC01A151BD689832
      C589817F686ECEEFBE67EDBAF56D2D0566AF162190BF86957C1E33E0604FE882
      0146B147A89CF6613E11888152D507022DF8E5E374520904846AF42AE2E8A853
      9DD06EBC60E555D7F00433E0604FE88681EEF805B3BE75E5DCCB3406B480B018
      B01E33B2D5037A368E3306F4D3D9BBB163C076DC70257F4C1033E0604FE88681
      798793AB85ABE69EAF31A00584C4003376DC67C7C0AE3D5A1FD1F8D503BE18B0
      9795FCFE1FCC80833DA12B063E9F9CF5D757A80340C0801A10527D00563E7C7C
      43FBD66DDB2E3C00C5A463BB604AC87D44E3C396CCD67A60E57C6B061CEC0943
      66C0D96CD22D03D6362420E1DA905491383140F9961B3B48FB965B593F9F2798
      01077BC2B0193081EE93018FB664A78DD833D0DB7378DED48BA6A9BEE53AA62A
      3BC0007F400333E0604F183A038C0D895F06AA456C865A3C1C121203BB8AD8A3
      D44535C4B75C12FB969B467CCBADE4BB01C50C3879EB0CB55DA032A0DB909C8E
      0CDC779F2303DBB7978281DEA715DF72A3E04B46527CCB8D625F322B256B061C
      EC09C36D17A000C68664DC33701F2D0A0264C3E610188929010345C5ADD8D48B
      C0A754BDE25BEE22EC536AE542EE10D54AE7AEE26CE865016343121E03B7F992
      E00CD00A40450067B5F52164382E7C0696AE572100DF72DF547CCBBDD6E1C480
      833D61E80C3036242131F02862805D80425F89A2E40C1CD53318E73FFE301E72
      9F7E08CE7FFCE183019B06E4D88E2E05826ED0034D8A6FB9A98A1EE00A66C0C1
      86247406181B129F0CEC9A616C05A0AB1816A50002F49528682818098501D5F4
      4BCD7DF26538442B2894DC275FE1964B63BDBB15DF7249A80FAC577CCB7590FA
      400777A81A33E06043123A038C0D89EFFE01536F8061510A20405F8982868291
      3018D04C40EF33BCEFF4215A5500EB01A55ED8163603633B9EC2BEE51612DF72
      59EC5B6E3FF12DB7F28B1D3CC10C38D81386CE006343E29B81AD3D9BF73EAE43
      505B6B58940208D057A2A0A160C443128F7EBD70FB7F03A5737BE18927BE5EA0
      195034C17DFCB6216640D104F7056C1BDA33D0BB6377C3FAB67AD5B7DCAD4D08
      02B57FE08B5F9C67968EB0CA02F7E386E1F5116106166D3B764063C0D0CA0502
      F495286828CCF611A21B212357C7476B46E1A3A6E6D4834FE80CA8C5810D035A
      4DA1A40CD8F8965BB9F2A73553597971A5EBB2C068571CC47E20BCBEE2AD3D0F
      EDDDB075B07D9BCA8061510A20405F89828682110F0C3C51734ECDA99AE3E79C
      3A5E03AB043C61ACF4AB0CF0CB02ADDF805716F0CDCB0524DE19B09E6DB872E5
      D44F2FBAE87F4DFDA22253D1D6CA954B5DDA11D9DA947AB3230A6FCCA8BDE7A1
      3E3CE5609BC200B30809DBE79DE5AF5CE28181CEE353A64CBBE8B5CF7E162F18
      F306C340DB51DB3AA15667E4D409DB0CE9A1CD30F0CC80D3C8214796566587B8
      7B3DF09832E5E00061805D80825A8982078577060A359F260F1FDE78ECD0C6E4
      E18D87593DE0D4366CB36E1BB6D19350226DDA4CA39019183FE29A81EF69530E
      B66106D80528A89528682818F1C2C0F18D4FCF7ABCFDBEFB362CECAB7FDA8A01
      1F7D444ABEEB0CA8D3CBCE32E0C0009E6CB00D7F6206D80528A89528682818F1
      A4070EAF6B3C04197C68D6D7D6690C04EF2BD6F39D30A04F2F3BCB803D03FB0E
      BD84EA02DBF02730C02E4041AD444143C1880706FEAE66E31D480B6C447FED7F
      7F83CA400863464ABE2BD34C759570D463BB61BB6B395D1840F5810D3578E201
      A90FB00B50502B51D05030E2490FCCBA654FFB863DDF8FB7FFE4DBFF60C380D7
      B163C2803ADDDC7FDB71BB4B07BC37D20C58B505565DCA756673E9AACB2D632A
      C0C0E6BD8BE83E2276010A6A250A1A0A46BCE881530D0F1DBBEFBE63480F1CDA
      FC90C24028638F11AA8FA1CC0C642D0EC9D6D5CDE009CAEC39B5D12F9805C26D
      DB7F1EACE7BCF40F18FA09D90528A89528682818F1C0C0EDC79BB7F493FA40FF
      755B426640EB6308521684CAC09C3975E0D3103B36245BF80B4120647822D4D9
      F603B91D13F3CA80410FB00B50502B51D050981D12BBEE233AF59D67AEFB1A82
      E0D8AD9BB66CD219086C32AABFFB4703D5097D3160E1A8395B77D9CC999781CC
      54FEF0F6CCCB100329BE949F01D39891E3AA2456CEE9DDB70DBFBD69D3A6BD87
      36EC7DC6C84030CB734EFF80E67AC423032E1D71DFEC8A812B2FE7C995888104
      5FCACEC026E3D8F18C9DB537FA124F7DC59B9F41103CF3CC75D76DBAAEA40C68
      DE68CAC080C58A5ED9BA2BAEB8120B7CA9DB6803CA02BE949D01D665616D3918
      D84449A80C70FB8ABDD7096F7129AE18B8922F55C4003BFD8CA9136A35811019
      289CDA5C2206B863466DE561C06275C771C1404DCD940D7D7B1FDEBC0532E461
      9601DEAA2441EB8485DD0F7FE7E1EBBFA348BEB40CF86A1B2E7529340356F3CD
      C70D037DC7BEAF31E05BDC32F0F4ED5FBFFD89AF6BC54F6D680C8425DB97B814
      9A01ABF9E6E38501B01FE82F1B0376A6BED5C1C09D2E8566C06ABEB90D031649
      5411060E61FB817E8581CAD89657150377B9149A01ABF9E6755F3688A86E5417
      03AACBC27E9501C6B8DC6AD710556906B66F0F6FA4C7695D22DE024556F3CEB3
      96395D4D0CE82E0BFB310346BB61C68C18653B3FCAC3ED95A43E003E42EF7527
      CE0CDCE3526806ACE69B8F0B06B0E5C01EFC891930DA0D3366C428DBF9511E6E
      AF24ED82ED28735D165BCE0CDCED526806ACE69BDB30602A1F9452A2127AE0A5
      437D0F3F863E891E30DA0D3366C428DBF9515E182845FFC07694B9F5EEC49981
      9B5C0ACD80D57C731B06AC6A8B256580B78E09D40716ED7D7873FF21A53E60B4
      1B66CC8851B6F3A33CDC1ED54F785D780CD4BB1667061A5C0ACD80D57C73CB16
      608518E0FAA462FB888C56A38C1931CA767E942706363FB305C60B42D5036132
      B0DCA5D00C58CD37AF3A06980CE7326054778C19319DEDCB19BB62D76581326E
      D8DEFFCC962D6132105A7DE05697B2DDD18C283B3E1930567B182B62DAACF826
      C6AED8B51EB0B21F085A1F088D81AC4BA119B09A6F3E1E18308D19199BC08C15
      316D567C376357EC56ACEC880233D0E24E9C19687229340356730C6D18A04692
      95B16532AA5C6A06B66DDC0F15C0ADCF2A0CB02E0B19DBF23B192B62DAAC7819
      6357EC56ACEC0903F70FE4DC8933036ED749A119B09A636869295267695D5262
      060E2C1C5C080D41D221C4F541611C1661AC8869B3E23B19BB62D7F5019E5D71
      600672FCF9D0F66FAF050339EF3459CD3BCF5A5A8CD5695666B49D1958999598
      818D2F0DBE726CCF8F5E79057708717D50188747192B62DAAC78096357EC5A0F
      F0E6170466A0893F1FDABE14B760A0C57BA9C22D0BB01EB0B21CADAB33D898CE
      A9D3AC4D4BCC009E4FB40D21A0EA01B33DA1D14C82B122A6CD8A973276C5EEF5
      C0E1FEC68DCC3CA3C00C64B359EF2DBA1019B02A0B50B6722CC8A3B560586C61
      755EF2FAC0A19706075F510688B83E288CB6218C15316D567C0B6343E2BE6DA8
      CD379CA5CD370CCCC072ABD9B076BD7B160CF8696194648E4989DA0587F0C840
      FF269D01667E0163476C6D567C33634BE65E0F70E61D0766E0A69B6EAA280325
      9152B50D17E191018D8176DBF9055E6C4ADD0AD7FF406006EEBEDBC7488F0503
      5533DFB064FD037D871EA3FA07B6F6F46F84F986078E1D2813035C3F24811958
      B6CCC7A87FB54B99FA88B67E6FE3E0FE03B0022E82A02C0C70FD110566E0CE3B
      7D58809D890C70C68CB61E4695C48508817F54FC0F3076C4D666C537FAAC1372
      FD92056660C9121F96A0672003BC754C901E7869F015682E2AFE076EF62515B7
      255BBAD48745F819C8C08BAC28FE07504BE1157045C3AE5A52E6070EC4C02DB7
      F89819720632C02B9CB7F66CEE833E838DAA5F32FF3F1B70DE703006DCABACB3
      0C981978E8BB1BB0231A8501DF8BD504B50D0FC680FBEAEB99CE8069A11AD23F
      B08D2050260618C3628D81207A244406BE5BFBF777DCB153DBDDF5DDDA9DB0B7
      E6BBCFED5AB264A712B1AB76D7AE6F7F9BECDC59BBD43866B6F3D16A66C0B484
      95D90745E919600D8B55069EB7916EBBC8501958323434CCC8C8C8A3B58FFE6C
      C8143132F248EDCEA543C3E6F05DD5CC80B294DD238F284BD93163467F571606
      18C36295812344F80CA871BC63C264E0C6A1E1FB4D6B5AF78E3C3A7368E8D76F
      31F2EB919125B1A15FBE7D8291374746C61303AC0F8A7230A01A165FC767802B
      263DA03B237EFE489875C2A121F3BAE65DCF0C8F00026FBF6994B7DF82F01363
      EFBEFBEE7BD4BF774F9C181EF152BA558C01B2ACA9D90745391800C3E2EBFE16
      1C91D00C3CF5D441F49F2FDD470CA98619509C113F7F304C06065FBFDBBCA6F5
      CB3B86077FF9D68913BF23F2AF8ABCF9F6AF4706DFFAE80F273F3CF981E1DF89
      B747EE8027FA9C2BA91003DAB2A6667BC2329405D8B0F8A60B2EF81A7148A432
      B0CF461003B4A39923477467C447F685D93F30C45FD37A78E8D726958F94FE5B
      C34327FEF0C1490481E1DFEF4F0C438D2072A92BA9380326BBE232E801302C5E
      FEF9C19766DD741DCDC0BAAE2EF49F2FDD070DCE880F1ED49D111FEC0A9501BE
      193962E0CD13265FF6C0C0BB8801068193EF9D18C64F743E92CB66E24F7DD3F8
      853ECF4406C0B078F905470707071B1BC0B05865209B5D8FFEF3A57B9FC119F1
      BE7DBAE3B97DEBC3EC2B1EE29B8F0203635C063EFAE0C393ACA80CC0D293979D
      8F3FF54DE3D765E7FF79E518D85C3106C0B0B8717070C3058383D8B05865C0CE
      84B7BBCBE08CB8AB4B7740D9D516E698D1D07C4B067E6F1260E0BD0F4EDA32E0
      28E75701033FDA08F30D9F3DD65F2E06C0B0F8B159B36E9B3CEB8226302C5619
      58BC60C1E20516D2BDDEE08CD8A023168439763CC45FD37A78E857BFF9FDBBAC
      D83000DD477821D22BAFC29FFAA6F10B7D569E816D1B07F7F73DFCD8D6C163CF
      964B0F8061F1E0E064A4072E00C36295811536D26DED8CB86D45C483EF1083F7
      101E037C068181F75879F7378881F73FFCA38981F7153D000B907E4BC09FFAA6
      F10B7D56BE3E0003460BF760FB81B2E981C3FD8DA830383A780C1B16AB0C4836
      D2BDC0E08C78C102BD2C582085694734C49FA88A1878E7BDF78DF2DEFB6FBE8D
      183869CD00BD10A9614D52EA0B1628AD3403DB34FB81FE7231800D8B9116500C
      8B55069236D2BDC2E08C78C50ABD4EB82219F1E03BC4E03D84C78064C9C0FB26
      217AE0938F4F9E34FE7F5F290BF465482FA05724A5BF2E80054A2B5E1FD8A6D8
      0F94B13E60342C5619E8B613C9D03F2049BA3362A93B4C9BD221FE7AC6C0C01F
      4C8218187EFFE41B2C0227FF706218F711C102A4F1C3F853DF347EC56181D2CA
      B70B0E61FB81FEB2B50B58C36295812936D29D3430904CEACE889353C2B42DF7
      C60094053F1DFDF8E393C6FF8801988119D19721EDA65724A5BFBAE75D58156D
      43CADCBC3C7DC546C362958169A3A3E83F5FBABB0D7DC5DDDDBA33E2EED18807
      DF2106EF215C06B88218F8ED0726410C203D50F3312B7F50EA03AFB992EAE81F
      D0CDCDCB52163086C56E6C48BA59C5A03B239EA2CE330A65AED9107F4DEBE161
      6B06A6711818C24FF40692D137B44FB269FC1A7D63DA99D84FC81816BBB223EA
      565504475360066EBDD587F7101E03FC35AD410F7C681260E0A393A37F640531
      B0536540CD726B08222533CFA36BB5B5D63624151833F2634BD6ED62CE6928F3
      8E87F96B5A0F0D5B31F0E607134D0CBCFFF6502863C781454740F73360B22533
      FBA0F0CF40509BD240B66461F9291D19E6AD693D3434323CF28E497E09E11F7D
      F809237F7C7368A8F6AC8C5F1979FD33A635AD8786962238467EC5C8300EFFF5
      9B1F197B0D4EBCFDCBA1A56713725C433062B40E1C1A1AC2596A0C1F1AE28793
      A8B3088C67B96651E3672660F906FA9B85FEAE477F17A2BF9A09E7E2F077CF99
      30E1823F237F7F3E81FC81FCFBBFFFFB844FDEFEDD848F8E0F4D38393A3CE18F
      BFFAC5848FFFF5F5091FBD3132E1D4EF7E35E18FBFFDE5848F7F737CC2A9B77F
      33E17F9FF8B709C77EF4FD096FBE7060C2D8C84BF8DCC96109BFBC9C3CD9C28C
      69F2795CB1B90E371C5D87177C1A5F672257D075B8E1E83ABCE02ABCCE67B982
      AEC30D47D7E105A3EB7C862BE83ADC70741D5E7088D739872BE83ADC70741D5E
      30BACE24AEA0EB70C3D17578C1E83AFF812BE83ADC70741D5E30BACEB95C41D7
      E186A3EBF08243BCCE9F71055D871B8EAEC30B46D7E12B68741D6E38BA0E2F18
      5DE73F72C5BB3E0C49EEB8F5DA254B6F585C7FD7E4495DB9CE8C387952E1DE7C
      5B5B436B2ED3D4DED9DED67031096958536C6EEFCC143B73B962FBEAC993C87E
      AEB521DF92E9CCB53514DB9BD0F90D85FFBCA6BD654E537BEB9CC64EF5A0359D
      2D99E662B1636E5DDDDAB56BE7E4DB8AB9D59D0DC57C7BDBECB5ED9DEBE068F2
      1B68A335D7562C64AECDE621FA4BEDABBEF49596D65C36DF90CD754D9E3479D2
      1D37DF307FD9F225D72E45B7DB916F2AAEE9CC65D02DB4CD696CED983CA9B5A1
      706F063EC86E677B4BCB9A0EF530751F1F846EADA998EFCA299185A6F6356DC5
      8C3C79522C4322E65CB3E8E6C993844CC75A722D3183EE6C4DBE986B2D908078
      A65989925042B515D1C59598446675673EABECA05B9EBF7CC9D2C54BE08E0BC5
      86CE62D39ACE427B67BE2D9B5B9711264F22BBCA0DC4F0090B172F597443FDC2
      C5E88C96DCAA62B1BDA3A31D255A461084A884EEB133BFBA990A155338140E6D
      6C47E1AD245C8C45D371E56043B82C448598847EB9258F12BB33D784AE114797
      888A7202C524274F6A5CADA40BB9CBD902495A38B4A133D79049478564544CC6
      A382807869CE178BB942D170ABE9A8286931C6FB15E55854900CA7D1B727A4F1
      6DD3A71AEE3E817E3C26A899096793885834A606E293A8500004720F3F2A0A89
      E2D03CCA3563887A5C477BC71AF40F72A3B1BD339BEB5C9BCF169B33929A597A
      AA20BED13B807651D86AF48E6074F2AD0DAB7370B21A905BB50A7E279F6BC477
      D6962B1408CB8B6F5E7EF36D37D42F587C1BCAEAB5E8B2ED6B0D09AFA4BB2933
      0C491D4F45932C132901C2D8A48DA7A3491E1129319A440F87E1C6292246C568
      4A8E2653E6272E34411AB73674DE9BEB6C6A6F411A2125C5A4745A3446910727
      070888B8849C226C5F7F43FD32BB478EBB7964418AC6D9478ECB1066A209B19E
      E43C723C191552EC2B80DEAE5854443FB60ABDCF58037EA533DFD042F69B7370
      8D0C900BBB85E2FA16D029B04D1E933CDFD29B6EA8FFCA926BBF02AF3BFD4E43
      F8E26B6EBC76FE323D065E9E5866D1B5F5CB6F5876EDA2B9AA8201B5D3D4D001
      0A70AEF20DFAA7A9A5BD906B5C839EA16D6EA198255BA0875AF36DF9D6FC3738
      71125286EB2CE21219F2B29863E48CFA22343674C20DCD65F6274F4A660AEB0B
      38C474762AA31C693C82BA847A645A3D927E32CE71424C3D103D8DCD61827658
      BECDFA3094176A8ADF056A06E583AA3720AB0CC502C14FE4BC05A8B022D44445
      312A23052CAAA7525102C4004FADED9D1DE89756C30FE06D744C36D37A6F36B7
      AA614D4B91BC7A806EFBAA55851CA233418230B64A18FA816CBE2B8F548DA2B4
      247C79D0FC4A387301F568EA1AE80529E6D615B5775C96F15BE01777F2C086A0
      356DA82AD0D892CBEAA12949141250DEA09457707699F0B3059B9447E59580FE
      C36B9F30A5BDAED29D525ED9506E0C34AE96427089342AABD2F62924D329B4AA
      D0D8DE92A5D349538F6C6A09723299444983625AF2AB01D362A6D80099F8B535
      85627ED57AF4B0CD0D483FC24D912D26E59940485FFD4D52D3783E04392474CC
      269D45A413911615658997D028548AA610E5292AAD05ABB46E5F4BCE8AC35909
      72D6EACEF6351D547EA32A60033AADA9B549B971540B4065AC315B95407233DC
      28EDB7B408943C464DA9A6D022253440220929292AA0372A8668944C899440A1
      49549A4613692FA924A6E1B484804FB34CA656FDEEA99492A269C8339473715E
      6AA13B42F1E88EE878FA87512CFA611C0BE9662845B474534283C085120DD20D
      01C14F37C417BACB94EC31DDD069E8F6E134EB74D3EFDE906E8290C20927C52C
      120E0E80949362DC948368483A89204717B26AC22D4161CB3B82241BE8EDA814
      E7BD91285414A528AA648B92E029D9C8899272A265C291BB0EF9C53456304228
      98C568221695E3D164CC9442A8B62B42142865C7E4614A66915F306B69184D4B
      706901CA4D43510BCD9674A8452DFCA875D93BDF54F61AEA636A0A2F5D5F408F
      F3258808C023C651B4C4514A621C65C92B8EE8444939D11247E5B142E6915385
      750965CCBEB618833FF4A271B024B19212EB5C73516F5C2227CACA891549294E
      C523503A09324E2721C54D27889594584FE90427CACA8965AD7830ED9770D248
      226924F3D3482269247B4E2389A4911CF35C7A86954C6AFB2D9C644A91572EC6
      4FA61479E5629E9329455EB958CC73E52C6832415FC2FCC5F5CB962CFE1BBD33
      21813B139476AFD626CE14DBDB5B3A1ADA722D73F12774244010735C3CD3D49C
      6BBAB7B17DDD5CBCD1D990CDB743FFC1EA8635AB7373F12774197419F6E50C3E
      8E3D2B9931FC602AD3D2D08876F127B4FA8B9D0DE8A71A3AE7AA1BB889DFCC0B
      167057EA5CF8407BE8D61B1AE7A23FB41DCFE4B2F9E25CF8407B126AFAB7B6CF
      850FB497C83493BE28B89AB68522E44C173F229969C9178AF020CA370A4B6550
      3E3692A7533650689AA4947A38BD83D2369629200EF09DA91B28149E020102C7
      AB9920660AC52C4917750385C6516843714D81A49F1A2A29A170D3EAF90925A7
      A94410D1D3ADE90060E6922F1494CC34B34129B56FC9F4C4625A8DB279C4784C
      3BC89C3A7141ED0A877BD537518C48772AD1FD32282E8EB2A5A3053A7C51AE28
      1B285842D9C8094E64D0BBA177696908CB99C6F662333FE7E349A5B7CB40663C
      9569CCAF36BD21F1B41ACCFC8414C3EF0EDDABA56DA258418B2504730E11D52B
      5B5D234E1F6079194404793694FADA160A4F608CBBF2B9B573D50D142AE3411B
      1CAA6EA0D0A44295E18D965299CE3CCA70A04ADD40A1E94C6E1D4922E51BE902
      F4C6E61AB2286BC8170A11328516E8719A4BBEB0AAD2F4B841614B169DBC965A
      1C741F6A9B886C47B0144D99864352D1B4B91F98E854B6171887527DC0505117
      C59257D4B3F902D3472688725C141336CD5C78A0D5A060D1BD9A2BD929943EA8
      5103E903BF4675DEA008897442AABFAA45C6512B0835F3E5684AC479A5BD0881
      B30B55DDD35129114DA498FC12F1C80FD3718F5A4689203906C5377FD04AD154
      4CC9AA8C02C23005B7CCE545D15D744DE80BF0B64344B41F25D0954BE0B44E24
      A271219A8A45134926B113A819CA2636D41745FF891D8FE26659B95F8F988B86
      23F34AA00489C3386702A78BE1A5804088437F388E7D2FE8AA965A2D0A9E4DE9
      A82C46D362342598B2C9A4C3C4643415E48D889351AF1033695527BA0E3F4362
      EE320425400A27001EBDC5E98A074AF180721C9105BDF932E935C1610855141C
      C381FAE12407E5685286A74C0BD0EDC1C48A10292471A4320E693C20053DDA89
      681ABD2071ED714D9781C11174544A204721187021199804AD6B369630694789
      539A05D28DD0C289A33BEE6C5F8DB45B8124AC399C1C8F4A4E94E229621DD098
      5B9D6F53BAB8D075736D597D0735568AF9A686164C86FFB1D2AE701214BADC00
      AB54342599DE2DD338314E253641253C0EE62A4585382E4D4D29CA84933B9361
      185D8821166597291A6CF4596D8F9D555755A6AE5062A22A5132C15157714CAF
      8C232DD5554C807713772B5BA9AB243E0AEB36D2E11B4E5D0EF7234137473421
      9B5030E9AB047A1A330A32AA0C725848C4F1F035434322194DC4C657750EB7D4
      03A734146928F364DCFE706AE6C413419A390256F38940BA46EDA609FCDC624C
      828AA59022C667862797A3B22B058E5223E9E2C9C126030C7D62600901F78F5F
      DD18844A2494D4CA35F2E1D54C24B01624EF1D1D2F9282072525C4D32A1C254F
      7368E923C0BD094A0A892E5208153B49BF6C0851D03671DC4ED353880EA55340
      C6C5849042AA4DE6A5108A4FA6713CD8F4D1D506A84E75E6B36CE224FCF40CE0
      6758955F97CB36E55A5AD80E8342AE05856831749378557BD39A821643B7A2B5
      AB51637F12FD23D400201D6E18F353BA12CC97E15CC1EAE4967C1B58A7E24E82
      785A4A0950BE34AE664D4838DAD2EFAB4DD2CB589C423A1943E0814DBFA006D2
      3FA38631F6316AB041A33434865C5CA12BAAC3FA31190FCC8A5A094AC589244E
      4A288F4A45C1D82514F6B86B664D01DD021529A770642AE9A1106314BBB904C5
      61E60AAAC4D36F09125E8406EC2ADACAABA191B5FB6A682C34AE569208293404
      1718FC865BEB3261A22499C1E809FC9BA0E28C7448ABFDD338FFA1B731786922
      A2B2004C8BD0FBC32948859829C105DC4FE24F5D424D3041F40C3BB684EE4380
      315DB811490C35A12915AB576958E5ABC540FAF2C2F1805B6B7BE014879A2754
      7CB1558AC85A279B5B608904CF5217357E794DB0848C5F24FEEB6565F5E73AA9
      79E67A8AC544C9925D57DE6222964AEA350B9352875A843688115C332644DCE7
      85AB11125B8D40C58DA98E29C9FEDB75F023608283DB487A3D424669A084AA56
      51A4B9058923932695D2C0A1A385147A99A0D08EC118BE4412D770048EC1C57A
      523F82497E81BE3E138F53079D0F3A5D3B9F3D06E2E018B0F683638ACD6B5A1B
      95BA609ABC0412FA96B41F610E4085093E408E93EB33D1B244A2C13A014711F5
      2D6424C3BE08FBAB5BD677342B770EE55302DB36083A4EFA01062239C1D01313
      1E666043863401988DA6596590D4BB59ECABF329BE32E054E721B7B02E3054E7
      6535D4C088825E54E6432682411DBA73D4F44F883CC4503CA204E2E59467C0F0
      D5F1C9502A71E8820384343E02ECA8743644111A86A204769266B0E0B424B970
      DA8415CCF581C8641247BA874A4C42951E155E09DCA9E6032965C4B8FCA58BC4
      2B5D248BD285D49FF8A50B36F4535311FD929088EAB54743246490402E85EB40
      8648F446C3A9C998C9983066362654828CA683A18F489A2B6ADCAE152590FD61
      2A98FA7D2A54BD0D2A483752ECB02E45F971A6F7D0B184E5BE7F86B3ACE2C870
      8FE5252DA3E17A9691BA72C5A9D845D925341BA39AA928A331038E360691F129
      C5F622F8902DD2A48871A428C484B9D22C9ABA9F92B8261D6CD0967EC7A0EC23
      BDADA8088FB1EF11DC1D2A3CE3A8EA2827FCBC47D0F113970375339B5F1A2AB3
      25456F88BC2A611CE96611DD7D52C2FDA00C7C108B2A15100B0593A237F11D6A
      5637EA48E4E9A454D3B16812B50424090F8EB05A15C5A2561CC40A44F919D42A
      4CCB416D2B1C2D89662BED840BCD1A3BAB5ACFAA562BD50AA8109B46AA6E273A
      8D36DB0D538305BE6212184A1F07744B8BD01049264DEFAFB99303E9A7B4FF3E
      0EA4AE45ACDAFCBE2806C8D04B8BD581C0A75384215350A5696812253894C6A1
      AD878E803A977684F10704461BB3756DF80D59F98D64824B2EFE1559F9956442
      E9B226769CC18B5BA47990F693607EB26836DC11639C8135913BEEC11F5913D9
      91356C039D80A9498E436B90DF093233B42C836B0EE34CAA7D2C9BE6B305FF63
      0521E97B848720A833DB29D3DDE078C8E4059754F6183ED2A6F75B0AF87E079B
      09AC3D7E183D0850D9834E0D9C084937566D713190559B882A1251511C5F63CE
      BAFD7708090E5A10669BCA643E0353FD4F8739F88C6BE2B46AD66F23496E438A
      2BB7519A1EF3788AF4D903EFA6AA3AEEAD4F81B1068C9024CD95F5580CC7C7F1
      307D92749E91218CE01DB47828155E4498C9C5D6CAF5D4B5EF3A73970B1A95A6
      EA1FBC7C298B4E5881DC1F2A34C59865276C0A2A4AD41186EBE3ABA337DBAA17
      16CFD549909F10E3FC7EB2183906FF8848262837879405E87A51E86B86DE3431
      16AF40160830081D97ADF200F702C6A0875561C49C0729720490AA1D6197C76C
      F282852FFC02CC2E53CF678F91956352CA31BA6B87B05AA87178C9A212BA8944
      C264F1208A1C13345108D64215CEF47EBFB862C0960ADA3C5547D51C1BA952C2
      B625208969880508F8ED80B484E361689FD30A006756F8EA56A8C3F5511D03AE
      9FE4EB1AF8053802FD021CC1B643E3606B00AD0DD9AA192B2102A07F474C4593
      02BF311B07DB7DC44A3A8E0F29696FA1797A57295F5489F7A2A64AF1A29E897D
      49A2F2BA26CFBEAEA7E3EB5A921E2866EA6629470DB8EDB4B0470DE0F745322E
      A0196F9DE98306C68A98324AA4CEC42DA53938DF982DC1EDB4922D94BDEC386E
      10C7E6A409DCC8E0B6D88DEE64820F9580073030AA87812991F69228100B17EC
      E04DF75D933139CBA37C63703CDEA19355770726FF7570AFEB98383500DD22ED
      9D84EB754FB18A80DE08C6BA490BA71D35AAB620CA5CEB100C979324EDB025AE
      64EAA64EB86A4DC5DDCDCDA16D0F9AC37B04E85A4AA3C700E0629233F1A01003
      B70861260F35C73D8CF9B878922C6AB098A7F324DCCD3993F5A9BB06079B641E
      01F51412D60F61CFE8F1384BD4E52C1F481294320981A48C619A28044AB85E49
      E2ECA6891A0BEF10A608422B3C856E2ECE5AB0A2F436DBE9A502D8FB9FB5D30B
      CF4E2FCE9854C5C3B6D3A39C5804870C3A2750519C9438435049CE10543C6D35
      0425BB9ADCA50D4139CFEE82114229CE1F8292C01A2E41103177B74B49F05B8C
      EA463299FF6BE55A338089B0F2CA539E4382E705360E94D01B2F996B55A2A91E
      8D7DF405AA47A3FFC2381BEFA05DB2049F331CC3CE0E41158872DC6CF0649E6F
      2771E177EF38214EBABDABDE7102D47870D2C04C285501EAB149E2255284F968
      38D6AE58347ABA094563418E49D057C0697E08719EBB0B21E0FCF971E1EE0227
      09240D740540D218720D87C6A1444F2AB196B946F91CB2CC4EEA98E0790AEE5F
      64E5C653B20BD34351089AA7E3C48589944CE2A449801140CA94A79070A9144E
      38DCB8729FA7780A248CC1CAB4660DF145C503C9E04B16BAAC78EAD5B4608198
      D6663DFBF621104F8E874C851E2B481A707F6D52AF1274FA402C8C7FDAAB57BB
      1795EF432CF8E8A840B2559453FC6C4D734ACD80D92A8F8F52539449C6C5A1C0
      30656B5CF1AD1CC78D494FD98ADEF2180C2D404310AC6C546F6FA5ECC8430AD6
      D491978C7274AE80EBF2E6AA7F929DB387BBCA2C8DCF94D922E098AE0A8CBCB8
      F3F054C779D57A7F942FBF108CCF641BE3B338A7FF41F23F4F10B77B481FBBC1
      A58E8407150DE1CACD41035EB19C94D246AF3A22ED55470CCD4F91EA09B15A33
      5F71CA585AA35481D30E4DC8DCC15CD1422DC866B5A01BA5825E6BD60BC2345E
      DD24A1DE0AC476F16E349D2091461FED10C2F868872074E3C600727BC6B02ED6
      262241F0C437C8C6C13443D9D0C5AF76B8E29E9EA888D750D2632957BF789D01
      EC898E3D485F27835C4752AED38C6F99EAE7821E196C292A9A0EA07F0826A8E3
      DB499A0ED37E0A5C75E08352DAB548D39EAE370AE442A298E41D43FF649A5C0D
      D677E01CA9FF6A4AB9B5B472C52EE611259248B2608AA67E4D26C994944D0769
      3F9424D7496BD7313D5C5AC9B398CC3B847EB618B9169EDC6F3E527F3651B962
      5CC580CF5500C5445CAF9672784036AF2D2624F92E9EF8C303491C5EFEE101FF
      1DFD509A6207B6A178AD354EF9D7DCBC3677AE69513ACCA0344B418775022BB3
      66AAB3598845A10B1BC6A0623280469D244761580A3A49C1695217759644A2F0
      6C3A845D2EBB1A8F25817EC39952A010FAFFEF23884E}
  end
  object mnu_main: TspSkinMainMenu
    SkinData = SknDat_main
    Left = 472
    object mnu_file: TMenuItem
      Caption = #25628#32034'(&F)'
      object mnu_openskn: TMenuItem
        Caption = #36873#25321#30382#32932
        ShortCut = 16465
        OnClick = mnu_opensknClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnu_startsearch: TMenuItem
        Caption = #24320#22987#25628#32034'(&P)'
        ShortCut = 16456
        OnClick = btn_searchClick
      end
      object P1: TMenuItem
        Caption = #20572'   '#27490'(&P)'
        ShortCut = 16467
        OnClick = P1Click
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object mnu_exit: TMenuItem
        Caption = #36864'   '#20986'(&X)'
        ShortCut = 27
        OnClick = mnu_exitClick
      end
    end
  end
  object OpenDialog1: TspSkinOpenDialog
    SkinData = SknDat_main
    CtrlSkinData = SknDat_main
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    Title = 'Open file'
    Filter = 'ini'#25991#20214'(*.ini)|*.ini'
    FilterIndex = 0
    Left = 536
  end
  object HttpScan1: THttpScan
    TimeOut = 300
    FileOfResults = 'c:\results.txt'
    LeavesFirst = True
    Agent = 'Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)'
    HttpPort = 80
    Retries = 3
    LinkScan = scanAllLinks
    LinkReport = reportAllLinks
    DepthSearchLevel = 3
    TypeFilterEnabled = False
    KeywordsFilterEnabled = True
    KeywordsLimiterEnabled = True
    ProxyType = PROXY_DEFAULT
    ProxyPort = 80
    MaxQueueSize = 5000
    SeekRobotsTxt = False
    ConcurrentDownloads = 6
    OnLinkFound = HttpScan1LinkFound
    OnPageReceived = HttpScan1PageReceived
    OnUpdatedStats = HttpScan1UpdatedStats
    Left = 576
  end
  object SaveDialog1: TspSkinSaveDialog
    SkinData = SknDat_main
    CtrlSkinData = SknDat_main
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    Title = 'Save file'
    Filter = #25991#26412#25991#20214'(*.txt)|*.txt'
    FilterIndex = 0
    Left = 622
    Top = 4
  end
  object mnu_pop_listbox: TspSkinPopupMenu
    SkinData = SknDat_main
    Left = 672
    Top = 65528
    object pop_browser: TMenuItem
      Caption = #27983'  '#35272'(&W)'
      OnClick = pop_browserClick
    end
    object mnu_pop_list_copy: TMenuItem
      Caption = #22797'  '#21046'(&C)'
      OnClick = mnu_pop_list_copyClick
    end
    object mnu_pop_clearlistbox: TMenuItem
      Caption = #28165#12288#38500'(&L)'
      OnClick = mnu_pop_clearlistboxClick
    end
    object mnu_pop_listsave: TMenuItem
      Caption = #20445'  '#23384'(&S)'
      OnClick = mnu_pop_listsaveClick
    end
  end
end
