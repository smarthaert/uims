object Form1: TForm1
  Left = 216
  Top = 228
  Width = 211
  Height = 184
  Caption = 'GetCPUInfo'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 64
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Get!'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 113
    Caption = 'CpuInfo'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 22
      Width = 30
      Height = 12
      Caption = 'Name:'
    end
    object Label2: TLabel
      Left = 8
      Top = 46
      Width = 36
      Height = 12
      Caption = 'Speed:'
    end
    object Label3: TLabel
      Left = 8
      Top = 70
      Width = 30
      Height = 12
      Caption = 'Type:'
    end
    object EditCPUSpeed: TEdit
      Left = 48
      Top = 40
      Width = 121
      Height = 20
      TabOrder = 0
    end
    object CheckBoxMMX: TCheckBox
      Left = 48
      Top = 88
      Width = 73
      Height = 17
      Caption = 'WithMMX'
      TabOrder = 1
    end
    object CheckBoxHasFPU: TCheckBox
      Left = 112
      Top = 88
      Width = 57
      Height = 17
      Caption = 'HasFPU'
      TabOrder = 2
    end
    object EditCPUName: TEdit
      Left = 48
      Top = 16
      Width = 121
      Height = 20
      TabOrder = 3
    end
    object EditCPUType: TEdit
      Left = 48
      Top = 64
      Width = 121
      Height = 20
      TabOrder = 4
    end
  end
end
