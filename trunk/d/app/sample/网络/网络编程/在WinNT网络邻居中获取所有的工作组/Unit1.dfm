object Form1: TForm1
  Left = 218
  Top = 158
  Width = 566
  Height = 410
  Caption = 'Form1'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 558
    Height = 383
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 8
      Top = 0
      Width = 265
      Height = 377
      Caption = #26041#27861#19968
      TabOrder = 0
      object TreeView1: TTreeView
        Left = 8
        Top = 16
        Width = 249
        Height = 321
        Indent = 19
        TabOrder = 0
      end
      object Button1: TButton
        Left = 96
        Top = 344
        Width = 75
        Height = 25
        Caption = 'Go'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object GroupBox2: TGroupBox
      Left = 280
      Top = 0
      Width = 273
      Height = 377
      Caption = #26041#27861#20108
      TabOrder = 1
      object Button2: TButton
        Left = 96
        Top = 344
        Width = 75
        Height = 25
        Caption = 'Go'
        TabOrder = 0
        OnClick = Button2Click
      end
      object Memo1: TMemo
        Left = 8
        Top = 16
        Width = 257
        Height = 321
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
  end
end
