object FrmSetup: TFrmSetup
  Left = 186
  Top = 63
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #35774#32622
  ClientHeight = 351
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lblJF: TLabel
    Left = 68
    Top = 20
    Width = 102
    Height = 12
    Caption = #27599#26376#24320#22987#35745#36153#26085#26399':'
  end
  object lblMonthTime: TLabel
    Left = 68
    Top = 50
    Width = 78
    Height = 12
    Caption = #27599#26376#19978#32593#26102#38480':'
  end
  object lblHour1: TLabel
    Left = 320
    Top = 50
    Width = 24
    Height = 12
    Caption = #23567#26102
  end
  object lblDateLimit: TLabel
    Left = 68
    Top = 80
    Width = 78
    Height = 12
    Caption = #27599#26085#19978#32593#26102#38480':'
  end
  object lblHour2: TLabel
    Left = 320
    Top = 80
    Width = 24
    Height = 12
    Caption = #23567#26102
  end
  object edtJFDate: TEdit
    Left = 176
    Top = 16
    Width = 121
    Height = 20
    TabOrder = 0
    Text = '21'
  end
  object udnMonthTime: TUpDown
    Left = 297
    Top = 16
    Width = 15
    Height = 20
    Associate = edtJFDate
    Min = 1
    Max = 31
    Position = 21
    TabOrder = 1
    Wrap = False
  end
  object edtTimeLimit: TEdit
    Left = 176
    Top = 46
    Width = 121
    Height = 20
    TabOrder = 2
    Text = '120'
  end
  object udnTimeLimit: TUpDown
    Left = 297
    Top = 46
    Width = 15
    Height = 20
    Associate = edtTimeLimit
    Min = 0
    Max = 744
    Position = 120
    TabOrder = 3
    Wrap = False
  end
  object edtDateLimit: TEdit
    Left = 176
    Top = 76
    Width = 121
    Height = 20
    TabOrder = 4
    Text = '5'
  end
  object udnDateLimit: TUpDown
    Left = 297
    Top = 76
    Width = 15
    Height = 20
    Associate = edtDateLimit
    Min = 0
    Max = 24
    Position = 5
    TabOrder = 5
    Wrap = False
  end
  object gbxOther: TGroupBox
    Left = 66
    Top = 114
    Width = 283
    Height = 49
    Caption = #20854#20182#35774#32622
    TabOrder = 6
    object cbxDropTransparency: TCheckBox
      Left = 12
      Top = 18
      Width = 121
      Height = 17
      Caption = #25302#25918#31383#21475#36879#26126#26174#31034
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object gbxOverTime: TGroupBox
    Left = 66
    Top = 172
    Width = 283
    Height = 49
    Caption = #36229#26102#25253#35686
    TabOrder = 7
    object cbxSound: TCheckBox
      Left = 10
      Top = 20
      Width = 97
      Height = 17
      Caption = #22768#38899
      TabOrder = 0
      OnClick = cbxSoundClick
    end
    object cbxForm: TCheckBox
      Left = 154
      Top = 20
      Width = 97
      Height = 17
      Caption = #24377#20986#31383#21475
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object gbxSound: TGroupBox
    Left = 66
    Top = 228
    Width = 283
    Height = 81
    Caption = #22768#38899#36873#39033
    Enabled = False
    TabOrder = 8
    object Label1: TLabel
      Left = 10
      Top = 40
      Width = 102
      Height = 12
      Caption = #25351#23450#22768#38899#25991#20214#36335#24452':'
    end
    object cbxDefaultSound: TCheckBox
      Left = 10
      Top = 18
      Width = 113
      Height = 13
      Caption = #20351#29992#40664#35748#22768#38899
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = cbxDefaultSoundClick
    end
    object edtSoundPath: TEdit
      Left = 10
      Top = 56
      Width = 241
      Height = 20
      Enabled = False
      TabOrder = 1
    end
    object btnOpenSound: TButton
      Left = 254
      Top = 54
      Width = 25
      Height = 23
      Caption = '...'
      Enabled = False
      TabOrder = 2
      OnClick = btnOpenSoundClick
    end
  end
  object btnOK: TButton
    Left = 66
    Top = 318
    Width = 75
    Height = 27
    Caption = #30830#23450
    TabOrder = 9
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 171
    Top = 318
    Width = 75
    Height = 27
    Caption = #21462#28040
    TabOrder = 10
    OnClick = btnCancelClick
  end
  object btnDefault: TButton
    Left = 276
    Top = 318
    Width = 75
    Height = 27
    Caption = #20351#29992#40664#35748#20540
    TabOrder = 11
    OnClick = btnDefaultClick
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'wav'
    Filter = 'WAV Files|*.wav'
    Left = 374
    Top = 318
  end
end
