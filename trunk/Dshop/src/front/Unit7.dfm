object Pos_Setup: TPos_Setup
  Left = 640
  Top = 260
  BorderStyle = bsNone
  Caption = 'Pos_Setup'
  ClientHeight = 257
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 282
    Height = 216
    Align = alTop
    BevelInner = bvLowered
    Color = clBlack
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 33
      Width = 78
      Height = 12
      Caption = #38065#31665#37197#32622#25991#20214':'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 110
      Top = 33
      Width = 48
      Height = 12
      Cursor = crHandPoint
      Caption = #12288#12288#12288#12288
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      Transparent = True
      OnClick = Label2Click
    end
    object Label3: TLabel
      Left = 32
      Top = 59
      Width = 54
      Height = 12
      Caption = #36229#24066#21517#31216':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 32
      Top = 83
      Width = 54
      Height = 12
      Caption = #23459#20256#21475#21495':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 32
      Top = 107
      Width = 54
      Height = 12
      Caption = #22791#27880#31080#39064':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 32
      Top = 131
      Width = 54
      Height = 12
      Caption = #32852#31995#30005#35805':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 44
      Top = 169
      Width = 81
      Height = 22
      Caption = #20445#12288#23384
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 156
      Top = 169
      Width = 81
      Height = 22
      Caption = #36820#12288#22238
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object RzEdit1: TRzEdit
      Left = 88
      Top = 56
      Width = 161
      Height = 20
      Text = #23454#30719#27700#26063#19990#30028
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
      MaxLength = 20
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object RzEdit2: TRzEdit
      Left = 88
      Top = 80
      Width = 161
      Height = 20
      Text = #23454#30719#27700#26063' '#24744#23478#20013#30340#28023#27915#19990#30028
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
      MaxLength = 20
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
    end
    object RzEdit3: TRzEdit
      Left = 88
      Top = 104
      Width = 161
      Height = 20
      Text = #25105#20204#26399#24453#24744#19979#27425#20809#20020
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
      MaxLength = 20
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
    end
    object RzEdit4: TRzEdit
      Left = 88
      Top = 128
      Width = 161
      Height = 20
      Text = '0551-123456'
      Color = clBlack
      Ctl3D = True
      DisabledColor = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      FrameColor = clWhite
      FrameHotColor = 14593668
      FrameHotTrack = True
      FrameVisible = True
      ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
      MaxLength = 15
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = #21069#12288#21488#12288#35774#12288#32622
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = #20223#23435'_GB2312'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object RzFormShape1: TRzFormShape
      Left = 2
      Top = 2
      Width = 278
      Height = 37
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #38065#31665#37197#32622#25991#20214'(*.exe;*.com)|*.exe;*.com|'#26174#31034#25152#26377#25991#20214'(*.*)|*.*'
    Left = 8
    Top = 8
  end
end
