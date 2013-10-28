object Form1: TForm1
  Left = 320
  Top = 245
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #19975#24180#21382
  ClientHeight = 206
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 359
    Height = 162
    Align = alClient
    ColCount = 7
    Ctl3D = False
    DefaultColWidth = 50
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 7
    ParentCtl3D = False
    ScrollBars = ssNone
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 162
    Width = 359
    Height = 44
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 168
      Top = 16
      Width = 100
      Height = 13
      AutoSize = False
    end
    object Label2: TLabel
      Left = 67
      Top = 16
      Width = 27
      Height = 13
      AutoSize = False
      Caption = #24180'  '
    end
    object Label3: TLabel
      Left = 148
      Top = 16
      Width = 27
      Height = 13
      AutoSize = False
      Caption = #26376'  '
    end
    object ComboBox1: TComboBox
      Left = 83
      Top = 13
      Width = 61
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object MaskEdit1: TMaskEdit
      Left = 8
      Top = 13
      Width = 53
      Height = 21
      EditMask = '!0000;1;_'
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      MaxLength = 4
      TabOrder = 1
      Text = '    '
    end
    object Button1: TButton
      Left = 279
      Top = 11
      Width = 75
      Height = 23
      Caption = #36864#20986
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
