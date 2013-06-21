object frmMainForm: TfrmMainForm
  Left = 206
  Top = 172
  Width = 379
  Height = 272
  Caption = #26102#38047#32452#20214#27979#35797#31243#24207'-'#21033#29992#32447#31243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object clckClock: TClock
    Left = 0
    Top = 0
    Width = 145
    Height = 130
    HourValue = 15
    MinuteValue = 59
    SecondValue = 29
    HourColor = clBlack
    MinuteColor = clBlack
    SecondColor = clBlack
    Radius = 50
    Enabled = True
  end
  object grpSet: TGroupBox
    Left = 8
    Top = 136
    Width = 345
    Height = 89
    Caption = #26102#38047#35774#32622
    TabOrder = 2
    object lblHourValue: TLabel
      Left = 16
      Top = 24
      Width = 24
      Height = 13
      Caption = #26102#65306
    end
    object lblMinuteValue: TLabel
      Left = 86
      Top = 24
      Width = 24
      Height = 13
      Caption = #20998#65306
    end
    object lblSecondValue: TLabel
      Left = 155
      Top = 24
      Width = 24
      Height = 13
      Caption = #31186#65306
    end
    object lblHourColor: TLabel
      Left = 16
      Top = 56
      Width = 24
      Height = 13
      Caption = #26102#65306
    end
    object lblMinuteColor: TLabel
      Left = 86
      Top = 56
      Width = 24
      Height = 13
      Caption = #20998#65306
    end
    object lblSecondColor: TLabel
      Left = 155
      Top = 56
      Width = 24
      Height = 13
      Caption = #31186#65306
    end
    object shpHourColor: TShape
      Left = 40
      Top = 50
      Width = 41
      Height = 22
      Brush.Color = clDefault
      OnMouseDown = shpHourColorMouseDown
    end
    object shpMinuteColor: TShape
      Left = 110
      Top = 50
      Width = 41
      Height = 22
      Brush.Color = clDefault
      OnMouseDown = shpMinuteColorMouseDown
    end
    object shpSecondColor: TShape
      Left = 179
      Top = 50
      Width = 41
      Height = 22
      Brush.Color = clDefault
      OnMouseDown = shpSecondColorMouseDown
    end
    object lblSize: TLabel
      Left = 232
      Top = 24
      Width = 36
      Height = 13
      Caption = #22823#23567#65306
    end
    object seHourValue: TSpinEdit
      Left = 40
      Top = 20
      Width = 41
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = seHourValueChange
    end
    object seMinuteValue: TSpinEdit
      Left = 110
      Top = 20
      Width = 41
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = seHourValueChange
    end
    object seSecondValue: TSpinEdit
      Left = 179
      Top = 20
      Width = 41
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = seHourValueChange
    end
    object seSize: TSpinEdit
      Left = 272
      Top = 20
      Width = 41
      Height = 22
      MaxValue = 80
      MinValue = 0
      TabOrder = 3
      Value = 50
      OnChange = seSizeChange
    end
  end
  object rgClockStyle: TRadioGroup
    Left = 168
    Top = 8
    Width = 193
    Height = 105
    Caption = #26102#38047#26174#31034#39118#26684
    ItemIndex = 0
    Items.Strings = (
      #25351#38024#22411#26102#38047
      #25968#23383#22411#26102#38047)
    TabOrder = 0
    OnClick = rgClockStyleClick
  end
  object btnRunOrStop: TBitBtn
    Left = 256
    Top = 184
    Width = 75
    Height = 25
    Caption = #36816#34892#20013'...'
    TabOrder = 1
    OnClick = btnRunOrStopClick
    Kind = bkYes
  end
  object dlgColor: TColorDialog
    Left = 328
    Top = 112
  end
end
