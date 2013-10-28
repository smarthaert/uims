unit psCodeSpecs;

interface

uses Classes, {Windows, }SysUtils, TypInfo, psTypes, psCodeFNLite;

{$I psBarcode.inc}

  function  BarcodeInfo(T:TpsBarcodeSymbology; Barcode:string=''):TpsBarCodeInfo;
  function  BarcodeInfoItem(const BI:TpsBarcodeInfo; ItemType:TpsBarcodeInfoItemType):String; overload;
  function  BarcodeInfoItem(T:TpsBarcodeSymbology; ItemType:TpsBarcodeInfoItemType):String; overload;
  function  TypBarcodeEnum(T:TpsBarcodeSymbology):String;
  function  psCount(st:TbcSymbolTypes; sup:Boolean):Integer;

  function  psCreateSymbologyList(fn:TFileName; separator:char=';'):Boolean;

implementation

function Ean13Country(Barcode:string):string;
var country,code:integer;
begin
        Result:='';
        Val(Copy(Barcode,1,3),country,Code);
        if Code<>0 then Exit;

        case Country of
                00..130 : result:='U.S.A. & Canada';
                200..290: result:='In-store numbers';
                300..370: result:='France';
                380     : result:='Bulgaria';
                383     : result:='Slovenia';
                385     : result:='Croatia';
                387     : result:='Bosnia-Herzegovina';
                400..440: result:='Germany';
                450..459: result:='Japan';
                460..469: result:='Russian Federation';
                471     : result:='Taiwan';
                474     : result:='Estonia';
                475     : result:='Latvia';
                477     : result:='Lithuania';
                479     : result:='Sri Lanka';
                480     : result:='Philippines';
                482     : result:='Ukraine';
                484     : result:='Moldova';
                485     : result:='Armenia';
                486     : result:='Georgia';
                487     : result:='Kazakhstan';
                489     : result:='Hong Kong';
                490..491: result:='Japan';
                500..509: result:='U.K.';
                520     : result:='Greece';
                528     : result:='Lebanon';
                529     : result:='Cyprus';
                531     : result:='Macedonia';
                535     : result:='Malta';
                539     : result:='Ireland';
                540..549: result:='Belgium & Luxembourg';
                560     : result:='Portugal';
                569     : result:='Iceland';
                570..579: result:='Denmark';
                590     : result:='Poland';
                594     : result:='Rumania';
                599     : result:='Hungary';
                600..601: result:='South Africa';
                609     : result:='Mauritius';
                611     : result:='Maroc';
                613     : result:='Algeria';
                619     : result:='Tunisia';
                622     : result:='Egypt';
                626     : result:='Iran';
                640..649: result:='Finland';
                690..692: result:='China';
                700..709: result:='Norge';
                729     : result:='Israel';
                730..739: result:='Sweden';
                740..745: result:='Guatemala, El Salvador, Honduras, Nicaragua, Costa Rica, Panama';
                746     : result:='Republica Dominica';
                750     : result:='Mexico';
                759     : result:='Venezuela';
                760..769: result:='Suisse';
                770     : result:='Colombia';
                773     : result:='Uruguay';
                775     : result:='Peru';
                777     : result:='Bolivia';
                779     : result:='Argentina';
                780     : result:='Chile';
                784     : result:='Paraguay';
                786     : result:='Ecuador';
                789     : result:='Brazil';
                800..830: result:='Italy';
                840..849: result:='Spain';
                850     : result:='Cuba';
                858     : result:='Slovakia';
                859     : result:='Chech';
                860     : result:='Yugoslavia';
                869     : result:='Turkey';
                870..879: result:='Nederland';
                880     : result:='South Corea';
                885     : result:='Thailand';
                888     : result:='Singapore';
                890     : result:='India';
                893     : result:='Vietnam';
                899     : result:='Indonesia';
                900..919: result:='Austria';
                930..939: result:='Australia';
                940..949: result:='New Zealand';
                955     : result:='Malaysia';
                977     : result:='Periodicals';
                978,979 : result:='Books';
                980     : result:='Refund receipts';
                990..999: result:='Coupons';
        end;
