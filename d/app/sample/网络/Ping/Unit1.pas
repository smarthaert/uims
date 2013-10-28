unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient, Mask, RzEdit, Menus, ExtCtrls;

type
  TIPvalues=array [0..3] of Byte;
  TForm1 = class(TForm)
    IdIcmp: TIdIcmpClient;
    label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Nedit1: TRzNumericEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    List1: TListBox;
    list2: TListBox;
    Button3: TButton;
    Label3: TLabel;
    Nedit2: TRzNumericEdit;
    Label4: TLabel;
    Label5: TLabel;
    PopupMenu2: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure Button1Click(Sender: TObject);
    function IsIPString(IPStr:string):Boolean;
    function iptoValues(ip:string):TIPvalues;
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IdIcmpReply(ASender: TComponent;
      const AReplyStatus: TReplyStatus);
    procedure Button3Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var stop:Boolean;
function   TForm1.IsIPString(IPStr:   string):   Boolean;
  var
      i,DotNum:integer;
      Tmpstr:string;
  begin
      Result:=true;
      DotNum:=0;
      for   i:=1   to   Length(IPStr)   do
          Case   IPStr[i]   of
              '0'..'9','.':
                  begin
                  if   IPStr[i]<>'.'   then
                      begin
                          Tmpstr:=Tmpstr+IPStr[i];
                          if   StrtoInt(tmpstr)>255     then
                          begin
                              Result:=False;
                              exit;
                          end;
                      end
                  else
                      begin
                          if   (TmpStr='')and(DotNum>0)   then     //如果连续2个点的情况
                          begin
                              Result:=False;
                              Exit;
                          end;
                          Tmpstr:='';
                          DotNum:=DotNum+1;
                      end;
                  end;
              else
                  begin   Result:=false;   exit;   end;
          end;
      if   DotNum<>3   then   Result:=False;
  end;


procedure TForm1.N3Click(Sender: TObject);
begin
List2.Items.Delete(List2.ItemIndex);
end;

procedure TForm1.N4Click(Sender: TObject);
begin
List2.Clear;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
List1.Items.Delete(List1.ItemIndex);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
List1.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
begin
Button2.Enabled:=false;
Button1.Enabled:=false;
N1.Enabled:=False;
N2.Enabled:=False;
N3.Enabled:=False;
N4.Enabled:=False;
stop:=False;
IdIcmp.ReceiveTimeout:=Trunc(Nedit2.Value);
for i := 0 to List1.Count - 1 do
begin
Application.ProcessMessages;
IdIcmp.Host:=List1.Items[i];
List1.ItemIndex:=i;
IdIcmp.Ping;
if stop then Break;

end;
Button2.Enabled:=true;
Button1.Enabled:=true;
N1.Enabled:=true;
N2.Enabled:=true;
N3.Enabled:=true;
N4.Enabled:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
stop:=true;
end;

procedure TForm1.IdIcmpReply(ASender: TComponent;
  const AReplyStatus: TReplyStatus);
begin
case AReplyStatus.ReplyStatusType of
  rsEcho: List2.Items.Add(AReplyStatus.FromIpAddress+'  成功  耗时(毫秒)：'+inttostr(areplystatus.MsRoundTripTime));
  rsError: List2.Items.Add(IdIcmp.Host+'  错误  ');
  rsTimeOut:List2.Items.Add(IdIcmp.Host+'  超时  ');
  rsErrorUnreachable:list2.Items.Add(IdIcmp.Host+'  地址错误  ');
else
  list2.Items.Add(IdIcmp.Host+'  其他未知错误  ');
end;
list2.ItemIndex:=list2.Count-1;
end;

function TForm1.iptoValues(ip:string):TIPvalues;
var tmp:string;
  i,x: Byte;
begin
x:=0;
tmp:='';
if IsIPString(ip) then
  begin
  for  i:= 1 to Length(ip) do
  begin
     if ip[i] in ['0'..'9'] then
       tmp:=tmp+ip[i];
     if ip[i]='.' then
     begin
     Result[x]:=StrToInt(tmp);
     tmp:='';
     x:=x+1;
     end;
  end;
  Result[x]:=StrToInt(tmp);
  end else raise Exception.Create('非法IP');
end;

procedure TForm1.Button1Click(Sender: TObject);
var ipvalue:TIPvalues;
  i:Integer;
  x:Byte;
begin
if IsIPString(Edit1.Text) then
  begin
   List1.Items.Add(Edit1.Text);
   if CheckBox1.Checked and (Nedit1.Value>0) then
     begin
       ipvalue:=iptoValues(Edit1.Text);
       if ipvalue[3]+nedit1.Value>255 then Nedit1.Value:=255-ipvalue[3];
         for I := ipvalue[3]+1 to ipvalue[3]+trunc(nedit1.Value) do
          List1.Items.Add(Format('%d.%d.%d.%d',[ipvalue[0],ipvalue[1],ipvalue[2],i]));
     end;
  end else Application.MessageBox('你输入的IP不合法。', '错误', MB_OK + MB_ICONSTOP);
end;

end.
