object Form2: TForm2
  Left = 89
  Top = 140
  Width = 803
  Height = 485
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 432
    Align = alLeft
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 16
      Top = 16
      Width = 153
      Height = 25
      Caption = 'Previe&w'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 16
      Top = 47
      Width = 153
      Height = 25
      Caption = '&Print'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 16
      Top = 78
      Width = 153
      Height = 25
      Caption = 'Printer &setup'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 16
      Top = 157
      Width = 153
      Height = 25
      Caption = '&Direct print'
      TabOrder = 3
    end
    object BitBtn5: TBitBtn
      Left = 16
      Top = 212
      Width = 153
      Height = 25
      Caption = '&Edit barcode'
      TabOrder = 4
      OnClick = BitBtn5Click
    end
    object BitBtn6: TBitBtn
      Left = 16
      Top = 259
      Width = 153
      Height = 25
      TabOrder = 5
      OnClick = BitBtn6Click
      Kind = bkHelp
    end
    object BitBtn7: TBitBtn
      Left = 16
      Top = 290
      Width = 153
      Height = 25
      TabOrder = 6
      Kind = bkClose
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 432
    Width = 795
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end>
  end
  object ZAL: TPageControl
    Left = 185
    Top = 0
    Width = 610
    Height = 432
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Reports'
      object RadioGroup1: TRadioGroup
        Left = 16
        Top = 3
        Width = 241
        Height = 182
        ItemIndex = 0
        Items.Strings = (
          'Simple report '
          'Database report'
          'List supported symbologies'
          'Example of Barcode studio features')
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Data'
      ImageIndex = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 41
        Width = 602
        Height = 363
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 602
        Height = 41
        Align = alTop
        TabOrder = 1
        object DBNavigator1: TDBNavigator
          Left = 2
          Top = 8
          Width = 240
          Height = 25
          DataSource = DataSource1
          TabOrder = 0
        end
      end
    end
    object SH_SAMPLE: TTabSheet
      Caption = 'Sample barcode'
      ImageIndex = 2
      object BarcodeSample: TpsBarcode
        Left = 32
        Top = 23
        Width = 553
        Height = 324
        BackgroundColor = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        BarcodeSymbology = bcEan13
        LinesColor = clBlack
        BarCode = '9771210107001'
        CaptionUpper.Visible = True
        CaptionUpper.Font.Charset = DEFAULT_CHARSET
        CaptionUpper.Font.Color = clWindowText
        CaptionUpper.Font.Height = -13
        CaptionUpper.Font.Name = 'Arial'
        CaptionUpper.Font.Style = []
        CaptionUpper.AutoSize = True
        CaptionUpper.Alignment = taLeftJustify
        CaptionUpper.AutoCaption = False
        CaptionUpper.MaxHeight = 25
        CaptionUpper.ParentFont = False
        CaptionUpper.LineSpacing = 0
        CaptionUpper.BgColor = clNone
        CaptionBottom.Visible = True
        CaptionBottom.Font.Charset = DEFAULT_CHARSET
        CaptionBottom.Font.Color = clWindowText
        CaptionBottom.Font.Height = -13
        CaptionBottom.Font.Name = 'Arial'
        CaptionBottom.Font.Style = []
        CaptionBottom.AutoSize = True
        CaptionBottom.Alignment = taLeftJustify
        CaptionBottom.AutoCaption = False
        CaptionBottom.MaxHeight = 25
        CaptionBottom.ParentFont = False
        CaptionBottom.LineSpacing = 0
        CaptionBottom.BgColor = clNone
        CaptionHuman.Visible = True
        CaptionHuman.Font.Charset = DEFAULT_CHARSET
        CaptionHuman.Font.Color = clWindowText
        CaptionHuman.Font.Height = -13
        CaptionHuman.Font.Name = 'Arial'
        CaptionHuman.Font.Style = []
        CaptionHuman.AutoSize = True
        CaptionHuman.Alignment = taLeftJustify
        CaptionHuman.AutoCaption = False
        CaptionHuman.MaxHeight = 25
        CaptionHuman.ParentFont = False
        CaptionHuman.LineSpacing = 0
        CaptionHuman.BgColor = clNone
        Params.ECI = 3
        Params.GS1.FNC1InputType = gs1Separators
        Params.GS1.FNC1Type = fnc1None
        Params.PDF417.Mode = psPDF417Alphanumeric
        Params.PDF417.SecurityLevel = psPDF417AutoEC
        Params.PDF417.FileSize = 0
        Params.PDF417.Kind = pkStandard
        Params.PDF417.Checksum = 0
        Params.PDF417.UseMacro = False
        Params.DataMatrix.Encoding = dmeAutomatic
        Params.DataMatrix.Version = psDMAutomatic
        Params.QRCode.EccLevel = QrEccLevelM
        Params.QRCode.Mode = QrAutomatic
        Params.QRCode.MicroQR = False
        Params.QRCode.Version = 0
        Params.QRCode.Mask = 0
        Params.QRCode.Checksum = 0
        Options = [boTransparent, boSecurity, boStartStopLines, boAddOnUp, boEnableEditor, boAutoSize, boAutoHint, boAutoCheckDigit, boEditorAfterCreate]
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 536
    Top = 64
  end
  object Table1: TTable
    DatabaseName = 'DBDEMOS'
    TableName = 'country.db'
    Left = 488
    Top = 64
  end
end
