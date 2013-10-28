unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses
 frmMain,U_Web;

procedure TForm4.Button1Click(Sender: TObject);
begin
   if(wangjun=nil) then
   begin
       memo1.Lines.Add('先打开网页，再执行JS指令！');
   end else
   begin
     if self.CheckBox1.Checked then
     begin
     if wangjun1=nil then exit;

     wangjun1.execScript(self.Memo1.Lines.Text,'javascript');
     end else
     begin
     if wangjun=nil then exit;

     wangjun.execScript(self.Memo1.Lines.Text,'javascript');
     end;
   end;
end;

end.
