object Form1: TForm1
  Left = 324
  Top = 163
  Caption = 'Wifi Scanner'
  ClientHeight = 384
  ClientWidth = 554
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
  object ListView1: TListView
    Left = 0
    Top = 89
    Width = 554
    Height = 295
    Align = alClient
    Columns = <
      item
        Caption = 'Network Name'
        Width = 200
      end
      item
        Caption = 'Signal Quality'
        Width = 100
      end
      item
        Caption = 'Algorithm (1)'
        Width = 100
      end
      item
        Caption = 'Algorithm (2)'
        Width = 100
      end>
    GridLines = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 89
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 17
      Top = 51
      Width = 43
      Height = 13
      Caption = 'Adapter :'
    end
    object Label2: TLabel
      Left = 17
      Top = 11
      Width = 33
      Height = 13
      Caption = 'GUID :'
    end
    object ComboBox1: TComboBox
      Left = 66
      Top = 48
      Width = 479
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 66
      Top = 8
      Width = 479
      Height = 21
      TabOrder = 1
      Text = 'Edit1'
    end
  end
end
