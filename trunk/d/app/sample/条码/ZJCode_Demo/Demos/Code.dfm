object Form1: TForm1
  Left = 190
  Top = 105
  Width = 551
  Height = 425
  Caption = 'Code 39 Demos'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 274
    Width = 543
    Height = 124
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 543
      Height = 124
      Align = alClient
      TabOrder = 0
      object Button1: TButton
        Left = 456
        Top = 40
        Width = 75
        Height = 25
        Caption = #25171#21360#26465#30721
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 456
        Top = 65
        Width = 75
        Height = 25
        Caption = #20445#23384#26465#30721
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 456
        Top = 15
        Width = 75
        Height = 25
        Caption = #29983#25104#26465#30721
        TabOrder = 1
        OnClick = Button3Click
      end
      object GroupBox2: TGroupBox
        Left = 9
        Top = 14
        Width = 435
        Height = 101
        Caption = #36873#39033
        TabOrder = 0
        object Label1: TLabel
          Left = 18
          Top = 46
          Width = 24
          Height = 12
          Caption = #30721#20540
        end
        object Label2: TLabel
          Left = 18
          Top = 21
          Width = 24
          Height = 12
          Caption = #30721#21046
        end
        object Label3: TLabel
          Left = 18
          Top = 72
          Width = 24
          Height = 12
          Caption = #35282#24230
        end
        object Label4: TLabel
          Left = 269
          Top = 19
          Width = 24
          Height = 12
          Caption = #39640#24230
        end
        object Label5: TLabel
          Left = 269
          Top = 47
          Width = 24
          Height = 12
          Caption = #23485#26465
        end
        object Label6: TLabel
          Left = 269
          Top = 73
          Width = 24
          Height = 12
          Caption = #31364#26465
        end
        object Label7: TLabel
          Left = 146
          Top = 71
          Width = 24
          Height = 12
          Caption = #23383#21495
        end
        object Edt_CodeStr: TEdit
          Left = 50
          Top = 42
          Width = 201
          Height = 20
          CharCase = ecUpperCase
          MaxLength = 14
          TabOrder = 0
          Text = 'EDT_CODESTR'
          OnKeyPress = Edt_CodeStrKeyPress
        end
        object CBX_CodeMode: TComboBox
          Left = 50
          Top = 16
          Width = 116
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 1
          Text = 'Code 39'
          Items.Strings = (
            'Code 39')
        end
        object Edt_CHeight: TEdit
          Left = 301
          Top = 16
          Width = 121
          Height = 20
          TabOrder = 2
          Text = 'Edt_CHeight'
        end
        object Edt_CWidth: TEdit
          Left = 301
          Top = 42
          Width = 121
          Height = 20
          TabOrder = 3
          Text = 'Edt_CWidth'
        end
        object Edt_CWidthShort: TEdit
          Left = 301
          Top = 69
          Width = 121
          Height = 20
          TabOrder = 4
          Text = 'Edt_CWidthShort'
        end
        object Edt_Size: TEdit
          Left = 175
          Top = 68
          Width = 76
          Height = 20
          TabOrder = 5
          Text = 'Edt_Size'
        end
        object Edt_Corner: TSpinEdit
          Left = 50
          Top = 68
          Width = 82
          Height = 21
          MaxLength = 3
          MaxValue = 360
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object CheckBox1: TCheckBox
          Left = 172
          Top = 17
          Width = 85
          Height = 17
          Caption = #36215#22987#32456#27490#31526
          TabOrder = 7
          OnClick = Button3Click
        end
      end
      object Button4: TButton
        Left = 456
        Top = 90
        Width = 75
        Height = 25
        Caption = #20851#38381
        TabOrder = 4
        OnClick = Button4Click
      end
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 543
    Height = 274
    Align = alClient
    BevelInner = bvSpace
    BevelOuter = bvSpace
    Color = clBtnFace
    ParentColor = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 537
      Height = 252
      PopupMenu = PopupMenu1
      Stretch = True
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 384
    Top = 48
    object N1: TMenuItem
      Caption = #25918#22823
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #32553#23567
      OnClick = N2Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 384
    Top = 80
  end
  object OpenDialog1: TOpenDialog
    Left = 384
    Top = 112
  end
end
