{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}

unit asSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfmAsSet = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtFromName: TEdit;
    edtFromAddress: TEdit;
    btnSet: TBitBtn;
    btnCanel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnCanelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAsSet: TfmAsSet;

implementation

uses main, AsNote;

{$R *.dfm}

procedure TfmAsSet.FormCreate(Sender: TObject);
begin
if fmAsN.lvAddress.Selected<>nil then
begin

     edtFromName.Text:=fmAsN.lvAddress.Selected.Caption;
     edtFromAddress.Text:=fmAsN.lvAddress.Selected.SubItems.Text;
end;
end;

procedure TfmAsSet.btnSetClick(Sender: TObject);
begin
       with fmAsN.adoqAsN do
       begin
                close;
                sql.Clear;
                sql.Add('select * from AddressNote where FromAddress=:FromAddress');
                Parameters.ParamByName('FromAddress').Value:=edtFromAddress.Text;
                open;
       end;

       if fmAsN.adoqAsN.RecordCount=1 then
       begin
                if  edtFromAddress.Text<>fmAsN.lvAddress.Selected.SubItems.Text then
                begin
                        showmessage('地址重名！');
                        fmAsN.adoqAsN.Close;
                        exit;
                end



                else
                begin
                     with fmAsN.adoqAsN do
                     begin
                                close;
                                sql.Clear;
                                SQL.Text:='select * from AddressNote where FromAddress='''+trim(fmAsN.lvAddress.Selected.SubItems.Text)+'''';
                                Open; //这里我本来是也是用sql的update语句的，但总提示说操作符丢失
                                Edit;
                                FieldByName('FromName').AsString:=edtFromName.Text;
                                FieldByName('FromAddress').AsString:=edtFromAddress.Text;
                                Post;
                                Close;
                     end;

                     {fmAsN.lvAddress.Selected.Caption:=edtFromName.Text;
                     fmAsN.lvAddress.Selected.SubItems.Text:=edtFromAddress.Text;
                     fmAsN.lvAddress.Update;}
                     fmAsN.lvAddress.Clear;
                     fmAsN.UpdatelvAddress(Sender);

                     fmAsN.labFromName.Caption:=fmAsN.lvAddress.Selected.Caption;
                     fmAsN.labFormAddress.Caption:=fmAsN.lvAddress.Selected.SubItems.Strings[0];
                     fmAsSet.Close;

                end;

       end;
       with fmAsN.adoqAsN do
       begin
                close;
                sql.Clear;
                SQL.Text:='select * from AddressNote where FromAddress='''+fmAsN.lvAddress.Selected.SubItems.Text+'''';
                Open; //这里我本来是也是用sql的update语句的，但总提示说操作符丢失
                Edit;
                FieldByName('FromName').AsString:=edtFromName.Text;
                FieldByName('FromAddress').AsString:=edtFromAddress.Text;
                Post;
                Close;
        end;

        {fmAsN.lvAddress.Selected.Caption:=edtFromName.Text;
        fmAsN.lvAddress.Selected.SubItems.Text:=edtFromAddress.Text;
        fmAsN.lvAddress.Update;}

        fmAsN.lvAddress.Clear;
        fmAsN.UpdatelvAddress(Sender);

        fmAsN.labFromName.Caption:=fmAsN.lvAddress.Selected.Caption;
        fmAsN.labFormAddress.Caption:=fmAsN.lvAddress.Selected.SubItems.Strings[0];
        fmAsSet.Close;

end;

procedure TfmAsSet.btnCanelClick(Sender: TObject);
begin
        close;
end;

end.
