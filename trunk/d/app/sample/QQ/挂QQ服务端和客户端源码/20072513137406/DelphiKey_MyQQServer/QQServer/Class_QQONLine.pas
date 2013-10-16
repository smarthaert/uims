//挂QQ服务端，如需WEB版挂QQ的，自己来改造，本人现在没有精力改造了
//不需要的东西都已经取消了
//提供该程序只是用来学习目的，千万不要用于非法用途，后果自负
//用到RX控件，和JCL库，请大家自行下载
//如果不能挂QQ的话，那就请看LumqQQ中的相关协议，改成新协议即可
//如有更新希望发一份给我 QQ:709582502 Email:Touchboy@126.com 
unit Class_QQONLine;

interface

uses
  Windows,Messages, SysUtils, Variants, Classes,ExtCtrls,
  MSWinsockLib_TLB,Class_QQTEA,Class_Record,Class_QQOUTPacket,
  Class_QQInPacket,Class_QQDB;

Type
  TQQOnLine=Class
    private
      FUDPSock     :array [1..MAXUDPOnLineNum] of TWinSock;

      FKeepLiveTime:TTimer;
      FErrorTime   :TTimer;
      FLoginTime   :TTimer;

      FUDPServer:Array [1..7] of String;
      //FAutoReplay: String;
      procedure OnKeepLiveTime(Sender:TObject);
      procedure OnErrorTime(Sender:TObject);
      procedure OnLoginTime(Sender:TObject);

      procedure OnDataArrival(ASender: TObject; bytesTotal: Integer);
      procedure OnError(ASender: TObject; Number: Smallint;
       var Description: WideString; Scode: Integer; const Source,
       HelpFile: WideString; HelpContext: Integer;
       var CancelDisplay: WordBool);

      procedure UPDSendData(Index:integer;SendData:TMYByte;nSendLen:Integer);
    public
      constructor Create(nKeepLiveTime,nError,nLoginTime:Integer;TCPForm:TComponent);
      destructor Destroy; override;

      procedure ResetServer(Index:integer);

      procedure Login(Index,QQNum: Integer; QQPassWord:String;QQHide: Boolean;QQAutoReplay: String;
                      OneHour,OneMin,TwoHour,TwoMin,UserType:integer);
      procedure ReLogin(Index:integer);
      procedure Clear(Index:integer);
      procedure LogOut(Index:integer);

      procedure StopQQ;

      Function GetOnLineTime(Index:integer):String;

      //property AutoReplay:String Read FAutoReplay Write FAutoReplay;
    end;

var
  QQOnLine:TQQOnLine;

implementation

Uses NWSystem,JclDateTime,NWDateTime;

{ TQQOnLine }


constructor TQQOnLine.Create(nKeepLiveTime, nError, nLoginTime: Integer;
  TCPForm: TComponent);
var
  i:integer;
begin
  SocketNextSearch :=1;

  For i:=1 to MAXUDPOnLineNum do
  begin
    FUDPSock[i] :=TWinSock.Create(TCPForm);
    FUDPSock[i].Tag :=i;
    FUDPSock[i].OnError       :=OnError;
    FUDPSock[i].OnDataArrival :=OnDataArrival;
    FUDPSock[i].Protocol      :=1;
  end;
  
  {FUDPSock :=TWinSock.Create(TCPForm);
  FUDPSock.OnError       :=OnError;
  FUDPSock.OnDataArrival :=OnDataArrival;
   }
  FKeepLiveTime         :=TTimer.Create(Nil);
  FKeepLiveTime.Interval:=nKeepLiveTime;
  FKeepLiveTime.OnTimer :=OnKeepLiveTime;

  FErrorTime         :=TTimer.Create(Nil);
  FErrorTime.Interval:=nError;
  FErrorTime.OnTimer :=OnErrorTime;

  FLoginTime       :=TTimer.Create(Nil);
  FLoginTime.Interval:=nLoginTime;
  FLoginTime.OnTimer :=OnLoginTime;

  FUDPServer[1]:='sz.tencent.com';
  FUDPServer[2]:='sz4.tencent.com';
  FUDPServer[3]:='sz3.tencent.com';
  FUDPServer[4]:='sz4.tencent.com';
  FUDPServer[5]:='sz5.tencent.com';
  FUDPServer[6]:='sz6.tencent.com';
  FUDPServer[7]:='sz7.tencent.com';

  FLoginTime.Enabled      :=True;
  FErrorTime.Enabled      :=True;
  FKeepLiveTime.Enabled   :=True;

