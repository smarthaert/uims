object Form1: TForm1
  Left = 192
  Top = 107
  Caption = 'Zones & Security Demo'
  ClientHeight = 446
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 553
    Top = 224
    Width = 204
    Height = 13
    Caption = 'Sites or urlpatterns added to selected zone:'
  end
  object Label1: TLabel
    Left = 7
    Top = 389
    Width = 98
    Height = 13
    Caption = 'Current template:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 7
    Top = 410
    Width = 105
    Height = 13
    Caption = 'Minimum template:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 7
    Top = 432
    Width = 109
    Height = 13
    Caption = 'Recomm. template:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 568
    Top = 8
    Width = 88
    Height = 13
    Caption = 'Select Urlzone:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListView1: TListView
    Left = 568
    Top = 24
    Width = 183
    Height = 177
    Columns = <
      item
        AutoSize = True
      end>
    ReadOnly = True
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = ListView1SelectItem
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 537
    Height = 377
    ColCount = 2
    DefaultColWidth = 265
    DefaultRowHeight = 16
    FixedCols = 0
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 552
    Top = 240
    Width = 225
    Height = 193
    ReadOnly = True
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 118
    Top = 385
    Width = 297
    Height = 22
    BevelInner = bvLowered
    TabOrder = 3
    object CurrentImage: TImage
      Left = 5
      Top = 3
      Width = 16
      Height = 16
    end
    object CurrentDisplay: TLabel
      Left = 28
      Top = 5
      Width = 3
      Height = 13
    end
  end
  object Panel2: TPanel
    Left = 118
    Top = 407
    Width = 297
    Height = 22
    BevelInner = bvLowered
    TabOrder = 4
    object MinimumImage: TImage
      Left = 5
      Top = 3
      Width = 16
      Height = 16
    end
    object MinimumDisplay: TLabel
      Left = 28
      Top = 5
      Width = 3
      Height = 13
    end
  end
  object Panel3: TPanel
    Left = 118
    Top = 429
    Width = 297
    Height = 22
    BevelInner = bvLowered
    TabOrder = 5
    object RecommImage: TImage
      Left = 5
      Top = 3
      Width = 16
      Height = 16
    end
    object RecommDisplay: TLabel
      Left = 27
      Top = 5
      Width = 3
      Height = 13
    end
  end
  object Button1: TButton
    Left = 449
    Top = 405
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 6
    OnClick = Button1Click
  end
end
