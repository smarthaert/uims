unit client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ScktComp, ExtCtrls;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button2: TButton;
    Button7: TButton;
    Button1: TButton;
    Button3: TButton;
    Panel2: TPanel;
    Edit4: TEdit;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button6: TButton;
    Button5: TButton;
    Button4: TButton;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ClientSocket1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Button6Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  password : string;
  usename : string;
  counter : integer;
implementation
  uses  unit2, Unit3;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
        clientsocket1.Address:=edit3.Text;
//        edit3.Clear;
        clientsocket1.Active:=true;
        button1.Enabled:=false;
        button3.Enabled:=true;
        button2.Enabled:=true;
        button7.Enabled:=true;

end;

procedure TForm1.ClientSocket1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  statusbar1.SimpleText:='正在连接... '+  clientsocket1.Address;
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  statusbar1.SimpleText:='连接到 '+ clientsocket1.Address;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if clientsocket1.Active then
  begin
        clientsocket1.Socket.SendText(usename+'*^&%#^)@');
        clientsocket1.Active:=false;
  end;
        statusbar1.SimpleText:='断开连接';
        edit1.Enabled:=true;
        edit2.Enabled:=true;
        button1.Enabled:=true;
        button6.Enabled:=true;
        memo1.Clear;
        listbox1.Clear;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
      if key=#13 then
      if button6.Enabled then
      button6.Click;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
   chatname : string;
   i : integer;
begin
  if edit4.Text='' then
  begin
    showmessage('发送消息不能为空！');
    exit;
  end;

   if  radiobutton2.Checked=true then
        begin
            for i:=0 to listbox1.items.count   do
                 begin
                      if listbox1.selected[i] then
                         begin
                         chatname:= listbox1.items.strings[i];
                         memo1.lines.add('你对'+chatname+'悄悄说：'+edit4.Text);
                         //edit4.Clear;
                         break;
                         end
                  end;
             clientsocket1.Socket.SendText(edit4.Text+'&&'+chatname+'$$'+usename+'%&%&%&');
             edit4.Clear;
         end
 else
    begin
       clientsocket1.Socket.SendText(edit1.Text+'对大家说：'+edit4.Text);
       edit4.Clear;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if edit1.Text=''  then
 begin
   showmessage('请输入用户名！');
   edit1.SetFocus;
   exit;
 end;
 if edit2.Text=''  then
 begin
   showmessage('请输入密码！');
   edit2.SetFocus;
   exit;
 end;
  clientsocket1.Socket.SendText(edit1.Text+'$%$%$%');
  usename:=edit1.Text;
  password:=edit2.Text;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var
    temptext : string;
    //chatname: string;
    mssge : string;
begin
   temptext:=clientsocket1.Socket.ReceiveText;
   if  pos('@#$%^&',temptext)<>0 then   //回送密码
       begin
          temptext:=copy(temptext,1,length(temptext)-6);
            if temptext=password then
            begin
             Memo1.Lines.Add('登陆成功，欢迎进入本聊天室！');
             listbox1.Items.Add(usename);
             button6.Enabled:=true;
             button2.Enabled:=false;
             edit1.Enabled:=false;
             edit2.Enabled:=false;
             button7.Enabled:=true;
            end else
            begin
              showmessage('密码错误，登陆失败，请检查后重新登陆！');
              clientsocket1.Socket.SendText(usename+'*^&%#^)@');
            end
         end
  else if pos('~{}()&*%^',temptext)<>0 then // 他人登陆信息
        begin
          temptext:=copy(temptext,1,length(temptext)-9);
          if temptext<>edit1.Text then
          begin
            memo1.Lines.Add(temptext+' 进入聊天室...');
            listbox1.Items.add(temptext);
          end;
        end         
  else if  pos('^$%#^$',temptext)<>0 then    //off line
       begin
       
          temptext:=copy(temptext,1,length(temptext)-6);
          memo1.Lines.Add(temptext+' 离开聊天室...');
//          showmessage(inttostr(listbox1.Items.IndexOf(temptext)));
          if listbox1.Items.IndexOf(temptext)<>-1 then
          listbox1.Items.Delete(listbox1.Items.IndexOf(temptext));
       end
  else if  pos('#$%^&*{}',temptext)<>0 then
       begin
          mssge:=copy(temptext,1,length(temptext)-8);
          memo1.Lines.Add(mssge);
       end
  else
    memo1.Lines.Add(temptext);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
      form2.ShowModal;
end;


procedure TForm1.Button5Click(Sender: TObject);
begin
  memo1.Clear;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if clientsocket1.Active then
  begin
        clientsocket1.Socket.SendText(usename+'*^&%#^)@');
        clientsocket1.Active:=false;
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Form3.ShowModal;
end;

end.
