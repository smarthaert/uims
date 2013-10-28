unit Unit1;

interface
//Download by http://www.codefans.net
uses
  Windows,  SysUtils,     Forms,UrlMon,
  Dialogs,   StdCtrls,Registry,StrUtils,Tlhelp32,filectrl,mmSystem,
  WinSkinData, WinSkinStore, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze, ComCtrls,
  Controls, Buttons, Classes,ExtCtrls,  Graphics,shellapi, Messages,Variants;

type
    TForm1 = class(TForm)
    ListView1: TListView;
    Label1: TLabel;
    IdAntiFreeze1: TIdAntiFreeze;
    IdHTTP1: TIdHTTP;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    SkinStore1: TSkinStore;
    SkinData1: TSkinData;
    SpeedButton1: TSpeedButton;
    Image2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;

    procedure EndProcess(AFileName: string);

    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private

    { Private declarations }
  public

    { Public declarations }
    //procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY; 当接收到WM_HOTKEY消息时执行 WMHotKey过程
  end;

var
  Form1: TForm1;
  baiduarr: array of string;
implementation
{$R *.dfm}





 procedure TForm1.EndProcess(AFileName: string);
const
 PROCESS_TERMINATE = $0001;
var
 ContinueLoop: BOOL;
 FSnapShotHandle: THandle;
 FProcessEntry32: TProcessEntry32;
 KillHandle: THandle;//用于杀死进程
begin
 FSnapShotHandle := CreateToolhelp32SnapShot(TH32CS_SNAPPROCESS, 0);
 FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
 ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
 while integer(ContinueLoop) <> 0 do
 begin
   if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(AFileName)) or (UpperCase(FProcessEntry32.szExeFile )=UpperCase(AFileName))) then
   begin
   KillHandle := OpenProcess(PROCESS_TERMINATE, False, FProcessEntry32.th32ProcessID);
     TerminateProcess(KillHandle, 0);//强制关闭进程
     CloseHandle(KillHandle);
     exit;
end;
   ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
   end;
end;


procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
 ProgressBar1.Max:=AWorkCountMax;
ProgressBar1.Min:=0;
ProgressBar1.Position:=0;
end;

procedure TForm1.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
ProgressBar1.Position:=ProgressBar1.Position+AWorkCount;
end;




procedure TForm1.FormCreate(Sender: TObject);
begin
   SkinData1.LoadFromCollection(skinstore1,0);
   if not SkinData1.active then SkinData1.active:=true;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var

