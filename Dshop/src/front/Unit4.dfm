object Sele: TSele
  Left = 287
  Top = 164
  BorderStyle = bsNone
  Caption = 'Sele'
  ClientHeight = 281
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWhite
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Panel3: TPanel
    Left = 0
    Top = 239
    Width = 403
    Height = 42
    Align = alBottom
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 11
      Top = 8
      Width = 246
      Height = 26
      Caption = #25353'"'#8593#12289#8595'"'#36873#25321#21830#21697';'#25353'Enter('#22238#36710')'#30830#23450
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 47
    Align = alTop
    BevelInner = bvLowered
    Caption = #36873#12288#25321#12288#21830#12288#21697
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = #20223#23435'_GB2312'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 47
    Width = 403
    Height = 192
    Align = alClient
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 2
      Top = 2
      Width = 399
      Height = 188
      Align = alClient
      BorderStyle = bsNone
      Color = clBlack
      Ctl3D = True
      DataSource = DataSource2
      FixedColor = clBlack
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnKeyPress = DBGrid1KeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'BarCode'
          Title.Alignment = taCenter
          Title.Caption = #21830#21697#26465#30721
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GoodsName'
          Title.Alignment = taCenter
          Title.Caption = #21830#21697#21517#31216
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PYBrevity'
          Title.Alignment = taCenter
          Title.Caption = #25340#38899
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Unit'
          Title.Alignment = taCenter
          Title.Caption = #21333#20301
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SellPrice'
          Title.Alignment = taCenter
          Title.Caption = #21806#20215
          Width = 55
          Visible = True
        end>
    end
  end
  object DataSource2: TDataSource
    DataSet = Main.ADOQuery2
    Left = 40
    Top = 16
  end
end
