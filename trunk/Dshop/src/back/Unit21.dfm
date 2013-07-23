object Fr_Card: TFr_Card
  Left = 335
  Top = 143
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #35831#21047#21345'...'
  ClientHeight = 82
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 82
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 283
      Height = 76
      Align = alClient
      Color = 15723503
      TabOrder = 0
      object Label2: TLabel
        Left = 53
        Top = 32
        Width = 54
        Height = 12
        Caption = #35831' '#21047' '#21345':'
      end
      object RzEdit1: TRzEdit
        Left = 107
        Top = 29
        Width = 124
        Height = 18
        AutoSize = False
        FrameHotColor = 14593668
        FrameHotTrack = True
        FrameVisible = True
        ImeName = #20013#25991' ('#31616#20307') - '#20840#25340
        MaxLength = 32
        TabOrder = 0
        OnKeyPress = RzEdit1KeyPress
      end
    end
  end
end
