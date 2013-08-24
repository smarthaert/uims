object QHD_P: TQHD_P
  Left = 552
  Top = 301
  BorderStyle = bsNone
  Caption = 'QHD_P'
  ClientHeight = 362
  ClientWidth = 492
  Color = clBlack
  Font.Charset = GB2312_CHARSET
  Font.Color = clWhite
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 492
    Height = 80
    Align = alTop
    BevelInner = bvLowered
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = #20223#23435'_GB2312'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 156
      Top = 10
      Width = 180
      Height = 29
      Caption = #20986#24211#21333#25454#34917#25171
    end
    object Label3: TLabel
      Left = 132
      Top = 54
      Width = 36
      Height = 12
      Caption = #21333#21495#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 169
      Top = 50
      Width = 193
      Height = 18
      Ctl3D = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #20223#23435'_GB2312'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 80
    Width = 492
    Height = 225
    Align = alClient
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 488
      Height = 221
      TabStop = False
      Align = alClient
      Color = clBlack
      Ctl3D = False
      DataSource = DataSource1
      FixedColor = clBlack
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnKeyPress = DBGrid1KeyPress
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'created_at'
          Title.Alignment = taCenter
          Title.Caption = #24314#21333#26085#26399
          Width = 86
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'slid'
          Title.Alignment = taCenter
          Title.Caption = #21333#12288#21495
          Width = 83
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'custname'
          Title.Caption = #23458#25143#22995#21517
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'custtel'
          Title.Caption = #23458#25143#30005#35805
          Width = 59
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'uname'
          Title.Alignment = taCenter
          Title.Caption = #25805#20316#21592
          Width = 80
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 305
    Width = 492
    Height = 57
    Align = alBottom
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 135
      Top = 24
      Width = 76
      Height = 26
      Caption = 'Esc.'#36820#12288#22238
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 223
      Top = 24
      Width = 134
      Height = 26
      Caption = 'Enter('#22238#36710').'#21462#12288#21333
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object Label1: TLabel
      Left = 140
      Top = 7
      Width = 204
      Height = 12
      Caption = #25353'"'#8593#12289#8595'"'#36873#25321#21830#21697#35760#24405';'#25353#22238#36710#30830#23450'.'
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 40
    Top = 8
  end
  object ADOQuery1: TADOQuery
    Connection = Main.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'Select * from Sell_Main where Not(Hang)')
    Left = 8
    Top = 8
  end
  object ADOQuerySQL: TADOQuery
    Connection = Main.ADOConnection1
    Parameters = <>
    Left = 16
    Top = 111
  end
end
