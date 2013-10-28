object Form1: TForm1
  Left = 82
  Top = 103
  Width = 920
  Height = 671
  Caption = #21457#31080#36830#32493#25171#21360#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 64
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #36215#22987#26085#26399':'
  end
  object Label2: TLabel
    Left = 248
    Top = 64
    Width = 65
    Height = 25
    AutoSize = False
    Caption = #32467#26463#26085#26399':'
  end
  object Label3: TLabel
    Left = 480
    Top = 64
    Width = 73
    Height = 21
    AutoSize = False
    Caption = #26426#26500#21495':'
  end
  object Label4: TLabel
    Left = 208
    Top = 96
    Width = 41
    Height = 21
    AutoSize = False
    Caption = #65293
  end
  object Label5: TLabel
    Left = 296
    Top = 104
    Width = 57
    Height = 17
    AutoSize = False
    Caption = #26465#35760#24405
  end
  object Edit1: TEdit
    Left = 64
    Top = 64
    Width = 121
    Height = 21
    Hint = #35831#36755#20837#22914'20091201'#30340'8'#20301#25968#23383
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = '20091201'
  end
  object Edit2: TEdit
    Left = 312
    Top = 64
    Width = 121
    Height = 21
    Hint = #35831#36755#20837#22914'20091231'#30340'8'#20010#25968#23383
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '20091231'
  end
  object Button1: TButton
    Left = 352
    Top = 96
    Width = 105
    Height = 25
    Caption = #24320#22987#25171#21360
    TabOrder = 2
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 536
    Top = 64
    Width = 145
    Height = 21
    Hint = #20026#31354#20195#34920#25152#26377#26426#26500
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object Button2: TButton
    Left = 0
    Top = 96
    Width = 75
    Height = 25
    Caption = #26597#30475#35760#24405
    TabOrder = 4
    OnClick = Button2Click
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 120
    Width = 912
    Height = 497
    DataSource = DataSource1
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    RowDetailPanel.Color = clBtnFace
    SortLocal = True
    STFilter.Local = True
    STFilter.Visible = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Edit3: TEdit
    Left = 144
    Top = 96
    Width = 57
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object Edit4: TEdit
    Left = 224
    Top = 96
    Width = 65
    Height = 21
    TabOrder = 7
  end
  object MainMenu1: TMainMenu
    Left = 256
    Top = 176
    object N8: TMenuItem
      Caption = #25171#21360#35774#32622
      object N9: TMenuItem
        Caption = #24494#35843#25171#21360#20301#32622
        OnClick = N9Click
      end
      object N10: TMenuItem
        Caption = #25171#21360#31471#21475#35774#32622
        OnClick = N10Click
      end
    end
    object N4: TMenuItem
      Caption = #24110#21161
      object N5: TMenuItem
        Caption = #26597#30475#24110#21161
        OnClick = N5Click
      end
    end
    object N6: TMenuItem
      Caption = #36864#20986
      object N7: TMenuItem
        Caption = #36864#20986#31995#32479
        OnClick = N7Click
      end
    end
  end
  object ADOQuery2: TADOQuery
    CursorType = ctStatic
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 128
    Top = 248
  end
  object ADOQuery1: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tadaiben.a111872')
    Left = 264
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery2
    Left = 160
    Top = 248
  end
end
