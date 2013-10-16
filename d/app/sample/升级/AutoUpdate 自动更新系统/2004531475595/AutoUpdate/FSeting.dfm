object frmSeting: TfrmSeting
  Left = 307
  Top = 249
  BorderStyle = bsDialog
  Caption = #26356#26032#35774#32622
  ClientHeight = 262
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 425
    Height = 201
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #26356#26032#26381#21153#22120#35774#32622
      object Label1: TLabel
        Left = 16
        Top = 32
        Width = 96
        Height = 12
        Caption = #26356#26032#26381#21153#22120#22320#22336#65306
      end
      object txtServer: TEdit
        Left = 112
        Top = 27
        Width = 289
        Height = 20
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 16
        Top = 64
        Width = 385
        Height = 97
        Caption = #30331#38470#35774#32622
        TabOrder = 1
        object Label2: TLabel
          Left = 23
          Top = 64
          Width = 72
          Height = 12
          Caption = #30331#38470#29992#25143#21517#65306
        end
        object Label3: TLabel
          Left = 204
          Top = 61
          Width = 60
          Height = 12
          Caption = #30331#38470#21475#20196#65306
        end
        object chkNeedLogin: TCheckBox
          Left = 21
          Top = 24
          Width = 137
          Height = 17
          Caption = #26381#21153#22120#38656#35201#30331#38470
          TabOrder = 0
          OnClick = chkNeedLoginClick
        end
        object txtLoginUser: TEdit
          Left = 94
          Top = 58
          Width = 95
          Height = 20
          Enabled = False
          TabOrder = 1
        end
        object txtLoginPass: TEdit
          Left = 278
          Top = 56
          Width = 92
          Height = 20
          Enabled = False
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #32593#32476#37197#32622
      ImageIndex = 1
      TabVisible = False
      object GroupBox2: TGroupBox
        Left = 32
        Top = 56
        Width = 361
        Height = 81
        Caption = 'Ftp'#20195#29702#26381#21153#22120#35774#32622
        TabOrder = 0
        object Label4: TLabel
          Left = 16
          Top = 40
          Width = 36
          Height = 12
          Caption = #22320#22336#65306
        end
        object Label5: TLabel
          Left = 216
          Top = 40
          Width = 36
          Height = 12
          Caption = #31471#21475#65306
        end
        object txtProxyServer: TEdit
          Left = 56
          Top = 35
          Width = 153
          Height = 20
          Enabled = False
          TabOrder = 0
        end
        object txtProxyPort: TEdit
          Left = 256
          Top = 34
          Width = 82
          Height = 20
          Enabled = False
          TabOrder = 1
        end
      end
      object chkUseProxy: TCheckBox
        Left = 40
        Top = 24
        Width = 177
        Height = 17
        Caption = #36890#36807#20195#29702#26381#21153#22120#36830#25509
        TabOrder = 1
        OnClick = chkUseProxyClick
      end
    end
  end
  object Button1: TButton
    Left = 216
    Top = 224
    Width = 99
    Height = 25
    Caption = #20445#23384
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 328
    Top = 224
    Width = 99
    Height = 25
    Caption = #21462#28040
    TabOrder = 2
    OnClick = Button2Click
  end
end
