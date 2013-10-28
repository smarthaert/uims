object Form1: TForm1
  Left = 301
  Top = 155
  Width = 659
  Height = 555
  Caption = 'RSR_'#35777#21048#23454#26102#34892#24773#24341#25806' (DEMO)'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar1: TStatusBar
    Left = 0
    Top = 504
    Width = 651
    Height = 17
    Panels = <
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 651
    Height = 504
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #21152#36733#25968#25454#24341#25806
      object Button9: TButton
        Left = 32
        Top = 152
        Width = 185
        Height = 81
        Caption = #21152#36733' RSR_'#35777#21048#34892#24773#24341#25806
        TabOrder = 0
        OnClick = Button9Click
      end
      object RG: TRadioGroup
        Left = 32
        Top = 32
        Width = 185
        Height = 105
        ItemIndex = 0
        Items.Strings = (
          #31383#21475#28040#24687#27169#24335
          #22238#35843#20989#25968#27169#24335)
        TabOrder = 1
        OnClick = RGClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454#25805#20316
      ImageIndex = 1
      DesignSize = (
        643
        477)
      object Label1: TLabel
        Left = 8
        Top = 436
        Width = 169
        Height = 17
        Anchors = [akLeft, akBottom]
        AutoSize = False
        Caption = #20195#30721'('#21487#21518#21152'SZ'#25110'SH'#25351#23450#24066#22330')'#65306
      end
      object Label2: TLabel
        Left = 248
        Top = 436
        Width = 65
        Height = 17
        Anchors = [akLeft, akBottom]
        AutoSize = False
        Caption = #35777#21048#21517#31216#65306
      end
      object Memo1: TMemo
        Left = 8
        Top = 16
        Width = 498
        Height = 401
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          '{'
          '******************************************'
          #20197#19979#20026'Delphi'#29256#30340#25968#25454#32467#26500#21644#30456#20851#35843#29992#20989#25968#22768#26126
          #20351#29992#20854#20182#24320#21457#35821#35328#30340#65292#21482#35201#36716#25442#25104#33258#24049#35821#35328#30340#30456#24212#26684#24335#23601#21487#20197#20102
          #30446#21069#22312' RSRStock.dll '#20013#65292#25552#20379#20102#22914#19979#20960#20010#23548#20986#20989#25968#65306
          
            '   DLLVER, R_Open, R_Close, R_Connect, R_DisConnect, R_InitMarke' +
            'tData, '
          '   R_GetPK, R_GetTestRealPK, R_GetKDays, R_GetDeals, R_GetMins,'
          '   R_GetMarket, R_GetMarketByStockCode, R_GetMarketByStockName,'
          '   R_GetStockName, R_GetStockCode'
          #23427#20204#37117#20351#29992#30340#26159' stdcall '#30340#21442#25968#20256#36882#26684#24335
          ''
          #20351#29992#20854#20182#24320#21457#35821#35328#30340#65292#35831#33258#34892#36716#21270' TDXGrobal.pas '#37324#38754#30340'Delphi'#25968#25454#26426#26500
          #26032#29256#26412#21462#28040#20102#20351#29992#22238#35843#20989#25968#26469#33719#24471#25968#25454#30340#26041#24335#65292#25913#20026#20351#29992#28040#24687#27169#24335
          #28040#24687#30340#23450#20041#35831#21442#30475' TDXGrobal.pas'
          ''
          ''
          '******************************************'
          '}'
          ''
          ''
          '{'
          #21019#24314#25968#25454#25509#25910#32452#20214'('#20351#29992#29420#31435#30340#25968#25454#24037#20316#32447#31243')'
          #21442#25968
          'Handle  = '#35843#29992#32773#31383#21475' Handle '#65292#25968#25454#32452#20214#22312#33719#24471#25968#25454#21518#23558#21521#36825#20010#31383#21475#21457#36865#28040#24687
          'RegKey  = '#27880#20876#23383#31526#20018#65292#35797#29992#26102#30452#25509#20351#29992#31354#20540
          #36820#22238#20540
          #21019#24314#30340#25968#25454#25509#25910#32452#20214#30340#21477#26564#65292#38656#35201#23558#35813#21477#26564#36827#34892#20445#23384#65292#20197#20415#36827#34892#20854#20182#25968#25454#25805#20316
          '}'
          
            '  R_Open  :function(Handle: THandle; RegKey: PChar): longword; s' +
            'tdcall;'
          ''
          '{'
          #37322#25918#25968#25454#25509#25910#32452#20214
          #21442#25968
          'TDXManager = '#38656#35201#37322#25918#30340#32452#20214#30340#21477#26564
          '}'
          '  R_Close :procedure(TDXManager: longword); stdcall;'
          '{'
          #36830#25509#21040#34892#24773#26381#21153#22120
          #21442#25968
          'TDXManager = '#20351#29992' R_Open '#21019#24314#30340#25968#25454#25509#25910#32452#20214#36820#22238#30340#21477#26564
          'ServerAddr = '#34892#24773#26381#21153#22120#22320#22336#65292#21487#20197#26159'IP'#25110#22495#21517
          'Port       = '#26381#21153#22120#31471#21475' 7709'
          #36820#22238#20540
          'True   '#25104#21151#36830#25509
          'False  '#22833#36133
          '}'
          
            '  R_Connect :function   (TDXManager: longword; ServerAddr: PChar' +
            '; port:integer=7709):LongBool; stdcall;'
          '{'
          #26029#24320#19982#26381#21153#22120#30340#36830#25509
          #21442#25968
          'TDXManager = '#20351#29992' R_Open '#21019#24314#30340#25968#25454#25509#25910#32452#20214#36820#22238#30340#21477#26564
          '}'
          '  R_DisConnect  :procedure (TDXManager: longword); stdcall;'
          '{'
          #21021#22987#21270#24066#22330#25968#25454'  '#33719#24471#26368#26032#30340#35777#21048#20195#30721#19982#35777#21048#21517#31216#31561#25968#25454#30340#34920
          #21442#25968
          'TDXManager = '#20351#29992' R_Open '#21019#24314#30340#25968#25454#25509#25910#32452#20214#36820#22238#30340#21477#26564
          'Market 0='#28145#22323' 1='#19978#28023
          '}'
          
            '  R_InitMarketData  :procedure  (TDXManager: longword; Market: i' +
            'nteger); stdcall;'
          '{'
          #21457#36865#35831#27714#30424#21475#35201#27714
          #33509#25552#20379#20004#20010#21442#25968#65292#21017#33021#20934#30830#21457#36865
          #33509#20165#25552#20379#35777#21048#21517#31216#65292#20063#19968#33324#33021#20934#30830#21457#36865
          #33509#20165#25552#20379#35777#21048#20195#30721
          #22240#20026#19978#28023#21644#28145#22323#23384#22312#21516#21517#30340#20195#30721#65292#22914'000001'#22312#19978#28023#20195#34920#22823#30424#25351#25968#65292#22312#28145#22323#20195#34920#28145#21457#23637#65292#25152#20197#26377#21487#33021#21457#36865#30340#26159#19981#31526#21512#24744#39044#26399#30340#25968#25454#65292
          #36825#26102#20505#20320#21487#20197#22312#35777#21048#20195#30721#21518#38754#21152#24066#22330#25351#23450#23383#31526#65292#22914#65306'000001SH '#23601#20195#34920#19978#28023#30340'000001 000001SZ'#20195#34920#28145#22323#30340'000001'
          #21442#25968
          'TDXManager = '#20351#29992' R_Open '#21019#24314#30340#25968#25454#25509#25910#32452#20214#36820#22238#30340#21477#26564
          'StkCode = '#35777#21048#20195#30721
          'StkName = '#35777#21048#21517#31216
          '}'
          
            '  R_GetPK :procedure  (TDXManager: longword; StkCode  :PChar; St' +
            'kName :PChar); stdcall;'
          ''
          '{'
          #21457#36865#26159#21542#26377#23454#26102#25968#25454#21464#21270#35831#27714
          #21487#20197#29992#27604#36739#39057#32321#30340#21521#26381#21153#22120#21457#36865#26412#35831#27714#65292#27979#35797#26159#21542#26377#26032#30340#20132#26131#25968#25454#25110#30424#21475#21464#21270#65292#22914#26524#26377#65292#21017#36820#22238#25968#25454#65292#27809#26377#65292#21017#19981#36820#22238#25968#25454
          #21442#25968
          'TDXManager = '#20351#29992' R_Open '#21019#24314#30340#25968#25454#25509#25910#32452#20214#36820#22238#30340#21477#26564
          'StkCode = '#35777#21048#20195#30721
          'Market  = '#24066#22330#32534#21495
          
            'Time    = '#26368#21518#19968#27425#25509#25910#21040#30340#30424#21475#25968#25454#32467#26500' TTDX_PKBASE.LastDealTime '#30340#20540#65292#33509'=0'#65292#21017#19968#23450#20250#36820#22238#24403 +
            #21069#26368#26032#30424#21475#25968#25454
          ''
          '}'
          
            '   R_GetTestRealPK : procedure(TDXManager: longword; StkCode: PC' +
            'har; market, Time: integer);  stdcall;'
          ''
          '{'
          #21457#36865#35831#27714#33719#24471#26085'K'#32447#25968#25454
          #21442#25968
          'TDXManager = '#20351#29992' R_Open '#21019#24314#30340#25968#25454#25509#25910#32452#20214#36820#22238#30340#21477#26564
          'StkCode = '#35777#21048#20195#30721
          'Market  = '#24066#22330#32534#21495
          'startcount  = '#24320#22987#20132#26131#26085#22825#25968#65292#20174#24403#21069#26368#26032#20132#26131#26085#24448#21518#25512#30340#25968#23383#65292#33509'=0'#21017#20174#26368#26032#20132#26131#26085#24320#22987
          'count   = '#33719#21462#30340#26085'K'#32447#22825#25968
          '}'
          
            '   R_GetKDays :procedure(TDXManager: longword; StkCode: PChar; m' +
            'arket, startcount, count: integer); stdcall;//'#33719#24471#26085'K'#32447
          ''
          '{'
          #21457#36865#35831#27714#33719#24471#20998#31508#25104#20132#25968#25454
          #21442#25968
          'startcount  = '#20174#26368#26032#19968#31508#20132#26131#24448#21518#25512#30340#24320#22987#31508#25968
          'count       = '#38656#35201#33719#21462#30340#31508#25968
          '}'
          
            '   R_GetDeals :procedure (TDXManager: longword; StkCode: PChar; ' +
            'market, startcount, count: integer); //'#20998#31508#25104#20132
          ''
          '{'
          #21457#36865#35831#27714#33719#24471#20998#26102#25104#20132#25968#25454
          #21442#25968
          'start   = '#24320#22987#20998#38047#25968#65292#19968#33324#21462'0'#65292#36820#22238#24403#21069#25152#26377#20998#26102#25968#25454
          '}'
          
            '   R_GetMins  :procedure (TDXManager: longword; StkCode: PChar; ' +
            'market, start: integer); //'#20998#26102#22270
          ''
          '{'
          #33719#24471#24066#22330#31867#22411#65292#24517#39035#22312#35843#29992' R_InitMarketData '#20989#25968#33719#24471#21021#22987#21270#24066#22330#25968#25454#21518
          #24403#20004#20010#21442#25968#37117#27491#30830#36755#20837#26102#65292#21487#20197#20934#30830#36820#22238#24066#22330#31867#21035#65292#33509#21482#26377'StkCode'#21442#25968#65292#22240#27492#21442#25968#20004#24066#21487#33021#23384#22312#21516#21517#65292#22240#27492#36820#22238#20854#20013#19968#20010#24066#22330#30340#31867#22411
          #33509#21482#26377'StkName'#21442#25968#65292#19968#33324#24773#20917#19979#37117#21487#20197#20934#30830#36820#22238
          #21442#25968
          'StkCode = '#35777#21048#20195#30721
          'StkName = '#35777#21048#21517#31216
          #36820#22238#20540
          '0='#28145#22323
          '1='#19978#28023
          '255='#26410#25214#21040
          '}'
          
            '   R_GetMarket :function   (StkCode  :PChar; StkName :PChar): in' +
            'teger; stdcall;'
          
            '   R_GetMarketByStockCode :function  (StkCode  :PChar): integer;' +
            ' stdcall;'
          
            '   R_GetMarketByStockName :function  (StkName  :PChar): integer;' +
            ' stdcall;'
          
            '   R_GetStockName :function  (StkCode :PChar; Market: integer): ' +
            'PChar; stdcall;'
          '   R_GetStockCode :function  (StkName :PChar): PChar; stdcall;'
          '{'
          #33719#24471#25968#25454#24341#25806#29256#26412#21495
          #36820#22238#20540'   ='#29992#26085#26399#30456#38548#30340#29256#26412#21495
          '}'
          '  GetDLLVER :function ():PChar; stdcall;')
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 176
        Top = 433
        Width = 65
        Height = 20
        Anchors = [akLeft, akBottom]
        TabOrder = 1
        Text = '600158'
      end
      object Edit2: TEdit
        Left = 312
        Top = 433
        Width = 65
        Height = 20
        Anchors = [akLeft, akBottom]
        TabOrder = 2
        Text = #20013#20307#20135#19994
      end
      object StaticText1: TStaticText
        Left = 8
        Top = 460
        Width = 626
        Height = 17
        Alignment = taCenter
        Anchors = [akLeft, akRight, akBottom]
        AutoSize = False
        Caption = 'renshouren QQ:114032666 http://renshou.net'
        Enabled = False
        TabOrder = 3
      end
      object Button8: TButton
        Left = 512
        Top = 328
        Width = 129
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #33719#24471#25152#26377#30424#21475
        TabOrder = 4
        OnClick = Button8Click
      end
      object Button7: TButton
        Left = 513
        Top = 286
        Width = 129
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #33719#24471#20998#31508#25968#25454
        Enabled = False
        TabOrder = 5
        OnClick = Button7Click
      end
      object Button6: TButton
        Left = 513
        Top = 245
        Width = 129
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #33719#24471#20998#26102#22270
        Enabled = False
        TabOrder = 6
        OnClick = Button6Click
      end
      object Button5: TButton
        Left = 513
        Top = 204
        Width = 129
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #33719#24471#26085'K'#32447
        Enabled = False
        TabOrder = 7
        OnClick = Button5Click
      end
      object Button3: TButton
        Left = 513
        Top = 163
        Width = 129
        Height = 30
        Anchors = [akTop, akRight]
        Caption = #33719#24471#30424#21475
        Enabled = False
        TabOrder = 8
        OnClick = Button3Click
      end
      object Button2: TButton
        Left = 513
        Top = 122
        Width = 129
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #21021#22987#21270#24066#22330
        Enabled = False
        TabOrder = 9
        OnClick = Button2Click
      end
      object Button4: TButton
        Left = 513
        Top = 81
        Width = 129
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #26029#24320#36830#25509
        Enabled = False
        TabOrder = 10
        OnClick = Button4Click
      end
      object Button1: TButton
        Left = 513
        Top = 40
        Width = 129
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #36830#25509#26381#21153#22120
        TabOrder = 11
        OnClick = Button1Click
      end
      object ComboBox1: TComboBox
        Left = 513
        Top = 16
        Width = 129
        Height = 20
        Anchors = [akTop, akRight]
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 12
        Text = #30005#20449
        Items.Strings = (
          #30005#20449
          #32593#36890
          #26399#36135)
      end
    end
  end
end
