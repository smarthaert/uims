object FrmMain: TFrmMain
  Left = 399
  Top = 340
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #39564#35777#30721#35782#21035#25511#20214'DEMO'
  ClientHeight = 245
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lbl1: TLabel
    Left = 8
    Top = 12
    Width = 72
    Height = 12
    Caption = #39564#35777#30721#26679#24335#65306
  end
  object ImgDemo: TImage
    Left = 88
    Top = 136
    Width = 105
    Height = 25
    AutoSize = True
  end
  object Label1: TLabel
    Left = 8
    Top = 180
    Width = 60
    Height = 12
    Caption = #35782#21035#32467#26524#65306
  end
  object Image1: TImage
    Left = 208
    Top = 136
    Width = 105
    Height = 25
    AutoSize = True
  end
  object Label2: TLabel
    Left = 8
    Top = 88
    Width = 72
    Height = 12
    Caption = #39564#35777#30721#21517#31216#65306
  end
  object Label3: TLabel
    Left = 8
    Top = 112
    Width = 66
    Height = 12
    Caption = #39564#35777#30721'URL'#65306
  end
  object LbName: TLabel
    Left = 88
    Top = 88
    Width = 6
    Height = 12
  end
  object Label4: TLabel
    Left = 8
    Top = 144
    Width = 72
    Height = 12
    Caption = #39564#35777#30721#22270#24418#65306
  end
  object CbStyle: TComboBox
    Left = 88
    Top = 8
    Width = 73
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 2
    OnChange = CbStyleChange
  end
  object TxtVerifyCode: TEdit
    Left = 88
    Top = 176
    Width = 105
    Height = 20
    ReadOnly = True
    TabOrder = 4
  end
  object CmdExec: TButton
    Left = 96
    Top = 208
    Width = 75
    Height = 25
    Caption = #25191#34892#35782#21035
    TabOrder = 5
    OnClick = CmdExecClick
  end
  object CmdBrowser: TButton
    Left = 176
    Top = 208
    Width = 75
    Height = 25
    Caption = #27983#35272'...'
    TabOrder = 6
    OnClick = CmdBrowserClick
  end
  object CmdAbout: TButton
    Left = 8
    Top = 208
    Width = 75
    Height = 25
    Caption = #20851#20110
    TabOrder = 1
    OnClick = CmdAboutClick
  end
  object TxtURL: TEdit
    Left = 88
    Top = 108
    Width = 201
    Height = 20
    Enabled = False
    TabOrder = 3
  end
  object CmdGet: TButton
    Left = 296
    Top = 107
    Width = 25
    Height = 22
    Caption = 'Get'
    TabOrder = 7
    OnClick = CmdGetClick
  end
  object GrMode: TRadioGroup
    Left = 8
    Top = 32
    Width = 305
    Height = 41
    Caption = #29305#24449#24211#21152#36733#27169#24335
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'XML '#25991#26723
      'XML '#36164#28304'DLL'
      'XML '#27969)
    TabOrder = 0
    OnClick = GrModeClick
  end
  object OD: TOpenDialog
    Filter = 
      #25903#25345#30340#26684#24335' (*.bmp;*.jpg;*.jpeg;*.png;*.gif)|*.bmp;*.jpg;*.jpeg;*.png;' +
      '*.gif'
    Left = 232
    Top = 176
  end
end
