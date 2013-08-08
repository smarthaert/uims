object Form1: TForm1
  Left = 164
  Top = 117
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 433
    Top = 0
    Width = 8
    Height = 348
    Cursor = crHSplit
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 433
    Height = 348
    Align = alLeft
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object GroupBox1: TGroupBox
    Left = 441
    Top = 0
    Width = 95
    Height = 348
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 48
      Height = 12
      Caption = #27599#39029#25171#21360
    end
    object Label2: TLabel
      Left = 72
      Top = 43
      Width = 12
      Height = 12
      Caption = #26465
    end
    object Button1: TButton
      Left = 8
      Top = 72
      Width = 75
      Height = 25
      Caption = #25171#21360#39044#35272
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 8
      Top = 40
      Width = 45
      Height = 20
      ReadOnly = True
      TabOrder = 1
      Text = '10'
    end
    object UpDown1: TUpDown
      Left = 53
      Top = 40
      Width = 15
      Height = 20
      Associate = Edit1
      Min = 1
      Position = 10
      TabOrder = 2
      Wrap = False
    end
    object Button2: TButton
      Left = 8
      Top = 272
      Width = 75
      Height = 25
      Caption = #20851#38381
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 24
    Top = 24
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'custoly.db'
    Left = 88
    Top = 24
  end
end
