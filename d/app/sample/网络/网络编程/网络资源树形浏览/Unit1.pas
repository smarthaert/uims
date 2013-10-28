unit Unit1;
{Download by http://www.codefans.net}
interface

uses

Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

StdCtrls, Buttons, ComCtrls, ImgList;

type

TForm1 = class(TForm)

Button1: TButton;

ResourcesTree: TTreeView;

pb1: TProgressBar;

function AddContainer(NetRes: TNetResource;temp_node:Ttreenode):ttreenode;

procedure AddShare(NetRes:TNetResource;node:ttreenode);

procedure EnumerationContainer(NetResContainer:Pnetresource;CurrentNode:TtreeNode);

procedure Button1Click(Sender: TObject);

private

{ Private declarations }

public

{ Public declarations }

end;

var

Form1: TForm1;

ResourceScope, ResourceType,ResourceUsage: DWORD;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);

begin

ResourcesTree.Items.Clear;

ResourceScope:=RESOURCE_GLOBALNET;

ResourceType:=RESOURCETYPE_ANY;

ResourceUsage:=0;

Screen.Cursor:=crHourGlass;

EnumerationContainer(nil,nil);

Screen.Cursor:=crdefault;

pb1.Position:=0;

end;

procedure TForm1.EnumerationContainer(NetResContainer:Pnetresource;CurrentNode:TtreeNode);

var NetRes: Array[0..10] of TNetResource;

r,hEnum,EntryCount,NetResLen: DWORD;

begin

if CurrentNode<>nil then 

CurrentNode:=AddContainer(NetResContainer^,CurrentNode)

else CurrentNode:=ResourcesTree.Items.Add(nil,'整个网络');

r:=WNetOpenEnum(ResourceScope,ResourceType,ResourceUsage,NetResContainer,hEnum);

if r<>NO_ERROR then begin

WNetCloseEnum(hEnum);

Exit;

end;

while true do begin

EntryCount:=1;

NetResLen:=SizeOf(NetRes);

r:=WNetEnumResource(hEnum,EntryCount,@NetRes,NetResLen);

case r of

0: begin

if (NetRes[0].dwUsage=RESOURCEUSAGE_CONTAINER) or (NetRes[0].dwUsage=10) then

EnumerationContainer (@NetRes[0],currentnode)

Else 

AddShare (NetRes[0],currentnode) ;

End ;

ERROR_NO_MORE_ITEMS: Break;

else begin

MessageDlg('Error #'+IntToStr(r)+' Walking Resources.',mtError,[mbOK],0);

Break;

end;

end;

end;

WNetCloseEnum(hEnum);

end;



function TForm1.AddContainer(NetRes:TNetResource;temp_node:Ttreenode):ttreenode;

var ItemName: String;

begin

ItemName:=Trim(String(NetRes.lpRemoteName));

//if Trim(String(NetRes.lpComment))<>'' then begin

// if ItemName<>'' then ItemName:=ItemName+' ';

// end;

case netres.dwDisplayType of

RESOURCEDISPLAYTYPE_DOMAIN:ItemName:='组:'+ItemName;

RESOURCEDISPLAYTYPE_GENERIC:ItemName:='Generic:'+ItemName;

RESOURCEDISPLAYTYPE_SERVER:ItemName:='主机:'+ItemName;

RESOURCEDISPLAYTYPE_SHARE:ItemName:='共享资源:'+ItemName;

else if ItemName='' then ItemName:=netRes.lpProvider;

end;

result:=ResourcesTree.Items.Addchild(temp_node,ItemName);

if pb1.Position>=100 then pb1.Position:=0

else pb1.Position:=pb1.Position+1;

Refresh;

end;

procedure TForm1.AddShare(NetRes:TNetResource;node:ttreenode);

var ItemName: String;

begin

ItemName:=Trim(String(NetRes.lpRemoteName));

if Trim(String(NetRes.lpComment))<>'' then begin

if ItemName<>'' then ItemName:=ItemName+' ';

ItemName:=ItemName;

end;

ResourcesTree.Items.AddChild(node,ItemName);

ResourcesTree.Refresh;

end;

end.


