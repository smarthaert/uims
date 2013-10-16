object SetForm: TSetForm
  Left = 431
  Top = 250
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #27983#35272#22120' '#36873#39033
  ClientHeight = 344
  ClientWidth = 590
  Color = 15263976
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 590
    Height = 344
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 590
      Height = 344
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      OnChanging = PageControl1Changing
      object TabSheet1: TTabSheet
        Caption = #24120#35268
        object SBOKCG: TSpeedButton
          Left = 480
          Top = 264
          Width = 73
          Height = 33
          Caption = #30830#23450#20462#25913
          OnClick = SBOKCGClick
        end
        object GroupBox2: TGroupBox
          Left = 24
          Top = 16
          Width = 217
          Height = 281
          Caption = #21551#21160#65306
          TabOrder = 0
          object CBLoadBrowserHis: TCheckBox
            Left = 16
            Top = 32
            Width = 137
            Height = 17
            Caption = #36733#20837#27983#35272#21382#21490#35760#24405
            Checked = True
            State = cbChecked
            TabOrder = 3
            OnClick = CBLoadBrowserHisClick
          end
          object CBLoadFavorite: TCheckBox
            Left = 16
            Top = 56
            Width = 137
            Height = 17
            Caption = #36733#20837#33756#21333#25910#34255#22841#20869#23481
            Checked = True
            State = cbChecked
            TabOrder = 2
            OnClick = CBLoadFavoriteClick
          end
          object Panel1: TPanel
            Left = 2
            Top = 142
            Width = 213
            Height = 137
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object Label12: TLabel
              Left = 24
              Top = 24
              Width = 72
              Height = 12
              Caption = #21551#21160#26102#25171#24320#65306
            end
            object RBOpenHome: TRadioButton
              Left = 24
              Top = 96
              Width = 49
              Height = 17
              Caption = #20027#39029
              TabOrder = 1
              OnClick = RBOpenHomeClick
            end
            object RBOpenDefault: TRadioButton
              Left = 24
              Top = 72
              Width = 81
              Height = 17
              Caption = #40664#35748
              Checked = True
              TabOrder = 2
              TabStop = True
              OnClick = RBOpenDefaultClick
            end
            object RBOpenNull: TRadioButton
              Left = 24
              Top = 48
              Width = 65
              Height = 17
              Caption = #26080
              TabOrder = 0
              OnClick = RBOpenNullClick
            end
            object EditDefaultPage: TEdit
              Left = 72
              Top = 92
              Width = 138
              Height = 20
              MaxLength = 30
              TabOrder = 3
              OnChange = EditDefaultPageChange
            end
          end
          object CBLoadLastTime: TCheckBox
            Left = 16
            Top = 80
            Width = 161
            Height = 17
            Caption = #25552#31034#36733#20837#19978#27425#27983#35272#30340#20869#23481
            Checked = True
            State = cbChecked
            TabOrder = 4
            OnClick = CBLoadLastTimeClick
          end
          object CBCreateOneLabel: TCheckBox
            Left = 16
            Top = 104
            Width = 153
            Height = 17
            Caption = #21551#21160#21518#21019#24314#19968#20010#26032#26631#31614
            Checked = True
            Enabled = False
            State = cbChecked
            TabOrder = 0
            OnClick = CBCreateOneLabelClick
          end
        end
        object GroupBox4: TGroupBox
          Left = 240
          Top = 16
          Width = 217
          Height = 281
          Caption = #36864#20986#65306
          TabOrder = 1
          object Label18: TLabel
            Left = 16
            Top = 64
            Width = 72
            Height = 12
            Caption = #36864#20986#26102#28165#38500#65306
          end
          object CBCleanAddress: TCheckBox
            Left = 16
            Top = 144
            Width = 153
            Height = 17
            Caption = #28165#38500#22320#22336#26639#25152#26377#35760#24405
            TabOrder = 1
            OnClick = CBCleanAddressClick
          end
          object CBCleanCache: TCheckBox
            Left = 16
            Top = 192
            Width = 97
            Height = 17
            Caption = #28165#38500#32531#23384
            TabOrder = 2
            OnClick = CBCleanCacheClick
          end
          object CBCleanHistory: TCheckBox
            Left = 16
            Top = 168
            Width = 113
            Height = 17
            Caption = #28165#38500#27983#35272#21382#21490#35760#24405
            TabOrder = 3
            OnClick = CBCleanHistoryClick
          end
          object CBCleanCookies: TCheckBox
            Left = 16
            Top = 216
            Width = 105
            Height = 17
            Caption = #28165#38500' Cookies'
            TabOrder = 4
            OnClick = CBCleanCookiesClick
          end
          object CBCleanRecent: TCheckBox
            Left = 16
            Top = 240
            Width = 145
            Height = 17
            Caption = #28165#38500#26368#36817#27983#35272#30340#25991#26723' '
            TabOrder = 0
            OnClick = CBCleanRecentClick
          end
          object CBExitCleanAllHistory: TCheckBox
            Left = 16
            Top = 96
            Width = 145
            Height = 17
            Caption = #28165#38500#25152#26377#27983#35272#30340#35760#24405
            TabOrder = 5
            OnClick = CBExitCleanAllHistoryClick
          end
          object ComboBox1: TComboBox
            Left = 16
            Top = 24
            Width = 81
            Height = 20
            Enabled = False
            ItemHeight = 12
            TabOrder = 6
            Text = #32769#26495#38190
          end
          object HotKey1: THotKey
            Left = 97
            Top = 24
            Width = 113
            Height = 19
            HotKey = 32833
            TabOrder = 7
            OnChange = HotKey1Change
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #31383#21475
        ImageIndex = 1
        object GroupBox1: TGroupBox
          Left = 376
          Top = 8
          Width = 177
          Height = 289
          Caption = #29366#24577#26639#65306
          TabOrder = 0
          object Label1: TLabel
            Left = 8
            Top = 24
            Width = 96
            Height = 12
            Caption = #29366#24577#26639#26174#31034#26684#24335#65306
          end
          object Label2: TLabel
            Left = 8
            Top = 72
            Width = 30
            Height = 12
            Caption = 'A'#65306#24180
          end
          object Label3: TLabel
            Left = 8
            Top = 88
            Width = 30
            Height = 12
            Caption = 'B'#65306#26376
          end
          object Label4: TLabel
            Left = 8
            Top = 104
            Width = 30
            Height = 12
            Caption = 'C'#65306#26085
          end
          object Label5: TLabel
            Left = 8
            Top = 120
            Width = 30
            Height = 12
            Caption = 'D'#65306#26102
          end
          object Label6: TLabel
            Left = 8
            Top = 136
            Width = 30
            Height = 12
            Caption = 'E'#65306#20998
          end
          object Label7: TLabel
            Left = 8
            Top = 152
            Width = 30
            Height = 12
            Caption = 'F'#65306#31186
          end
          object Label8: TLabel
            Left = 8
            Top = 168
            Width = 42
            Height = 12
            Caption = 'G'#65306#26143#26399
          end
          object Label9: TLabel
            Left = 8
            Top = 216
            Width = 96
            Height = 12
            Caption = 'J'#65306'CPU'#20351#29992#30334#20998#27604
          end
          object Label10: TLabel
            Left = 8
            Top = 200
            Width = 126
            Height = 12
            Caption = 'I'#65306#29289#29702#20869#23384#20351#29992#30334#20998#27604
          end
          object Label11: TLabel
            Left = 8
            Top = 184
            Width = 60
            Height = 12
            Caption = 'H'#65306' ['#31354#26684']'
          end
          object Label13: TLabel
            Left = 8
            Top = 232
            Width = 114
            Height = 12
            Caption = 'K'#65306#21097#20313#29289#29702#20869#23384'(MB)'
          end
          object Label14: TLabel
            Left = 8
            Top = 248
            Width = 78
            Height = 12
            Caption = 'L'#65306#26412#26426'IP'#22320#22336
          end
          object SBStatusBarSet: TSpeedButton
            Left = 56
            Top = 264
            Width = 65
            Height = 22
            Caption = #35774#23450
            OnClick = SBStatusBarSetClick
          end
          object EStatusBar: TEdit
            Left = 8
            Top = 40
            Width = 153
            Height = 20
            TabOrder = 0
            Text = 'A-B-C_D:E:F_G'
            OnChange = EStatusBarChange
          end
        end
        object GroupBox7: TGroupBox
          Left = 16
          Top = 8
          Width = 361
          Height = 289
          Caption = #24120#35268#35774#32622#65306
          TabOrder = 1
          object Panel2: TPanel
            Left = 8
            Top = 32
            Width = 329
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object Label24: TLabel
              Left = 8
              Top = 3
              Width = 84
              Height = 12
              Caption = #25171#24320#26032#39029#38754#26102#65306
            end
            object RBAtCurentPage: TRadioButton
              Left = 104
              Top = 0
              Width = 97
              Height = 17
              Caption = #40664#35748#24403#21069#39029#38754
              TabOrder = 0
              OnClick = RBAtCurentPageClick
            end
            object RBGoToNewPage: TRadioButton
              Left = 216
              Top = 0
              Width = 89
              Height = 17
              Caption = #36716#21040#26032#39029#38754
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = RBGoToNewPageClick
            end
          end
          object Panel3: TPanel
            Left = 8
            Top = 64
            Width = 329
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object Label25: TLabel
              Left = 8
              Top = 3
              Width = 120
              Height = 12
              Caption = #22312#25176#30424#26159#21542#21019#24314#22270#26631#65306
            end
            object RBInstallTrayIconON: TRadioButton
              Left = 152
              Top = 0
              Width = 57
              Height = 17
              Caption = #21019#24314
              TabOrder = 0
              OnClick = RBInstallTrayIconONClick
            end
            object RBInstallTrayIconNOON: TRadioButton
              Left = 224
              Top = 0
              Width = 73
              Height = 17
              Caption = #19981#21019#24314
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = RBInstallTrayIconNOONClick
            end
          end
          object Panel8: TPanel
            Left = 8
            Top = 224
            Width = 329
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            object Label23: TLabel
              Left = 8
              Top = 3
              Width = 72
              Height = 12
              Caption = #26631#31614#26639#25918#32622#65306
            end
            object RBTabAt0: TRadioButton
              Left = 112
              Top = 0
              Width = 57
              Height = 17
              Caption = #22312#19978
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = RBTabAt0Click
            end
            object RBTabAt1: TRadioButton
              Left = 192
              Top = 0
              Width = 57
              Height = 17
              Caption = #22312#19979
              TabOrder = 1
              OnClick = RBTabAt1Click
            end
          end
          object PanelAppendPage: TPanel
            Left = 8
            Top = 96
            Width = 337
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 3
            object Label32: TLabel
              Left = 8
              Top = 3
              Width = 192
              Height = 12
              Caption = #25171#24320#30340#26032#39029#38754#22312#24403#21069#39029#38754#21518#38754#36861#21152#65306
            end
            object RBAppenPageYes: TRadioButton
              Left = 224
              Top = 0
              Width = 49
              Height = 17
              Caption = #26159
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = RBAppenPageYesClick
            end
            object RBAppenPageNo: TRadioButton
              Left = 288
              Top = 0
              Width = 41
              Height = 17
              Caption = #21542
              TabOrder = 1
              OnClick = NoClick
            end
          end
          object Panel6: TPanel
            Left = 8
            Top = 160
            Width = 337
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 4
            object Label33: TLabel
              Left = 8
              Top = 3
              Width = 180
              Height = 12
              Caption = #20851#38381#39029#38754#26159#21542#20445#30041#26368#21518#19968#20010#26631#31614#65306
            end
            object RBHoldOneYes: TRadioButton
              Left = 200
              Top = 0
              Width = 49
              Height = 17
              Caption = #26159
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = RBHoldOneYesClick
            end
            object RBHoldOneNo: TRadioButton
              Left = 272
              Top = 0
              Width = 41
              Height = 17
              Caption = #21542
              Enabled = False
              TabOrder = 1
              OnClick = RBHoldOneNoClick
            end
          end
          object Panel18: TPanel
            Left = 8
            Top = 192
            Width = 345
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 5
            object Label36: TLabel
              Left = 8
              Top = 3
              Width = 96
              Height = 12
              Caption = #40736#26631#21491#20987#26631#31614#26102#65306
            end
            object RBCRCurrentNo: TRadioButton
              Left = 224
              Top = 0
              Width = 49
              Height = 17
              Caption = #24120#35268
              TabOrder = 0
              OnClick = RBCRCurrentNoClick
            end
            object RBCloseOnly: TRadioButton
              Left = 136
              Top = 0
              Width = 65
              Height = 17
              Caption = #20165#20851#38381
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = RBCloseOnlyClick
            end
          end
          object Panel5: TPanel
            Left = 8
            Top = 128
            Width = 337
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 6
            object Label37: TLabel
              Left = 8
              Top = 0
              Width = 96
              Height = 12
              Caption = #20851#38381#39029#38754#21518#36716#21040#65306
            end
            object RBCloseGoTab1: TRadioButton
              Left = 144
              Top = 0
              Width = 73
              Height = 17
              Caption = #21069#19968#39029#38754
              TabOrder = 0
              OnClick = RBCloseGoTab1Click
            end
            object RBCloseGoTab2: TRadioButton
              Left = 240
              Top = 0
              Width = 81
              Height = 17
              Caption = #21518#19968#39029#38754
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = RBCloseGoTab2Click
            end
          end
          object Panel7: TPanel
            Left = 8
            Top = 256
            Width = 329
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 7
            object Label39: TLabel
              Left = 8
              Top = 3
              Width = 120
              Height = 12
              Caption = #24635#26159#20351#29992#24403#21069#30340#26631#31614#65306
            end
            object RBNewTabY: TRadioButton
              Left = 200
              Top = 0
              Width = 41
              Height = 17
              Caption = #26159
              TabOrder = 0
              OnClick = RBNewTabYClick
            end
            object RBNewTabN: TRadioButton
              Left = 272
              Top = 0
              Width = 41
              Height = 17
              Caption = #21542
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = RBNewTabNClick
            end
          end
        end
      end
      object TabSheetButton: TTabSheet
        Caption = #26631#20934#25353#38062
        ImageIndex = 4
        object GroupBox10: TGroupBox
          Left = 16
          Top = 16
          Width = 545
          Height = 289
          Caption = #33258#23450#20041#24037#20855#26639#25353#38062#65306
          TabOrder = 0
          object Label40: TLabel
            Left = 16
            Top = 32
            Width = 240
            Height = 12
            Caption = #30446#21069#21482#25552#20379#20004#20010#24037#20855#26639#25353#38062#30340#33258#23450#20041#26367#25442#21151#33021
            Visible = False
          end
          object Label41: TLabel
            Left = 16
            Top = 96
            Width = 48
            Height = 12
            Caption = #23558#40664#35748#30340
            Visible = False
          end
          object SpeedButton12: TSpeedButton
            Left = 72
            Top = 80
            Width = 41
            Height = 33
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC0C5C6A19997C3A1
              8EAE8F8C83756FD5A796FFD7D0D6A694788084CDD1D1898F92CACCCCC2C1C1FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC0C5C6D6BBB3D9A493FFDA
              D3FFB7B7C3B9B1FEB4B5FFD4CAFFBDBD6B5551AC8B86DD9A89263031BAC0BFC1
              C1C1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1C7CAA499957E706ABFA190FFD9
              D0F4B0AFFFDACFF4B0AFFFD7CCF5B3B1FFBBBAFFDBD1FFDCD4E7B09E9A9FA2C3
              C3C3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5C29B88D9A998D9A999D0A695F9B4
              B4F6B6B4F5B3B1F6B6B4F5B3B1F6B6B4F6B6B4F5B3B1F9B3B4CA8F7EC1C9CAC4
              C9CAC4C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC2C4D9A594FDB6B8FFDFD6F9B5B5F6B6
              B4F6B6B4FCB4B2FCB4B2FCB4B2FBB6B4FAB7B7F5B3B1FFE2D8A689846C7C8098
              5F5B959B9DC4C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5BC9B87FFC0C1EA817EF6B8B6F6B6
              B4FFB4B3B2C2C3B9C1C1B7C2C3CAB5ACD0A28FFEBDBEEA807DFFBFBDFFC0BDFF
              CAC8253230CCCCCDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBCC2C4D2BEB8C08C7CFCBDBDEC8481FFBD
              BEC5B2A8BEC1C2FF00FFFF00FFBCC2C4CEB6AFD1A493FBC0C0F6B8B6ED8582F1
              B4B4D69381BEC4C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC1C2D3BBB3A28480D4AE9CF08684F8BAB8C790
              7EC7D5D7BFBEBEFF00FFFF00FFFF00FFBDC4C7BC9D89F78D8CED8885F2B6B3FE
              8B89E0DED6BDBEBFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC4C6C88C7CFFC2C2FABBBBF7BEBCFFC2C19162
              60C2C7C8FF00FFFF00FFFF00FFFF00FFBDBEBFDED5CEC28E7EFDC2C1FFC4C264
              5956737D82CDCECDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC4C6C99180F58C8CEE8F8CEE8F8CFA9491755F
              5BC8CBCBFF00FFFF00FFFF00FFFF00FFFF00FFBCC2C5BFA391F38D8CEE8F8CFF
              9B99AD70677C8589FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC1C2CFB8B1D3A996F78F8FEF9491FB98957460
              5DB8C2C0C1C1C1FF00FFFF00FFFF00FFFF00FFBFC3C5BFA391F49290EF9491EF
              9491FF9B997A615DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBEC1C2BCC9CFB8AA94F49290F69794AF76
              6E7D8286C9C9C8FF00FFFF00FFFF00FFFF00FFBEC4C6CA9383F39391EF9491F6
              9794FB8E8CA5A29DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC3C6C2A38FDD666AF19794F19794EC74
              762F4440B9BDC9C4C3C2FF00FFFF00FFFF00FFBFCACCC49584F39391F69794A1
              6E67D6C9C0C0C5C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBDBFC1D8C7BAC89183F89A97EF9491F19794F89C
              99C162602E3E3CC4CAC9C8CBCBC4C3C3C2CBCCA68C85FA9391EF9491FA9D9A91
              5552795D5AC8CBCBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC3C6BFA28EDD6265F99591D6696CF39B
              97FEA09DC7756A2D44437E5F5B91AEACAD938CE36D6FF39B97F19794D46D6EFF
              A5A1735D5CB3BCBBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDBEBFE0D1C8B9C7C8B8CACCC99C8ADB70
              72D77171FCA29EE97878EA797AB46F63E47476DC7878D77171F99B9ADB7072DB
              6D71C08C6AC2C7CAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBDBEBFFF00FFBCC6C8C99C8ADE73
              75DC7878D97474DC7878DC7878E17A7BDC7878DC7878E1777AB59878CFA090FF
              8B89BACBCEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBEC1C2D0BAAFE2666BE078
              79DC7878DE7274E07578DC7878C75959DF7678DD7A7ACE5A5B9A59586E7D83C1
              CCCCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBDC4C7C4A892B266
              5CE6696CBEAD9BB79A7BCB5558DF7779C9A693E06E71DF7778B4655BDAC1B7BE
              C1C2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5C0C9
              CABAC8CAD9CFC3B25F58E77376B0675CAD8F8CBFAA94FE8887ECE2D6BABFC1FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFBBBFC2D8CDC0C9B8B0F0DED2BDC3C5BFC3C5BAC5C5BBBEBFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFBDBFC1BEC1C2BBBEBFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            Visible = False
          end
          object SpeedButton13: TSpeedButton
            Left = 336
            Top = 80
            Width = 41
            Height = 33
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE6E3E58C8C8C868686B7B6B7FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE4E2E3959595818181B1B0B0FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0D8EFE8E8EFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBBBB8C8C8C7E7E7EDBD9
              D9FF00FFFF00FFFF00FFFF00FFFF00FF97AEEB658BE77B9EECFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFE5E2E3FF00FFFF00FFFF00FFFF00FFAEADAE9292928C8C8CB4B3
              B3FF00FFFF00FFFF00FFFF00FF92AAEB6A8FE8769BEC769FEF82AAF3FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFA5A5A5D6D3D4FF00FFFF00FFFF00FF9F9F9F979797919191B8B6
              B5FF00FFFF00FFFF00FF93ABEB6A8FE8759AEC79A1F07CA6F37CAAF589B4F7FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFB9B9B9A5A5A5C4C3C4BCBBBBA9A8A99F9F9F9C9C9C959595BAB7
              B3E3E3EBCAD3EE9FB5ED6A8EE8759AEC79A0F07CA6F37FABF583B2F883B5FA8F
              BEFBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDCDADBB2B2B2AFAFAFABABABA9A9A9A4A4A4A0A0A09E9D988B91
              A17E9DE477A0F17DACF678A0EF78A0EF7CA4F380ACF682B1F885B5FB88BBFD88
              BEFF93C5FEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD0CFCFB0B0B0ADADADA9A9A9A5A5A5A6A5A0969DAD7596
              E478A3F383B2F98DC2FF89BDFE7CA6F3789FEF79A1F086B8FC88BBFD8CBFFF8F
              C3FF91C6FF9DCDFEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD9D7D8D6D5D5D5D4D1A1A7B57596E479A2
              F383B2F98ABFFF97CBFF97CAFF87B7FC7FAAF5759AED7CA5F28CC1FF90C4FF93
              C8FF97CBFF97CBFFA4D1FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF809FE977A2F283B2
              F98BBEFF98CBFF8FC3FF92C5FF92C6FF87B9FC80ABF57599EC7EAAF497CAFF97
              CBFF99CCFF94C9FFD4E4F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8BA8ED77A0F183B2F98ABF
              FF98CCFF8EC3FF779EEE86B8FC9ACDFF92C5FF87B9FC7FABF57499EC80ADF79A
              CEFF94CAFFD0E2F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9AB2EE749FEF83B2F98ABFFF99CC
              FF8FC3FF789FEF7DA7F285B5FB95C9FF9ACEFF92C6FF88BAFC7FABF57498EC7E
              ACF7D0E4F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAAC3F27DAEF88CBFFF98CCFF8EC3
              FF779EEE7DA8F386B8FB91C5FF98CBFF8ABEFF98CBFF92C6FF88B8FD7FABF574
              99ECDCDFEEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4CBFD98CBFF8DC2FF789E
              EE7DA8F386B6FB91C5FF9ACDFF82B1F7769DED89BDFE99CDFF91C6FF86B9FC7E
              AAF5DADFF1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCBDCF6799FEE7CA7
              F386B6FB90C4FF9ACEFF83B0F8779CEE81AEF788BBFD98CBFF99CEFF94C6FFC5
              D9F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA0C0F57EB2
              FB90C4FF9ACEFF83B2F8779CEE81B0F789BCFE96C9FF93C7FB95AEC897A8BCB6
              B6B8B5B3B2D4D2D3EEEAEBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAED2
              FC9ACDFF82B1F8779CEE81AEF789BCFE94C8FF94C9FD9EA8B29C979397949291
              91908B8B8B808080B1B0B1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFCAD9F3789DEE81AEF68ABDFE91C7FF9DCEFEA7B1BBA4A29EA0A0A09C9C9C97
              97979292928C8C8C808080BFBDBDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FF9BBFF784B9FE90C6FFABD5FDEDEDEFD6D3D2A5A5A5A4A4A4A0A0A0A0
              9F9FAFAEAEBAB9BA939393848383FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFB7D7FBB7D9FCEDEDEFEDEAECD6D4D4A9A9A9A9A9A9AAAAAAFF
              00FFFF00FFFF00FFE5E3E38B8B8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD8D6D7ADADADABABABBCBBBBFF
              00FFFF00FFFF00FFFF00FFE5E3E4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE9E7E8B0B0B0AFAFAFC5C4C4FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0D0D0B1B1B1A6A6A6D7
              D4D5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD8D7D7BABABAA6
              A5A5E8E5E6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            Visible = False
          end
          object Label42: TLabel
            Left = 120
            Top = 96
            Width = 48
            Height = 12
            Caption = #26367#25442#20026#65306
            Visible = False
          end
          object Label43: TLabel
            Left = 280
            Top = 96
            Width = 48
            Height = 12
            Caption = #23558#40664#35748#30340
            Visible = False
          end
          object Label44: TLabel
            Left = 384
            Top = 96
            Width = 54
            Height = 12
            Caption = ' '#26367#25442#20026#65306
            Visible = False
          end
          object BToolReplace1010: TSpeedButton
            Tag = 10
            Left = 72
            Top = 128
            Width = 33
            Height = 33
            Hint = 'TOB'#36873#39033
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC0C5C6A19997C3A1
              8EAE8F8C83756FD5A796FFD7D0D6A694788084CDD1D1898F92CACCCCC2C1C1FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC0C5C6D6BBB3D9A493FFDA
              D3FFB7B7C3B9B1FEB4B5FFD4CAFFBDBD6B5551AC8B86DD9A89263031BAC0BFC1
              C1C1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1C7CAA499957E706ABFA190FFD9
              D0F4B0AFFFDACFF4B0AFFFD7CCF5B3B1FFBBBAFFDBD1FFDCD4E7B09E9A9FA2C3
              C3C3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5C29B88D9A998D9A999D0A695F9B4
              B4F6B6B4F5B3B1F6B6B4F5B3B1F6B6B4F6B6B4F5B3B1F9B3B4CA8F7EC1C9CAC4
              C9CAC4C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC2C4D9A594FDB6B8FFDFD6F9B5B5F6B6
              B4F6B6B4FCB4B2FCB4B2FCB4B2FBB6B4FAB7B7F5B3B1FFE2D8A689846C7C8098
              5F5B959B9DC4C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5BC9B87FFC0C1EA817EF6B8B6F6B6
              B4FFB4B3B2C2C3B9C1C1B7C2C3CAB5ACD0A28FFEBDBEEA807DFFBFBDFFC0BDFF
              CAC8253230CCCCCDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBCC2C4D2BEB8C08C7CFCBDBDEC8481FFBD
              BEC5B2A8BEC1C2FF00FFFF00FFBCC2C4CEB6AFD1A493FBC0C0F6B8B6ED8582F1
              B4B4D69381BEC4C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC1C2D3BBB3A28480D4AE9CF08684F8BAB8C790
              7EC7D5D7BFBEBEFF00FFFF00FFFF00FFBDC4C7BC9D89F78D8CED8885F2B6B3FE
              8B89E0DED6BDBEBFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC4C6C88C7CFFC2C2FABBBBF7BEBCFFC2C19162
              60C2C7C8FF00FFFF00FFFF00FFFF00FFBDBEBFDED5CEC28E7EFDC2C1FFC4C264
              5956737D82CDCECDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC4C6C99180F58C8CEE8F8CEE8F8CFA9491755F
              5BC8CBCBFF00FFFF00FFFF00FFFF00FFFF00FFBCC2C5BFA391F38D8CEE8F8CFF
              9B99AD70677C8589FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC1C2CFB8B1D3A996F78F8FEF9491FB98957460
              5DB8C2C0C1C1C1FF00FFFF00FFFF00FFFF00FFBFC3C5BFA391F49290EF9491EF
              9491FF9B997A615DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBEC1C2BCC9CFB8AA94F49290F69794AF76
              6E7D8286C9C9C8FF00FFFF00FFFF00FFFF00FFBEC4C6CA9383F39391EF9491F6
              9794FB8E8CA5A29DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC3C6C2A38FDD666AF19794F19794EC74
              762F4440B9BDC9C4C3C2FF00FFFF00FFFF00FFBFCACCC49584F39391F69794A1
              6E67D6C9C0C0C5C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBDBFC1D8C7BAC89183F89A97EF9491F19794F89C
              99C162602E3E3CC4CAC9C8CBCBC4C3C3C2CBCCA68C85FA9391EF9491FA9D9A91
              5552795D5AC8CBCBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC3C6BFA28EDD6265F99591D6696CF39B
              97FEA09DC7756A2D44437E5F5B91AEACAD938CE36D6FF39B97F19794D46D6EFF
              A5A1735D5CB3BCBBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDBEBFE0D1C8B9C7C8B8CACCC99C8ADB70
              72D77171FCA29EE97878EA797AB46F63E47476DC7878D77171F99B9ADB7072DB
              6D71C08C6AC2C7CAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBDBEBFFF00FFBCC6C8C99C8ADE73
              75DC7878D97474DC7878DC7878E17A7BDC7878DC7878E1777AB59878CFA090FF
              8B89BACBCEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBEC1C2D0BAAFE2666BE078
              79DC7878DE7274E07578DC7878C75959DF7678DD7A7ACE5A5B9A59586E7D83C1
              CCCCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBDC4C7C4A892B266
              5CE6696CBEAD9BB79A7BCB5558DF7779C9A693E06E71DF7778B4655BDAC1B7BE
              C1C2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5C0C9
              CABAC8CAD9CFC3B25F58E77376B0675CAD8F8CBFAA94FE8887ECE2D6BABFC1FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFBBBFC2D8CDC0C9B8B0F0DED2BDC3C5BFC3C5BAC5C5BBBEBFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFBDBFC1BEC1C2BBBEBFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1010Click
          end
          object BToolReplace1012: TSpeedButton
            Tag = 12
            Left = 104
            Top = 128
            Width = 33
            Height = 33
            Hint = #22797#21046
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE6E3E4E1DDDFDBD8D9D9D6D8D9D6D8D9D6
              D8D9D6D8D9D6D8D9D6D8D9D6D8D9D5D8D9D5D8D9D5D8D9D5D7D9D5D7DAD7D9E0
              DCDEE6E3E4EAE7E8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD3CFD0C2BFC1B7B4B6B2AFB0B1AFB0B1AF
              B08E615F8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8D5E5C8B
              5C5B8B5C5B8B5C5B8B5C5B8B5C5BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA1AFB47E98A07E98A07E98A07E98A07E98A07E98
              A0B39790E9E2DCFFF6E9FFF2E5FFEFDFFFEDD9FFEAD3FFE8CFFFE5CAFADFC3FF
              DEBCFFDCB8FFDAB4FFD0C5906260FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFA7B4BA7E98A070CDE665C6E25ABFDF4FB7DB44B0D73AAA
              D3B5A39CEFEAE9FFFDFAFFFBF6FFF8F2FFF7EEFFF4E8FFF1E3FFECDAF5E3D0FF
              E4C8FFE3C6FFE0C2FFD2C9986B69FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A084DAED79D4E96FCDE564C5E259BEDE4EB7DB44B0
              D7B6ADA4EEF0EFF1F9FCF1F9FBF0F6F9F0F5F5F0F4F3F0F0EBF2EAE2E7E3DBF0
              E3D3F7E2CDFAE3CBFDC8C2A27977FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A08EE1F084DAEC78D3E96ECCE564C5E158BEDE4DB7
              DAC7B4A4F7F4F3C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5FD
              DED0FFBEBEFFAFAFFFA1A1A17572FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A097E6F28DE0F082DAEC78D2E96DCBE462C4E157BC
              DDCBB8A5F9F7F5FFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFCF8FEF9F2F4F2EDE6
              BEABE5A79AE59E91E4988BA27674FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0A7F1F89EEBF594E5F28BDFEE81D8EB76D1E86BCA
              E4D1BCA8FAF8F6C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5F6F0E7B2
              8074B28074B28074B28074A37875FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0ADF5FAA6F1F79EEBF594E5F18ADEEE80D7EB75D0
              E7D4C0A9FBF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFBF8FFF8F1F6F3EDB2
              8074FFB85CE1A36ACD9A81FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0B9FDFEB3F9FCACF5FAA4F0F79CEAF592E3F188DD
              EDDAC4ACFDFBF8C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5F6F5F1B2
              8074E4AD81D29F83D9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFB8FCFDB3F9FCABF4FAA3EFF79BE9F491E3
              F1DEC7ADFEFBF9FEFEFEFAFAFAF8F8F8F7F7F7F5F5F5F2F2F1EFEDEBE6E9E9B2
              8074D7A485B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFB8FCFEB2F8FCABF3F9A3EEF69AE9
              F3DCBB9BDDAA88DCA987DCA987DCA987DCA987DCA987DCA987DCA987D5A98AB2
              80747E98A0B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFB7FCFDB1F8FCAAF3F9A2EE
              F699E8F48FE2F085DBED7BD5EA70CDE565C6E25ABFDE4FB8DB44B1D73AAAD430
              A3D07E98A0B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFBCFFFFB7FBFDB1F7FBA9F3
              F9A2EEF699E7F38EE2F085DAED7AD4E96FCCE664C5E259BEDE4FB7DB44B0D739
              A9D37E98A0B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFF72A8B972A8B972A8B972A8
              B972A8B972A8B972A8B972A8B972A8B972A8B972A8B972A8B972A8B94DB6DA42
              AFD67E98A0B6B4B5DAD8D9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFBCFFFF72A8B989CCDF89CC
              DF89CCDF89CCDF89CCDF89CCDF89CCDF89CCDF89CCDF72A8B962C4E157BCDD4C
              B5DA7E98A0C1BFC0E0DDDEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFBAFDFD73A9BA9FD0DDACDB
              E8ACDBE879A5AA79A5AA74B4BEACDBE8ACDBE891C3D272A8B96CCBE461C3E056
              BCDD7E98A0D2CFD0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFABB9BE7E98A0BCFFFFBCFFFFBCFFFFA1DFE575ACBCA5CC
              D8CEEAF179A5AA79A5AA79A5AACEEAF1A3CBD775AEBF7ED2E576D1E86BCAE47E
              98A0A1AFB4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFABB9BE7E98A07E98A07E98A07E98A07C9AA474A5
              B4A7CAD5D3E6ECD3E6ECE5F2F6B2D1DB73A6B67D9AA37E98A07E98A07E98A0A6
              B4BAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFA9C5CF8BB5C38BB5C378ABBC8DB6C4DEE1E5FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1012Click
          end
          object BToolReplace1013: TSpeedButton
            Tag = 13
            Left = 136
            Top = 128
            Width = 33
            Height = 33
            Hint = #20391#36793#26639
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFCC6600CC6600CC6600CC6600CC6600CC6600CC6600CC
              6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600FF00FFCC6600FFFFFF
              FFFFFFFFFFFFFFF4E7CC6600FFEEDCFFEEDCFFE7D0FFE6C3FEE0C0FFD7B0FFD7
              B0FFD3A5CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFEEDCFF
              EEDCFFEEDCFFE7D0FFE6C3FEE0C0FFD7B0FFD7B0CC6600FF00FFCC6600FFFFF6
              999999999999FFFFF6CC6600FFEEDC9999999999999999999999999999999999
              99FFD7B0CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFEEDCFF
              EEDCFFEEDCFFEEDCFFEEDCFFEEDCFFEEDCFFEEDCCC6600FF00FFCC6600FFFFFF
              999999999999FFFFFFCC6600FFEEDC9999999999999999999999999999999999
              99FFEEDCCC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFF4E7FF
              F4E7FFF4E7FFF4E7FFF4E7FFF4E7FFF4E7FFF4E7CC6600FF00FFCC6600FFFFFF
              999999999999FFFFFFCC6600FFF8F19999999999999999999999999999999999
              99FFFFF6CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFFFF6FF
              FFF6FFFFF6FFFFF6FFFFF6FFFFF6FFFFF6FFFFF6CC6600FF00FFCC6600CC6600
              CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC66
              00CC6600CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F1FFF4E7CC6600FF00FFCC6600DF7A00
              DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A
              00DF7A00CC6600FF00FFCE6900CE6900CE6900CE6900CE6900CE6900CE6900CE
              6900CE6900CE6900CE6900CE6900CE6900CE6900CE6900FF00FFFF00FFD37313
              D37313D37313D37313D37313D37313D37313D37313D37313D37313D37313D373
              13D37313FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1013Click
          end
          object BToolReplace1014: TSpeedButton
            Tag = 14
            Left = 168
            Top = 128
            Width = 33
            Height = 33
            Hint = #25171#21360#39044#35272
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA37875A37875A37875A37875A37875A378
              75A37875A37875A37876A37875A37875A37875A37875A37875A37875A37875A3
              7875283543283543FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA57976E7BEB8F1BEB8EFBBB7EEBBB6ECB9
              B5EBB8B5EAB8B4E9B6B3EBB8B5EAB7B4EAB7B5EAB7B5E9B6B4E8B5B4E8B5B428
              3543599CB721A1D0435869FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA77B76D9D4CEFFE9D3FEE7D0FDE1CAFBDD
              C6FCDAC3FDD8BFFBD5BAFCD7BAFEDAB5FFDAB2FFD7AFFFD5ABFFD3A828354390
              B3B230B8E992CADB92CADB6A8B9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA97E77DBD7D2FFECD8FFE9D3FEE7CFFFE3
              CBFFE2C7FEE0C2DFC9B3AF9A868C77678243427B6D5CA08A724D58652396C33D
              BBE892CADBA8F3FB6A8B9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAC8079DDD9D4FFEDDBFFEDDAFFE9D3FFE8
              CFFFE5CBCDC0B3A18B79B39E7FD2BF98D2BF98C69992A66C6C5D544858848E92
              CADBA8F3FB6A8B9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAE8179DEDAD7FFEFDFFFEFDEFFEBD9FFE8
              D4E6D8C5A38C7BD2BF98E5D0A8E5D0A8E5D0A8E6D2A0D2BF98BC747572615599
              B5BD8497A38C5E5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB2857BE1DEDAFFF0E2FFF2E4FFEEDFFFEE
              D9C0B5A7B9AD91EDE2BFEDE2BFEDE2BFEDE2BFE5D0A8E6D2A0D2BF98A0636496
              826DFDD4CC8E605EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB5887CE3E1DEFFF3E7FFF4E8FFF2E5FFF0
              E19B8A7DDCCEB0F1E6CDF1E6CDF4ECE8F1E6CDF1E6CDE5D0A8E6D2A0B6A47D79
              6B5AFFCFC58F6160FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB98B7EE5E3E1FFF4E9FFF6ECFFF4E9FFF2
              E588776AF1E6CDF4ECE8F4ECE8FFFFF0F4ECE8F1E6CDEDE2BFE6D2A0D2BF9882
              4342FFD0C7926362FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBC8E7FE6E5E3FFF7EFFFF8F1FFF7EEFFF4
              EA9B8C7FE6D3C9FFFCE3FFFCF4FFFCF4FFFCF4F4ECE8EDE2BFE5D0A8C6999279
              6C5BFFD0C7936665FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC09181E9E8E7FFF8F1FFFAF5FFF9F1FFF7
              EEC0B9B0B5AB9BF4ECE8FFFCF4FFFCF4F4ECE8F1E6CDEDE2BFE5D0A8B39E7FA9
              9A8BFFD1C8956966FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC49581EBEAE9FFFAF7FFFCF8FFFAF5FFF9
              F3E6E5DFA09B92DCCEB0F4ECE8FFFCE3FFFCDFF1E6CDEDE2BFB9AD91988576DA
              C6AEFFD1C8986B69FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC89983EDEDECFFFBF8FFFDFBFFFDF9FFFA
              F7FFFAF4D8DBD69E9389B5AB9BE6D3C9F1E6CDDCCEB0B6A47D988677CCC3B3FF
              E2C5FFD2CA9A6D6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFCB9C85EFEFEFFFFEFEFFFEFEFFFDFCFFFC
              FAFFFBF7FFFAF5E7E8E6C3CAC69B8C7E7269619B8A7DB0B4ACDBD4C8FFE5CBFF
              E4CBFFCFC89B6F6DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFCFA086F2F2F2FFFFFFFFFFFFFFFFFFFFFE
              FDFFFDFBFFFCF8FFFAF7FFF9F2FFF3EBFFF0E4FFEEE0FFEDDBFFE8D3FFE8D1FF
              E5CCFFC6C09D716FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD3A388F3F3F3FFFFFFFFFFFFFFFFFFFFFF
              FFFFFEFDFFFEFCFFFDFBFFFCF9FFFAF3FFF5EDFFF2E7FFF0E2FFEBD9FFE9D4FF
              E8D2FFBDB79F7471FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD7A789F5F5F5FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFEFEFFFDFEFFFDFAFFFBF7FFF9F4FFF7F0FFF1EAFDDED0FFBEBEFF
              AFAFFFA1A1A17572FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFDAAA8AF8F8F8FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFEFEFFFCFBFFFBF8FFFAF3FEF7F1FEF6EFE6BEABE5A79AE5
              9E91E4988BA27674FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFDEAD8CFAFAFAFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFCFAFFFAF7FFF9F2FFF7EFFFF3E9FFF4E8B28074B28074B2
              8074B28074A37875FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE1B08DFBFBFBFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF7EFFFF7EFB28074FFB85CE1
              A36ACD9A81E4CCC1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE4B38EFEFEFEFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF9F2B28074E4AD81D2
              9F83E8D4CAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE7B68FFFFFFFFEFEFEFDFDFDFBFBFBF9F9
              F9F8F8F8F7F7F7F5F5F5F3F3F3F2F2F1F0EEEDEEECEAEEECEAB28074D7A485EA
              D6CBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFEAB890DCA987DCA987DCA987DCA987DCA9
              87DCA987DCA987DCA987DCA987DCA987DCA987DCA987DCA987B28074ECD8CCFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1014Click
          end
          object BToolReplace1015: TSpeedButton
            Tag = 15
            Left = 200
            Top = 128
            Width = 33
            Height = 33
            Hint = #25171#21360
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE2E0E1B9B9
              B9959595919191A8A7A7CFCDCEDBD8D9B5A1A1B5ACACACACACC7C6C6E9E7E7FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB4B3B3BCBCBCD8D8
              D8DFDFDFB0B0B0B6B6B69E9595AF8686A38383AFACACD8D8D8C7C7C7BABABAC0
              BFBFE8E5E6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCBC9CBB9B9B9CDCDCDEDEDEDEFEF
              EFDBDBDBAFAFAFB0B0B09A8E8E554E4E5F5F5F6767678585859A9A9AD5D5D5D4
              D4D4BABABABDBCBCDDDBDBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD7D5D7B8B7B8C0C0C0E8E8E8F5F5F5EFEFEFEAEA
              EAD4D4D4A9A9A9AFAFAF9090904C4C4C4444445F5F5F676767858585909090B0
              B0B0C6C6C6DBDBDBBEBEBEC0BFC0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD1CFD0B9B9B9DDDDDDF9F9F9F5F5F5EFEFEFEAEAEAE2E2
              E2D1D1D1A7A7A7A9A9A9AFAFAFB0B0B0A5A5A58B8B8B71717167676785858590
              9090B0B0B09C9C9CBBBABACFCDCDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB8B8B8FDFDFDFBFBFBF5F5F5EFEFEFEAEAEADADADAB2B2
              B29292928181818F8F8FA5A5A5AFAFAFB0B0B0B6B6B6B9B9B9AEAEAE9A9A9A65
              65655A5A5ACCCCCCBFBDBEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1B1B1FBFBFBF5F5F5EFEFEFDADADA9D9D9D9B9B9BBABA
              BAC7C7C79F9F9F8E8E8E8181818181818F8F8FA3A3A3B6B6B6B9B9B9BDBDBDC2
              C2C2B9B9B9C3C3C3BFBDBEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFA6A6A6F5F5F5CECECE9797979B9B9BD0D0D0D8D8D8D4D4
              D4D2D2D2CDCDCDBCBCBCA5A5A5A7A7A79C9C9C8F8F8F828282898989A0A0A0BD
              BDBD7DB68F84BD97BFBDBEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF9A9B9A898989979797DADADADFDFDFD8D8D8D4D4D4CDCD
              CDE8E8E8E3E3E3E7E7E7EAEAEADADADACBCBCBB8B8B8AFAFAFABABAB98989884
              84847D7D7D959595BAB8B9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF909090EAEAEAE2E2E2DFDFDFD8D8D8D4D4D4CDCDCDDFDF
              DFDBDBDBB4B4B4B9B9B9B9B9B9BDBDBDCECECEE4E4E4E4E4E4D6D6D6C6C6C6BE
              BEBEB9B9B9A7A7A7B4B2B3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF898989E2E2E2DFDFDFD8D8D8D4D4D4CDCDCDDCDCDCE4E4
              E4C0C0C0F1F1F1EFEFEFE9E9E9CFCFCFBFBFBFB9B9B9B9B9B9BEBEBED1D1D1E0
              E0E0DCDCDCD1D1D1C4C2C3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFE1DEE0D0D0D0D8D8D8D4D4D4CDCDCDDEDEDECECECEC2C2
              C2F5F5F5F3F3F3F1F1F1EFEFEFEEEEEEECECECE9E9E9DADADAC8C8C8BBBBBBB9
              B9B9B8B8B8CACACAE1DEDFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFDFDDDFD3D2D3ACACACBEBEBEC3C3C3D1D1D1C4C4
              C4CBCBCBE4E4E4F3F3F3F1F1F1EFEFEFEEEEEEECECECEAEAEAE7E7E7E6E6E6D3
              D3D3B0B0B0C9C8C8F2EFF0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAAAAAAE6E6E6E6E6E6B1B1
              B1B5B5B5B9B9B9B9B9B9C1C1C1CBCBCBDBDBDBE6E4E4E8E6E6EAEAEACACACAB6
              B6B6C5C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAAAAAAFBF8F5FDF0E4E6D9
              CCD1D1D1C5C5C5C3C3C3BBBBBBC0C0C0BEBEBEBAA9A9B9A5A5AFAFAFC8C7C7D7
              D5D6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE2DFE1C69784FFD5AAFFD5
              AAFFD5AAFFDAB5FFE0BFFFEAD5F3E4D3ECE1D7C4A8A8C8BDBDFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDCCED0D9AE97FFD9B3FFD9
              B3FFD9B3FFD9B3FFD9B3FFD9B3FFD9B3F6D0AFBA9797FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCCB4B5F2CEB0FFDDBBFFDD
              BBFFDDBBFFDDBBFFDDBBFFDDBBFFDDBBD4B2A5BC9A9AFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC3A1A0FFE5CCFFE5CCFFE5
              CCFFE5CCFFE5CCFFE5CCFFE5CCFFE5CCB99696D0B9BAFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBF9892FFECD9FFECD9FFEC
              D9FFECD9FFECD9FFECD9FFECD9F1DBCCB99696FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD1BDBDDFC5BBFFF0E1FFF0E1FFF0
              E1FFF0E1FFF0E1FFF0E1FFF0E1CEB1ADBC9A9AFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD9B9AFFF7EEFFF7EEFFF7EEFFF7
              EEFFF7EEFFF7EEFFF7EEFBF2E9B99696CBB2B2FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD7C6C6E6D8D7FFFDFBFFFDFBFFFDFBFFFD
              FBFFFDFBFFFDFBFFFDFBF3ECEABC9A9AE5DBDCFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE8E0E0B69292B99696B99696B99696B99696B996
              96B99696B99696B99696B99696DCCDCDFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1015Click
          end
          object BToolReplace1016: TSpeedButton
            Tag = 16
            Left = 232
            Top = 128
            Width = 33
            Height = 33
            Hint = #20445#23384
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFA89DAF41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3
              CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41
              A3CC41A3CC41A3CCAB9BABFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC49D1FF42CDFF4CB6E3A3A09FCACACACACACACACA
              CACACACACACACACACACACACACACACACACACACACACACACACACACACACA99B9C68D
              C7DE77B0C88EA7B241A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF140A2CBB6B3B2FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8EDCFC25
              B3ED34C1FA6BAAC441A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF13FA1CAB1ADACFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF91D9F630
              B3E83BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63ABAEE55B5DDC8BAB5D6CBC6D6CBC6D6CB
              C6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D8C9C37DC1DC34
              B8EE3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63CB7EA54C5F474C2E24997B84997B84997
              B84997B84997B84997B84997B84997B84997B84997B84997B84A95B443ABD63F
              BCEF3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F641B9EB3DB8EB35B8EF37BAF038BCF23BBF
              F53BBEF53BBEF53BBEF53BBEF53BBEF53BBEF53BBEF53BBFF539BEF43CB9ED41
              B9EB3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63FBAEC40B4E35CB7DC70CCF266C1E7429E
              C447A2C846A2C846A2C846A2C846A2C846A2C847A2C8439EC456B0D556C3F03C
              B8EB3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF241A1C9BDAEA8FFF9F5D1C6C1BBB0
              ABB4A8A4B4A9A4B2A7A2B2A7A2B2A7A2B2A7A2B8ADA89D918DB7A39AA0E2FE30
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE6E6E6B5B5B5FBFB
              FBE1E1E1ECECECFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3C8C8C8BAB2AE96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B7B7B7F2F2
              F2D9D9D9F4F4F4AFAFAF7777778B8B8BC3C3C3F6F6F6C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B7B7B7F1F1
              F1D8D8D8F4F4F4ACACAC727272868686C0C0C0F6F6F6C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B5B5B5FBFB
              FBDFDFDFF2F2F2ACACAC727272868686C0C0C0F6F6F6C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B5B5B5F5F5
              F5EEEEEEF8F8F8A9A9A96A6A6A7D7D7DBCBCBCF7F7F7C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC33BCF52CB7F0339ECAB4B0AFECECECBABABAFBFB
              FBE9E9E9F9F9F9BFBFBF727272727272B0B0B0F1F1F1C3C3C3BDB5B196DDFB31
              B4E93ABCF175AFC741A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CCC2F9FFBFF7FFA7D2E4A7A5A5DCDCDC9A9A9AFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACACAA59C98A5F3FF35
              C3FC46D3FF44839D3385A8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD638D541A3CC41A3CC3385A8ACACAC41A3CC41A3CC41A3
              CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41
              A3CC41A3CC3385A8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1016Click
          end
          object BToolReplace1111: TSpeedButton
            Tag = 11
            Left = 336
            Top = 128
            Width = 33
            Height = 33
            Hint = #24037#20855
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE6E3E58C8C8C868686B7B6B7FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE4E2E3959595818181B1B0B0FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0D8EFE8E8EFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBBBB8C8C8C7E7E7EDBD9
              D9FF00FFFF00FFFF00FFFF00FFFF00FF97AEEB658BE77B9EECFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFE5E2E3FF00FFFF00FFFF00FFFF00FFAEADAE9292928C8C8CB4B3
              B3FF00FFFF00FFFF00FFFF00FF92AAEB6A8FE8769BEC769FEF82AAF3FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFA5A5A5D6D3D4FF00FFFF00FFFF00FF9F9F9F979797919191B8B6
              B5FF00FFFF00FFFF00FF93ABEB6A8FE8759AEC79A1F07CA6F37CAAF589B4F7FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFB9B9B9A5A5A5C4C3C4BCBBBBA9A8A99F9F9F9C9C9C959595BAB7
              B3E3E3EBCAD3EE9FB5ED6A8EE8759AEC79A0F07CA6F37FABF583B2F883B5FA8F
              BEFBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDCDADBB2B2B2AFAFAFABABABA9A9A9A4A4A4A0A0A09E9D988B91
              A17E9DE477A0F17DACF678A0EF78A0EF7CA4F380ACF682B1F885B5FB88BBFD88
              BEFF93C5FEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD0CFCFB0B0B0ADADADA9A9A9A5A5A5A6A5A0969DAD7596
              E478A3F383B2F98DC2FF89BDFE7CA6F3789FEF79A1F086B8FC88BBFD8CBFFF8F
              C3FF91C6FF9DCDFEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD9D7D8D6D5D5D5D4D1A1A7B57596E479A2
              F383B2F98ABFFF97CBFF97CAFF87B7FC7FAAF5759AED7CA5F28CC1FF90C4FF93
              C8FF97CBFF97CBFFA4D1FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF809FE977A2F283B2
              F98BBEFF98CBFF8FC3FF92C5FF92C6FF87B9FC80ABF57599EC7EAAF497CAFF97
              CBFF99CCFF94C9FFD4E4F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8BA8ED77A0F183B2F98ABF
              FF98CCFF8EC3FF779EEE86B8FC9ACDFF92C5FF87B9FC7FABF57499EC80ADF79A
              CEFF94CAFFD0E2F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9AB2EE749FEF83B2F98ABFFF99CC
              FF8FC3FF789FEF7DA7F285B5FB95C9FF9ACEFF92C6FF88BAFC7FABF57498EC7E
              ACF7D0E4F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAAC3F27DAEF88CBFFF98CCFF8EC3
              FF779EEE7DA8F386B8FB91C5FF98CBFF8ABEFF98CBFF92C6FF88B8FD7FABF574
              99ECDCDFEEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4CBFD98CBFF8DC2FF789E
              EE7DA8F386B6FB91C5FF9ACDFF82B1F7769DED89BDFE99CDFF91C6FF86B9FC7E
              AAF5DADFF1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCBDCF6799FEE7CA7
              F386B6FB90C4FF9ACEFF83B0F8779CEE81AEF788BBFD98CBFF99CEFF94C6FFC5
              D9F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA0C0F57EB2
              FB90C4FF9ACEFF83B2F8779CEE81B0F789BCFE96C9FF93C7FB95AEC897A8BCB6
              B6B8B5B3B2D4D2D3EEEAEBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAED2
              FC9ACDFF82B1F8779CEE81AEF789BCFE94C8FF94C9FD9EA8B29C979397949291
              91908B8B8B808080B1B0B1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFCAD9F3789DEE81AEF68ABDFE91C7FF9DCEFEA7B1BBA4A29EA0A0A09C9C9C97
              97979292928C8C8C808080BFBDBDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FF9BBFF784B9FE90C6FFABD5FDEDEDEFD6D3D2A5A5A5A4A4A4A0A0A0A0
              9F9FAFAEAEBAB9BA939393848383FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFB7D7FBB7D9FCEDEDEFEDEAECD6D4D4A9A9A9A9A9A9AAAAAAFF
              00FFFF00FFFF00FFE5E3E38B8B8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD8D6D7ADADADABABABBCBBBBFF
              00FFFF00FFFF00FFFF00FFE5E3E4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE9E7E8B0B0B0AFAFAFC5C4C4FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0D0D0B1B1B1A6A6A6D7
              D4D5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD8D7D7BABABAA6
              A5A5E8E5E6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1111Click
          end
          object BToolReplace1112: TSpeedButton
            Tag = 12
            Left = 368
            Top = 128
            Width = 33
            Height = 33
            Hint = #22797#21046
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE6E3E4E1DDDFDBD8D9D9D6D8D9D6D8D9D6
              D8D9D6D8D9D6D8D9D6D8D9D6D8D9D5D8D9D5D8D9D5D8D9D5D7D9D5D7DAD7D9E0
              DCDEE6E3E4EAE7E8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD3CFD0C2BFC1B7B4B6B2AFB0B1AFB0B1AF
              B08E615F8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8B5C5B8D5E5C8B
              5C5B8B5C5B8B5C5B8B5C5B8B5C5BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA1AFB47E98A07E98A07E98A07E98A07E98A07E98
              A0B39790E9E2DCFFF6E9FFF2E5FFEFDFFFEDD9FFEAD3FFE8CFFFE5CAFADFC3FF
              DEBCFFDCB8FFDAB4FFD0C5906260FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFA7B4BA7E98A070CDE665C6E25ABFDF4FB7DB44B0D73AAA
              D3B5A39CEFEAE9FFFDFAFFFBF6FFF8F2FFF7EEFFF4E8FFF1E3FFECDAF5E3D0FF
              E4C8FFE3C6FFE0C2FFD2C9986B69FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A084DAED79D4E96FCDE564C5E259BEDE4EB7DB44B0
              D7B6ADA4EEF0EFF1F9FCF1F9FBF0F6F9F0F5F5F0F4F3F0F0EBF2EAE2E7E3DBF0
              E3D3F7E2CDFAE3CBFDC8C2A27977FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A08EE1F084DAEC78D3E96ECCE564C5E158BEDE4DB7
              DAC7B4A4F7F4F3C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5FD
              DED0FFBEBEFFAFAFFFA1A1A17572FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A097E6F28DE0F082DAEC78D2E96DCBE462C4E157BC
              DDCBB8A5F9F7F5FFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFCF8FEF9F2F4F2EDE6
              BEABE5A79AE59E91E4988BA27674FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0A7F1F89EEBF594E5F28BDFEE81D8EB76D1E86BCA
              E4D1BCA8FAF8F6C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5F6F0E7B2
              8074B28074B28074B28074A37875FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0ADF5FAA6F1F79EEBF594E5F18ADEEE80D7EB75D0
              E7D4C0A9FBF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFBF8FFF8F1F6F3EDB2
              8074FFB85CE1A36ACD9A81FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0B9FDFEB3F9FCACF5FAA4F0F79CEAF592E3F188DD
              EDDAC4ACFDFBF8C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5C8AFA5F6F5F1B2
              8074E4AD81D29F83D9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFB8FCFDB3F9FCABF4FAA3EFF79BE9F491E3
              F1DEC7ADFEFBF9FEFEFEFAFAFAF8F8F8F7F7F7F5F5F5F2F2F1EFEDEBE6E9E9B2
              8074D7A485B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFB8FCFEB2F8FCABF3F9A3EEF69AE9
              F3DCBB9BDDAA88DCA987DCA987DCA987DCA987DCA987DCA987DCA987D5A98AB2
              80747E98A0B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFB7FCFDB1F8FCAAF3F9A2EE
              F699E8F48FE2F085DBED7BD5EA70CDE565C6E25ABFDE4FB8DB44B1D73AAAD430
              A3D07E98A0B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFBCFFFFB7FBFDB1F7FBA9F3
              F9A2EEF699E7F38EE2F085DAED7AD4E96FCCE664C5E259BEDE4FB7DB44B0D739
              A9D37E98A0B1AFAFD9D6D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFF72A8B972A8B972A8B972A8
              B972A8B972A8B972A8B972A8B972A8B972A8B972A8B972A8B972A8B94DB6DA42
              AFD67E98A0B6B4B5DAD8D9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFBCFFFF72A8B989CCDF89CC
              DF89CCDF89CCDF89CCDF89CCDF89CCDF89CCDF89CCDF72A8B962C4E157BCDD4C
              B5DA7E98A0C1BFC0E0DDDEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF7E98A0BCFFFFBCFFFFBCFFFFBAFDFD73A9BA9FD0DDACDB
              E8ACDBE879A5AA79A5AA74B4BEACDBE8ACDBE891C3D272A8B96CCBE461C3E056
              BCDD7E98A0D2CFD0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFABB9BE7E98A0BCFFFFBCFFFFBCFFFFA1DFE575ACBCA5CC
              D8CEEAF179A5AA79A5AA79A5AACEEAF1A3CBD775AEBF7ED2E576D1E86BCAE47E
              98A0A1AFB4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFABB9BE7E98A07E98A07E98A07E98A07C9AA474A5
              B4A7CAD5D3E6ECD3E6ECE5F2F6B2D1DB73A6B67D9AA37E98A07E98A07E98A0A6
              B4BAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFA9C5CF8BB5C38BB5C378ABBC8DB6C4DEE1E5FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1112Click
          end
          object BToolReplace1113: TSpeedButton
            Tag = 13
            Left = 400
            Top = 128
            Width = 33
            Height = 33
            Hint = #20391#36793#26639
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFCC6600CC6600CC6600CC6600CC6600CC6600CC6600CC
              6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600FF00FFCC6600FFFFFF
              FFFFFFFFFFFFFFF4E7CC6600FFEEDCFFEEDCFFE7D0FFE6C3FEE0C0FFD7B0FFD7
              B0FFD3A5CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFEEDCFF
              EEDCFFEEDCFFE7D0FFE6C3FEE0C0FFD7B0FFD7B0CC6600FF00FFCC6600FFFFF6
              999999999999FFFFF6CC6600FFEEDC9999999999999999999999999999999999
              99FFD7B0CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFEEDCFF
              EEDCFFEEDCFFEEDCFFEEDCFFEEDCFFEEDCFFEEDCCC6600FF00FFCC6600FFFFFF
              999999999999FFFFFFCC6600FFEEDC9999999999999999999999999999999999
              99FFEEDCCC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFF4E7FF
              F4E7FFF4E7FFF4E7FFF4E7FFF4E7FFF4E7FFF4E7CC6600FF00FFCC6600FFFFFF
              999999999999FFFFFFCC6600FFF8F19999999999999999999999999999999999
              99FFFFF6CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFCC6600FFFFF6FF
              FFF6FFFFF6FFFFF6FFFFF6FFFFF6FFFFF6FFFFF6CC6600FF00FFCC6600CC6600
              CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC6600CC66
              00CC6600CC6600FF00FFCC6600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F1FFF4E7CC6600FF00FFCC6600DF7A00
              DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A00DF7A
              00DF7A00CC6600FF00FFCE6900CE6900CE6900CE6900CE6900CE6900CE6900CE
              6900CE6900CE6900CE6900CE6900CE6900CE6900CE6900FF00FFFF00FFD37313
              D37313D37313D37313D37313D37313D37313D37313D37313D37313D37313D373
              13D37313FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1113Click
          end
          object BToolReplace1114: TSpeedButton
            Tag = 14
            Left = 432
            Top = 128
            Width = 33
            Height = 33
            Hint = #25171#21360#39044#35272
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA37875A37875A37875A37875A37875A378
              75A37875A37875A37876A37875A37875A37875A37875A37875A37875A37875A3
              7875283543283543FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA57976E7BEB8F1BEB8EFBBB7EEBBB6ECB9
              B5EBB8B5EAB8B4E9B6B3EBB8B5EAB7B4EAB7B5EAB7B5E9B6B4E8B5B4E8B5B428
              3543599CB721A1D0435869FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA77B76D9D4CEFFE9D3FEE7D0FDE1CAFBDD
              C6FCDAC3FDD8BFFBD5BAFCD7BAFEDAB5FFDAB2FFD7AFFFD5ABFFD3A828354390
              B3B230B8E992CADB92CADB6A8B9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA97E77DBD7D2FFECD8FFE9D3FEE7CFFFE3
              CBFFE2C7FEE0C2DFC9B3AF9A868C77678243427B6D5CA08A724D58652396C33D
              BBE892CADBA8F3FB6A8B9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAC8079DDD9D4FFEDDBFFEDDAFFE9D3FFE8
              CFFFE5CBCDC0B3A18B79B39E7FD2BF98D2BF98C69992A66C6C5D544858848E92
              CADBA8F3FB6A8B9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAE8179DEDAD7FFEFDFFFEFDEFFEBD9FFE8
              D4E6D8C5A38C7BD2BF98E5D0A8E5D0A8E5D0A8E6D2A0D2BF98BC747572615599
              B5BD8497A38C5E5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB2857BE1DEDAFFF0E2FFF2E4FFEEDFFFEE
              D9C0B5A7B9AD91EDE2BFEDE2BFEDE2BFEDE2BFE5D0A8E6D2A0D2BF98A0636496
              826DFDD4CC8E605EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB5887CE3E1DEFFF3E7FFF4E8FFF2E5FFF0
              E19B8A7DDCCEB0F1E6CDF1E6CDF4ECE8F1E6CDF1E6CDE5D0A8E6D2A0B6A47D79
              6B5AFFCFC58F6160FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB98B7EE5E3E1FFF4E9FFF6ECFFF4E9FFF2
              E588776AF1E6CDF4ECE8F4ECE8FFFFF0F4ECE8F1E6CDEDE2BFE6D2A0D2BF9882
              4342FFD0C7926362FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBC8E7FE6E5E3FFF7EFFFF8F1FFF7EEFFF4
              EA9B8C7FE6D3C9FFFCE3FFFCF4FFFCF4FFFCF4F4ECE8EDE2BFE5D0A8C6999279
              6C5BFFD0C7936665FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC09181E9E8E7FFF8F1FFFAF5FFF9F1FFF7
              EEC0B9B0B5AB9BF4ECE8FFFCF4FFFCF4F4ECE8F1E6CDEDE2BFE5D0A8B39E7FA9
              9A8BFFD1C8956966FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC49581EBEAE9FFFAF7FFFCF8FFFAF5FFF9
              F3E6E5DFA09B92DCCEB0F4ECE8FFFCE3FFFCDFF1E6CDEDE2BFB9AD91988576DA
              C6AEFFD1C8986B69FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC89983EDEDECFFFBF8FFFDFBFFFDF9FFFA
              F7FFFAF4D8DBD69E9389B5AB9BE6D3C9F1E6CDDCCEB0B6A47D988677CCC3B3FF
              E2C5FFD2CA9A6D6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFCB9C85EFEFEFFFFEFEFFFEFEFFFDFCFFFC
              FAFFFBF7FFFAF5E7E8E6C3CAC69B8C7E7269619B8A7DB0B4ACDBD4C8FFE5CBFF
              E4CBFFCFC89B6F6DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFCFA086F2F2F2FFFFFFFFFFFFFFFFFFFFFE
              FDFFFDFBFFFCF8FFFAF7FFF9F2FFF3EBFFF0E4FFEEE0FFEDDBFFE8D3FFE8D1FF
              E5CCFFC6C09D716FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD3A388F3F3F3FFFFFFFFFFFFFFFFFFFFFF
              FFFFFEFDFFFEFCFFFDFBFFFCF9FFFAF3FFF5EDFFF2E7FFF0E2FFEBD9FFE9D4FF
              E8D2FFBDB79F7471FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD7A789F5F5F5FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFEFEFFFDFEFFFDFAFFFBF7FFF9F4FFF7F0FFF1EAFDDED0FFBEBEFF
              AFAFFFA1A1A17572FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFDAAA8AF8F8F8FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFEFEFFFCFBFFFBF8FFFAF3FEF7F1FEF6EFE6BEABE5A79AE5
              9E91E4988BA27674FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFDEAD8CFAFAFAFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFCFAFFFAF7FFF9F2FFF7EFFFF3E9FFF4E8B28074B28074B2
              8074B28074A37875FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE1B08DFBFBFBFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF7EFFFF7EFB28074FFB85CE1
              A36ACD9A81E4CCC1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE4B38EFEFEFEFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF9F2B28074E4AD81D2
              9F83E8D4CAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE7B68FFFFFFFFEFEFEFDFDFDFBFBFBF9F9
              F9F8F8F8F7F7F7F5F5F5F3F3F3F2F2F1F0EEEDEEECEAEEECEAB28074D7A485EA
              D6CBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFEAB890DCA987DCA987DCA987DCA987DCA9
              87DCA987DCA987DCA987DCA987DCA987DCA987DCA987DCA987B28074ECD8CCFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1114Click
          end
          object BToolReplace1115: TSpeedButton
            Tag = 15
            Left = 464
            Top = 128
            Width = 33
            Height = 33
            Hint = #25171#21360
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE2E0E1B9B9
              B9959595919191A8A7A7CFCDCEDBD8D9B5A1A1B5ACACACACACC7C6C6E9E7E7FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB4B3B3BCBCBCD8D8
              D8DFDFDFB0B0B0B6B6B69E9595AF8686A38383AFACACD8D8D8C7C7C7BABABAC0
              BFBFE8E5E6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCBC9CBB9B9B9CDCDCDEDEDEDEFEF
              EFDBDBDBAFAFAFB0B0B09A8E8E554E4E5F5F5F6767678585859A9A9AD5D5D5D4
              D4D4BABABABDBCBCDDDBDBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD7D5D7B8B7B8C0C0C0E8E8E8F5F5F5EFEFEFEAEA
              EAD4D4D4A9A9A9AFAFAF9090904C4C4C4444445F5F5F676767858585909090B0
              B0B0C6C6C6DBDBDBBEBEBEC0BFC0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD1CFD0B9B9B9DDDDDDF9F9F9F5F5F5EFEFEFEAEAEAE2E2
              E2D1D1D1A7A7A7A9A9A9AFAFAFB0B0B0A5A5A58B8B8B71717167676785858590
              9090B0B0B09C9C9CBBBABACFCDCDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB8B8B8FDFDFDFBFBFBF5F5F5EFEFEFEAEAEADADADAB2B2
              B29292928181818F8F8FA5A5A5AFAFAFB0B0B0B6B6B6B9B9B9AEAEAE9A9A9A65
              65655A5A5ACCCCCCBFBDBEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFB1B1B1FBFBFBF5F5F5EFEFEFDADADA9D9D9D9B9B9BBABA
              BAC7C7C79F9F9F8E8E8E8181818181818F8F8FA3A3A3B6B6B6B9B9B9BDBDBDC2
              C2C2B9B9B9C3C3C3BFBDBEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFA6A6A6F5F5F5CECECE9797979B9B9BD0D0D0D8D8D8D4D4
              D4D2D2D2CDCDCDBCBCBCA5A5A5A7A7A79C9C9C8F8F8F828282898989A0A0A0BD
              BDBD7DB68F84BD97BFBDBEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF9A9B9A898989979797DADADADFDFDFD8D8D8D4D4D4CDCD
              CDE8E8E8E3E3E3E7E7E7EAEAEADADADACBCBCBB8B8B8AFAFAFABABAB98989884
              84847D7D7D959595BAB8B9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF909090EAEAEAE2E2E2DFDFDFD8D8D8D4D4D4CDCDCDDFDF
              DFDBDBDBB4B4B4B9B9B9B9B9B9BDBDBDCECECEE4E4E4E4E4E4D6D6D6C6C6C6BE
              BEBEB9B9B9A7A7A7B4B2B3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF898989E2E2E2DFDFDFD8D8D8D4D4D4CDCDCDDCDCDCE4E4
              E4C0C0C0F1F1F1EFEFEFE9E9E9CFCFCFBFBFBFB9B9B9B9B9B9BEBEBED1D1D1E0
              E0E0DCDCDCD1D1D1C4C2C3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFE1DEE0D0D0D0D8D8D8D4D4D4CDCDCDDEDEDECECECEC2C2
              C2F5F5F5F3F3F3F1F1F1EFEFEFEEEEEEECECECE9E9E9DADADAC8C8C8BBBBBBB9
              B9B9B8B8B8CACACAE1DEDFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFDFDDDFD3D2D3ACACACBEBEBEC3C3C3D1D1D1C4C4
              C4CBCBCBE4E4E4F3F3F3F1F1F1EFEFEFEEEEEEECECECEAEAEAE7E7E7E6E6E6D3
              D3D3B0B0B0C9C8C8F2EFF0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAAAAAAE6E6E6E6E6E6B1B1
              B1B5B5B5B9B9B9B9B9B9C1C1C1CBCBCBDBDBDBE6E4E4E8E6E6EAEAEACACACAB6
              B6B6C5C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAAAAAAFBF8F5FDF0E4E6D9
              CCD1D1D1C5C5C5C3C3C3BBBBBBC0C0C0BEBEBEBAA9A9B9A5A5AFAFAFC8C7C7D7
              D5D6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE2DFE1C69784FFD5AAFFD5
              AAFFD5AAFFDAB5FFE0BFFFEAD5F3E4D3ECE1D7C4A8A8C8BDBDFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDCCED0D9AE97FFD9B3FFD9
              B3FFD9B3FFD9B3FFD9B3FFD9B3FFD9B3F6D0AFBA9797FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCCB4B5F2CEB0FFDDBBFFDD
              BBFFDDBBFFDDBBFFDDBBFFDDBBFFDDBBD4B2A5BC9A9AFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC3A1A0FFE5CCFFE5CCFFE5
              CCFFE5CCFFE5CCFFE5CCFFE5CCFFE5CCB99696D0B9BAFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBF9892FFECD9FFECD9FFEC
              D9FFECD9FFECD9FFECD9FFECD9F1DBCCB99696FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD1BDBDDFC5BBFFF0E1FFF0E1FFF0
              E1FFF0E1FFF0E1FFF0E1FFF0E1CEB1ADBC9A9AFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD9B9AFFF7EEFFF7EEFFF7EEFFF7
              EEFFF7EEFFF7EEFFF7EEFBF2E9B99696CBB2B2FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD7C6C6E6D8D7FFFDFBFFFDFBFFFDFBFFFD
              FBFFFDFBFFFDFBFFFDFBF3ECEABC9A9AE5DBDCFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE8E0E0B69292B99696B99696B99696B99696B996
              96B99696B99696B99696B99696DCCDCDFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1115Click
          end
          object BToolReplace1116: TSpeedButton
            Tag = 16
            Left = 496
            Top = 128
            Width = 33
            Height = 33
            Hint = #20445#23384
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C0000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFA89DAF41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3
              CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41
              A3CC41A3CC41A3CCAB9BABFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC49D1FF42CDFF4CB6E3A3A09FCACACACACACACACA
              CACACACACACACACACACACACACACACACACACACACACACACACACACACACA99B9C68D
              C7DE77B0C88EA7B241A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF140A2CBB6B3B2FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8EDCFC25
              B3ED34C1FA6BAAC441A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8ED6F331
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF13FA1CAB1ADACFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF91D9F630
              B3E83BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63ABAEE55B5DDC8BAB5D6CBC6D6CBC6D6CB
              C6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D6CBC6D8C9C37DC1DC34
              B8EE3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63CB7EA54C5F474C2E24997B84997B84997
              B84997B84997B84997B84997B84997B84997B84997B84997B84A95B443ABD63F
              BCEF3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F641B9EB3DB8EB35B8EF37BAF038BCF23BBF
              F53BBEF53BBEF53BBEF53BBEF53BBEF53BBEF53BBEF53BBFF539BEF43CB9ED41
              B9EB3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63FBAEC40B4E35CB7DC70CCF266C1E7429E
              C447A2C846A2C846A2C846A2C846A2C846A2C847A2C8439EC456B0D556C3F03C
              B8EB3BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF241A1C9BDAEA8FFF9F5D1C6C1BBB0
              ABB4A8A4B4A9A4B2A7A2B2A7A2B2A7A2B2A7A2B8ADA89D918DB7A39AA0E2FE30
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE6E6E6B5B5B5FBFB
              FBE1E1E1ECECECFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3C8C8C8BAB2AE96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B7B7B7F2F2
              F2D9D9D9F4F4F4AFAFAF7777778B8B8BC3C3C3F6F6F6C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B7B7B7F1F1
              F1D8D8D8F4F4F4ACACAC727272868686C0C0C0F6F6F6C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B5B5B5FBFB
              FBDFDFDFF2F2F2ACACAC727272868686C0C0C0F6F6F6C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC43C1F63DBDF141A3CCB2AFAEE8E8E8B5B5B5F5F5
              F5EEEEEEF8F8F8A9A9A96A6A6A7D7D7DBCBCBCF7F7F7C1C1C1B8B0AC96DDFB31
              B4E93BBDF26EA8C041A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CC33BCF52CB7F0339ECAB4B0AFECECECBABABAFBFB
              FBE9E9E9F9F9F9BFBFBF727272727272B0B0B0F1F1F1C3C3C3BDB5B196DDFB31
              B4E93ABCF175AFC741A3CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF41A3CCC2F9FFBFF7FFA7D2E4A7A5A5DCDCDC9A9A9AFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACACAA59C98A5F3FF35
              C3FC46D3FF44839D3385A8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD638D541A3CC41A3CC3385A8ACACAC41A3CC41A3CC41A3
              CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41A3CC41
              A3CC41A3CC3385A8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
            OnClick = BToolReplace1116Click
          end
          object SpeedButton14: TSpeedButton
            Tag = 10
            Left = 120
            Top = 208
            Width = 23
            Height = 22
            Hint = #21518#19968#39029#38754
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9BB69C438245FF00
              FF036C0A036508036408015A04014003587C59FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7C0A81074130883160EA5260EB4
              250CB3220AB21C07B01706AF1302A70C018307014C04426C44FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF7DAD7F067D1115AA3318B83A15B63412B5
              2F10B42B0CB3230BB32108B11907B01604AF1001AD0B017D07014503FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF8DB78E0782131DB6472BC1642BC16418B83C17B7
              3913B6312BC1640FB4280CB3220AB21E07B01706B01503AE0D019809014503FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFA6C4A709881424BA5523BD5421BC501EBB4A1CBA461AB9
              4051CA6CF1FBF3F0FAF23DC3540EB4270BB32109B21D06B01605AF1201930910
              4E12FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF108A122BC16429C06128BF5E25BE5722BD5320BC4F1DBA
              488EDDA3FFFFFFFFFFFFF0FAF23EC35510B52B0CB3230BB32008B11807B01503
              770B8CA68DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF9BC29C129D2A2BC1642BC1642BC16628C06027BF5D23BE5522BD
              5249C86EF1FBF3FFFFFFFFFFFFF0FAF23EC35611B52E0EB4280CB3220AB21C07
              AA16015104FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF42A54426B8582BC1642BC1642BC1642DC26A2AC16328C05F25BF
              5A22BD544BC973F1FBF4FFFFFFFFFFFFF1FBF341C45B11B52F10B42B0CB3230B
              B32104780DA7B9A8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF0193022BC1642BC1642BC1642BC1642BC1642BC1642CC16729C0
              6127C05E24BE574BC973F1FBF4FFFFFFFFFFFFF1FBF342C55E14B63311B52E0F
              B4280890176B966CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF0DA11D2BC1642BC1642BC16462D19097E1B597E1B597E1B596E0
              B494E0B094E0AF92DFABBAEAC9FFFFFFFFFFFFFFFFFFF1FBF343C55F16B73712
              B5300DA0232C772FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF0DA61D2BC1642BC1642BC16497E1B5FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1FBF343C56017
              B83A12B02F136D16FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF0DA91D2BC1642BC1642BC16497E1B5FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5F2DE2ABE521A
              B94015AE34137516FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF0CAA1734C36F2BC1642BC16462D19097E1B597E1B597E1B597E1
              B597E1B597E1B597E1B5D8F4E3FFFFFFFFFFFFFFFFFFD6F3E030C15F21BC511D
              BA4816A636589859FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF01A9024ECA7A43C87833C36E2EC26B2EC26B2EC26B2EC26B2EC2
              6B2EC26B2EC26B7CD9A3FFFFFFFFFFFFFFFFFFD8F4E336C46B27C05E24BE5722
              BD52129B2D7EAD7FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF58BE584CC66164D18C55CD8342C8772EC26B2EC26B2EC26B2EC2
              6B2EC26B7CD9A3FFFFFFFFFFFFFFFFFFD8F4E33BC6742EC26A2BC16428C05F26
              BE59078412BBC9BBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF13B51687DBA37BD89B63D18C4ECB7F38C5712EC26B2EC2
              6B55CD87FFFFFFFFFFFFFFFFFFD8F4E33BC6742EC26B2FC26C2FC26C2CC1671F
              B04A108212FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF57C2565CCD669DE1B085DBA172D5955ACE8644C87930C3
              6D62D190FFFFFFFFFFFFD8F4E33BC6742EC26B2EC26B2FC26C2FC26C2FC26C0A
              8D17FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF01B40144C648ACE5B996DFAC7DD99D68D38F53CC
              823AC57397E1B5B1E8C83BC6742EC26B2FC26C2FC26C2FC26C2FC26C129E2A6A
              B06BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF0EBA0E94DF97AEE5BB9BE0AF82DAA06ED4
              9256CD8343C8782FC26C2FC26C2FC26C2FC26C2FC26C2FC26C12A22A2FA231FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF10BC1059CF5AB3E7B8A7E3B691DE
              A97CD89B64D18C4FCB8039C5722FC26C2FC26C24B9520A9E1658B159FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8DCE8D0EBB0E4AC94C6BD1
              7476D5837ED89763D08241C46422B7420AA81610A311A8CBA8FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7D1A76BC7
              6A2AB82A11B31112B01358BD597DC47EBBCFBBFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton15: TSpeedButton
            Tag = 11
            Left = 144
            Top = 208
            Width = 23
            Height = 22
            Hint = #20572#27490
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD3D3D3D5D5
              D5D4D5D4E5DCE1E8D9E3E8DAE3E2DCDFD8D9D8FF00FFD3D3D3FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD3D3D3D3D4D3E6E3E5D2C7
              CDEED4E431755212A1401A9C484D786BBDA4B6E5DDDFE0DDE0D2D3D2D3D3D3FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD2D3D3E1DFDFEADBE49582983C97
              6A32B26730CC6A37C76E36C86D32C96C3BB3704A927ACCAEC5ECE1E7DAD8DAD2
              D3D3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD2D3D2E7E5E5B792AE2F905925CC6133C8
              6B34C56B36C46C36C46C36C46C35C46B33C66A30C86823C75F528B82E3CDD8DF
              DCDDD2D3D3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD2D3D2E7E5E7AB89A219B85132CA6B36C46C36C4
              6C36C46C36C46C36C46C36C46C36C46C36C46C36C46C35C46B2ECA662DA967D9
              BCCDDFDCDDD2D3D2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD3D3D3E3E0E3B490A915C05335C66C36C46C36C46C36C4
              6C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C31C8692A
              AA66E5D0DADBD9DBD3D3D3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD5D5D5DFC8D622B16135C66C36C46C36C46C36C46C36C4
              6C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C2E
              CA674E897AEFE4EAD2D3D2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFD3D3D3ECE2E93D6B512FCD6A36C46C36C46C36C46C36C46C36C4
              6C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C35
              C46B26C463CAACC2DFDDDFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFE6D4E014C35237C46D36C46C36C46C36C46C36C46C36C4
              6C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36
              C46C31C8693A966FEFE2E9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDBDBDB9F85972BC46735C46C1CBC591CBC591CBC591CBC591CBC
              591CBC591CBC591CBC591CBC591CBC591CBC591CBC591CBC591CBC591CBC591C
              BC5933C66A3AB170D1BBCBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFE6DDE429733A3CCA731CBC59FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF1CBD5933C56C588576FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFEADAE8009B1637C8711DBC59FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF1CBC5935C86D1D9D4AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFEBD9E900A20B36C6721DBC59FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF1CBC5934C46A2FC76AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFE8DCE619832235C7731CBC59FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF1CBC592FC7686B867BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFE1DEE157615349CE7D32C36A1CBC591CBC591CBC591CBC591CBC
              591CBC591CBC591CBC591CBC591CBC591CBC591CBC591CBC591CBC591CBC591C
              BC5934C56A36B76FD8C2D0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFD5D5D5E0CBDD42C55945C97932C26835C46B36C46C36C46C36C4
              6C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36
              C46C33C96B358B5DF3E7EFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFEADCEA008D008EE3B145C97730C16835C36B36C46C36C4
              6C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C35
              C46B28C9669D879AE4E1E4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFD6D6D6DFC1DD51C65AA6E6BE51CC7F33C36A33C36A35C3
              6B36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C36C46C32
              C96B2E8B5BFAEBF5D1D2D1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE7E0E721601F33C936C2E9CE6DD3913EC67232C3
              6934C36B35C46B36C46C36C46C36C46C36C46C36C46C36C46C36C46C34C56B1E
              B65BDDC3D3DCD9DCD3D3D3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFF8E5F80C760BA5EBA6C8ECD388DAA452CD
              7F35C46B33C26A35C36B35C46B35C46C36C46C35C46C35C46B32C56920C160BD
              9EB8E4E1E3D2D3D2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF6E5F62B672B40C33FDBF4DEB2E6
              C47BD99C4BCA7D35C46B33C36B36C46C34C46A34C46A35CA6E2CB168D7B8CCE4
              E1E3D2D3D2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE4DDE4F3D4F300910035BE
              3462D06C7AD9887FDAA155CE8330C46334C36C35C56F357142FFE8F8DDDADDD2
              D3D2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE8D9E8F1E0
              F1D3B8D02B892900A800009F00849282DDC9D6F6E4F0EBE1E9D2D2D2D3D3D3FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD3D3
              D3D6D6D6E5DAE5EBD8EBEAD9EADEDADDD5D5D5D2D2D2D3D3D3FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton16: TSpeedButton
            Tag = 11
            Left = 192
            Top = 208
            Width = 23
            Height = 22
            Hint = #20027#39029
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB6999BC59583B992
              8BA57C7BB29698C3B5B7E8F0F1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB9918FE0AC84EDC097F0E3
              CFEFE1CCE1CBB7D6B8A9D5ADA4C19697C5A8AAC9BBBDFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC6C4C7C59E95E6B78CEDBC8AEEC49BF2E6
              D6F0E2CEEFE1CBEDDEC5ECDCC1B38181B88585BD8A8AC1908DB88E8CB6999BBC
              AEB0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC7C4C7CC9F93EDC495EFC392EEBF8DEFC89FF3E8
              D9F2E6D5F0E2CEEFE1CAEDDEC5A47272AA7878AE7C7CC0958BE6D0AADABF9EC7
              A48BB48A7EA9888AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFC8BABCD6AA97F2CF9DF1CB99F0C896EFC392F0CBA3F5EC
              DFF3E8D9F2E6D5F0E2CEEFE1CA9967679B6969A06E6EB58A81E8D4B1E6D0AAE5
              CFA6E4CCA0A58182FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFCAC0C2DFB89EF5D9A6F3D3A0F2CF9DF1CB99F0C695F1CFA8F6EE
              E3F5ECDFF3E8D9F2E6D5F0E2CE996767996767996767AD837CE8D6B5E8D4B1E6
              D0AAE5CFA6A58182FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDFB89EECCEA8F5DAA8F5D8A5F3D2A0F2CF9DF1CB99F2D2AAF8F1
              E9F6EDE2F5EBDFF2E7D8F1E5D4996767996767996767AD837DEAD9BBE8D5B4E7
              D3B0E6D0A9A58182FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDFB89EECD0AAF7E0AEF5DAA8F4D7A4F3D2A0F2CF9DF4D6B0F9F3
              EDF8F1E8F6EDE2F4EBDEF2E7D8996767996767996767AE847EEBDABEEAD8BAE8
              D5B4E7D3AFA58182FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDFB89EEDD4ADF7E2AFF7E0AEF3D3A1EDBC8BEDBC8AF3D4ADFBF7
              F3F9F3EDF8F1E8F6EDE2F4EBDE996767996767996767AE847FEDDEC4EBDABEEA
              D8BAE8D5B4A58182FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDFB89EEED5AFF9E8B5F2CD9C91A9C13695F8458FE4CFBFB5FEFC
              FBFBF7F3F9F3EDF8F1E8F6EDE2E4D3C9D6BFB4C5A69EBF9C93EEE0C8EDDEC4EB
              DABEEAD8BAA58182FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDFB89EEED6B0E7C99E75B3E043A8FF399EFF3597FB4694EDDAE9
              FBFDFAF8FBF7F2F9F2EBF7F0E7F5ECE1F4EADDF2E7D7F1E4D1F0E2CDEEDFC7ED
              DDC4EAD9BDA58182FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFDFB89ECBB6A36AC6F759BEFF4FB4FF45AAFF3BA0FF3597FC4596
              EFDAE9FBFDFAF8FBF7F2F9F2EBF7F0E7F5ECE1F4EADDF2E7D7F1E4D1F0E2CDEE
              DFC7EAD9C1BF9090FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFCBB6A35FC4FF67CCFF65CAFF5ABFFF50B5FF46ABFF3CA1FF3498
              FE4596F1E6F1FCFDFAF8FBF7F2F9F2EBF7F0E7F5ECE1F4EADDF2E7D7F1E4D1EC
              DCCAB89BA5C0949BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF4DB2FF56BBFF5DC2FF66CBFF65CAFF5CC1FF53B8FF48ADFF3FA4
              FF359AFF5DA6F6F3F8FEFDFAF8FBF7F2F9F2EBF7F0E7F5ECE1F4EADDECE1D49E
              92AC9E86A0BFB8C0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF4BAAFC4CB1FF54B9FF5CC1FF66CBFF66CBFF5CC1FF53B8FF49AE
              FF3FA4FF369BFF5CA8F8F2F7FDFCF9F5FAF6F1F8F1EAF7EFE6F5ECE09697B87A
              79A6B2B3C2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFAFC9DD4BAAFC4BB0FF53B8FF5BC0FF65CAFF67CCFF5FC4FF56BB
              FF4CB1FF41A6FF369BFF5BAAFBF2F7FDFCF9F5FAF6F1F8F1EA8C99C2586BABA6
              AEC4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFAFC9DD49A8FC49AEFF50B5FF5ABFFF63C8FF67CCFF60C5
              FF56BBFF4CB1FF43A8FF399EFF5AACFFF2F8FEFCF9F588A7D8486EBA9AA9C6FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFADC7DD48A7FC47ACFF50B5FF59BEFF62C7FF67CC
              FF62C7FF58BDFF4EB3FF43A8FF399EFF5AACFF83B8F33E83DC97B0D2FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFADC7DD59ADF746ABFF4FB4FF58BDFF60C5
              FF67CCFF64C9FF59BEFF50B5FF46ABFF3CA1FF3498FE5A8CE3FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF58ACF743A8FF4EB3FF56BB
              FF5FC4FF66CBFF65CAFF5ABFFF51B6FF388AEC3271E9567ADFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBFCED84CA6FA43A8FF4CB1
              FFFF00FF6AC4FA92CEECA9CFE25F68BA0101992446D1567ADFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8BBDE897C2
              E5BACDDAFF00FFFF00FFFF00FF6569B80101992446D1567ADFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF979DBD65699E7176A5A3AAC0FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton17: TSpeedButton
            Tag = 10
            Left = 168
            Top = 208
            Width = 23
            Height = 22
            Hint = #21047#26032
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA37875A37875A37875A37875A37875A37875A378
              75A37875A37875A37875A37875A37875A37875A37875A37875A37875A37875A3
              78758A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA57976E7BEB8F1BEB8EFBCB7EFBCB7EEBBB7EEBB
              B7EDBAB6ECB9B6ECB9B6EBB8B5EAB7B5EAB7B5E9B6B4E8B5B4E8B5B4E7B4B3E7
              B4968A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA77B76D9D4CEFFE9D3FFE8D0FFE5CCFFE4C9FFE2
              C5FFE1C2FFDEBDFFDDBAFFDBB6FFDAB3FFD7AFFFD5ABFFD3A8FFD1A3FFD0A0FF
              CDC18A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA97E77DBD7D2FFECD8FFE9D3FFE8D0FFE5CCFFE4
              C9FFE2C5FFE1C2FFDEBDFFDDBAFFDBB6FFDAB3FFD7AFFFD6ACFFD3A8FFD1A3FF
              CDC18A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFAC8079DDD9D4FFEDDBFFEBD6FFE9D3019901FFE3
              C8FFE3C8BFD09481BC609FC477DFD4A1FFDBB6FFD8B0FFD7AFFFD6ACFFD3A8FF
              CEC38B5C5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFAE8179DEDAD7FFEFDFFFEDDBFFEBD70199018FC4
              7451B44801990101990101990101990171B651FFDBB6FFDAB3FFD7AFFFD6ACFF
              CEC38C5E5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFB2857BE1DEDAFFF0E2FFEFDFFFEDDB0199010199
              0101990101990101990101990101990101990171B651FFDBB6FFD8B0FFD7AFFF
              CFC58E605EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFB5887CE3E1DEFFF3E7FFF0E2FFEFDF0199010199
              0101990101990131A72781BE6671B957119E0D019901BFCB89FFDBB6FFDAB3FF
              CFC58F6160FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFB98B7EE5E3E1FFF4E9FFF3E6FFF0E20199010199
              010199010199018FC474FFE5CCFFE3C8EFDDB941AB3251AF3CFFDCB9FFDBB6FF
              D0C7926362FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBC8E7FE6E5E3FFF7EFFFF4E9FFF3E60199010199
              01019901019901019901019901FFE5CCFFE3C8EFDDB931A726EFDAB1FFDDBAFF
              D0C7936665FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC09181E9E8E7FFF8F1FFF7EDFFF4E9FFF4E9FFF3
              E6FFF0E2FFF0E2FFE7CFFFE7CFFFE7CFFFE5CCFFE3C8FFE3C8EFDDB9FFDEBDFF
              D1C8956966FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC49581EBEAE9FFFAF7FFF8F081C878FFF4E9FFF3
              E6FFF0E2FFF0E2FFE7CFFFE7CFFFE7CFFFE5CCFFE3C8FFE4C9FFE2C5FFE1C2FF
              D1C8986B69FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC89983EDEDECFFFBF8FFFAF681C97ABFDFB1FFF4
              E9FFF3E6FFF0E2019901019901019901019901019901FFE5CCFFE4CAFFE2C5FF
              D2CA9A6D6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFCB9C85EFEFEFFFFEFEFFFBF8CFE8C9119F10CFE5
              C0FFF4E9FFF3E6EFEBD431A92B019901019901019901FFEDDBFFE5CCFFE4CBFF
              CFC89B6F6DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFCFA086F2F2F2FFFFFFFFFEFEFFFBF841B23F0199
              0181C776DFE9CCDFE7C951B448019901019901019901FFE9D4FFE8D2FFE5CCFF
              C6C09D716FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD3A388F3F3F3FFFFFFFFFFFFFFFEFECFE9CA0199
              01019901019901019901019901019901019901019901FFECDAFFE9D4FFE8D2FF
              BDB79F7471FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD7A789F5F5F5FFFFFFFFFFFFFFFFFFFFFEFE9FD7
              9B01990101990101990101990101990121A41D019901FFE3D6FFBEBEFFAFAFFF
              A1A1A17572FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFDAAA8AF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFE
              FEDFEFD971C46E41B13E41B13D8FCC83EFEDD8019901E7C0ADE6A79AE59E91E4
              988BA27674FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFDEAD8CFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFE
              FEFFFBF8FFFAF7FFF8F1FFF7EDFFF4E9FFF3E6FFF4E9B28074B28074B28074B2
              8074A37875FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE1B08DFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF7EFFFF7EFB28074FFB85CE1A36ACD
              9A81C9B8AFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE4B38EFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF9F2B28074E4AD81D29F83CB
              BDB5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE7B68FFFFFFFFEFEFEFDFDFDFBFBFBF9F9F9F8F8
              F8F7F7F7F5F5F5F3F3F3F2F2F1F0EEEDEEECEAEEECEAB28074D7A485CDBFB6FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFEAB890DCA987DCA987DCA987DCA987DCA987DCA9
              87DCA987DCA987DCA987DCA987DCA987DCA987DCA987B28074CFC1B7FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton18: TSpeedButton
            Tag = 11
            Left = 240
            Top = 208
            Width = 23
            Height = 22
            Hint = #20851#38381#24403#21069#39029#38754
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA37875A37875A37875A37875A37875A37875A378
              75A37875A37875A37875A37875A37875A37875A37875A37875A37875A37875A3
              78758A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA57976E7BEB8F1BEB8EFBCB7EFBCB7EEBBB7EEBB
              B7EDBAB6ECB9B6ECB9B6EBB8B5EAB7B5EAB7B5E9B6B4E8B5B4E8B5B4E7B4B3E7
              B4968A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA77B76D9D4CEFFE9D3FFE8D0FFE5CCFFE4C9FFE2
              C5FFE1C2FFDEBDFFDDBAFFDBB6FFDAB3FFD7AFFFD5ABFFD3A8FFD1A3FFD0A0FF
              CDC18A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA97E77DBD7D2FFECD8FFE9D3FFE8D0FFE5CCFFE4
              C9FFE2C5FFE1C2FFDEBDFFDDBAFFDBB6FFDAB3FFD7AFFFD6ACFFD3A8FFD1A3FF
              CDC18A5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFAC8079DDD9D4FFEDDBFFECD8FFE9D3FFE8D0FFE5
              CCFFE4C9FFE2C5FFE1C2FFDEBDFFDDBAFFDBB6FFDAB3FFD7AFFFD6ACFFD3A8FF
              CEC38B5C5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFAE8179DEDAD7FFEFDFFFEDDBFFECD8FFE9D3FFE8
              D0FFE5CCFFE4C9FFE2C5FFE1C2FFDEBDFFDDBAFFDBB6FFDAB3FFD7AFFFD6ACFF
              CEC38C5E5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFB2857BE1DEDAFFF0E2FFEFDFFFEDDBFFECD8AFB0
              E1EFDCD3FFE5CCFFE4C9FFE2C5CFC0CDFFDEBDFFDDBAFFDBB6FFDAB3FFD7AFFF
              CFC58E605EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFB5887CE3E1DEFFF3E7FFF0E2FFEFDF9FA7E90134
              FF3156F7EFDCD3FFE5CC9FA2DD0134FF6174E6FFDEBDFFDDBAFFDBB6FFDAB3FF
              CFC58F6160FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFB98B7EE5E3E1FFF4E9FFF3E8DFD9E60134FF0134
              FF0134FF3156F78F98E50134FF0134FF0134FF9F9FD8FFDEBDFFDDBAFFDBB6FF
              D0C7926362FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBC8E7FE6E5E3FFF7EFFFF4E9FFF3E89FA9ED0134
              FF0134FF0134FF0134FF0134FF0134FF6176EBFFE2C5FFE1C2FFDEBDFFDDBAFF
              D0C7936665FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC09181E9E8E7FFF8F1FFF7EFFFF4E9FFF3E8BFC1
              EA1140FD0134FF0134FF0134FF6178EEFFE5CCFFE4C9FFE2C5FFE1C2FFDEBDFF
              D1C8956966FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC49581EBEAE9FFFAF7FFF8F1FFF7EFFFF4E99FAB
              F00134FF0134FF0134FF0134FF3156F7EFDDD4FFE5CCFFE4C9FFE2C5FFE1C2FF
              D1C8986B69FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC89983EDEDECFFFBF8FFFAF7FFF8F19FAEF50134
              FF0134FF0134FF0134FF0134FF0134FF3156F7EFDDD4FFE5CCFFE4CAFFE2C5FF
              D2CA9A6D6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFCB9C85EFEFEFFFFEFEFFFBF8DFE2F80134FF0134
              FF0134FF617CF6CFCDE81140FD0134FF0134FF8F99E6FFE8D2FFE5CCFFE4CBFF
              CFC89B6F6DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFCFA086F2F2F2FFFFFFFFFEFEFFFBF89FB0FB0134
              FF617EF9FFF4E9FFF3E8CFCDE81140FD617AF2FFECDAFFE9D4FFE8D2FFE5CCFF
              C6C09D716FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD3A388F3F3F3FFFFFFFFFFFFFFFEFEFFFBF8CFD5
              F9FFF8F1FFF7EFFFF4E9FFF3E8DFD9E6FFEFE1FFEDDBFFECDAFFE9D4FFE8D2FF
              BDB79F7471FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD7A789F5F5F5FFFFFFFFFFFFFFFFFFFFFEFEFFFB
              F8FFFAF7FFF8F1FFF7EFFFF4E9FFF3E8FFF0E2FFEFE1FFE3D6FFBEBEFFAFAFFF
              A1A1A17572FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFDAAA8AF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFE
              FEFFFCF9FFFAF7FFF8F1FFF7EFFFF4E9FFF3E8FFF3E8E7C0ADE6A79AE59E91E4
              988BA27674FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFDEAD8CFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFCF9FFFAF7FFF8F1FFF7EFFFF4E9FFF4E9B28074B28074B28074B2
              8074A37875FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE1B08DFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF7EFFFF7EFB28074FFB85CE1A36ACD
              9A81C9B8AFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE4B38EFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFCF9FFFBF8FFF9F2FFF9F2B28074E4AD81D29F83CB
              BDB5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFE7B68FFFFFFFFEFEFEFDFDFDFBFBFBF9F9F9F8F8
              F8F7F7F7F5F5F5F3F3F3F2F2F1F0EEEDEEECEAEEECEAB28074D7A485CDBFB6FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFEAB890DCA987DCA987DCA987DCA987DCA987DCA9
              87DCA987DCA987DCA987DCA987DCA987DCA987DCA987B28074CFC1B7FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton19: TSpeedButton
            Tag = 10
            Left = 216
            Top = 208
            Width = 23
            Height = 22
            Hint = #28155#21152#21040#25910#34255#22841
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA3BDCAFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA3BDCABCCAD2FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF5995B30181B30E74A3A3BDCAFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCCAD23381A8589FBF1576A3BC
              CAD2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF01679984E7FF01B9EC0E7AAA8AB0C2FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFA3BDCA277AA59FC6D9C1F7FF33A3C697
              B7C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF4088ADCFE2EC21D2FF06C7F9087DAC71A3
              BBFF00FFFF00FFFF00FFFF00FFA3BDCA1E77A3AFDCEC9BEDFF44E2FF1576A3FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF8AB0C2619FBF81E6FF01CCFF1BCFF91493
              BF4C8EB0FF00FFFF00FF7EA9BE1B80ACD2EAF263E0FF0BCFFF1EAFD95995B3FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1D7BA7DFF2F901CCFF0FD1FF33DD
              FF2AA6CC277AA5659CB83A8CB3DBF3F977E9FF12D2FF01CCFF0888B9B0C4CDFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF71A3BB82BAD261DFFF01CCFF22D7
              FF49E4FF44BCD955A8C6F2FFFF92F6FF4EE5FF22D7FF01BFF2277AA5FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCCAD2217AA6CFF5FF01CCFF14D3
              FF38DEFF5FEBFFA4F8FFACFFFF88F9FF61ECFF36DEFF0B9CCC7EA9BEFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4C8EB0B2D6E631D6FF03CD
              FF29DAFF50E6FF74F2FF97FEFF97FEFF72F1FF47E3FF137BAABCCAD2FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7EA9BE469BBF9FECFF01CC
              FF19D4FF3FE1FF66EDFF88F9FF99FFFF81F7FF42C1DF3381A8FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF659CB80E80B001B3E61BD5FF01CC
              FF0BCFFF2EDBFF53E7FF79F4FF99FFFF94FDFF66E7F9209DC63381A8B0C4CDFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF97B7C61A7AA70199CC14D2FF3BDFFF29DAFF0DD0
              FF01CCFF20D7FF44E2FF6BEFFF8DFBFF99FFFF7EF5FF53E7FF22BEE60375A665
              9CB8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFBCCAD24C8EB00181B30BC2F24EE6FF76F3FF58E8FF3BDFFF1ED6
              FF01CCFF0FD1FF36DEFF5AE9FF80F6FF99FFFF8BFAFF66EDFF3BDFFF0FD1FF01
              99CC1A74A197B7C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF0E74A301ACDF1ED6FF84F8FF99FFFF81F7FF66EDFF49E4FF27D9
              FF06CEFF01CCFF25D8FF49E4FF6FF0FF94FDFF99FFFF76F3FF4CE4FF22D7FF01
              CCFF0DC3F20B83B35995B3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF41D2F960E3FFB4F7FFC5FDFFCCFFFFDDFEFFDCFCFFD3F9FFF4FD
              FF34D9FF01CCFF14D3FF3BDFFF61ECFFE1FDFFE6FFFFD6FCFFADF4FF97EEFF73
              E3FF43DAFF62E4FF248FB9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF71A9C681B3CC62AECC60B0CC418CB3348CB31E89B3277AA571A9
              C676E6FF03CDFF06CEFF29DAFF36BDDF1A74A11E83AC348CB3418CB34DA3C665
              AECC81B3CC81B3CC2681ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF7EA9BEFF00FFFF00FFFF00FFBCCAD2FF00FFFF00FFFF00FF3E8A
              B0AEF1FF12D2FF01CCFF19D4FF179AC697B7C6FF00FFFF00FFFF00FF97B7C697
              B7C697B7C67EA9BEB0C4CDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3381
              A8D4F1F922D7FF01CCFF0BCFFF087DACFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF659C
              B8AFCFDF42DEFF0DD0FF01C6F93381A8FF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF97B7
              C671A9C685EAFF1BD5FF01ACDF659CB8FF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF3183ACC3F5FF27D9FF0694C697B7C6FF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF3381A8E4F4F933DDFF087DACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF5995B3A4CEDF53D6F23381A8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFBCCAD2277AA5177DAA8AB0C2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton21: TSpeedButton
            Tag = 10
            Left = 264
            Top = 208
            Width = 23
            Height = 22
            Hint = #25764#28040#20851#38381
            Glyph.Data = {
              66090000424D660900000000000036000000280000001C0000001C0000000100
              18000000000030090000120B0000120B00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFCBCBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAC4C0B9AA9EAA9482
              AF9D8FAC9B8EB2AAA5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFD4D4D4D2D0CFB5A497936F52976C3F896141
              98806CA8A4A1B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFB19D8E875B39BA9452865B3A967E6CABAAAA
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFD5D5D5C1B6AD885D3BD8B562B28B4E8D6B51A6A2A0FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8A89CAB
              834AF1D270BA94528D6C52AAA9A8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFD3D3D3CDCDCDC9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9C9
              C9C9C9C9CACACACBCBCBCDCDCDFFFFFFFFFFFF99795ED2AD5FF1D270B48D4F95
              7C6AB2B2B2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECECEBCBCBCB2B2B2
              B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3B5B5B5BCBC
              BCC8C8C8FFFFFFBEB1A6A47C46F1D270EBCB6D865B3AA7A29EFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF8A5F3C885A35885A35885A35885A35885A35885A35
              885A35885A35885A35885A358D6545906B4D9B7F68C9C8C7FFFFFFD3D1CF8D60
              38F1D270F1D270B99251998372B8B8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF91
              6336F1D270F1D270F1D270F1D270F1D270F1D270F1D270F1D270F1D270F1D270
              BA934F9B7958CAC8C5FFFFFFFFFFFFFFFFFF93683DEDCD6DE8BF56DBB7629672
              50B4B4B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9E6E38F1D270DBA532DBA532DB
              A532DBA532DBA532DBA532E5B94EEDCD6DC0974FA88966CDCCCAFFFFFFFFFFFF
              FFFFFFFFFFFF9F723DEECF6EDDA938EECF6E9F703CB3B3B3FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFAC7A39F2D579DEAA3EDEAA3EDEAA3EDEAA3EDEAA3EDEAA3EF2
              D579D2AB5CAD926FC3C3C3FFFFFFFFFFFFFFFFFFFFFFFFCCC5BBB78843F2D579
              DEAA3EF2D579B07F3DB3B0ACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBB873BF4DB
              89E3B555E3B555E3B555E3B555E3B555E4B859F3D987BA873EAEA79CBBBBBBCE
              CECEFFFFFFFFFFFFFFFFFFC1A882D8B062F4DB89E3B555F4DB89BD8A3EB5B4B1
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9933CF6E09BE9C06FE9C06FE9C06FE9C0
              6FE9C06FE9C06FF6E09BE2BD71BF9A5CB0B0B0BFBFBFFFFFFFFFFFFFC7C2BAC8
              9545F2D992F0D286EBC474F4DC97C89441BCBCBCFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFD49C3DF9E6ACEFCD88EFCD88EFCD88EFCD88EFCD88EFCD88F0D08CF9E6
              ACE3BA6BC1A26BB0AEABB6B6B6BBB4A8CFA050E7C175F9E6ACEFCD88F6DEA0EF
              D28EC9A15CC5C5C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9A13EFAEAB9F7E1AC
              FAEAB9F7E1ACF3D59BF3D59BF3D59BF3D59BF6DDA6FAE9B8E8C175D5A249D2A3
              50DDAA4EEBC981FAEAB9F4D9A1F3D59BFAEAB9E7C074C7AF84CFCFCFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFD9A13EFBEABAF7E2ABE9C378F3DA9EFBEABAF4D69D
              F4D69DF4D69DF4D69DF7DEA8FBEABAF8E3AEF5DEA6FBEABAFBEABAF5D8A0F4D6
              9DF9E5B2F5DDA4D8A345C8C4BDD8D8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9
              A13EFBEABAE7BF71CDB384D7AB5EF3D99DFAE7B6F4D69DF4D69DF4D69DF4D69D
              F4D69DF5DAA3F6DDA7F4D69DF4D69DF4D69DF6DDA7FBEABAE7BF71CBB48BD4D4
              D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9A13EE8C074CFAB6BD1D1D1DA
              C6A3E5BA6AFBEABAF6DDA7F4D69DF4D69DF4D69DF4D69DF4D69DF4D69DF4D69D
              F4D69DFAE9B8FBEABAE7BF73D0AE70FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFD9A13ED6AB5DCFCECCDCDCDCDFDFDFDAB676E7BF71FBEABAFB
              EABAF6DCA5F4D69DF4D69DF4D69DF5DAA3FAE9B8FBEABAF1D697E3B764D3B071
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8A750D9D4
              CCFFFFFFFFFFFFFFFFFFFFFFFFDBBA7EDFAF55EDCD88F7E2ADFBEABAFBEABAFB
              EABAF8E3AEEFD190E3B764D7A64FD5C4A6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED4C3FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFDFD4C2DAB77AD9A74FD9A13EDEAC51D9A13ED7A54CD8B372DAC8AAFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFE0D8C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF}
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton22: TSpeedButton
            Tag = 11
            Left = 96
            Top = 208
            Width = 23
            Height = 22
            Hint = #21069#19968#39029#38754
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9BB69C4382
              45025C06036C0A036508036408015A04014003587C59FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7C0A81074130883160EA5
              260EB4250CB3220AB21C07B01706AF1302A70C018307014C04426C44FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7DAD7F067D1115AA3318B83A15B6
              3412B52F10B42B0CB3230BB32108B11907B01604AF1001AD0B017D07014503FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF8DB78E0782131DB6471DBA471BB94218B8
              3C17B73913B63112B52E0FB4280CB3220AB21E07B01706B01503AE0D01980901
              4503FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFA6C4A709881424BA5523BD5421BC501EBA491CBA
              461AB93F44C560F0FAF2F0FAF24CC7600DB3240CB32109B11B07B01605AF1201
              9309104E12FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF108A1225B55529C06128BF5E25BE5723BD5320BB
              4D48C76AF1FBF3FFFFFFFFFFFF88DA9712B52F0FB4290CB3230BB21F08B11807
              B01503770B8CA68DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF9BC29C129D2A2FC26C2FC26B2BC16429C06026BF5B4DCA
              75F1FBF4FFFFFFFFFFFFF1FBF335C15416B73713B53111B52D0EB4250CB3220A
              B21C07AA16015104FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF42A54426B8582FC26C2FC26C2FC26C2EC26952CC80F2FB
              F5FFFFFFFFFFFFF1FBF448C76B1CBA4519B83D18B83A15B63412B52F10B42B0C
              B3230BB32104780DA7B9A8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF0193022FC26C2FC26C2FC26C2FC26C56CD87F2FBF6FFFF
              FFFFFFFFF2FBF54DCA7622BD521FBB4B1DBA471BB94218B83C17B73813B63112
              B52E0FB4280890176B966CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF0DA11D2FC26C2FC26C2FC26C56CD87F2FBF6FFFFFFFFFF
              FFFFFFFFBCEBCD93DFAE91DEAA91DEA98FDDA58EDDA38DDCA18BDC9D52CA6C15
              B73512B5300DA0232C772FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF0DA61D2FC26C2FC26C56CD87F2FBF6FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8CDCA019
              B83D17B83A12B02F136D16FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF0DA91D2FC26C2FC26C56CD87F2FBF6FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8EDDA31D
              BA461AB94015AE34137516FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF0CAA1734C36F2FC26C2FC26C56CD87F2FBF6FFFFFFFFFF
              FFFFFFFFD8F4E397E1B597E1B597E1B597E1B594E0B194E0AF92DFAD5ACE7F20
              BC4E1DBA4816A636589859FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF01A9024ECA7A43C8782FC26C2FC26C56CD87F2FBF6FFFF
              FFFFFFFFFFFFFF7DD9A32FC26C2FC26C2FC26C2FC26B2CC16629C06027BF5C24
              BD5622BD52129B2D7EAD7FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF58BE584CC66164D18C4FCB8039C5722FC26C56CD87F2FB
              F6FFFFFFFFFFFFFFFFFF7DD9A32FC26C2FC26C2FC26C2FC26C2EC26A2BC16329
              C05F26BE59078412BBC9BBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF13B51687DBA373D5955BCE8645C87A31C36E56CD
              87F2FBF6FFFFFFFFFFFFFFFFFF49CA7F2FC26C2FC26C2FC26C2FC26C2FC26C2C
              C1671FB04A108212FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF57C2565CCD6696DFAC81D99E69D38F54CC823BC5
              7456CD87F2FBF6FFFFFFFFFFFF63D1902FC26C2FC26C2FC26C2FC26C2FC26C2F
              C26C0A8D17FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF01B40192DD9AA2E2B38CDCA677D79860D0
              894CCA7E4ECB81B1E8C897E1B52FC26C2FC26C2FC26C2FC26C2FC26C2FC26C12
              9E2A6AB06BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0EBA0E94DF97AEE5BB9BE0AF82DA
              A06ED49256CD8343C8782FC26C2FC26C2FC26C2FC26C2FC26C2FC26C12A22A2F
              A231FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF10BC1059CF5AB3E7B8A7E3
              B691DEA97CD89B64D18C4FCB8039C5722FC26C2FC26C24B9520A9E1658B159FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8DCE8D0EBB0E4AC9
              4C6BD17476D5837ED89763D08241C46422B7420AA81610A311A8CBA8FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7D1
              A76BC76A2AB82A11B31112B01358BD597DC47EBBCFBBFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton23: TSpeedButton
            Tag = 10
            Left = 72
            Top = 208
            Width = 23
            Height = 22
            Hint = #26032#24314#31354#30333#39029
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA37774A37774A37774A37774A37774A377
              74A37774A37774A37774A37774A37774A37774A37774A37774A37774A37774A3
              77748A5A59FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA37774F5D7CFFFDACEFFD9CCFFD8CBFFD7
              C9FFD6C7FFD5C5FFD4C2FFD4C1FFD2BFFFD2BEFFD0BBFFD0BAFFCEB7FFCEB6FF
              CCB38A5A59FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA57A75F3E6D8FFEBD6FFE9D3FFE7CFFFE5
              CCFFE3C8FFE2C5FFE0C0FFDEBDFFDCB7FFDBB6FFD8B0FFD7AFFFD4A9FFD2A7FF
              CEB78A5A59FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFA87B76F4E7DBFFEDDBFFEBD6FFE9D3FFE7
              CFFFE5CCFFE3C8FFE2C5FFE0C0FFDEBDFFDCB7FFDBB6FFD8B0FFD7AFFFD4A9FF
              D0BA8C5B5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAB7E77F5E9DFFFEFDFFFEDDBFFEBD6FFE9
              D3FFE7CFFFE5CCFFE3C8FFE2C5FFE0C0FFDEBDFFDCB7FFDBB6FFD8B0FFD7AFFF
              D0BB8E5E5BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAF8279F5ECE2FFF0E2FFEFDFFFEDDBFFEB
              D6FFE9D3FFE7CFFFE5CCFFE3C8FFE2C5FFE0C0FFDEBDFFDCB7FFDBB6FFD8B0FF
              D2BE91605EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB4867AF6EEE6FFF3E6FFF0E2FFEFDFFFED
              DBFFEBD6FFE9D3FFE7CFFFE5CCFFE3C8FFE2C5FFE0C0FFDEBDFFDCB7FFDBB6FF
              D2BF93635FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFB88A7CF7F0E9FFF4E9FFF3E6FFF0E2FFEF
              DFFFEDDBFFEBD6FFE9D3FFE7CFFFE5CCFFE3C8FFE2C5FFE0C0FFDEBDFFDCB7FF
              D4C1976662FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBC8E7EF7F2ECFFF7EDFFF4E9FFF3E6FFF0
              E2FFEFDFFFEDDBFFEBD6FFE9D3FFE7CFFFE5CCFFE3C8FFE2C5FFE0C0FFDEBDFF
              D4C29A6964FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC19380F8F4F0FFF8F0FFF7EDFFF4E9FFF3
              E6FFF0E2FFEFDFFFEDDBFFEBD6FFE9D3FFE7CFFFE5CCFFE3C8FFE2C5FFE0C0FF
              D5C59E6C66FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFC69781F9F6F3FFFAF5FFF8F0FFF7EDFFF4
              E9FFF3E6FFF0E2FFEFDFFFEDDBFFEBD6FFE9D3FFE7CFFFE5CCFFE3C8FFE2C5FF
              D6C7A16F68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFCB9B83FAF9F8FFFBF8FFFAF5FFF8F0FFF7
              EDFFF4E9FFF3E6FFF0E2FFEFDFFFEDDBFFEBD6FFE9D3FFE7CFFFE5CCFFE3C8FF
              D7C9A5736BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFCFA085FAFAFAFFFEFEFFFBF8FFFAF5FFF8
              F0FFF7EDFFF4E9FFF3E6FFF0E2FFEFDFFFEDDBFFEBD6FFE9D3FFE7CFFFE5CCFF
              D5C7A8766DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD4A587FBFBFBFFFFFFFFFEFEFFFBF8FFFA
              F5FFF8F0FFF7EDFFF4E9FFF3E6FFF0E2FFEFDFFFEDDBFFEBD6FFE9D3FFE7CFFF
              CEC1AB796EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD9A989FBFBFBFFFFFFFFFFFFFFFEFEFFFB
              F8FFFAF5FFF8F0FFF7EDFFF4E9FFF3E6FFF0E2FFEFDFFFEDDBFFD7CCFFCFC4FF
              B8B2AE7B70FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFDDAD8BFCFCFCFFFFFFFFFFFFFFFFFFFFFE
              FEFFFBF8FFFAF5FFF8F0FFF7EDFFF4E9FFF3E6FFF0E2FFD7CCFFB8B8FFAAAAFF
              9B9BB17D72FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE2B18DFDFDFDFFFFFFFFFFFFFFFFFFFFFF
              FFFFFEFEFFFBF8FFFAF5FFF8F0FFF7EDFFF4E9B27F73B27F73B27F73B27F73B2
              7F73B27F73FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE6B58EFDFDFDFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFEFEFFFBF8FFFAF5FFF8F0FFF7EDB27F73E9B688FDAC3BEF9520CD
              9167CA977EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFEDBB91FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF00FFFFFBF8FFFAF5B27F73E9CDA5DEB08DD3A083D1
              9E82FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFF0BE93FEF1E5FBEEE2F7EBDFF5E9DDF2E5
              DAEEE2D7EBDFD4E9DCD2E6DAD0E2D5CCDFD2C9B27F73FF00FFD8A586D6A385FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFF2C093FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB27F73FF00FFDBA887FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton24: TSpeedButton
            Tag = 11
            Left = 312
            Top = 208
            Width = 23
            Height = 22
            Hint = #24037#20855
            Glyph.Data = {
              F6060000424DF606000000000000360000002800000018000000180000000100
              180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFE6E3E58C8C8C868686B7B6B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFE4E2E3959595818181B1B0B0FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFD0D8EFE8E8EFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBBBB8C8C8C7E
              7E7EDBD9D9FF00FFFF00FFFF00FFFF00FFFF00FF97AEEB658BE77B9EECFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE5E2E3FF00FFFF00FFFF00FFFF00
              FFAEADAE9292928C8C8CB4B3B3FF00FFFF00FFFF00FFFF00FF92AAEB6A8FE876
              9BEC769FEF82AAF3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA5A5A5D6D3D4
              FF00FFFF00FFFF00FF9F9F9F979797919191B8B6B5FF00FFFF00FFFF00FF93AB
              EB6A8FE8759AEC79A1F07CA6F37CAAF589B4F7FF00FFFF00FFFF00FFFF00FFFF
              00FFB9B9B9A5A5A5C4C3C4BCBBBBA9A8A99F9F9F9C9C9C959595BAB7B3E3E3EB
              CAD3EE9FB5ED6A8EE8759AEC79A0F07CA6F37FABF583B2F883B5FA8FBEFBFF00
              FFFF00FFFF00FFFF00FFDCDADBB2B2B2AFAFAFABABABA9A9A9A4A4A4A0A0A09E
              9D988B91A17E9DE477A0F17DACF678A0EF78A0EF7CA4F380ACF682B1F885B5FB
              88BBFD88BEFF93C5FEFF00FFFF00FFFF00FFFF00FFD0CFCFB0B0B0ADADADA9A9
              A9A5A5A5A6A5A0969DAD7596E478A3F383B2F98DC2FF89BDFE7CA6F3789FEF79
              A1F086B8FC88BBFD8CBFFF8FC3FF91C6FF9DCDFEFF00FFFF00FFFF00FFFF00FF
              FF00FFD9D7D8D6D5D5D5D4D1A1A7B57596E479A2F383B2F98ABFFF97CBFF97CA
              FF87B7FC7FAAF5759AED7CA5F28CC1FF90C4FF93C8FF97CBFF97CBFFA4D1FDFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF809FE977A2F283B2F98BBEFF
              98CBFF8FC3FF92C5FF92C6FF87B9FC80ABF57599EC7EAAF497CAFF97CBFF99CC
              FF94C9FFD4E4F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8BA8ED77A0F183
              B2F98ABFFF98CCFF8EC3FF779EEE86B8FC9ACDFF92C5FF87B9FC7FABF57499EC
              80ADF79ACEFF94CAFFD0E2F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9AB2
              EE749FEF83B2F98ABFFF99CCFF8FC3FF789FEF7DA7F285B5FB95C9FF9ACEFF92
              C6FF88BAFC7FABF57498EC7EACF7D0E4F8FF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFAAC3F27DAEF88CBFFF98CCFF8EC3FF779EEE7DA8F386B8FB91C5
              FF98CBFF8ABEFF98CBFF92C6FF88B8FD7FABF57499ECDCDFEEFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4CBFD98CBFF8DC2FF789EEE7DA8F3
              86B6FB91C5FF9ACDFF82B1F7769DED89BDFE99CDFF91C6FF86B9FC7EAAF5DADF
              F1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCBDCF679
              9FEE7CA7F386B6FB90C4FF9ACEFF83B0F8779CEE81AEF788BBFD98CBFF99CEFF
              94C6FFC5D9F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFA0C0F57EB2FB90C4FF9ACEFF83B2F8779CEE81B0F789BCFE96
              C9FF93C7FB95AEC897A8BCB6B6B8B5B3B2D4D2D3EEEAEBFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAED2FC9ACDFF82B1F8779CEE81AE
              F789BCFE94C8FF94C9FD9EA8B29C97939794929191908B8B8B808080B1B0B1FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCAD9F3
              789DEE81AEF68ABDFE91C7FF9DCEFEA7B1BBA4A29EA0A0A09C9C9C9797979292
              928C8C8C808080BFBDBDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FF9BBFF784B9FE90C6FFABD5FDEDEDEFD6D3D2A5A5A5A4A4A4
              A0A0A0A09F9FAFAEAEBAB9BA939393848383FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB7D7FBB7D9FCEDEDEFEDEAECD6
              D4D4A9A9A9A9A9A9AAAAAAFF00FFFF00FFFF00FFE5E3E38B8B8BFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFD8D6D7ADADADABABABBCBBBBFF00FFFF00FFFF00FFFF00FFE5
              E3E4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFE9E7E8B0B0B0AFAFAFC5C4C4FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0D0D0B1B1B1
              A6A6A6D7D4D5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFD8D7D7BABABAA6A5A5E8E5E6FF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object SpeedButton25: TSpeedButton
            Tag = 10
            Left = 288
            Top = 208
            Width = 23
            Height = 22
            Hint = 'TOP'#36873#39033
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC0C5C6A19997C3A1
              8EAE8F8C83756FD5A796FFD7D0D6A694788084CDD1D1898F92CACCCCC2C1C1FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC0C5C6D6BBB3D9A493FFDA
              D3FFB7B7C3B9B1FEB4B5FFD4CAFFBDBD6B5551AC8B86DD9A89263031BAC0BFC1
              C1C1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1C7CAA499957E706ABFA190FFD9
              D0F4B0AFFFDACFF4B0AFFFD7CCF5B3B1FFBBBAFFDBD1FFDCD4E7B09E9A9FA2C3
              C3C3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5C29B88D9A998D9A999D0A695F9B4
              B4F6B6B4F5B3B1F6B6B4F5B3B1F6B6B4F6B6B4F5B3B1F9B3B4CA8F7EC1C9CAC4
              C9CAC4C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC2C4D9A594FDB6B8FFDFD6F9B5B5F6B6
              B4F6B6B4FCB4B2FCB4B2FCB4B2FBB6B4FAB7B7F5B3B1FFE2D8A689846C7C8098
              5F5B959B9DC4C4C4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5BC9B87FFC0C1EA817EF6B8B6F6B6
              B4FFB4B3B2C2C3B9C1C1B7C2C3CAB5ACD0A28FFEBDBEEA807DFFBFBDFFC0BDFF
              CAC8253230CCCCCDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBCC2C4D2BEB8C08C7CFCBDBDEC8481FFBD
              BEC5B2A8BEC1C2FF00FFFF00FFBCC2C4CEB6AFD1A493FBC0C0F6B8B6ED8582F1
              B4B4D69381BEC4C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC1C2D3BBB3A28480D4AE9CF08684F8BAB8C790
              7EC7D5D7BFBEBEFF00FFFF00FFFF00FFBDC4C7BC9D89F78D8CED8885F2B6B3FE
              8B89E0DED6BDBEBFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC4C6C88C7CFFC2C2FABBBBF7BEBCFFC2C19162
              60C2C7C8FF00FFFF00FFFF00FFFF00FFBDBEBFDED5CEC28E7EFDC2C1FFC4C264
              5956737D82CDCECDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC4C6C99180F58C8CEE8F8CEE8F8CFA9491755F
              5BC8CBCBFF00FFFF00FFFF00FFFF00FFFF00FFBCC2C5BFA391F38D8CEE8F8CFF
              9B99AD70677C8589FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBEC1C2CFB8B1D3A996F78F8FEF9491FB98957460
              5DB8C2C0C1C1C1FF00FFFF00FFFF00FFFF00FFBFC3C5BFA391F49290EF9491EF
              9491FF9B997A615DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBEC1C2BCC9CFB8AA94F49290F69794AF76
              6E7D8286C9C9C8FF00FFFF00FFFF00FFFF00FFBEC4C6CA9383F39391EF9491F6
              9794FB8E8CA5A29DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC3C6C2A38FDD666AF19794F19794EC74
              762F4440B9BDC9C4C3C2FF00FFFF00FFFF00FFBFCACCC49584F39391F69794A1
              6E67D6C9C0C0C5C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFBDBFC1D8C7BAC89183F89A97EF9491F19794F89C
              99C162602E3E3CC4CAC9C8CBCBC4C3C3C2CBCCA68C85FA9391EF9491FA9D9A91
              5552795D5AC8CBCBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDC3C6BFA28EDD6265F99591D6696CF39B
              97FEA09DC7756A2D44437E5F5B91AEACAD938CE36D6FF39B97F19794D46D6EFF
              A5A1735D5CB3BCBBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFBDBEBFE0D1C8B9C7C8B8CACCC99C8ADB70
              72D77171FCA29EE97878EA797AB46F63E47476DC7878D77171F99B9ADB7072DB
              6D71C08C6AC2C7CAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBDBEBFFF00FFBCC6C8C99C8ADE73
              75DC7878D97474DC7878DC7878E17A7BDC7878DC7878E1777AB59878CFA090FF
              8B89BACBCEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBEC1C2D0BAAFE2666BE078
              79DC7878DE7274E07578DC7878C75959DF7678DD7A7ACE5A5B9A59586E7D83C1
              CCCCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBDC4C7C4A892B266
              5CE6696CBEAD9BB79A7BCB5558DF7779C9A693E06E71DF7778B4655BDAC1B7BE
              C1C2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBFC3C5C0C9
              CABAC8CAD9CFC3B25F58E77376B0675CAD8F8CBFAA94FE8887ECE2D6BABFC1FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFBBBFC2D8CDC0C9B8B0F0DED2BDC3C5BFC3C5BAC5C5BBBEBFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFBDBFC1BEC1C2BBBEBFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object Label56: TLabel
            Left = 16
            Top = 184
            Width = 348
            Height = 12
            Caption = #26631#20934#25353#38062#30340#26159#21542#26174#31034#65306'('#22914#26524#21246#36873#21017#26174#31034#65292#19981#21246#36873#21017#21024#38500#35813#25353#38062#12290')'
            Visible = False
          end
          object SpeedButton36: TSpeedButton
            Tag = 11
            Left = 336
            Top = 208
            Width = 33
            Height = 22
            Hint = #24037#20855
            Caption = '--'
            ParentShowHint = False
            ShowHint = True
            Visible = False
          end
          object Label48: TLabel
            Left = 16
            Top = 56
            Width = 78
            Height = 12
            Caption = #27492#21151#33021#26410#24320#25918'.'
            Visible = False
          end
          object CheckBox1: TCheckBox
            Left = 80
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 0
            Visible = False
            OnClick = CheckBox1Click
          end
          object CheckBox2: TCheckBox
            Left = 104
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 1
            Visible = False
            OnClick = CheckBox2Click
          end
          object CheckBox3: TCheckBox
            Left = 128
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 2
            Visible = False
            OnClick = CheckBox3Click
          end
          object CheckBox4: TCheckBox
            Left = 152
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 3
            Visible = False
            OnClick = CheckBox4Click
          end
          object CheckBox5: TCheckBox
            Left = 176
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 4
            Visible = False
            OnClick = CheckBox5Click
          end
          object CheckBox6: TCheckBox
            Left = 200
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 5
            OnClick = CheckBox6Click
          end
          object CheckBox7: TCheckBox
            Left = 224
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 6
            Visible = False
            OnClick = CheckBox7Click
          end
          object CheckBox8: TCheckBox
            Left = 248
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 7
            Visible = False
            OnClick = CheckBox8Click
          end
          object CheckBox9: TCheckBox
            Left = 272
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 8
            OnClick = CheckBox9Click
          end
          object CheckBox11: TCheckBox
            Left = 320
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 9
            Visible = False
            OnClick = CheckBox11Click
          end
          object CheckBox10: TCheckBox
            Left = 296
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 10
            Visible = False
            OnClick = CheckBox10Click
          end
          object CheckBox12: TCheckBox
            Left = 344
            Top = 232
            Width = 17
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 11
            Visible = False
          end
        end
      end
      object TabSheetMousssTable: TTabSheet
        Caption = #40736#26631#25163#21183
        ImageIndex = 6
        object Panel17: TPanel
          Left = 0
          Top = 0
          Width = 582
          Height = 317
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object GroupBox8: TGroupBox
            Left = 8
            Top = 8
            Width = 265
            Height = 289
            Caption = #40736#26631#25163#21183#65306
            TabOrder = 0
            object SpeedButton27: TSpeedButton
              Left = 8
              Top = 56
              Width = 41
              Height = 22
              Flat = True
              Glyph.Data = {
                36060000424D360600000000000036000000280000001F000000100000000100
                1800000000000006000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C9
                21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
                0000000000000000000000000000000000000000FFFFFF000000FFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000000000000000000000000000FFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFF00C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFF00C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C9
                21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
            end
            object SpeedButton28: TSpeedButton
              Left = 8
              Top = 88
              Width = 41
              Height = 22
              Flat = True
              Glyph.Data = {
                76050000424D76050000000000003600000028000000200000000E0000000100
                1800000000004005000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C9
                21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFF00C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFFFF00C92100C92100C9
                2100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
                0000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C9
                21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            end
            object SpeedButton29: TSpeedButton
              Left = 8
              Top = 120
              Width = 41
              Height = 22
              Flat = True
              Glyph.Data = {
                76060000424D7606000000000000360000002800000021000000100000000100
                1800000000004006000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C921FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C921
                00C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C9
                2100C92100C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000000000000000000000000000000000000000000000000000000000
                FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100
                C92100C92100C92100C92100C92100C92100C92100C921FFFFFFFFFFFFFFFFFF
                FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00C92100C92100C921
                FFFFFF00C92100C92100C92100C92100C92100C92100C92100C921FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF00C92100C92100C9
                21FFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C92100
                C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF00C92100
                C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
                FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                00C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF00C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
                0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                FFFFFFFF00C92100C92100C921FFFFFFFFFFFF00C92100C92100C92100C92100
                C92100C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF00FFFFFFFFFFFFFFFFFF00C92100C92100C921FFFFFF00C92100C92100C921
                00C92100C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF00FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C92100C9
                2100C92100C92100C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFF00
                0000000000000000000000000000000000000000000000000000000000000000
                FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100
                C92100C92100C92100C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF0000
                00FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C921
                00C92100C92100C92100C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
            end
            object SpeedButton31: TSpeedButton
              Left = 8
              Top = 152
              Width = 41
              Height = 22
              Flat = True
              Glyph.Data = {
                D6050000424DD6050000000000003600000028000000200000000F0000000100
                180000000000A005000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C9
                21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C92100C9
                2100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C92100C92100C92100C92100C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
                0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C92100C92100C92100C921FFFFFF00C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C92100C92100C92100C921FFFFFFFFFF
                FF00C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF00C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF00C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
                0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                00C92100C92100C92100C92100C92100C92100C92100C92100C921FFFFFFFFFF
                FF00C92100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C92100C92100C92100C921FFFFFF00C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFF00C92100C92100C92100C92100C92100C92100C92100C92100C92100C9
                2100C92100C921FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
                0000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C92100C9
                2100C921FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00C92100C92100C92100C92100C92100C92100C92100C9
                21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00C92100C92100C92100C921FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            end
            object SpeedButton32: TSpeedButton
              Left = 8
              Top = 184
              Width = 49
              Height = 22
              Flat = True
              Glyph.Data = {
                36080000424D360800000000000036000000280000002A000000100000000100
                1800000000000008000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF6FD6006FD6006FD6006FD600FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFF6FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD600FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                6FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD600FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF0000FFFFFF6FD600
                6FD6006FD600FFFFFFFFFFFF6FD6006FD6006FD6006FD6006FD6006FD6006FD6
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
                000000000000000000000000000000FFFFFFFFFFFFFFFFFF0000FFFFFF6FD600
                6FD6006FD600FFFFFFFFFFFF6FD6006FD6006FD6006FD6006FD6006FD6006FD6
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00006FD6006FD600
                6FD6006FD600FFFFFFFFFFFF6FD6006FD600FFFFFF6FD6006FD6006FD6006FD6
                006FD600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00006FD6006FD600
                6FD6006FD600FFFFFFFFFFFF6FD6006FD600FFFFFFFFFFFF6FD6006FD6006FD6
                006FD600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00006FD6006FD600
                6FD6006FD600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FD6006FD6
                006FD600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
                000000000000000000000000000000FFFFFFFFFFFFFFFFFF00006FD6006FD600
                6FD6006FD6006FD600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FD6006FD6
                006FD600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
                0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF6FD600
                6FD6006FD6006FD6006FD6006FD6006FD600FFFFFFFFFFFF6FD6006FD6006FD6
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF6FD600
                6FD6006FD6006FD6006FD6006FD6006FD600FFFFFF6FD6006FD6006FD6006FD6
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000
                000000000000000000000000000000000000FFFFFFFFFFFF0000FFFFFFFFFFFF
                6FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD600FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFF6FD6006FD6006FD6006FD6006FD6006FD6006FD6006FD600FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF6FD6006FD6006FD6006FD600FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
            end
            object SpeedButton33: TSpeedButton
              Left = 8
              Top = 216
              Width = 49
              Height = 22
              Flat = True
              Glyph.Data = {
                C6090000424DC60900000000000036000000280000002D000000120000000100
                1800000000009009000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2
                C000C2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFC2C000C2C000C2C000C2C000C2C000C2C000C2C000C2C000FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                FFFFFFFFFFFFC2C000C2C000C2C000C2C000C2C000C2C000C2C000C2C000C2C0
                00C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FF00FFFFFFFFFFFFFFFFFFC2C000C2C000C2C000C2C000C2C000C2C000C2C000
                FFFFFFC2C000C2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000000000000000000000000000000000000000FFFFFF
                FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFC2C000C2C000C2C000C2C000C2
                C000C2C000C2C000FFFFFFFFFFFFC2C000C2C000C2C000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFC2C000C2C000C2C0
                00C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2C000C2C000C2
                C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                C2C000C2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFC2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000
                000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
                FF00FFFFFFFFFFFFC2C000C2C000C2C000C2C000FFFFFFFFFFFFC2C000C2C000
                FFFFFFFFFFFFC2C000C2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF000000000000000000000000000000000000000000FFFFFF
                FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFC2C000C2C000C2C000C2C000FFFFFFFF
                FFFFC2C000C2C000FFFFFFC2C000C2C000C2C000C2C000C2C000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFC2C000C2C0
                00C2C000FFFFFFFFFFFFC2C000C2C000C2C000C2C000C2C000C2C000C2C000FF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                FFFFFFC2C000C2C000C2C000FFFFFFFFFFFFC2C000C2C000C2C000C2C000C2C0
                00C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
                000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
                FF00FFFFFFFFFFFFFFFFFFFFFFFFC2C000C2C000C2C000C2C000C2C000C2C000
                C2C000C2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
                00000000000000000000000000000000000000000000000000000000FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2C000C2C000C2
                C000C2C000C2C000C2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFC2C000C2C000C2C000C2C000FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF00}
            end
            object CBSSTop: TComboBox
              Left = 56
              Top = 56
              Width = 193
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              TabOrder = 1
              OnChange = CBSSTopChange
              Items.Strings = (
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #20999#25442#21040#21069#19968#20010#27983#35272#39029
                #20999#25442#21040#21518#19968#20010#27983#35272#39029
                #21518#36864
                #21069#36827
                #24674#22797#21018#20851#38381#30340#27983#35272#31383#21475
                #20851#38381#24403#21069#30340#27983#35272#31383#21475
                #21047#26032'('#37325#26032#35775#38382')'#24403#21069#30340#32593#39029
                #20572#27490#24403#21069#30340#32593#39029
                #24320#21551#26032#30340#27983#35272#31383#21475
                #35775#38382#39318#39029
                #20851#38381#25152#26377#30340#27983#35272#31383#21475
                #27983#35272#39029#38754#28378#21160#21040#39318#37096
                #27983#35272#39029#38754#28378#21160#21040#23614#37096
                #20851#38381#20840#37096#21518#38754#30340#31383#21475
                #25918#22823#39029#38754
                #32553#23567#39029#38754
                #32593#39029#25991#23383#20943#23567
                #32593#39029#25991#23383#21152#22823)
            end
            object CBUseSS: TCheckBox
              Left = 16
              Top = 24
              Width = 97
              Height = 17
              Caption = #20351#29992#40736#26631#25163#21183#12288
              TabOrder = 2
              OnClick = CBUseSSClick
            end
            object ButtonSSOK: TButton
              Left = 168
              Top = 248
              Width = 67
              Height = 25
              Caption = #30830#23450
              Enabled = False
              TabOrder = 0
              OnClick = ButtonSSOKClick
            end
            object CBSSButtom: TComboBox
              Left = 56
              Top = 88
              Width = 193
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              TabOrder = 3
              OnChange = CBSSButtomChange
              Items.Strings = (
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #20999#25442#21040#21069#19968#20010#27983#35272#39029
                #20999#25442#21040#21518#19968#20010#27983#35272#39029
                #21518#36864
                #21069#36827
                #24674#22797#21018#20851#38381#30340#27983#35272#31383#21475
                #20851#38381#24403#21069#30340#27983#35272#31383#21475
                #21047#26032'('#37325#26032#35775#38382')'#24403#21069#30340#32593#39029
                #20572#27490#24403#21069#30340#32593#39029
                #24320#21551#26032#30340#27983#35272#31383#21475
                #35775#38382#39318#39029
                #20851#38381#25152#26377#30340#27983#35272#31383#21475
                #27983#35272#39029#38754#28378#21160#21040#39318#37096
                #27983#35272#39029#38754#28378#21160#21040#23614#37096
                #20851#38381#20840#37096#21518#38754#30340#31383#21475
                #25918#22823#39029#38754
                #32553#23567#39029#38754
                #32593#39029#25991#23383#20943#23567
                #32593#39029#25991#23383#21152#22823)
            end
            object CBSSLeft: TComboBox
              Left = 56
              Top = 120
              Width = 193
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              TabOrder = 4
              OnChange = CBSSLeftChange
              Items.Strings = (
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #20999#25442#21040#21069#19968#20010#27983#35272#39029
                #20999#25442#21040#21518#19968#20010#27983#35272#39029
                #21518#36864
                #21069#36827
                #24674#22797#21018#20851#38381#30340#27983#35272#31383#21475
                #20851#38381#24403#21069#30340#27983#35272#31383#21475
                #21047#26032'('#37325#26032#35775#38382')'#24403#21069#30340#32593#39029
                #20572#27490#24403#21069#30340#32593#39029
                #24320#21551#26032#30340#27983#35272#31383#21475
                #35775#38382#39318#39029
                #20851#38381#25152#26377#30340#27983#35272#31383#21475
                #27983#35272#39029#38754#28378#21160#21040#39318#37096
                #27983#35272#39029#38754#28378#21160#21040#23614#37096
                #20851#38381#20840#37096#21518#38754#30340#31383#21475
                #25918#22823#39029#38754
                #32553#23567#39029#38754
                #32593#39029#25991#23383#20943#23567
                #32593#39029#25991#23383#21152#22823)
            end
            object CBSSRight: TComboBox
              Left = 56
              Top = 152
              Width = 193
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              TabOrder = 5
              OnChange = CBSSRightChange
              Items.Strings = (
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #20999#25442#21040#21069#19968#20010#27983#35272#39029
                #20999#25442#21040#21518#19968#20010#27983#35272#39029
                #21518#36864
                #21069#36827
                #24674#22797#21018#20851#38381#30340#27983#35272#31383#21475
                #20851#38381#24403#21069#30340#27983#35272#31383#21475
                #21047#26032'('#37325#26032#35775#38382')'#24403#21069#30340#32593#39029
                #20572#27490#24403#21069#30340#32593#39029
                #24320#21551#26032#30340#27983#35272#31383#21475
                #35775#38382#39318#39029
                #20851#38381#25152#26377#30340#27983#35272#31383#21475
                #27983#35272#39029#38754#28378#21160#21040#39318#37096
                #27983#35272#39029#38754#28378#21160#21040#23614#37096
                #20851#38381#20840#37096#21518#38754#30340#31383#21475
                #25918#22823#39029#38754
                #32553#23567#39029#38754
                #32593#39029#25991#23383#20943#23567
                #32593#39029#25991#23383#21152#22823)
            end
            object CBSSRightTop: TComboBox
              Left = 64
              Top = 184
              Width = 185
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              TabOrder = 6
              OnChange = CBSSRightTopChange
              Items.Strings = (
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #20999#25442#21040#21069#19968#20010#27983#35272#39029
                #20999#25442#21040#21518#19968#20010#27983#35272#39029
                #21518#36864
                #21069#36827
                #24674#22797#21018#20851#38381#30340#27983#35272#31383#21475
                #20851#38381#24403#21069#30340#27983#35272#31383#21475
                #21047#26032'('#37325#26032#35775#38382')'#24403#21069#30340#32593#39029
                #20572#27490#24403#21069#30340#32593#39029
                #24320#21551#26032#30340#27983#35272#31383#21475
                #35775#38382#39318#39029
                #20851#38381#25152#26377#30340#27983#35272#31383#21475
                #27983#35272#39029#38754#28378#21160#21040#39318#37096
                #27983#35272#39029#38754#28378#21160#21040#23614#37096
                #20851#38381#20840#37096#21518#38754#30340#31383#21475
                #25918#22823#39029#38754
                #32553#23567#39029#38754
                #32593#39029#25991#23383#20943#23567
                #32593#39029#25991#23383#21152#22823)
            end
            object CBSSRightButtom: TComboBox
              Left = 64
              Top = 216
              Width = 185
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              TabOrder = 7
              OnChange = CBSSRightButtomChange
              Items.Strings = (
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #26080#21160#20316
                #20999#25442#21040#21069#19968#20010#27983#35272#39029
                #20999#25442#21040#21518#19968#20010#27983#35272#39029
                #21518#36864
                #21069#36827
                #24674#22797#21018#20851#38381#30340#27983#35272#31383#21475
                #20851#38381#24403#21069#30340#27983#35272#31383#21475
                #21047#26032'('#37325#26032#35775#38382')'#24403#21069#30340#32593#39029
                #20572#27490#24403#21069#30340#32593#39029
                #24320#21551#26032#30340#27983#35272#31383#21475
                #35775#38382#39318#39029
                #20851#38381#25152#26377#30340#27983#35272#31383#21475
                #27983#35272#39029#38754#28378#21160#21040#39318#37096
                #27983#35272#39029#38754#28378#21160#21040#23614#37096
                #20851#38381#20840#37096#21518#38754#30340#31383#21475
                #25918#22823#39029#38754
                #32553#23567#39029#38754
                #32593#39029#25991#23383#20943#23567
                #32593#39029#25991#23383#21152#22823)
            end
          end
          object GroupBox5: TGroupBox
            Left = 280
            Top = 8
            Width = 281
            Height = 289
            Caption = #33258#21160#22635#34920#65306
            TabOrder = 1
            object Label28: TLabel
              Left = 32
              Top = 64
              Width = 42
              Height = 12
              Caption = #29992#25143#21517':'
            end
            object Label29: TLabel
              Left = 32
              Top = 88
              Width = 30
              Height = 12
              Caption = #23494#30721':'
            end
            object Label30: TLabel
              Left = 32
              Top = 40
              Width = 30
              Height = 12
              Caption = #26165#31216':'
            end
            object Label34: TLabel
              Left = 32
              Top = 136
              Width = 36
              Height = 12
              Caption = 'email:'
            end
            object Label35: TLabel
              Left = 32
              Top = 160
              Width = 42
              Height = 12
              Caption = #30495#21517#23383':'
            end
            object Label47: TLabel
              Left = 32
              Top = 112
              Width = 30
              Height = 12
              Caption = #31572#26696':'
            end
            object ENickName: TEdit
              Left = 88
              Top = 32
              Width = 121
              Height = 20
              TabOrder = 0
              OnChange = ENickNameChange
              OnKeyPress = ENickNameKeyPress
            end
            object BInputTable: TButton
              Left = 200
              Top = 256
              Width = 67
              Height = 25
              Caption = #30830#23450
              TabOrder = 5
              OnClick = BInputTableClick
            end
            object EUserName: TEdit
              Left = 88
              Top = 56
              Width = 121
              Height = 20
              TabOrder = 1
              OnChange = EUserNameChange
              OnKeyPress = EUserNameKeyPress
            end
            object EPassWord: TEdit
              Left = 88
              Top = 80
              Width = 121
              Height = 20
              TabOrder = 2
              OnChange = EPassWordChange
              OnKeyPress = EPassWordKeyPress
            end
            object EEmail: TEdit
              Left = 88
              Top = 128
              Width = 121
              Height = 20
              TabOrder = 3
              OnChange = EEmailChange
              OnKeyPress = EEmailKeyPress
            end
            object ERealName: TEdit
              Left = 88
              Top = 152
              Width = 121
              Height = 20
              TabOrder = 4
              OnChange = ERealNameChange
              OnKeyPress = ERealNameKeyPress
            end
            object EAnswer: TEdit
              Left = 88
              Top = 104
              Width = 121
              Height = 20
              TabOrder = 6
              OnChange = EAnswerChange
              OnKeyPress = EAnswerKeyPress
            end
          end
        end
      end
      object TabSheetQuickLink: TTabSheet
        Caption = #24555#25463#32593#22336
        ImageIndex = 5
        object Panel16: TPanel
          Left = 0
          Top = 0
          Width = 582
          Height = 317
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label45: TLabel
            Left = 16
            Top = 248
            Width = 60
            Height = 12
            Caption = #32593#31449#21517#31216#65306
          end
          object Label46: TLabel
            Left = 216
            Top = 248
            Width = 36
            Height = 12
            Caption = #32593#22336#65306
          end
          object SpeedButton20: TSpeedButton
            Left = 544
            Top = 112
            Width = 23
            Height = 22
            Hint = #21521#19978#35843#33410#27468#26354#39034#24207
            Glyph.Data = {
              2A020000424D2A02000000000000360000002800000006000000190000000100
              180000000000F401000000000000000000000000000000000000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              EC0000000000000000000000000000000000D8E9ECD8E9EC0000000000000000
              00D8E9EC0000D8E9ECD8E9ECD8E9EC000000D8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton20Click
          end
          object SpeedButton26: TSpeedButton
            Left = 544
            Top = 141
            Width = 23
            Height = 22
            Hint = #21521#19979#35843#33410#27468#26354#39034#24207
            Glyph.Data = {
              2A020000424D2A02000000000000360000002800000006000000190000000100
              180000000000F401000000000000000000000000000000000000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC000000D8E9ECD8E9ECD8E9EC
              0000D8E9EC000000000000000000D8E9ECD8E9EC000000000000000000000000
              0000000000D8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton26Click
          end
          object ListBoxQuickLink: TListBox
            Left = 16
            Top = 8
            Width = 521
            Height = 217
            ItemHeight = 12
            MultiSelect = True
            PopupMenu = PopupMenuQuickLink
            TabOrder = 0
            OnDblClick = ListBoxQuickLinkDblClick
          end
          object EQLTitle: TEdit
            Left = 80
            Top = 240
            Width = 121
            Height = 20
            TabOrder = 1
            OnKeyDown = EQLTitleKeyDown
            OnKeyPress = EQLTitleKeyPress
          end
          object EQLUrl: TEdit
            Left = 256
            Top = 240
            Width = 305
            Height = 20
            TabOrder = 2
            OnKeyDown = EQLUrlKeyDown
            OnKeyPress = EQLUrlKeyPress
          end
          object BQuickLinkOK: TButton
            Left = 488
            Top = 280
            Width = 75
            Height = 25
            Caption = #30830'  '#23450
            Enabled = False
            TabOrder = 3
            OnClick = BQuickLinkOKClick
          end
          object BAddQuickLink: TButton
            Left = 392
            Top = 280
            Width = 91
            Height = 25
            Caption = #28155#21152#21040#24555#25463#32452
            TabOrder = 4
            OnClick = BAddQuickLinkClick
          end
          object BLoadQuickLink: TButton
            Left = 16
            Top = 280
            Width = 97
            Height = 25
            Caption = #36733#20837#24555#25463#32593#22336
            TabOrder = 5
            OnClick = BLoadQuickLinkClick
          end
          object Button3: TButton
            Left = 120
            Top = 280
            Width = 89
            Height = 25
            Caption = #21047#26032#24555#25463#33756#21333
            TabOrder = 6
            Visible = False
            OnClick = Button3Click
          end
        end
      end
      object TabSheetProxy: TTabSheet
        Caption = #20195#29702#36873#39033
        ImageIndex = 7
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 582
          Height = 317
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label31: TLabel
            Left = 88
            Top = 248
            Width = 60
            Height = 12
            Caption = #20195#29702#22320#22336#65306
          end
          object Label38: TLabel
            Left = 304
            Top = 248
            Width = 48
            Height = 12
            Caption = #31471#21475#21495#65306
          end
          object SpeedButton34: TSpeedButton
            Left = 544
            Top = 112
            Width = 23
            Height = 22
            Hint = #21521#19978#35843#33410#27468#26354#39034#24207
            Glyph.Data = {
              2A020000424D2A02000000000000360000002800000006000000190000000100
              180000000000F401000000000000000000000000000000000000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              EC0000000000000000000000000000000000D8E9ECD8E9EC0000000000000000
              00D8E9EC0000D8E9ECD8E9ECD8E9EC000000D8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton34Click
          end
          object SpeedButton35: TSpeedButton
            Left = 544
            Top = 141
            Width = 23
            Height = 22
            Hint = #21521#19979#35843#33410#27468#26354#39034#24207
            Glyph.Data = {
              2A020000424D2A02000000000000360000002800000006000000190000000100
              180000000000F401000000000000000000000000000000000000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC000000D8E9ECD8E9ECD8E9EC
              0000D8E9EC000000000000000000D8E9ECD8E9EC000000000000000000000000
              0000000000D8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
              0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8
              E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9
              ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9
              ECD8E9EC0000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000D8E9ECD8E9EC
              D8E9ECD8E9ECD8E9ECD8E9EC0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton35Click
          end
          object EProxyAddress: TEdit
            Left = 152
            Top = 240
            Width = 121
            Height = 20
            TabOrder = 0
            OnKeyPress = EProxyAddressKeyPress
          end
          object EProxyNumber: TEdit
            Left = 360
            Top = 240
            Width = 57
            Height = 20
            TabOrder = 1
            OnKeyPress = EProxyNumberKeyPress
          end
          object BProxySetOK: TButton
            Left = 488
            Top = 280
            Width = 75
            Height = 25
            Caption = #30830'  '#23450
            Enabled = False
            TabOrder = 2
            OnClick = BProxySetOKClick
          end
          object BAddToProxyList: TButton
            Left = 384
            Top = 280
            Width = 99
            Height = 25
            Caption = #28155#21152#21040#20195#29702#21015#34920
            TabOrder = 3
            OnClick = BAddToProxyListClick
          end
          object BLoadProxyList: TButton
            Left = 16
            Top = 280
            Width = 97
            Height = 25
            Caption = #36733#20837#20195#29702#21015#34920
            TabOrder = 4
            OnClick = BLoadProxyListClick
          end
          object BSaveProxyList: TButton
            Left = 120
            Top = 280
            Width = 89
            Height = 25
            Caption = #20445#23384#20195#29702#21015#34920
            TabOrder = 5
            OnClick = BSaveProxyListClick
          end
          object ListBoxProxyList: TListBox
            Left = 16
            Top = 8
            Width = 521
            Height = 185
            Hint = #24038#38190#21452#20987#21015#34920#26694#20013#30340#39033#30446#21518','#22312#24377#20986#30340#25552#31034#26694#20013'"'#26159'"'#21518#21363#21487#30452#25509#20351#29992#35813#20195#29702'...'
            ItemHeight = 12
            MultiSelect = True
            ParentShowHint = False
            PopupMenu = PopupMenuProxy
            ShowHint = False
            TabOrder = 6
            OnDblClick = ListBoxProxyListDblClick
          end
          object Panel20: TPanel
            Left = 16
            Top = 200
            Width = 521
            Height = 33
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 7
            object CBUseProxy: TCheckBox
              Left = 128
              Top = 8
              Width = 97
              Height = 17
              Caption = #20351#29992#20195#29702
              TabOrder = 0
              OnClick = CBUseProxyClick
            end
            object CBNoUseProxy: TCheckBox
              Left = 240
              Top = 8
              Width = 97
              Height = 17
              Caption = #19981#20351#29992#20195#29702
              TabOrder = 1
              OnClick = CBNoUseProxyClick
            end
          end
        end
      end
      object TabSheetHistory: TTabSheet
        Caption = #21382#21490#35760#24405
        ImageIndex = 9
        object Panel14: TPanel
          Left = 0
          Top = 0
          Width = 582
          Height = 317
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object SBCleanAddress: TSpeedButton
            Left = 48
            Top = 280
            Width = 81
            Height = 25
            Caption = #22320#22336#26639#35760#24405
            OnClick = SBCleanAddressClick
          end
          object SBDelete: TSpeedButton
            Left = 392
            Top = 280
            Width = 73
            Height = 25
            Caption = #21024#38500#35760#24405
            OnClick = SBDeleteClick
          end
          object SBCleanHistoryList: TSpeedButton
            Left = 320
            Top = 280
            Width = 73
            Height = 25
            Caption = #28165#31354#21015#34920
            OnClick = SBCleanHistoryListClick
          end
          object SBHistorySave: TSpeedButton
            Left = 480
            Top = 280
            Width = 73
            Height = 25
            Caption = #20445#23384#20462#25913
            Enabled = False
            OnClick = SBHistorySaveClick
          end
          object SBLoadNewly: TSpeedButton
            Left = 136
            Top = 280
            Width = 97
            Height = 25
            Caption = #28165#38500#26368#36817#27983#35272
            OnClick = SBLoadNewlyClick
          end
          object ListBoxHistory: TListBox
            Left = 16
            Top = 8
            Width = 545
            Height = 265
            ItemHeight = 12
            MultiSelect = True
            TabOrder = 0
          end
        end
      end
      object TabSheet11: TTabSheet
        ImageIndex = 10
        TabVisible = False
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 576
          Height = 315
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
        end
      end
      object TabSheetWhiteList: TTabSheet
        Caption = #40657#30333#21517#21333
        ImageIndex = 8
        object Panel11: TPanel
          Left = 0
          Top = 0
          Width = 582
          Height = 317
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label26: TLabel
            Left = 32
            Top = 248
            Width = 36
            Height = 12
            Caption = #32593#22336#65306
          end
          object Label27: TLabel
            Left = 440
            Top = 248
            Width = 90
            Height = 12
            Caption = '('#20363':*.sohu.com)'
          end
          object ListBoxWhiteList: TListBox
            Left = 16
            Top = 8
            Width = 521
            Height = 217
            ItemHeight = 12
            MultiSelect = True
            PopupMenu = PopupMenuWhiteList
            TabOrder = 0
          end
          object EditWhiteList: TEdit
            Left = 72
            Top = 240
            Width = 289
            Height = 20
            TabOrder = 1
            OnKeyPress = EditWhiteListKeyPress
          end
          object BAddWhiteList: TButton
            Left = 368
            Top = 240
            Width = 57
            Height = 25
            Caption = #28155#21152
            TabOrder = 2
            OnClick = BAddWhiteListClick
          end
          object BWhiteListSaveOK: TButton
            Left = 472
            Top = 280
            Width = 67
            Height = 25
            Caption = #20445#23384#20462#25913
            Enabled = False
            TabOrder = 3
            OnClick = BWhiteListSaveOKClick
          end
          object BWhiteListClear: TButton
            Left = 376
            Top = 280
            Width = 75
            Height = 25
            Caption = #28165#31354#21015#34920
            TabOrder = 4
            OnClick = BWhiteListClearClick
          end
          object BWhiteListLoad: TButton
            Left = 288
            Top = 280
            Width = 75
            Height = 25
            Caption = #36733#20837#21015#34920
            TabOrder = 5
            OnClick = BWhiteListLoadClick
          end
          object Panel13: TPanel
            Left = 16
            Top = 272
            Width = 257
            Height = 41
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 6
            object RBBlackList: TRadioButton
              Left = 24
              Top = 16
              Width = 65
              Height = 17
              Caption = #40657#21517#21333
              Enabled = False
              TabOrder = 0
            end
            object RBWhiteList: TRadioButton
              Left = 120
              Top = 16
              Width = 113
              Height = 17
              Caption = #30333#21517#21333
              Checked = True
              TabOrder = 1
              TabStop = True
            end
          end
        end
      end
      object TabSheetOther: TTabSheet
        Caption = #20854#20182#36873#39033
        ImageIndex = 9
        object Panel12: TPanel
          Left = 0
          Top = 0
          Width = 582
          Height = 317
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object GroupBox9: TGroupBox
            Left = 16
            Top = 8
            Width = 265
            Height = 105
            Caption = #25910#34255#22841#65306
            TabOrder = 2
            object LabelF: TLabel
              Left = 8
              Top = 24
              Width = 72
              Height = 12
              Caption = #25910#34255#22841#36335#24452#65306
            end
            object LabelFavddddoriteDir: TLabel
              Left = 160
              Top = 48
              Width = 6
              Height = 12
            end
            object Button1: TButton
              Left = 160
              Top = 72
              Width = 97
              Height = 25
              Caption = #26356#25913#25910#34255#22841#36335#24452
              TabOrder = 1
              OnClick = Button1Click
            end
            object ButtonImport: TButton
              Left = 88
              Top = 72
              Width = 65
              Height = 25
              Caption = #23548#20837#23548#20986
              TabOrder = 0
              OnClick = ButtonImportClick
            end
            object EFavoriteDir: TEdit
              Left = 8
              Top = 48
              Width = 249
              Height = 20
              TabOrder = 2
              OnChange = EFavoriteDirChange
            end
            object RBUseSys: TRadioButton
              Left = 96
              Top = 18
              Width = 49
              Height = 17
              Caption = #31995#32479
              Checked = True
              TabOrder = 3
              TabStop = True
              OnClick = RBUseSysClick
            end
            object RBUseSelf: TRadioButton
              Left = 160
              Top = 18
              Width = 57
              Height = 17
              Caption = #33258#24049
              TabOrder = 4
              OnClick = RBUseSelfClick
            end
            object BFavOk: TButton
              Left = 24
              Top = 72
              Width = 57
              Height = 25
              Caption = #30830#23450
              TabOrder = 5
              OnClick = BFavOkClick
            end
          end
          object GroupBox6: TGroupBox
            Left = 288
            Top = 8
            Width = 265
            Height = 105
            Caption = #22825#27668#39044#25253#65306
            TabOrder = 0
            object Label21: TLabel
              Left = 16
              Top = 24
              Width = 192
              Height = 12
              Caption = #35831#36873#25321#35201#26597#30475#22825#27668#39044#25253#30340#22478#24066#21363#21487#65306
            end
            object Label22: TLabel
              Left = 16
              Top = 56
              Width = 60
              Height = 12
              Caption = #22478#24066#21517#31216#65306
            end
            object CBWeather2: TComboBox
              Left = 80
              Top = 8
              Width = 161
              Height = 20
              ItemHeight = 12
              TabOrder = 1
              Visible = False
              Items.Strings = (
                #21271#20140
                #19978#28023
                #22825#27941
                #37325#24198
                #24191#24030
                #28145#22323
                #26690#26519
                #26477#24030
                #20848#24030
                #36196#23792
                #21628#21644#28009#29305
                #27494#27721
                #38271#27801
                #36149#24030
                #19977#20122
                #28023#21475
                #22914#27809#26377','#35831#33258#34892#36755#20837'.')
            end
            object ListBoxWeather: TListBox
              Left = 240
              Top = 96
              Width = 121
              Height = 97
              ItemHeight = 12
              Items.Strings = (
                '<%'
                'Function wfile(fileName,IsExist,textInfo)   '
                '  Set Sys = Server.CreateObject("Scripting.FileSystemObject")   '
                '  If IsExist Then    '
                '    Set Txt = Sys.OpenTextFile(fileName, 2)    '
                ' Txt.Write(textInfo)    '
                ' Txt.Close    '
                ' msg ="'#24685#21916','#25991#20214#21019#24314#25104#21151#24182#20445#23384'!"   '
                '  ElseIf Sys.FileExists(fileName) Then     '
                '    msg ="'#25265#27465','#25991#20214#24050#32463#23384#22312'!"'
                '  End If   '
                '  Set Sys = Nothing   '
                '  wfile = msg  '
                'End Function'
                '%>'
                
                  '<table width="95%" border="0" cellpadding="0" cellspacing="0" cl' +
                  'ass="h">'
                '  <tr align="center"> '
                '    <% '#39'<td><font color="#000000">##'#22320#21306#26410#26469'3'#22825' '#22825#27668#39044#25253'</font></td> %>'
                '  </tr>'
                '  <tr align="center" valign="middle"> '
                '    <td> <%'
                'Function bytes2BSTR(vIn) '
                ' dim strReturn '
                ' dim i,ThisCharCode,NextCharCode '
                ' strReturn = "" '
                ' For i = 1 To LenB(vIn) '
                '   ThisCharCode = AscB(MidB(vIn,i,1)) '
                '   If ThisCharCode < &H80 Then '
                '     strReturn = strReturn & Chr(ThisCharCode) '
                '   Else '
                '     NextCharCode = AscB(MidB(vIn,i+1,1)) '
                
                  '     strReturn = strReturn & Chr(CLng(ThisCharCode) * &H100 + CI' +
                  'nt(NextCharCode)) '
                '     i = i + 1 '
                '   End If '
                ' Next '
                ' bytes2BSTR = strReturn '
                'End Function '
                ''
                'function GetWeatherInfo(cityNumber,cityName)'
                '  on error resume next '
                '  set http=Server.createobject("Msxml2.XMLHTTP") '
                
                  '  Http.open "GET","http://www.t7online.com/cgi-bin/citydruck?WMO' +
                  '="&cityNumber&"&LANG=cn&TIME=1082108632",false '
                '  Http.send() '
                '  if Http.readystate<>4 then  exit function '
                '  temp=bytes2BSTR(Http.responseBody) '
                '  set http=nothing'
                '    '#39'response.write cityName'
                '    response.write "'#22478#24066#65306'"&cityName&"  '#26410#26469'3'#22825' '#22825#27668#39044#25253'"'
                
                  '  temp=Left(temp,InStr(temp,CHR(10)&"<table width="&""""&"420")-' +
                  '1)'#39#21491#36793#30340#21435#38500#20102
                '  temp=Left(temp,InStr(temp,"</table")+7)'#39#21491#36793#30340#21435#38500#20102
                '  temp=Mid(temp,InStr(temp,"<table")+5)'
                '  temp=Mid(temp,InStr(temp,"<table"))'
                '  temp=Replace(temp,"/daten","http://www.t7online.com/daten")'
                '  temp=Replace(temp,"<font face=""'#22841#21457#30768'"" size=""2"">"," ")'
                '  temp=Replace(temp,"</font></td>","</td>")'
                '  temp=Replace(temp,"#ffffff","#CCCCCC"""&" clsss=""h")'
                '  temp=Replace(temp,"<tr ","<tr bgcolor=""#FFFFFF""")'
                '  temp=Replace(temp,"border=""1""","border=""0""")'
                '  temp=Replace(temp,"cellspacing=""0""","cellspacing=""1""")'
                '  GetWeatherInfo=temp'
                '  temp=Replace(temp,"<td ","<td Class=""h""")'
                '  response.write(wfile("ld.htm",true,temp))'
                '  if err.number<>0 then err.Clear  '
                'end function'
                ''
                'MyNumber=Request("CityNumber")'
                'if MyNumber="" then '
                '  MyNumber="54511" '
                'end if '
                'MyCityName=Request("CityName")'
                'if MyCityName="" then '
                '  MyCityName="##" '
                'end if '
                'response.write GetWeatherInfo(MyNumber,MyCityName)'
                '%> </td>'
                '  </tr>'
                '  <tr> '
                '    <td> </td>'
                '  </tr>'
                '  <tr> '
                '    <br>'
                
                  '    <td align="center" valign="middle"><a href="http://www.cnlog' +
                  'in.com/tob/" target=new>TOB '#27983#35272#22120'--The Open Browser  '#25552#20379#26816#32034' '
                '      </a></td>'
                '  </tr>'
                '</table>')
              TabOrder = 2
              Visible = False
            end
            object RBWeatherPageSource1: TRadioButton
              Left = 16
              Top = 80
              Width = 57
              Height = 17
              Caption = #28304#19968
              Checked = True
              TabOrder = 3
              TabStop = True
              OnClick = RBWeatherPageSource1Click
            end
            object RBWeatherPageSource2: TRadioButton
              Left = 72
              Top = 80
              Width = 57
              Height = 17
              Caption = #28304#20108
              TabOrder = 4
              OnClick = RBWeatherPageSource2Click
            end
            object SBWeatherOK: TButton
              Left = 168
              Top = 72
              Width = 73
              Height = 25
              Caption = #30830#23450
              TabOrder = 0
              OnClick = SBWeatherOKClick
            end
            object CBWeather: TComboBoxEx
              Left = 80
              Top = 48
              Width = 161
              Height = 21
              ItemsEx = <
                item
                  Caption = #21271#20140
                end
                item
                  Caption = #19978#28023
                end
                item
                  Caption = #22825#27941
                end
                item
                  Caption = #37325#24198
                end
                item
                  Caption = #24191#24030
                end
                item
                  Caption = #28145#22323
                end
                item
                  Caption = #26690#26519
                end
                item
                  Caption = #26477#24030
                end
                item
                  Caption = #20848#24030
                end
                item
                  Caption = #36196#23792
                end
                item
                  Caption = #21628#21644#28009#29305
                end
                item
                  Caption = #27494#27721
                end
                item
                  Caption = #38271#27801
                end
                item
                  Caption = #36149#24030
                end
                item
                  Caption = #19977#20122
                end
                item
                  Caption = #28023#21475
                end
                item
                  Caption = #22914#27809#26377','#35831#33258#34892#36755#20837'..'
                end>
              ItemHeight = 16
              TabOrder = 5
              DropDownCount = 8
            end
          end
          object GroupBox3: TGroupBox
            Left = 16
            Top = 128
            Width = 537
            Height = 177
            Caption = #27880#20876#34920#24674#22797#65306
            TabOrder = 1
            object Label15: TLabel
              Left = 16
              Top = 72
              Width = 276
              Height = 12
              Caption = #22914#26524#27880#20876#32534#36753#22120#34987#38145#65292#35831#28857#20987#21518#38754#30340#25353#38062#36827#34892#35299#38145#12290
            end
            object Label16: TLabel
              Left = 16
              Top = 104
              Width = 336
              Height = 12
              Caption = #22914#26524#25991#26412#25991#20214#31867#22411'(.txt)'#20851#32852#34987#24694#24847#31243#24207#20462#25913#65292#21487#20197#36827#34892#24674#22797#12290
            end
            object Label19: TLabel
              Left = 16
              Top = 24
              Width = 444
              Height = 12
              Caption = #37073#37325#22768#26126#65306#20197#19979#21508#39033#23545#27880#20876#34920#36827#34892#25805#20316#65292#32771#34385#21040#31995#32479#30340#19981#19968#33268#24615#20197#21450#35823#25805#20316#30340#21487#33021#65292
              Color = 15263976
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentColor = False
              ParentFont = False
            end
            object Label20: TLabel
              Left = 78
              Top = 40
              Width = 168
              Height = 12
              Caption = #24314#35758#25805#20316#21069#23545#27880#20876#34920#36827#34892#22791#20221#12290
              Color = 15263976
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentColor = False
              ParentFont = False
            end
            object Label17: TLabel
              Left = 16
              Top = 136
              Width = 336
              Height = 12
              Caption = #22914#26524'IE'#27983#35272#22120#30340#26631#39064#25110#32773#36215#22987#39029#31561#34987#24694#24847#20462#25913#65292#21487#20197#36827#34892#24674#22797#12290
            end
            object BUnlockReg: TButton
              Left = 408
              Top = 64
              Width = 113
              Height = 22
              Caption = #35299#38145#27880#20876#34920#32534#36753#22120
              TabOrder = 0
              OnClick = BUnlockRegClick
            end
            object BDefaultTXTType: TButton
              Left = 408
              Top = 96
              Width = 113
              Height = 22
              Caption = #24674#22797'.txt'#31867#22411#20851#32852
              TabOrder = 1
              OnClick = BDefaultTXTTypeClick
            end
            object BDefaultAll: TButton
              Left = 448
              Top = 152
              Width = 73
              Height = 22
              Caption = 'DefautAll'
              TabOrder = 2
              Visible = False
              OnClick = BDefaultAllClick
            end
            object Button4: TButton
              Left = 392
              Top = 128
              Width = 129
              Height = 22
              Caption = #20462#22797'IE'#26631#39064#21450#36215#22987#39029
              TabOrder = 3
              OnClick = Button4Click
            end
            object BLockAll: TButton
              Left = 376
              Top = 152
              Width = 65
              Height = 22
              Caption = 'LockAll'
              TabOrder = 4
              Visible = False
              OnClick = BLockAllClick
            end
          end
        end
      end
      object TabSheetSystem: TTabSheet
        Caption = #31995#32479#30456#20851
        ImageIndex = 10
        object Panel10: TPanel
          Left = 0
          Top = 0
          Width = 582
          Height = 317
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Pie: TGauge
            Left = 30
            Top = 31
            Width = 140
            Height = 129
            BorderStyle = bsNone
            ForeColor = clBlue
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            Kind = gkPie
            ParentFont = False
            Progress = 0
            Visible = False
          end
          object SBGetAutoRunKey: TSpeedButton
            Left = 304
            Top = 270
            Width = 89
            Height = 28
            Caption = #33258#21160#36816#34892#38190
            OnClick = SBGetAutoRunKeyClick
          end
          object SBMemoryOptimize: TSpeedButton
            Left = 184
            Top = 206
            Width = 65
            Height = 28
            Caption = #20869#23384#20248#21270
            Visible = False
            OnClick = SBMemoryOptimizeClick
          end
          object SBProcessList: TSpeedButton
            Left = 551
            Top = 296
            Width = 17
            Height = 22
            Visible = False
            OnClick = SBProcessListClick
          end
          object SBAllProcess: TSpeedButton
            Left = 472
            Top = 270
            Width = 81
            Height = 28
            Caption = #25152#26377#36827#31243
            OnClick = SBAllProcessClick
          end
          object SBProcessPath: TSpeedButton
            Left = 392
            Top = 270
            Width = 81
            Height = 28
            Caption = #36827#31243#36335#24452
            OnClick = SBProcessPathClick
          end
          object SBSystemInfo: TSpeedButton
            Left = 224
            Top = 270
            Width = 81
            Height = 28
            Caption = #31995#32479#20449#24687
            OnClick = SBSystemInfoClick
          end
          object ListBoxRegKey: TListBox
            Left = 224
            Top = 8
            Width = 337
            Height = 257
            ItemHeight = 12
            TabOrder = 0
            OnDblClick = ListBoxRegKeyDblClick
          end
          object CLBox1_: TCheckListBox
            Left = 250
            Top = 8
            Width = 302
            Height = 257
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = -1
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ItemHeight = 12
            ParentFont = False
            TabOrder = 1
            Visible = False
            OnDblClick = CLBox1_DblClick
          end
          object LBProcess: TListBox
            Left = 224
            Top = 8
            Width = 337
            Height = 257
            ItemHeight = 12
            TabOrder = 2
            OnDblClick = LBProcessDblClick
          end
          object ListBoxProcess: TListBox
            Left = 360
            Top = 56
            Width = 121
            Height = 161
            ItemHeight = 12
            TabOrder = 3
            Visible = False
          end
          object MemoSystemInfo: TMemo
            Left = 8
            Top = 8
            Width = 201
            Height = 289
            ReadOnly = True
            TabOrder = 4
          end
        end
      end
    end
  end
  object TimerStatusBar: TTimer
    OnTimer = TimerStatusBarTimer
    Left = 732
    Top = 47
  end
  object OpenDialogList: TOpenDialog
    Filter = #21015#34920#25991#20214'(*.lst)|*.lst|'#25152#26377#25991#20214'(*.*)|*.*'
    Left = 736
    Top = 104
  end
  object SaveDialog: TSaveDialog
    Filter = #21015#34920#25991#20214'(*.lst)|*.lst|'#25152#26377#25991#20214'(*.*)|*.*'
    Left = 728
    Top = 136
  end
  object PopupMenuQuickLink: TPopupMenu
    Left = 720
    Top = 215
    object NSBEditCurrentQLData: TMenuItem
      Caption = #32534#36753#24403#21069#25968#25454
      OnClick = NSBEditCurrentQLDataClick
    end
    object N2: TMenuItem
      Caption = #31227#38500
      OnClick = N2Click
    end
    object NSaveQuickLink: TMenuItem
      Caption = #20445#23384#21015#34920
      OnClick = NSaveQuickLinkClick
    end
  end
  object PopupMenuProxy: TPopupMenu
    Left = 740
    Top = 247
    object MenuItem2: TMenuItem
      Caption = #31227#38500
      OnClick = MenuItem2Click
    end
    object MenuItem1: TMenuItem
      Caption = #32534#36753#24403#21069#25968#25454
      OnClick = MenuItem1Click
    end
  end
  object PopupMenuWhiteList: TPopupMenu
    Left = 728
    Top = 175
    object MenuItem3: TMenuItem
      Caption = #32534#36753#24403#21069#25968#25454
      OnClick = MenuItem3Click
    end
    object MenuItem4: TMenuItem
      Caption = #31227#38500
      OnClick = MenuItem4Click
    end
    object MenuItem5: TMenuItem
      Caption = #20445#23384#21015#34920
      OnClick = MenuItem5Click
    end
  end
end
