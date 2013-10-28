object Form1: TForm1
  Left = 179
  Top = 145
  Width = 518
  Height = 273
  Caption = #32593#21345#25511#21046
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 40
    Top = 188
    Width = 75
    Height = 25
    Caption = #33719#21462#32593#21345
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 225
    Height = 169
    Caption = #24403#21069#32593#21345#21015#34920
    TabOrder = 1
    object MacList: TListBox
      Left = 8
      Top = 16
      Width = 209
      Height = 145
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 240
    Top = 8
    Width = 257
    Height = 169
    Caption = #26102#38388#25511#21046
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 55
      Width = 60
      Height = 13
      Caption = #20851#38381#26102#38388#65306
    end
    object Label2: TLabel
      Left = 12
      Top = 93
      Width = 60
      Height = 13
      Caption = #24320#22987#26102#38388#65306
    end
    object Label3: TLabel
      Left = 12
      Top = 25
      Width = 60
      Height = 13
      Caption = #21551#21160#26102#38388#65306
    end
    object Label4: TLabel
      Left = 84
      Top = 25
      Width = 31
      Height = 13
      Caption = 'Label4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object begintime: TDateTimePicker
      Left = 168
      Top = 50
      Width = 73
      Height = 21
      Date = 40170.430309780100000000
      Time = 40170.430309780100000000
      DateMode = dmUpDown
      Kind = dtkTime
      TabOrder = 0
    end
    object endtime: TDateTimePicker
      Left = 168
      Top = 87
      Width = 73
      Height = 21
      Date = 40170.430309780100000000
      Time = 40170.430309780100000000
      DateMode = dmUpDown
      Kind = dtkTime
      TabOrder = 1
    end
    object Button2: TButton
      Left = 16
      Top = 127
      Width = 81
      Height = 33
      Caption = #21551#21160#35774#32622
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 160
      Top = 127
      Width = 81
      Height = 33
      Caption = #20851#38381#35774#32622
      Enabled = False
      TabOrder = 3
      OnClick = Button3Click
    end
    object beginday: TDateTimePicker
      Left = 74
      Top = 50
      Width = 81
      Height = 21
      Date = 40170.643833726850000000
      Time = 40170.643833726850000000
      TabOrder = 4
    end
    object endday: TDateTimePicker
      Left = 75
      Top = 87
      Width = 81
      Height = 21
      Date = 40170.644154004630000000
      Time = 40170.644154004630000000
      TabOrder = 5
    end
  end
  object Button4: TButton
    Left = 204
    Top = 188
    Width = 75
    Height = 25
    Caption = #31435#21363#31105#29992
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 368
    Top = 188
    Width = 75
    Height = 25
    Caption = #31435#21363#21551#29992
    TabOrder = 4
    OnClick = Button5Click
  end
  object MacStatusBar: TStatusBar
    Left = 0
    Top = 220
    Width = 510
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object MacTimer: TTimer
    Enabled = False
    OnTimer = MacTimerTimer
    Left = 272
    Top = 184
  end
end
