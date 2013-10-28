object Form5: TForm5
  Left = 469
  Top = 705
  Width = 376
  Height = 200
  Caption = #25171#21360#31471#21475#35774#32622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 256
    Top = 48
    Width = 3
    Height = 13
  end
  object Label4: TLabel
    Left = 40
    Top = 56
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #25171#21360#31471#21475#21517':'
  end
  object Button2: TButton
    Left = 56
    Top = 88
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 184
    Top = 88
    Width = 75
    Height = 25
    Caption = #20851#38381#30028#38754
    TabOrder = 1
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 112
    Top = 56
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'lpt1'
      'lpt2'
      'lpt3')
  end
end
