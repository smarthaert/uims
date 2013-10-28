object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 
    'PDF417 barcode demo project .... PSOFT 2011, http://psoft.sk, ht' +
    'tp://barcode-software.eu'
  ClientHeight = 402
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 416
    Top = 13
    Width = 90
    Height = 19
    Caption = 'PDF417 kind'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape1: TShape
    Left = 417
    Top = 41
    Width = 279
    Height = 7
    Brush.Color = clMoneyGreen
    Pen.Style = psClear
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 349
    Width = 704
    Height = 12
    Align = alBottom
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 361
    Width = 704
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 8
      Top = 6
      Width = 100
      Height = 25
      Caption = '&Editor'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      Visible = False
    end
    object BitBtn2: TBitBtn
      Left = 114
      Top = 6
      Width = 100
      Height = 25
      Caption = '&Print'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      Visible = False
    end
    object BitBtn3: TBitBtn
      Left = 489
      Top = 6
      Width = 100
      Height = 25
      Caption = '&Homepage'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 595
      Top = 6
      Width = 100
      Height = 25
      Caption = '&Quit'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      Left = 220
      Top = 6
      Width = 206
      Height = 25
      Caption = '&Save as graphic file'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 4
      Visible = False
      OnClick = BitBtn5Click
    end
  end
  object bc: TpsBarcode
    Left = 24
    Top = 19
    Width = 369
    Height = 324
    Hint = 
      'Symbology  name : PDF417'#13#10'Enumerated name : bcPDF417'#13#10'Symbology ' +
      'type  : stStacked'#13#10'Current value   : ABC0123456789012345ABC98765' +
      '4321098765ABC123'#13#10'Charset         : '#13#10
    BackgroundColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = []
    BarcodeSymbology = bcPDF417
    LinesColor = clBlack
    BarCode = 'ABC0123456789012345ABC987654321098765ABC123'
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
    Params.GS1.FNC1InputType = gs1Classic
    Params.GS1.FNC1Type = fnc1FirstPosition
    Params.PDF417.Mode = psPDF417Alphanumeric
    Params.PDF417.Cols = 2
    Params.PDF417.SecurityLevel = psPDF417Error5
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
    Options = [boTransparent, boStartStopLines, boAddOnUp, boEnableEditor, boAutoSize, boAutoHint, boAutoCheckDigit, boEditorAfterCreate]
    ErrorInfo.Mode = emDrawErrorString
  end
  object PageControl1: TPageControl
    Left = 416
    Top = 64
    Width = 279
    Height = 279
    ActivePage = TabSheet1
    TabOrder = 3
    object TabSheet3: TTabSheet
      Caption = 'To encode'
      ImageIndex = 2
      object Label16: TLabel
        Left = 0
        Top = 0
        Width = 271
        Height = 19
        Align = alTop
        Caption = 'Value to encode :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Shape3: TShape
        Left = 0
        Top = 19
        Width = 271
        Height = 5
        Align = alTop
        Brush.Color = clMoneyGreen
        Pen.Style = psClear
      end
      object meToEncode: TMemo
        Left = 0
        Top = 24
        Width = 271
        Height = 227
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          'meToEncode')
        TabOrder = 0
        OnChange = meToEncodeChange
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Main settings'
      object Mode: TLabel
        Left = 12
        Top = 19
        Width = 26
        Height = 13
        Caption = 'Mode'
      end
      object Label1: TLabel
        Left = 12
        Top = 46
        Width = 64
        Height = 13
        Caption = 'Security level'
      end
      object Label2: TLabel
        Left = 12
        Top = 80
        Width = 20
        Height = 13
        Caption = 'Cols'
      end
      object Label3: TLabel
        Left = 12
        Top = 107
        Width = 26
        Height = 13
        Caption = 'Rows'
      end
      object Shape2: TShape
        Left = 3
        Top = 126
        Width = 232
        Height = 3
        Brush.Color = clMoneyGreen
        Pen.Style = psClear
      end
      object Label5: TLabel
        Left = 12
        Top = 136
        Width = 89
        Height = 13
        Caption = 'Used parameters :'
      end
      object Label6: TLabel
        Left = 12
        Top = 182
        Width = 64
        Height = 13
        Caption = 'Security level'
      end
      object Label7: TLabel
        Left = 12
        Top = 163
        Width = 26
        Height = 13
        Caption = 'Mode'
      end
      object Label8: TLabel
        Left = 12
        Top = 201
        Width = 20
        Height = 13
        Caption = 'Cols'
      end
      object Label9: TLabel
        Left = 12
        Top = 220
        Width = 26
        Height = 13
        Caption = 'Rows'
      end
      object lblUsedMode: TLabel
        Left = 116
        Top = 163
        Width = 26
        Height = 13
        Caption = 'Mode'
      end
      object lblUsedECL: TLabel
        Left = 116
        Top = 182
        Width = 64
        Height = 13
        Caption = 'Security level'
      end
      object lblUsedCols: TLabel
        Left = 116
        Top = 201
        Width = 20
        Height = 13
        Caption = 'Cols'
      end
      object lblUsedRows: TLabel
        Left = 116
        Top = 220
        Width = 26
        Height = 13
        Caption = 'Rows'
      end
      object cbMode: TComboBox
        Left = 112
        Top = 16
        Width = 121
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbModeChange
      end
      object cbECL: TComboBox
        Left = 112
        Top = 43
        Width = 121
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = cbModeChange
      end
      object edCols: TEdit
        Left = 112
        Top = 72
        Width = 105
        Height = 21
        TabOrder = 2
        Text = '1'
        OnChange = cbModeChange
      end
      object edRows: TEdit
        Left = 112
        Top = 99
        Width = 105
        Height = 21
        TabOrder = 3
        Text = '0'
        OnChange = cbModeChange
      end
      object UpDown1: TUpDown
        Left = 217
        Top = 72
        Width = 16
        Height = 21
        Associate = edCols
        Position = 1
        TabOrder = 4
      end
      object UpDown2: TUpDown
        Left = 217
        Top = 99
        Width = 16
        Height = 21
        Associate = edRows
        TabOrder = 5
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Macro PDF417'
      ImageIndex = 1
      TabVisible = False
      object CheckBox1: TCheckBox
        Left = 3
        Top = 0
        Width = 97
        Height = 17
        Caption = 'Use macro block'
        TabOrder = 0
      end
      object grMacro: TGroupBox
        Left = 0
        Top = 15
        Width = 271
        Height = 236
        Align = alBottom
        TabOrder = 1
        object Label10: TLabel
          Left = 8
          Top = 16
          Width = 37
          Height = 13
          Caption = 'Label10'
        end
        object Label11: TLabel
          Left = 8
          Top = 40
          Width = 37
          Height = 13
          Caption = 'Label11'
        end
        object Label12: TLabel
          Left = 3
          Top = 69
          Width = 37
          Height = 13
          Caption = 'Label12'
        end
        object Label13: TLabel
          Left = 3
          Top = 96
          Width = 37
          Height = 13
          Caption = 'Label13'
        end
        object Label14: TLabel
          Left = 3
          Top = 120
          Width = 37
          Height = 13
          Caption = 'Label14'
        end
        object Label15: TLabel
          Left = 3
          Top = 139
          Width = 37
          Height = 13
          Caption = 'Label15'
        end
        object Edit1: TEdit
          Left = 96
          Top = 8
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit2: TEdit
          Left = 96
          Top = 35
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Edit2'
        end
        object Edit3: TEdit
          Left = 96
          Top = 64
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit3'
        end
        object Edit4: TEdit
          Left = 96
          Top = 88
          Width = 121
          Height = 21
          TabOrder = 3
          Text = 'Edit4'
        end
        object Edit5: TEdit
          Left = 96
          Top = 112
          Width = 121
          Height = 21
          TabOrder = 4
          Text = 'Edit5'
        end
        object Edit6: TEdit
          Left = 96
          Top = 136
          Width = 121
          Height = 21
          TabOrder = 5
          Text = 'Edit6'
        end
      end
    end
  end
  object cbKind: TComboBox
    Left = 528
    Top = 8
    Width = 163
    Height = 27
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 1
    ParentFont = False
    TabOrder = 4
    Text = 'Standard'
    OnChange = cbModeChange
    Items.Strings = (
      'Micro'
      'Standard'
      'Truncated')
  end
end
