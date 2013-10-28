object FrmDirPath: TFrmDirPath
  Left = 430
  Top = 279
  BorderStyle = bsDialog
  Caption = #25991#20214#36335#24452
  ClientHeight = 210
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 32
    Width = 177
    Height = 137
    ItemHeight = 16
    TabOrder = 0
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 8
    Width = 177
    Height = 19
    TabOrder = 1
    OnChange = DriveComboBox1Change
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 176
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 120
    Top = 176
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    Kind = bkCancel
  end
end
