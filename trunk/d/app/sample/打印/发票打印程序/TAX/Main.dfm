object FrmMain: TFrmMain
  Left = 205
  Top = 111
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '海宁市税务师事务所增值税发票结报系统'
  ClientHeight = 329
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar1: TStatusBar
    Left = 0
    Top = 310
    Width = 536
    Height = 19
    Panels = <
      item
        Text = 'Fly Dance Software'
        Width = 120
      end
      item
        Width = 500
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Wallpaper1: TWallpaper
    Left = 0
    Top = 0
    Width = 536
    Height = 310
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Top = 72
    object N1: TMenuItem
      Caption = '业务处理'
      object miJBInput: TMenuItem
        Caption = '结报录入'
        OnClick = miJBInputClick
      end
      object miChargeInput: TMenuItem
        Caption = '收费录入'
        OnClick = miChargeInputClick
      end
      object miEPriseReg: TMenuItem
        Caption = '企业登记'
        OnClick = miEPriseRegClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = '退出系统'
        OnClick = miExitClick
      end
    end
    object N7: TMenuItem
      Caption = '数据查询'
      object miJBQuery: TMenuItem
        Caption = '结报查询'
      end
      object miChargeQuery: TMenuItem
        Caption = '收费查询'
      end
      object miEPriseQuery: TMenuItem
        Caption = '企业查询'
      end
    end
    object N11: TMenuItem
      Caption = '报表打印'
    end
    object N12: TMenuItem
      Caption = '系统设置'
      object miBackGround: TMenuItem
        Caption = '背景设置'
        OnClick = miBackGroundClick
      end
      object N2: TMenuItem
        Caption = '输入法设置'
        OnClick = N2Click
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 32
    Top = 72
  end
  object BackGroundDialog: TOpenPictureDialog
    Left = 64
    Top = 72
  end
end
