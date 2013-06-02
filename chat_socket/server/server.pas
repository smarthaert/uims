unit server;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ScktComp, StdCtrls, DB, DBTables, ToolWin;

type
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Table1: TTable;
    ToolBar1: TToolBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Button4: TButton;
    procedure ServerSocket1Listen(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure N1Click(Sender: TObject);
    procedure ServerSocket1Accept(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i : integer;
  //addr: array [0..100] of  string;
  counter : integer;
  chatname : array [0..100] of string;
  clientip: string;
implementation

uses Unit3;

{$R *.dfm}

procedure TForm1.ServerSocket1Listen(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  statusbar1.SimpleText:='监听状态...';
  counter:=0;
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 statusbar1.SimpleText:='连接到 '+ socket.RemoteAddress;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  statusbar1.SimpleText:= Socket.RemoteAddress +' 已连接';
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
  var
      tmptext: string;
      check :string;
      i,j: integer;
      chattext:string;
      signpos : integer;
      member : string;
      usename : string;
begin
     tmptext := socket.ReceiveText;
  if pos('%&%&%&',tmptext)<>0 then // 当有'%&%&%&'字符串时表示私聊
    begin
      tmptext := copy(tmptext,1,length(tmptext)-6);
      signpos:= pos('&&',tmptext);
      chattext:= copy(tmptext,1,signpos-1);
      member:=copy(tmptext, signpos+2,pos('$$',tmptext)-2-signpos);
      usename:=copy(tmptext,pos('$$',tmptext)+2,length(tmptext)-pos('$$',tmptext)+2);
      for i:=0 to  counter-1  do
         begin
         if member=chatname[i] then
            begin
            serversocket1.Socket.Connections[i].SendText(usename+'悄悄对你说：'+chattext);
            break;
            end;
         end;
    end

  else if   pos('$%$%$%',tmptext)<>0  then  // 当有'$%$%$%'表示有登陆信息
      begin
        tmptext := copy(tmptext,1,length(tmptext)-6);
        chatname[counter]:=tmptext;
        listbox1.Items.add(tmptext);
        check :=(table1.lookup('usename',tmptext,'password'));
        socket.SendText(check+'@#$%^&');
        if counter>0 then
         begin
           for i:=0 to counter-1 do
           begin
             serversocket1.Socket.Connections[counter].SendText(chatname[i]+'~{}()&*%^');
             serverSocket1.Socket.Connections[i].SendText(tmptext+'~{}()&*%^');
             sleep(300);
           end;
        end;
        inc(counter);
      end
else if pos('??**##',tmptext)<>0  then   //表示注册信息
       begin
           signpos:=pos('??**##',tmptext);
           member:=copy(tmptext,1,signpos-1);
           chattext:=copy(tmptext,signpos+6,length(tmptext)-6-length(member));
           with table1 do
           begin
           if   table1.FindField('usename').AsString=member  then
                socket.SendText('用户名已经有人用了，请检查后重新注册。')
           else
              begin
                insertrecord([member,chattext]);
                memo1.Lines.Add('新用户：['+member+']注册成功！');
                socket.SendText('注册成功，请先登陆再进行聊天！');
              end;
           end;
       end
else if  pos('*^&%#^)@',tmptext)<>0 then // 有人走了
        begin
        tmptext:=copy(tmptext,1,length(tmptext)-8);
//        memo1.Lines.Add('用户['+tmptext+']离开聊天室。');
        for i:=0 to counter-1 do
          serversocket1.Socket.Connections[i].SendText(tmptext+'^$%#^$');
        for i:=listbox1.items.Count downto 1 do
          if listbox1.Items.Strings[i-1]=tmptext then
              begin
              listbox1.Items.Delete(i-1);
              dec(counter);
              end;
        end
else  // 当无任何标记时表示公聊
         begin
         for i:=0 to counter-1 do
         serversocket1.Socket.Connections[i].SendText(tmptext);
         end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
       serversocket1.Active:=false;
       serversocket1.Close;
end;

procedure TForm1.ServerSocket1Accept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
   clientip:=socket.RemoteAddress
end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  if errorcode=10054 then
    errorcode:=0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  table1.Active:=true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not serversocket1.Active then
  begin
    serversocket1.Active:=true;
    memo1.Lines.Add('服务器连接！['+Datetimetostr(now)+']');
  end else
    showmessage('已经在监听状态');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  serversocket1.Active:=false;
  serversocket1.Close;
  statusbar1.SimpleText:='服务器已经关闭';
  memo1.Lines.Add('服务器关闭！['+Datetimetostr(now)+']');
  listbox1.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  button1.Click;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form3.ShowModal;
end;

end.
