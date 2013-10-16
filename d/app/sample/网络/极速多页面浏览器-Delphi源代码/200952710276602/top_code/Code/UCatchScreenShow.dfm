object CatchScreenShowForm: TCatchScreenShowForm
  Left = 296
  Top = 269
  BorderIcons = []
  BorderStyle = bsNone
  Caption = #21306#22495#25235#22270#31383#21475'  '#28857#20987#40736#26631#24038#38190#24182#25289#20280#36827#34892#25235#22270','#20877#27425#21333#20987#40736#26631#24038#38190#23436#25104#25235#22270#24182#23558#22270#29255#25335#36125#21040#21098#36148#26495'.'
  ClientHeight = 341
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ChildImage: TImage
    Left = 0
    Top = 0
    Width = 536
    Height = 341
    Align = alClient
    OnMouseDown = ChildImageMouseDown
    OnMouseMove = ChildImageMouseMove
  end
  object ChildTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = ChildTimerTimer
    Left = 104
    Top = 56
  end
  object SaveDialog1: TSaveDialog
    Filter = #22270#29255#25991#20214'(*.jpg;*.bmp)|*.jpg;*.bmp|'#25152#26377#25991#20214'(*.*)|*.*'
    Left = 208
    Top = 104
  end
end
