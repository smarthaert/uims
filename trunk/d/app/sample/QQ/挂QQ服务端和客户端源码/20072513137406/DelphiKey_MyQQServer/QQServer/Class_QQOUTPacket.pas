//挂QQ服务端，如需WEB版挂QQ的，自己来改造，本人现在没有精力改造了
//不需要的东西都已经取消了
//提供该程序只是用来学习目的，千万不要用于非法用途，后果自负
//用到RX控件，和JCL库，请大家自行下载
//如果不能挂QQ的话，那就请看LumqQQ中的相关协议，改成新协议即可
//如有更新希望发一份给我 QQ:709582502 Email:Touchboy@126.com 

unit Class_QQOUTPacket;

interface

uses
  Windows,Messages, SysUtils, Variants, Classes, Class_QQTEA,Class_Record;
Type
   TQQOutPacket=Class
   private
     FGreenValue: Byte;
     FBlueValue: Byte;
     FRedValue: Byte;
   public
      Function LoginToken( QQNum :Integer):TMyByte;
      Function LoginPacket(QQNum :integer; QQHide:Boolean;
       LoginKey,PasswordKey:Array of Byte;LoginToken:TMyByte):TMyByte;

      Function SendIMPacket(FromQQNum:integer;ToQQNum:integer;
              SessionKey:Array of Byte;NowTime:integer;StrSend:String;var nSendLen:integer):TMyByte;

      Function KeepAlivePacket(QQNum:Integer;SessionKey:Array of Byte;Var nSendLen:integer):TMYByte;
      Function LogoutPacket(QQNum :integer; SessionKey, PasswordKey:Array of Byte;Var nSendLen:integer):TMYByte;

      Function  ChangeStatus(BStatus,BFakeCom:Boolean;SessionKey,
                  PasswordKey:Array of Byte;Var nSendLen:integer):TMYByte;

      property   RedValue   :Byte Read FRedValue   Write FRedValue;
      property   GreenValue :Byte Read FGreenValue Write FGreenValue;
      property   BlueValue  :Byte Read FBlueValue  Write FBlueValue;
   end;


var
  QQOutPacket:TQQOutPacket;

implementation


Function TQQOutPacket.LoginToken( QQNum :Integer):TMyByte;
var
   Packet:array[0..12] of byte;
   QQBuff:array[0..3] of byte;
begin
    CopyMemory(@QQBuff[0], @QQNum, 4 );
    Packet[0] := $2;                      //头部
    Packet[1] := $D;                      //'客户端版本号码
    Packet[2] := $51;
    Packet[3] := $0 ;                     //'命令类型
    Packet[4] := $62 ;
    Packet[5] := Trunc(Random * 256);//          // '包序号
    Packet[6] := Trunc(Random * 256);
    Packet[7] := QQBuff[3] ;//               //'用户 QQ 号
    Packet[8] := QQBuff[2]  ;//;
    Packet[9] := QQBuff[1]  ;//
    Packet[10] := QQBuff[0]    ;//
    Packet[11] := $0;//                   // '请求登陆令牌
    Packet[12] := $3;//                     //'结尾
    //Result := Packet;
    //SetLength(Result,13);
    CopyMemory(@Result[0],@Packet[0],13);
end;

Function TQQOutPacket.LoginPacket(QQNum :integer; QQHide:Boolean;
    LoginKey,PasswordKey:Array of Byte;LoginToken:TMyByte):TMyByte;
var
   Packet:array[0..459] of byte;
   QQBuff:array[0..3] of byte;
   Free:array of byte;
   PasswordEncode,
   Crypt:TMyByte;
   Plain :array[0..415] of byte;
   i:integer;
   nSendLen:integer;
