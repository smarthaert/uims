unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ScktComp, DB, DBTables, ADODB, IniFiles,
  ImgList, AppEvnts;


type
  TForm1 = class(TForm)
    ClientSocket: TClientSocket;
    Panel1: TPanel;
    Memo1: TMemo;
    Timer1: TTimer;
    Timer2: TTimer;
    Database1: TADOConnection;
    Query1: TADOQuery;
    Query2: TADOQuery;
    qryTemp: TADOQuery;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Bevel2: TBevel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer2Timer(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    CommandID, Times: integer;
    DateNum: Longint;
    FirstCreate : Boolean;
    procedure ConnectServer;
    procedure AppException(Sender: TObject; E: Exception);
    procedure SaveHisData;
    procedure ClientShow(s: string);
    procedure RefreshIP;
  public
    { Public declarations }
    ConnSuccess: Boolean;
    Clients : TList;
    sp_version, called, curFile: String;
    ClientFile: TextFile;
    strStep, strRegCode : integer;
    procedure SendMsg(Msg: string);
  end;

var
  Form1: TForm1;
Procedure TimeDelay(DT:DWORD);

implementation

{$R *.dfm}
uses regForm;

Procedure TimeDelay(DT:DWORD);
var
 TT:DWORD;
begin
  //取得现在的Tick值
  TT:=GetTickCount();
  //计算Tick差值是否超过设置值
  while GetTickCount()-TT<DT do
    Application.ProcessMessages; //释放控制权
end;

procedure TForm1.SendMsg(Msg: string);
begin
  ClientShow(Format('[%s] 发送 %s',[DatetimeTostr(Now), Msg]));
  try
    ClientSocket.Socket.SendText(Msg+#13#10);
  except
    ConnSuccess := False;
    ClientShow(Format('[%s] 连接错误！',[DatetimeTostr(Now)]));
    ConnectServer;
  end;
end;

procedure OpenQuery(query: TADOQuery; S: String);
begin
  with query do
  begin
    Close;
    Sql.Clear; Sql.Add(S);
    Open;
  end;
end;

procedure ExecQuery(query: TADOQuery; S: String);
begin
  with query do
  begin
    Close;
    Sql.Clear; Sql.Add(S);
    ExecSql;
  end;
end;

function SubCopy(Msg, StrID: string):string;
var bpos, mpos: integer;
  lMsg, stemp, bs, ms: string;
begin
  result := '';
  lMsg := Msg;
  repeat
    bpos := Pos(LowerCase(StrID), LowerCase(LMsg));
    bs := copy(LMsg, bpos-1, 1);
    mpos := bpos+Length(StrID);
    ms := copy(LMsg, mpos, 1);
    if ((bs = ' ') or (bs = '&')) and (ms = '=') then
    begin
      stemp := copy(LMsg, mPos+1, Length(LMsg)-mpos+1);
      bpos := Pos('&', stemp);
      if bpos > 0 then sTemp := Copy(stemp, 1, bpos-1);
      result := Trim(sTemp);
      break;
    end;
    LMsg := Copy(LMsg, mpos, Length(LMsg)-mpos);
  until bpos <= 0;
end;

function AnsiToUnicode(Ansi: string):string;
var
  s:string;
  i, slen:integer;
  j:string[2];
begin
  s:='';
  sLen := length(Ansi);
  for i := 1 to sLen do
  begin
    if i mod 2 = 1 then
      j:=IntToHex(word(ansi[i]) shl 8,2)
    else j:=IntToHex(word(ansi[i]),2);
    s:=s+j;
  end;
  Result :=s;
end;

function HexToInt(hex: char): integer;
begin
  if (hex >='1') and (hex <= '9') then result := strToInt(hex)
  else if  ((hex >= 'a') and (hex <= 'f')) then result := integer(hex)- integer('a') + 10
  else if (hex >= 'A') and (hex <= 'F') then result := integer(hex)- integer('A') + 10
  else result := 0;
end;

function UnicodeToAnsi(Unicode: string):string;
var
  s:string;
  i, slen, m, n:integer;
begin
  s:='';
  sLen := length(Unicode) div 2 ;
  for i := 1 to sLen do
  begin
    m := HexToInt(Unicode[i*2-1]);
    n := HexToInt(Unicode[i*2]);
    s := s+chr(m *16 +n);
  end;
  Result :=s;
end;

procedure TForm1.RefreshIP;
var
  hDll:THandle;
  GetIP: function: string;
  strDllName,strErrMsg, s: String;
  F: TextFile;
  IniFile: TIniFile;
begin
  {从服务器中下载并更新IP}
  ClientShow('['+DatetimeTostr(Now)+'] 提示：现正在更新IP地址，大约需要十多秒，请稍等...');
  strDllName:='.\GetIPInfo.dll';//得到Dll所在
  hDll:=LoadLibrary(PChar(strDllName));//加载Dll
  if(hDll<=0) then
  begin
    ClientShow('['+DatetimeTostr(Now)+'] 对不起，不能加载文件GetIPInfo.dll，请确认文件是否存在。');
    exit;
  end;

  GetIP:=GetProcAddress(hDll,'GetIP');
  if not Assigned(GetIP) then
  begin
    Freelibrary(hDll);
    ClientShow('['+DatetimeTostr(Now)+'] 对不起，文件GetIPInfo.dll没有信息发送功能，请确认文件是否正确。');
    Exit;
  end else
    GetIP;

  Freelibrary(hDll);

  {读取IP地址}
  AssignFile(F, '.\ip.asp');
  Reset(F);
  readln(F, s);
  CloseFile(F);
  {最新IP写入INI文件中}
  IniFile := TIniFile.Create('.\spClient.ini');
  IniFile.WriteString('configs','ip',s);
  IniFile.Free;
  ClientShow('['+DatetimeTostr(Now)+'] 提示：更新完毕，请重新运行程序！')
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (Times > 3) or (not ClientSocket.Active)  then
  begin
    if ClientSocket.Active then
    begin
      ClientSocket.Close;
      TimeDelay(1000);
      ConnSuccess := False;
    end;
    ConnectServer;
    Exit;
  end;

  if ClientSocket.Active then
  begin
    if CommandID > 9999 then CommandID := 1000 else inc(CommandID);
    SendMsg('ActiveTest CommandId='+intTostr(CommandID));
    Inc(Times);
  end;
end;

procedure TForm1.ConnectServer;
var FileAttrs: Integer;
  sr: TSearchRec;
  IniFile: TIniFile;
  ports :integer;
  id, pwd, ip : string;
  TT: dWord;
begin
  IniFile := TIniFile.Create('.\spClient.ini');
  ports := IniFile.ReadInteger('configs','ports',8021);
  ip := IniFile.ReadString('configs','ip','211.162.36.89');
  sp_version := IniFile.ReadString('configs','version','1.1.1.0');
  IniFile.Free;

  IniFile := TIniFile.Create('.\TCP.INI');
  id := IniFile.ReadString('configs','id','100');
  pwd := IniFile.ReadString('configs','spwd','');
  Called := IniFile.ReadString('configs','called','91603318');
  IniFile.Free;
  try
    ConnSuccess := False;
    Timer2.Enabled := False;
    ClientShow('['+DatetimeTostr(Now)+'] 提示：正在连接...到 '+ip+' ！');
    if ClientSocket.Active then ClientSocket.Close;
    ClientSocket.Address := ip;
    ClientSocket.Port := ports;
    ClientSocket.Host := ClientSocket.Address;
    ClientSocket.Active := True;
    TT:=GetTickCount();
    while (GetTickCount()-TT<8000) and (not ClientSocket.Active) do
      Application.ProcessMessages;

    if ClientSocket.Active then
    begin
      if database1.Connected then database1.Close;
      database1.ConnectionString := 'FILE NAME='+'.\Business.udl';
      database1.Connected := True;
    end;
  except
    ClientShow('['+DatetimeTostr(Now)+'] 提示：连接出错，判断IP地址或端口是否正确！'+#10#13);
    RefreshIP;
    exit;
  end;

  if ClientSocket.Active then
  begin
    if CurFile <> '' then
      CloseFile(ClientFile);
    CurFile := DatetimeTostr(Now);
    CurFile := copy(CurFile,1,4)+copy(CurFile,6,2)+copy(CurFile,9,2);
    FileAttrs := faAnyFile;
    AssignFile(ClientFile, CurFile+'_C.txt'); { File selected in dialog }
    if FindFirst(CurFile+'_C.txt', FileAttrs, sr) = 0 then  Append(ClientFile)
    else ReWrite(ClientFile);

    DateNum := 0;
    SendMsg(Format('Login Name=%s&Pwd=%s&Type=0&version=%s', [id, pwd, sp_version]));
  end else begin
    ClientShow('['+DatetimeTostr(Now)+'] 提示：连接失败！');
    RefreshIP;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CommandID := 1000;
  CurFile := '';
  ConnSuccess := False;
  FirstCreate := True;
  sp_version := '';
  Application.OnException := AppException;
end;

procedure TForm1.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var Msg, MsgFlag, sTemp: string;
  i: integer;
  MsgList : TStringList;
begin
  MsgList := TStringList.Create;
  MsgList.Text := Socket.ReceiveText;
  for i := 0 to MsgList.Count -1 do
  begin
    Msg := MsgList.Strings[i];
    MsgFlag := LowerCase(Trim(Msg));
    if MsgFlag = '' then Continue;
    ClientShow(Format('[%s] 接收 %s',[DatetimeTostr(Now), Msg]));

    if  copy(MsgFlag,1,4)='pass' then
    begin
      Times := 0;
      ClientShow('['+DatetimeTostr(Now)+'] 提示：验证身份成功！Successed！');
      Timer1.Enabled := True;
      Timer2.Enabled := True;
      ConnSuccess := True;
      timeDelay(1000);
      application.Minimize;
    end else if copy(MsgFlag, 1, 10)='activetest' then
    begin
      SendMsg('Received CommandId='+subcopy(Msg, 'commandid')+#13#10);
    end else if copy(MsgFlag, 1, 7)='deliver' then
    begin
      SendMsg('Received CommandId='+subcopy(msg, 'commandid')+#13#10);
      stemp := 'INSERT INTO msgcomm(GateName, smid, smmobile, smcalled, smfee, smfeeno, smfmt, smmsgs, scheduletime, expiretime, mtflag, MsgId, reportflag, sendtime, extdata, smflag)'+
               ' VALUES(null, ''%s'',''%s'', ''%s'', 1, null, %d, ''%s'', null, null, 0, null, 0, getdate(), null, 1)';
      ExecQuery(query1, Format(stemp, ['103901', subcopy(msg,'usernumber'), subcopy(msg,'spnumber'), strToint(subcopy(msg,'msgcode')),UnicodeToAnsi(subcopy(msg,'msg:'))]));
    end else if copy(MsgFlag, 1, 6)='report' then
    begin
      SendMsg('Received CommandId='+subcopy(msg, 'commandid')+#13#10);
      stemp := subcopy(Msg, 'msgid');
      with query1 do
      begin
        stemp := 'INSERT INTO reportcomm(Commandid, extdata, msgid, Gatename, state) VALUES(''%s'',''%s'', ''%s'', null, ''%s'')';
        ExecQuery(query1, Format(stemp, [subcopy(Msg, 'commandid'), subCopy(Msg, 'ExtData'), subCopy(Msg, 'msgid'), subcopy(Msg, 'state')]));
      end;
    end else if copy(MsgFlag, 1, 6)='regist' then
    begin
      strRegCode := strToint(subCopy(Msg, 'result'));
      strStep := strToInt(subCopy(Msg, 'step'));
      if form2 <> nil then
        form2.Panel3.Caption := subcopy(Msg, 'errmsg');
    end else if copy(MsgFlag, 1, 8)='received' then Times := 0;
  end;
  MsgList.Free;
end;

procedure TForm1.AppException(Sender: TObject; E: Exception);
begin
  ClientShow(Format('[%s] 提示 程序错误：%s',[DatetimeTostr(Now), E.Message ]));
end;

procedure TForm1.SaveHisData;
var
  dt: string;
begin
  dt := DatetimeTostr(Now);
  dt := copy(dt,1,4)+copy(dt,6,2)+copy(dt,9,2);
  if dt <> curFile then
  begin
    CurFile := dt;
    CloseFile(ClientFile);
    AssignFile(ClientFile, CurFile+'_C.txt'); { File selected in dialog }
    ReWrite(ClientFile);
  end;
end;

procedure TForm1.ClientShow(s: string);
begin
  if memo1.Lines.Count > 200 then memo1.Clear;
  Memo1.Lines.Add(s);
  if CurFile <> '' then
  begin
    Writeln(ClientFile, s);
    Flush(ClientFile);
    SaveHisData;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var Msg: string;
  id: integer;

  Function BuildMsgID: string;
  var
    Present: TDateTime;
    Year, Month, Day, Hour, Min, Sec, MSec: Word;
  begin
    Present:= Now;
    DecodeDate(Present, Year, Month, Day);
    DecodeTime(Present, Hour, Min, Sec, MSec);
    result := Format('%.2d%.2d%.2d%.2d%.2d00%.4d%.3d',[Month, Day, Hour, Min, Sec, MSec, id]);
  end;
begin
  Timer2.Enabled := False;
  if ConnSuccess and ClientSocket.Active and Database1.Connected then
  begin
    with query2 do
    begin
      //database1.StartTransaction;
      database1.BeginTrans;
      try
        Open;
        if not isEmpty then
          ExecQuery(qryTemp, 'Delete From msgcomm');
        //database1.Commit;
        database1.CommitTrans;
      except
        if database1.InTransaction then database1.RollbackTrans;// .Rollback;
        Timer2.Enabled := True;
        exit;
      end;
      if query2.IsEmpty then
      begin
        Timer2.Enabled := True;
        Close; Exit;
      end;

      First;
      id := 1;
      While not Eof do
      begin
        if FieldByName('smflag').AsInteger = 0 then
        begin
          inc(CommandID);
          Msg := Format('Submit CommandId=%d', [CommandID]);
          if not FieldByName('gatename').IsNull then Msg := Msg + '&GateName='+FieldByName('gatename').Asstring;
          if not FieldByName('smid').IsNull then Msg := Msg + '&ITEMID='+FieldByName('smid').Asstring;
          if not FieldByName('smcalled').IsNull then Msg := Msg + '&SpNumber='+FieldByName('smcalled').Asstring;
          if not FieldByName('smmobile').IsNull then Msg := Msg + '&UserNumber='+FieldByName('smmobile').Asstring;
          if not FieldByName('smfeeno').IsNull then Msg := Msg + '&FeeNumber='+FieldByName('smfeeno').Asstring;
          if not FieldByName('smfee').IsNull then Msg := Msg + Format('&FeeType=%d',[FieldByName('smfee').Asinteger]);
          if not FieldByName('scheduletime').IsNull then Msg := Msg + '&ScheduleTime='+FieldByName('scheduletime').Asstring;
          if not FieldByName('expiretime').IsNull then Msg := Msg + '&ExpireTime='+FieldByName('expiretime').Asstring;
          if not FieldByName('mtflag').IsNull then Msg := Msg + Format('&MtFlag=%d',[FieldByName('mtflag').Asinteger]);
          if not FieldByName('reportflag').IsNull then Msg := Msg + Format('&ReportFlag=%d',[FieldByName('reportflag').Asinteger]);
          if not FieldByName('smfmt').IsNull then Msg := Msg + Format('&MsgCode=%d',[FieldByName('smfmt').Asinteger]);
          Msg := Msg + '&MsgId='+BuildMsgID;
          if not FieldByName('extdata').IsNull then Msg := Msg + '&ExtData:='+FieldByName('extdata').Asstring;
          if not FieldByName('smmsgs').IsNull then Msg := Msg + '&Msg:='+AnsiToUnicode(FieldByName('smmsgs').Asstring);
          SendMsg(Msg);
          Application.ProcessMessages;
          inc(id);
        end;
        Next;
      end;
      Close;
    end;
  end;
  Timer2.Enabled := True;
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  form1.Hide;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Application.Restore;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
  IniFile: TIniFile;
  id, pwd : string;
begin
  IniFile := TIniFile.Create('.\TCP.INI');
  id := IniFile.ReadString('configs','id','');
  pwd := IniFile.ReadString('configs','spwd','');
  IniFile.Free;

  if (id = '') or (pwd = '') then
  begin
    Button1Click(nil);
  end else if FirstCreate then
  begin
    FirstCreate := False;
    ConnectServer;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CurFile <> '' then
  begin
    CloseFile(ClientFile);
    CurFile := '';
  end;
  Action := caFree;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TForm2, Form2);
  try
    Form2.showModal;
    if Form2.btnOk then
    begin
      ClientSocket.Active := False;
      FirstCreate := False;
      ConnectServer;
    end;
  finally
    Form2.Free;
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  RefreshIP;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ConnectServer;
end;

end.
