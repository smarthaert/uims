object Form1: TForm1
  Left = 292
  Top = 206
  Width = 488
  Height = 164
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'UrlCheck'
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
  object frequency: TLabel
    Left = 12
    Top = 74
    Width = 84
    Height = 13
    Caption = #30417#25511#39057#29575'('#20998#38047'):'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 12
    Top = 21
    Width = 53
    Height = 13
    Caption = #24453#26816#27979'Url:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 12
    Top = 47
    Width = 88
    Height = 13
    Caption = #25209#22788#29702#25991#20214#36335#24452':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 105
    Top = 16
    Width = 362
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    ParentFont = False
    TabOrder = 0
    Text = 'http://www.qq.com/'
  end
  object Edit2: TEdit
    Left = 105
    Top = 71
    Width = 73
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    TabOrder = 1
    Text = '1'
  end
  object Button1: TButton
    Left = 208
    Top = 102
    Width = 65
    Height = 23
    Caption = #20445#23384#37197#32622
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 105
    Top = 43
    Width = 362
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    ParentFont = False
    TabOrder = 3
    Text = 'C:\Documents and Settings\Administrator\'#26700#38754'\Url'#26816#27979'\Del.bat'
  end
  object cbxWatch: TCheckBox
    Left = 208
    Top = 72
    Width = 73
    Height = 17
    Caption = #30417#25511#20013'...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = cbxWatchClick
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 408
    Top = 80
  end
end
