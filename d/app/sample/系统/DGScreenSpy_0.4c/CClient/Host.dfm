object frmHost: TfrmHost
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Enter Host'
  ClientHeight = 163
  ClientWidth = 237
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
  object lbl1: TLabel
    Left = 8
    Top = 11
    Width = 25
    Height = 13
    Caption = 'Host:'
  end
  object lbl2: TLabel
    Left = 8
    Top = 34
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object edtHost: TEdit
    Left = 38
    Top = 8
    Width = 190
    Height = 19
    Ctl3D = False
    MaxLength = 50
    ParentCtl3D = False
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object edtPort: TEdit
    Left = 38
    Top = 31
    Width = 190
    Height = 19
    Ctl3D = False
    MaxLength = 5
    ParentCtl3D = False
    TabOrder = 1
    Text = '9000'
  end
  object rg1: TRadioGroup
    Left = 8
    Top = 54
    Width = 220
    Height = 57
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
    TabOrder = 2
  end
  object btnOk: TButton
    Left = 35
    Top = 125
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 131
    Top = 125
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
