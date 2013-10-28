object Form6: TForm6
  Left = 294
  Top = 705
  Width = 734
  Height = 259
  Caption = #25171#21360#20301#32622#24494#35843
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
    Left = 112
    Top = 56
    Width = 385
    Height = 17
    AutoSize = False
    Caption = #25171#21360#31532#19968#39029#31532'1'#34892#20043#21069', '#25171#21360#26426#36208#32440#38271#24230#30456#23545#40664#35748#36208#32440#38271#24230', '#22686#21152
  end
  object Label1: TLabel
    Left = 72
    Top = 104
    Width = 49
    Height = 25
    AutoSize = False
    Caption = #27599#25171#21360
  end
  object Label3: TLabel
    Left = 580
    Top = 56
    Width = 73
    Height = 17
    AutoSize = False
    Caption = #27627#31859
  end
  object Label4: TLabel
    Left = 580
    Top = 104
    Width = 73
    Height = 17
    AutoSize = False
    Caption = #27627#31859
  end
  object Label5: TLabel
    Left = 200
    Top = 104
    Width = 281
    Height = 25
    AutoSize = False
    Caption = #39029#21518', '#25171#21360#26426#36208#32440#38271#24230#30456#23545#40664#35748#36208#32440#38271#24230', '#22686#21152
  end
  object Button1: TButton
    Left = 440
    Top = 168
    Width = 105
    Height = 25
    Caption = #24674#22797#40664#35748#35774#32622
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 456
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object Button2: TButton
    Left = 208
    Top = 168
    Width = 83
    Height = 25
    Caption = #30830#23450#20462#25913
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 456
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Button3: TButton
    Left = 320
    Top = 168
    Width = 97
    Height = 25
    Caption = #20851#38381#30028#38754
    TabOrder = 4
    OnClick = Button3Click
  end
  object ComboBox1: TComboBox
    Left = 120
    Top = 104
    Width = 73
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    Text = '1'
    Items.Strings = (
      '1'
      '10'
      '20'
      '50'
      '100'
      '')
  end
end
