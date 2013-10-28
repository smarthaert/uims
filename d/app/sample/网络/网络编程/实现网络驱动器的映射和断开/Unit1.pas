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
    Edit2: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Button2: TButton;
    Panel1: TPanel;
    Edit3: TEdit;
    Edit4: TEdit;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender : TObject);
var
 NetSource : TNetResource;
begin
 with NetSource do
 begin
  dwType := RESOURCETYPE_DISK;
  lpLocalName :=Pchar(edit2.text);
  // 将远程资源映射到此驱动器
  lpRemoteName :=pchar(edit1.text);
  // 远程网络资源
  lpProvider := '';
  // 必须赋值,如为空则使用lpRemoteName的值。
 end;
if WnetAddConnection2(NetSource, pchar(edit4.text), pchar(edit3.text), CONNECT_UPDATE_PROFILE)=NO_ERROR
 //用户名为Guest，口令为Password,下次登录时重新连接,此时在Windows资源管理器中可看到网络驱动器：
 then     //映射成功
    showmessage(edit1.text+'成功映射成'+edit2.text)
  else
    showmessage('映射失败！');
 end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if MessageDlg('确实要断开么?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//不管是否有文件打开，断开网络驱动器：
 if WNetCancelConnection2(pchar(edit2.text), CONNECT_UPDATE_PROFILE, True)=NO_ERROR then
    //映射断开成功
    showmessage(edit1.text+'映射断开！')
  else
    showmessage('断开映射失败');
end;

end.
