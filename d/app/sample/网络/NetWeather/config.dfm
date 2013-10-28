object Form2: TForm2
  Left = 387
  Top = 222
  BorderStyle = bsDialog
  Caption = #35774#32622
  ClientHeight = 157
  ClientWidth = 306
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
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 39
    Height = 13
    Caption = #22320#21306#65306
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 71
    Width = 40
    Height = 13
    Caption = #27599#38548'  '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 144
    Top = 71
    Width = 169
    Height = 13
    Caption = #20998#38047#21047#26032#19968#27425'             '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 48
    Top = 120
    Width = 81
    Height = 25
    Caption = #37325#32622
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 168
    Top = 120
    Width = 73
    Height = 25
    Caption = #30830#23450
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton2Click
  end
  object Edit3: TEdit
    Left = 64
    Top = 63
    Width = 65
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 64
    Top = 16
    Width = 105
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    Text = #30465#20221
    OnChange = ComboBox1Change
    Items.Strings = (
      #23433#24509
      #21271#20140
      #37325#24198
      #31119#24314
      #29976#32899
      #24191#19996
      #24191#35199
      #36149#24030
      #28023#21335
      #27827#21271
      #40657#40857#27743
      #27827#21335
      #39321#28207
      #28246#21271
      #28246#21335
      #20869#33945#21476
      #27743#33487
      #27743#35199
      #21513#26519
      #36797#23425
      #28595#38376
      #23425#22799
      #38738#28023
      #38485#35199
      #23665#19996
      #19978#28023
      #23665#35199
      #22235#24029
      #22825#27941
      #35199#34255
      #26032#30086
      #20113#21335
      #27993#27743
      #33521#22269
      #27861#22269
      #29233#23572#20848
      #21152#25343#22823
      #32654#22269
      #28595#22823#21033#20122
      #26032#35199#20848)
  end
  object ComboBox2: TComboBox
    Left = 184
    Top = 16
    Width = 97
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 2
    Text = #22478#24066
  end
  object WinSkinForm1: TWinSkinForm
    DisableTag = 99
    SkinControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcCheckBox, xcRadioButton, xcProgress, xcScrollbar, xcEdit, xcButton, xcBitBtn, xcSpeedButton, xcPanel, xcGroupBox, xcStatusBar, xcTab]
    Left = 176
    Top = 88
  end
  object XPMenu1: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = GB2312_CHARSET
    Font.Color = clMenuText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Pitch = fpVariable
    Font.Style = []
    Color = 14674159
    IconBackColor = 14674159
    MenuBarColor = 14674159
    SelectColor = 16737894
    SelectBorderColor = 16723759
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 0
    DrawSelect = True
    UseSystemColors = False
    OverrideOwnerDraw = False
    Gradient = True
    FlatMenu = True
    AutoDetect = True
    Active = True
    Left = 213
    Top = 88
  end
end
