object Form1: TForm1
  Left = 294
  Top = 181
  Width = 322
  Height = 118
  Caption = 'Delphi'#20013#30340'INI'#25991#20214#32534#31243
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 12
    Caption = #29992#25143#21517#65306
  end
  object Label2: TLabel
    Left = 144
    Top = 8
    Width = 72
    Height = 12
    Caption = #24050#36816#34892#26102#38388#65306
  end
  object Edit1: TEdit
    Left = 56
    Top = 5
    Width = 81
    Height = 20
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 216
    Top = 5
    Width = 81
    Height = 20
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 40
    Width = 97
    Height = 17
    Caption = #26159#21542#27491#24335#29992#25143
    TabOrder = 2
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 192
    Top = 32
  end
end
