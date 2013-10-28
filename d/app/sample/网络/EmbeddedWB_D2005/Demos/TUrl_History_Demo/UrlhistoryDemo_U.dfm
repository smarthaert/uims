object Form1: TForm1
  Left = 192
  Top = 107
  Width = 740
  Height = 480
  Caption = 'TUrlHistory Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 480
    Top = 397
    Width = 25
    Height = 13
    Caption = 'Filter:'
  end
  object Label2: TLabel
    Left = 232
    Top = 376
    Width = 36
    Height = 13
    Caption = 'Sort by:'
  end
  object StringGrid1: TStringGrid
    Left = 10
    Top = 16
    Width = 710
    Height = 353
    DefaultColWidth = 75
    DefaultRowHeight = 16
    FixedCols = 0
    TabOrder = 0
    ColWidths = (
      75
      234
      222
      75
      75)
  end
  object Button1: TButton
    Left = 72
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Enumerate'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 520
    Top = 392
    Width = 97
    Height = 21
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 234
    Top = 426
    Width = 137
    Height = 16
    Caption = 'Only sites visited today'
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 232
    Top = 392
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = 'Last vistited'
    Items.Strings = (
      'Last visted'
      'Title'
      'Url'
      'Last updated'
      'Expires')
  end
  object UrlHistory1: TUrlHistory
    OnAccept = UrlHistory1Accept
    SortField = sfLastVisited
    SearchField = seBoth
    SortDirection = sdAscending
    Left = 24
    Top = 400
  end
end