begin
    If high(LoginKey) <> 15 Then Exit ;
    If high(PasswordKey) <> 15 Then Exit ;
    For i:=0 to 459 do
      Packet[i]:=0;

    For i:=0 to 415 do
      Plain[i]:=0;
    InitArray(Crypt);
    
    //If high(LoginToken) <> 23 Then Exit;
    CopyMemory(@QQBuff[0],@QQNum,4);
    Packet[0] := $2 ;//                     '头部
    Packet[1] := $D  ;//                     '客户端版本号码
    Packet[2] := $51  ;//
    Packet[3] := $0  ;//                     '命令类型
    Packet[4] := $22  ;//
    Packet[5] := 1;//Trunc(Random * 256) ;//           '包序号
    Packet[6] := 1;//Trunc(Random * 256);//
    Packet[7] := QQBuff[3];   ;//              '用户 QQ 号
    Packet[8] := QQBuff[2];   ;//
    Packet[9] := QQBuff[1];   ;//
    Packet[10]:= QQBuff[0];    ;//
    //'初始密钥
    CopyMemory(@Packet[11], @LoginKey[0],16);

    SetLength(Free,16);


    //'密码密钥
    PasswordEncode := QQTEA.Encrypt(Free, PasswordKey,nSendLen);

    CopyMemory(@Plain[0], @PasswordEncode[0], 16);

    //'固定字节
    Plain[35] := $13; Plain[36] := $F1; Plain[37] := $CD; Plain[38] := $6E; Plain[39]:= $3   ;
    Plain[40] := $1F; Plain[41] := $2D; Plain[42] := $73; Plain[43] := $5E; Plain[44] := $CD  ;
    Plain[45] := $33; Plain[46] := $DB; Plain[47] := $5F; Plain[48] := $D0; Plain[49] := $C5  ;
    Plain[50] := $B;  Plain[51] := $1;

    //'状态: 在线/隐身
    If QQHide = True Then Plain[52] := $28 Else Plain[52] := $A;

    //'固定字节
    Plain[53] := $DF; Plain[54] := $B2; Plain[55] := $81; Plain[56] := $D3; Plain[57] := $F2 ;
    Plain[58] := $A0; Plain[59] := $32; Plain[60] := $46; Plain[61] := $93; Plain[62] := $EE ;
    Plain[63] := $6;  Plain[64] := $B8; Plain[65] := $50; Plain[66] := $2B; Plain[67] := $C9;
    Plain[68] := $FE; Plain[69] := $18;
    //'登陆令牌
    CopyMemory(@Plain[70], @LoginToken[0], 24);

    //'固定字节
    Plain[94] := $1;Plain[95] := $40;

    //'加密数据包
    Crypt := QQTEA.Encrypt(Plain, LoginKey,nSendLen);
    CopyMemory(@Packet[27], @Crypt[0], 432);
    //'包尾
    Packet[459]:= $3;

    CopyMemory(@Result[0],@Packet[0],460);

    GlobalCurrLen :=460;

end;


Function TQQOutPacket.SendIMPacket(FromQQNum:integer;ToQQNum:integer;
SessionKey:Array of Byte;NowTime:integer;StrSend:String;var nSendLen:integer):TMyByte;
var
   c:MD5Digest;
   Plain,SendBuff:array of byte;
   QQBuff:array[0..3] of byte;
   ToQQBuff:array[0..3] of byte;

   b:array[0..19] of byte;
   TickCount,i,
   bit,bytesCount:Integer;
   TickCountBuff:array[0..3] of byte;
   Crypt,Packet:TMYByte;
