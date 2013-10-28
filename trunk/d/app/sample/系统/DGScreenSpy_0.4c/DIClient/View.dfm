object frmView: TfrmView
  Left = 237
  Top = 122
  Width = 480
  Height = 320
  Caption = 'DGScreenSpy - Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object sbA: TScrollBox
    Left = 0
    Top = 0
    Width = 472
    Height = 293
    Align = alClient
    BorderStyle = bsNone
    Color = clBlack
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 0
    object pbA: TPaintBox
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      OnMouseDown = pbAMouseDown
      OnMouseMove = pbAMouseMove
      OnMouseUp = pbAMouseUp
      OnPaint = pbAPaint
    end
  end
end
