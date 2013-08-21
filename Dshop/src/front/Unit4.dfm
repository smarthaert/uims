object Main_T: TMain_T
  Left = 343
  Top = 24
  Width = 1045
  Height = 810
  ActiveControl = edt1
  Caption = 'Main_T'
  Color = clBlack
  Font.Charset = GB2312_CHARSET
  Font.Color = clWhite
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1037
    Height = 40
    Align = alTop
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 924
      Top = 10
      Width = 100
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
      Width = 596
      Height = 27
      Caption = #9733#9733#9733#23454#24191#27700#26063#19990#30028#26071#33328#29256' - '#20135#21697#21806#21518#9733#9733#9733
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = #20223#23435'_GB2312'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object RzFormShape1: TRzFormShape
      Left = 2
      Top = 2
      Width = 791
      Height = 40
      Align = alCustom
    end
    object SpeedButton2: TSpeedButton
      Left = 795
      Top = 10
      Width = 121
      Height = 19
      Caption = 'F12.'#31383#21475#23621#20013
      Flat = True
      ParentShowHint = False
      ShowHint = False
      OnClick = SpeedButton2Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 719
    Width = 1037
    Height = 64
    Align = alBottom
    BevelInner = bvLowered
    Color = clBlack
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 7
    object Label2: TLabel
      Left = 12
      Top = 10
      Width = 96
      Height = 16
      Caption = 'F1.'#21830#21697#26465#30721':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 13
      Top = 38
      Width = 48
      Height = 12
      Caption = 'F2.'#25968#37327':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 198
      Top = 38
      Width = 48
      Height = 12
      Caption = 'F4.'#36864#36135':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 528
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
      Left = 584
      Top = 22
      Width = 131
      Height = 33
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 716
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
      Left = 518
      Top = 4
      Width = 2
      Height = 56
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Label17: TLabel
      Left = 300
      Top = 38
      Width = 36
      Height = 12
      Caption = 'F10.-:'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 749
      Top = 4
      Width = 2
      Height = 56
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Label25: TLabel
      Left = 760
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
      Left = 841
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
    object Label31: TLabel
      Left = 105
      Top = 38
      Width = 48
      Height = 12
      Caption = 'F3.'#20214#25968':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label32: TLabel
      Left = 248
      Top = 38
      Width = 48
      Height = 12
      Caption = 'F5.'#21806#21518':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object RzEdit1: TRzEdit
      Left = 455
      Top = 11
      Width = 34
      Height = 20
      Text = '100'
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 4
      Visible = False
      OnKeyPress = RzEdit1KeyPress
    end
    object RzEdit2: TRzEdit
      Left = 327
      Top = 11
      Width = 50
      Height = 20
      Text = '123456'
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 3
      Visible = False
      OnKeyPress = RzEdit2KeyPress
    end
    object RzEdit3: TRzEdit
      Left = 61
      Top = 35
      Width = 40
      Height = 20
      Text = '1234'
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 1
      OnKeyPress = RzEdit3KeyPress
    end
    object RzEdit4: TRzEdit
      Left = 108
      Top = 7
      Width = 190
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
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyPress = RzEdit4KeyPress
    end
    object RzEdit5: TRzEdit
      Left = 153
      Top = 35
      Width = 40
      Height = 20
      Text = '1234'
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 2
      OnKeyPress = RzEdit5KeyPress
    end
    object ComboBox1: TComboBox
      Left = 384
      Top = 11
      Width = 65
      Height = 20
      Color = clBlack
      ItemHeight = 12
      TabOrder = 5
      Text = #32500#20462
      Visible = False
      OnKeyPress = ComboBox1KeyPress
      Items.Strings = (
        #32500#20462
        #36864#36135
        '-')
    end
  end
  object Panel4: TPanel
    Left = 795
    Top = 40
    Width = 242
    Height = 679
    Align = alRight
    BevelInner = bvLowered
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
      Left = 3
      Top = 360
      Width = 242
      Height = 2
      Shape = bsBottomLine
      Style = bsRaised
    end
    object Label18: TLabel
      Left = 7
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
      Left = 98
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
      Left = 7
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
      Left = 28
      Top = 79
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
      Left = -1
      Top = 137
      Width = 242
      Height = 2
      Shape = bsBottomLine
      Style = bsRaised
    end
    object Label23: TLabel
      Left = 42
      Top = 174
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
      Left = 42
      Top = 150
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
      Left = 42
      Top = 273
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
    object Label28: TLabel
      Left = 42
      Top = 297
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
      Left = 42
      Top = 248
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
      Left = 42
      Top = 322
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
    object Label22: TLabel
      Left = 70
      Top = 199
      Width = 126
      Height = 14
      Caption = #36873#25321'"'#21512#35745'"'#34892#26102#35843#25972
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label33: TLabel
      Left = 70
      Top = 224
      Width = 126
      Height = 14
      Caption = #35746#21333#20013#25152#26377#21830#21697#25968#37327
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
  end
  object grp1: TGroupBox
    Left = 8
    Top = 41
    Width = 780
    Height = 82
    Caption = #23458#25143
    Color = clBlack
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 2
    object lbl1: TLabel
      Left = 25
      Top = 17
      Width = 30
      Height = 12
      Caption = #22995#21517':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 138
      Top = 17
      Width = 30
      Height = 12
      Caption = #30005#35805':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 25
      Top = 49
      Width = 30
      Height = 12
      Caption = #22320#22336':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 277
      Top = 17
      Width = 54
      Height = 12
      Caption = #20250#21592#32534#21495':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 413
      Top = 17
      Width = 30
      Height = 12
      Caption = #22320#21306':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl11: TLabel
      Left = 525
      Top = 17
      Width = 54
      Height = 12
      Caption = #24215#38138#21517#31216':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object edt1: TRzEdit
      Left = 63
      Top = 14
      Width = 65
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 0
      OnKeyPress = edt1KeyPress
    end
    object edt2: TRzEdit
      Left = 170
      Top = 14
      Width = 95
      Height = 20
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 1
      OnKeyPress = edt2KeyPress
    end
    object edt3: TRzEdit
      Left = 63
      Top = 46
      Width = 708
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 4
    end
    object edt7: TRzEdit
      Left = 333
      Top = 14
      Width = 65
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 2
    end
    object edt8: TRzEdit
      Left = 445
      Top = 14
      Width = 65
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 3
      OnKeyPress = edt8KeyPress
    end
    object RzEdit7: TRzEdit
      Left = 582
      Top = 14
      Width = 189
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 5
      OnKeyPress = edt8KeyPress
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 125
    Width = 780
    Height = 425
    Caption = #35746#21333
    Color = clBlack
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 4
    object DBGrid1: TDBGrid
      Left = 1
      Top = 13
      Width = 778
      Height = 411
      TabStop = False
      Align = alClient
      BorderStyle = bsNone
      Color = clBlack
      Ctl3D = False
      DataSource = DataSource1
      FixedColor = clBlack
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
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
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'row'
          Title.Caption = #35760#24405
          Width = 39
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pid'
          Title.Alignment = taCenter
          Title.Caption = #21830#21697#32534#21495
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'goodsname'
          Title.Alignment = taCenter
          Title.Caption = #21830#21697#21517#31216
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'color'
          Title.Caption = #39068#33394
          Width = 45
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'volume'
          Title.Caption = #20307#31215
          Width = 38
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ramount'
          Title.Caption = #25968#37327
          Width = 45
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'unit'
          Title.Alignment = taCenter
          Title.Caption = #21333#20301
          Width = 55
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'rbundle'
          Title.Caption = #20214#25968
          Width = 40
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'outprice'
          Title.Caption = #21333#20215
          Width = 37
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'discount'
          Title.Alignment = taCenter
          Title.Caption = #25240#25187
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'additional'
          Title.Alignment = taCenter
          Title.Caption = #34917#20214
          Width = 55
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'subtotal'
          Title.Alignment = taCenter
          Title.Caption = #23567#35745
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'type'
          Title.Caption = #21806#21518
          Width = 45
          Visible = True
        end>
    end
  end
  object grp3: TGroupBox
    Left = 8
    Top = 553
    Width = 780
    Height = 81
    Caption = #25176#36816#37096
    Color = clBlack
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 5
    object lbl4: TLabel
      Left = 24
      Top = 17
      Width = 30
      Height = 12
      Caption = #21517#31216':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 176
      Top = 17
      Width = 30
      Height = 12
      Caption = #30005#35805':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 24
      Top = 49
      Width = 30
      Height = 12
      Caption = #22320#22336':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object edt4: TRzEdit
      Left = 62
      Top = 14
      Width = 100
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 0
      OnKeyPress = edt4KeyPress
    end
    object edt5: TRzEdit
      Left = 208
      Top = 14
      Width = 130
      Height = 20
      Alignment = taRightJustify
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 1
    end
    object edt6: TRzEdit
      Left = 62
      Top = 46
      Width = 708
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameStyle = fsBump
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 2
    end
  end
  object grp4: TGroupBox
    Left = 8
    Top = 637
    Width = 780
    Height = 65
    Caption = #20184#27454
    Color = clBlack
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 6
    object lbl7: TLabel
      Left = 24
      Top = 19
      Width = 54
      Height = 12
      Caption = #20184#27454#26041#24335':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 400
      Top = 19
      Width = 30
      Height = 12
      Caption = #22791#27880':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cbb1: TComboBox
      Left = 80
      Top = 16
      Width = 161
      Height = 20
      BevelEdges = [beBottom]
      Color = clBlack
      Ctl3D = False
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 0
      Items.Strings = (
        #29616#37329
        #36716#36134
        #25176#36816#37096#20195#25910
        #36170#27424)
    end
    object mmo1: TMemo
      Left = 442
      Top = 11
      Width = 330
      Height = 49
      Color = clBlack
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
    end
  end
  object Panel5: TPanel
    Left = 24
    Top = 252
    Width = 33
    Height = 33
    Color = clBlack
    TabOrder = 3
    Visible = False
    object QuickRep1: TQuickRep
      Left = -1
      Top = 2
      Width = 907
      Height = 529
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
        100.000000000000000000
        1400.000000000000000000
        100.000000000000000000
        2400.000000000000000000
        100.000000000000000000
        100.000000000000000000
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
        Left = 38
        Top = 127
        Width = 831
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Frame.Style = psDot
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          50.270833333333330000
          2198.687500000000000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbDetail
        object qrdbtxtpid: TQRDBText
          Left = 61
          Top = 1
          Width = 22
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            161.395833333333300000
            2.645833333333333000
            58.208333333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'pid'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtgoodsname: TQRDBText
          Left = 152
          Top = 1
          Width = 64
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            402.166666666666600000
            2.645833333333333000
            169.333333333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'goodsname'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtcolor: TQRDBText
          Left = 334
          Top = 1
          Width = 36
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            883.708333333333400000
            2.645833333333333000
            95.250000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'color'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtvolume: TQRDBText
          Left = 388
          Top = 1
          Width = 43
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1026.583333333333000000
            2.645833333333333000
            113.770833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'volume'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtamount: TQRDBText
          Left = 443
          Top = 1
          Width = 43
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1172.104166666667000000
            2.645833333333333000
            113.770833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'amount'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtunit: TQRDBText
          Left = 496
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1312.333333333333000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'unit'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtbundle: TQRDBText
          Left = 550
          Top = 1
          Width = 43
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1455.208333333333000000
            2.645833333333333000
            113.770833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'bundle'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtoutprice: TQRDBText
          Left = 605
          Top = 1
          Width = 57
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1600.729166666667000000
            2.645833333333333000
            150.812500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'outprice'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtrepeat: TQRDBText
          Left = 659
          Top = 1
          Width = 71
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1743.604166666667000000
            2.645833333333333000
            187.854166666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'additional'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtsubtotal: TQRDBText
          Left = 712
          Top = 1
          Width = 57
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1883.833333333333000000
            2.645833333333333000
            150.812500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'subtotal'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtrow: TQRDBText
          Left = 24
          Top = 0
          Width = 21
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            63.500000000000000000
            0.000000000000000000
            55.562500000000000000)
          Alignment = taRightJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'row'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      object PageHeaderBand1: TQRBand
        Left = 38
        Top = 38
        Width = 831
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = True
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Frame.Style = psDot
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          79.375000000000000000
          2198.687500000000000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbPageHeader
        object QRLabel1: TQRLabel
          Left = 21
          Top = 0
          Width = 340
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            55.562500000000000000
            0.000000000000000000
            899.583333333333400000)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = #23454#30719#27700#26063#19990#30028
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 20
        end
        object QRLabel2: TQRLabel
          Left = 368
          Top = 0
          Width = 457
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            973.666666666666900000
            0.000000000000000000
            1209.145833333333000000)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Caption = #24744#23478#20013#30340#28023#27915#19990#30028
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 20
        end
      end
      object SummaryBand1: TQRBand
        Left = 38
        Top = 146
        Width = 831
        Height = 75
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Frame.Style = psDot
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          198.437500000000000000
          2198.687500000000000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbSummary
        object QRLabel7: TQRLabel
          Left = 131
          Top = 6
          Width = 78
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            346.604166666666700000
            15.875000000000000000
            206.375000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #24212#25910':999.99'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel9: TQRLabel
          Left = 458
          Top = 6
          Width = 78
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            1211.791666666667000000
            15.875000000000000000
            206.375000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25214#38646':999.99'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel8: TQRLabel
          Left = 284
          Top = 6
          Width = 78
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            751.416666666666800000
            15.875000000000000000
            206.375000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #23454#25910':999.99'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel10: TQRLabel
          Left = 17
          Top = 6
          Width = 92
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            44.979166666666670000
            15.875000000000000000
            243.416666666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25805#20316#21592':'#26446#29233#25991
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl13: TQRLabel
          Left = 17
          Top = 28
          Width = 78
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            44.979166666666670000
            74.083333333333340000
            206.375000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25910#20214#20154':'#32769#36213
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl14: TQRLabel
          Left = 131
          Top = 28
          Width = 120
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            346.604166666666700000
            74.083333333333340000
            317.500000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #30005#35805#65306'12345678901'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl15: TQRLabel
          Left = 284
          Top = 28
          Width = 169
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            751.416666666666800000
            74.083333333333340000
            447.145833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25910#36135#22320#22336#65306#23433#24509#33298#22478#21315#20154#26725
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl16: TQRLabel
          Left = 17
          Top = 51
          Width = 113
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            44.979166666666670000
            134.937500000000000000
            298.979166666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25176#36816#37096#65306#32769#20065#25176#36816
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl17: TQRLabel
          Left = 131
          Top = 51
          Width = 120
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            346.604166666666700000
            134.937500000000000000
            317.500000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #30005#35805#65306'01234567899'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl18: TQRLabel
          Left = 284
          Top = 51
          Width = 162
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            751.416666666666800000
            134.937500000000000000
            428.625000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25176#36816#37096#22320#22336#65306#40644#23665#36335'135'#21495
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl19: TQRLabel
          Left = 458
          Top = 28
          Width = 141
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            1211.791666666667000000
            74.083333333333340000
            373.062500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25903#20184#26041#24335#65306#25176#36816#37096#20195#25910
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      object qrbndPageFooter1: TQRBand
        Left = 38
        Top = 221
        Width = 831
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Frame.Style = psDot
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          79.375000000000000000
          2198.687500000000000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbPageFooter
        object qrlbl20: TQRLabel
          Left = 17
          Top = 7
          Width = 218
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            44.979166666666670000
            18.520833333333330000
            576.791666666666800000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #26085#26399#65306'2013'#24180'08'#26376'12'#26085' 10'#65306'00'#65306'00'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl21: TQRLabel
          Left = 259
          Top = 7
          Width = 113
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            685.270833333333400000
            18.520833333333330000
            298.979166666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21333#21495#65306'1234567895'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl22: TQRLabel
          Left = 397
          Top = 7
          Width = 134
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1050.395833333333000000
            18.520833333333330000
            354.541666666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #37319#36141#30005#35805#65306'123456789'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl12: TQRLabel
          Left = 731
          Top = 7
          Width = 92
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1934.104166666667000000
            18.520833333333330000
            243.416666666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #31532'X'#39029' / '#20849'X'#39029
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          OnPrint = qrlbl12Print
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl23: TQRLabel
          Left = 575
          Top = 5
          Width = 121
          Height = 28
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            74.083333333333340000
            1521.354166666667000000
            13.229166666666670000
            320.145833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #27426#36814#19979#27425#20809#20020
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 14
        end
      end
      object qrbndtitleColumnHeaderBand1: TQRBand
        Left = 38
        Top = 108
        Width = 831
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = True
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Frame.Style = psDot
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          50.270833333333330000
          2198.687500000000000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbColumnHeader
        object qrlbl9: TQRLabel
          Left = 61
          Top = 1
          Width = 57
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            161.395833333333300000
            2.645833333333333000
            150.812500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21830#21697#32534#21495
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl24: TQRLabel
          Left = 152
          Top = 1
          Width = 57
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            402.166666666666600000
            2.645833333333333000
            150.812500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21830#21697#21517#31216
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl25: TQRLabel
          Left = 334
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            883.708333333333400000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #39068#33394
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl26: TQRLabel
          Left = 388
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1026.583333333333000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #20307#31215
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl27: TQRLabel
          Left = 442
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1169.458333333333000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25968#37327
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl28: TQRLabel
          Left = 496
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1312.333333333333000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21333#20301
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl29: TQRLabel
          Left = 550
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1455.208333333333000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #20214#25968
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl30: TQRLabel
          Left = 605
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1600.729166666667000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21333#20215
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl31: TQRLabel
          Left = 659
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1743.604166666667000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #34917#20214
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl32: TQRLabel
          Left = 712
          Top = 1
          Width = 29
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1883.833333333333000000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #23567#35745
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object QRLabel3: TQRLabel
          Left = 25
          Top = 0
          Width = 33
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            66.145833333333340000
            0.000000000000000000
            87.312500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #34892#21495
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      object qrbndtitleTitleBand1: TQRBand
        Left = 38
        Top = 68
        Width = 831
        Height = 40
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
          105.833333333333300000
          2198.687500000000000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbTitle
        object qrlbl2: TQRLabel
          Left = 345
          Top = 6
          Width = 141
          Height = 28
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            74.083333333333340000
            912.812500000000100000
            15.875000000000000000
            373.062500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #20135#21697#20986#24211#21333
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 20
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 72
    Top = 177
  end
  object ADOQuery1: TADOQuery
    Connection = Main.ADOConnection1
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'Select * from Sell_Minor')
    Left = 24
    Top = 214
  end
  object ADOQuerySQL: TADOQuery
    Connection = Main.ADOConnection1
    Parameters = <>
    Left = 72
    Top = 213
  end
  object ADOQuery2: TADOQuery
    Connection = Main.ADOConnection1
    Parameters = <>
    Left = 24
    Top = 181
  end
end