end;


function BarcodeInfo(T:TpsBarcodeSymbology; Barcode:string):TpsBarCodeInfo;

const _lowersign =' !"#$%&''()*+,-./';
      _middlesign=':;<=>?@';
      _numbers  ='0123456789';
      _UpperCase='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      _LowerCase='abcdefghijklmnopqrstuvwxyz';
var i:integer;

begin
   with Result do begin
        SelectedSymbology:= T;

        Length         := 0;
        Chars          := _Numbers;
        EnabledAdd     := False;
        Supported      := True;
        SymbolType     := stLinear;
        LongName       := '';

        VariableRatio  := T in [bc25Datalogic,bc25Matrix,bc25Industrial,
            bc25Interleaved, bc25Coop, bcCode11];

        case T of
          bcPostNet, bcPlanet, bcRoyalMail, bc4State, bcDutch4StatePostal,
          bcTelepen,
          //bcTelepenNumeric,
          bcSwissPostal,
          //bcSingapore4State,
          //bcPostbarCPC4State, bcCPCBinary,
          bcFim, bcIntelligentMail, bcAustraliaPost
          //bcJapanPost,
          //bcDeutschePostIdentcode,bcDeutschePostLeitcode,bcKoreanPost

                : SymbolType := stPostalCode;

          //bcCode49,
          bcPDF417, bcCode16K, bcCodablockF
            //bcCodablock256
            : SymbolType := stStacked;

          bcQRCode,  bcAztec,
          //bcAztecMESAS,
          bcDatamatrix
          //bcMaxicode, bcCodeOne, bcMiniCode, bcDotCodeA, bcGoCode, bcSecryptCode,
          //bcSnowFlake, bcVericode, bcVSCode, bcSemacode

                : SymbolType := stMatrix;
          // bcChromocode : SymbolType := stColorCode;
        end;

        if T in [bcUPCA,bcUPCE0, bcUPCE1, bcUPCShipping] then
            Country := 'USA' ;

        case T of
             bcNone          : begin
                                  Name           := 'Undefined symbology';
                               end;
             bcEan8          : begin
                                  Name           := 'EAN 8';
                                  LongName       := 'EAN 8 (2 or 5 digit supplement)';
                                  InitValue      := '1234567';
                                  ParentCode     := bcEan13;
                                  Year           := 1977;
                                  Country        := 'EU';
                                  EnabledAdd     := True;
                                  OptCharWidthMM := 2.5;
                               end;
             bcEan13         : begin
                                  Name           := 'EAN 13';
                                  LongName       := 'EAN 13 (2 or 5 digit supplement)';
                                  InitValue      := '9771210107001';
                                  ParentCode     := bcEan13;
                                  Year           := 1977;
                                  Country        := 'EU';
                                  EnabledAdd     := True;
                                  OptCharWidthMM := 2.5;
                                  CodeContry     := Ean13Country(Barcode);
                               end;
             bcCodabar       : begin
                                  Name           := 'Codabar';
                                  LongName       := 'Codabar (Monarch, NW-7, USD-4, 2 of 7 code)';
                                  InitValue      := 'A0123+-$/:68A';
                                  Chars          := _numbers+'-$:/.+abcdtn*eABCDETN';
                                  ParentCode     := bcCodabar;
                                  Year           := 1972;
                                  OptCharWidthMM := 4;
                               end;
             bcCode39Standard: begin
                                  Name           := 'Code 39 Standard';
                                  LongName       := 'Code 39 Standard';
                                  InitValue      := 'PSOFT';
                                  Chars          := _numbers+_UpperCase+'-. $/+%';
                                  ParentCode     := bcCode39Standard;
                                  Year           := 1972;
                                  OptCharWidthMM := 4;
                               end;
             bcCode39Full    : begin
                                  Name           := 'Code 39 Extended';
                                  LongName       := 'Code 39 Extended';
                                  InitValue      := 'PSOFT';
                                  Chars          :={ #1#2#3#4#5#6#7#8#9#10
                                     + #11#12#13#14#15#16#17#18
                                     + #19#20#21#22#23#24#25#26
                                     + #27#28#29#30#31
                                     +}' !"#$%&''()*+,-./'+_numbers
                                     +':;<=>?@'+_UpperCase
                                     +'[\]^_`'
                                     +'abcdefghijklmnopqrstuvwxyz{|}~'#128;
                                  ParentCode     := bcCode39Standard;
                                  Year           := 1974;
                                  OptCharWidthMM := 4;
                               end;
             bcCode93Standard: begin
                                  Name           := 'Code 93 Standard';
                                  LongName       := 'Code 93 Standard';
                                  InitValue      := 'PSOFT';
                                  Chars          := _numbers+_UpperCase+'-. $/+%&"()';
                                  ParentCode     := bcCode93Standard;
                                  Year           := 1982;
                                  OptCharWidthMM := 4;
                               end;
             bcCode93Full    : begin
                                  Name           := 'Code 93 Extended';
                                  LongName       := 'Code 93 Extended';
                                  InitValue      := 'PSOFT';
                                  Chars          := ' !"#$%&''()*+,-./'
                                    +_numbers
                                    +':;<=>?@'
                                    +_UpperCase
                                    +'[\]^_`'
                                    +_LowerCase
                                    +'{|}~';
                                  ParentCode     := bcEan13;
                                  Year           := 1974;
                                  OptCharWidthMM := 4;
                               end;
             bcCode128       : begin
                                  Name           := 'Code 128';
                                  InitValue      := 'PSOFT';
                                  Chars:='';
                                  for i:=2 to 127 do
                                      Chars := Chars+Chr(i-1);

                                  ParentCode     := bcCode128;
                                  Year           := 1981;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bcABCCodabar    : begin
                                  Name           := 'AbcCodabar';
                                  InitValue      := 'ABCCBA';
                                  Chars          := _numbers+'-$:/.+ABCD ';
                                  ParentCode     := bcCodabar;
                                  Year           := 1977;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bc25Datalogic   : begin
                                  Name           := '2/5 Datalogic';
                                  LongName       := '2/5 Datalogic, Code25, 2 of 5';
                                  InitValue      := '123456';
                                  ParentCode     := bc25Datalogic;
                                  Year           := 1968;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bc25Interleaved : begin
                                  Name           := '2/5 Interleaved (ITF)';
                                  LongName       := 'Code25, 2 of 5, ITF';
                                  InitValue      := '123456';
                                  ParentCode     := bc25Datalogic;
                                  Year           := 1972;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bc25Matrix      : begin
                                  Name           := '2/5 Matrix ';
                                  LongName       := 'Code25, 2/5 Matrix';
                                  InitValue      := '123456';
                                  ParentCode     := bc25Datalogic;
                                  Year           := 1968;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bc25Industrial  : begin
                                  Name           := '2/5 Industrial';
                                  LongName       := 'Code25, 2/5 Industrial';
                                  InitValue      := '123456';
                                  ParentCode     := bc25Datalogic;
                                  Year           := 1972;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bc25IATA        : begin
                                  Name           := '2/5 IATA';
                                  LongName       := 'Code25, 2/5 IATA';
                                  InitValue      := '123456';
                                  ParentCode     := bc25Datalogic;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bc25Invert      : begin
                                  Name           := '2/5 INVERT';
                                  LongName       := 'Code25, 2/5 INVERT';
                                  InitValue      := '123456';
                                  ParentCode     := bc25Datalogic;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bcITF           : begin
                                  Name           := 'ITF';
                                  LongName       := 'ITF6, ITF14 (SSC14), ITF16';
                                  InitValue      := '0977121010700';
                                  ParentCode     := bc25Interleaved;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 3;
                               end;
             bcISBN          : begin
                                  Name           := 'ISBN (Bookland)';
                                  LongName       := 'ISBN (International Standard Book Number)';
                                  InitValue      := '80-7226-102';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  Country        := '';
                                  EnabledAdd     := True;
                                  AutoCaption    := False;
                                  OptCharWidthMM := 2.5;
                               end;
             bcISSN          : begin
                                  Name           := 'ISSN';
                                  LongName       := 'ISSN (International Standard Serial Number)';
                                  InitValue      := '80-7226-102';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  Country        := '';
                                  EnabledAdd     := True;
                                  AutoCaption    := False;
                                  OptCharWidthMM := 2.5;
                               end;
             bcISMN          : begin
                                  Name           := 'ISMN';
                                  LongName       := 'ISMN (International Standard Music Number)';
                                  InitValue      := '80-7226-102';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  Country        := '';
                                  EnabledAdd     := True;
                                  OptCharWidthMM := 2.5;
                               end;
             bcUPCA          : begin
                                  Name           := 'UPC-A';
                                  LongName       := 'UPC-A (with or without supplements)';
                                  InitValue      := '01234567890';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  EnabledAdd     := True;
                                  OptCharWidthMM := 2.5;
                               end;
             bcUPCE0         : begin
                                  Name           := 'UPC-E0';
                                  LongName       := 'UPC-E0 (with or without supplements)';
                                  InitValue      := '0123456';
                                  ParentCode     := bcEan13;
                                  EnabledAdd     := True;
                                  OptCharWidthMM := 2.5;
                               end;
             bcUPCE1         : begin
                                  Name           := 'UPC-E1';
                                  LongName       := 'UPC-E1 (with or without supplements)';
                                  InitValue      := '0123456';
                                  ParentCode     := bcEan13;
                                  EnabledAdd     := True;
                                  OptCharWidthMM := 2.5;
                               end;
             bcUPCShipping   : begin
                                  Name           := 'UPC-Shipping';
                                  LongName       := 'UPC-Shipping';
                                  InitValue      := '1234567890123';
                                  ParentCode     := bc25Interleaved;
                                  EnabledAdd     := True;
                                  OptCharWidthMM := 2.5;
                               end;
             bcJAN8          : begin
                                  Name           := 'JAN8';
                                  LongName       := 'Japanese version of  EAN 8';
                                  InitValue      := '49123456';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  Country        := '';
                                  EnabledAdd     := True;
                                  AutoCaption    := False;
                                  OptCharWidthMM := 2.5;
                               end;
             bcJAN13         : begin
                                  Name           := 'JAN13';
                                  LongName       := 'Japanese version of  EAN 13';
                                  InitValue      := '491234567890';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  Country        := '';
                                  EnabledAdd     := True;
                                  AutoCaption    := False;
                                  OptCharWidthMM := 2.5;
                               end;

             bcMSIPlessey    : begin
                                  Name           := 'MSI/Plessey';
                                  LongName       := 'MSI/Plessey (Modified)';
                                  InitValue      := '';
                                  Chars          := _numbers+'ABCDEF';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  Country        := 'USA';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 2.5;
                                  Supported      := False;
                               end;
             bcPostNet       : begin
                                  Name           := 'PostNet';
                                  LongName       := 'PostNet (ZIP, ZIP+4, DPBC)';
                                  InitValue      := '12345678901';
                                  Chars          := _numbers+'ABCDEF';
                                  ParentCode     := bcPostNet;
                                  Year           := 0;
                                  EnabledAdd     := True;
                                  Country        := 'USA';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
               bcPlanet:       begin
                                  Name           := 'Planet';
                                  LongName       := 'Planet Barcode';
                                  InitValue      := '12345678901';
                                  Chars          := _numbers;
                                  ParentCode     := bcPlanet;
                                  Year           := 0;
                                  Country        := 'USA';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
               bcRoyalMail:    begin
                                  Name           := 'Royal Mail Barcode';
                                  LongName       := 'Royal Mail Barcode, RMS4CC';
                                  InitValue      := '123456789';
                                  ParentCode     := bcRoyalMail;
                                  Year           := 0;
                                  Chars          := _Numbers+_UpperCase;
                                  Country        := 'UK';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
               bc4State   :    begin
                                  Name           := '4 State barcode';
                                  LongName       := '4 State barcode';
                                  InitValue      := '123456';
                                  ParentCode     := bcRoyalMail;
                                  Year           := 0;
                                  Chars          := _Numbers+_UpperCase;
                                  Country        := 'UK';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
               bcDutch4StatePostal:    begin
                                  Name           := 'Dutch 4-State Postal';
                                  LongName       := 'Dutch 4-State Postal';
                                  InitValue      := '3224BC10';
                                  ParentCode     := bcRoyalMail;
                                  Year           := 0;
                                  Chars          := _Numbers+_UpperCase;
                                  Country        := 'DE';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
               bcSwissPostal:   begin
                                  Name           := 'SwissPostal';                                  LongName       := 'Royal Mail Barcode, RMS4CC';
                                  InitValue      := '123456789';
                                  ParentCode     := bcRoyalMail;
                                  Year           := 0;
                                  Chars          := _Numbers+_UpperCase;
                                  Country        := 'UK';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                                  Supported      := False;
                               end;

              bcSingapore4StatePostalCode:    begin
                                  Name           := 'Singapore Post 4-State Mail Code';
                                  LongName       := 'Singapore Post 4-State Mail Code';
                                  InitValue      := '123456';
                                  ParentCode     := bcRoyalMail;
                                  Year           := 0;
                                  Chars          := _Numbers+_UpperCase;
                                  Country        := 'JPN';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
              bcPostBar:    begin
                                  Supported      := True;
                                  Name           := 'PostBar';
                                  LongName       := 'PostBar, CPC 4 State';
                                  InitValue      := '123456';
                                  ParentCode     := bcPostBar;
                                  Year           := 0;
                                  Chars          := _Numbers+_UpperCase;
                                  Country        := 'CAN';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
              bcPostbarCPC4State :    begin
                                  Name           := 'CPC 4-state';
                                  LongName       := 'Postbar, CPC 4-state, Canada Postís 4-State Bar Code Symbology';
                                  InitValue      := 'B K1A 4S2 1234';
                                  ParentCode     := bcNone;
                                  Chars          := 'ABCDEFGHIJKLMNOPRSTVUVWXYZ0123456789 ';
                                  Country        := 'CAN';
                                  Supported      := False;
                          end;


             bcOPC           : begin
                                  Name           := 'OPC';
                                  LongName       := 'OPC (Optical Industry Association)';
                                  InitValue      := '1234567897';
                                  Chars          := _numbers+'ABCDEF';
                                  ParentCode     := bcEan13;
                                  Year           := 0;
                                  Country        := 'USA';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                               end;
             bcUccEan128     : begin
                                  Name           := 'UCC/EAN 128';
                                  LongName       := 'UCC/EAN 128';
                                  InitValue      := '';
