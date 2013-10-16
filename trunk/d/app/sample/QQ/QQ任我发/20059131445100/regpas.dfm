object regform: Tregform
  Left = 246
  Top = 169
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #36755#20837#27880#20876#30721#65306
  ClientHeight = 236
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object lbl2: TLabel
    Left = 9
    Top = 178
    Width = 282
    Height = 12
    Caption = #27880#20876#30721#65306'    -----------------------------------'
  end
  object bvl1: TBevel
    Left = 8
    Top = 200
    Width = 289
    Height = 3
    Shape = bsTopLine
  end
  object lbl1: TLabel
    Left = 8
    Top = 208
    Width = 66
    Height = 12
    Caption = #31561#24453#27880#20876'...'
  end
  object edit2: TEdit
    Left = 69
    Top = 173
    Width = 53
    Height = 20
    MaxLength = 6
    TabOrder = 0
  end
  object btn1: TButton
    Left = 144
    Top = 208
    Width = 75
    Height = 25
    Caption = #23436#25104#27880#20876
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 224
    Top = 208
    Width = 75
    Height = 25
    Caption = #21462#28040#27880#20876
    TabOrder = 2
    OnClick = btn2Click
  end
  object edit3: TEdit
    Left = 127
    Top = 173
    Width = 53
    Height = 20
    MaxLength = 6
    TabOrder = 3
  end
  object edit5: TEdit
    Left = 186
    Top = 173
    Width = 53
    Height = 20
    MaxLength = 6
    TabOrder = 4
  end
  object edit6: TEdit
    Left = 245
    Top = 173
    Width = 53
    Height = 20
    MaxLength = 6
    TabOrder = 5
  end
  object mmo1: TMemo
    Left = 8
    Top = 8
    Width = 290
    Height = 161
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Lines.Strings = (
      #12288#9679#24863#35874#24744#35797#29992'QQ'#20219#25105#21457#65292#23427#19981#26159#19968#20010#20813#36153#36719#20214#65292
      #26410#27880#20876#29256#26412#21482#33021#36830#32493#21457#36865'30'#26465#20449#24687#65292#27880#20876#21518#21487#35299#38500
      #38480#21046#65292#22914#26524#24744#24471#21040#20102#27880#20876#30721#65292#35831#22312#19979#38754#36755#20837#24182#28857#20987
      #8220#23436#25104#27880#20876#8221#25353#38062#65292#35874#35874#65281
      ''
      #12288#9679#27880#20876#36153#65306'98'#20803#20154#27665#24065'/'#22871
      ''
      #12288#9679#35831#27719#27454#33267#65306
      #12288#12288'A'#12288#20013#22269#38134#34892#65306
      #12288#12288#12288#12288#25143#12288#21517#65306#24352#12288#23431
      #12288#12288#12288#12288#36134#12288#21495#65306'413466020118909'
      '        '#24320#25143#34892#65306#23665#19996#20020#27778#20998#34892#20020#27821#25903#34892
      '    B  '#24314#35774#38134#34892#65306
      #12288#12288#12288#12288#25143#12288#21517#65306#24352#12288#23431
      #12288#12288#12288#12288#24080#12288#21495#65306'2297519980130005728'
      #12288#12288#12288#12288#24320#25143#34892#65306#20013#22269#24314#35774#38134#34892#23665#19996#30465#20998#34892
      #12288#12288'C'#12288#20892#19994#38134#34892#65306
      #12288#12288#12288#12288#25143#12288#21517#65306#24352#12288#23431
      #12288#12288#12288#12288#24080#12288#21495#65306'15-898101100197293'
      #12288#12288#12288#12288#24320#25143#34892#65306#20013#22269#20892#34892#23665#19996#20020#27821#25903#34892)
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
end
