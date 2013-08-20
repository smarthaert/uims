object QP: TQP
  Left = 697
  Top = 250
  BorderStyle = bsNone
  Caption = 'QP'
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
    Height = 47
    Align = alTop
    BevelInner = bvLowered
    Caption = #20135'  '#21697
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = #20223#23435'_GB2312'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 47
    Width = 492
    Height = 258
    Align = alClient
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 488
      Height = 254
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
          FieldName = 'pid'
          Title.Alignment = taCenter
          Title.Caption = #32534#21495
          Width = 53
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'goodsname'
          Title.Alignment = taCenter
          Title.Caption = #21517#31216
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'color'
          Title.Caption = #39068#33394
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'size'
          Title.Caption = #23610#23544
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'volume'
          Title.Caption = #20307#31215
          Width = 29
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'amount'
          Title.Caption = #25968#37327
          Width = 36
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'unit'
          Title.Caption = #21333#20301
          Width = 61
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'remark'
          Title.Alignment = taCenter
          Title.Caption = #22791#27880
          Width = 47
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
      Caption = 'Enter('#22238#36710').'#30830#35748#36873#25321
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
      Caption = #25353'"'#8593#12289#8595'"'#36873#25321#20135#21697#35760#24405';'#25353#22238#36710#30830#23450'.'
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
end
