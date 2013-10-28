object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'CMD'
  ClientHeight = 216
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 410
    Height = 177
    Lines.Strings = (
      '$(window.frames["main"].document).find(".enter_enw")')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 111
    Top = 183
    Width = 75
    Height = 25
    Caption = #25191#34892#33050#26412
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 216
    Top = 191
    Width = 185
    Height = 17
    Caption = #22312'Frame'#30340#39029#38754#20013#25191#34892
    TabOrder = 2
  end
end