//                                  Chars          := ' !"#$%&''()*+,-./'+_numbers+':;<=>?@'
//                                    +_UpperCase
//                                    +'[\]^_`'
//                                    +_LowerCase
//                                    +'{|}~öËùû˝·ÌÈ';
                                  Chars := _numbers + '()'+#$1D+'[~';
                                  ParentCode     := bcCode128;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bc25Coop : begin
                                  Name           := '2/5 Coop';
                                  LongName       := 'Code25, 2/5 Matrix';
                                  InitValue      := '123456';
                                  Chars          := _numbers;
                                  ParentCode     := bc25Matrix;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bcCode11 : begin
                                  Name           := 'Code 11';
                                  LongName       := 'Code 11 (USD-8)';
                                  InitValue      := '123456';
                                  Chars          := _numbers+'-';
                                  // ParentCode     := bc25Matrix;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bcPZN : begin
                                  Name           := 'PZN';
                                  LongName       := 'Pharma-Zentral-Nummer';
                                  InitValue      := '123456';
                                  Chars          := _numbers;
                                  Parentcode     := bcCode39Standard;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                               end;
             bcSCC14 : begin
                                  Name           := 'SCC-14';
                                  LongName       := 'Shipping Container Code (EAN/UCC-14,SCC-14)';
                                  InitValue      := '1234567890123';
                                  Chars          := _numbers;
                                  Parentcode     := bcCode128;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 4;
                                  Supported      := False;
                               end;
             bcPDF417 : begin
                                  Name           := 'PDF417';
                                  LongName       := 'PDF417, MicroPDF417, MAcroPDf, PDF417 Truncated';
                                  InitValue      := 'PSOFT, http://www.psoft.sk, email: peter@psoft.sk';
                                  Chars          := '';
                                  // Parentcode     := bcCode39Standard;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                               end;
             bcCodaBlockF: begin
                                  Supported      := False;
                                  Name           := 'CodabarF';
                                  LongName       := 'CodabarF';
                                  InitValue      := '123ABC';
                                  Chars          := '';
                                  Parentcode     := bcCode128;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                               end;
             bcSSCC: begin
                                  Supported      := False;
                                  Name           :='SSCC';
                                  LongName       := 'Serial Shipping Container Code';
                                  InitValue      := '';
                                  Chars          := '';
                                  Parentcode     := bcCode128;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                               end;
             bcSISAC: begin
                                  Supported      := False;
                                  Name           := 'SISAC';
                                  LongName       := '';
                                  InitValue      := '';
                                  Chars          := '';
                                  Parentcode     := bcCode128;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                               end;
             bcCode16K: begin
                                  Supported      := False;
                                  Name           :='Code16K';
                                  LongName       := '';
                                  InitValue      := '12345678901234567890';
                                  Chars          := '';
                                  Parentcode     := bcCode128;
                                  Year           := 0;
                                  Country        := '';
                                  AutoCaption    := False;
                               end;
             bcCodabarMonarch: begin
                                  Supported      := False;
                                  Name           :='Codabar Monarch';
                                  LongName       := 'Codabar Monarch, NW-7';
                                  InitValue      := '';
                                  Chars          := '0123456789$-:/.+abcdtn*eABCDETN';
                                  Parentcode     := bcCodabar;
                                  Year           := 0;
                                  Country        := 'SUI';
                                  AutoCaption    := False;
                               end;
             bcFim: begin
                                  Name := 'FIM' ;
                                  LongName := 'FIM A,B,C,D';
                                  InitValue:='A';
                                  Chars:='ABCD';
                    end;
        {$ifdef PSOFT_PROF}
             bcIntelligentMail: begin
                Name           := 'InteligentMail barcode';
                LongName       := 'OneCode 4CB, USPS 4CB, 4-CB, 4-State Customer Barcode, USPS OneCode Solution Barcode';
                InitValue      := '01-234-567094-987654321-01234567891';
                Chars          := '0123456789- /';
                Year           := 2007;
                Country        := 'USPS (USA)';
              end;
             bcAustraliaPost : begin
                Name           := 'Australia Post Barcode';
                LongName       := 'Australia 4-state postal barcode, Australia Post Customer Barcode';
                InitValue      := '1196184209';
                Chars          :=
                  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ';
                Country        := 'Australia';
              end;
              bcTelepen:      begin
                                  Name           := 'Telepen';
                                  LongName       := 'Telepen';
                                  InitValue      := '123456789';
                                  ParentCode     := bcTelepen;
                                  Year           := 1972;
                                  Country        := 'UK';
                                  AutoCaption    := False;
                                  OptCharWidthMM := 6;
                                  Chars          :='';
                               end;

             {bcPostbarCPC4State :    begin
                Name           := 'CPC 4-state';
                LongName       := 'Postbar, CPC 4-state, Canada Postís 4-State Bar Code Symbology';
                InitValue      := 'B K1A 4S2 1234';
                ParentCode     := bcNone;
                Chars          := 'ABCDEFGHIJKLMNOPRSTVUVWXYZ0123456789 ';
                Country        := 'CAN';
              end;
              }
        {$endif}

        {$ifdef PSOFT_STUDIO}
            bcDataMatrix: begin
                Name           := 'DataMatrix';
                InitValue      := 'Authors homepage : http://barcode-software.eu , http://psoft.sk';
                Chars          := '';
              end;
            bcQRCode : begin
                Name           := 'QR Code';
                LongName       := 'QR code, Code QR, Quick Response code, Micro QR code';
                InitValue      := 'Authors homepage : http://barcode-software.eu , http://psoft.sk';
                Chars          := '';
              end;
            bcAztec : begin
                Name           := 'Aztec code';
                LongName       := 'Aztec code, Aztec MESAS';
                InitValue      := 'Authors homepage : http://barcode-software.eu , http://psoft.sk';
                Chars          := '';
                Supported      := False;
              end;

        {$endif}
        end;

        if LongName='' then
              LongName := Name;
   end;