strbaiduname:string;
var
sl:TStringList;attr : integer;//lonstr:string;  //定   TStringList数据类型
strtxt:string;strxt:string;lon:integer;Filestrr:string; Filestrrr:string;
ARegistry : TRegistry;lonstr:integer; a:integer;
regestr:string;jishu:string;cl:string;MySysPath : pchar ;
Filestr:string;finame:string;isfile:boolean;isregedit:boolean;
Sr: TSearchRec;Err: Integer;str1:string;str2:string;str3:string;int1:integer;
begin
  if  FileExists(ExtractFilePath(Application.ExeName)+'xxzh.dat') =false then
    begin
    showmessage('库文件不存在,无法启动扫描');
    exit;
  end;
  //////////////////////////////////////////////////
  ListView1.Clear ;
  jishu:='';
  ARegistry := TRegistry.Create;
  sl:=Tstringlist.create;  //初始化sl
   try
  sl.LoadFromFile(ExtractFilePath(Application.ExeName)+'xxzh.dat');  //装入文件
  except
  showmessage('文件正被其它程序打开斩时无法读取');
  exit;
  end;
  SetLength(baiduarr,sl.Count );
  for lon:=0 to sl.Count-1 do
      begin
        baiduarr[lon]:= sl.Strings [lon] ;
        strtxt:=baiduarr[lon];
        if (baiduarr[lon]='[info]') or (baiduarr[lon]='[indentify]') or(baiduarr[lon]='[process]')or (baiduarr[lon]='[regsvr]')or (baiduarr[lon]='[files]') or (baiduarr[lon]='[registry]') then
         strxt:= baiduarr[lon] ;
         if (strxt='[info]') and (strtxt <> '' ) and  ( strtxt <> strxt) then
          begin
           if (finame<>'') and ((jishu ='jishu') or (jishu ='jishuss')) then
           begin
         //  Image2.Enabled :=true;
            with ListView1.Items.Add do
               begin
                   Caption:=finame;
                    SubItems.Add('有残余文件');
              end;
              jishu:='';
            end;
            if (finame<>'') and (jishu='jishus')  then
            begin
            Image2.Enabled :=true;
           with ListView1.Items.Add do
            begin
               Caption:=finame ;
                SubItems.Add('存在');
             end;
             jishu:='';
            end;
            if LeftStr(strtxt,4)='name' then
            begin
            finame:= copy(strtxt,pos('=',strtxt)+2,Length(strtxt)-pos('=',strtxt)+2);
            Label1.Caption :='正在扫描'+finame+'......';
            end;
          end
    else if lon= sl.Count-1  then
    begin

       if (finame<>'') and ((jishu ='jishu')or (jishu ='jishuss'))  then
           begin
            with ListView1.Items.Add do
               begin
                   Caption:=finame;
                    SubItems.Add('有残余文件');
              end;
              jishu:='';
            end;
            if (finame<>'') and (jishu='jishus')  then
            begin
           with ListView1.Items.Add do
            begin
               Caption:=finame ;
                SubItems.Add('存在');
             end;
             jishu:='';
            end;

  end
       else if (( strxt='[registry]')) and (strtxt <> '' ) and  ( strtxt <> strxt) then
        begin
          regestr:=copy(strtxt,1,pos('\',strtxt)-1);
        if UpperCase(regestr)='HKEY_LOCAL_MACHINE' then
           aregistry.RootKey :=  HKEY_LOCAL_MACHINE
           else if UpperCase(regestr)='HKEY_CLASSES_ROOT' then
           aregistry.RootKey :=  HKEY_CLASSES_ROOT
           else if UpperCase(regestr)='HKEY_CURRENT_USER' then
           aregistry.RootKey :=  HKEY_CURRENT_USER
           else if UpperCase(regestr)='HKEY_USERS' then
           aregistry.RootKey :=  HKEY_USERS
           else if UpperCase(regestr)='HKEY_CURRENT_CONFIG' then
           aregistry.RootKey :=  HKEY_CURRENT_CONFIG;
           strtxt:= copy(strtxt,1,pos('=',strtxt)-1);
           strtxt:= copy(strtxt,pos('\',strtxt),length(strtxt)-pos('\',strtxt));
         if ARegistry.OpenKeyReadOnly(strtxt)=true then
           begin
           if jishu ='jishu' then
             jishu:='jishus' ;
            if jishu='' then
            jishu:='jishuss';
             end ;
         end
        else if ((strxt='[files]') ) and (strtxt <> '' ) and  ( strtxt <> strxt) then
          begin
             cl:=RightStr(strtxt,Length(strtxt)-1);
             regestr:=copy(cl,1,pos('}',strtxt)-2);
             regestr:=LowerCase(regestr);
             if regestr='sys' then
             begin
              GetMem(MySysPath,255);                //为mysyspath指针类型开辟255个字节FREEMEM(MySysPath,255);//为mysyspath指针类型释放255个字节
              GetSystemDirectory(MySysPath,255);  //GetMem(
              Filestr:=strpas(MySysPath);     //strpas是将pchar转换为string
               cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:=Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
             end
             else if  regestr='win' then
             begin
             GetMem(MySysPath,255);
            GetWindowsDirectory(mysyspath,255) ;
            Filestr:=strpas(MySysPath);
            cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
            Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
            FREEMEM(MySysPath,255) ;
             end
             else if  regestr='prg' then
             begin
              GetMem(MySysPath,255);
              GetWindowsDirectory(mysyspath,255) ;
              Filestr:=strpas(MySysPath);
              Filestr:=leftstr(filestr,3);
              Filestr:=Filestr+'Program Files';
              cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
              end
             else if regestr='tmp' then
             begin
             GetMem(MySysPath,255);
             GetTempPath(255 , MySysPath);
              Filestr:=strpas(MySysPath);
              cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
               end
             else if  regestr='uprograms' then
             begin
            //  GetMem(MySysPath,255);
           //  GetTempPath(255 , MySysPath);
           //   Filestr:=strpas(MySysPath);
           //   cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
           //   Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
           //   FREEMEM(MySysPath,255) ;
              end
             else if regestr='cprograms'  then
             begin
            // GetMem(MySysPath,255);
            // GetTempPath(255 , MySysPath);
            //  Filestr:=strpas(MySysPath);
             // cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
             // Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
             // FREEMEM(MySysPath,255) ;
              end;
///////////////////////////////////////////////////////////////
if pos('*',Filestr) <> 0 then
begin

filestrr:=copy(Filestr,pos('*',Filestr)-1,Length(Filestr)-pos('*',Filestr)+1);
if filestrr ='\*.*'  then
begin
Filestrrr:=copy(Filestr,1,pos('*',Filestr)-1);
if DirectoryExists(Filestrrr)then
begin
ChDir(Filestrrr);
Err := FindFirst('*.*',$37,Sr);
while (Err = 0) do
begin
if Sr.Name[1] <> '.' then
begin
if (Sr.Attr and faDirectory) = 0 then
begin
 jishu:='jishu';
end ;     //扫到文件
end;
Err := FindNext(Sr);
end;   //for扫描
end;     //文件夹存在
end;   //\*.*
////////////////////////////
 filestrr:=copy(Filestr,pos('*',Filestr),3);
   if filestrr <>'*.*'  then
   begin
     Filestrrr:=copy(Filestr,1,pos('*',Filestr)-1);
     if DirectoryExists(Filestrrr)then
     begin
      ChDir(Filestrrr);
        Err := FindFirst('*.*',$37,Sr);
       while (Err = 0) do
       begin
      if Sr.Name[1] <> '.' then
      begin
        if (Sr.Attr and faDirectory) = 0 then
            begin
         if rightstr(ExpandFileName(Sr.Name),3)=rightstr(Filestr,3) then    //扫到文件
           begin
            jishu:='jishu';
           end;  //*.ico
            end;     //有文件
            end;
           Err := FindNext(Sr);
            end; //whows
          end;      //文件夹在
          end;      //<>*.*
          ///////////////////////////////
      //////////////////////////////////////////////////
      filestrr:=copy(Filestr,pos('*',Filestr)-1,Length(Filestr)-pos('*',Filestr)+1);
if filestrr <>'\*.*'  then
   begin
    str1:=ReverseString(Filestr);
    str2:=ReverseString(copy(str1,1,pos('\',str1)-1));
   str3:=ReverseString(copy(str1,pos('\',str1)+1,Length(str1)-pos('\',str1)));
        if DirectoryExists(str3)then
     begin
      ChDir(str3);
        Err := FindFirst('*.*',$37,Sr);
        while (Err = 0) do
       begin
      if Sr.Name[1] <> '.' then
      begin
        if (Sr.Attr and faDirectory) = 0 then
        begin
if pos(leftstr(str2,Length(str2)-3),sr.Name)<>0then
           begin
            jishu:='jishu';
           end;  //*.ico
            end;     //有文件
            end;
           Err := FindNext(Sr);
            end; //whows
          end;      //文件夹在
          end;      //<>*.*
end
else // if pos('*',Filestr) = 0 then
         begin
          if  FileExists (Filestr)  then
          begin
           jishu:='jishu';
end;

end;
end;
end;
ARegistry.Free ;
 if ListView1.Items.Count=0 then  begin
label1.Caption :='未扫到流氓软件'
end
 else begin
  label1.Caption :='扫到'+inttostr(ListView1.Items.Count)+'个流氓软件';
   image2.Enabled :=true;
   end;
end;













procedure TForm1.Image2Click(Sender: TObject);

var
strbaiduname:string;

hu:integer;
//sl:TStringList;//lonstr:string;  //定   TStringList数据类型
strtxt:string;strxt:string;lon:longword;Filestrr:string; Filestrrr:string;
ARegistry : TRegistry;lonstr:integer; a:integer;cll:integer;lc:string;
regestr:string;jishu:string;cl:string;MySysPath : pchar ;str4:string;
Filestr:string;finame:string;isfile:boolean;isregedit:boolean; attr : integer;
Sr: TSearchRec;Err: Integer;str1:string;str2:string;str3:string;int1:integer;
winHwnd :hWnd;PIDD:LongWord; msg:string;    HandleIE   :   integer ;
play: Integer;

st : SYSTEMTIME;hToken : THANDLE;tkp : TOKEN_PRIVILEGES;rr : Dword;
begin
  ARegistry := TRegistry.Create;
  for hu :=1 to 2 do
  begin
   application.ProcessMessages ;
 for lon:=0 to high(baiduarr) do
 begin
 application.ProcessMessages   ;
       strtxt:=baiduarr[lon];
        if (baiduarr[lon]='[info]') or (baiduarr[lon]='[indentify]') or(baiduarr[lon]='[process]')or (baiduarr[lon]='[regsvr]')or (baiduarr[lon]='[files]') or (baiduarr[lon]='[registry]') then
         strxt:= baiduarr[lon] ;
         if (strxt='[info]') and (strtxt <> '' ) and  ( strtxt <> strxt) then
          begin
           if LeftStr(strtxt,4)='name' then
           begin
          lc:='';
           finame:= copy(strtxt,pos('=',strtxt)+2,Length(strtxt)-pos('=',strtxt)+2);
          for cll:=0 to ListView1.Items.Count-1 do
          begin
          if  listview1.Items.Item[cll].Checked=true   then
          begin
          if finame =listview1.Items.Item[cll].Caption then
          begin
          if hu=1 then
           begin
             winHwnd := FindWindow( nil, 'Program Manager');
            if winhwnd<>0 then
             begin
        GetWindowThreadProcessId(winHwnd,PIDD);
         winexec(pchar('taskkill /f /pid '+inttostr(PIDD)),1)   ;
          end ;
             HandleIE   :=   FindWindow(pchar('IEFRAME'),nil);
             SendMessage(HandleIE,WM_SYSCOMMAND,SC_CLOSE,0);
             while HandleIE <>0 do
             begin
                   HandleIE   :=   FindWindow(pchar('IEFRAME'),nil);
                     SendMessage(HandleIE,WM_SYSCOMMAND,SC_CLOSE,0);
                   EndProcess('IEXPLORE.EXE');
                     EndProcess('iexplore.exe');
                end;
          listview1.Items.Item[cll].Checked:=false;
          ListView1.items.Item[cll].SubItems[0]:='清除完毕';
          lc:='lc';
           Label1.Caption :='正在清除'+finame+'......';
           break;
           if FileExists(ExtractFilePath(Application.ExeName)+'SOUND5.WAV') and( play<>0) then
 PlaySound(pchar(ExtractFilePath(Application.ExeName)+'SOUND5.WAV'),0,snd_Async);
play:=play+1;
           end;
          end
          else
          begin
          lc:='';
           break;
          end;
          end;
          end;
          end;
          end




         






          
  /////////////////////////////////////////////////////////////////////////
       else if (strxt='[process]')and (lc='lc')and (strtxt <> '' ) and  ( strtxt <> strxt) then
        begin
           strtxt:= copy(strtxt,1,pos('=',strtxt)-1);
           if pos('explorer.exe',LowerCase(strtxt))<>0 then
            begin
            winHwnd := FindWindow( nil, 'Program Manager');
            if winhwnd<>0 then
             begin
        GetWindowThreadProcessId(winHwnd,PIDD);
         winexec(pchar('taskkill /f /pid '+inttostr(PIDD)),1)   ;
          end ;
         end
         else
         begin
        EndProcess(strtxt);
         end;

       // EndProcess(strtxt);
         end

          else if (strxt='[regsvr]')and (strtxt <> '' ) and  ( strtxt <> strxt)and ( lc='lc') then
        begin
        cl:=RightStr(strtxt,Length(strtxt)-1);
             regestr:=copy(cl,1,pos('}',strtxt)-2);
             regestr:=LowerCase(regestr);
             if regestr='sys' then
             begin
              GetMem(MySysPath,255);                //为mysyspath指针类型开辟255个字节FREEMEM(MySysPath,255);//为mysyspath指针类型释放255个字节
              GetSystemDirectory(MySysPath,255);  //GetMem(
              Filestr:=strpas(MySysPath);     //strpas是将pchar转换为string
               cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:=Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
             end
             else if  regestr='win' then
             begin
             GetMem(MySysPath,255);
            GetWindowsDirectory(mysyspath,255) ;
            Filestr:=strpas(MySysPath);
            cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
            Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
            FREEMEM(MySysPath,255) ;
             end
             else if  regestr='prg' then
             begin
              GetMem(MySysPath,255);
              GetWindowsDirectory(mysyspath,255) ;
              Filestr:=strpas(MySysPath);
              Filestr:=leftstr(filestr,3);
              Filestr:=Filestr+'Program Files';
              cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
              end
             else if regestr='tmp' then
             begin
             GetMem(MySysPath,255);
             GetTempPath(255 , MySysPath);
              Filestr:=strpas(MySysPath);
              cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
               end;
               winexec(pchar('regsvr32 /u /s '+ '"'+Filestr+'"'),1)   ;
             //反注册dll文件
         end
         ///删除文件
        else if (strxt='[files]') and (strtxt <> '' ) and  ( strtxt <> strxt)and (lc='lc') then
          begin
             cl:=RightStr(strtxt,Length(strtxt)-1);
             regestr:=copy(cl,1,pos('}',strtxt)-2);
             regestr:=LowerCase(regestr);
             if regestr='sys' then
             begin
              GetMem(MySysPath,255);                //为mysyspath指针类型开辟255个字节FREEMEM(MySysPath,255);//为mysyspath指针类型释放255个字节
              GetSystemDirectory(MySysPath,255);  //GetMem(
              Filestr:=strpas(MySysPath);     //strpas是将pchar转换为string
               cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:=Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
             end
             else if  regestr='win' then
             begin
             GetMem(MySysPath,255);
            GetWindowsDirectory(mysyspath,255) ;
            Filestr:=strpas(MySysPath);
            cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
            Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
            FREEMEM(MySysPath,255) ;
             end
             else if  regestr='prg' then
             begin
              GetMem(MySysPath,255);
              GetWindowsDirectory(mysyspath,255) ;
              Filestr:=strpas(MySysPath);
              Filestr:=leftstr(filestr,3);
              Filestr:=Filestr+'Program Files';
              cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
              end
             else if regestr='tmp' then
             begin
             GetMem(MySysPath,255);
             GetTempPath(255 , MySysPath);
              Filestr:=strpas(MySysPath);
              cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
              Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
              FREEMEM(MySysPath,255) ;
               end
             else if  regestr='uprograms' then
             begin
            //  GetMem(MySysPath,255);
           //  GetTempPath(255 , MySysPath);
           //   Filestr:=strpas(MySysPath);
          //    cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
           //   Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
           //   FREEMEM(MySysPath,255) ;
              end
             else if regestr='cprograms'  then
             begin
          //   GetMem(MySysPath,255);
          //   GetTempPath(255 , MySysPath);
           //   Filestr:=strpas(MySysPath);
          ///    cl:=RightStr(strtxt,Length(strtxt)-pos('}',strtxt));
           //   Filestr:= Filestr+'\'+ copy(cl,1,pos('=',cl)-1 );
           //   FREEMEM(MySysPath,255) ;
              end;
///////////////////////////////////////////////////////////////
if pos('*',Filestr) <> 0 then
begin
filestrr:=copy(Filestr,pos('*',Filestr)-1,Length(Filestr)-pos('*',Filestr)+1);
if filestrr ='\*.*'  then
begin
Filestrrr:=copy(Filestr,1,pos('*',Filestr)-1);
if DirectoryExists(Filestrrr)then
begin
ChDir(Filestrrr);
Err := FindFirst('*.*',$37,Sr);
while (Err = 0) do
begin
if Sr.Name[1] <> '.' then
begin
if (Sr.Attr and faDirectory) = 0 then
begin
 showmessage(Sr.Name);
attr:= FileGetAttr(ExpandFileName(Sr.Name));
attr := attr and (not faReadOnly); //删除只读属性
FileSetAttr(ExpandFileName(Sr.Name), attr);
 if hu=1 then
 begin
DeleteFile(PChar(ExpandFileName(Sr.Name)));
 end
else
begin
ListView1.items.Item[cll].SubItems[0]:='未清除完毕,下次重起时将自动清除'  ;
  MoveFileEx(PChar(ExpandFileName(Sr.Name)),nil,MOVEFILE_DELAY_UNTIL_REBOOT);
 //下次重起计算机时删除文件
   msg:='msg';
 end;

end ;     //扫到文件
end;
Err := FindNext(Sr);
end;   //for扫描
end;     //文件夹存在
end;   //\*.*
////////////////////////////
 filestrr:=copy(Filestr,pos('*',Filestr),3);
   if filestrr <>'*.*'  then
   begin
     Filestrrr:=copy(Filestr,1,pos('*',Filestr)-1);
     if DirectoryExists(Filestrrr)then
     begin
      ChDir(Filestrrr);
        Err := FindFirst('*.*',$37,Sr);
       while (Err = 0) do
       begin
      if Sr.Name[1] <> '.' then
      begin
        if (Sr.Attr and faDirectory) = 0 then
            begin
         if rightstr(ExpandFileName(Sr.Name),3)=rightstr(Filestr,3) then    //扫到文件
           begin
attr:= FileGetAttr(ExpandFileName(Sr.Name));
attr := attr and (not faReadOnly); //删除只读属性
FileSetAttr(ExpandFileName(Sr.Name), attr);
if hu=1 then
begin
DeleteFile(PChar(ExpandFileName(Sr.Name)));
end
else
begin
  MoveFileEx(PChar(ExpandFileName(Sr.Name)),nil,MOVEFILE_DELAY_UNTIL_REBOOT);
   msg:='msg';
 //下次重起计算机时删除文件
   ListView1.items.Item[cll].SubItems[0]:='未清除完毕,下次重起时将自动清除';
 end;
           end;  //*.ico
            end;     //有文件
            end;
           Err := FindNext(Sr);
            end; //whows
          end;      //文件夹在
          end;      //<>*.*
          ///////////////////////////////
      //////////////////////////////////////////////////
filestrr:=copy(Filestr,pos('*',Filestr)-1,Length(Filestr)-pos('*',Filestr)+1);
if filestrr <>'\*.*'  then
   begin
    str1:=ReverseString(Filestr);
    str2:=ReverseString(copy(str1,1,pos('\',str1)-1));
   str3:=ReverseString(copy(str1,pos('\',str1)+1,Length(str1)-pos('\',str1)));
        if DirectoryExists(str3)then
     begin
      ChDir(str3);
        Err := FindFirst('*.*',$37,Sr);
        while (Err = 0) do
       begin
      if Sr.Name[1] <> '.' then
      begin
        if (Sr.Attr and faDirectory) = 0 then
        begin
       if pos(leftstr(str2,Length(str2)-3),sr.Name)<>0then
           begin
attr:= FileGetAttr(ExpandFileName(Sr.Name));
attr := attr and (not faReadOnly); //删除只读属性
FileSetAttr(ExpandFileName(Sr.Name), attr);
if hu=1 then
begin
DeleteFile(PChar(ExpandFileName(Sr.Name)));
end
 else
 begin
  MoveFileEx(PChar(ExpandFileName(Sr.Name)),nil,MOVEFILE_DELAY_UNTIL_REBOOT);
   msg:='msg';
   ListView1.items.Item[cll].SubItems[0]:='未清除完毕,下次重起时将自动清除';
 //下次重起计算机时删除文件
 end;

           end;  //*.ico
            end;     //有文件
            end;
           Err := FindNext(Sr);
            end; //whows
          end;      //文件夹在
          end;      //<>*.*
          end
          else   //if pos('*',Filestr) = 0 then
          begin
          attr:= FileGetAttr(ExpandFileName(Filestr));
        attr := attr and (not faReadOnly); //删除只读属性
       FileSetAttr(ExpandFileName(Filestr), attr);
 if hu=1 then
 begin
DeleteFile(PChar(ExpandFileName(Filestr)));
end
else
begin
  msg:='msg';
   ListView1.items.Item[cll-1].SubItems[0]:='未清除完毕,下次重起时将自动清除';
   MoveFileEx(PChar(ExpandFileName(Filestr)),nil,MOVEFILE_DELAY_UNTIL_REBOOT);
//下次重起计算机时删除文件
end;

end;
end
  else if (strxt='[registry]') and (strtxt <> '' ) and  ( strtxt <> strxt)and(lc='lc') then
  begin
 regestr:=copy(strtxt,1,pos('\',strtxt)-1);
        if UpperCase(regestr)='HKEY_LOCAL_MACHINE' then
           aregistry.RootKey :=  HKEY_LOCAL_MACHINE
           else if UpperCase(regestr)='HKEY_CLASSES_ROOT' then
           aregistry.RootKey :=  HKEY_CLASSES_ROOT
           else if UpperCase(regestr)='HKEY_CURRENT_USER' then
           aregistry.RootKey :=  HKEY_CURRENT_USER
           else if UpperCase(regestr)='HKEY_USERS' then
           aregistry.RootKey :=  HKEY_USERS
           else if UpperCase(regestr)='HKEY_CURRENT_CONFIG' then
           aregistry.RootKey :=  HKEY_CURRENT_CONFIG;
           strtxt:= copy(strtxt,1,pos('=',strtxt)-1);
           strtxt:= copy(strtxt,pos('\',strtxt),length(strtxt)-pos('\',strtxt));
           if (aregistry.OpenKeyReadOnly(strtxt)=true) and (hu=1) then   begin

//删除注册表
aregistry.DeleteKey(strtxt); //删除注册表项
aregistry.CloseKey;
end;
if (aregistry.OpenKeyReadOnly(strtxt)=true) and (hu=2) then
  begin

ListView1.items.Item[cll-1].SubItems[0]:='未清除完毕,下次重起时将自动清除';
end;

//aregistry.Free;
//删除注册表
end;
end;   //有*
end;
//aregistry.Free;
  winHwnd := FindWindow( nil, 'Program Manager');
  if winhwnd=0 then
winexec('explorer.exe',1 );

if  msg='msg' then
begin
if   MessageBox(Handle,   '你确定现在就重起计算机吗？重起计算机前请保存其它程序',   '提示',MB_YESNO   or   MB_ICONINFORMATION)   =   IDYes   then
begin
OpenProcessToken(GetCurrentProcess(),TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,hToken);
LookupPrivilegeValue(nil,'SeShutdownPrivilege',tkp.Privileges[0].Luid);
// 设定权限为1
tkp.PrivilegeCount := 1;
tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
// 得到权限
AdjustTokenPrivileges(hToken, FALSE, tkp, 0,nil,rr);
// 重起计算机
ExitWindowsEx(2, 1)
 end;
 end;
 label1.Caption :='清除完毕';
end;


procedure TForm1.SpeedButton3Click(Sender: TObject);
var
MyStream: TFileStream;
FileSizeE: integer;
FF:File of Byte;
Size:integer; sll:TStringList;jj:string;
begin
 if  FileExists(ExtractFilePath(Application.ExeName)+'gamersky.dat') =false then
    begin
    showmessage('文件被破坏,找不到升级地址');
    exit;
  end;
sll:=Tstringlist.create;
sll.LoadFromFile(ExtractFilePath(Application.ExeName)+'gamersky.dat');
if sll.Count <>0 then
jj:=sll. Strings[0];
if jj='' then
  begin
    showmessage('文件被破坏,找不到升级地址');
    exit;
  end;
 sll.Free ;
ProgressBar1.Visible :=true;
Label2.Visible :=true;
 if  FileExists(ExtractFilePath(Application.ExeName)+'xxzh.dat') =false then
 begin
 MyStream :=   TFileStream.Create(ExtractFilePath(Application.ExeName)+'xxzh.dat' ,   fmCreate);
 try
IdHTTP1.Get(jj,MyStream);//下载我站点的一个ZIP文件
ProgressBar1.Visible :=true;
Label2.Visible :=true;
IdAntiFreeze1.OnlyWhenIdle:=False;//设置使程序有反应.

except//INDY控件一般要使用这种try..except结构.
// ProgressBar1.Max:=AWorkCountMax;
ProgressBar1.Min:=0;
ProgressBar1.Position:=0;
Showmessage('网络出错无法升级!');
MyStream.Free;
ProgressBar1.Visible :=false;
Label2.Visible :=false;
Exit;
end;
ProgressBar1.Visible :=false;
Label2.Visible :=false;
MyStream.Free;
Showmessage('下载完毕');
 end
 else
 begin
 try
  IdHTTP1.Head(jj);
  FileSizeE := IdHTTP1.Response.ContentLength;
  except
  ProgressBar1.Min:=0;
ProgressBar1.Position:=0;
Showmessage('网络出错无法升级!');
MyStream.Free;
Exit;

  end;
  IdHTTP1.Disconnect;
      AssignFile(FF,ExtractFilePath(Application.ExeName)+'xxzh.dat');
      Reset(FF);
      Size:=FileSize(FF);//   字节为单位；
       CloseFile(FF);
     if (FileSizeE= Size) or (FileSizeE< Size) then
     begin
     showmessage('你现在的版本是最新版本,不要升级');
     end
     else

     begin
     MyStream :=   TFileStream.Create(ExtractFilePath(Application.ExeName)+'xxzh.dat' , fmCreate);
      try
IdHTTP1.Get(jj,MyStream);//下载我站点的一个ZIP文件

ProgressBar1.Visible :=true;
Label2.Visible :=true;
IdAntiFreeze1.OnlyWhenIdle:=False;//设置使程序有反应.
except//INDY控件一般要使用这种try..except结构.
ProgressBar1.Min:=0;
ProgressBar1.Position:=0;
Showmessage('网络出错!');
MyStream.Free;
ProgressBar1.Visible :=false;
Label2.Visible :=false;
Exit;
end;
ProgressBar1.Visible :=false;
Label2.Visible :=false;
MyStream.Free;
Showmessage('下载完毕');
     end;
end;
 end;


procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
showmessage('技術支持开心软件园');
ShellExecute(handle,   ''   ,   pChar('http://www.hpdown.cn'),   '','',   SW_SHOWNORMAL);
end;




end.
