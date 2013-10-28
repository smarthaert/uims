object Form1: TForm1
  Left = 448
  Top = 97
  Width = 482
  Height = 365
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
  object lbl1: TLabel
    Left = 8
    Top = 64
    Width = 57
    Height = 13
    Caption = #32593#39029#22320#22336':  '
  end
  object lbl2: TLabel
    Left = 8
    Top = 88
    Width = 57
    Height = 13
    Caption = #32593#39029#26631#39064':  '
  end
  object lbl3: TLabel
    Left = 8
    Top = 112
    Width = 57
    Height = 13
    Caption = #20803#32032#31867#22411':  '
  end
  object lbl4: TLabel
    Left = 264
    Top = 112
    Width = 44
    Height = 13
    Caption = #20803#32032'ID:  '
  end
  object lbl5: TLabel
    Left = 8
    Top = 136
    Width = 57
    Height = 13
    Caption = #20803#32032#22806#26694':  '
  end
  object lbl6: TLabel
    Left = 8
    Top = 160
    Width = 57
    Height = 13
    Caption = #31383#21475#21477#26564':  '
  end
  object lbl7: TLabel
    Left = 264
    Top = 160
    Width = 63
    Height = 13
    Caption = #25509#21475'2'#21477#26564':  '
  end
  object lbl8: TLabel
    Left = 8
    Top = 184
    Width = 57
    Height = 13
    Caption = #25991#26412#20869#23481':  '
  end
  object lbl9: TLabel
    Left = 8
    Top = 208
    Width = 63
    Height = 13
    Caption = 'HTML'#20869#23481':  '
  end
  object lbl10: TLabel
    Left = 8
    Top = 40
    Width = 45
    Height = 13
    Caption = #31867#21517#31216':  '
  end
  object btn2: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Caption = #24320#22987#33719#21462
    TabOrder = 0
    OnClick = btn2Click
  end
  object edt_url: TEdit
    Left = 64
    Top = 58
    Width = 393
    Height = 21
    TabOrder = 1
  end
  object edt_formtext: TEdit
    Left = 64
    Top = 82
    Width = 393
    Height = 21
    TabOrder = 2
  end
  object edt_tagname: TEdit
    Left = 64
    Top = 106
    Width = 137
    Height = 21
    TabOrder = 3
  end
  object edt_elemID: TEdit
    Left = 320
    Top = 106
    Width = 137
    Height = 21
    TabOrder = 4
  end
  object edt_rect: TEdit
    Left = 64
    Top = 130
    Width = 393
    Height = 21
    TabOrder = 5
  end
  object edt_formhandle: TEdit
    Left = 64
    Top = 154
    Width = 137
    Height = 21
    TabOrder = 6
  end
  object edt_ihtmldcoument2: TEdit
    Left = 320
    Top = 154
    Width = 137
    Height = 21
    TabOrder = 7
  end
  object edt_elemtext: TEdit
    Left = 64
    Top = 178
    Width = 393
    Height = 21
    TabOrder = 8
  end
  object mmo1: TMemo
    Left = 72
    Top = 208
    Width = 385
    Height = 113
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object edt_winClass: TEdit
    Left = 64
    Top = 34
    Width = 393
    Height = 21
    TabOrder = 10
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmr1Timer
    Top = 8
  end
end
