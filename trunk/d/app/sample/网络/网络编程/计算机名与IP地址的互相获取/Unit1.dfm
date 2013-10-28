object Form1: TForm1
  Left = 328
  Top = 344
  Width = 435
  Height = 294
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 267
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 177
      Height = 249
      Caption = #35745#31639#26426#21517'->IP'#22320#22336
      TabOrder = 0
      object Edit1: TEdit
        Left = 16
        Top = 48
        Width = 145
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object Button1: TButton
        Left = 46
        Top = 84
        Width = 75
        Height = 25
        Caption = #33719#21462'IP'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Edit2: TEdit
        Left = 16
        Top = 144
        Width = 145
        Height = 21
        TabOrder = 2
        Text = 'Edit2'
      end
      object StaticText1: TStaticText
        Left = 16
        Top = 24
        Width = 52
        Height = 17
        Caption = #35745#31639#26426#21517
        TabOrder = 3
      end
      object StaticText2: TStaticText
        Left = 16
        Top = 120
        Width = 38
        Height = 17
        Caption = 'IP'#22320#22336
        TabOrder = 4
      end
    end
    object GroupBox2: TGroupBox
      Left = 200
      Top = 7
      Width = 217
      Height = 250
      Caption = 'IP'#22320#22336'->'#35745#31639#26426#21517
      TabOrder = 1
      object Edit3: TEdit
        Left = 24
        Top = 48
        Width = 185
        Height = 21
        TabOrder = 0
        Text = 'Edit3'
      end
      object Button2: TButton
        Left = 62
        Top = 84
        Width = 91
        Height = 25
        Caption = #33719#21462#35745#31639#26426#21517
        TabOrder = 1
        OnClick = Button2Click
      end
      object Memo1: TMemo
        Left = 8
        Top = 144
        Width = 201
        Height = 97
        Lines.Strings = (
          'Memo1')
        TabOrder = 2
      end
      object StaticText3: TStaticText
        Left = 16
        Top = 24
        Width = 38
        Height = 17
        Caption = 'IP'#22320#22336
        TabOrder = 3
      end
      object StaticText4: TStaticText
        Left = 16
        Top = 120
        Width = 52
        Height = 17
        Caption = #35745#31639#26426#21517
        TabOrder = 4
      end
    end
  end
end
