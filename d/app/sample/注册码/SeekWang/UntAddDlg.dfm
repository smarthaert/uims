object FrmAddDlg: TFrmAddDlg
  Left = 553
  Top = 279
  BorderStyle = bsDialog
  Caption = #26032#22686
  ClientHeight = 84
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 16
    Width = 90
    Height = 16
    Caption = #26106#26106#29992#25143#21517#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EdtName: TEdit
    Left = 94
    Top = 11
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object BtnAdd: TButton
    Left = 23
    Top = 44
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    TabOrder = 1
    OnClick = BtnAddClick
  end
  object BtnCancel: TButton
    Left = 124
    Top = 44
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    TabOrder = 2
    OnClick = BtnCancelClick
  end
end
