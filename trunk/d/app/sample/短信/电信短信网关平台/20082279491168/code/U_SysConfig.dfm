object FSysConfig: TFSysConfig
  Left = 338
  Top = 34
  BorderStyle = bsDialog
  Caption = #31995#32479#21442#25968#37197#32622
  ClientHeight = 288
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label68: TLabel
    Left = 48
    Top = 264
    Width = 60
    Height = 12
    Caption = #31995#32479#29256#26412#21495
  end
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 589
    Height = 257
    ActivePage = TabSheet2
    Align = alTop
    FlatColor = 10263441
    HotTrackColor = 3983359
    HotTrackColorType = htctActual
    ParentColor = False
    TabColors.HighlightBar = 3983359
    TabIndex = 2
    TabOrder = 0
    TabStyle = tsDoubleSlant
    FixedDimension = 18
    object TabSheet1: TRzTabSheet
      Caption = #30331#38470#37197#32622
      object GroupBox2: TGroupBox
        Left = 0
        Top = 8
        Width = 217
        Height = 177
        Caption = #30331#38470#30005#20449#32593#20851#21442#25968
        TabOrder = 0
        object Label1: TLabel
          Left = 14
          Top = 46
          Width = 96
          Height = 12
          Caption = 'SP_ID('#20225#19994#20195#30721'):'
        end
        object Label2: TLabel
          Left = 31
          Top = 67
          Width = 78
          Height = 12
          Caption = 'Secret('#23494#30721'):'
        end
        object Label3: TLabel
          Left = 8
          Top = 88
          Width = 102
          Height = 12
          Caption = 'CTIP('#30005#20449#26381#21153#22120'):'
        end
        object Label4: TLabel
          Left = 44
          Top = 109
          Width = 66
          Height = 12
          Caption = 'Port('#31471#21475'):'
        end
        object Label61: TLabel
          Left = 9
          Top = 25
          Width = 102
          Height = 12
          Caption = 'ClientID('#29992#25143#21517'):'
        end
        object Label60: TLabel
          Left = 18
          Top = 130
          Width = 90
          Height = 12
          Caption = #23458#25143#31471#25903#25345#29256#26412':'
        end
        object Label81: TLabel
          Left = 29
          Top = 152
          Width = 78
          Height = 12
          Caption = #26412#22320#32593#20851#32534#21495':'
        end
        object TSPID: TEdit
          Left = 110
          Top = 38
          Width = 100
          Height = 20
          TabOrder = 0
          Text = '1186185'
        end
        object TSC: TEdit
          Left = 110
          Top = 59
          Width = 100
          Height = 20
          PasswordChar = '*'
          TabOrder = 1
          Text = 'secret'
        end
        object TCTIP: TEdit
          Left = 110
          Top = 80
          Width = 100
          Height = 20
          TabOrder = 2
          Text = 'TCTIP'
        end
        object TCTPort: TEdit
          Left = 110
          Top = 101
          Width = 100
          Height = 20
          TabOrder = 3
          Text = 'TCTPort'
        end
        object EClientID: TEdit
          Left = 110
          Top = 17
          Width = 100
          Height = 20
          TabOrder = 4
          Text = '4453'
        end
        object HVision: TEdit
          Left = 110
          Top = 122
          Width = 100
          Height = 20
          TabOrder = 5
          Text = '20'
        end
        object Edit17: TEdit
          Left = 110
          Top = 144
          Width = 100
          Height = 20
          TabOrder = 6
        end
      end
      object GroupBox4: TGroupBox
        Left = 440
        Top = 8
        Width = 142
        Height = 177
        Caption = #25910#21457#21442#25968
        TabOrder = 1
        object Label16: TLabel
          Left = 8
          Top = 18
          Width = 96
          Height = 12
          Caption = #25509#25910#25968#25454#31561#24453#26102#38388
          Transparent = True
        end
        object Label18: TLabel
          Left = 8
          Top = 58
          Width = 108
          Height = 24
          Caption = #38142#36335#31354#38386#26102#21457#36865#38142#36335#27979#35797#21253#26102#38388#38388#38548
          Transparent = True
          WordWrap = True
        end
        object Label7: TLabel
          Left = 7
          Top = 110
          Width = 96
          Height = 12
          Caption = 'Retry Login Time'
        end
        object Label67: TLabel
          Left = 11
          Top = 148
          Width = 114
          Height = 24
          Caption = #27880#24847':'#25910#21457#21442#25968#26102#38388#21333#20301#20026'"'#27627#31186'"'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Edit1: TEdit
          Left = 53
          Top = 32
          Width = 65
          Height = 20
          TabOrder = 0
          Text = '6000'
        end
        object Edit2: TEdit
          Left = 53
          Top = 85
          Width = 65
          Height = 20
          TabOrder = 1
          Text = '6000'
        end
        object ERetry: TEdit
          Left = 53
          Top = 124
          Width = 65
          Height = 20
          TabOrder = 2
          Text = '1000'
        end
      end
      object GroupBox7: TGroupBox
        Left = 220
        Top = 113
        Width = 217
        Height = 72
        Caption = #21457#36865#30701#28040#24687
        TabOrder = 2
        object Label58: TLabel
          Left = 8
          Top = 16
          Width = 81
          Height = 13
          AutoSize = False
          Caption = 'SMGP'#30331#24405#27169#24335':'
        end
        object Label59: TLabel
          Left = 31
          Top = 36
          Width = 57
          Height = 13
          AutoSize = False
          Caption = #36830#25509#26041#24335':'
        end
        object Label55: TLabel
          Left = 42
          Top = 56
          Width = 42
          Height = 12
          Caption = #24207#21015#21495':'
        end
        object CBLoginMode1: TComboBox
          Left = 88
          Top = 8
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 0
          Items.Strings = (
            '0'#21457#36865#30701#28040#24687
            '1'#25509#25910#30701#28040#24687
            '2'#25910#21457#30701#28040#24687
            #20854#23427#20445#30041)
        end
        object ConnectMode1: TComboBox
          Left = 88
          Top = 28
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 1
          Items.Strings = (
            '1'#38271#36830#25509
            '2'#30701#36830#25509)
        end
        object ESSeq: TEdit
          Left = 88
          Top = 48
          Width = 120
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = '1'
        end
      end
      object GroupBox8: TGroupBox
        Left = 220
        Top = 39
        Width = 217
        Height = 73
        Caption = #25509#25910#30701#28040#24687
        TabOrder = 3
        object Label5: TLabel
          Left = 8
          Top = 16
          Width = 81
          Height = 13
          AutoSize = False
          Caption = 'SMGP'#30331#24405#27169#24335':'
        end
        object Label20: TLabel
          Left = 31
          Top = 36
          Width = 59
          Height = 13
          AutoSize = False
          Caption = #36830#25509#26041#24335':'
        end
        object Label54: TLabel
          Left = 42
          Top = 55
          Width = 42
          Height = 12
          Caption = #24207#21015#21495':'
        end
        object CBLoginMode: TComboBox
          Left = 88
          Top = 9
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 0
          Items.Strings = (
            '0'#21457#36865#30701#28040#24687
            '1'#25509#25910#30701#28040#24687
            '2'#25910#21457#30701#28040#24687
            #20854#23427#20445#30041)
        end
        object ConnectMode: TComboBox
          Left = 88
          Top = 29
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 1
          Items.Strings = (
            '1'#38271#36830#25509
            '2'#30701#36830#25509)
        end
        object EDSeq: TEdit
          Left = 88
          Top = 49
          Width = 120
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = '1'
        end
      end
      object RzBitBtn1: TRzBitBtn
        Left = 448
        Top = 200
        Width = 81
        Caption = #20445#23384'Save'
        HotTrack = True
        TabOrder = 4
        OnClick = RzBitBtn1Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000830E0000830E00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8090909
          09090909090909090909E8E8E881818181818181818181818181E8E809101009
          E31009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E80909101009
          E31009E3E3E309101009E88181ACAC81E3AC81E3E3E381ACAC81091009101009
          E31009E3E3E30910100981AC81ACAC81E3AC81E3E3E381ACAC81091009101009
          E3E3E3E3E3E30910100981AC81ACAC81E3E3E3E3E3E381ACAC81091009101010
          0909090909091010100981AC81ACACAC818181818181ACACAC81091009101010
          1010101010101010100981AC81ACACACACACACACACACACACAC81091009101009
          0909090909090910100981AC81ACAC8181818181818181ACAC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC810910091009D7
          090909090909D709100981AC81AC81D7818181818181D781AC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC81091009E309D7
          090909090909D709090981AC81E381D7818181818181D78181810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC8109E309090909
          0909090909090909090981E38181818181818181818181818181091009D7D7D7
          D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8090909090909
          0909090909090909E8E88181818181818181818181818181E8E8}
        NumGlyphs = 2
      end
      object GroupBox12: TGroupBox
        Left = 220
        Top = 8
        Width = 217
        Height = 30
        Caption = #30331#38470#27169#24335
        TabOrder = 5
        object RadioButton1: TRadioButton
          Left = 38
          Top = 12
          Width = 62
          Height = 14
          Caption = #21452#38142#36335
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Left = 97
          Top = 9
          Width = 113
          Height = 17
          Caption = #21333#38142#36335'('#25910#21457#27169#24335')'
          TabOrder = 1
          OnClick = RadioButton2Click
        end
      end
      object GroupBox13: TGroupBox
        Left = 220
        Top = 39
        Width = 217
        Height = 73
        Caption = #25910#21457#36865#30701#28040#24687
        TabOrder = 6
        Visible = False
        object Label75: TLabel
          Left = 8
          Top = 16
          Width = 81
          Height = 13
          AutoSize = False
          Caption = 'SMGP'#30331#24405#27169#24335':'
        end
        object Label76: TLabel
          Left = 31
          Top = 36
          Width = 57
          Height = 13
          AutoSize = False
          Caption = #36830#25509#26041#24335':'
        end
        object Label77: TLabel
          Left = 42
          Top = 55
          Width = 42
          Height = 12
          Caption = #24207#21015#21495':'
        end
        object ComboBox1: TComboBox
          Left = 88
          Top = 9
          Width = 121
          Height = 20
          ItemHeight = 12
          ItemIndex = 2
          TabOrder = 0
          Text = '2'#25910#21457#30701#28040#24687
          Items.Strings = (
            '0'#21457#36865#30701#28040#24687
            '1'#25509#25910#30701#28040#24687
            '2'#25910#21457#30701#28040#24687
            #20854#23427#20445#30041)
        end
        object ComboBox2: TComboBox
          Left = 88
          Top = 29
          Width = 121
          Height = 20
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 1
          Text = '1'#38271#36830#25509
          Items.Strings = (
            '1'#38271#36830#25509
            '2'#30701#36830#25509)
        end
        object Edit16: TEdit
          Left = 88
          Top = 49
          Width = 120
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = '1'
        end
      end
    end
    object TabSheet3: TRzTabSheet
      Caption = #20869#37096#21327#35758
      object GroupBox1: TGroupBox
        Left = 16
        Top = 8
        Width = 292
        Height = 225
        Caption = #20869#37096#21327#35758
        TabOrder = 0
        object Label9: TLabel
          Left = 168
          Top = 53
          Width = 36
          Height = 12
          Caption = #21629#20196#23383
        end
        object Label10: TLabel
          Left = 15
          Top = 53
          Width = 87
          Height = 13
          AutoSize = False
          Caption = #35831#27714#30701#20449#38431#21015#21495
        end
        object Label11: TLabel
          Left = 178
          Top = 24
          Width = 24
          Height = 12
          Caption = #29366#24577
        end
        object Label8: TLabel
          Left = 39
          Top = 74
          Width = 57
          Height = 13
          AutoSize = False
          Caption = #19978#34892#38431#21015#21495
        end
        object Label19: TLabel
          Left = 15
          Top = 95
          Width = 81
          Height = 13
          AutoSize = False
          Caption = #22238#39304#25253#21578#38431#21015#21495
        end
        object Label6: TLabel
          Left = 39
          Top = 24
          Width = 58
          Height = 13
          AutoSize = False
          Caption = #21327#35758#29256#26412#21495
        end
        object Label33: TLabel
          Left = 168
          Top = 74
          Width = 36
          Height = 12
          Caption = #21629#20196#23383
        end
        object Label34: TLabel
          Left = 168
          Top = 95
          Width = 36
          Height = 12
          Caption = #21629#20196#23383
        end
        object Label35: TLabel
          Left = 15
          Top = 116
          Width = 81
          Height = 13
          AutoSize = False
          Caption = #36882#36865#25253#21578#38431#21015#21495
        end
        object Label36: TLabel
          Left = 168
          Top = 116
          Width = 36
          Height = 12
          Caption = #21629#20196#23383
        end
        object Bevel1: TBevel
          Left = 0
          Top = 40
          Width = 290
          Height = 3
        end
        object Bevel2: TBevel
          Left = 2
          Top = 136
          Width = 288
          Height = 3
        end
        object TMTCom: TEdit
          Left = 208
          Top = 45
          Width = 57
          Height = 20
          TabOrder = 0
          Text = 'TMTCom'
        end
        object TMTSeq: TEdit
          Left = 104
          Top = 45
          Width = 57
          Height = 20
          TabOrder = 1
          Text = 'TMTSeq'
        end
        object TSta: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 20
          TabOrder = 2
          Text = 'TSta'
        end
        object TRespSeq: TEdit
          Left = 104
          Top = 87
          Width = 57
          Height = 20
          TabOrder = 3
          Text = 'TRespSeq'
        end
        object TMOSeq: TEdit
          Left = 104
          Top = 66
          Width = 57
          Height = 20
          Hint = #25152#26377#19994#21153#31243#24207#23545#21015#30001'Service.xml'#37197#32622#25991#20214#20135#29983
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Text = 'TMOSeq'
        end
        object TVision: TEdit
          Left = 104
          Top = 16
          Width = 57
          Height = 20
          TabOrder = 5
          Text = 'TVision'
        end
        object TMOCom: TEdit
          Left = 208
          Top = 66
          Width = 57
          Height = 20
          TabOrder = 6
          Text = 'TCom'
        end
        object TRespCom: TEdit
          Left = 208
          Top = 87
          Width = 57
          Height = 20
          TabOrder = 7
          Text = 'TCom'
        end
        object TReportSeq: TEdit
          Left = 104
          Top = 108
          Width = 57
          Height = 20
          TabOrder = 8
          Text = 'ReSeq'
        end
        object TReCom: TEdit
          Left = 208
          Top = 108
          Width = 57
          Height = 20
          TabOrder = 9
          Text = 'TCom'
        end
      end
      object GroupBox3: TGroupBox
        Left = 314
        Top = 8
        Width = 265
        Height = 177
        Caption = #20013#38388#26381#21153#22120
        TabOrder = 1
        object Label15: TLabel
          Left = 12
          Top = 32
          Width = 72
          Height = 12
          Caption = #26381#21153#22120#22320#22336#65306
        end
        object Label17: TLabel
          Left = 24
          Top = 52
          Width = 60
          Height = 12
          Caption = #25509#25910#36229#26102#65306
        end
        object Label14: TLabel
          Left = 60
          Top = 114
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #35831#27714#30701#20449#31471#21475
        end
        object Label12: TLabel
          Left = 60
          Top = 134
          Width = 81
          Height = 13
          AutoSize = False
          Caption = #19978#34892#30701#20449#31471#21475
        end
        object Label13: TLabel
          Left = 24
          Top = 153
          Width = 129
          Height = 13
          AutoSize = False
          Caption = #22238#39304#21644#36882#36865#25253#21578#31471#21475
        end
        object TSerIP: TEdit
          Left = 89
          Top = 24
          Width = 121
          Height = 20
          TabOrder = 0
          Text = 'TSerIP'
        end
        object CBTimeout: TComboBox
          Left = 89
          Top = 44
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 1
          Items.Strings = (
            '0'
            '1000'
            '2000'
            '3000'
            '4000'
            '5000'
            '6000'
            '7000'
            '8000'
            '9000')
        end
        object CheckBox1: TCheckBox
          Left = 104
          Top = 72
          Width = 97
          Height = 17
          Caption = #21457#36865#29366#24577#22238#39304
          TabOrder = 2
        end
        object TMTPort: TEdit
          Left = 152
          Top = 105
          Width = 57
          Height = 20
          TabOrder = 3
          Text = 'TMTPort'
        end
        object TMOPort: TEdit
          Left = 152
          Top = 125
          Width = 57
          Height = 20
          TabOrder = 4
          Text = 'TMOPort'
        end
        object TRePort: TEdit
          Left = 152
          Top = 145
          Width = 57
          Height = 20
          TabOrder = 5
          Text = 'TRePort'
        end
      end
      object RzBitBtn3: TRzBitBtn
        Left = 448
        Top = 200
        Width = 81
        Caption = #20445#23384'Save'
        HotTrack = True
        TabOrder = 2
        OnClick = RzBitBtn3Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000830E0000830E00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8090909
          09090909090909090909E8E8E881818181818181818181818181E8E809101009
          E31009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E80909101009
          E31009E3E3E309101009E88181ACAC81E3AC81E3E3E381ACAC81091009101009
          E31009E3E3E30910100981AC81ACAC81E3AC81E3E3E381ACAC81091009101009
          E3E3E3E3E3E30910100981AC81ACAC81E3E3E3E3E3E381ACAC81091009101010
          0909090909091010100981AC81ACACAC818181818181ACACAC81091009101010
          1010101010101010100981AC81ACACACACACACACACACACACAC81091009101009
          0909090909090910100981AC81ACAC8181818181818181ACAC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC810910091009D7
          090909090909D709100981AC81AC81D7818181818181D781AC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC81091009E309D7
          090909090909D709090981AC81E381D7818181818181D78181810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC8109E309090909
          0909090909090909090981E38181818181818181818181818181091009D7D7D7
          D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8090909090909
          0909090909090909E8E88181818181818181818181818181E8E8}
        NumGlyphs = 2
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = #25910#21457#32447#31243
      object GroupBox9: TGroupBox
        Left = 8
        Top = 8
        Width = 449
        Height = 177
        Caption = #32447#31243#25968'/'#25910#21457#38388#38548
        TabOrder = 0
        object Label21: TLabel
          Left = 48
          Top = 32
          Width = 121
          Height = 13
          AutoSize = False
          Caption = #20174#30005#20449#25509#25910#32447#31243#25968':'
        end
        object Label27: TLabel
          Left = 265
          Top = 32
          Width = 66
          Height = 12
          Caption = 'Sleep Time:'
        end
        object Label28: TLabel
          Left = 265
          Top = 53
          Width = 66
          Height = 12
          Caption = 'Sleep Time:'
        end
        object Label29: TLabel
          Left = 265
          Top = 74
          Width = 66
          Height = 12
          Caption = 'Sleep Time:'
        end
        object Label30: TLabel
          Left = 265
          Top = 95
          Width = 66
          Height = 12
          Caption = 'Sleep Time:'
        end
        object Label31: TLabel
          Left = 265
          Top = 116
          Width = 66
          Height = 12
          Caption = 'Sleep Time:'
        end
        object Label32: TLabel
          Left = 265
          Top = 137
          Width = 66
          Height = 12
          Caption = 'Sleep Time:'
        end
        object Label22: TLabel
          Left = 84
          Top = 53
          Width = 72
          Height = 13
          AutoSize = False
          Caption = #19979#34892#32447#31243#25968':'
        end
        object Label23: TLabel
          Left = 36
          Top = 74
          Width = 129
          Height = 13
          AutoSize = False
          Caption = #24448#20013#38388#23618#19978#34892#32447#31243#25968':'
        end
        object Label24: TLabel
          Left = 48
          Top = 95
          Width = 104
          Height = 13
          AutoSize = False
          Caption = 'Submit'#35831#27714#32447#31243#25968':'
        end
        object Label25: TLabel
          Left = 35
          Top = 116
          Width = 129
          Height = 13
          AutoSize = False
          Caption = #21457#36865#22238#39304#25253#21578#32447#31243#25968':'
        end
        object Label26: TLabel
          Left = 35
          Top = 137
          Width = 129
          Height = 13
          AutoSize = False
          Caption = #21457#36865#36882#36865#25253#21578#32447#31243#25968':'
        end
        object TCTDeliverN: TEdit
          Left = 160
          Top = 24
          Width = 80
          Height = 20
          Enabled = False
          TabOrder = 0
          Text = 'TCTDeliverN'
        end
        object Edit5: TEdit
          Left = 337
          Top = 24
          Width = 80
          Height = 20
          TabOrder = 1
        end
        object Edit6: TEdit
          Left = 337
          Top = 45
          Width = 80
          Height = 20
          TabOrder = 2
        end
        object Edit7: TEdit
          Left = 337
          Top = 66
          Width = 80
          Height = 20
          TabOrder = 3
        end
        object Edit8: TEdit
          Left = 337
          Top = 87
          Width = 80
          Height = 20
          TabOrder = 4
        end
        object Edit9: TEdit
          Left = 337
          Top = 108
          Width = 80
          Height = 20
          TabOrder = 5
        end
        object Edit10: TEdit
          Left = 337
          Top = 129
          Width = 80
          Height = 20
          TabOrder = 6
        end
        object EReport: TEdit
          Left = 160
          Top = 129
          Width = 80
          Height = 20
          TabOrder = 7
          Text = 'EReport'
        end
        object TResponse: TEdit
          Left = 160
          Top = 108
          Width = 80
          Height = 20
          TabOrder = 8
          Text = 'TResponse'
        end
        object TSubmitRes: TEdit
          Left = 160
          Top = 87
          Width = 80
          Height = 20
          TabOrder = 9
          Text = 'TSubmitRes'
        end
        object TSPsubmitN: TEdit
          Left = 160
          Top = 45
          Width = 80
          Height = 20
          Enabled = False
          TabOrder = 10
          Text = 'TSPsubmitN'
        end
        object TSPDeliverN: TEdit
          Left = 160
          Top = 66
          Width = 80
          Height = 20
          TabOrder = 11
          Text = 'TSPDeliverN'
        end
      end
      object GroupBox10: TGroupBox
        Left = 464
        Top = 8
        Width = 113
        Height = 177
        Caption = #30701#20449#37325#21457
        TabOrder = 1
        object Label65: TLabel
          Left = 8
          Top = 16
          Width = 96
          Height = 36
          Caption = #22238#39304#25253#21578#22810#20037#27809#22238#22797#65292#32593#20851#37325#21457#65288#20998#38047#65289
          WordWrap = True
        end
        object Label66: TLabel
          Left = 8
          Top = 94
          Width = 96
          Height = 36
          Caption = #22238#39304#25253#21578#22238#22797#29366#24577#22312#19981#26159#28040#24687#21253#26377#38169#30340#24773#20917#19979#37325#21457#27425#25968
          WordWrap = True
        end
        object ERespTime: TEdit
          Left = 24
          Top = 55
          Width = 81
          Height = 20
          TabOrder = 0
          Text = 'ERespTime'
        end
        object ESendCou: TEdit
          Left = 24
          Top = 136
          Width = 81
          Height = 20
          TabOrder = 1
          Text = 'ESendCou'
        end
      end
      object RzBitBtn4: TRzBitBtn
        Left = 448
        Top = 200
        Width = 80
        Caption = #20445#23384'Save'
        HotTrack = True
        TabOrder = 2
        OnClick = RzBitBtn4Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000830E0000830E00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8090909
          09090909090909090909E8E8E881818181818181818181818181E8E809101009
          E31009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E80909101009
          E31009E3E3E309101009E88181ACAC81E3AC81E3E3E381ACAC81091009101009
          E31009E3E3E30910100981AC81ACAC81E3AC81E3E3E381ACAC81091009101009
          E3E3E3E3E3E30910100981AC81ACAC81E3E3E3E3E3E381ACAC81091009101010
          0909090909091010100981AC81ACACAC818181818181ACACAC81091009101010
          1010101010101010100981AC81ACACACACACACACACACACACAC81091009101009
          0909090909090910100981AC81ACAC8181818181818181ACAC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC810910091009D7
          090909090909D709100981AC81AC81D7818181818181D781AC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC81091009E309D7
          090909090909D709090981AC81E381D7818181818181D78181810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC8109E309090909
          0909090909090909090981E38181818181818181818181818181091009D7D7D7
          D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8090909090909
          0909090909090909E8E88181818181818181818181818181E8E8}
        NumGlyphs = 2
      end
    end
    object TabSheet4: TRzTabSheet
      Caption = #26085#24535
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 413
        Height = 193
        Caption = #26085#24535#20998#31867
        TabOrder = 0
        object Label37: TLabel
          Left = 8
          Top = 24
          Width = 120
          Height = 12
          Caption = #30005#20449#19978#34892#38750#25253#21578#31867#30701#20449
        end
        object Label38: TLabel
          Left = 32
          Top = 48
          Width = 96
          Height = 12
          Caption = #30005#20449#19978#34892#22238#39304#25253#21578
        end
        object Label39: TLabel
          Left = 32
          Top = 72
          Width = 96
          Height = 12
          Caption = #30005#20449#19978#34892#36882#36865#25253#21578
        end
        object Label40: TLabel
          Left = 202
          Top = 48
          Width = 48
          Height = 12
          Caption = #32593#20851#24179#21488
        end
        object RzLine1: TRzLine
          Left = 128
          Top = 16
          Width = 81
          Height = 41
          ShowArrows = saEnd
        end
        object RzLine2: TRzLine
          Left = 120
          Top = 43
          Width = 87
          Height = 20
          ShowArrows = saEnd
        end
        object RzLine3: TRzLine
          Left = 248
          Top = 44
          Width = 73
          Height = 20
          ShowArrows = saEnd
        end
        object Label41: TLabel
          Left = 320
          Top = 48
          Width = 60
          Height = 12
          Caption = #20013#38388#26381#21153#22120
        end
        object RzLine4: TRzLine
          Left = 128
          Top = 48
          Width = 81
          Height = 41
          LineSlope = lsUp
          ShowArrows = saEnd
        end
        object Label42: TLabel
          Left = 320
          Top = 96
          Width = 60
          Height = 12
          Caption = #20013#38388#26381#21153#22120
        end
        object RzLine5: TRzLine
          Left = 248
          Top = 92
          Width = 73
          Height = 20
          ShowArrows = saStart
        end
        object Label43: TLabel
          Left = 200
          Top = 96
          Width = 48
          Height = 12
          Caption = #32593#20851#24179#21488
        end
        object Label44: TLabel
          Left = 104
          Top = 96
          Width = 24
          Height = 12
          Caption = #30005#20449
        end
        object RzLine6: TRzLine
          Left = 122
          Top = 91
          Width = 79
          Height = 20
          ShowArrows = saStart
        end
        object Label45: TLabel
          Left = 152
          Top = 88
          Width = 24
          Height = 12
          Caption = #19979#34892
        end
        object Label46: TLabel
          Left = 280
          Top = 88
          Width = 24
          Height = 12
          Caption = #19979#34892
        end
        object Label47: TLabel
          Left = 104
          Top = 128
          Width = 24
          Height = 12
          Caption = #30005#20449
        end
        object RzLine7: TRzLine
          Left = 122
          Top = 123
          Width = 87
          Height = 20
          ShowArrows = saBoth
        end
        object Label48: TLabel
          Left = 200
          Top = 128
          Width = 48
          Height = 12
          Caption = #32593#20851#24179#21488
        end
        object Label49: TLabel
          Left = 144
          Top = 120
          Width = 48
          Height = 12
          Caption = #38142#36335#27979#35797
          Transparent = True
        end
        object Label50: TLabel
          Left = 144
          Top = 136
          Width = 48
          Height = 12
          Caption = #30331#38470#36864#20986
          Transparent = True
        end
        object CheckBox2: TCheckBox
          Left = 232
          Top = 168
          Width = 105
          Height = 17
          Caption = 'Auto write log'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckBox5: TCheckBox
          Left = 232
          Top = 152
          Width = 121
          Height = 17
          Caption = #38142#36335#27979#35797#20889#20837#26085#24535
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
      object GroupBox6: TGroupBox
        Left = 426
        Top = 8
        Width = 135
        Height = 121
        Caption = #20889#26085#24535#32447#31243
        TabOrder = 1
        object Label51: TLabel
          Left = 27
          Top = 24
          Width = 36
          Height = 12
          Caption = #32447#31243#25968
        end
        object Label52: TLabel
          Left = 27
          Top = 64
          Width = 60
          Height = 12
          Caption = 'Sleep Time'
        end
        object Edit3: TEdit
          Left = 43
          Top = 40
          Width = 49
          Height = 20
          TabOrder = 0
          Text = '1'
        end
        object Edit11: TEdit
          Left = 43
          Top = 88
          Width = 49
          Height = 20
          TabOrder = 1
        end
        object UpDown2: TUpDown
          Left = 92
          Top = 40
          Width = 15
          Height = 20
          Associate = Edit3
          Min = 1
          Max = 10
          Position = 1
          TabOrder = 2
        end
      end
      object RzBitBtn5: TRzBitBtn
        Left = 448
        Top = 200
        Width = 80
        Caption = #20445#23384'Save'
        HotTrack = True
        TabOrder = 2
        OnClick = RzBitBtn5Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000830E0000830E00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8090909
          09090909090909090909E8E8E881818181818181818181818181E8E809101009
          E31009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E80909101009
          E31009E3E3E309101009E88181ACAC81E3AC81E3E3E381ACAC81091009101009
          E31009E3E3E30910100981AC81ACAC81E3AC81E3E3E381ACAC81091009101009
          E3E3E3E3E3E30910100981AC81ACAC81E3E3E3E3E3E381ACAC81091009101010
          0909090909091010100981AC81ACACAC818181818181ACACAC81091009101010
          1010101010101010100981AC81ACACACACACACACACACACACAC81091009101009
          0909090909090910100981AC81ACAC8181818181818181ACAC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC810910091009D7
          090909090909D709100981AC81AC81D7818181818181D781AC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC81091009E309D7
          090909090909D709090981AC81E381D7818181818181D78181810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC8109E309090909
          0909090909090909090981E38181818181818181818181818181091009D7D7D7
          D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8090909090909
          0909090909090909E8E88181818181818181818181818181E8E8}
        NumGlyphs = 2
      end
    end
    object TabSheet5: TRzTabSheet
      Caption = #31995#32479#30417#25511
      object Label53: TLabel
        Left = 80
        Top = 32
        Width = 84
        Height = 12
        Caption = #20013#38388#23618#38431#21015#28385#65306
      end
      object Label56: TLabel
        Left = 80
        Top = 57
        Width = 84
        Height = 12
        Caption = #32593#32476#36830#25509#38169#35823#65306
      end
      object Label57: TLabel
        Left = 33
        Top = 107
        Width = 132
        Height = 12
        Caption = #36830#25509#38169#35823#27425#25968#20419#21457#25253#35686#65306
      end
      object SpeedButton8: TSpeedButton
        Left = 327
        Top = 23
        Width = 49
        Height = 22
        Caption = #35797#21548
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000
          8080000000808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0000000008080000000C0C0C0C0C0C0808080C0C0C0C0C0
          C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000808080808080
          8080FFFFFFFFFFFF808080C0C0C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C000000000808000FFFF000000C0C0C0FFFFFFFFFFFF808080C0C0C08080
          80C0C0C0C0C0C0C0C0C0C0C0C000000000000000808000FFFFFFFFFF000000C0
          C0C0FFFFFFFFFFFF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000008080
          80808000FFFFFFFFFF00FFFF000000000000FFFFFFFFFFFF808080C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C000808000FFFFC0C0C0FFFFFF00FFFFFFFFFF00000080
          8080000000FFFFFF808080C0C0C080808080808080808080808000808000FFFF
          C0C0C000FFFFFFFFFF00FFFF000000C0C0C0000000FFFFFF808080C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0008080FFFFFFC0C0C0FFFFFF00FFFFFFFFFF00000000
          0000FFFFFFFFFFFF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080
          00808000FFFFFFFFFF00FFFF000000C0C0C0FFFFFFFFFFFF808080C0C0C08080
          80C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000808000FFFFFFFFFF000000C0
          C0C0FFFFFFFFFFFF808080C0C0C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C000808000FFFF808080808080C0C0C0FFFFFF808080C0C0C0C0C0
          C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000808000FFFF00
          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0008080808080000000808080C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        OnClick = SpeedButton8Click
      end
      object SpeedButton9: TSpeedButton
        Left = 328
        Top = 47
        Width = 48
        Height = 21
        Caption = #35797#21548
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000
          8080000000808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0000000008080000000C0C0C0C0C0C0808080C0C0C0C0C0
          C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000808080808080
          8080FFFFFFFFFFFF808080C0C0C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C000000000808000FFFF000000C0C0C0FFFFFFFFFFFF808080C0C0C08080
          80C0C0C0C0C0C0C0C0C0C0C0C000000000000000808000FFFFFFFFFF000000C0
          C0C0FFFFFFFFFFFF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000008080
          80808000FFFFFFFFFF00FFFF000000000000FFFFFFFFFFFF808080C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C000808000FFFFC0C0C0FFFFFF00FFFFFFFFFF00000080
          8080000000FFFFFF808080C0C0C080808080808080808080808000808000FFFF
          C0C0C000FFFFFFFFFF00FFFF000000C0C0C0000000FFFFFF808080C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0008080FFFFFFC0C0C0FFFFFF00FFFFFFFFFF00000000
          0000FFFFFFFFFFFF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080
          00808000FFFFFFFFFF00FFFF000000C0C0C0FFFFFFFFFFFF808080C0C0C08080
          80C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000808000FFFFFFFFFF000000C0
          C0C0FFFFFFFFFFFF808080C0C0C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C000808000FFFF808080808080C0C0C0FFFFFF808080C0C0C0C0C0
          C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000808000FFFF00
          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0008080808080000000808080C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
      end
      object Label63: TLabel
        Left = 55
        Top = 82
        Width = 108
        Height = 12
        Caption = #32593#20851#32531#20914#21306#38431#21015#28385#65306
      end
      object SpeedButton10: TSpeedButton
        Left = 288
        Top = 73
        Width = 33
        Height = 21
        Caption = '...'
        Flat = True
        OnClick = SpeedButton10Click
      end
      object SpeedButton11: TSpeedButton
        Left = 328
        Top = 73
        Width = 48
        Height = 21
        Caption = #35797#21548
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000
          8080000000808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0000000008080000000C0C0C0C0C0C0808080C0C0C0C0C0
          C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000808080808080
          8080FFFFFFFFFFFF808080C0C0C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C000000000808000FFFF000000C0C0C0FFFFFFFFFFFF808080C0C0C08080
          80C0C0C0C0C0C0C0C0C0C0C0C000000000000000808000FFFFFFFFFF000000C0
          C0C0FFFFFFFFFFFF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000008080
          80808000FFFFFFFFFF00FFFF000000000000FFFFFFFFFFFF808080C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C000808000FFFFC0C0C0FFFFFF00FFFFFFFFFF00000080
          8080000000FFFFFF808080C0C0C080808080808080808080808000808000FFFF
          C0C0C000FFFFFFFFFF00FFFF000000C0C0C0000000FFFFFF808080C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0008080FFFFFFC0C0C0FFFFFF00FFFFFFFFFF00000000
          0000FFFFFFFFFFFF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080
          00808000FFFFFFFFFF00FFFF000000C0C0C0FFFFFFFFFFFF808080C0C0C08080
          80C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000808000FFFFFFFFFF000000C0
          C0C0FFFFFFFFFFFF808080C0C0C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C000808000FFFF808080808080C0C0C0FFFFFF808080C0C0C0C0C0
          C0C0C0C0808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000808000FFFF00
          0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0008080808080000000808080C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
          0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
      end
      object SpeedButton12: TSpeedButton
        Left = 8
        Top = 24
        Width = 65
        Height = 49
        Flat = True
        Glyph.Data = {
          36240000424D3624000000000000360000002800000030000000300000000100
          20000000000000240000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000007B7B7BFF7B7B7BFF7B7B
          7BFF7B7B7BFF7B7B7BFF7B7B7BFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000F2B3B3FFEFACACFFE699
          99FFCF8C8CFFB07474FF936D6DFF766F6FFF7B7B7BFF7B7B7BFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000ECA6A6FFECA6A6FFECA6
          A6FFECA6A6FFECA6A6FFEFACACFFD88888FFA56D6DFF766969FF787878FF7B7B
          7BFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000ECA6A6FFECA6A6FFECA6A6FFD88888FF9D6A6AFF6969
          69FF7B7B7BFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000ECA6A6FFECA6A6FFECA6A6FFC172
          72FF776464FF787878FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007B7B7BFF7B7B7BFF7B7B7BFF7B7B
          7BFF7B7B7BFF0000000000000000000000000000000000000000ECA6A6FFECA6
          A6FFD27C7CFF8B6565FF6E6E6EFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000EFACACFFEFACACFFEFACACFFECA6A6FFECA6
          A6FFECA6A6FF847777FF7B7B7BFF00000000000000000000000000000000ECA6
          A6FFECA6A6FFDF8C8CFF8C6565FF6E6E6EFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000ECA6A6FFECA6A6FFECA6A6FF787171FF7B7B7BFF00000000000000000000
          0000ECA6A6FFECA6A6FFDF8C8CFF8B6565FF727272FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000656565FF6E6E
          6EFF5C5C5CFF595959FF5F5F5FFF6A6A6AFF767676FF00000000000000000000
          00000000000000000000ECA6A6FFECA6A6FF927272FF727272FF000000000000
          000000000000ECA6A6FFECA6A6FFD67979FF766262FF7D7D7DFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000656565FF424242FF333333FF3D3D
          3DFF333333FF333333FF333333FF333333FF393939FF454545FF5C5C5CFF7878
          78FF000000000000000000000000ECA6A6FFECA6A6FFAA7171FF717171FF0000
          00000000000000000000ECA6A6FFECA6A6FFCB6F6FFF666060FF7B7B7BFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000838383FF3A3A3AFF464646FF939393FFB9B9B9FFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFB9B9B9FF939393FF595959FF353535FF3D3D
          3DFF595959FF000000000000000000000000ECA6A6FFECA6A6FFB27373FF6E6E
          6EFF000000000000000000000000ECA6A6FFECA6A6FFB56969FF696969FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000626262FF3D3D3DFF8D8D8DFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFA6A6A6FF5959
          59FF353535FF494949FF717171FF0000000000000000ECA6A6FFECA6A6FFAF6F
          6FFF7B7B7BFF000000000000000000000000ECA6A6FFE29393FF8B6565FF7E7E
          7EFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00005F5F5FFF4A4A4AFF9C9C9CFFBDBDBDFFC3C3C3FFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFF898989FF333333FF3F3F3FFF6A6A6AFF0000000000000000ECA6A6FFE293
          93FF977070FF7B7B7BFF000000000000000000000000ECA6A6FFC67070FF6B64
          64FF7B7B7BFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008383
          83FF3A3A3AFF9C9C9CFFAEAEAEFFB1B1B1FFA5A5A5FF939393FF838383FF8686
          86FF898989FF8D8D8DFF9B9B9BFFB1B1B1FFC5C5C5FFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFAEAEAEFF3D3D3DFF3F3F3FFF6A6A6AFF0000000000000000ECA6
          A6FFECA6A6FF7C6F6FFF7B7B7BFF0000000000000000ECA6A6FFE99F9FFF9865
          65FF7B7B7BFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000003333
          33FF838383FF9F9F9FFF959595FF787878FF898989FFA5A5A5FFBABABAFFCCCC
          CCFFCCCCCCFFC5C5C5FFB9B9B9FFA8A8A8FF939393FFABABABFFC9C9C9FFCCCC
          CCFFCCCCCCFFCCCCCCFFAEAEAEFF3D3D3DFF3F3F3FFF717171FF000000000000
          0000ECA6A6FFECA6A6FF757575FF000000000000000000000000ECA6A6FFCB6F
          6FFF676767FF7B7B7BFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000565656FF5959
          59FF919191FF7E7E7EFF727272FF959595FFAEAEAEFFB4B4B4FFBDBDBDFFC3C3
          C3FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFC5C5C5FFA6A6A6FF9C9C9CFFBFBF
          BFFFCCCCCCFFCCCCCCFFCCCCCCFFAEAEAEFF333333FF494949FF838383FF0000
          000000000000ECA6A6FF8B7272FF7B7B7BFF0000000000000000ECA6A6FFECA6
          A6FF8C6565FF7B7B7BFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000373737FF7B7B
          7BFF787878FF6C6C6CFF8D8D8DFF9F9F9FFFA3A3A3FFAEAEAEFFB4B4B4FFBDBD
          BDFFC3C3C3FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFB9B9B9FF9999
          99FFB9B9B9FFCCCCCCFFCCCCCCFFCCCCCCFF898989FF353535FF565656FF0000
          000000000000ECA6A6FFECA6A6FF787878FF000000000000000000000000ECA6
          A6FFB56969FF717171FF00000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000007B7B7BFF4D4D4DFF7171
          71FF626262FF808080FF919191FF959595FF9F9F9FFFA3A3A3FFAEAEAEFFB4B4
          B4FFBDBDBDFFC3C3C3FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFBFBF
          BFFF9C9C9CFFB9B9B9FFCCCCCCFFCCCCCCFFCCCCCCFF595959FF3D3D3DFF7171
          71FF0000000000000000ECA6A6FF867373FF7B7B7BFF0000000000000000ECA6
          A6FFDC8686FF756868FF7B7B7BFF000000000000000000000000000000000000
          00000000000000000000000000000000000000000000454545FF5C5C5CFF6262
          62FF6C6C6CFF808080FF868686FF919191FF7D7D7DFF6A6A6AFF515151FF6262
          62FF7E7E7EFFADADADFFC3C3C3FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFFB9B9B9FF9C9C9CFFC3C3C3FFCCCCCCFFCCCCCCFFB9B9B9FF333333FF4F4F
          4FFF0000000000000000ECA6A6FFAA7171FF7B7B7BFF0000000000000000ECA6
          A6FFE99F9FFF8E6868FF7B7B7BFF000000000000000000000000000000000000
          00000000000000000000000000000000000000000000373737FF626262FF5959
          59FF717171FF767676FF7B7B7BFF494949FF453D3DFF725757FF9D6E6EFF8C65
          65FF695050FF333333FF787878FFC3C3C3FFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFAEAEAEFFA3A3A3FFCCCCCCFFCCCCCCFFCCCCCCFF6C6C6CFF3939
          39FF767676FF00000000ECA6A6FFECA6A6FF7B7B7BFF00000000000000000000
          0000F9BFBFFFA76868FF7B7B7BFF000000000000000000000000000000000000
          0000000000000000000000000000000000007B7B7BFF3F3F3FFF595959FF5C5C
          5CFF676767FF6E6E6EFF3F3F3FFF695252FFB98080FFC28585FFC28585FFC285
          85FFC48686FFB87D7DFF504343FF4D4D4DFFBABABAFFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFF9F9F9FFFB6B6B6FFCCCCCCFFCCCCCCFFB9B9B9FF3535
          35FF5C5C5CFF0000000000000000ECA6A6FF8B7878FF7B7B7BFF000000000000
          0000FFCCCCFFC77676FF7B7B7BFF000000000000000000000000000000000000
          0000000000000000000000000000000000007B7B7BFF494949FF545454FF5C5C
          5CFF666666FF4D4D4DFF4F4545FFAB7D7DFFAB7D7DFFAB7D7DFFAB7D7DFFB380
          80FFBC8383FFC28585FFB98080FF604D4DFF565656FFC3C3C3FFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFFBABABAFF9B9B9BFFCCCCCCFFCCCCCCFFCCCCCCFF5959
          59FF454545FF0000000000000000ECA6A6FFA67F7FFF7B7B7BFF000000000000
          0000FFCCCCFFD98080FF7B7B7BFF000000000000000000000000000000000000
          00000000000000000000000000007B7B7BFF524B4BFF464646FF4D4D4DFF5F5F
          5FFF5F5F5FFF373737FF937171FF9C7878FF9C7878FF9C7878FF9C7878FFA37A
          7AFFA37A7AFFAB7D7DFFBA8282FFB98080FF4E4242FF787878FFC3C3C3FFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFF9B9B9BFFB9B9B9FFCCCCCCFFCCCCCCFF9393
          93FF393939FF757575FF00000000ECA6A6FFC69393FF7B7B7BFF000000000000
          0000FDD4D4FFE8A8A8FF7B7B7BFF000000000000000000000000000000000000
          000000000000000000006E4E4EFF653535FF4D3333FF404040FF4D4D4DFF5C5C
          5CFF525252FF423E3EFF7B6D6DFF766B6BFF766B6BFF766B6BFF766B6BFF816F
          6FFF927474FF9F7979FFA37A7AFFB38080FF9E7171FF3D3D3DFFB4B4B4FFC3C3
          C3FFCCCCCCFFCCCCCCFFCCCCCCFFB3B3B3FFA5A5A5FFCCCCCCFFCCCCCCFFB9B9
          B9FF333333FF656565FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000683737FF693B3BFF755757FF564B4BFF404040FF4A4A4AFF5959
          59FF464646FF4D4D4DFF666666FF666666FF666666FF666666FF666666FF6666
          66FF6A6767FF7F6E6EFF987676FFA37A7AFFAF7E7EFF574848FF7E7E7EFFBDBD
          BDFFC3C3C3FFCCCCCCFFCCCCCCFFC5C5C5FF939393FFC9C9C9FFCCCCCCFFCCCC
          CCFF464646FF545454FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00006A3A3AFF704B4BFF857575FF8E7A7AFF645959FF3D3D3DFF494949FF5454
          54FF464646FF515151FF757575FF7B7B7BFF7E7E7EFF7E7E7EFF787878FF7171
          71FF696969FF666666FF746A6AFF987676FFA37A7AFF8A6767FF4A4A4AFFB4B4
          B4FFBDBDBDFFC3C3C3FFCCCCCCFFCCCCCCFF9B9B9BFFBDBDBDFFCCCCCCFFCCCC
          CCFF626262FF4A4A4AFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000007B51
          51FF693838FF947A7AFF9C8282FFA48585FF705E5EFF393939FF424242FF5252
          52FF424242FF595959FF808080FF868686FF8A8A8AFF8A8A8AFF838383FF7E7E
          7EFF7B7B7BFF6C6C6CFF666666FF776C6CFF9C7878FFA57B7BFF333333FFAEAE
          AEFFB4B4B4FFBDBDBDFFC3C3C3FFCCCCCCFFA5A5A5FFADADADFFCCCCCCFFCCCC
          CCFF808080FF454545FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000007B51
          51FF835858FFAE8A8AFFB38C8CFFBC9191FFA07C7CFF373737FF3F3F3FFF4D4D
          4DFF424242FF5A5A5AFF959595FF969696FF9C9C9CFF9B9B9BFF969696FF9393
          93FF838383FF7D7D7DFF696969FF666666FF857070FFA37A7AFF484040FF8989
          89FFAEAEAEFFB4B4B4FFBDBDBDFFC3C3C3FFABABABFFA8A8A8FFCCCCCCFFCCCC
          CCFF808080FF454545FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006633
          33FFA17373FFC39494FFCA9898FFCC9999FFC39494FF333333FF3A3A3AFF4949
          49FF454545FF464646FF9F9F9FFFADADADFFADADADFFADADADFFABABABFF9C9C
          9CFF959595FF808080FF787878FF666666FF726A6AFF9A7777FF4F4545FF8585
          85FFA3A3A3FFAEAEAEFFB4B4B4FFBDBDBDFFABABABFF999999FFCCCCCCFFCCCC
          CCFF808080FF424242FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006633
          33FFB38080FFCD9B9BFFD1A3A3FFD5ABABFFDAB5B5FF534D4DFF393939FF4242
          42FF494949FF333333FF9F9F9FFFB3B3B3FFB9B9B9FFB9B9B9FFAEAEAEFFADAD
          ADFF999999FF8D8D8DFF7E7E7EFF6C6C6CFF676767FF907474FF4F4545FF7D7D
          7DFF9F9F9FFFA3A3A3FFAEAEAEFFB4B4B4FFAEAEAEFF969696FFCCCCCCFFCCCC
          CCFF808080FF464646FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006633
          33FFBA8E8EFFDAB5B5FFDEBCBCFFE1C4C4FFE7CFCFFF837B7BFF353535FF3D3D
          3DFF464646FF3A3A3AFF757575FFC5C5C5FFCACACAFFC7C7C7FFBFBFBFFFADAD
          ADFFA5A5A5FF959595FF7E7E7EFF717171FF666666FF8B7272FF333333FF8A8A
          8AFF959595FF9F9F9FFFA3A3A3FFAEAEAEFF999999FF959595FFC3C3C3FFCCCC
          CCFF808080FF464646FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006633
          33FFB38E8EFFE7CFCFFFEAD5D5FFEEDDDDFFF4E8E8FFD3CDCDFF333333FF3535
          35FF424242FF424242FF3D3D3DFFB3B3B3FFDDDDDDFFD3D3D3FFC5C5C5FFADAD
          ADFFA8A8A8FF969696FF7E7E7EFF727272FF666666FF645A5AFF3D3D3DFF8686
          86FF919191FF959595FF9F9F9FFFA3A3A3FF959595FF9C9C9CFFBDBDBDFFC3C3
          C3FF767676FF4A4A4AFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006633
          33FFA27E7EFFF3E7E7FFF7EFEFFFFCF9F9FFFFFFFFFFFFFFFFFF595959FF3333
          33FF3A3A3AFF424242FF3A3A3AFF4E4E4EFFC7C7C7FFCACACAFFC5C5C5FFADAD
          ADFFA6A6A6FF969696FF7E7E7EFF727272FF666666FF444141FF565656FF8080
          80FF868686FF919191FF959595FF9F9F9FFF858585FF9C9C9CFFB4B4B4FFBDBD
          BDFF565656FF5C5C5CFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000784B4BFFFFFFFFFFFFFFFFFFFDFDFDFFF5F5F5FFEFEFEFFFA6A6A6FF3333
          33FF353535FF3F3F3FFF424242FF373737FF4E4E4EFFBABABAFFB6B6B6FFADAD
          ADFF9C9C9CFF939393FF7E7E7EFF6E6E6EFF545454FF373737FF6E6E6EFF7676
          76FF808080FF868686FF919191FF939393FF787878FF9F9F9FFFAEAEAEFFADAD
          ADFF333333FF5C5C5CFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000663333FFC1AEAEFFEFEFEFFFEBEBEBFFEBEBEBFFE3E3E3FFDDDDDDFF5252
          52FF333333FF373737FF404040FF424242FF393939FF424242FF808080FF9F9F
          9FFF969696FF868686FF787878FF4E4E4EFF373737FF5C5C5CFF676767FF7272
          72FF767676FF808080FF868686FF858585FF7B7B7BFF9F9F9FFFA3A3A3FF8080
          80FF3A3A3AFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000006F3F3FFFDCD9D9FFDDDDDDFFD6D6D6FFD6D6D6FFD0D0D0FFA3A3
          A3FF333333FF333333FF393939FF404040FF424242FF3F3F3FFF353535FF3939
          39FF4D4D4DFF464646FF393939FF3D3D3DFF595959FF626262FF666666FF6767
          67FF727272FF767676FF808080FF717171FF858585FF959595FF9F9F9FFF4E4E
          4EFF5C5C5CFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000006F3F3FFF907070FFD3D3D3FFCCCCCCFFC5C5C5FFC3C3C3FFBFBF
          BFFF6C6C6CFF333333FF333333FF393939FF404040FF424242FF464646FF4646
          46FF464646FF4A4A4AFF515151FF595959FF5C5C5CFF606060FF626262FF6666
          66FF676767FF727272FF6E6E6EFF6E6E6EFF868686FF919191FF7D7D7DFF3737
          37FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000006F3F3FFF896969FFBFBFBFFFB9B9B9FFB1B1B1FFADAD
          ADFFADADADFF464646FF333333FF333333FF393939FF404040FF424242FF4646
          46FF4A4A4AFF4D4D4DFF525252FF545454FF595959FF5C5C5CFF606060FF6262
          62FF666666FF666666FF656565FF727272FF808080FF868686FF4A4A4AFF5C5C
          5CFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000006F3F3FFF6F3F3FFF978787FFA8A8A8FF9C99
          99FF867373FF704D4DFF3D3333FF333333FF333333FF373737FF404040FF4242
          42FF464646FF4A4A4AFF4D4D4DFF525252FF545454FF595959FF5C5C5CFF6060
          60FF606060FF5F5F5FFF656565FF727272FF767676FF595959FF424242FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000663333FF663333FF6633
          33FF6B3C3CFF6B3C3CFF00000000565656FF333333FF333333FF373737FF3D3D
          3DFF424242FF464646FF4A4A4AFF4D4D4DFF525252FF545454FF595959FF5656
          56FF595959FF606060FF666666FF676767FF5A5A5AFF373737FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000565656FF333333FF353535FF3737
          37FF393939FF3F3F3FFF424242FF494949FF494949FF4D4D4DFF4E4E4EFF5454
          54FF5C5C5CFF606060FF626262FF4D4D4DFF373737FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000565656FF3F3F3FFF3535
          35FF393939FF3D3D3DFF404040FF454545FF464646FF4D4D4DFF515151FF5454
          54FF595959FF525252FF3A3A3AFF494949FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000005656
          56FF3F3F3FFF353535FF393939FF3D3D3DFF424242FF454545FF454545FF4242
          42FF373737FF3A3A3AFF606060FF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000606060FF606060FF606060FF606060FF606060FF6060
          60FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      object SpeedButton6: TSpeedButton
        Left = 288
        Top = 23
        Width = 33
        Height = 21
        Caption = '...'
        Flat = True
        OnClick = SpeedButton6Click
      end
      object SpeedButton13: TSpeedButton
        Left = 288
        Top = 48
        Width = 33
        Height = 21
        Caption = '...'
        Flat = True
        OnClick = SpeedButton13Click
      end
      object Label74: TLabel
        Left = 16
        Top = 133
        Width = 144
        Height = 36
        Caption = #31995#32479#25903#25345#65306'  '#19979#34892#30701#20449#20869#23481#36229#36807'250'#20010#23383#31526#26102','#31995#32479#33258#21160#20316#20998#21253#19979#21457#22788#29702#65281
        WordWrap = True
      end
      object Edit4: TEdit
        Left = 168
        Top = 24
        Width = 121
        Height = 20
        ReadOnly = True
        TabOrder = 0
      end
      object Edit12: TEdit
        Left = 168
        Top = 49
        Width = 121
        Height = 20
        ReadOnly = True
        TabOrder = 1
      end
      object Edit13: TEdit
        Left = 168
        Top = 99
        Width = 121
        Height = 20
        TabOrder = 2
      end
      object Edit14: TEdit
        Left = 168
        Top = 74
        Width = 121
        Height = 20
        TabOrder = 3
      end
      object GroupBox11: TGroupBox
        Left = 384
        Top = 0
        Width = 200
        Height = 185
        Caption = 'UDP'#30417#25511
        TabOrder = 4
        object Label69: TLabel
          Left = 29
          Top = 34
          Width = 60
          Height = 12
          Caption = 'ServerHost'
        end
        object Label70: TLabel
          Left = 47
          Top = 55
          Width = 42
          Height = 12
          Caption = 'UDPPort'
        end
        object Label71: TLabel
          Left = 29
          Top = 76
          Width = 60
          Height = 12
          Caption = 'BufferSize'
        end
        object Label72: TLabel
          Left = 6
          Top = 97
          Width = 84
          Height = 12
          Caption = 'ReceiveTimeout'
        end
        object CheckBox3: TCheckBox
          Left = 24
          Top = 152
          Width = 152
          Height = 17
          Caption = 'BroadcastEnabled('#24191#25773')'
          TabOrder = 0
        end
        object EIP: TEdit
          Left = 94
          Top = 26
          Width = 97
          Height = 20
          TabOrder = 1
        end
        object EPort: TEdit
          Left = 94
          Top = 47
          Width = 97
          Height = 20
          TabOrder = 2
        end
        object Edit18: TEdit
          Left = 94
          Top = 68
          Width = 97
          Height = 20
          ReadOnly = True
          TabOrder = 3
          Text = '8192'
        end
        object Edit19: TEdit
          Left = 95
          Top = 89
          Width = 96
          Height = 20
          ReadOnly = True
          TabOrder = 4
          Text = '-2'
        end
        object CheckBox4: TCheckBox
          Left = 24
          Top = 128
          Width = 121
          Height = 17
          Caption = #21551#21160'UDP'#28040#24687#30417#25511
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
      end
      object RzBitBtn6: TRzBitBtn
        Left = 448
        Top = 200
        Width = 80
        Caption = #20445#23384'Save'
        HotTrack = True
        TabOrder = 5
        OnClick = RzBitBtn6Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000830E0000830E00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8090909
          09090909090909090909E8E8E881818181818181818181818181E8E809101009
          E31009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E80909101009
          E31009E3E3E309101009E88181ACAC81E3AC81E3E3E381ACAC81091009101009
          E31009E3E3E30910100981AC81ACAC81E3AC81E3E3E381ACAC81091009101009
          E3E3E3E3E3E30910100981AC81ACAC81E3E3E3E3E3E381ACAC81091009101010
          0909090909091010100981AC81ACACAC818181818181ACACAC81091009101010
          1010101010101010100981AC81ACACACACACACACACACACACAC81091009101009
          0909090909090910100981AC81ACAC8181818181818181ACAC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC810910091009D7
          090909090909D709100981AC81AC81D7818181818181D781AC810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC81091009E309D7
          090909090909D709090981AC81E381D7818181818181D78181810910091009D7
          D7D7D7D7D7D7D709100981AC81AC81D7D7D7D7D7D7D7D781AC8109E309090909
          0909090909090909090981E38181818181818181818181818181091009D7D7D7
          D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8090909090909
          0909090909090909E8E88181818181818181818181818181E8E8}
        NumGlyphs = 2
      end
      object GroupBox14: TGroupBox
        Left = 168
        Top = 128
        Width = 185
        Height = 89
        Caption = #30005#20449#19978#34892#24773#20917#39044#35686
        TabOrder = 6
        object Label78: TLabel
          Left = 8
          Top = 40
          Width = 24
          Height = 12
          Caption = #36229#36807
        end
        object Label79: TLabel
          Left = 80
          Top = 40
          Width = 96
          Height = 12
          Caption = #20998#38047#21457#36865#39044#35686#28040#24687
        end
        object Label80: TLabel
          Left = 8
          Top = 64
          Width = 72
          Height = 12
          Caption = #36830#32493#21457#36865#27425#25968
        end
        object CheckBox6: TCheckBox
          Left = 8
          Top = 16
          Width = 97
          Height = 17
          Caption = #39044#35686#24320#20851
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object RzSpinEdit1: TRzSpinEdit
          Left = 32
          Top = 32
          Width = 47
          Height = 20
          AllowKeyEdit = True
          Max = 120.000000000000000000
          Min = 1.000000000000000000
          Value = 30.000000000000000000
          Alignment = taLeftJustify
          TabOrder = 1
        end
        object RzSpinEdit2: TRzSpinEdit
          Left = 80
          Top = 56
          Width = 47
          Height = 20
          AllowKeyEdit = True
          Min = 1.000000000000000000
          Value = 10.000000000000000000
          Alignment = taLeftJustify
          TabOrder = 2
        end
      end
    end
  end
  object Edit15: TEdit
    Left = 112
    Top = 264
    Width = 185
    Height = 20
    BorderStyle = bsNone
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 1
  end
  object RzBitBtn2: TRzBitBtn
    Left = 448
    Top = 256
    Width = 80
    Caption = #36864#20986'Exit'
    HotTrack = True
    TabOrder = 2
    OnClick = RzBitBtn2Click
    Glyph.Data = {
      36060000424D3606000000000000360400002800000020000000100000000100
      08000000000000020000730B0000730B00000001000000000000000000003300
      00006600000099000000CC000000FF0000000033000033330000663300009933
      0000CC330000FF33000000660000336600006666000099660000CC660000FF66
      000000990000339900006699000099990000CC990000FF99000000CC000033CC
      000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
      0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
      330000333300333333006633330099333300CC333300FF333300006633003366
      33006666330099663300CC663300FF6633000099330033993300669933009999
      3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
      330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
      66006600660099006600CC006600FF0066000033660033336600663366009933
      6600CC336600FF33660000666600336666006666660099666600CC666600FF66
      660000996600339966006699660099996600CC996600FF99660000CC660033CC
      660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
      6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
      990000339900333399006633990099339900CC339900FF339900006699003366
      99006666990099669900CC669900FF6699000099990033999900669999009999
      9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
      990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
      CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
      CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
      CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
      CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
      CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
      FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
      FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
      FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
      FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
      000000808000800000008000800080800000C0C0C00080808000191919004C4C
      4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
      6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
      EEE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8EEE8E8E8E8E8E8E8E8E8E8E8E8EEE3AC
      E3EEE8E8E8E8E8E8E8E8E8E8E8EEE8ACE3EEE8E8E8E8E8E8E8E8E8EEE3E28257
      57E2ACE3EEE8E8E8E8E8E8EEE8E2818181E2ACE8EEE8E8E8E8E8E382578282D7
      578181E2E3E8E8E8E8E8E881818181D7818181E2E8E8E8E8E8E857828989ADD7
      57797979EEE8E8E8E8E88181DEDEACD781818181EEE8E8E8E8E857898989ADD7
      57AAAAA2D7ADE8E8E8E881DEDEDEACD781DEDE81D7ACE8E8E8E857898989ADD7
      57AACEA3AD10E8E8E8E881DEDEDEACD781DEAC81AC81E8E8E8E85789825EADD7
      57ABCFE21110E8E8E8E881DE8181ACD781ACACE28181E8E8E8E8578957D7ADD7
      57ABDE101010101010E881DE56D7ACD781ACDE818181818181E857898257ADD7
      57E810101010101010E881DE8156ACD781E381818181818181E857898989ADD7
      57E882101010101010E881DEDEDEACD781E381818181818181E857898989ADD7
      57ACEE821110E8E8E8E881DEDEDEACD781ACEE818181E8E8E8E857898989ADD7
      57ABE8AB8910E8E8E8E881DEDEDEACD781ACE3ACDE81E8E8E8E857828989ADD7
      57ACE8A3E889E8E8E8E88181DEDEACD781ACE381E8DEE8E8E8E8E8DE5E8288D7
      57A2A2A2E8E8E8E8E8E8E8DE8181DED781818181E8E8E8E8E8E8E8E8E8AC8257
      57E8E8E8E8E8E8E8E8E8E8E8E8AC818181E8E8E8E8E8E8E8E8E8}
    NumGlyphs = 2
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.Wav|*.Wav'
    Title = #36873#25321#25253#35686#25991#20214
    Left = 385
    Top = 259
  end
  object OpenDialog2: TOpenDialog
    Filter = '*.Wav|*.Wav'
    Title = #36873#25321#25253#35686#25991#20214
    Left = 329
    Top = 259
  end
  object OpenDialog3: TOpenDialog
    Filter = '*.Wav|*.Wav'
    Title = #36873#25321#25253#35686#25991#20214
    Left = 353
    Top = 259
  end
end
