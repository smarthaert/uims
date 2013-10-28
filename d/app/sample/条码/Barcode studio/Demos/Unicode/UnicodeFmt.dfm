object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'DataMatrix, PDF417, QR code & Unicode example, http://psoft.sk'
  ClientHeight = 637
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    513
    637)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 575
    Width = 497
    Height = 13
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Caption = 'Value to encode, change and see changes in barcode images'
    ExplicitTop = 461
    ExplicitWidth = 420
  end
  object Memo1: TMemo
    Left = 8
    Top = 594
    Width = 494
    Height = 34
    Anchors = [akLeft, akRight, akBottom]
    Lines.Strings = (
      #45208#45716' '#44552#48169' QR code '#44060#48156#51012' '#45149#45256#45796
      #50557' 2-3'#51068#51221#46020#47732' '#47560#51648#47561' '#48260#51260#51012' '#47564#46308#49688' '#51080#45796'!!')
    TabOrder = 0
    OnChange = Memo1Change
    ExplicitTop = 550
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 8
    Width = 505
    Height = 561
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'DataMatrix'
      ExplicitHeight = 469
      DesignSize = (
        497
        533)
      object DATAMATRIX: TpsBarcode
        Left = 16
        Top = 16
        Width = 464
        Height = 499
        Anchors = [akLeft, akTop, akRight, akBottom]
        BackgroundColor = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        BarcodeSymbology = bcDataMatrix
        LinesColor = clBlack
        BarCode = 'Authors homepage : http://barcode-software.eu , http://psoft.sk'
        CaptionUpper.Font.Charset = DEFAULT_CHARSET
        CaptionUpper.Font.Color = clWindowText
        CaptionUpper.Font.Height = -13
        CaptionUpper.Font.Name = 'Arial'
        CaptionUpper.Font.Style = []
        CaptionUpper.Alignment = taLeftJustify
        CaptionUpper.ParentFont = False
        CaptionBottom.Font.Charset = DEFAULT_CHARSET
        CaptionBottom.Font.Color = clWindowText
        CaptionBottom.Font.Height = -13
        CaptionBottom.Font.Name = 'Arial'
        CaptionBottom.Font.Style = []
        CaptionBottom.Alignment = taLeftJustify
        CaptionBottom.ParentFont = False
        CaptionHuman.Font.Charset = DEFAULT_CHARSET
        CaptionHuman.Font.Color = clWindowText
        CaptionHuman.Font.Height = -13
        CaptionHuman.Font.Name = 'Arial'
        CaptionHuman.Font.Style = []
        CaptionHuman.Alignment = taLeftJustify
        CaptionHuman.ParentFont = False
        Params.FNC1_InputType = gs1Classic
        Params.PDF417.SecurityLevel = psPDF417AutoEC
        Params.DataMatrix.Encoding = dmeASCII
        Params.DataMatrix.Version = psDMAutomatic
        Params.QRCode.EccLevel = QrEccLevelM
        Params.QRCode.Mode = QrAutomatic
        Params.QRCode.MicroQR = False
        Params.QRCode.Version = 0
        Params.QRCode.Mask = 0
        Params.QRCode.Checksum = 0
        Options = [boTransparent, boSecurity, boStartStopLines, boAddOnUp, boEnableEditor, boAutoSize, boAutoHint, boAutoCheckDigit, boEditorAfterCreate]
        ExplicitHeight = 435
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'QR Code'
      ImageIndex = 1
      ExplicitHeight = 469
      DesignSize = (
        497
        533)
      object QRCODE: TpsBarcode
        Left = 16
        Top = 21
        Width = 466
        Height = 494
        Anchors = [akLeft, akTop, akRight, akBottom]
        BackgroundColor = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        BarcodeSymbology = bcQRCode
        LinesColor = clBlack
        BarCode = 'Authors homepage : http://barcode-software.eu , http://psoft.sk'
        CaptionUpper.Font.Charset = DEFAULT_CHARSET
        CaptionUpper.Font.Color = clWindowText
        CaptionUpper.Font.Height = -13
        CaptionUpper.Font.Name = 'Arial'
        CaptionUpper.Font.Style = []
        CaptionUpper.Alignment = taLeftJustify
        CaptionUpper.ParentFont = False
        CaptionBottom.Font.Charset = DEFAULT_CHARSET
        CaptionBottom.Font.Color = clWindowText
        CaptionBottom.Font.Height = -13
        CaptionBottom.Font.Name = 'Arial'
        CaptionBottom.Font.Style = []
        CaptionBottom.Alignment = taLeftJustify
        CaptionBottom.ParentFont = False
        CaptionHuman.Font.Charset = DEFAULT_CHARSET
        CaptionHuman.Font.Color = clWindowText
        CaptionHuman.Font.Height = -13
        CaptionHuman.Font.Name = 'Arial'
        CaptionHuman.Font.Style = []
        CaptionHuman.Alignment = taLeftJustify
        CaptionHuman.ParentFont = False
        Params.FNC1_InputType = gs1Classic
        Params.PDF417.SecurityLevel = psPDF417AutoEC
        Params.DataMatrix.Encoding = dmeAutomatic
        Params.DataMatrix.Version = psDMAutomatic
        Params.QRCode.EccLevel = QrEccLevelM
        Params.QRCode.Mode = QrBytes
        Params.QRCode.MicroQR = False
        Params.QRCode.Version = 0
        Params.QRCode.Mask = 0
        Params.QRCode.Checksum = 0
        Options = [boTransparent, boSecurity, boStartStopLines, boAddOnUp, boEnableEditor, boAutoSize, boAutoHint, boAutoCheckDigit, boEditorAfterCreate]
        ExplicitHeight = 430
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'PDF417'
      ImageIndex = 2
      ExplicitHeight = 489
      DesignSize = (
        497
        533)
      object PDF417: TpsBarcode
        Left = 16
        Top = 21
        Width = 469
        Height = 494
        Anchors = [akLeft, akTop, akRight, akBottom]
        BackgroundColor = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        BarcodeSymbology = bcPDF417
        LinesColor = clBlack
        BarCode = 'PSOFT, http://www.psoft.sk, email: peter@psoft.sk'
        CaptionUpper.Font.Charset = DEFAULT_CHARSET
        CaptionUpper.Font.Color = clWindowText
        CaptionUpper.Font.Height = -13
        CaptionUpper.Font.Name = 'Arial'
        CaptionUpper.Font.Style = []
        CaptionUpper.Alignment = taLeftJustify
        CaptionUpper.ParentFont = False
        CaptionBottom.Font.Charset = DEFAULT_CHARSET
        CaptionBottom.Font.Color = clWindowText
        CaptionBottom.Font.Height = -13
        CaptionBottom.Font.Name = 'Arial'
        CaptionBottom.Font.Style = []
        CaptionBottom.Alignment = taLeftJustify
        CaptionBottom.ParentFont = False
        CaptionHuman.Font.Charset = DEFAULT_CHARSET
        CaptionHuman.Font.Color = clWindowText
        CaptionHuman.Font.Height = -13
        CaptionHuman.Font.Name = 'Arial'
        CaptionHuman.Font.Style = []
        CaptionHuman.Alignment = taLeftJustify
        CaptionHuman.ParentFont = False
        Params.FNC1_InputType = gs1Classic
        Params.PDF417.Mode = psPDF417Binary
        Params.PDF417.Rows = 10
        Params.PDF417.Cols = 5
        Params.PDF417.SecurityLevel = psPDF417AutoEC
        Params.DataMatrix.Encoding = dmeAutomatic
        Params.DataMatrix.Version = psDMAutomatic
        Params.QRCode.EccLevel = QrEccLevelM
        Params.QRCode.Mode = QrBytes
        Params.QRCode.MicroQR = False
        Params.QRCode.Version = 0
        Params.QRCode.Mask = 0
        Params.QRCode.Checksum = 0
        Options = [boTransparent, boSecurity, boStartStopLines, boAddOnUp, boEnableEditor, boAutoSize, boAutoHint, boAutoCheckDigit, boEditorAfterCreate]
        ExplicitHeight = 450
      end
    end
  end
end