end;


function  BarcodeInfoItem(const BI:TpsBarcodeInfo; ItemType:TpsBarcodeInfoItemType):String;
begin
  case ItemType of
    // itSupported   : Result := YesNo(BI.Supported);
    itName        : Result := BI.Name;
    itLongName    : if BI.LongName='' then Result := BI.Name
                    else                   Result := BI.LongName;
    itEnumName    : Result := TypBarcodeEnum(BI.SelectedSymbology);
    itInitValue   : Result := BI.InitValue;
//    itChars       : Result := CharSetDescription(BI.Chars);
//    itCharsString : Result := CharSetAvailable(BI.Chars);
//    itParentCode  : Result := GetEnumName(TypeInfo(TpsBarcodeSymbology), Integer(BI.ParentCode));
    itYear        : Result := IntToStr(BI.Year);
    itCountry     : Result := BI.Country;
//    itEnabledAdd  : Result := YesNo(soEnabledAdd in BI.Options);
    itAutoCaption : Result := YesNo(BI.AutoCaption);
//    itLength      : Result := BI.Lengths;
    itPrefix      : Result := BI.Prefix;
    itSuffix      : Result := BI.Suffix;
    itSymbolType  : Result := GetEnumName(TypeInfo(TpsSymbolType),Integer(BI.SymbolType));
