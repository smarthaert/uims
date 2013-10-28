unit Unit5;
////打印界面
interface
//download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm5 = class(TForm)
    Label2: TLabel;
    Button2: TButton;
    Button1: TButton;
    Label4: TLabel;
    ComboBox1: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit1,unit4,unit7;

{$R *.dfm}

procedure TForm5.Button2Click(Sender: TObject);
begin
   unit7.printPort:=trim(combobox1.Text);
   try
   unit7.saveParams;
   except on e:exception do
   begin
     showmessage('保存参数到params.cfg文件失败!修改失败!'+e.Message);
     exit;
   end;
   end;
   //这个有点特殊,它不需要清空内容
   //combobox1.text:='';
   showMessage('设置完成');
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  //edit1.Clear;
  //edit2.Clear;
  //combobox1.text:='';
  form5.Visible:=false;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  combobox1.Text:=unit7.printPort;
end;

procedure TForm5.FormHide(Sender: TObject);
begin
   Button1Click(Sender);
end;

end.
