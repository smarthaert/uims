object Main: TMain
  Left = 412
  Top = 40
  Width = 1045
  Height = 837
  ActiveControl = RzEdit4
  Caption = 'Main'
  Color = clBlack
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
      Width = 261
      Height = 27
      Caption = #23454#30719#27700#26063#19990#30028#26071#33328#29256
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
      Width = 654
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
    Top = 746
    Width = 1037
    Height = 64
    Align = alBottom
    BevelInner = bvLowered
    Color = clBlack
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Label2: TLabel
      Left = 15
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
      Left = 269
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
      Left = 556
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
      Left = 604
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
      Left = 516
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
      Width = 90
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
      Left = 318
      Top = 35
      Width = 67
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
      Left = 119
      Top = 7
      Width = 267
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
    Left = 795
    Top = 40
    Width = 242
    Height = 706
    Align = alRight
    BevelInner = bvLowered
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
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
  object grp1: TGroupBox
    Left = 4
    Top = 41
    Width = 780
    Height = 82
    Caption = #23458#25143
    Color = clBlack
    ParentColor = False
    TabOrder = 4
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
      Left = 177
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
      Left = 353
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
      Left = 521
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
    object edt1: TRzEdit
      Left = 63
      Top = 14
      Width = 100
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 0
      OnKeyPress = edt1KeyPress
    end
    object edt2: TRzEdit
      Left = 209
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
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 1
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
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 2
    end
    object edt7: TRzEdit
      Left = 409
      Top = 14
      Width = 100
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 3
      OnKeyPress = edt1KeyPress
    end
    object edt8: TRzEdit
      Left = 553
      Top = 14
      Width = 100
      Height = 20
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 4
      OnKeyPress = edt1KeyPress
    end
  end
  object grp2: TGroupBox
    Left = 4
    Top = 125
    Width = 780
    Height = 425
    Caption = #35746#21333
    Color = clBlack
    ParentColor = False
    TabOrder = 5
    object DBGrid1: TDBGrid
      Left = 2
      Top = 14
      Width = 776
      Height = 409
      TabStop = False
      Align = alClient
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
          Expanded = False
          FieldName = 'volume'
          Title.Caption = #20307#31215
          Width = 38
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'amount'
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
          Expanded = False
          FieldName = 'bundle'
          Title.Caption = #20214#25968
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'outprice'
          Title.Caption = #21333#20215
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'discount'
          Title.Alignment = taCenter
          Title.Caption = #25240#25187
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'repeat'
          Title.Alignment = taCenter
          Title.Caption = #34917#20214
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'subtotal'
          Title.Alignment = taCenter
          Title.Caption = #23567#35745
          Width = 74
          Visible = True
        end>
    end
  end
  object grp3: TGroupBox
    Left = 4
    Top = 553
    Width = 780
    Height = 81
    Caption = #25176#36816#37096
    Color = clBlack
    ParentColor = False
    TabOrder = 6
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
      FrameVisible = True
      ParentCtl3D = False
      TabOrder = 2
    end
  end
  object grp4: TGroupBox
    Left = 4
    Top = 637
    Width = 780
    Height = 65
    Caption = #20184#27454
    Color = clBlack
    ParentColor = False
    TabOrder = 7
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
    object bvl1: TBevel
      Left = 386
      Top = 4
      Width = 2
      Height = 56
      Shape = bsLeftLine
      Style = bsRaised
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
      Color = clBlack
      ItemHeight = 12
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
      TabOrder = 1
    end
  end
  object Panel5: TPanel
    Left = 27
    Top = 93
    Width = 950
    Height = 684
    Color = clBlack
    TabOrder = 3
    Visible = False
    object QuickRep1: TQuickRep
      Left = 11
      Top = 12
      Width = 907
      Height = 597
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
        1580.000000000000000000
        0.000000000000000000
        2400.000000000000000000
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
        Width = 884
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Frame.Style = psDot
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          52.916666666666660000
          2338.916666666667000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbDetail
        object qrdbtxtpid: TQRDBText
          Left = 29
          Top = 1
          Width = 18
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            76.729166666666680000
            2.645833333333333000
            47.625000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'pid'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtgoodsname: TQRDBText
          Left = 120
          Top = 1
          Width = 68
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            317.500000000000000000
            2.645833333333333000
            179.916666666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'goodsname'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtcolor: TQRDBText
          Left = 302
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
            799.041666666666800000
            2.645833333333333000
            76.729166666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'color'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtvolume: TQRDBText
          Left = 356
          Top = 1
          Width = 41
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            941.916666666666800000
            2.645833333333333000
            108.479166666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'volume'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtamount: TQRDBText
          Left = 411
          Top = 1
          Width = 44
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1087.437500000000000000
            2.645833333333333000
            116.416666666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'amount'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtunit: TQRDBText
          Left = 464
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
            1227.666666666667000000
            2.645833333333333000
            58.208333333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'unit'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtbundle: TQRDBText
          Left = 518
          Top = 1
          Width = 39
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1370.541666666667000000
            2.645833333333333000
            103.187500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'bundle'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtoutprice: TQRDBText
          Left = 573
          Top = 1
          Width = 47
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1516.062500000000000000
            2.645833333333333000
            124.354166666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'outprice'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtrepeat: TQRDBText
          Left = 627
          Top = 1
          Width = 37
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1658.937500000000000000
            2.645833333333333000
            97.895833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'repeat'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxt11: TQRDBText
          Left = 680
          Top = 1
          Width = 55
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1799.166666666667000000
            2.645833333333333000
            145.520833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      object PageHeaderBand1: TQRBand
        Left = 12
        Top = 0
        Width = 884
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
          2338.916666666667000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbPageHeader
        object QRLabel1: TQRLabel
          Left = 21
          Top = 16
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
            42.333333333333340000
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
          Top = 16
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
            42.333333333333340000
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
        object qrlbl1: TQRLabel
          Left = 29
          Top = 54
          Width = 49
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            76.729166666666680000
            142.875000000000000000
            129.645833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21830#21697#32534#21495
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl2: TQRLabel
          Left = 120
          Top = 54
          Width = 49
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            317.500000000000000000
            142.875000000000000000
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
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl3: TQRLabel
          Left = 302
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            799.041666666666800000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #39068#33394
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl4: TQRLabel
          Left = 356
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            941.916666666666800000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #20307#31215
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl5: TQRLabel
          Left = 410
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            1084.791666666667000000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25968#37327
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl6: TQRLabel
          Left = 464
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            1227.666666666667000000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21333#20301
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl7: TQRLabel
          Left = 518
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            1370.541666666667000000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #20214#25968
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl8: TQRLabel
          Left = 572
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            1513.416666666667000000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21333#20215
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl10: TQRLabel
          Left = 627
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            1658.937500000000000000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #34917#20214
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl11: TQRLabel
          Left = 681
          Top = 54
          Width = 25
          Height = 30
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            79.375000000000000000
            1801.812500000000000000
            142.875000000000000000
            66.145833333333340000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #23567#35745
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrsysdt1: TQRSysData
          Left = 771
          Top = 56
          Width = 78
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            2039.937500000000000000
            148.166666666666700000
            206.375000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          Color = clWhite
          Data = qrsDetailCount
          Transparent = False
          FontSize = 10
        end
      end
      object SummaryBand1: TQRBand
        Left = 12
        Top = 90
        Width = 884
        Height = 85
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
          224.895833333333300000
          2338.916666666667000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbSummary
        object QRLabel7: TQRLabel
          Left = 131
          Top = 24
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            346.604166666666700000
            63.500000000000000000
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
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object QRLabel9: TQRLabel
          Left = 458
          Top = 24
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            1211.791666666667000000
            63.500000000000000000
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
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object QRLabel8: TQRLabel
          Left = 284
          Top = 24
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            751.416666666666800000
            63.500000000000000000
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
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object QRLabel10: TQRLabel
          Left = 17
          Top = 24
          Width = 79
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            44.979166666666670000
            63.500000000000000000
            209.020833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25805#20316#21592':'#26446#29233#25991
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl13: TQRLabel
          Left = 17
          Top = 46
          Width = 67
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            44.979166666666670000
            121.708333333333300000
            177.270833333333300000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25910#20214#20154':'#32769#36213
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl14: TQRLabel
          Left = 131
          Top = 46
          Width = 103
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            346.604166666666700000
            121.708333333333300000
            272.520833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #30005#35805#65306'12345678901'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl15: TQRLabel
          Left = 284
          Top = 46
          Width = 145
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            751.416666666666800000
            121.708333333333300000
            383.645833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25910#36135#22320#22336#65306#23433#24509#33298#22478#21315#20154#26725
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl16: TQRLabel
          Left = 17
          Top = 69
          Width = 97
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            44.979166666666670000
            182.562500000000000000
            256.645833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25176#36816#37096#65306#32769#20065#25176#36816
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl17: TQRLabel
          Left = 131
          Top = 69
          Width = 103
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            346.604166666666700000
            182.562500000000000000
            272.520833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #30005#35805#65306'01234567899'
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl18: TQRLabel
          Left = 284
          Top = 69
          Width = 139
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            751.416666666666800000
            182.562500000000000000
            367.770833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25176#36816#37096#22320#22336#65306#40644#23665#36335'135'#21495
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrlbl19: TQRLabel
          Left = 458
          Top = 46
          Width = 121
          Height = 15
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            39.687500000000000000
            1211.791666666667000000
            121.708333333333300000
            320.145833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25903#20184#26041#24335#65306#25176#36816#37096#20195#25910
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #20223#23435'_GB2312'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qrshp2: TQRShape
          Left = 15
          Top = 1
          Width = 650
          Height = 1
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            2.645833333333333000
            39.687500000000000000
            2.645833333333333000
            1719.791666666667000000)
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrxpr1: TQRExpr
          Left = 360
          Top = 3
          Width = 157
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            952.500000000000000000
            7.937500000000000000
            415.395833333333400000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          ResetAfterPrint = False
          Transparent = False
          WordWrap = True
          Expression = 'SUM(ADOQuery1.fields[7])'
          FontSize = 10
        end
      end
      object qrbndPageFooter1: TQRBand
        Left = 12
        Top = 175
        Width = 884
        Height = 30
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
          79.375000000000000000
          2338.916666666667000000)
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
          Left = 700
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
            1852.083333333333000000
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
          Left = 555
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
            1468.437500000000000000
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
        object qrshp3: TQRShape
          Left = 15
          Top = 4
          Width = 800
          Height = 1
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            2.645833333333333000
            39.687500000000000000
            10.583333333333330000
            2116.666666666667000000)
          Shape = qrsRectangle
          VertAdjust = 0
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
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'MSDASQL.1'
    Left = 8
    Top = 49
  end
  object ADOQuery3: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 8
    Top = 145
  end
  object ADOQuery4: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 8
    Top = 178
  end
end
