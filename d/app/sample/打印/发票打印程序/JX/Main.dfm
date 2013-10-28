object FrmMain: TFrmMain
  Left = 94
  Top = 82
  BorderStyle = bsSingle
  Caption = '增值税专用发票数据查询'
  ClientHeight = 213
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar1: TStatusBar
    Left = 0
    Top = 193
    Width = 633
    Height = 20
    AutoHint = True
    Panels = <
      item
        Alignment = taCenter
        Width = 200
      end
      item
        Alignment = taCenter
        Text = 'Swink软件出品'
        Width = 200
      end
      item
        Alignment = taCenter
        Width = 200
      end
      item
        Alignment = taCenter
        Width = 200
      end>
    SimplePanel = False
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 633
    Height = 63
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 51
    ButtonWidth = 55
    Caption = 'ToolBar1'
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    EdgeInner = esLowered
    EdgeOuter = esRaised
    Flat = True
    Images = ImageList1
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = '数据查询'
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object ToolButton3: TToolButton
      Left = 55
      Top = 0
      Caption = '参数设置'
      ImageIndex = 2
      OnClick = ToolButton3Click
    end
    object ToolButton2: TToolButton
      Left = 110
      Top = 0
      Caption = '退出程序'
      ImageIndex = 1
      OnClick = ToolButton2Click
    end
  end
  object ImageList1: TImageList
    Height = 32
    Width = 32
    Left = 40
    Top = 66
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 136
    Top = 64
  end
  object Rollup1: TRollup
    isEnabled = True
    isRolledUp = False
    MinHeight = 0
    Left = 8
    Top = 64
  end
end
