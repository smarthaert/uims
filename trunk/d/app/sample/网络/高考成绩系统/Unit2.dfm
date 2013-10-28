object Form2: TForm2
  Left = 196
  Top = 128
  Width = 455
  Height = 366
  Caption = #29702#31185#25104#32489#24405#20837#31383#20307
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
    Left = 136
    Top = 10
    Width = 152
    Height = 21
    Caption = #29702#31185#32771#35797#25104#32489#24405#20837
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = #21326#25991#20013#23435
    Font.Style = []
    ParentFont = False
  end
  object DBNavigator1: TDBNavigator
    Left = 96
    Top = 105
    Width = 240
    Height = 25
    DataSource = DataSource1
    Flat = True
    TabOrder = 0
  end
  object DBEdit1: TDBEdit
    Left = 9
    Top = 74
    Width = 147
    Height = 20
    DataField = #20934#32771#35777#21495
    DataSource = DataSource1
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 164
    Top = 74
    Width = 148
    Height = 20
    DataField = #23398#29983#22995#21517
    DataSource = DataSource1
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 317
    Top = 74
    Width = 119
    Height = 20
    DataField = #32771#21069#23398#26657
    DataSource = DataSource1
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object DBNavigator2: TDBNavigator
    Left = 104
    Top = 300
    Width = 240
    Height = 25
    DataSource = DataSource2
    Flat = True
    TabOrder = 4
  end
  object StaticText1: TStaticText
    Left = 32
    Top = 51
    Width = 52
    Height = 16
    Caption = #20934#32771#35777#21495
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object StaticText2: TStaticText
    Left = 198
    Top = 51
    Width = 52
    Height = 16
    Caption = #23398#29983#22995#21517
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object StaticText3: TStaticText
    Left = 352
    Top = 51
    Width = 52
    Height = 16
    Caption = #32771#21069#23398#26657
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 160
    Width = 427
    Height = 129
    DataSource = DataSource2
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = #31185#30446#24207#21495
        Title.Alignment = taCenter
        Title.Font.Charset = GB2312_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = #23435#20307
        Title.Font.Style = []
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = #20934#32771#35777#21495
        Title.Alignment = taCenter
        Title.Font.Charset = GB2312_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = #23435#20307
        Title.Font.Style = []
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = #32771#35797#31185#30446
        Title.Alignment = taCenter
        Title.Font.Charset = GB2312_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = #23435#20307
        Title.Font.Style = []
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = #32771#35797#25104#32489
        Title.Alignment = taCenter
        Title.Font.Charset = GB2312_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = #23435#20307
        Title.Font.Style = []
        Visible = True
      end>
  end
  object Table1: TTable
    Active = True
    AutoRefresh = True
    TableName = #29702#31185#20027#34920'.db'
    Left = 328
    Top = 8
    object Table1BDEDesigner: TFloatField
      FieldName = #20934#32771#35777#21495
    end
    object Table1BDEDesigner2: TStringField
      FieldName = #23398#29983#22995#21517
      Size = 18
    end
    object Table1BDEDesigner3: TStringField
      FieldName = #32771#21069#23398#26657
      Size = 28
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 368
    Top = 8
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 376
    Top = 280
  end
  object Table2: TTable
    Active = True
    IndexName = 'kh'
    MasterFields = #20934#32771#35777#21495
    MasterSource = DataSource1
    TableName = #29702#31185#20174#34920'.db'
    Left = 352
    Top = 224
    object Table2BDEDesigner: TFloatField
      DisplayWidth = 9
      FieldName = #31185#30446#24207#21495
    end
    object Table2BDEDesigner2: TFloatField
      DisplayWidth = 18
      FieldName = #20934#32771#35777#21495
    end
    object Table2BDEDesigner3: TStringField
      DisplayWidth = 30
      FieldName = #32771#35797#31185#30446
      Size = 18
    end
    object Table2BDEDesigner4: TFloatField
      DisplayWidth = 16
      FieldName = #32771#35797#25104#32489
    end
  end
end
