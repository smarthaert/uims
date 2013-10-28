object Form1: TForm1
  Left = 342
  Top = 338
  Width = 322
  Height = 144
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label3: TLabel
    Left = 16
    Top = 16
    Width = 60
    Height = 12
    Caption = #32593#32476#22320#22336#65306
  end
  object Button1: TButton
    Left = 216
    Top = 8
    Width = 81
    Height = 25
    Caption = #33719#21462#26102#38388'(&G)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 40
    Width = 81
    Height = 25
    Caption = #26657#23545#26102#38388'(&A)'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 16
    Top = 40
    Width = 185
    Height = 65
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 60
      Height = 12
      Caption = #31995#32479#26102#38388#65306
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 60
      Height = 12
      Caption = #32593#32476#26102#38388#65306
    end
  end
  object Button3: TButton
    Left = 216
    Top = 80
    Width = 81
    Height = 25
    Caption = #36864#20986#31243#24207'(&X)'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 80
    Top = 8
    Width = 121
    Height = 20
    TabOrder = 4
    Text = 'clock.psu.edu'
  end
  object IdTime1: TIdTime
    MaxLineAction = maException
    ReadTimeout = 0
    BaseDate = 2.000000000000000000
    Left = 112
    Top = 80
  end
end
