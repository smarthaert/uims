object FRM_Date: TFRM_Date
  Left = 568
  Top = 125
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #20892#21382#26085#21382#34920' For 2007 '#65288#24352#27704#29983#20462#25913#25972#29702#65289
  ClientHeight = 300
  ClientWidth = 312
  Color = clWhite
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 312
    Height = 300
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 312
      Height = 300
      Align = alClient
      ExplicitHeight = 299
    end
    object Label20: TLabel
      Left = 0
      Top = 56
      Width = 313
      Height = 72
      Alignment = taCenter
      AutoSize = False
      Caption = '2002'
      Font.Charset = ANSI_CHARSET
      Font.Color = 14543103
      Font.Height = -64
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label16: TLabel
      Left = 0
      Top = 98
      Width = 313
      Height = 134
      Alignment = taCenter
      AutoSize = False
      Caption = '6'
      Font.Charset = ANSI_CHARSET
      Font.Color = 15461355
      Font.Height = -120
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Image1: TImage
      Left = 9
      Top = 56
      Width = 297
      Height = 191
    end
    object shp1: TShape
      Left = 0
      Top = 247
      Width = 312
      Height = 52
      Brush.Color = clSkyBlue
    end
    object Shape2: TShape
      Left = 12
      Top = 56
      Width = 38
      Height = 30
      Brush.Color = 8512126
      Pen.Color = clGreen
    end
    object day1: TLabel
      Left = 14
      Top = 56
      Width = 36
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = '22'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -14
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Visible = False
    end
    object image_month: TImage
      Left = 0
      Top = 0
      Width = 95
      Height = 40
      PopupMenu = MenuMonth
    end
    object image_year: TImage
      Left = 94
      Top = 0
      Width = 154
      Height = 40
      PopupMenu = MenuYear
    end
    object Bevel2: TBevel
      Left = 9
      Top = 46
      Width = 297
      Height = 10
      Shape = bsBottomLine
    end
    object Label1: TLabel
      Left = 118
      Top = -1
      Width = 76
      Height = 41
      Alignment = taCenter
      Caption = '2002'
      Color = 15268607
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      PopupMenu = MenuYear
      ShowHint = False
      Transparent = True
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 19
      Top = 40
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #26143#26399#26085
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 59
      Top = 40
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #26143#26399#19968
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 99
      Top = 40
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #26143#26399#20108
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 179
      Top = 40
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #26143#26399#22235
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 139
      Top = 40
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #26143#26399#19977
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 259
      Top = 40
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #26143#26399#20845
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 219
      Top = 40
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #26143#26399#20116
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Cnday: TLabel
      Left = 13
      Top = 73
      Width = 36
      Height = 12
      Alignment = taCenter
      AutoSize = False
      Caption = #21021#19968
      Font.Charset = GB2312_CHARSET
      Font.Color = 16384
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Visible = False
      OnClick = CndayClick
    end
    object Label17: TLabel
      Left = 14
      Top = 3
      Width = 36
      Height = 37
      Alignment = taCenter
      Caption = '12'
      Font.Charset = ANSI_CHARSET
      Font.Color = 12615808
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = MenuMonth
      Transparent = True
    end
    object Label18: TLabel
      Left = 64
      Top = 20
      Width = 15
      Height = 14
      Caption = #26376
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = MenuMonth
    end
    object Label19: TLabel
      Left = 210
      Top = 17
      Width = 15
      Height = 14
      Caption = #24180
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = MenuYear
    end
    object Label21: TLabel
      Left = 219
      Top = 278
      Width = 36
      Height = 12
      Alignment = taCenter
      Caption = #30002#26411#40857
      Color = clFuchsia
      Font.Charset = GB2312_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label22: TLabel
      Left = 140
      Top = 278
      Width = 24
      Height = 12
      Alignment = taCenter
      Caption = #26411#40857
      Color = clFuchsia
      Font.Charset = GB2312_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl1: TLabel
      Left = 13
      Top = 256
      Width = 24
      Height = 12
      Alignment = taCenter
      Caption = 'lbl1'
      Color = clFuchsia
      Font.Charset = GB2312_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl2: TLabel
      Left = 9
      Top = 278
      Width = 24
      Height = 12
      Alignment = taCenter
      Caption = 'lbl2'
      Color = clFuchsia
      Font.Charset = GB2312_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl3: TLabel
      Left = 219
      Top = 256
      Width = 24
      Height = 12
      Alignment = taCenter
      Caption = 'lbl3'
      Color = clFuchsia
      Font.Charset = GB2312_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl4: TLabel
      Left = 271
      Top = 19
      Width = 24
      Height = 12
      Alignment = taCenter
      Caption = #20170#22825
      OnClick = lbl4Click
    end
    object image_today: TImage
      Left = 247
      Top = 0
      Width = 65
      Height = 40
      OnClick = image_todayClick
    end
  end
  object MenuMonth: TPopupMenu
    Left = 267
    Top = 101
    object MenuMonth_1: TMenuItem
      Tag = 1
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_2: TMenuItem
      Tag = 2
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_3: TMenuItem
      Tag = 3
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_4: TMenuItem
      Tag = 4
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_5: TMenuItem
      Tag = 5
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_6: TMenuItem
      Tag = 6
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_7: TMenuItem
      Tag = 7
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_8: TMenuItem
      Tag = 8
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_9: TMenuItem
      Tag = 9
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_10: TMenuItem
      Tag = 10
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_11: TMenuItem
      Tag = 11
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
    object MenuMonth_12: TMenuItem
      Tag = 12
      Caption = #19968#26376
      OnClick = MenuMonth_1Click
    end
  end
  object MenuYear: TPopupMenu
    Left = 267
    Top = 69
  end
end
