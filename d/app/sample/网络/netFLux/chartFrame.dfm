object frameChart: TframeChart
  Left = 0
  Top = 0
  Width = 725
  Height = 443
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  OnResize = FrameResize
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 725
    Height = 145
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 495
      Height = 143
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        #32593#32476#27969#37327)
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Maximum = 281.000000000000000000
      Legend.Alignment = laBottom
      Legend.ColorWidth = 20
      Legend.LegendStyle = lsSeries
      Legend.ShadowSize = 0
      Legend.TopPos = 0
      View3D = False
      Align = alClient
      TabOrder = 0
      object Series1: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = #21457#20986#27969#37327
        LinePen.Color = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series2: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clGreen
        Title = #25509#25910#27969#37327
        LinePen.Color = clGreen
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
    object Panel2: TPanel
      Left = 496
      Top = 1
      Width = 228
      Height = 143
      Align = alRight
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 48
        Height = 12
        Caption = #25509#25910#27969#37327
      end
      object Label2: TLabel
        Left = 8
        Top = 40
        Width = 48
        Height = 12
        Caption = #21457#20986#27969#37327
      end
      object Label12: TLabel
        Left = 197
        Top = 16
        Width = 24
        Height = 12
        Caption = 'Byte'
      end
      object Label13: TLabel
        Left = 198
        Top = 40
        Width = 24
        Height = 12
        Caption = 'Byte'
      end
      object sta1Rev: TStaticText
        Left = 65
        Top = 14
        Width = 129
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 0
      end
      object sta1Send: TStaticText
        Left = 65
        Top = 38
        Width = 129
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 1
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 145
    Width = 725
    Height = 143
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel3'
    TabOrder = 1
    object Chart2: TChart
      Left = 1
      Top = 1
      Width = 495
      Height = 141
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        #24191#25773#36127#36733#29575)
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Maximum = 100.000000000000000000
      Legend.Alignment = laBottom
      Legend.LegendStyle = lsSeries
      Legend.ShadowSize = 0
      Legend.TopPos = 0
      View3D = False
      Align = alClient
      TabOrder = 0
      object Series3: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = #24191#25773#25509#25910#36127#36733#29575
        LinePen.Color = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series4: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clGreen
        Title = #24191#25773#21457#20986#36127#36733#29575
        LinePen.Color = clGreen
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
    object Panel4: TPanel
      Left = 496
      Top = 1
      Width = 228
      Height = 141
      Align = alRight
      TabOrder = 1
      object Label4: TLabel
        Left = 8
        Top = 8
        Width = 60
        Height = 12
        Caption = #25509#25910#29992#25143#21253
      end
      object Label5: TLabel
        Left = 8
        Top = 29
        Width = 60
        Height = 12
        Caption = #25509#25910#24191#25773#21253
      end
      object Label6: TLabel
        Left = 8
        Top = 70
        Width = 60
        Height = 12
        Caption = #21457#20986#24191#25773#21253
      end
      object Label7: TLabel
        Left = 8
        Top = 49
        Width = 60
        Height = 12
        Caption = #21457#20986#29992#25143#21253
      end
      object Label15: TLabel
        Left = 197
        Top = 8
        Width = 24
        Height = 12
        Caption = #20010#21253
      end
      object Label16: TLabel
        Left = 197
        Top = 28
        Width = 24
        Height = 12
        Caption = #20010#21253
      end
      object Label17: TLabel
        Left = 197
        Top = 49
        Width = 24
        Height = 12
        Caption = #20010#21253
      end
      object Label18: TLabel
        Left = 197
        Top = 70
        Width = 24
        Height = 12
        Caption = #20010#21253
      end
      object Label23: TLabel
        Left = 8
        Top = 91
        Width = 84
        Height = 12
        Caption = #24191#25773#25509#25910#36127#36733#29575
      end
      object Label24: TLabel
        Left = 8
        Top = 112
        Width = 84
        Height = 12
        Caption = #24191#25773#21457#20986#36127#36733#29575
      end
      object Label25: TLabel
        Left = 196
        Top = 91
        Width = 6
        Height = 12
        Caption = '%'
      end
      object Label26: TLabel
        Left = 196
        Top = 112
        Width = 6
        Height = 12
        Caption = '%'
      end
      object sta2Rev: TStaticText
        Left = 75
        Top = 6
        Width = 118
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 0
      end
      object sta2RevUser: TStaticText
        Left = 75
        Top = 26
        Width = 118
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 1
      end
      object sta2Send: TStaticText
        Left = 75
        Top = 47
        Width = 118
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 2
      end
      object sta2SendUser: TStaticText
        Left = 75
        Top = 68
        Width = 118
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 3
      end
      object sta2RevV: TStaticText
        Left = 104
        Top = 89
        Width = 89
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 4
      end
      object Sta2SendV: TStaticText
        Left = 104
        Top = 110
        Width = 89
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 5
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 288
    Width = 725
    Height = 155
    Align = alBottom
    BevelOuter = bvLowered
    Caption = 'Panel5'
    TabOrder = 2
    object Chart3: TChart
      Left = 1
      Top = 1
      Width = 495
      Height = 153
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        #32593#32476#36127#36733#29575)
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Maximum = 100.000000000000000000
      Legend.Alignment = laBottom
      Legend.LegendStyle = lsSeries
      Legend.ShadowSize = 0
      Legend.TopPos = 0
      View3D = False
      Align = alClient
      TabOrder = 0
      object Series5: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = #21457#20986#36127#36733#29575
        LinePen.Color = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series6: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clGreen
        Title = #25509#25910#36127#36733#29575
        LinePen.Color = clGreen
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series7: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = 8454143
        Title = #32508#21512#36127#36733#29575
        LinePen.Color = 8454143
        LinePen.Width = 2
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
    object Panel6: TPanel
      Left = 496
      Top = 1
      Width = 228
      Height = 153
      Align = alRight
      TabOrder = 1
      object Label8: TLabel
        Left = 8
        Top = 16
        Width = 72
        Height = 12
        Caption = #25509#21475#26368#22823#24102#23485
      end
      object Label9: TLabel
        Left = 8
        Top = 40
        Width = 60
        Height = 12
        Caption = #25509#25910#36127#36733#29575
      end
      object Label10: TLabel
        Left = 8
        Top = 64
        Width = 60
        Height = 12
        Caption = #21457#20986#36127#36733#29575
      end
      object Label11: TLabel
        Left = 8
        Top = 88
        Width = 60
        Height = 12
        Caption = #32508#21512#36127#36733#29575
      end
      object Label19: TLabel
        Left = 200
        Top = 16
        Width = 24
        Height = 12
        Caption = 'MBps'
      end
      object Label20: TLabel
        Left = 200
        Top = 40
        Width = 6
        Height = 12
        Caption = '%'
      end
      object Label21: TLabel
        Left = 200
        Top = 64
        Width = 6
        Height = 12
        Caption = '%'
      end
      object Label22: TLabel
        Left = 200
        Top = 88
        Width = 6
        Height = 12
        Caption = '%'
      end
      object sta3Max: TStaticText
        Left = 85
        Top = 14
        Width = 108
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 0
      end
      object sta3RevV: TStaticText
        Left = 84
        Top = 38
        Width = 110
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 1
      end
      object Sta3SendV: TStaticText
        Left = 84
        Top = 62
        Width = 110
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 2
      end
      object sta3Zonghe: TStaticText
        Left = 85
        Top = 86
        Width = 110
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = '0'
        TabOrder = 3
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 432
    Top = 112
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 464
    Top = 96
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 432
    Top = 80
  end
end
