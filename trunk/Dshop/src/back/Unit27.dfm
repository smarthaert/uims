object Fr_DaYinJiCeShi: TFr_DaYinJiCeShi
  Left = 381
  Top = 194
  Width = 915
  Height = 623
  Caption = #25171#21360#26426#27979#35797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = -8
    Top = -9
    Width = 913
    Height = 538
    Caption = 'pnl1'
    TabOrder = 0
    object QuickRep1: TQuickRep
      Left = 0
      Top = 8
      Width = 911
      Height = 529
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      DataSet = ADOQuery1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Functions.Strings = (
        'PAGENUMBER'
        'COLUMNNUMBER'
        'REPORTTITLE')
      Functions.DATA = (
        '0'
        '0'
        #39#39)
      Options = [FirstPageHeader, LastPageFooter]
      Page.Columns = 1
      Page.Orientation = poPortrait
      Page.PaperSize = Custom
      Page.Values = (
        100.000000000000000000
        1400.000000000000000000
        100.000000000000000000
        2410.000000000000000000
        100.000000000000000000
        100.000000000000000000
        0.000000000000000000)
      PrinterSettings.Copies = 1
      PrinterSettings.OutputBin = Auto
      PrinterSettings.Duplex = False
      PrinterSettings.FirstPage = 0
      PrinterSettings.LastPage = 0
      PrinterSettings.UseStandardprinter = False
      PrinterSettings.UseCustomBinCode = False
      PrinterSettings.CustomBinCode = 0
      PrinterSettings.ExtendedDuplex = 0
      PrinterSettings.UseCustomPaperCode = False
      PrinterSettings.CustomPaperCode = 0
      PrinterSettings.PrintMetaFile = False
      PrinterSettings.PrintQuality = 0
      PrinterSettings.Collate = 0
      PrinterSettings.ColorOption = 0
      PrintIfEmpty = True
      ReportTitle = #36825#37324#26159#26631#39064
      SnapToGrid = True
      Units = MM
      Zoom = 100
      PrevFormStyle = fsNormal
      PreviewInitialState = wsNormal
      PrevInitialZoom = qrZoomToFit
      object qrbnd1: TQRBand
        Left = 38
        Top = 38
        Width = 835
        Height = 83
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          219.604166666666700000
          2209.270833333333000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbPageHeader
        object qrshp1: TQRShape
          Left = 1
          Top = 16
          Width = 840
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            171.979166666666700000
            2.645833333333333000
            42.333333333333340000
            2222.500000000000000000)
          Pen.Style = psDot
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrshp2: TQRShape
          Left = 91
          Top = 59
          Width = 89
          Height = 25
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            66.145833333333340000
            240.770833333333300000
            156.104166666666700000
            235.479166666666700000)
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrshp3: TQRShape
          Left = -3
          Top = 59
          Width = 89
          Height = 25
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            66.145833333333340000
            -7.937500000000000000
            156.104166666666700000
            235.479166666666700000)
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrshp4: TQRShape
          Left = 179
          Top = 59
          Width = 89
          Height = 25
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            66.145833333333340000
            473.604166666666700000
            156.104166666666700000
            235.479166666666700000)
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrlbl2: TQRLabel
          Left = 28
          Top = 64
          Width = 33
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.916666666666660000
            74.083333333333340000
            169.333333333333300000
            87.312500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #21345#21495
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl3: TQRLabel
          Left = 124
          Top = 64
          Width = 33
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.916666666666660000
            328.083333333333400000
            169.333333333333300000
            87.312500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #22995#21517
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrlbl4: TQRLabel
          Left = 212
          Top = 64
          Width = 33
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.916666666666660000
            560.916666666666800000
            169.333333333333300000
            87.312500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #22791#27880
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object img1: TQRImage
          Left = 277
          Top = 20
          Width = 281
          Height = 41
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            108.479166666666700000
            732.895833333333400000
            52.916666666666660000
            743.479166666666800000)
          Picture.Data = {
            0A544A504547496D6167654F130000FFD8FFE000104A46494600010101006000
            600000FFDB0043000302020302020303030304030304050805050404050A0707
            06080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F17
            1816141812141514FFDB00430103040405040509050509140D0B0D1414141414
            1414141414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC00011080029010703012200021101031101
            FFC4001F0000010501010101010100000000000000000102030405060708090A
            0BFFC400B5100002010303020403050504040000017D01020300041105122131
            410613516107227114328191A1082342B1C11552D1F02433627282090A161718
            191A25262728292A3435363738393A434445464748494A535455565758595A63
            6465666768696A737475767778797A838485868788898A92939495969798999A
            A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
            D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
            01010101010101010000000000000102030405060708090A0BFFC400B5110002
            0102040403040705040400010277000102031104052131061241510761711322
            328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
            292A35363738393A434445464748494A535455565758595A636465666768696A
            737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
            A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
            E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FB9B
            F68FFDA0EFFE077FC23D6FA5787F4FF126A5ABFDA2416B7DACB69DB2287CA0EE
            A56DE62F869A307E5006E193C8078BF86BFB665FFC4AF8A3E0FF000E587822DD
            B40F1079A0EBB6DAD34ED6FB6D67B857F285B05689BC9440FE68E655E0F19E57
            F6F88743BDF187C34B3D4F4BB7D52F5ACB579A14BFB64B9B53147369AD224914
            9947CBFD9D806461F21E9D0F99FECE326A307C45F8137367716B6F656DE17D1E
            5D47ED4FB15AD7FE11950D86DAD82AE637FE1C8420B004D007E8BD15C6F8D7C4
            DA1DD78375D806B764864B09D03457681C663619539EBE95C27ECABF102CF5EF
            825F0BB4EB9D56EF55F114FE0ED2B52BBB9BB69A769A492DA33216B87C869379
            6250B6E00E718A00F6DA2B1BC5179A9E9BA15EDD691669A8DFDBC6668EC9DB6F
            DA76F26256FE16600804E40246462BC27C4BF152C7E2B4FF00B39F897C2FA8EA
            16FA27883C57309A28E692DA4711E97A933DB5C2A30CEC9E001E36C8DD160838
            A00FA3E8AF3FD23C7DAB6BDF17F5CF0D5968D149E18D12CA1FB6EBAF705586A1
            265C5AC71ED21F6C263776DCBB7CC4186DC76FA050014551BDD52CF4E9ACE1BB
            BC82D65BC9BC8B78E69551A793696D8809F99B6AB1C0E70A4F6AF12FD91BC58B
            A97C1DD6EF353D5E4B93A778A3C4305CDCDF5CB38B78E2D4EE7629673F22243E
            5E0701540E9401EF74572DF0FBC776DF11B417D62C74FD4EC2C8DCCD043FDAB6
            8D6CF7088E544F1AB7262703723606E520F7AE37E35EB5752C5A1F87B4EBAD5F
            C3BE27D575410683AADA2C324725CC304976F1C8864C344D05BCEACB201919C1
            0DB1A803D6E8AF14F8F7E29D4A6F855E29D2E7B5B9F09FF6906D3FFB55B50862
            7B6D3DA3DD7B7E2456221686013B297206F5886E1BF8EE2C355BCB2F085BA787
            744BBD5162B251A7BDE6A513C770027EECBDC79B23306E32F862739E6803B3A2
            A8E9535D5C69D6B2DEDA8B2BB78D4CD6EB289046F8F99438037007A1C0C8EC3A
            56278DBC277DE2BB3B55D3FC4BAB785AF6D25134575A618983B0FE1963951D64
            8C8C82A40382482AC158007534579F7C0EF8AD61F1A7E1BE9DE27B0922956679
            6DE57803089E48A464678F3C98DF68910E4E51D0E4E735E83400515E51E34F89
            1AD689F1E7C13E0BB27B0834BD6F43D5B52B9B8BC81A47492D65B358C2912200
            08B97CE73D1718E7389F13B575F1278F3C23E049EF5DEFEF165D7A3D674784C3
            FD98B6735B9FDE49F690C16632795B5436F5F30118C9A00F72A2BCF3C73E286F
            0DF862EAF751F1E681E16B7CC708D56E6DD4240F23AA27FAC9F6E4B30500E464
            8E0D767712CD168F2C8264370B016F3A34C216DBF7829278CF38C9FA9A00D0A2
            BE726F8D9E356FD9EFE11F8F04BA20D4FC6173E168AF201A7CBE5443529ED526
            D9FBFCFCA276DB9CF415DFF866EEFB5AF8AFF10B4F9B54BD1636074F36D6F1CB
            8488C96E4BE0638C95071EB9F53401E9D4578CFC0ED4752BCF88BF1BEDAF354B
            ED46DF4FF15DBDA59C5793B48B6D17F63E9F2148C1E101795D881804B13D4935
            ADF16EDB50F1BDFE8BE06D2350B9D37ED5710EA5AD5FE9F74D6F716B610C81C2
            A3A8255E7951621CA9F2FCF656CC78201EA145789E93FB42AF8B7E32D87833C3
            566B71A6BDA6B266D56F15D51EE34FB8B38245818122440F7522337678585657
            883E3CF8A1FE145E78AF49D3B49B4BBB6F1B27853C8BB69674755F10A69324BF
            2EC20B2EE900E769207CD8E403E81A28AF22F12EA9AA7C4522E3C1CBA8695ACF
            8735F5B49AF1D6268678A3953ED70321994BA49113B723E57D8DC15A00F5DAE6
            FC697BE2AB0D2A297C23A368FAE6A6660B241ADEAD2E9B0AC5B5B2E248EDAE09
            6DC106DD801049DC3001F3C7D46DFE3ADE786B5ED361D71FC2FA06A7717319B1
            B94B46BCD42DE59ECDE293F7C8C6289D26CA91B64628412ABF3777F0BBE20D97
            C57F873E1AF19E9B697765A76BDA7C3A8DB5BDF055992395032870ACC33823A1
            340167E1EF892FBC63E02F0D6BFA9E8D71E1BD4754D32DAFAEB46BBDDE7584B2
            C4AEF6EFB954EE8D98A1CAA9CA9C81D28AE8E8A00F98FF006DCF06F88B54F0D5
            9F8BAC0E967C31E11D2757D535B4B89A44BD644862963FB2A8428E4882552AEC
            9CB210DC107CE7C09F06BC5BF0FBE3F7C2AD67C6F2E9B2C171AC5CDA6892693A
            94D752B91A2EA1B7ED2B2DBC62345811805467C36C19DAB93F52FC77F07EA1F1
            0FE08FC41F0AE92223AAEB9E1FBFD32D7CF7D9189A7B692242CDD9433824E0F1
            9E0F4ACFF117C2CD475AF16FC33D58EB924D0F857549B509E0B948FF007C1F4D
            BBB30A852352086BA0D9271853C648A00A96FE30F11DE6B3F12BC27AFE8B2476
            DA558A5EE99AFC31B2DBDFDADC24C04672302789A27570A482A637F977ED0FFD
            93BFE4D63E0DFF00D899A37FE90C3577E39FC54F0E7C27F87DAC6ABE279EF6CB
            4E167386BB874DB9BA8A33E539FDE3431B08C1DB805F68259541CB005BFB3768
            97FE18FD9DBE16E8FAA5B3D9EA5A7785B4BB4BAB7720B452C769123A1C646430
            238F4A00EB6F347D52E2EA6960D7A7B58588290A5B42C10607192A49E727F1AF
            9F60F0EEA7E2AD37C47E229B548EC20F86FE26D52F3C350E97670C714ED1E9F2
            432B5CAED21899AEAF410857A21EBBB3EEBE2EF1849A2C4D67A4593EB7E23994
            2DBE9F1121559B3B649DC644310C125DB9214840ED853CB68BF0C66F01FC04D5
            3C2B6F27F6B6B1369FA84F77730C453EDDA85D1966B89550B315124F348C1371
            DA182838028025D2FC03ABEA7F0F63B2B3F1A6A9A24DA8DB8B89350D3ADAD45C
            A4B2FEF24914C913AEE2CCC7254F5E31C63BC9F4882FF49FECFD4E38F5585E35
            49C5D448CB3118E5931B792338C6335E476FFB42F83AC7E1447791EA97115FC1
            A2F98BA71B19C5F2CAB0FF00AAFB394DFE6EE1B766376EE315DE683E2DD47C41
            F0D348D774DD1AED754D42C219A1D375756B492191D01C5C061BA30A4FCFF296
            001C2B1C0201E65E21F06E8DF103F694F09E9D068BA7B693E00B5935DBE74B40
            A06A770BE4D8A0206D2522FB5CA5792A5ADDB8C835E77FB3EFF63E89E04D2AFF
            00C469149E1AD4FC69AFE9F30BA702DA2D406BB786C64914F0773968C16CFEF0
            DBE064295F7BB18348F811E0BD5356D54DEDF3CD2CBABEBDABD969F2DCCB7170
            557CC99A2855E4DAA88A8AAA1B647122F4515E5FFB2AF86748F8AFFB274F65AB
            D94F71E1BF166A5AF5E471CC925B4B2D9DCEA9772C32AE76BA164749118608CA
            B03D0D007D315E41F19F47975AF89BF0455126315AF896F6EAE1A195A268E21A
            26A31EEDCA41FBF2C6BC1FE2F4CD45F02BC3FF00163C173EA9E18F1D6A3A4F8B
            3C37A7B2A687E2813BC7AA5DC18E12EE0D9B0CA98C1955C6EE0EDCE6B47C6875
            383C4F75E35D3743BBF129F0CE99716761A45A5D0864BD9E6647B8281C88D994
            410C68588E5E750474600F35F85B6337C42F84D63A478B750BA95AF35BD73FB4
            24D41DDEE65D3A2D66E960B7427E60922C7065B90D1C641CEE5234BE1378A6DF
            E20FC2BD5AFBC53E24D62FA4D3FC49ACA28D2269A19D60B2D5AE12D630B6A15D
            B11C110D9C99070C1B7107A7F076ABACF813E16E8BE1D16B06B3F111ADCB5C69
            96737996F6B7733192433CA0011C28D21F9880582FC8ACC42D63DECB2FECB3A0
            689AADEA6ABE24F0941A7AD9F88B52B2B633DCDACEAEF27F68B5B44B96477966
            12F94A4AE636DBB15CA807B8585EC5A9595BDD406430CF1ACA9E646D1B608C8C
            AB00CA7D41008E840AF3AF8F1AD6A0FE1AB7F06787EE1ED7C53E2F77D2ECEE22
            04B594057FD2AF721582F93116652C02995A142419057732788237D1E3D46D2D
            EE6F92750D6F0470B24929232A30FB76E7D5B0075240AC3F06F82AE34ED6350F
            126BB3C77DE28D45042EF09260B2B6524A5AC1900EC04E59C80D23E588501110
            0388F0DE93A77C06F895A7F87AC2C20D2FC15E28B5B7B5B136F0A4715BEA96B0
            0856291830C99AD218553E5C66C98672E8B5ED75CCFC42F0068FF13FC23A8786
            B5D86492C2F1411243218E6825560F1CD0C8398E58DD55D1C72ACA08E95C37C1
            7B8F8B7A4EA3A9786FE21E9FA66ADA7E98AABA778CECAEC24BAAC64B60CF6810
            08A5002EF2A769624AA81C50052F16DA477BFB5DFC3E8A48E39A35F057889A48
            DC020A9BDD1C720F5E4D79FF008CEFB52D17E19FED05F155341BEF0F788DF42D
            42D74396E74F092D9DA69D6D73F66919599972D70F73383B4652488303B6BDC2
            D743BCD6BE24EBFAC8BD92D2CEDAC2DB49B378235F3164123CF72E19C32B2B06
            B78F1B72A62939C91B78FF00DAAB49BB8FF660F8C0EDADDF48ABE0ED6098DD2D
            F6B0FB14DC1C440E0FB1068037BC39ACDED8E97E0AB17F0CEAFE256BEB78E3D4
            35F961B3885B91083E7CEA0C79DEF818863C0C93B540AF41D4D4269576AA02A8
            81C003A0F94D727A1786EE358F0269B6E3C49AAC315CE9D1279B68D6E8EAAD10
            194711654E0F0C0E4750735D4C3A6797A42D8CD733DD0F27C97B891879AFF2E0
            B12A00DC7AE401CD007C69672E8EDFB20FECD620D4BCEBFF00ED0F006EB6FED0
            79307ED761B87945C818E78C71ED5ED5E10BBD0B56F8DFF1785DE9ED7F258DD6
            976323369AF71B641611CC40608C31B2E233F526BB2BEF0EF843C07E01F0E786
            D7444D434AD063B48742D10A1BA98C968ABF651109092CF198D08918FC8543B3
            2ED2C2B78174097E1A786B5ED735BB67B9D775BD424D67575D22DE4B92256448
            D228D5177C822862862042E5BCBCE0671401C9FECE62D53E20FC791676FF0066
            B6FF0084CA0D9179261DBFF124D333F21008E73DAB2FE235CFC3ED37E305EF87
            E3D77FB2FC7BE26B386EAFE29F549F096480C42582CCBF96F336D6452887054B
            3E760567FEC99E30D3BE246ADF197C63A10BA93C3BAC78CB3A7DDDDD94D68D70
            21D32C2DE52239955C059A1950E547CC8C3A835E8926B3E2FBDF1EDFD9D8F82A
            CACB4CB50B02F89B52D41337319457C41044AD2305662A448D10CA92370C1201
            E6B770DAE95FB4CFC2AB0F0CE9AB696365E0BF105AC167751CB66B1C6B75A380
            0078CB1EDCE39E79CD79F34BA89FD9D355596D2D56DCFC6225E44B96670DFF00
            09DAE405F2C0233C67238E71DABD4BC512DFD97ED63F0D1AE233AA5CFF00C21F
            E220C2C6358401F6BD239DB249C0FF008113CD711E39F0F6B1E03F80B75A76B3
            A64D6ED75F142CF581324B1491AC177E3182EE20DB5CB6EF2E64040070D91923
            9A00FAC6BC57E13DB40D79E3E696DB57666F15DF90D6B71324647C8380AE07E9
            5EC1796C2EE031F9B243920EF85B6B0C1F5FD2AAFF00617FD446FF00FEFF00FF
            00F5A803C13F64AB7B66F830A5ADF5A76FF848FC47CC3753AAFF00C86EFBB090
            0CFAFBE73CD76DFB2869B79A3FECC7F0A74FD46CEE74EBFB4F0C69D05C5A5E42
            D0CD0C8B6E8ACAE8C01520823045735FB216922E3E08A48B7F78AA7C49E24C79
            73601FF89EDF8CF4EFD6BD62CFC136765E2C93C422F3559AFDED16C9926D4667
            B6F2C31618B7DDE507CB1F9C2EE23827000A00E9A8A28A00F3CF18E93E381F14
            BC19ADF874E9F79E1BB6B3BED3F5BD3F50D5A7B3FF005F3D8BC575146904A93C
            B125BDCAAAB98FFD7901D43357A1D145003258927429222BA1EAAC320D3E8A28
            02086DE280B98E348F7B176D8A06E63D49F53EF53D1450014514500359448A55
            806046083D0D32389208D511422280AAAA30001D00152D1400514514010DBDB4
            369108A089218C7448D4281F80A9A8A2800A28A2800A28A280228A35894AA285
            524B7CA31C93927F1249A8EEED61BFB69ADEE2249EDE5431C90CAA191D48C156
            0782083820D59A2801888B1A8550155460003000A7D1450043F678FCE336C5F3
            76ECF3368DDB739C67D2A6A28A006471242812345451D1546053E8A2801368CE
            71CFAD2D1450014514500416B6B0D94090DBC290429C2C7128555FA01585E34B
            DF155869514BE11D1B47D73533305920D6F56974D8562DAD9712476D704B6E08
            36EC00824EE1800F494500737F0F6CBC43A7780BC3569E2FBF8354F15C1A65B4
            5AC5FDA00B0DCDEAC4A27910044015A40E40D8BC11F28E80AE928A00FFD9}
        end
      end
      object qrbnd2: TQRBand
        Left = 38
        Top = 121
        Width = 835
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          66.145833333333340000
          2209.270833333333000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbDetail
        object qrshp7: TQRShape
          Left = 3
          Top = 2
          Width = 89
          Height = 25
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            66.145833333333340000
            7.937500000000000000
            5.291666666666667000
            235.479166666666700000)
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrshp8: TQRShape
          Left = 91
          Top = 2
          Width = 89
          Height = 25
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            66.145833333333340000
            240.770833333333300000
            5.291666666666667000
            235.479166666666700000)
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrshp9: TQRShape
          Left = 179
          Top = 2
          Width = 89
          Height = 25
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            66.145833333333340000
            473.604166666666700000
            5.291666666666667000
            235.479166666666700000)
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrdbtxtid: TQRDBText
          Left = 11
          Top = 5
          Width = 11
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.916666666666660000
            29.104166666666670000
            13.229166666666670000
            29.104166666666670000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'id'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtname: TQRDBText
          Left = 100
          Top = 5
          Width = 33
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.916666666666660000
            264.583333333333400000
            13.229166666666670000
            87.312500000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'name'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrdbtxtnote: TQRDBText
          Left = 190
          Top = 5
          Width = 26
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.916666666666660000
            502.708333333333400000
            13.229166666666670000
            68.791666666666680000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataSet = ADOQuery1
          DataField = 'note'
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      object qrbnd3: TQRBand
        Left = 38
        Top = 146
        Width = 835
        Height = 41
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        TransparentBand = False
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          108.479166666666700000
          2209.270833333333000000)
        PreCaluculateBandHeight = False
        KeepOnOnePage = False
        BandType = rbPageFooter
        object qrshp12: TQRShape
          Left = -3
          Top = 8
          Width = 840
          Height = 33
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            87.312500000000000000
            -7.937500000000000000
            21.166666666666670000
            2222.500000000000000000)
          Pen.Style = psDot
          Shape = qrsRectangle
          VertAdjust = 0
        end
        object qrlbl5: TQRLabel
          Left = 196
          Top = 16
          Width = 444
          Height = 20
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            52.916666666666660000
            518.583333333333400000
            42.333333333333340000
            1174.750000000000000000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = #25216#26415#25903#25345' '#22307#23665'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          Color = clWhite
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qrsysdt1: TQRSysData
          Left = 696
          Top = 21
          Width = 68
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.979166666666670000
            1841.500000000000000000
            55.562500000000000000
            179.916666666666700000)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          Color = clWhite
          Data = qrsDateTime
          Transparent = False
          FontSize = 10
        end
      end
    end
  end
  object pnl2: TPanel
    Left = -8
    Top = 529
    Width = 913
    Height = 65
    Caption = 'pnl2'
    TabOrder = 1
    object btn1: TButton
      Left = 200
      Top = 24
      Width = 113
      Height = 25
      Caption = #39044#35272
      TabOrder = 0
      OnClick = btn1Click
    end
    object btn2: TButton
      Left = 600
      Top = 24
      Width = 113
      Height = 25
      Caption = #25171#21360
      TabOrder = 1
      OnClick = btn2Click
    end
  end
  object ADOQuery1: TADOQuery
    Connection = Fr_Pass.ADOConnection1
    Parameters = <>
    Left = 40
    Top = 65535
  end
end
