object Form1: TForm1
  Left = 290
  Top = 206
  BorderStyle = bsSingle
  Caption = #26001#39532#26426#25171#21360#27979#35797
  ClientHeight = 295
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 24
    Height = 12
    Caption = #26465#30721
  end
  object Label2: TLabel
    Left = 8
    Top = 44
    Width = 24
    Height = 12
    Caption = #30721#21046
  end
  object Label3: TLabel
    Left = 168
    Top = 16
    Width = 24
    Height = 12
    Caption = #25991#23383
  end
  object Label4: TLabel
    Left = 168
    Top = 44
    Width = 24
    Height = 12
    Caption = #23383#20307
  end
  object Label5: TLabel
    Left = 8
    Top = 72
    Width = 24
    Height = 12
    Caption = #25351#20196
  end
  object Edit1: TEdit
    Left = 46
    Top = 12
    Width = 107
    Height = 20
    TabOrder = 0
    Text = '6924452318664'
  end
  object cbx1: TComboBox
    Left = 46
    Top = 40
    Width = 107
    Height = 20
    AutoComplete = False
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 1
    TabOrder = 1
    Text = 'Code 39'
    Items.Strings = (
      'Code 11'
      'Code 39'
      'Code 49'
      'Code 93'
      'Code 128'
      'EAN-8')
  end
  object Edit2: TEdit
    Left = 206
    Top = 12
    Width = 107
    Height = 20
    TabOrder = 2
    Text = #24471#21147#20339#32440#21697'SP-1866'
  end
  object cbx2: TComboBox
    Left = 206
    Top = 40
    Width = 107
    Height = 20
    AutoComplete = False
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 3
    Text = #23435#20307
    Items.Strings = (
      #23435#20307
      #38582#20070
      #21326#25991#34892#26999)
  end
  object Memo1: TMemo
    Left = 46
    Top = 68
    Width = 267
    Height = 89
    Lines.Strings = (
      '')
    TabOrder = 4
  end
  object Button1: TButton
    Left = 328
    Top = 12
    Width = 75
    Height = 25
    Caption = #29983#25104#25351#20196
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 328
    Top = 68
    Width = 75
    Height = 25
    Caption = #25171#21360
    TabOrder = 6
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 24
    Top = 164
    Width = 421
    Height = 125
    BevelInner = bvSpace
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clMenu
    Lines.Strings = (
      #21033#29992' ZPL II '#25511#21046#21629#20196#25171#21360#26465#24418#30721#30340#20363#23376
      #21487#20197#25171#21360#20013#33521#25991','#25968#23383','#26465#30721
      
        '----------------------------------------------------------------' +
        '--'
      #35828#26126':'#25105#22312#20889#36825#20010#31243#24207#30340#26102#20505#25163#22836#19978#24050#32463#27809#26377#26001#39532#26426#20102','#20165#26681#25454#20197#21069#29992'PB'#26102#30340
      #19968#20123#27169#31946#35760#24518#26469#20889','#25152#20197#25171#21360#25351#20196#38169#35823#26159#22312#25152#38590#20813#30340','#35831#21442#29031' ZPL II '#21442#32771#25163#20876
      #33258#34892#20462#25913'.'#20363#31243#37324#38754#21253#25324#20102'Fnthex32.dll'#30340#29992#27861',Fnthex32.dll'#20013#23553#35013#20102#26001#39532#26426
      #25171#21360#20013#19996#22320#21306#23383#31526#30340#20989#25968'GETFONTHEX.'
      
        '----------------------------------------------------------------' +
        '--'
      #22914#26524#24744#21457#29616#24182#20462#25913#20102#26412#31243#24207#30340#38169#35823','#35831#21153#24517#21457#32473#23567#24351#19968#20221','#22312#27492#20808#35874#36807#20102'!!'
      'Mail:zzy9903@163.com')
    TabOrder = 7
  end
end
