object Form1: TForm1
  Left = 223
  Top = 138
  Width = 428
  Height = 244
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
    Left = 8
    Top = 8
    Width = 401
    Height = 153
    TabOrder = 6
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 385
      Height = 137
    end
    object Edit3: TEdit
      Left = 112
      Top = 48
      Width = 225
      Height = 21
      TabOrder = 0
    end
    object Edit4: TEdit
      Left = 112
      Top = 80
      Width = 225
      Height = 21
      TabOrder = 1
    end
    object StaticText3: TStaticText
      Left = 56
      Top = 48
      Width = 40
      Height = 17
      Caption = '用户名'
      TabOrder = 2
    end
    object StaticText4: TStaticText
      Left = 64
      Top = 80
      Width = 28
      Height = 17
      Caption = '密码'
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 112
    Top = 176
    Width = 75
    Height = 25
    Caption = '映射'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 120
    Top = 24
    Width = 225
    Height = 21
    TabOrder = 1
    Text = '\\clear\others'
  end
  object Edit2: TEdit
    Left = 120
    Top = 112
    Width = 225
    Height = 21
    TabOrder = 2
    Text = 'Z:'
  end
  object StaticText1: TStaticText
    Left = 56
    Top = 24
    Width = 52
    Height = 17
    Caption = '远程资源'
    TabOrder = 3
  end
  object StaticText2: TStaticText
    Left = 40
    Top = 120
    Width = 64
    Height = 17
    Caption = '本地驱动器'
    TabOrder = 4
  end
  object Button2: TButton
    Left = 232
    Top = 176
    Width = 75
    Height = 25
    Caption = '断开映射'
    TabOrder = 5
    OnClick = Button2Click
  end
end