begin
    If High(SessionKey) <> 15 Then Exit;

    InitArray(Packet);
    InitArray(Crypt);

    //TickCount :=0;  //1124569192


    For i:=0 to 19 do
      b[i]:=0;

    //TickCount :=1124569192;//
    TickCount := NowTime ;
    CopyMemory(@QQBuff[0], @FromQQNum, 4 );
    CopyMemory(@ToQQBuff[0], @ToQQNum, 4 );
    CopyMemory(@TickCountBuff[0], @TickCount, 4);
    //SetLength(Packet,11);
    Packet[0] := $2 ;                  //   '头部
    Packet[1] := $D ;                 //    '客户端版本号码
    Packet[2] := $51;                 //
    Packet[3] := $0 ;                 //    '命令类型
    Packet[4] := $16;
    Packet[5] := 10;//Trunc(Random * 256);//           '包序号
    Packet[6] := 10;//Trunc(Random * 256);//
    Packet[7] := QQBuff[3]          ;//      '用户 QQ 号
    Packet[8] := QQBuff[2]         ;//
    Packet[9] := QQBuff[1]        ;//
    Packet[10] := QQBuff[0]       ;//
    bytesCount := -1;
    For I := 1 To Length(StrSend) do
    begin
        bit := Ord(StrSend[i]);
        If (bit > -1) And (bit < 256) Then
        begin
            bytesCount := bytesCount + 1;
            SetLength(SendBuff,bytesCount+1);
            SendBuff[bytesCount] := Byte(bit);
        end
        Else begin
            bytesCount := bytesCount + 2;
            SetLength(SendBuff,bytesCount+1);

            //ReDim Preserve SendBuff(bytesCount) As Byte
            SendBuff[bytesCount - 1] := Hi(bit) ;
            SendBuff[bytesCount] := Lo(bit) ;
        end;
    end;

    SetLength(Plain,67 + bytesCount+1) ;
    Plain[0] := QQBuff[3];
    Plain[1] := QQBuff[2];
    Plain[2] := QQBuff[1];
    Plain[3] := QQBuff[0];
    Plain[4] := ToQQBuff[3];
    Plain[5] := ToQQBuff[2];
    Plain[6] := ToQQBuff[1];
    Plain[7] := ToQQBuff[0];
    Plain[8] := $D  ;
    Plain[9] := $51 ;
    Plain[10] := QQBuff[3] ;
    Plain[11] := QQBuff[2] ;
    Plain[12] := QQBuff[1] ;
    Plain[13] := QQBuff[0] ;
    Plain[14] := ToQQBuff[3];
    Plain[15] := ToQQBuff[2];
    Plain[16] := ToQQBuff[1];
    Plain[17] := ToQQBuff[0];
    //18 - 33 MD5
    b[0] := QQBuff[3];
    b[1] := QQBuff[2];
    b[2] := QQBuff[1];
    b[3] := QQBuff[0];

    CopyMemory(@b[4], @SessionKey[0], 16);

    C:=MD5ByteArray(B); //DigestBAryToArray(b,c)  ;//**MD5

    CopyMemory (@Plain[18], @c[0], 16);
    Plain[34] := 0 ;
    Plain[35] := 11;
    Plain[36] := Trunc(Random * 256);
    Plain[37] := Trunc(Random * 256);
    Plain[38] := TickCountBuff[3];
    Plain[39] := TickCountBuff[2];
    Plain[40] := TickCountBuff[1];
    Plain[41] := TickCountBuff[0];
    Plain[42] := 0  ;
    Plain[43] := 0  ;
    Plain[44] := 0  ;
    Plain[45] := 0  ;
    Plain[46] := 0  ;
    Plain[47] := 1  ;
    Plain[48] := 1  ;
    Plain[49] := 0  ;
    Plain[50] := Trunc(Random * 256) ;
    Plain[51] := Trunc(Random * 256) ;
    Plain[52] := 2 ;
    CopyMemory(@Plain[53], @SendBuff[0], High(SendBuff) + 1);
    {Plain[High(Plain) - 13] := 32;
    Plain[High(Plain) - 12] := 0 ;
    Plain[High(Plain) - 11] := 9 ;
    //Plain[High(Plain) - 10] =frmMain.hsRed.value
    //Plain[High(Plain) - 9] = frmMain.hsGreen.value
    //Plain[High(Plain) - 8] = frmMain.hsBlue.value
    Plain[High(Plain) - 7] := 0  ;
    Plain[High(Plain) - 6] := 134;
    Plain[High(Plain) - 5] := 0  ;
    Plain[High(Plain) - 4] := $CB ;
    Plain[High(Plain) - 3] := $CE ;
    Plain[High(Plain) - 2] := $CC ;
    Plain[High(Plain) - 1] := $E5 ;
    Plain[High(Plain)]     := 13  ;  }

    Plain[High(Plain) - 13] := 32;
    Plain[High(Plain) - 12] := 0 ;
    Plain[High(Plain) - 11] := 9 ;
    Plain[High(Plain) - 10] :=FRedValue ;
    Plain[High(Plain) - 9]  :=FBlueValue;
    Plain[High(Plain) - 8]  :=FRedValue;
    Plain[High(Plain) - 7]  := 0  ;
    Plain[High(Plain) - 6]  := 134;
    Plain[High(Plain) - 5]  := 0  ;
    Plain[High(Plain) - 4]  := $CB ;
    Plain[High(Plain) - 3]  := $CE ;
    Plain[High(Plain) - 2]  := $CC ;
    Plain[High(Plain) - 1]  := $E5 ;
    Plain[High(Plain)]      := 13  ;

    Crypt := QQTEA.Encrypt(Plain, SessionKey,nSendLen);

    CopyMemory(@Packet[11], @Crypt[0], nSendLen);

    Packet[nSendLen+11] := 3;

    Copymemory(@Result[0],@Packet[0],nSendLen+12);
    nSendLen :=nSendLen+12;
end;

