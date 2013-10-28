object frmAbout: TfrmAbout
  Left = 514
  Top = 251
  BorderStyle = bsDialog
  Caption = #20851#20110#31243#24207
  ClientHeight = 244
  ClientWidth = 428
  Color = clBtnFace
  Constraints.MaxHeight = 278
  Constraints.MaxWidth = 436
  Constraints.MinHeight = 276
  Constraints.MinWidth = 434
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 428
    Height = 65
    Align = alTop
    Pen.Color = clWhite
  end
  object Bevel1: TBevel
    Left = 0
    Top = 65
    Width = 428
    Height = 4
    Align = alTop
    Shape = bsTopLine
  end
  object lblAboutTitle: TLabel
    Left = 24
    Top = 14
    Width = 65
    Height = 12
    Caption = #24555#36882#21333#25171#21360
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblAboutDescription: TLabel
    Left = 48
    Top = 33
    Width = 252
    Height = 12
    Caption = #26412#36719#20214#20026#35299#20915#32593#31449#21518#21488#21457#36135#35746#21333#30340#24555#36882#21333#25171#21360#12290
    Transparent = True
  end
  object Image1: TImage
    Left = 352
    Top = 8
    Width = 49
    Height = 49
  end
  object lblProgram: TLabel
    Left = 72
    Top = 110
    Width = 60
    Height = 12
    Caption = #31243#24207#35774#35745#65306
  end
  object lblLogo: TLabel
    Left = 72
    Top = 141
    Width = 60
    Height = 12
    Caption = 'LOGO'#35774#35745#65306
  end
  object lblPageHome: TLabel
    Left = 72
    Top = 171
    Width = 60
    Height = 12
    Caption = #32593#31449#20027#39029#65306
  end
  object lblProgramV: TLabel
    Left = 136
    Top = 110
    Width = 36
    Height = 12
    Caption = #24464#24314#24179
  end
  object lblLogoV: TLabel
    Left = 136
    Top = 141
    Width = 36
    Height = 12
    Caption = #26361#20029#32418
  end
  object lblVersionV: TLabel
    Left = 136
    Top = 80
    Width = 108
    Height = 12
    Caption = '1.0 Build 20091030'
    Transparent = True
  end
  object lblPageHomeV: TRzURLLabel
    Left = 136
    Top = 171
    Width = 132
    Height = 12
    Caption = 'http://www.veryecs.com'
    Font.Charset = GB2312_CHARSET
    Font.Color = clHighlight
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
    URL = 'http://www.veryecs.com'
  end
  object lblVersion: TLabel
    Left = 72
    Top = 80
    Width = 60
    Height = 12
    Caption = #31243#24207#29256#26412#65306
  end
  object Panel1: TPanel
    Left = 0
    Top = 203
    Width = 428
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOK: TRzBitBtn
      Left = 320
      Top = 9
      Width = 85
      Caption = #30830#23450
      HotTrack = True
      TabOrder = 0
      Kind = bkOK
    end
  end
end
