object Form5: TForm5
  Left = 144
  Top = 98
  Width = 450
  Height = 352
  Caption = #25991#31185#26597#35810#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 264
    Top = 53
    Width = 106
    Height = 22
    Caption = #25191#34892#26597#35810
    Flat = True
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 16
    Top = 256
    Width = 36
    Height = 12
    Caption = #24635#25104#32489
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 288
    Width = 48
    Height = 12
    Caption = #24179#22343#25104#32489
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object StaticText1: TStaticText
    Left = 126
    Top = 13
    Width = 194
    Height = 25
    Caption = #39640#32771#25991#31185#25104#32489#26597#35810#31995#32479
    Font.Charset = GB2312_CHARSET
    Font.Color = clFuchsia
    Font.Height = -19
    Font.Name = #21326#25991#20013#23435
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object StaticText2: TStaticText
    Left = 8
    Top = 56
    Width = 88
    Height = 16
    Caption = #35831#36755#20837#32771#29983#32771#21495
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 104
    Top = 53
    Width = 121
    Height = 20
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 88
    Width = 417
    Height = 153
    DataSource = DataSource1
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
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
        Width = 139
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
  object Edit2: TEdit
    Left = 88
    Top = 251
    Width = 121
    Height = 20
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 88
    Top = 288
    Width = 121
    Height = 20
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'Edit3'
  end
  object Memo1: TMemo
    Left = 24
    Top = 144
    Width = 385
    Height = 57
    Lines.Strings = (
      'Memo1')
    TabOrder = 6
    Visible = False
  end
  object Table1: TTable
    Active = True
    TableName = #25991#31185#20174#34920'.db'
    Left = 392
    Top = 40
    object Table1BDEDesigner: TFloatField
      FieldName = #31185#30446#24207#21495
    end
    object Table1BDEDesigner2: TFloatField
      FieldName = #20934#32771#35777#21495
    end
    object Table1BDEDesigner3: TStringField
      FieldName = #32771#35797#31185#30446
      Size = 18
    end
    object Table1BDEDesigner4: TFloatField
      FieldName = #32771#35797#25104#32489
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 392
    Top = 88
  end
end