//    itOptions     : Result := SymbologyOptionsAsString(BI.Options);
//    itCountTotal .. itCount2DBoth : Result := GetCountSymbologies(ItemType);

//    itSymbolName  : Result := !!!! dorobit
  end;
end;

function  BarcodeInfoItem(T:TpsBarcodeSymbology; ItemType:TpsBarcodeInfoItemType):String;
var BI:TpsBarcodeInfo;
begin
  BI:=BarcodeInfo(T,'');
  Result := BarcodeInfoItem(BI,ItemType);
end;


function  TypBarcodeEnum(T:TpsBarcodeSymbology):String;
begin
    Result:=GetEnumName(TypeInfo(TpsBarcodeSymbology),Integer(T));
end;

function psCount(st:TbcSymbolTypes; sup:Boolean):Integer;
var i   : TpsBarcodeSymbology;
    BI  : TpsBarCodeInfo;
    cnt : Integer;
begin
  cnt := 0;

  for I := Low(TpsBarcodeSymbology) to High(TpsBarcodeSymbology) do begin
    BI:=BarcodeInfo(I);
    if (st=[]) or (BI.SymbolType in st) then begin
        if sup and (not BI.Supported) then Continue
        else
            Inc(cnt);
    end;
  end;
  Result := cnt;
end;



function psCreateSymbologyList(fn:TFileName; separator:char=';'):Boolean;
var s, s1:string;
    L:TStringList;
    i:TpsBarcodeSymbology;
    BI:TpsBarcodeInfo;
    idx:Integer;
begin
      Result := True;
      L:=TStringList.Create;
      try
        idx:=0;
        for i := low(TpsBarcodeSymbology) to high(TpsBarcodeSymbology) do begin
            if i= bcNone then
                Continue;
            BI:=BarcodeInfo(i);
            if not BI.Supported then
                Continue;

            // s := GetEnumName(TypeInfo(TpsBarcodeSymbology), Integer(i));
            Inc(idx);
            s :=  BarcodeInfoItem(BI, itEnumName);
            s1:=  BarcodeInfoItem(BI, itSymbolType);
            L.Add(Format('%d;%s;%s;%s;%d;%s;%s',
              [idx, BI.Name, BI.LongName, s, Integer(i), BI.InitValue, s1]));
        end;
        L.SaveToFile(fn);
      finally
        L.Free;
      end;
end;



end.
