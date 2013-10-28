object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Barcode studio - ACE reporter demo, http://barcode-software.eu'
  ClientHeight = 389
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 732
    Height = 329
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = -6
    object TabSheet1: TTabSheet
      Caption = 'Reports'
      ExplicitWidth = 281
      ExplicitHeight = 165
      DesignSize = (
        724
        301)
      object RG_REPORTS: TRadioGroup
        Left = 3
        Top = 4
        Width = 217
        Height = 145
        Caption = ' >> Select report << '
        ItemIndex = 0
        Items.Strings = (
          'Single report'
          'Report with table'
          'Symbologies list with samples'
          'List as labels'
          'List of symbologies with details'
          '3 columns samples')
        TabOrder = 0
      end
      object btnPreview: TBitBtn
        Left = 3
        Top = 155
        Width = 217
        Height = 40
        Caption = 'Pre&view'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
      end
      object btnPrint: TBitBtn
        Left = 3
        Top = 201
        Width = 217
        Height = 40
        Caption = '&Designer'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        OnClick = btnPrintClick
      end
      object BitBtn3: TBitBtn
        Left = 3
        Top = 247
        Width = 217
        Height = 40
        Caption = '&Print'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 3
      end
      object AcePreview1: TAcePreview
        Left = 232
        Top = 8
        Width = 480
        Height = 290
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 4
        ExplicitWidth = 441
      end
    end
    object Data: TTabSheet
      Caption = 'Data'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 724
        Height = 301
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object Symbologies: TTabSheet
      Caption = 'Symbologies'
      ImageIndex = 2
      ExplicitWidth = 281
      ExplicitHeight = 165
    end
    object About: TTabSheet
      Caption = 'About'
      ImageIndex = 3
      ExplicitWidth = 685
      ExplicitHeight = 278
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 370
    Width = 732
    Height = 19
    Panels = <>
    ExplicitLeft = 64
    ExplicitTop = 296
    ExplicitWidth = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 329
    Width = 732
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 48
    ExplicitTop = 272
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 4
      Top = 6
      Width = 133
      Height = 29
      DoubleBuffered = True
      Kind = bkClose
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
    end
    object btnEmail: TBitBtn
      Left = 167
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Email'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = btnEmailClick
    end
    object btnHome: TBitBtn
      Left = 248
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Homepage'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      OnClick = btnEmailClick
    end
    object btnOrder: TBitBtn
      Left = 567
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Order'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = btnEmailClick
    end
    object btnEncyclopedia: TBitBtn
      Left = 329
      Top = 10
      Width = 193
      Height = 25
      Caption = 'Barcode &Encyclopedia'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = btnEmailClick
    end
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'animals.dbf'
    Left = 576
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 576
    Top = 56
  end
end
