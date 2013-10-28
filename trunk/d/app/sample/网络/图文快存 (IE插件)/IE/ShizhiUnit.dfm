object frmShizhi: TfrmShizhi
  Left = 366
  Top = 201
  BorderStyle = bsSingle
  Caption = #22270#25991#24555#23384' ['#35774#32622']'
  ClientHeight = 197
  ClientWidth = 221
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 104
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #20445#23384#36335#24452
  end
  object SpeedButton1: TSpeedButton
    Left = 176
    Top = 120
    Width = 41
    Height = 22
    Caption = #27983#35272
  end
  object SpeedButton2: TSpeedButton
    Left = 72
    Top = 168
    Width = 65
    Height = 22
    Caption = #20445#23384#35774#32622
    OnClick = SpeedButton2Click
  end
  object Bevel1: TBevel
    Left = 6
    Top = 154
    Width = 212
    Height = 5
    Shape = bsTopLine
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 209
    Height = 81
    Caption = #25353#38062#21487#35270#36873#25321
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 8
      Top = 24
      Width = 57
      Height = 17
      Caption = #32593#39029
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 80
      Top = 24
      Width = 57
      Height = 17
      Caption = #25991#26412
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 152
      Top = 24
      Width = 53
      Height = 17
      Caption = #22270#29255
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 8
      Top = 54
      Width = 57
      Height = 17
      Caption = #36873#20013
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 80
      Top = 52
      Width = 57
      Height = 17
      Caption = #38142#25509
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 152
      Top = 52
      Width = 57
      Height = 17
      Caption = #35774#32622
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object Edit1: TEdit
    Left = 8
    Top = 120
    Width = 161
    Height = 21
    TabOrder = 1
  end
end
