object canshu: Tcanshu
  Left = 224
  Top = 138
  BorderStyle = bsDialog
  Caption = #36816#34892#21442#25968#35774#32622
  ClientHeight = 104
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #36816#34892#21442#25968#65306
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #36816#34892#26041#24335#65306
  end
  object Edit1: TEdit
    Left = 80
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 80
    Top = 32
    Width = 121
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    Text = #27491#24120#26041#24335
    Items.Strings = (
      #38544#34255#31383#21475
      #27491#24120#26041#24335
      #26368#22823#21270
      #26368#23567#21270)
  end
  object Button1: TButton
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 64
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = Button2Click
  end
end
