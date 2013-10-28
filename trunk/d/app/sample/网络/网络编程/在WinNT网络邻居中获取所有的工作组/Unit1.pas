//API WnetOpenEnum()和WnetEnumResource的使用
unit Unit1;
{Download by http://www.codefans.net}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TNetResourceArray = ^TNetResource;  //网络资源类型的数组
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}
{ Start here }

procedure GetDomainList(TV:TTreeView);
var
   i:Integer;
   ErrCode:Integer;
   NetRes:Array[0..1023] of TNetResource;
   EnumHandle:THandle;
   EnumEntries:DWord;
   BufferSize:DWord;
begin
 try
  With NetRes[0] do
  begin
   dwScope :=RESOURCE_GLOBALNET;
   dwType :=RESOURCETYPE_ANY;
   dwDisplayType :=RESOURCEDISPLAYTYPE_DOMAIN;
   dwUsage :=RESOURCEUSAGE_CONTAINER;
   lpLocalName :=NIL;
   lpRemoteName :=NIL;
   lpComment :=NIL;
   lpProvider :=NIL;
   end;
//get net root
   ErrCode:=
    WNetOpenEnum(
     RESOURCE_GLOBALNET,
     RESOURCETYPE_ANY,
     RESOURCEUSAGE_CONTAINER,
     @NetRes[0],
     EnumHandle
      );
If ErrCode=NO_ERROR then
  begin
    EnumEntries:=1;
    BufferSize:=SizeOf(NetRes);
    ErrCode:=WNetEnumResource(
      EnumHandle,
      EnumEntries,
      @NetRes[0],
      BufferSize
       );
   WNetCloseEnum(EnumHandle);
If ErrCode=NO_ERROR then
 begin
    ErrCode:=WNetOpenEnum(
      RESOURCE_GLOBALNET,
      RESOURCETYPE_ANY,
      RESOURCEUSAGE_CONTAINER,
      @NetRes[0],
      EnumHandle
       );
    EnumEntries:=1024;
    BufferSize:=SizeOf(NetRes);
    ErrCode:=WNetEnumResource(
     EnumHandle,
     EnumEntries,
     @NetRes[0],
     BufferSize
      );

IF ErrCode=No_Error then
 for i:=0 to 1024 do
  begin
    if(NetRes[i].lpProvider=nil) then
     begin
      showmessage('网络上共有'+inttostr(i)+'个对象。');
      break;
     end
    else
    with TV do
     begin
      Items.BeginUpdate;
      Items.Add(TV.Selected,'第'+inttostr(i+1)+'个对象');
      Items.Add(TV.Selected,'服务提供商：'+string(NetRes[i].lpProvider));
      Items.Add(TV.Selected,'本机名：'+string(NetRes[i].lpLocalName));
      Items.Add(TV.Selected,'远程机名或工作组名：'+string(NetRes[i].lpRemoteName));
      Items.Add(TV.Selected,'评注：'+string(NetRes[i].lpComment));
      Items.Add(TV.Selected,'-------');
      Items.EndUpdate;      
     end;
  end;
 end;
 end;
 except
   showmessage('网络邻居上没有工作组或主机');
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 TreeView1.Items.BeginUpdate;
 TreeView1.Items.Clear;
 TreeView1.Items.EndUpdate;
 GetDomainList(TreeView1);
end;

//函数GetServerList列举出整个网络中的工作组名称，返回值为TRUE表示执行成功，
//参数List中返回服务器（工作组）的名称
Function GetServerList( var List : TStringList ) : Boolean;
Var
NetResource : TNetResource;
Buf : Pointer;
Count,BufSize,Res : DWORD;
lphEnum : THandle;
p:TNetResourceArray;
i,j : SmallInt;
NetworkTypeList : TList;
Begin
Result := False;
NetworkTypeList := TList.Create;
List.Clear;
Res := WNetOpenEnum( RESOURCE_GLOBALNET, RESOURCETYPE_DISK,
RESOURCEUSAGE_CONTAINER, Nil,lphEnum);
//获取整个网络中的文件资源的句柄，lphEnum为返回名柄
If Res <> NO_ERROR Then exit;
//执行失败，退出

//执行成功，开始获取整个网络中的网络类型信息
Count := $FFFFFFFF;
//不限资源数目
BufSize := 8192;
//缓冲区大小设置为8K
GetMem(Buf, BufSize);
//申请内存，用于获取工作组信息
Res := WNetEnumResource(lphEnum, Count, Pointer(Buf), BufSize);
If ( Res = ERROR_NO_MORE_ITEMS )
//资源列举完毕
or (Res <> NO_ERROR )
//执行失败
Then Exit;

P := TNetResourceArray(Buf);
For I := 0 To Count - 1 Do
//记录各个网络类型的信息
Begin
NetworkTypeList.Add(p);
Inc(P);
End;

//WNetCloseEnum关闭一个列举句柄
Res:= WNetCloseEnum(lphEnum);
//关闭一次列举
If Res <> NO_ERROR Then exit;
For J := 0 To NetworkTypeList.Count-1 Do
//列出各个网络类型中的所有工作组名称
Begin
//列出一个网络类型中的所有工作组名称
NetResource := TNetResource(NetworkTypeList.Items[J]^);
//网络类型信息
//获取某个网络类型的文件资源的句柄，NetResource为网络类型信息，lphEnum为返回名柄
Res := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_DISK,
RESOURCEUSAGE_CONTAINER, @NetResource,lphEnum);
If Res <> NO_ERROR Then break;
//执行失败
While true Do
//列举一个网络类型的所有工作组的信息
Begin
Count := $FFFFFFFF;
//不限资源数目
BufSize := 8192;
//缓冲区大小设置为8K
GetMem(Buf, BufSize);
//申请内存，用于获取工作组信息，获取一个网络类型的文件资源信息，
Res := WNetEnumResource(lphEnum, Count, Pointer(Buf), BufSize);
If ( Res = ERROR_NO_MORE_ITEMS )
//资源列举完毕
or (Res <> NO_ERROR)
//执行失败
then break;
P := TNetResourceArray(Buf);
For I := 0 To Count - 1 Do
//列举各个工作组的信息
Begin
List.Add( StrPAS( P^.lpRemoteName ));
//取得一个工作组的名称
Inc(P);
End;
End;
Res := WNetCloseEnum(lphEnum);
//关闭一次列举
If Res <> NO_ERROR Then break;
//执行失败
End;
Result := True;
FreeMem(Buf);
NetworkTypeList.Destroy;
End;


procedure TForm1.Button2Click(Sender: TObject);
var
 sl:TstringList;
 i:integer;
begin
 memo1.lines.Clear;
 sl:=Tstringlist.create;
if GetServerList(sl) then
 begin
  memo1.lines.Add('总共找到'+inttostr(sl.count)+'个工作组！');
 for i:=0 to sl.count-1 do
   memo1.lines.Add (sl.Strings[i]);
 end
 else
   memo1.lines.Add('没有找到工作组！');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   memo1.lines.Clear;
end;

end.

