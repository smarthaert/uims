object Form1: TForm1
  Left = 175
  Top = 191
  Caption = 'IntelligentMail'#174' Barcode demo'
  ClientHeight = 233
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image2: TImage
    Left = 8
    Top = 176
    Width = 185
    Height = 44
    Cursor = crHandPoint
    Hint = 'PSOFT Home : http://psoft.sk , http://barcode-software.eu'
    Center = True
    Picture.Data = {
      07544269746D6170EE040000424DEE0400000000000076000000280000006400
      0000160000000100040000000000780400000000000000000000100000000000
      000000000000080808009EA09E0061626000C1E4BC0031AB270042AD37004065
      3E00195B150030DE1D00A4E49D0062D356005CA9550044CC370085EA7C001C01
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000440000
      4444000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000044222224000233322240000000042222222
      2224000000442222224000004224000000000000004224000000000000000000
      000422CCC66C400A888873322400000237777777773324000423777773324002
      3732000000000000023732000000000000000000042CCD55555C200099958887
      3324000211111111111832004311111111832402111300000000000002111300
      00000000000000004266666666662400D9999958873240041111111111118340
      2111111111113244111340000000000004111340000000000000000A65555555
      5555E400ABBDD999588722004444444423711720F11130002371132081172000
      0000000000F1172000000000000000A6555555555555C400000004AEDB583240
      00000000007111241118400004311F2471182000000000000031182000000000
      000004C6666666666666C2000004400004E68320000422222271112211174000
      002711322111322222222200002111240000000000000A666666666666666200
      00222224004E8820004233333711112411172000000711822111773333333340
      004111340000000000000B555555555555555C400E888733400AD82004711111
      1111110011182000000311134811111111111340000811320000000000000D55
      5555555555555C400A5588872000D82003111111111112007111240000021113
      4311111111111300000311720000000000000E66666666666666662004999958
      2000D840081117333322000021113200000411174211173222222200000211F2
      0000000000000E66555555555555562400D99998400056000811F24000000000
      471183400004111744111324000000000004111340000000000000BD66666666
      666666C400B9995E00045A0003111322222222240271173224231113003F1832
      222222244222111722222400000000ABB6666666666666C200A55B40000EA000
      027118333333333200371173333F111200431187333333322333111833333200
      00000004B6555555555555620004000000440000002311111111111340027111
      1111117000023F11111111831111111111118200000000000AD6655555555552
      40000000440000000002811111111113000027111111174000004311111111F2
      111111111111F400000000000004EBBC6666666E400000440000000000004233
      3333333200000022333240000000004223333334233333333333300000000000
      00000AAEBBBBBBBA000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000044AAA400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    Transparent = True
  end
  object ED: TEdit
    Left = 8
    Top = 8
    Width = 697
    Height = 37
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 36
    ParentFont = False
    TabOrder = 0
    Text = '01-234-567094-987654321-01234567891'
    OnChange = EDChange
  end
  object BitBtn1: TBitBtn
    Left = 576
    Top = 176
    Width = 129
    Height = 41
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    Kind = bkClose
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
  end
  object BC: TpsBarcode
    Left = 8
    Top = 72
    Width = 697
    Height = 80
    BackgroundColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = []
    BarcodeSymbology = bcIntelligentMail
    LinesColor = clBlack
    BarCode = '01-234-567094-987654321-01234567891'
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
end
