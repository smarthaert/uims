object AboutForm: TAboutForm
  Left = 443
  Top = 294
  BorderStyle = bsDialog
  Caption = #27983#35272#22120
  ClientHeight = 212
  ClientWidth = 279
  Color = clWhite
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 7
    Top = 9
    Width = 266
    Height = 160
    Shape = bsFrame
  end
  object LTitle: TLabel
    Left = 8
    Top = 24
    Width = 257
    Height = 12
    Alignment = taCenter
    AutoSize = False
  end
  object LPage: TLabel
    Left = 16
    Top = 72
    Width = 66
    Height = 12
    Cursor = crHandPoint
    Caption = 'http://www.'
    ParentShowHint = False
    ShowHint = True
    OnClick = LPageClick
  end
  object Label4: TLabel
    Left = 16
    Top = 104
    Width = 102
    Height = 12
    Cursor = crArrow
    Caption = #21457#29616'bug'#35831'mailto'#65306
    ParentShowHint = False
    ShowHint = True
  end
  object LVersion: TLabel
    Left = 40
    Top = 48
    Width = 36
    Height = 12
    Caption = #29256#26412#65306
  end
  object Label25: TLabel
    Left = 168
    Top = 144
    Width = 6
    Height = 12
  end
  object Label2: TLabel
    Left = 104
    Top = 183
    Width = 54
    Height = 12
    Caption = '2005-2009'
  end
  object LEmail: TLabel
    Left = 120
    Top = 104
    Width = 6
    Height = 12
    Cursor = crHandPoint
    OnClick = LEmailClick
  end
  object LBrowserName: TLabel
    Left = 8
    Top = 184
    Width = 81
    Height = 12
    Alignment = taCenter
    AutoSize = False
    Caption = 'xxx'
  end
  object LThanks: TLabel
    Left = 16
    Top = 136
    Width = 6
    Height = 12
  end
  object Button2: TButton
    Left = 196
    Top = 177
    Width = 75
    Height = 23
    Caption = #30830#23450
    TabOrder = 0
    OnClick = Button2Click
  end
end