end;

destructor TQQOnLine.Destroy;
var
  i:integer;
begin
  FKeepLiveTime.Enabled:=False;
  FErrorTime.Enabled   :=False;
  FLoginTime.Enabled   :=False;

  FreeAndNil(FKeepLiveTime);
  FreeAndNil(FErrorTime);
  FreeAndNil(FLoginTime);

  For i:=1 to MAXUDPOnLineNum do
  begin
    FUDPSock[i].Close;
    FreeAndNil(FUDPSock[i]);
  end;
  inherited;
end;

procedure TQQOnLine.Login(Index,QQNum: Integer; QQPassWord: String;
  QQHide: Boolean; QQAutoReplay: String;OneHour,OneMin,TwoHour,TwoMin,UserType:integer);
var
  I:integer;
  PasswordKey:TMyByte;
  MYOne,MyTwo:MD5Digest;
  sSend:String;
  Send:Array of Byte;
  S:String;
begin
    //Randomize;
    If (QQNum = 0) Or (QQPassWord ='') Then Exit;
    QQInfo[Index].QQNumber   :=QQNum;
    QQInfo[Index].QQPassword :=QQPassword;
    QQInfo[Index].QQAutoReply:=QQAutoReplay;
    QQInfo[Index].QQHide     :=QQHide;

    QQinfo[Index].OneHour    :=OneHour;
    QQinfo[Index].OneMin     :=OneMin;
    QQinfo[Index].TwoHour    :=TwoHour;
    QQinfo[Index].TwoMin     :=TwoMin;
    QQinfo[Index].UserType   :=UserType;
    QQinfo[Index].OnLineMin  :=HourTwoToMin(OneHour,OneMin,TwoHour,TwoMin);

    MYOne       :=MD5String(QQInfo[Index].QQPassword);
    SetLength(S,16);
    CopyMemory(@S[1],@MyOne[0],16);

    MyTwo :=MD5String(S);
    For I := 0 To 15 do
    begin
       QQInfo[Index].PasswordKey[i] :=MyTwo[i];
       QQInfo[Index].LoginKey[I]    :=Trunc(Random * 256);
    end;
    ReLogin(index);
end;

procedure TQQOnLine.ReLogin(Index: integer);
var
  sSend:String;
  Send:Array of Byte;
  SendData:TMyByte;
begin
  if QQInfo[Index].QQNumber=0 then Exit;
  {
  if (QQInfo[Index].TwoHour>HourOfTime(NOW)) then
  begin
    QQInfo[Index].State := QsNotTime;
    Exit;
  end;
  if (QQInfo[Index].TwoHour=HourOfTime(NOW)) and (QQInfo[Index].TwoMin> MinuteOfTime(NoW))then
  begin
    QQInfo[Index].State := QsNotTime;
    Exit;
  end;
   }
  QQInfo[Index].TimerCount     :=0;
  QQInfo[Index].KeepAliveCount :=1;

  SendData := QQOutPacket.LoginToken(QQInfo[Index].QQNumber);
  SetLength(Send,13);
  Move(SendData[0],Send[0],13);
  FUDPSock[Index].Close;
  FUDPSock[Index].Bind;
  FUDPSock[Index].RemoteHost :=QQInfo[Index].Server;
  FUDPSock[Index].RemotePort :=8000;
  FUDPSock[Index].SendData(Send);
end;


procedure TQQOnLine.OnDataArrival(ASender: TObject; bytesTotal: Integer);
var
   Buff:Array of Byte;
   SessionKeyTemp:TMYByte;
   ThisTime :Integer;
   Stra:String;
   I:integer;
   v,vv,VVV,VVVV: OleVariant;
   p: Pointer;
   n:Integer;
   MY:TMYByte;
   nSendLen:integer;
   SendData:Array [0..500] of byte;
   index:integer;
