object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Config'
  ClientHeight = 368
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 73
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'UserName:'
  end
  object Label2: TLabel
    Left = 8
    Top = 30
    Width = 73
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Password:'
  end
  object Label3: TLabel
    Left = 8
    Top = 53
    Width = 73
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Date:'
  end
  object Label4: TLabel
    Left = 8
    Top = 77
    Width = 73
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'CHECHI:'
  end
  object Label5: TLabel
    Left = 287
    Top = 78
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Need , split'
  end
  object Edit1: TEdit
    Left = 87
    Top = 5
    Width = 194
    Height = 21
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    TabOrder = 0
    Text = 'tb_user'
  end
  object Edit2: TEdit
    Left = 87
    Top = 28
    Width = 194
    Height = 21
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    PasswordChar = '*'
    TabOrder = 1
    Text = 'tb_user'
  end
  object Edit4: TEdit
    Left = 87
    Top = 74
    Width = 194
    Height = 21
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    TabOrder = 2
    Text = 'tb_user'
  end
  object Button1: TButton
    Left = 87
    Top = 335
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 335
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
  end
  object CheckBox1: TCheckBox
    Left = 290
    Top = 31
    Width = 55
    Height = 17
    Caption = 'Show'
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 87
    Top = 51
    Width = 194
    Height = 21
    Date = 41298.583141631940000000
    Time = 41298.583141631940000000
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    TabOrder = 6
  end
  object CheckBox2: TCheckBox
    Left = 16
    Top = 144
    Width = 313
    Height = 17
    Caption = #30331#38470#25104#21151#21518#65292#30452#25509#36339#36807#27426#36814#39029#38754#65292#30452#25509#36827#20837#36873#31080#65281
    TabOrder = 7
  end
end
