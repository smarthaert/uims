object Form2: TForm2
  Left = 146
  Top = 274
  Caption = 
    'QR code demo application - http://barcode-software.eu , '#169' PSOFT ' +
    '2011'
  ClientHeight = 473
  ClientWidth = 668
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  DesignSize = (
    668
    473)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 445
    Top = 0
    Width = 223
    Height = 454
    Align = alRight
    BevelInner = bvRaised
    BevelKind = bkSoft
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 27
      Width = 215
      Height = 13
      Align = alTop
      Caption = 'Value to encode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 2
      Top = 114
      Width = 215
      Height = 13
      Margins.Top = 20
      Align = alTop
      Caption = 'Mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 2
      Top = 148
      Width = 215
      Height = 13
      Align = alTop
      Caption = 'Error correction'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 2
      Top = 182
      Width = 215
      Height = 13
      Align = alTop
      Caption = 'Version'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 2
      Top = 2
      Width = 215
      Height = 25
      Align = alTop
      Alignment = taCenter
      Caption = 'QR Code demo'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Shape1: TShape
      Left = 2
      Top = 267
      Width = 215
      Height = 1
      Align = alTop
    end
    object Label7: TLabel
      Left = 2
      Top = 216
      Width = 215
      Height = 13
      Align = alTop
      Caption = 'Mask'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object BitBtn1: TBitBtn
      Left = 2
      Top = 348
      Width = 215
      Height = 25
      Align = alBottom
      Caption = 'Copy'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 2
      Top = 373
      Width = 215
      Height = 25
      Align = alBottom
      Caption = 'Export'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      Visible = False
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 2
      Top = 398
      Width = 215
      Height = 25
      Align = alBottom
      Caption = 'Print'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      Visible = False
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 2
      Top = 423
      Width = 215
      Height = 25
      Align = alBottom
      Caption = 'Close'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object meBarcode: TMemo
      Left = 2
      Top = 40
      Width = 215
      Height = 74
      Align = alTop
      Lines.Strings = (
        'Memo1')
      TabOrder = 4
      OnChange = meBarcodeChange
    end
    object cbMode: TComboBox
      Left = 2
      Top = 127
      Width = 215
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 5
      OnChange = cbModeChange
      Items.Strings = (
        'QrAutomatic'
        'QrNumeric'
        'QrAlphanumeric'
        'QrBytes '
        'QrKanji')
    end
    object cbECC: TComboBox
      Left = 2
      Top = 161
      Width = 215
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 6
      OnChange = cbECCChange
      Items.Strings = (
        'QrEccLevelL'
        'QrEccLevelM'
        'QrEccLevelQ '
        'QrEccLevelH')
    end
    object cbMicro: TCheckBox
      Left = 2
      Top = 250
      Width = 215
      Height = 17
      Align = alTop
      Caption = 'Micro QR code'
      TabOrder = 7
      Visible = False
      OnClick = cbMicroClick
    end
    object cbVersion: TComboBox
      Left = 2
      Top = 195
      Width = 215
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 8
      OnChange = cbVersionChange
      Items.Strings = (
        'Automatic'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23'
        '24'
        '25'
        '26'
        '27'
        '28'
        '29'
        '30'
        '31'
        '32'
        '33'
        '34'
        '35'
        '36'
        '37'
        '38'
        '39'
        '40')
    end
    object cbMask: TComboBox
      Left = 2
      Top = 229
      Width = 215
      Height = 21
      Align = alTop
      Style = csDropDownList
      TabOrder = 9
      Visible = False
      OnChange = cbMaskChange
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
  end
  object SB: TStatusBar
    Left = 0
    Top = 454
    Width = 668
    Height = 19
    Panels = <
      item
        Width = 100
      end>
  end
  object psBarcode1: TpsBarcode
    Left = 8
    Top = 8
    Width = 417
    Height = 433
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
    ErrorInfo.Mode = emDrawErrorString
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 584
    Top = 64
  end
  object ex: TpsExportImport
    SaveFilter = []
    Width = 0
    Height = 0
    FileTypes = []
    Left = 512
    Top = 296
  end
end
