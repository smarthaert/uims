object MainForm: TMainForm
  Left = 192
  Top = 119
  Width = 578
  Height = 305
  Caption = 'OLE'#33258#21160#21270#25511#21046#22120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 545
    Height = 225
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BitBtnSave: TBitBtn
    Left = 400
    Top = 240
    Width = 75
    Height = 25
    Caption = #20445#23384#21040'Excel'
    TabOrder = 1
    OnClick = BitBtnSaveClick
  end
  object BitBtnClose: TBitBtn
    Left = 480
    Top = 240
    Width = 75
    Height = 25
    Caption = #20851#38381'Excel'
    TabOrder = 2
    OnClick = BitBtnCloseClick
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 240
    Width = 97
    Height = 17
    Caption = #38544#34255#24212#29992#31243#24207
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 136
    Top = 240
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'customer.db'
    Left = 176
    Top = 240
  end
end
