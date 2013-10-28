object Form1: TForm1
  Left = 269
  Top = 157
  Width = 696
  Height = 480
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
  object Label1: TLabel
    Left = 32
    Top = 104
    Width = 78
    Height = 13
    Caption = #21457#36865#25163#26426#21495'      '
  end
  object Label2: TLabel
    Left = 32
    Top = 136
    Width = 78
    Height = 13
    Caption = #30446#26631#25163#26426#21495'      '
  end
  object Label3: TLabel
    Left = 40
    Top = 168
    Width = 123
    Height = 13
    Caption = #30701#20449#20869#23481'                         '
  end
  object Label4: TLabel
    Left = 240
    Top = 128
    Width = 81
    Height = 13
    Caption = #36153#29575#21495'               '
  end
  object Button1: TButton
    Left = 224
    Top = 32
    Width = 75
    Height = 25
    Caption = #21457#36865
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 104
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 104
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 40
    Top = 192
    Width = 545
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 296
    Top = 126
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '103901'
  end
  object Edit4: TEdit
    Left = 440
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '9160331'
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\TestAccessDB.mdb;' +
      'Persist Security Info=False'
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 56
    Top = 56
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 88
    Top = 56
  end
end
