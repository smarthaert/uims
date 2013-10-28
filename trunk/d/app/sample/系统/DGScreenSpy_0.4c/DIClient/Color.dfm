object frmColor: TfrmColor
  Left = 300
  Top = 146
  BorderStyle = bsDialog
  Caption = 'Select Color'
  ClientHeight = 123
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object rg1: TRadioGroup
    Left = 8
    Top = 8
    Width = 275
    Height = 65
    Caption = 'Color'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      '1 bit'
      '4 bit'
      '8 bit'
      '16 bit'
      '24 bit'
      '32 bit')
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 49
    Top = 85
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 169
    Top = 85
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
