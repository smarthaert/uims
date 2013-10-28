unit Unit6;
////微调打印位置界面
///值得注意的是:edit1和edit2中显示是永远是当前的调整值.
//所以确定修改 和关闭界面时什么都不做,二恢复默认设置时edit为0,显示窗体时edit从unit7读取数据.
interface
//download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unit7,unit1;

type
  TForm6 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Button2: TButton;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Button3: TButton;
    ComboBox1: TComboBox;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.Button2Click(Sender: TObject);
var
  temp:double;
  temp2:double;
begin
   try
   ///unit7.firstLineDownVersusStandard:=unit7.firstLineDownVersusStandard+strtofloat(trim(edit1.Text));
   unit7.firstLineDownVersusStandard:=strtofloat(trim(edit1.Text));
   unit7.pageNum:=strtoint(combobox1.Text);
   unit7.everyPageAddVersusStandard:=strtofloat(trim(edit2.Text));
   except on e:exception do
   begin
     showmessage('修改失败,请输入正确的数字格式'+e.Message);
     exit;
   end;
   end;

   temp:=strtofloat(trim(edit1.Text));
   temp2:=unit1.firstLineStandardDown/180*25.4;
   if((temp<0) and (abs(temp)>temp2)) then
   begin
      showmessage('修改失败,打印第一页第1行之前, 打印机走纸长度相对默认走纸长度,最多只能减少约'+ floattostr(temp2)+'毫米');
      exit;
   end;

   try
   unit7.saveParams;
   except on e:exception do
   begin
     showmessage('保存参数到params.cfg文件失败!修改失败!'+e.Message);
     exit;
   end;
   end;
   showMessage('修改完成');
   //这里有点特殊,为了防止xx错误,用0代替清空.
   //edit1.Text:='0';
   //edit2.Text:='0';
   //edit1.Clear;
   //edit2.Clear;
   //form6.Visible:=false;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  unit7.firstLineDownVersusStandard:=0;
  unit7.everyPageAddVersusStandard:=0;
  try
   unit7.saveParams;
   except
   begin
     showmessage('保存参数到params.cfg文件失败!修改失败!');
     exit;
   end;
   end;

  showMessage('恢复默认设置完成');
  edit1.Text:='0';
  edit2.Text:='0';
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
 //  edit1.text:='0';
  //edit2.Text:='0';
  form6.Visible:=false;
end;

procedure TForm6.FormHide(Sender: TObject);
begin
   Button3Click(Sender);
end;

procedure TForm6.FormShow(Sender: TObject);
begin
   edit1.Text:=floattostr(unit7.firstLineDownVersusStandard);
   edit2.Text:=floattostr(unit7.everyPageAddVersusStandard);
   combobox1.Text:=inttostr(unit7.pageNum);
end;

end.
