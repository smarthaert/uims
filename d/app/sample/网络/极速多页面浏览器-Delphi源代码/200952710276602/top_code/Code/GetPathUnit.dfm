object GetPathForm: TGetPathForm
  Left = 483
  Top = 223
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #36873#25321#30446#24405
  ClientHeight = 216
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LPath: TLabel
    Left = 40
    Top = 144
    Width = 3
    Height = 13
    Visible = False
  end
  object BOK: TButton
    Left = 88
    Top = 176
    Width = 75
    Height = 33
    Caption = #30830#23450
    TabOrder = 0
    OnClick = BOKClick
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 8
    Width = 233
    Height = 137
    ItemHeight = 16
    TabOrder = 1
    OnDblClick = DirectoryListBox1DblClick
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 152
    Width = 233
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 2
  end
  object ButtonCancel: TButton
    Left = 167
    Top = 175
    Width = 75
    Height = 33
    Caption = #21462#28040
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
end