Function TQQOutPacket.KeepAlivePacket(QQNum:Integer;SessionKey:Array of Byte;Var nSendLen:integer):TMYByte;
var
   QQBuff:array of byte;
   i:integer;
   Crypt,Packet:TMYByte;
   nLen ,Pos:integer;
begin
    InitArray(Crypt);
    InitArray(Result);
    InitArray(Packet);

    nLen :=Length(Trim(IntToStr(QQNum)));
    SetLength(QQBuff,nLen);
    For I := 1 To nLen do
        QQBuff[I - 1] := StrToInt(Copy(Trim(IntToStr(QQNum)), I, 1));

    Crypt := QQTEA.Encrypt(QQBuff, SessionKey,nSendLen);
    SetLength(QQBuff,4);
    CopyMemory(@QQBuff[0], @QQNum, 4);
    Packet[0] := $2 ;//                     '头部
    Packet[1] := $D ;//                      '客户端版本号码
    Packet[2] := $51;//
    Packet[3] := $0 ;//                      '命令类型
    Packet[4] := $2 ;// 
    Packet[5] := Trunc(Random * 256);//            '包序号
    Packet[6] := Trunc(Random  * 256);//
    Packet[7] := QQBuff[3]     ;//            '用户 QQ 号
    Packet[8] := QQBuff[2]     ;//
    Packet[9] := QQBuff[1]     ;//
    Packet[10]:= QQBuff[0]    ;//
    CopyMemory(@Packet[11], @Crypt[0],nSendLen);
    Packet[nSendLen+11] := 3;
    Copymemory(@Result[0], @Packet[0],nSendLen+12);
    nSendLen :=nSendLen+12;
end;

Function TQQOutPacket.LogoutPacket(QQNum :integer; SessionKey, PasswordKey:Array of Byte;Var nSendLen:integer):TMYByte;
var
   QQBuff :Array [0..3] of Byte;
   Packet :Array [0..43] of Byte;
   Crypt:TMYByte;
begin
    InitArray(Crypt);
    Crypt := QQTEA.Encrypt(PasswordKey, SessionKey,nSendLen);
    CopyMemory(@QQBuff[0], @QQNum, 4);
    Packet[0] := $2    ;  //                  '头部
    Packet[1] := $D    ;  //                  '客户端版本号码
    Packet[2] := $51   ;  //
    Packet[3] := $0    ;  //                  '命令类型
    Packet[4] := $1    ;  //
    Packet[5] := Trunc(Random * 256);  //     '包序号
    Packet[6] := Trunc(Random * 256) ;  //
    Packet[7] := QQBuff[3]     ;  //          '用户 QQ 号
    Packet[8] := QQBuff[2]    ;  //
    Packet[9] := QQBuff[1]    ;  //
    Packet[10] := QQBuff[0]   ;  //
    CopyMemory(@Packet[11], @Crypt[0], 32) ;  //
    Packet[43] := 3;

    Copymemory(@Packet[0],@Result[0],High(Packet)+1);
    nSendLen :=44;
end;

{
initialization
   QQOutPacket:=TQQOutPacket.Create;
finalization
  FreeAndNil(QQOutPacket);
 }

function TQQOutPacket.ChangeStatus(BStatus, BFakeCom: Boolean; SessionKey,
  PasswordKey: array of Byte; var nSendLen: integer): TMYByte;
var
   QQBuff :Array [0..3] of Byte;
   Packet :Array [0..43] of Byte;
   Crypt:TMYByte;
begin
  {  InitArray(Crypt);
    Crypt := QQTEA.Encrypt(PasswordKey, SessionKey,nSendLen);
    CopyMemory(@QQBuff[0], @QQNum, 4);
    Packet[0] := $2    ;  //                  '头部
    Packet[1] := $D    ;  //                  '客户端版本号码
    Packet[2] := $51   ;  //
    Packet[3] := $0    ;  //                  '命令类型
    Packet[4] := $1    ;  //
    Packet[5] := Trunc(Random * 256);  //     '包序号
    Packet[6] := Trunc(Random * 256) ;  //
    Packet[7] := QQBuff[3]     ;  //          '用户 QQ 号
    Packet[8] := QQBuff[2]    ;  //
    Packet[9] := QQBuff[1]    ;  //
    Packet[10]:=QQBuff[0]   ;  //
    CopyMemory(@Packet[11], @Crypt[0], 32) ;  //
    Packet[43] := 3;

    Copymemory(@Packet[0],@Result[0],High(Packet)+1);
    nSendLen :=44;
    ]}
end;


end.
