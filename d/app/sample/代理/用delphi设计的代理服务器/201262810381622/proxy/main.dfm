object Form1: TForm1
  Left = 192
  Top = 33
  Width = 547
  Height = 473
  BorderStyle = bsSizeToolWin
  Caption = 'Http代理服务器'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clNavy
  Font.Height = -16
  Font.Name = '宋体'
  Font.Style = [fsBold]
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    00000000000000000000000000000F0F0F0F0F00000000000000000000000000
    0000000700000000000000000000088888888880700000000000000000000088
    88888888000000000000000000000008888888888000000000C0000000000000
    0000000000000000CC00000000000000000088700000000CC000000000000000
    0000088700000000CC00000000000000000000887000000CC000000000000000
    00000008870000CC000000000000000000000000887000000000000000000000
    0CC000000887000000000FF00000000CCCCCCC000088700000FFFFFF00000000
    000CCC000008870FFFFFFFFF00000000000000000000880FFFFFFFFFF0000000
    0000000000FF00FFFFFFFFFFF000000000000000FFFFFFFFFFFFFFFFFF000000
    000000000FFFFFFFFFFFFFF00F000000000000000FFFFFFFFFFFFFF00FF00000
    0000000000FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFF000000000
    00000000000FFFFFFFFF00000000000000000000300FFFFF0000887000000000
    000003030300F000000008870000000000303030000000000000008870000003
    0303030000000000000000088700000030300000000000000000000088700000
    0300000000000000000000000880000000000000000000000000000000000000
    0000000000000000000000000000FFFFFFFF001FFFFF000FFFFF0007FFFF0003
    FFFF8003FFFFC003FDFFE003F3FFFE0FE7FFFF07F3FFFF83E7FFFFC1CFFFFFE0
    FF8FF9F07C0FE0382007FE3C0007FFFC0003FFE00003FFE00001FFF00001FFF0
    0000FFF80000FFF80003FFF0001FFF80000FFC000F07E0027F83C00FFFC1C03F
    FFE0E0FFFFF1E3FFFFFBFFFFFFFF280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000F0F
    0700000000000888870000CC0000000000000C0000000000870000C000000000
    08700C0000000CCC008700000000033CC008700FFF000000000000FFFF000000
    000FFFFFFFF00000000FFFFFFFF000000000FFFF000000000000000087000003
    3000000008700030000000000087000000000000000003FF000001FF000001CF
    000081BF0000E1DF0000F0BF00008863000084010000F8010000F8000000FC00
    0000FC010000E00100008070000087F800009FFD0000}
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 310
    Top = 355
    Width = 69
    Height = 16
    Caption = '会 话 数'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 19
    Top = 393
    Width = 130
    Height = 16
    Caption = '过 滤 关 键 字:'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 15
    Top = 355
    Width = 136
    Height = 16
    Caption = '允许访问站点列表'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 309
    Top = 316
    Width = 68
    Height = 16
    Caption = '访问策略'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 15
    Top = 316
    Width = 136
    Height = 16
    Caption = '拒绝访问站点列表'
    Font.Charset = GB2312_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 0
    Width = 521
    Height = 297
    Hint = '当前连接情况'
    ParentShowHint = False
    ReadOnly = True
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 384
    Top = 350
    Width = 49
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 157
    Top = 388
    Width = 135
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 2
    OnKeyDown = ComboBox1KeyDown
    Items.Strings = (
      '色情'
      '法轮功'
      '六四')
  end
  object ComboBox2: TComboBox
    Left = 156
    Top = 350
    Width = 135
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clGreen
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 3
    OnKeyDown = ComboBox2KeyDown
    Items.Strings = (
      'www.bb.cq.cn'
      'www.yahoo.com.cn'
      'www.cyol.com.cn')
  end
  object ComboBox3: TComboBox
    Left = 384
    Top = 312
    Width = 137
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clMaroon
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 4
    Text = '只拒绝拒绝访问的'
    OnChange = ComboBox3Change
    Items.Strings = (
      '只访问允许访问的'
      '只拒绝拒绝访问的')
  end
  object Button1: TButton
    Left = 310
    Top = 392
    Width = 65
    Height = 25
    Caption = '清 空'
    Font.Charset = GB2312_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = '宋体'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = Button1Click
  end
  object ComboBox4: TComboBox
    Left = 157
    Top = 312
    Width = 134
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 6
    OnKeyDown = ComboBox4KeyDown
    Items.Strings = (
      'www.cctv.com'
      'www.swnu.edu.cn')
  end
  object Button2: TButton
    Left = 464
    Top = 392
    Width = 59
    Height = 25
    Caption = '退 出'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 392
    Top = 392
    Width = 59
    Height = 25
    Caption = '刷 新'
    TabOrder = 8
    OnClick = Button3Click
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 988
    ServerType = stNonBlocking
    OnListen = ServerSocket1Listen
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    OnClientWrite = ServerSocket1ClientWrite
    OnClientError = ServerSocket1ClientError
    Left = 104
    Top = 272
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 80
    OnConnect = ClientSocket1Connect
    OnDisconnect = ClientSocket1Disconnect
    OnRead = ClientSocket1Read
    OnWrite = ClientSocket1Write
    OnError = ClientSocket1Error
    Left = 136
    Top = 272
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 2
    OnTimer = Timer2Timer
    Left = 216
    Top = 272
  end
  object PopupMenu1: TPopupMenu
    Left = 176
    Top = 272
    object N11: TMenuItem
      Caption = '&1.启动服务'
      OnClick = N11Click
    end
    object N21: TMenuItem
      Caption = '&2.终止服务'
      OnClick = N21Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N01: TMenuItem
      Caption = '&0.退出程序'
      OnClick = N01Click
    end
    object N40: TMenuItem
      Caption = '-'
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 256
    Top = 272
  end
  object MainMenu1: TMainMenu
    Left = 296
    Top = 272
    object N2: TMenuItem
      Caption = '服 务 器'
      object N3: TMenuItem
        Caption = '启    动'
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = '停    止'
        OnClick = N4Click
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object N31: TMenuItem
        Caption = '端口设置'
        OnClick = N31Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object N5: TMenuItem
        Caption = '退    出'
        OnClick = N5Click
      end
    end
    object N7: TMenuItem
      Caption = '拒绝设置'
      object N8: TMenuItem
        Caption = '增加站点'
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = '去除站点'
        OnClick = N9Click
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object N27: TMenuItem
        Caption = '清除设置'
        OnClick = N27Click
      end
    end
    object N10: TMenuItem
      Caption = '允许设置'
      object N12: TMenuItem
        Caption = '增加站点'
        OnClick = N12Click
      end
      object N13: TMenuItem
        Caption = '去除站点'
        OnClick = N13Click
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object N25: TMenuItem
        Caption = '清除设置'
        OnClick = N25Click
      end
    end
    object N14: TMenuItem
      Caption = '策略设置'
      object N15: TMenuItem
        Caption = '只 允 许'
        OnClick = N15Click
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object N16: TMenuItem
        Caption = '只 拒 绝'
        Checked = True
        OnClick = N16Click
      end
    end
    object N17: TMenuItem
      Caption = '过滤设置'
      object N18: TMenuItem
        Caption = '增加关键字'
        OnClick = N18Click
      end
      object N19: TMenuItem
        Caption = '去除关键字'
        OnClick = N19Click
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object N20: TMenuItem
        Caption = ' 清空设置'
        OnClick = N20Click
      end
    end
    object N28: TMenuItem
      Caption = '帮助'
      object N29: TMenuItem
        Caption = '关于、、'
        OnClick = N29Click
      end
      object N30: TMenuItem
        Caption = '使用说明'
        OnClick = N30Click
      end
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 368
    Top = 272
    object N33: TMenuItem
      Caption = '启动服务'
      OnClick = N33Click
    end
    object N34: TMenuItem
      Caption = '停止服务'
      OnClick = N34Click
    end
    object N37: TMenuItem
      Caption = '-'
    end
    object N35: TMenuItem
      Caption = '显示窗口'
      OnClick = N35Click
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object N36: TMenuItem
      Caption = '退出程序'
      OnClick = N36Click
    end
  end
end
