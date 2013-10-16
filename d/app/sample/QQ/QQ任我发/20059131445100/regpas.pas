unit regpas;

interface

uses
  Windows, Messages, SysUtils,IniFiles, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tregform = class(TForm)
    lbl2: TLabel;
    edit2: TEdit;
    btn1: TButton;
    btn2: TButton;
    edit3: TEdit;
    edit5: TEdit;
    edit6: TEdit;
    bvl1: TBevel;
    mmo1: TMemo;
    lbl1: TLabel;
    procedure btn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  regform: Tregform;

implementation

uses umain;

{$R *.dfm}

procedure Tregform.btn2Click(Sender: TObject);
begin
CLOSE
end;

procedure Tregform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree
end;

procedure writereginf(s:string);
var ini:tinifile;
begin
  try
  ini:=tinifile.Create(mainSend.apppath+'config.ini');
  ini.WriteString('Reginfo','regcode',s);
  finally
  Ini.free;
  end
end;

procedure Tregform.btn1Click(Sender: TObject);
var s:string;
begin
s:=edit5.Text+edit3.Text+edit6.Text+edit2.Text;
writereginf(s);
if s='6CR98D0510NNVG4BR29A75M3' then     // 9A75M3-0510NN-6CR98D-VG4BR2
  begin
  mainsend.senreg:=True;
  lbl1.Caption:='注册成功!';
  mainSend.Caption:='QQ任我发--'+'已注册';
  close
  end else
  mainsend.senreg:=False;
end;

end.
