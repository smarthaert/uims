object Rpt1: TRpt1
  Left = 0
  Top = 0
  Caption = 'ACE report designer'
  ClientHeight = 392
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SctReport1: TSctReport
    Left = 0
    Top = 0
    Width = 733
    Height = 392
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Align = alClient
    TabOrder = 0
    Visible = False
    Minimized = False
    Prompt = True
    AutoRun = False
    SuppressStatus = False
    PixelsPerInch = 96
    STop = 0
    SLeft = 0
    SWidth = 733
    SHeight = 392
    MTop = 0
    MLeft = 0
    SAlign = alClient
    Version = vAce1_0
    object ReportPage: TSctGrouppage
      Left = 35
      Top = 55
      Width = 678
      Height = 317
      HorzScrollBar.Position = 112
      Align = alClient
      Color = clWhite
      ParentColor = False
      TabOrder = 2
      ClipLabels = False
      PageSetup.Height = 11.000000000000000000
      PageSetup.Width = 8.500000000000000000
      BorderType = btNone
      CloseDataSet = False
      DataRange = drAllRecords
      OmitLastPgFt = False
      Head = ReportHeaderBand
      Detail = DetailBand
      Foot = ReportFooterBand
      PageHead = PageHeaderBand
      PageFoot = PageFooterBand
      ExplicitWidth = 27
      ExplicitHeight = 0
      Order = 1
      object ReportHeaderBandlevel: TSctLevel
        Left = -112
        Top = 0
        Width = 0
        Height = 0
        IsHeader = True
      end
      object PageHeaderBandlevel: TSctLevel
        Left = -112
        Top = 0
        Width = 0
        Height = 0
        IsHeader = True
      end
      object DetailBandlevel: TSctLevel
        Left = -112
        Top = 0
        Width = 0
        Height = 0
      end
      object PageFooterBandlevel: TSctLevel
        Left = -112
        Top = 0
        Width = 0
        Height = 0
      end
      object ReportFooterBandlevel: TSctLevel
        Left = -112
        Top = 0
        Width = 0
        Height = 0
      end
      object svarDateTime: TSctDateTimeVar
        Left = 0
        Top = 0
        Width = 0
        Height = 0
        AutoVar = True
        ID = vidDateTimeVar
      end
      object svarPage: TSctPageVar
        Left = 0
        Top = 0
        Width = 0
        Height = 0
        UpdateLevel = PageHeaderBandlevel
        AutoVar = True
        ID = vidPageVar
      end
      object ReportHeaderBand: TSctBand
        Left = -112
        Top = 0
        Width = 840
        Height = 5
        ParentColor = True
        BandName = 'Report Header'
        Updatelevel = ReportHeaderBandlevel
      end
      object PageHeaderBand: TSctBand
        Left = -112
        Top = 20
        Width = 840
        Height = 90
        ParentColor = True
        BandName = 'Page Header'
        Updatelevel = PageHeaderBandlevel
        object SctLine1: TSctLine
          Left = 120
          Top = 57
          Width = 585
          Height = 8
        end
        object Sctvarlabel1: TSctvarlabel
          Left = 128
          Top = 8
          Width = 577
          Height = 41
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Caption = 'Barcode studio - ACE reporter demo.'
        end
      end
      object DetailBand: TSctBand
        Left = -112
        Top = 125
        Width = 840
        Height = 116
        ParentColor = True
        BandName = 'Detail'
        Updatelevel = DetailBandlevel
        object psACEBarcode1: TpsACEBarcode
          Left = 120
          Top = 16
          Width = 177
          Height = 81
          BarcodeSymbology = bcEan13
          Barcode = '9771210107001'
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
          LinesColor = clBlack
          Options = [boTransparent, boStartStopLines, boAddOnUp, boEnableEditor, boAutoSize, boAutoHint, boAutoCheckDigit, boEditorAfterCreate]
          BackgroundColor = clWhite
          Angle = 0
        end
      end
      object PageFooterBand: TSctBand
        Left = -112
        Top = 256
        Width = 840
        Height = 20
        ParentColor = True
        BandName = 'Page Footer'
        Updatelevel = PageFooterBandlevel
      end
      object ReportFooterBand: TSctBand
        Left = -112
        Top = 291
        Width = 840
        Height = 20
        ParentColor = True
        BandName = 'Report Footer'
        Updatelevel = ReportFooterBandlevel
      end
    end
  end
end