begin
    index :=TWinSock(ASender).Tag;
    FUDPSock[index].GetData(v);
    SetLength(Buff,bytesTotal);
    p := VarArrayLock(V);
    try
      Move(p^, Buff[0], High(Buff)+1);
    finally
      VarArrayUnlock(V);
    end;
    n:= QQInPacket.GetPacketAbout(Buff);
    Case n of
        1:begin
            MY:=QQOutPacket.LoginPacket(QQInfo[Index].QQNumber, QQInfo[Index].QQHide,QQInfo[Index].LoginKey, QQInfo[Index].PasswordKey,
            QQInPacket.LoginTokenReply(Buff));
            //QQInfo[Index].State  :=QsLogin;
            UPDSendData(Index,My,460);
          end;
        2:
          begin
            Stra := QQInPacket.GetLoginPacketRedirect(Buff, QQInfo[Index].LoginKey);
            If Stra <> '' Then
            begin
               QQinfo[index].Server :=Stra;
               ReLogin(Index);
               Exit;
            end;
            Stra := QQInPacket.GetLoginPacketError(Buff, QQInfo[Index].LoginKey);
            If Stra <> '' Then
            begin
              QQInfo[Index].ErrorString := Stra ;
              QQInfo[Index].ErrorCount  := QQInfo[Index].ErrorCount + 1;
              If (Pos('密码',Stra)<> 0) And (Pos('错误',Stra) <> 0) Then
              begin
                 MY:=QQOutPacket.LogoutPacket(QQInfo[Index].QQNumber,QQInfo[Index].SessionKey,QQInfo[Index].PasswordKey,nSendLen);
                 UPDSendData(Index,My,nSendLen);
                 QQInfo[Index].State := QsPassWordError;
              end
              Else begin
                 QQInfo[Index].State := QsError;
              end;
              Exit;
            end;

            QQUserDB.AddQQInfo(QQInfo[Index].QQNumber,QQInfo[Index].QQPassword,QQinfo[index].OneHour,
                    QQinfo[index].OneHour,QQinfo[index].TwoHour,QQinfo[index].TwoHour,0);

            SessionKeyTemp := QQInPacket.GetLoginPacketSessionKey(Buff, QQInfo[Index].PasswordKey);
            For I := 0 To 15 do
                QQInfo[Index].SessionKey[I] := SessionKeyTemp[I];


            MY:=QQOutPacket.KeepAlivePacket(QQInfo[Index].QQNumber,QQInfo[Index].SessionKey,nSendLen);
            UPDSendData(Index,My,nSendLen);

            QQInfo[Index].ErrorString :='';
            QQInfo[Index].ErrorCount := 0;
            QQInfo[Index].State := QsLoginSucess;
          end;
        3:begin
            If QQInfo[Index].QQAutoReply <> '' Then
            begin
                ThisTime := QQInPacket.GetIMPacketTime(Buff, QQInfo[Index].SessionKey);
                If ThisTime > QQInfo[Index].NowTime Then
                begin
                   QQInfo[Index].NowTime := ThisTime;

                   MY:=QQOutPacket.SendIMPacket(QQInfo[Index].QQNumber,
                      QQInPacket.GetIMPacketFrom(QQInfo[Index].QQNumber, Buff, QQInfo[Index].SessionKey),
                      QQInfo[Index].SessionKey, ThisTime, QQInfo[Index].QQAutoReply,nSendLen);
                   UPDSendData(Index,My,nSendLen);
                end;
            end;
          end;
       4:begin
           QQInfo[Index].KeepAliveCount := QQInfo[Index].KeepAliveCount + 1;
         end;
    end
end;

procedure TQQOnLine.OnError(ASender: TObject; Number: Smallint;
  var Description: WideString; Scode: Integer; const Source,
  HelpFile: WideString; HelpContext: Integer; var CancelDisplay: WordBool);
var
  index:integer;
begin
  index :=TWinSock(ASender).Tag;
  FUDPSock[index].Close;
end;

procedure TQQOnLine.OnErrorTime(Sender: TObject);
var
  i:integer;
begin
  For i:=1 to MAXUDPOnLineNum do
  begin
     If QQInfo[I].ErrorCount >= 5 Then Logout(i);
     If (Minute - QQInfo[I].AddTime) > 2880 Then Logout(i);
  end;
end;

