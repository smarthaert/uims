object FrmSetupTime: TFrmSetupTime
  Left = 462
  Top = 111
  BorderStyle = bsDialog
  Caption = #23450#26102#35774#32622
  ClientHeight = 157
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 331
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 14
    Top = 2
    Width = 48
    Height = 13
    Caption = #23450#26102#26041#24335
  end
  object Bevel2: TBevel
    Left = 7
    Top = 64
    Width = 331
    Height = 9
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 14
    Top = 58
    Width = 48
    Height = 13
    Caption = #26102#38388#35774#32622
    Transparent = False
  end
  object Label3: TLabel
    Left = 12
    Top = 88
    Width = 24
    Height = 13
    Caption = #26143#26399
  end
  object Label4: TLabel
    Left = 119
    Top = 88
    Width = 24
    Height = 13
    Caption = #26085#26399
  end
  object Label5: TLabel
    Left = 220
    Top = 88
    Width = 24
    Height = 13
    Caption = #26102#38388
  end
  object Label6: TLabel
    Left = 292
    Top = 88
    Width = 3
    Height = 13
    Caption = ':'
  end
  object RBtnNone: TRadioButton
    Left = 14
    Top = 24
    Width = 57
    Height = 17
    Caption = #19981#22791#20221
    TabOrder = 0
    OnClick = RBtnNoneClick
  end
  object RBtnEveryTime: TRadioButton
    Left = 78
    Top = 24
    Width = 57
    Height = 17
    Caption = #27599#23567#26102
    TabOrder = 1
    OnClick = RBtnEveryTimeClick
  end
  object RBtnEveryDay: TRadioButton
    Left = 142
    Top = 24
    Width = 57
    Height = 17
    Caption = #27599#22825
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = RBtnEveryDayClick
  end
  object RBtnEveryWeek: TRadioButton
    Left = 206
    Top = 24
    Width = 57
    Height = 17
    Caption = #27599#21608
    TabOrder = 3
    OnClick = RBtnEveryWeekClick
  end
  object RBtnEveryMonth: TRadioButton
    Left = 270
    Top = 24
    Width = 57
    Height = 17
    Caption = #27599#26376
    TabOrder = 4
    OnClick = RBtnEveryMonthClick
  end
  object CmbWeek: TComboBox
    Left = 40
    Top = 84
    Width = 74
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = #26143#26399#26085
    Items.Strings = (
      #26143#26399#26085
      #26143#26399#19968
      #26143#26399#20108
      #26143#26399#19977
      #26143#26399#22235
      #26143#26399#20116
      #26143#26399#20845)
  end
  object EdtDay: TSpinEdit
    Left = 148
    Top = 83
    Width = 65
    Height = 22
    MaxValue = 31
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object EdtTime: TSpinEdit
    Left = 244
    Top = 83
    Width = 46
    Height = 22
    MaxValue = 23
    MinValue = 0
    TabOrder = 7
    Value = 0
  end
  object EdtMinute: TSpinEdit
    Left = 299
    Top = 83
    Width = 46
    Height = 22
    MaxValue = 59
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object BitBtn1: TBitBtn
    Left = 184
    Top = 120
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    TabOrder = 9
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 264
    Top = 120
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    TabOrder = 10
    OnClick = BitBtn2Click
  end
end
