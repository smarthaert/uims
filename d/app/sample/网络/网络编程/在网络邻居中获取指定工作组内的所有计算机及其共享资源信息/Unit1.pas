unit Unit1;
{Download by http://www.codefans.net}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    StaticText1: TStaticText;
    Panel1: TPanel;
    ListBox1: TListBox;
    StaticText2: TStaticText;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

Function GetUsers(GroupName:string;var List:TStringList):Boolean;
Function GetUserResource( UserName : string ; var List : TStringList ) : Boolean;

implementation
{$R *.DFM}
type
  TNetResourceArray = ^TNetResource;  //网络资源类型的数组

Function GetUsers(GroupName:string;var List:TStringList):Boolean;
Var
  NetResource:TNetResource;
  Buf : Pointer;
  Count,BufSize,Res : DWord;
  Ind : Integer;
  lphEnum : THandle;
  Temp:TNetResourceArray;
Begin
  Result := False;
  List.Clear;
  FillChar(NetResource, SizeOf(NetResource), 0);  //初始化网络层次信息
  NetResource.lpRemoteName := @GroupName[1];      //指定工作组名称
  NetResource.dwDisplayType := RESOURCEDISPLAYTYPE_SERVER;//类型为服务器（工作组）
  NetResource.dwUsage := RESOURCEUSAGE_CONTAINER;
  NetResource.dwScope := RESOURCETYPE_DISK;      //列举文件资源信息
  Res := WNetOpenEnum( RESOURCE_GLOBALNET, RESOURCETYPE_DISK,RESOURCEUSAGE_CONTAINER, @NetResource,lphEnum);
If Res <> NO_ERROR Then Exit; //执行失败
 While True Do          //列举指定工作组的网络资源
  Begin
   Count := $FFFFFFFF; //不限资源数目
   BufSize := 8192;    //缓冲区大小设置为8K
   GetMem(Buf, BufSize);//申请内存，用于获取工作组信息,获取计算机名称
   Res := WNetEnumResource(lphEnum, Count, Pointer(Buf), BufSize);
  If Res = ERROR_NO_MORE_ITEMS Then break;//资源列举完毕
  If (Res <> NO_ERROR) then Exit;//执行失败
    Temp := TNetResourceArray(Buf);
   For Ind := 0 to Count - 1 do//列举工作组的计算机名称
     Begin
       List.Add(Temp^.lpRemoteName);
       Inc(Temp);
     End;
 End;
 Res := WNetCloseEnum(lphEnum);//关闭一次列举
If Res <> NO_ERROR Then exit;//执行失败
  Result:=True;
  FreeMem(Buf);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  List:TstringList;
  i:integer;
begin
try
  List:=TstringList.Create;
  if GetUsers(edit1.text,List) then
    if List.count=0 then        //工作组下没找到计算机
      begin
        listbox1.Items.Add (edit1.text+'工作组下没有计算机！');
      end
   else
     listbox1.Items.Add (edit1.text+'下的所有计算机如下：');
     for i:=0 to List.Count-1  do
      begin
        listbox1.Items.Add (List.strings[i]);
      end;
finally
   List:=TstringList.Create;     //如有异常则释放分配的资源
end;
end;

Function GetUserResource( UserName : string ; var List : TStringList ) : Boolean;
Var
  NetResource : TNetResource;
  Buf : Pointer;
  Count,BufSize,Res : DWord;
  Ind : Integer;
  lphEnum : THandle;
  Temp : TNetResourceArray;
Begin
  Result := False;
  List.Clear;
  FillChar(NetResource, SizeOf(NetResource), 0);  //初始化网络层次信息
  NetResource.lpRemoteName := @UserName[1];       //指定计算机名称
  Res := WNetOpenEnum( RESOURCE_GLOBALNET, RESOURCETYPE_ANY,RESOURCEUSAGE_CONNECTABLE, @NetResource,lphEnum);
   //获取指定计算机的网络资源句柄
 If Res <> NO_ERROR Then exit;                   //执行失败
  While True Do                                  //列举指定工作组的网络资源
   Begin
    Count := $FFFFFFFF;                            //不限资源数目
    BufSize := 8192;                              //缓冲区大小设置为8K
    GetMem(Buf, BufSize);                   //申请内存，用于获取工作组信息
    Res := WNetEnumResource(lphEnum, Count, Pointer(Buf), BufSize);
                              //获取指定计算机的网络资源名称
  If Res = ERROR_NO_MORE_ITEMS Then break;//资源列举完毕
   If (Res <> NO_ERROR) then Exit;        //执行失败
     Temp := TNetResourceArray(Buf);
    For Ind := 0 to Count - 1 do
     Begin
     List.Add(Temp^.lpRemoteName);
     Inc(Temp);
    End;
 End;
 Res := WNetCloseEnum(lphEnum);          //关闭一次列举
 If Res <> NO_ERROR Then exit;           //执行失败
   Result := True;
   FreeMem(Buf);
End;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  List:TstringList;
  i:integer;
  user:string;
begin
  user:=Listbox1.Items[listbox1.ItemIndex];
try
  List:=TstringList.Create;
  if GetUserResource(user,List) then
    if List.count=0 then         //指定计算机下没有找到共享资源
      begin
        memo1.Lines.Add (user+'下没有找到共享资源！');
      end
   else
     memo1.Lines.Add (user+'下的所有共享资源如下：');
     for i:=0 to List.Count-1  do
      begin
        Memo1.lines.Add (List.strings[i]);
      end;
finally
   List:=TstringList.Create;     //如有异常则释放分配的资源
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   listbox1.Items.Clear ;
   memo1.Lines.Clear;
end;

end.


