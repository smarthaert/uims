object GroupForm: TGroupForm
  Left = 351
  Top = 205
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32676#32452#65306
  ClientHeight = 350
  ClientWidth = 576
  Color = 15263976
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 209
    Height = 350
    Align = alLeft
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 60
      Height = 12
      Caption = #24403#21069#32676#32452#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object SBCreateNewGroup: TSpeedButton
      Left = 96
      Top = 312
      Width = 49
      Height = 25
      Caption = #26032#24314#32452
      OnClick = SBCreateNewGroupClick
    end
    object SBDeleteGroup: TSpeedButton
      Left = 144
      Top = 312
      Width = 49
      Height = 25
      Caption = #21024#38500#32452
      OnClick = SBDeleteGroupClick
    end
    object CLBox1: TCheckListBox
      Left = 8
      Top = 32
      Width = 185
      Height = 273
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = -1
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      TabOrder = 0
      OnClick = CLBox1Click
    end
    object ENewGroup: TEdit
      Left = 8
      Top = 312
      Width = 81
      Height = 20
      TabOrder = 1
      OnKeyPress = ENewGroupKeyPress
    end
  end
  object Panel2: TPanel
    Left = 209
    Top = 0
    Width = 367
    Height = 350
    Align = alClient
    ParentColor = True
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 264
      Width = 60
      Height = 12
      Caption = #32593#31449#21517#31216#65306
    end
    object Label3: TLabel
      Left = 16
      Top = 288
      Width = 54
      Height = 12
      Caption = 'URL'#22320#22336#65306
    end
    object SBAddToCurrentGroup: TSpeedButton
      Left = 176
      Top = 312
      Width = 83
      Height = 25
      Caption = #28155#21152#21040#24403#21069#32452
      OnClick = SBAddToCurrentGroupClick
    end
    object SBDeleteCurrentData: TSpeedButton
      Left = 96
      Top = 312
      Width = 83
      Height = 25
      Caption = #21024#38500#24403#21069#25968#25454
      OnClick = SBDeleteCurrentDataClick
    end
    object SBEditCurrentData: TSpeedButton
      Left = 14
      Top = 312
      Width = 83
      Height = 25
      Caption = #32534#36753#24403#21069#25968#25454
      OnClick = SBEditCurrentDataClick
    end
    object SpeedButton1: TSpeedButton
      Left = 312
      Top = 312
      Width = 43
      Height = 25
      Caption = #21462#28040
      OnClick = SpeedButton1Click
    end
    object SBOK: TSpeedButton
      Left = 264
      Top = 312
      Width = 43
      Height = 25
      Caption = #30830#23450
      OnClick = SBOKClick
    end
    object ListBox: TListBox
      Left = 16
      Top = 16
      Width = 337
      Height = 233
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 12
      MultiSelect = True
      ParentFont = False
      TabOrder = 0
      OnDblClick = ListBoxDblClick
    end
    object EStationName: TEdit
      Left = 80
      Top = 256
      Width = 273
      Height = 20
      TabOrder = 1
      OnKeyPress = EStationNameKeyPress
    end
    object EURLAddress: TEdit
      Left = 80
      Top = 280
      Width = 273
      Height = 20
      TabOrder = 2
      OnKeyPress = EURLAddressKeyPress
    end
  end
end
