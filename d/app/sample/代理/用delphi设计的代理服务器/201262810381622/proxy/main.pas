unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ScktComp, Menus, StdCtrls;

type
   session_record=record
      Used: boolean;                       {会话记录是否可用}
      SS_Handle: integer;                  {代理服务器套接字句柄}
      CSocket: TClientSocket;              {用于连接远程的套接字}
      Lookingup: boolean;                  {是否正在查找服务器}
      LookupTime: integer;                 {查找服务器时间}
      Request: boolean;                    {是否有请求}
      request_str: string;                 {请求数据块}
      client_connected: boolean;           {客户机联机标志}
      remote_connected: boolean;           {远程服务器连接标志}
end;

type
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    ClientSocket1: TClientSocket;
    Timer2: TTimer;
    PopupMenu1: TPopupMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    N1: TMenuItem;
    N01: TMenuItem;
    Memo1: TMemo;
    Edit1: TEdit;
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Label4: TLabel;
    ComboBox3: TComboBox;
    Button1: TButton;
    Label5: TLabel;
    ComboBox4: TComboBox;
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    Button2: TButton;
    Button3: TButton;
    N31: TMenuItem;
    N32: TMenuItem;
    PopupMenu2: TPopupMenu;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N40: TMenuItem;
    procedure Timer2Timer(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N21Click(Sender: TObject);
    procedure N01Click(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Write(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1Listen(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure AppException(Sender: TObject; E: Exception);
    procedure Timer1Timer(Sender: TObject);
    procedure ServerSocket1ClientWrite(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure refreshdata;
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
 private
    { Private declarations }
  public
    Service_Enabled: boolean;
    session: array of session_record;      {会话数组}
    sessions: integer;                     {会话数}
    LookUpTimeOut: integer;                {连接超时值}
    InvalidRequests: integer;
    rec_error:array[0..2047] of char;
    portn:integer;
    reqcharlen:integer;
  end;

var
  Form1: TForm1;

implementation

uses noweb_add, noweb_delete, yesweb_add, yesweb_del, key_add, key_del,
  Unit_about, port_set;

{$R *.DFM}

procedure TForm1.Timer2Timer(Sender: TObject);
begin
   timer2.Enabled:=false;     {关闭定时器}
   sessions:=0;               {会话数=0}
   Application.OnException := AppException;
   invalidRequests:=0;
   LookUpTimeOut:=60000;      {超时值=1分钟}
   timer1.Enabled:=true;
   n11.Enabled:=false;
   n33.Enabled:=false;
   n21.Enabled:=true;
   n34.enabled:=true;
   n3.enabled:=false;
   n4.enabled:=true;
   serversocket1.Port:=portn;    {代理服务器端口=portn}
   serversocket1.Active:=true; {开启服务}
 //  form1.Hide;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
   serversocket1.Port:=portn;
   serversocket1.Active:=true;    {开启服务}
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Service_Enabled:=false;
   timer2.Enabled:=true;    {窗口建立时，打开定时器}
   //以下为服务器拒绝服务时的反馈信息。
   rec_error:='HTTP/1.1 200 OK'+char(13)+char(10)+'Date: Tue, 14 Sep 1999 02:19:57 GMT'+char(13)+char(10)+'Server: Apache/1.2.6'+char(13)+char(10)+'Connection: close'+char(13)+char(10)+'Content-Type: text/html'+char(13)+char(10)+char(13)+char(10)+'<html><head><title>无标题文档</title><meta http-equiv="Content-Type" content="text/html; charset=gb2312"></head>'+'<body bgcolor="#FFFFFF" text="#000000"><div align="left">  <p><b><font color="#FF0066" size="+3">对不起，您的要求被拒绝!</font></b></p>  <p><b><font color="#FF0066" size="+3">请试另一地址。</font></b> </p></div></body></html>';

   combobox1.Items.LoadFromFile('nokey.txt');
   combobox2.Items.LoadFromFile('yesweb.txt');
   combobox4.Items.LoadFromFile('noweb.txt');
   n16.checked:=true;
   n15.checked:=false;
   n16.Enabled:=false;
   n15.Enabled:=true;
   portn:=998;
   reqcharlen:=strlen(rec_error);
   
   
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   timer1.Enabled:=false;
   if Service_Enabled then
      serversocket1.Active:=false;   {退出程序时关闭服务}
end;

procedure TForm1.N21Click(Sender: TObject);
begin
   serversocket1.Active:=false;      {停止服务}
   N11.Enabled:=True;
   n33.Enabled:=true;
   n34.Enabled:=false;
   N21.Enabled:=False;
   n3.enabled:=true;
   n4.enabled:=false;
   Service_Enabled:=false;           {标志清零}
end;

procedure TForm1.N01Click(Sender: TObject);
begin
   form1.Close;
end;

procedure TForm1.ServerSocket1Listen(Sender: TObject;
  Socket: TCustomWinSocket);
begin
   Service_Enabled:=true;
   N11.Enabled:=false;
   n33.Enabled:=false;
   N21.Enabled:=true;
   n34.Enabled:=true;
   n3.enabled:=false;
   n4.Enabled:=true;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
i,j: integer;
begin
   j:=-1;
   for i:=1 to sessions do               {查找是否有空白项}
      if not session[i-1].Used and not session[i-1].CSocket.active then
         begin
            j:=i-1;                      {有，分配它}
            session[j].Used:=true;       {置为在用}
            break;
         end
      else
         if not session[i-1].Used and session[i-1].CSocket.active then
               session[i-1].CSocket.active:=false;
   if j=-1 then
      begin                              {无，新增一个}
         j:=sessions;
         inc(sessions);
         setlength(session,sessions);
         session[j].Used:=true;                        {置为在用}
         session[j].CSocket:=TClientSocket.Create(nil);
         session[j].CSocket.OnConnect:=ClientSocket1Connect;
         session[j].CSocket.OnDisconnect:=ClientSocket1Disconnect;
         session[j].CSocket.OnError:=ClientSocket1Error;
         session[j].CSocket.OnRead:=ClientSocket1Read;
         session[j].CSocket.OnWrite:=ClientSocket1Write;
         session[j].Lookingup:=false;
      end;
   session[j].SS_Handle:=socket.socketHandle;    {保存句柄}
   session[j].Request:=false;                    {无请求}
   session[j].client_connected:=true;            {客户机已连接}
   session[j].remote_connected:=false;           {远程未连接}
   edit1.text:=inttostr(sessions);
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
i,j,k: integer;
begin
   for i:=1 to sessions do
      if (session[i-1].SS_Handle=socket.SocketHandle) and session[i-1].Used then
         begin
            session[i-1].client_connected:=false;   {客户机未连接}
            if session[i-1].remote_connected then
               session[i-1].CSocket.active:=false   {假如远程尚连接，断开它}
            else
               session[i-1].Used:=false;           {假如两者都断开，则置释放资源标志}
            break;
         end;
   j:=sessions;
   k:=0;
   for i:=1 to j do
      begin
         if session[j-i].Used then
            break;
         inc(k);
      end;
   if k>0 then
      begin
         sessions:=sessions-k;
         setlength(session,sessions);
      end;
   edit1.text:=inttostr(sessions);
end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var
i,j,k: integer;
begin
   for i:=1 to sessions do
      if (session[i-1].SS_Handle=socket.SocketHandle) and session[i-1].Used then
         begin
            session[i-1].client_connected:=false;   {客户机未连接}
            if session[i-1].remote_connected then
               session[i-1].CSocket.active:=false   {假如远程尚连接，断开它}
            else
               session[i-1].Used:=false;           {假如两者都断开，则置释放资源标志}
            break;
         end;
   j:=sessions;
   k:=0;
   for i:=1 to j do
      begin
         if session[j-i].Used then
            break;
         inc(k);
      end;
   if k>0 then
      begin
         sessions:=sessions-k;
         setlength(session,sessions);
      end;
   edit1.text:=inttostr(sessions);
   errorcode:=0;
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
tmp,line,host: string;
i,j,port: integer;

begin
 
   //
   for i:=1 to sessions do                 {判断是哪一个会话}
      if session[i-1].Used and (session[i-1].SS_Handle=socket.sockethandle) then
          begin
             session[i-1].request_str:=socket.ReceiveText;  {保存请求数据}
             tmp:=session[i-1].request_str;                 {存放到临时变量}
             memo1.lines.add(tmp);
             j:=pos(char(13)+char(10),tmp);                 {一行标志}
             while j>0 do                                   {逐行扫描请求文本，查找主机地址}
                begin
                   line:=copy(tmp,1,j-1);                  {取一行}
                   delete(tmp,1,j+1);                      {删除一行}
                   j:=pos('Host',line);                    {主机地址标志}
                   if j>0 then
                      begin
                         delete(line,1,j+5);               {删除前面的无效字符}
                         j:=pos(':',line);
                         if j>0 then
                            begin
                               host:=copy(line,1,j-1);
                               delete(line,1,j);
                               try
                                  port:=strtoint(line);
                               except
                                  port:=80;
                               end;
                            end
                         else
                            begin
                               host:=trim(line);                 {获取主机地址}
                               port:=80;
                            end;
                         memo1.lines.add(host);
                        // button4.Caption:=host;
                         //另加对于访问站点的限制判断
                         if  combobox3.Items.IndexOf(combobox3.text)=1 then
                            if combobox4.Items.IndexOf(host)=-1 then
                                if not session[i-1].remote_connected  then  {假如远征尚未连接}
                                   begin
                                       session[i-1].Request:=true;          {置请求数据就绪标志}
                                       session[i-1].CSocket.host:=host;     {设置远程主机地址}
                                       session[i-1].CSocket.port:=port;     {设置端口}
                                       session[i-1].CSocket.active:=true;   {连接远程主机}
                                       session[i-1].Lookingup:=true;        {置标志}
                                       session[i-1].LookupTime:=0;          {从0开始计时}
                                   end
                                else
                                   session[i-1].CSocket.socket.sendtext(session[i-1].request_str)  {假如远程已连接，直接发送请求}
                           //else 向客户端发消息说拒绝访问。serversocket1.Socket.Connections[j-1].SendBuf(rec_error,bytes);
                            else serversocket1.Socket.SendBuf(rec_error,reqcharlen);
                         if  combobox3.Items.IndexOf(combobox3.text)=0 then
                            if combobox2.Items.IndexOf(host)<>-1 then
                                if not session[i-1].remote_connected  then  {假如远征尚未连接}
                                   begin
                                       session[i-1].Request:=true;          {置请求数据就绪标志}
                                       session[i-1].CSocket.host:=host;     {设置远程主机地址}
                                       session[i-1].CSocket.port:=port;     {设置端口}
                                       session[i-1].CSocket.active:=true;   {连接远程主机}
                                       session[i-1].Lookingup:=true;        {置标志}
                                       session[i-1].LookupTime:=0;          {从0开始计时}
                                   end
                                else
                                   session[i-1].CSocket.socket.sendtext(session[i-1].request_str)  {假如远程已连接，直接发送请求}
                              //else 发向客房端不允许访问；
                              //serversocket1.Socket.Connections[j-1].SendBuf(rec_error,bytes);
                            else serversocket1.Socket.SendBuf(rec_error,reqcharlen);


                            ///-------------------
                         //
                         break;                             {停止扫描请求文本}
                      end;
                   j:=pos(char(13)+char(10),tmp);           {指向下一行}
                end;
             break;                    {停止循环}
          end;
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
var
i: integer;
begin
   for i:=1 to sessions do
      if (session[i-1].CSocket.socket.sockethandle=socket.SocketHandle) and session[i-1].Used then
         begin
            session[i-1].CSocket.tag:=socket.SocketHandle;
            session[i-1].remote_connected:=true;   {置远程主机已连通标志}
            session[i-1].Lookingup:=false;         {清标志}
            break;
         end;
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
i,j,k: integer;
begin
   for i:=1 to sessions do
      if (session[i-1].CSocket.tag=socket.SocketHandle) and session[i-1].Used then
         begin
            session[i-1].remote_connected:=false;       {置为未连接}
            if not session[i-1].client_connected then
               session[i-1].Used:=false                {假如客户机已断开，则置释放资源标志}
            else
               for k:=1 to serversocket1.Socket.ActiveConnections do
                  if (serversocket1.Socket.Connections[k-1].SocketHandle=session[i-1].SS_Handle) and session[i-1].used then
                     begin
                        serversocket1.Socket.Connections[k-1].Close;
                        break;
                     end;
            break;
         end;
   j:=sessions;
   k:=0;
   for i:=1 to j do
      begin
         if session[j-i].Used then
            break;
         inc(k);
      end;
   if k>0 then
      begin
         sessions:=sessions-k;
         setlength(session,sessions);
      end;
   edit1.text:=inttostr(sessions);
end;

procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var
i,j,k: integer;
begin
   for i:=1 to sessions do
      if (session[i-1].CSocket.tag=socket.SocketHandle) and session[i-1].Used then
         begin
            socket.close;
            session[i-1].remote_connected:=false;       {置为未连接}
            if not session[i-1].client_connected then
               session[i-1].Used:=false                {假如客户机已断开，则置释放资源标志}
            else
               for k:=1 to serversocket1.Socket.ActiveConnections do
                  if (serversocket1.Socket.Connections[k-1].SocketHandle=session[i-1].SS_Handle) and session[i-1].used then
                     begin
                        serversocket1.Socket.Connections[k-1].Close;
                        break;
                     end;
            break;
         end;
   j:=sessions;
   k:=0;
   for i:=1 to j do
      begin
         if session[j-i].Used then
            break;
         inc(k);
      end;
   errorcode:=0;
   if k>0 then
      begin
         sessions:=sessions-k;
         setlength(session,sessions);
      end;
   edit1.text:=inttostr(sessions);
end;

procedure TForm1.ClientSocket1Write(Sender: TObject;
  Socket: TCustomWinSocket);
var
i: integer;
begin
   for i:=1 to sessions do
      if (session[i-1].CSocket.tag=socket.SocketHandle) and session[i-1].Used then
         begin
            if session[i-1].Request then
               begin
                  socket.SendText(session[i-1].request_str);   {假如有请求，发送}
                  session[i-1].Request:=false;                 {清标志}
               end;
            break;
         end;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var
i,j,k,m: integer;
pass:boolean;
s1,s2:pchar;
rec_bytes: integer;                  {传回的数据块长度}
rec_Buffer: array[0..2047] of char;  {传回的数据块缓冲区}
begin
   for i:=1 to sessions do
      if (session[i-1].CSocket.tag=socket.SocketHandle) and session[i-1].Used then
         begin
            rec_bytes:=socket.ReceiveBuf(rec_buffer,2048);   {接收数据}
            //另加
           pass:=false;
           for m:=1 to combobox1.items.count do
            begin
               s2:=pchar(combobox1.Items.Strings[m]);
               for k:=1 to rec_bytes do
                 begin
                   s1:=pchar(copy(rec_buffer,k,strlen(s2)));
                   if s2=s1 then pass:=true;
                 end;
            end;
            //
            for j:=1 to serversocket1.Socket.ActiveConnections do
                  if serversocket1.Socket.Connections[j-1].SocketHandle=session[i-1].SS_Handle then
                     begin
                        if not pass then
                            serversocket1.Socket.Connections[j-1].SendBuf(rec_buffer,rec_bytes)  {发送数据}
                        else
                            serversocket1.Socket.Connections[j-1].SendBuf(rec_error,reqcharlen);
                        break;
                     end;
            break;
         end;
end;

procedure TForm1.AppException(Sender: TObject; E: Exception);
begin
  inc(invalidrequests);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
i,j: integer;
begin
   for i:=1 to sessions do
      if session[i-1].Used and session[i-1].Lookingup then    {假如正在连接}
         begin
            inc(session[i-1].LookupTime);
            if session[i-1].LookupTime>lookuptimeout then     {假如超时}
               begin
                  session[i-1].Lookingup:=false;
                  session[i-1].CSocket.active:=false;         {停止查找}
                  for j:=1 to serversocket1.Socket.ActiveConnections do
                     if serversocket1.Socket.Connections[j-1].SocketHandle=session[i-1].SS_Handle then
                        begin
                           serversocket1.Socket.Connections[j-1].Close;  {断开客户机}
                           break;
                        end;
               end;
         end;
end;

procedure TForm1.ServerSocket1ClientWrite(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    socket.SendText('220');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

    memo1.Clear;
    

end;

procedure TForm1.ComboBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if ((combobox2.Items.IndexOf(combobox2.text)=-1) and (key=vk_RETURN)) then
    begin
         combobox2.items.Add(combobox2.text);
         combobox2.Items.SaveToFile('yesweb.txt');
    end;
END;

procedure TForm1.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if ((combobox1.Items.IndexOf(combobox1.text)=-1) and (key=vk_RETURN)) then
     begin
        combobox1.items.Add(combobox1.text);
        combobox1.Items.SaveToFile('nokey.txt');
     end;
end;

procedure TForm1.ComboBox4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if ((combobox4.Items.IndexOf(combobox4.text)=-1) and (key=vk_RETURN)) then
    begin
      combobox4.items.Add(combobox4.text);
      combobox4.Items.SaveToFile('noweb.txt');
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
      form1.Close;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
   serversocket1.Port:=portn;
   serversocket1.Active:=true;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
   serversocket1.Active:=false;      {停止服务}
   N11.Enabled:=True;
   n33.Enabled:=true;
   N21.Enabled:=False;
   n34.Enabled:=false;
   n3.Enabled:=true;
   n4.enabled:=false;
   Service_Enabled:=false;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
      form1.Close;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
     web_add.show;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
     web_del.show;
end;

procedure tform1.refreshdata;
begin
   combobox1.items.loadfromfile('nokey.txt');
   combobox2.items.loadfromfile('yesweb.txt');
   combobox4.items.loadfromfile('noweb.txt');

end;
procedure TForm1.N12Click(Sender: TObject);
begin
      yeswebadd.show;
end;

procedure TForm1.N13Click(Sender: TObject);
begin
   yeswebdel.show;
end;

procedure TForm1.N16Click(Sender: TObject);
begin
      n16.enabled:=false;
      n16.checked:=true;
      n15.Enabled:=true;
      n15.Checked:=false;
      form1.combobox3.text:=form1.ComboBox3.Items.Strings[1];
end;

procedure TForm1.N15Click(Sender: TObject);
begin
       n15.Checked:=true;
       n15.Enabled:=false;
       n16.Checked:=false;
       n16.Enabled:=true;
       form1.combobox3.text:=form1.ComboBox3.Items.Strings[0];
end;

procedure TForm1.N18Click(Sender: TObject);
begin
  keyadd.show;
end;

procedure TForm1.N19Click(Sender: TObject);
begin
     keydel.show;
end;

procedure TForm1.N27Click(Sender: TObject);
begin
   form1.ComboBox4.Items.Clear;
   form1.ComboBox4.Items.SaveToFile('noweb.txt');

end;

procedure TForm1.N25Click(Sender: TObject);
begin
   form1.ComboBox2.Items.Clear;
   form1.ComboBox2.Items.SaveToFile('yesweb.txt');

end;

procedure TForm1.N20Click(Sender: TObject);
begin
   form1.ComboBox1.Items.Clear;
   form1.ComboBox1.Items.SaveToFile('nokey.txt');

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
      form1.refreshdata;
end;

procedure TForm1.N29Click(Sender: TObject);
begin
   about.show;
end;

procedure TForm1.N30Click(Sender: TObject);
begin
      showmessage('对不起，时间仓促，暂不提供帮助信息。有困难，请联系我。');
end;

procedure TForm1.N31Click(Sender: TObject);
begin
    port_setup.show;
end;

procedure TForm1.N36Click(Sender: TObject);
begin
      close;
end;

procedure TForm1.N35Click(Sender: TObject);
begin
       show;
end;

procedure TForm1.N33Click(Sender: TObject);
begin
   serversocket1.Port:=portn;
   serversocket1.Active:=true;       
end;

procedure TForm1.N34Click(Sender: TObject);
begin
   serversocket1.Active:=false;      {停止服务}
   N11.Enabled:=True;
   n33.Enabled:=true;
   N21.Enabled:=False;
   n34.enabled:=false;
   n3.enabled:=true;
   n4.enabled:=false;
   Service_Enabled:=false;           {标志清零}
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
       if  combobox3.text='只拒绝拒绝访问的' then
          begin
             combobox4.Enabled:=true;
             combobox2.Enabled:=false;
          end
       else
         if combobox3.text='只访问允许访问的' then
             begin
                combobox4.Enabled:=false;
                combobox2.Enabled:=true;
             end
         else
             combobox3.text:='只拒绝拒绝访问的';
end;

end.
