object Form1: TForm1
  Left = 206
  Top = 256
  Width = 399
  Height = 293
  Caption = #31243#24207#22312#24490#29615#20013#21709#24212#30028#38754#25805#20316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 391
    Height = 259
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 0
    object Button1: TButton
      Left = 194
      Top = 222
      Width = 83
      Height = 21
      Caption = #24320#22987
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 293
      Top = 221
      Width = 83
      Height = 21
      Caption = #36864#20986
      TabOrder = 1
      OnClick = Button2Click
    end
    object ProgressBar1: TProgressBar
      Left = 17
      Top = 195
      Width = 358
      Height = 18
      TabOrder = 2
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 361
      Height = 185
      Caption = #25968#25454
      TabOrder = 3
      object DBGrid1: TDBGrid
        Left = 2
        Top = 18
        Width = 357
        Height = 165
        Align = alClient
        DataSource = DataSource1
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'OrderNo'
            Title.Caption = #39034#24207#21495
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ItemNo'
            Title.Caption = #39033#30446#21495
            Width = 81
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Discount'
            Title.Caption = #25240#25187
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Qty'
            Title.Caption = #25968#37327
            Visible = True
          end>
      end
    end
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'items.db'
    Left = 16
    Top = 224
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 48
    Top = 224
  end
end
