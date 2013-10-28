object Form3: TForm3
  Left = 313
  Top = 209
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '参数设置'
  ClientHeight = 213
  ClientWidth = 397
  Color = cl3DLight
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object SpeedButton2: TSpeedButton
    Left = 12
    Top = 180
    Width = 80
    Height = 24
    Caption = '默认值'
    Flat = True
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 216
    Top = 180
    Width = 80
    Height = 24
    Caption = '确  定'
    Flat = True
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 304
    Top = 180
    Width = 80
    Height = 24
    Caption = '放  弃'
    Flat = True
    OnClick = SpeedButton4Click
  end
  object Label6: TLabel
    Left = 104
    Top = 192
    Width = 102
    Height = 12
    Caption = '水石工作室 张长安'
    Font.Charset = GB2312_CHARSET
    Font.Color = clSilver
    Font.Height = -12
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
  end
  object PageControl1: TPageControl
    Left = 10
    Top = 8
    Width = 377
    Height = 165
    ActivePage = TabSheet2
    MultiLine = True
    OwnerDraw = True
    TabHeight = 20
    TabOrder = 0
    TabWidth = 83
    object TabSheet1: TTabSheet
      Caption = '报时设置'
      object Bevel3: TBevel
        Left = 8
        Top = 4
        Width = 353
        Height = 121
        Shape = bsFrame
        Style = bsRaised
      end
      object Label9: TLabel
        Left = 144
        Top = 40
        Width = 12
        Height = 16
        Caption = '...'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton6: TSpeedButton
        Left = 138
        Top = 38
        Width = 25
        Height = 25
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton6Click
      end
      object SpeedButton7: TSpeedButton
        Left = 326
        Top = 59
        Width = 25
        Height = 25
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000004000
          000080000000FF000000002000004020000080200000FF200000004000004040
          000080400000FF400000006000004060000080600000FF600000008000004080
          000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
          000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
          200080002000FF002000002020004020200080202000FF202000004020004040
          200080402000FF402000006020004060200080602000FF602000008020004080
          200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
          200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
          400080004000FF004000002040004020400080204000FF204000004040004040
          400080404000FF404000006040004060400080604000FF604000008040004080
          400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
          400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
          600080006000FF006000002060004020600080206000FF206000004060004040
          600080406000FF406000006060004060600080606000FF606000008060004080
          600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
          600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
          800080008000FF008000002080004020800080208000FF208000004080004040
          800080408000FF408000006080004060800080608000FF608000008080004080
          800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
          800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
          A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
          A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
          A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
          A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
          C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
          C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
          C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
          C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
          FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
          FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
          FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
          FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00DBDBDBDBDBDB
          DB0000DBDBDBDBDBDBDBDBDBDBDBDBDB00900092DBDBDBDBDBDBDBDBDBDBDB00
          9000DBDB92DBDBDB92DBDBDBDBDB00909292FFFF92DBDB92DBDBDBDBDB0090FC
          00DBFFFF92DB92DBDBDBDB000090FCFF00DBFFFF92DBDBDBDBDB009092FCFFFC
          0000FFFF92DBDBDBDBDB90FCDBFFFCFF009200FF92DB9292929290FCDBFCFFFC
          00DB00FF92DBDBDBDBDB90FFDBFFFCFF0000FFFF92DBDBDBDBDBDB9090FCFFFC
          00DBFFFF92DB92DBDBDBDBDBDB90FCFF00DBFFFF92DBDB92DBDBDBDBDBDB90FC
          9292DBFF92DBDBDB92DBDBDBDBDBDB90FC00DBDBDBDBDBDBDBDBDBDBDBDBDBDB
          90920092DBDBDBDBDBDBDBDBDBDBDBDBDB0000DBDBDBDBDBDBDB}
        ParentFont = False
        OnClick = SpeedButton7Click
      end
      object SpeedButton9: TSpeedButton
        Left = 326
        Top = 89
        Width = 25
        Height = 25
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000004000
          000080000000FF000000002000004020000080200000FF200000004000004040
          000080400000FF400000006000004060000080600000FF600000008000004080
          000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
          000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
          200080002000FF002000002020004020200080202000FF202000004020004040
          200080402000FF402000006020004060200080602000FF602000008020004080
          200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
          200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
          400080004000FF004000002040004020400080204000FF204000004040004040
          400080404000FF404000006040004060400080604000FF604000008040004080
          400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
          400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
          600080006000FF006000002060004020600080206000FF206000004060004040
          600080406000FF406000006060004060600080606000FF606000008060004080
          600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
          600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
          800080008000FF008000002080004020800080208000FF208000004080004040
          800080408000FF408000006080004060800080608000FF608000008080004080
          800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
          800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
          A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
          A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
          A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
          A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
          C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
          C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
          C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
          C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
          FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
          FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
          FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
          FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00DBDBDBDBDBDB
          DB0000DBDBDBDBDBDBDBDBDBDBDBDBDB00900092DBDBDBDBDBDBDBDBDBDBDB00
          9000DBDB92DBDBDB92DBDBDBDBDB00909292FFFF92DBDB92DBDBDBDBDB0090FC
          00DBFFFF92DB92DBDBDBDB000090FCFF00DBFFFF92DBDBDBDBDB009092FCFFFC
          0000FFFF92DBDBDBDBDB90FCDBFFFCFF009200FF92DB9292929290FCDBFCFFFC
          00DB00FF92DBDBDBDBDB90FFDBFFFCFF0000FFFF92DBDBDBDBDBDB9090FCFFFC
          00DBFFFF92DB92DBDBDBDBDBDB90FCFF00DBFFFF92DBDB92DBDBDBDBDBDB90FC
          9292DBFF92DBDBDB92DBDBDBDBDBDB90FC00DBDBDBDBDBDBDBDBDBDBDBDBDBDB
          90920092DBDBDBDBDBDBDBDBDBDBDBDBDB0000DBDBDBDBDBDBDB}
        ParentFont = False
        OnClick = SpeedButton9Click
      end
      object CheckBox8: TCheckBox
        Left = 32
        Top = 16
        Width = 121
        Height = 21
        Caption = '提醒窗口自动关闭'
        TabOrder = 0
        OnClick = CheckBox8Click
      end
      object CheckBox9: TCheckBox
        Left = 32
        Top = 44
        Width = 105
        Height = 17
        Caption = '提醒时播放声音'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox9Click
      end
      object Edit6: TEdit
        Left = 52
        Top = 64
        Width = 269
        Height = 20
        ReadOnly = True
        TabOrder = 2
      end
      object Panel4: TPanel
        Left = 172
        Top = 11
        Width = 173
        Height = 29
        BevelOuter = bvNone
        Enabled = False
        ParentColor = True
        TabOrder = 3
        object Label8: TLabel
          Left = 109
          Top = 9
          Width = 48
          Height = 12
          Caption = '秒后消失'
        end
        object Label7: TLabel
          Left = 5
          Top = 9
          Width = 60
          Height = 12
          Caption = '窗口在显示'
        end
        object MaskEdit3: TMaskEdit
          Left = 68
          Top = 5
          Width = 37
          Height = 20
          EditMask = '!9;1; '
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = '宋体'
          Font.Style = []
          MaxLength = 1
          ParentFont = False
          TabOrder = 0
          Text = '5'
        end
      end
      object ComboBox1: TComboBox
        Left = 132
        Top = 92
        Width = 189
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 4
        Items.Strings = (
          'psOK'
          'psError'
          'psWelcome'
          'psEmergency'
          'psWrong'
          'psCall'
          'psOfficial'
          'psDaze'
          'psFall'
          'psChord'
          'psWhisle'
          'psHanging'
          'psClimb'
          '')
      end
      object CheckBox7: TCheckBox
        Left = 32
        Top = 92
        Width = 89
        Height = 17
        Caption = 'PC喇叭发声'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = CheckBox9Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = '启动设置'
      ImageIndex = 1
      object Bevel5: TBevel
        Left = 8
        Top = 4
        Width = 353
        Height = 121
        Shape = bsFrame
        Style = bsRaised
      end
      object Label1: TLabel
        Left = 148
        Top = 20
        Width = 84
        Height = 12
        Caption = '报时窗口在显示'
        Visible = False
      end
      object Label2: TLabel
        Left = 284
        Top = 20
        Width = 48
        Height = 12
        Caption = '秒后消失'
        Visible = False
      end
      object Label3: TLabel
        Left = 148
        Top = 41
        Width = 12
        Height = 16
        Caption = '...'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton1: TSpeedButton
        Left = 141
        Top = 38
        Width = 25
        Height = 25
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton1Click
      end
      object SpeedButton5: TSpeedButton
        Left = 326
        Top = 62
        Width = 25
        Height = 25
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000004000
          000080000000FF000000002000004020000080200000FF200000004000004040
          000080400000FF400000006000004060000080600000FF600000008000004080
          000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
          000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
          200080002000FF002000002020004020200080202000FF202000004020004040
          200080402000FF402000006020004060200080602000FF602000008020004080
          200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
          200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
          400080004000FF004000002040004020400080204000FF204000004040004040
          400080404000FF404000006040004060400080604000FF604000008040004080
          400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
          400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
          600080006000FF006000002060004020600080206000FF206000004060004040
          600080406000FF406000006060004060600080606000FF606000008060004080
          600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
          600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
          800080008000FF008000002080004020800080208000FF208000004080004040
          800080408000FF408000006080004060800080608000FF608000008080004080
          800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
          800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
          A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
          A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
          A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
          A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
          C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
          C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
          C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
          C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
          FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
          FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
          FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
          FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00DBDBDBDBDBDB
          DB0000DBDBDBDBDBDBDBDBDBDBDBDBDB00900092DBDBDBDBDBDBDBDBDBDBDB00
          9000DBDB92DBDBDB92DBDBDBDBDB00909292FFFF92DBDB92DBDBDBDBDB0090FC
          00DBFFFF92DB92DBDBDBDB000090FCFF00DBFFFF92DBDBDBDBDB009092FCFFFC
          0000FFFF92DBDBDBDBDB90FCDBFFFCFF009200FF92DB9292929290FCDBFCFFFC
          00DB00FF92DBDBDBDBDB90FFDBFFFCFF0000FFFF92DBDBDBDBDBDB9090FCFFFC
          00DBFFFF92DB92DBDBDBDBDBDB90FCFF00DBFFFF92DBDB92DBDBDBDBDBDB90FC
          9292DBFF92DBDBDB92DBDBDBDBDBDB90FC00DBDBDBDBDBDBDBDBDBDBDBDBDBDB
          90920092DBDBDBDBDBDBDBDBDBDBDBDBDB0000DBDBDBDBDBDBDB}
        ParentFont = False
        OnClick = SpeedButton5Click
      end
      object SpeedButton10: TSpeedButton
        Left = 326
        Top = 91
        Width = 25
        Height = 25
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'System'
        Font.Style = [fsBold]
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000004000
          000080000000FF000000002000004020000080200000FF200000004000004040
          000080400000FF400000006000004060000080600000FF600000008000004080
          000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
          000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
          200080002000FF002000002020004020200080202000FF202000004020004040
          200080402000FF402000006020004060200080602000FF602000008020004080
          200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
          200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
          400080004000FF004000002040004020400080204000FF204000004040004040
          400080404000FF404000006040004060400080604000FF604000008040004080
          400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
          400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
          600080006000FF006000002060004020600080206000FF206000004060004040
          600080406000FF406000006060004060600080606000FF606000008060004080
          600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
          600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
          800080008000FF008000002080004020800080208000FF208000004080004040
          800080408000FF408000006080004060800080608000FF608000008080004080
          800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
          800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
          A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
          A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
          A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
          A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
          C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
          C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
          C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
          C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
          FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
          FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
          FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
          FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00DBDBDBDBDBDB
          DB0000DBDBDBDBDBDBDBDBDBDBDBDBDB00900092DBDBDBDBDBDBDBDBDBDBDB00
          9000DBDB92DBDBDB92DBDBDBDBDB00909292FFFF92DBDB92DBDBDBDBDB0090FC
          00DBFFFF92DB92DBDBDBDB000090FCFF00DBFFFF92DBDBDBDBDB009092FCFFFC
          0000FFFF92DBDBDBDBDB90FCDBFFFCFF009200FF92DB9292929290FCDBFCFFFC
          00DB00FF92DBDBDBDBDB90FFDBFFFCFF0000FFFF92DBDBDBDBDBDB9090FCFFFC
          00DBFFFF92DB92DBDBDBDBDBDB90FCFF00DBFFFF92DBDB92DBDBDBDBDBDB90FC
          9292DBFF92DBDBDB92DBDBDBDBDBDB90FC00DBDBDBDBDBDBDBDBDBDBDBDBDBDB
          90920092DBDBDBDBDBDBDBDBDBDBDBDBDB0000DBDBDBDBDBDBDB}
        ParentFont = False
        OnClick = SpeedButton10Click
      end
      object CheckBox2: TCheckBox
        Left = 32
        Top = 16
        Width = 109
        Height = 21
        Caption = '报时时弹出窗口'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object CheckBox3: TCheckBox
        Left = 32
        Top = 44
        Width = 109
        Height = 17
        Caption = '报时时播放声音'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox3Click
      end
      object Edit2: TEdit
        Left = 52
        Top = 64
        Width = 269
        Height = 20
        ReadOnly = True
        TabOrder = 2
      end
      object MaskEdit1: TMaskEdit
        Left = 240
        Top = 16
        Width = 37
        Height = 20
        EditMask = '!9;1; '
        MaxLength = 1
        TabOrder = 3
        Text = '2'
        Visible = False
      end
      object ComboBox2: TComboBox
        Left = 156
        Top = 92
        Width = 165
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 4
        Items.Strings = (
          'psOK'
          'psError'
          'psWelcome'
          'psEmergency'
          'psWrong'
          'psCall'
          'psOfficial'
          'psDaze'
          'psFall'
          'psChord'
          'psWhisle'
          'psHanging'
          'psClimb')
      end
      object CheckBox10: TCheckBox
        Left = 32
        Top = 94
        Width = 117
        Height = 17
        Caption = '报时时PC喇叭发声'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = CheckBox9Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = '提醒设置'
      ImageIndex = 2
      object Label4: TLabel
        Left = 164
        Top = 76
        Width = 60
        Height = 12
        Caption = '窗口在显示'
        Visible = False
      end
      object Label5: TLabel
        Left = 272
        Top = 76
        Width = 48
        Height = 12
        Caption = '秒后消失'
        Visible = False
      end
      object Bevel2: TBevel
        Left = 8
        Top = 4
        Width = 353
        Height = 121
        Shape = bsFrame
        Style = bsRaised
      end
      object CheckBox4: TCheckBox
        Left = 32
        Top = 16
        Width = 153
        Height = 21
        Caption = 'Windows启动时自动运行'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object CheckBox5: TCheckBox
        Left = 32
        Top = 44
        Width = 160
        Height = 21
        Caption = '启动时显示当日计划列表'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object CheckBox6: TCheckBox
        Left = 32
        Top = 74
        Width = 125
        Height = 17
        Caption = '列表窗口自动关闭'
        Checked = True
        State = cbChecked
        TabOrder = 2
        Visible = False
      end
      object MaskEdit2: TMaskEdit
        Left = 228
        Top = 72
        Width = 37
        Height = 20
        EditMask = '!9;1; '
        MaxLength = 1
        TabOrder = 3
        Text = '2'
        Visible = False
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'TabSheet4'
      ImageIndex = 3
      object Bevel4: TBevel
        Left = 8
        Top = 4
        Width = 353
        Height = 121
        Shape = bsFrame
        Style = bsRaised
      end
      object SpeedButton8: TSpeedButton
        Left = 36
        Top = 20
        Width = 305
        Height = 25
        Caption = '创建桌面快捷方式图标'
        Flat = True
        OnClick = SpeedButton8Click
      end
    end
  end
  object Panel1: TPanel
    Tag = 2
    Left = 98
    Top = 12
    Width = 76
    Height = 16
    BevelOuter = bvNone
    Caption = '报时设置'
    Enabled = False
    ParentColor = True
    TabOrder = 1
    OnClick = Panel1Click
  end
  object Panel2: TPanel
    Tag = 3
    Left = 180
    Top = 11
    Width = 76
    Height = 18
    BevelOuter = bvNone
    Caption = '启动设置'
    ParentColor = True
    TabOrder = 2
    OnClick = Panel1Click
  end
  object Panel3: TPanel
    Tag = 1
    Left = 15
    Top = 11
    Width = 76
    Height = 18
    BevelOuter = bvNone
    Caption = '提醒设置'
    ParentColor = True
    TabOrder = 3
    OnClick = Panel1Click
  end
  object Panel5: TPanel
    Tag = 4
    Left = 264
    Top = 11
    Width = 76
    Height = 18
    BevelOuter = bvNone
    Caption = '其它设置'
    ParentColor = True
    TabOrder = 4
    OnClick = Panel1Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'wav'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 146
    Top = 181
  end
  object Beeper1: TBTBeeper
    Left = 114
    Top = 182
  end
end
