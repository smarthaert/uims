object Form1: TForm1
  Left = 230
  Top = 237
  BorderStyle = bsSingle
  Caption = #33258#21160#21270#25511#21046#22120#28436#31034
  ClientHeight = 271
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 498
    Height = 65
    Align = alTop
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 100
      Height = 13
      Caption = #35831#36755#20837#20844#21496#21517#31216'(&C):'
      FocusControl = Edit1
    end
    object InsertBtn: TButton
      Left = 384
      Top = 32
      Width = 97
      Height = 25
      Caption = #25554#20837#26597#35810#32467#26524
      Default = True
      TabOrder = 0
      OnClick = InsertBtnClick
    end
    object Edit1: TEdit
      Left = 136
      Top = 30
      Width = 225
      Height = 21
      TabOrder = 1
      Text = 'Unisco'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 72
    Width = 497
    Height = 193
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 8
      Top = 8
      Width = 481
      Height = 177
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Company'
          Title.Alignment = taCenter
          Title.Caption = #20844#21496#21517#31216
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderNo'
          Title.Alignment = taCenter
          Title.Caption = #35746#21333#20195#30721
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SaleDate'
          Title.Alignment = taCenter
          Title.Caption = #38144#21806#26085#26399
          Visible = True
        end>
    end
  end
  object Query1: TQuery
    DatabaseName = 'DBDEMOS'
    SQL.Strings = (
      'select Customer.Company, Orders.OrderNo, Orders.SaleDate '
      '  from Customer, Orders'
      '  where Customer.CustNo = Orders.CustNo'
      '  and Customer.Company like :Company')
    Left = 328
    Top = 3
    ParamData = <
      item
        DataType = ftString
        Name = 'Company'
        ParamType = ptUnknown
        Value = 'Unisco'
      end>
    object Query1Company: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object Query1OrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object Query1SaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
  end
  object Query2: TQuery
    Active = True
    DatabaseName = 'DBDEMOS'
    SQL.Strings = (
      'select Customer.Company, Orders.OrderNo, Orders.SaleDate '
      '  from Customer, Orders'
      '  where Customer.CustNo = Orders.CustNo')
    Left = 360
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = Query2
    Left = 400
  end
end