procedure TQQOnLine.OnKeepLiveTime(Sender: TObject);
var
  i:integer;
  nSendLen:integer;
  MY:TMyByte;
  CurrHour:Integer;
begin
  For i:=1 to MAXUDPOnLineNum do
  begin
     If (QQInfo[I].QQNumber<>0) and (QQInfo[I].QQPassword<>'')
       and (QQInfo[i].State=QsLoginSucess)  Then
     begin
       CurrHour :=HourOfTime(NOW);
       if  CurrHour>QQInfo[i].TwoHour then
       begin
         //QQInfo[i].State := QsNotTime;
         Continue;
       end;
       if (QQInfo[i].TwoHour=HourOfTime(NOW)) and (QQInfo[i].TwoMin> MinuteOfTime(NoW))then
       begin
         //QQInfo[Index].State := QsNotTime;
         Continue;
       end;

       MY :=QQOutPacket.KeepAlivePacket(QQInfo[i].QQNumber,QQInfo[i].SessionKey,nSendLen);
       UPDSendData(i,My,nSendLen);
     end;
  end;
end;

procedure TQQOnLine.OnLoginTime(Sender: TObject);
var
  i:integer;
  nSendLen:integer;
  MY:TMyByte;
begin
  For i:=1 to MAXUDPOnLineNum do
  begin
     if QQInfo[I].KeepAliveCount=0 then
     begin
       ReLogin(i);
       QQInfo[I].KeepAliveCount :=0;
     end;
     If QQInfo[I].TimerCount>=20  Then
     begin
       QQInfo[I].TimerCount :=0;
       ReLogin(i);
     end;
  end;
end;


procedure TQQOnLine.ResetServer(Index: integer);
begin
  QQInfo[Index].Server :='sz.tencent.com';
  //QQInfo[Index].Server :=FUDPServer[Rand(7)];
end;

procedure TQQOnLine.Clear(Index: integer);
var
 i:integer;
begin
  FUDPSock[Index].Close;
  QQInfo[Index].State    :=QsLogin;
  QQInfo[Index].QQNumber :=0;

  QQInfo[Index].QQHide   :=False;
  QQInfo[Index].QQPassword     :='';
  QQInfo[Index].QQAutoReply    :='';
  QQInfo[Index].ErrorCount     :=0;
  QQInfo[Index].ErrorString    :='';
  QQInfo[Index].AddTime        :=0;
  QQInfo[Index].NowTime        :=0;

  For i:=0 to 15 do
  begin
   QQInfo[Index].PasswordKey[i]:=0;
   QQInfo[Index].LoginKey[i]   :=0;
   QQInfo[Index].SessionKey[i] :=0;
  end;
end;


procedure TQQOnLine.LogOut(Index: integer);
var
  MY:TMyByte;
  nSendLen:integer;
begin
  MY:=QQOutPacket.LogoutPacket(QQInfo[Index].QQNumber,QQInfo[Index].SessionKey,QQInfo[Index].PasswordKey,nSendLen);
  UPDSendData(Index,My,nSendLen);
  FUDPSock[Index].Close;
  Clear(Index);
end;

procedure TQQOnLine.UPDSendData(Index:integer;SendData: TMYByte; nSendLen: Integer);
var
  p:Pointer;
  V:OleVariant;
begin
  V:=VarArrayCreate([0,nSendLen-1],varByte);
  p := VarArrayLock(V);
  try
    Move(SendData[0], p^, nSendLen);
  finally
    VarArrayUnlock(V);
  end;
  FUDPSock[Index].Close;
  FUDPSock[Index].RemotePort :=8000;
  FUDPSock[Index].RemoteHost :=QQinfo[index].Server;
  FUDPSock[Index].Bind;
  FUDPSock[Index].SendData(V);
end;

procedure TQQOnLine.StopQQ;
var
  i:integer;
begin
  For i:=1 to MAXUDPOnLineNum do
  begin
     FUDPSock[i].Close;
  end;
end;

function TQQOnLine.GetOnLineTime(Index: integer): String;
begin
  Result :='在'+IntTostr(QQinfo[index].OneHour)+':'+IntTostr(QQinfo[index].OneMin)+
           '至'+IntTostr(QQinfo[index].TwoHour)+':'+IntTostr(QQinfo[index].TwoMin);
end;

end.
