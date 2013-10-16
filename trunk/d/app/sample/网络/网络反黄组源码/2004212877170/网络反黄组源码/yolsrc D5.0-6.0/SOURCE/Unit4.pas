unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TFlatButtonUnit, StdCtrls, TFlatEditUnit, ExtCtrls, TFlatTabControlUnit,registry;

type
  TForm4 = class(TForm)
    FlatTabControl1: TFlatTabControl;
    Notebook1: TNotebook;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edit1: TFlatEdit;
    edit2: TFlatEdit;
    edit3: TFlatEdit;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    redit1: TFlatEdit;
    redit2: TFlatEdit;
    redit3: TFlatEdit;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    procedure FlatTabControl1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure redit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure redit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure redit3KeyPress(Sender: TObject; var Key: Char);
    procedure FlatButton2Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
 pw1,pw2,pw3:string;

implementation
  uses unit2,Unit1,unit3,des;
{$R *.DFM}

procedure TForm4.FlatTabControl1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 notebook1.activepage:=inttostr(FlatTabControl1.ActiveTab);
end;

procedure TForm4.FormActivate(Sender: TObject);
begin
   redit1.Text:='';
   redit2.Text:='';
   redit3.Text:='';
 with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   edit1.Text:=copy(readstring('AK'),1,6);
   edit2.text:=copy(readstring('AK'),7,6);
   edit3.text:=copy(readstring('AK'),13,6);
   finally
   free;
   end;

end;

procedure TForm4.FlatButton1Click(Sender: TObject);
begin
  FlatTabControl1.ActiveTab:=1;
 notebook1.ActivePage:='1';
end;

procedure TForm4.FlatButton3Click(Sender: TObject);
begin
  redit3.text:=UpperCase(redit3.text);
  try
   if (redit1.Text=copy(encrystrhex(copy(decryStrHex(edit1.Text+edit2.Text+copy(edit3.Text,1,4),'i'),1,3),'i'),1,4)) and (redit2.Text=copy(encrystrhex(copy(decryStrHex(edit1.Text+edit2.Text+copy(edit3.Text,1,4),'i'),4,3),'love'),1,4))
    and (redit3.Text=copy(encrystrhex(copy(decryStrHex(edit1.Text+edit2.Text+copy(edit3.Text,1,4),'i'),7,2),'you'),1,4)) then
    begin
    showmessage('网络反黄组注册成功!');
    form1.Caption:='网络反黄组V1.3设置----------星火雨软件工作室(已注册)';
      with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   writestring('m4',redit1.text+redit2.Text+redit3.Text)
   finally
   free
   end;
    redit1.Enabled:=false;
    redit2.Enabled:=false;
    redit3.Enabled:=false;
    form4.Close;
    about.Close;
    form1.BlindGuardian1.Registered:=true;
    end
    else
     showmessage('注册失败原因!'+#13#10+#13#10+'1.是否输入有误？'+#13#10+'2.是否从销售商处得到有效的注册码？');
   //copy(EncryStrHex(copy(inttostr(SerialNum^),1,3),'i'),1,6);
   except
   showmessage('软件出错了！请不要无故修改本程序的设置！');
   end;
end;

procedure TForm4.redit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if length(redit1.text)>=4 then
  begin
   redit1.text:=UpperCase(redit1.text);
   redit2.SetFocus;
  end;
end;

procedure TForm4.redit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if length(redit2.text)>=4 then
  begin
   redit2.text:=UpperCase(redit2.text);
   redit3.SetFocus;
  end;
end;

procedure TForm4.redit3KeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) or (length(redit3.Text)>=4) then
  begin
   redit3.text:=UpperCase(redit3.text);
   FlatButton3.Click;
   end;
end;

procedure TForm4.FlatButton2Click(Sender: TObject);
begin
  close;
end;

procedure TForm4.FlatButton4Click(Sender: TObject);
begin
   redit1.Text:='';
   redit2.Text:='';
   redit3.Text:='';
   close;
end;

end.
