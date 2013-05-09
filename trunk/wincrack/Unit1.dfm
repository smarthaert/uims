object Form1: TForm1
  Left = 222
  Top = 120
  BorderStyle = bsSingle
  Caption = #22810#32447#31243'WINDWOS'#21475#20196#25195#25551#22120
  ClientHeight = 258
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 28
    Width = 41
    Height = 13
    AutoSize = False
    Caption = #29992#25143#21517
    Transparent = True
  end
  object Label3: TLabel
    Left = 8
    Top = 50
    Width = 41
    Height = 17
    AutoSize = False
    Caption = 'IP'
    Transparent = True
  end
  object Button1: TButton
    Left = 8
    Top = 223
    Width = 193
    Height = 24
    Caption = #24320' '#22987' '#25195' '#25551
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 56
    Top = 25
    Width = 145
    Height = 19
    Color = clGradientActiveCaption
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Text = 'administrator'
  end
  object Edit3: TEdit
    Left = 56
    Top = 48
    Width = 145
    Height = 19
    Color = clGradientActiveCaption
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    Text = '127.0.0.1'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 74
    Width = 193
    Height = 140
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 208
    Top = 19
    Width = 121
    Height = 231
    Caption = #23494#30721#23383#20856
    TabOrder = 4
    object Memo1: TMemo
      Left = 8
      Top = 16
      Width = 105
      Height = 208
      Ctl3D = False
      ParentCtl3D = False
      PopupMenu = PopupMenu1
      TabOrder = 0
    end
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 5
    Width = 321
    Height = 12
    TabOrder = 5
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 112
    object N1: TMenuItem
      Caption = #23548#20837
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #28165#31354
      OnClick = N2Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 248
    Top = 152
  end
end
