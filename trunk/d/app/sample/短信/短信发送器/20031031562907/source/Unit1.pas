unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, SUIForm, StdCtrls, SUIEdit, SUIListBox, ComCtrls, SUIMemo,
  SUIButton, SUISideChannel, TFlatSpeedButtonUnit, TFlatButtonUnit,SMSIOUnit,
  SUIProgressBar;

type
  TKc = record
     name:string;
     num:string;
  end;
  TDATAARR=array [0..200] of tkc;

  TForm1 = class(TForm)
    suiForm1: TsuiForm;
    ListBox1: TsuiListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Editname: TsuiEdit;
    Editpassword: TsuiEdit;
    Memo1: TsuiMemo;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiSideChannel1: TsuiSideChannel;
    ListBoxALL: TsuiListBox;
    ListBoxNOW: TsuiListBox;
    Label5: TLabel;
    Label6: TLabel;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    FlatButton3: TFlatButton;
    FlatSpeedButton1: TFlatSpeedButton;
    suiButton3: TsuiButton;
    suiButton4: TsuiButton;
    Label7: TLabel;
    Edit1: TsuiEdit;
    ProgressBar1: TsuiProgressBar;
    Labelnum: TLabel;
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton4Click(Sender: TObject);
    procedure readdata;
    procedure suiSideChannel1CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatSpeedButton1Click(Sender: TObject);
    procedure suiSideChannel1Push(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure readnow;
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  dataALL:tdataarr;
  datanow:tdataarr;
implementation

uses Unit2;

{$R *.DFM}

procedure TForm1.readdata;
var
  ss:tstringlist;
  i:integer;
  temp,str1,str2:string;
begin
 LISTBOXALL.Clear;
 for i:=0 to 200 do begin
   dataall[i].name :='';
   dataall[i].num :='';
 end;
 ss:=tstringlist.Create ;
 ss.LoadFromFile('info.ds');
 for i:=0 to ss.Count-1 do begin
   temp:=ss.strings[i];
   str1:=copy(temp,1,pos(':',temp)-1);
   str2:=copy(temp,pos(':',temp)+1,length(TEMP));
   DATAALL[I].name :=STR1;
   listboxall.Items.Append(str1);
   DATAALL[I].num :=STR2;
 end;
 ss.free;

end;

procedure TForm1.suiButton1Click(Sender: TObject);
var
 flag:boolean;
begin
  flag:=false;
  suiButton1.Enabled :=false;
 case  NetRegister(Editname.Text) of
   0:  flag:=true;
   1:   ShowMEssage('无法连接服务器');
   2:   ShowMEssage('手机错误');
   3:   ShowMEssage('注册失败');
 end;
 if flag then begin
   ShowMEssage('注册成功');
   suiButton2.Enabled :=true;
 end
 else suiButton1.Enabled :=true;
end;

procedure TForm1.suiButton3Click(Sender: TObject);
begin
  form2.show;
end;

procedure TForm1.suiButton4Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.suiSideChannel1CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
 readdata;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
listboxnow.Clear;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
listboxnow.Items.Text:=listboxall.items.text;
end;

procedure TForm1.FlatSpeedButton1Click(Sender: TObject);
begin
  listboxnow.Clear;
end;

procedure TForm1.suiSideChannel1Push(Sender: TObject);
begin
 listbox1.Items.Text :=listboxnow.Items.Text;
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
  if  listboxall.ItemIndex<>-1 then
   listboxnow.Items.append(listboxall.items.Strings[listboxall.ItemIndex]);
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
begin
  if  listboxnow.ItemIndex<>-1 then
    listboxnow.Items.Delete(listboxnow.itemindex);
end;

procedure TForm1.suiButton2Click(Sender: TObject);
var
 str:string;
 i:integer;
 number:integer;//删除的索引号
 flag:boolean;
 n:integer;
begin
  if listbox1.items.count=0 then
  begin
    showmessage('待发人员列表不能为空!');
    exit;
  end;
  suiButton1.Enabled :=true;
  ProgressBar1.Visible:=true;
  n:=100 div listbox1.items.count;
  readnow;
  number:=0;
  for i:=0 to listbox1.Items.Count-1 do begin
    flag:=false;
    case NetSendSMS(Editname.Text,Editpassword.Text,Edit1.Text,datanow[i].num,Memo1.Text) of
      0:   flag:=true;
      1:   ShowMEssage('无法连接服务器!');
      2:   ShowMEssage('手机错误!');
      3:   ShowMEssage('发送失败,可能是密码不对,也可能是短消息字符太多!');
      4:   ShowMEssage('其它错误!');
    end;
    if flag then begin
      listbox1.Items.Delete(number);
      ProgressBar1.Position :=ProgressBar1.Position +n;
    end;
  end;
  ProgressBar1.Visible:=false;
  suiButton2.Enabled :=false;
  if flag then begin
     showmessage('短消息已经成功发送，但有时会因为服务器的原因，短消息有可能不能及时送到对方手机上!');
  end;

end;

procedure TForm1.readnow;
var
  i,j:integer;
begin
  for i:=0 to 200 do begin
     datanow[i].name :='';
     datanow[i].num :='';
  end;
  for i:=0 to listbox1.Items.Count-1 do begin
     datanow[i].name :=listbox1.Items.Strings[i];
     for j:=0 to listboxall.Items.Count-1 do begin
         if datanow[i].name =dataall[j].name then begin
             datanow[i].num :=dataall[j].num ;
             break;
         end;
     end;
  end;

end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
labelnum.Caption :='已经输入'+inttostr(length(memo1.Text))+'个字符';
end;

end.
