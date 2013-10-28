object Form1: TForm1
  Left = 211
  Top = 182
  Width = 634
  Height = 262
  Caption = 'Form1'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 626
    Height = 235
    Align = alClient
    TabOrder = 3
    object ListBox1: TListBox
      Left = 16
      Top = 32
      Width = 289
      Height = 153
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = ListBox1DblClick
    end
    object StaticText2: TStaticText
      Left = 312
      Top = 12
      Width = 196
      Height = 17
      Caption = #21452#20987#24038#36793#35745#31639#26426#21517#20197#33719#21462#20854#20849#20139#36164#28304
      TabOrder = 1
    end
    object Memo1: TMemo
      Left = 312
      Top = 32
      Width = 297
      Height = 153
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 128
    Top = 200
    Width = 57
    Height = 25
    Caption = 'Go'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 128
    Top = 8
    Width = 177
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 8
    Width = 88
    Height = 17
    Caption = #35831#36755#20837#24037#20316#32452#21517
    TabOrder = 2
  end
end
