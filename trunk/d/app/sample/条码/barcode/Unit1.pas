unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, strutils;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    cbx1: TComboBox;
    Edit2: TEdit;
    cbx2: TComboBox;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function GETFONTHEX(chnstr: string; fontname: string; orient: integer; height: integer; width: integer; bold: integer; italic: integer; hexbuf: string): integer; stdcall; external 'fnthex32.dll';
function PrtChnStr(x, y: integer; fontname: string; height, xmf, ymf: integer; chnstr: string): string;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function PrtChnStr(x, y: integer; fontname: string; height, xmf, ymf: integer; chnstr: string): string;
var
  buf, ret: string;
  count: integer;
begin
  result := '';
  setlength(buf, 21 * 1024);
  count := GETFONTHEX(chnstr, fontname, 0, height, 0, 1, 0, buf);
  if count > 0 then
  begin
    ret := Copy(buf, 1, count);
    result := ret + '^FO' + inttostr(x) + ',' + inttostr(y) + '^XGOUTSTR01,' + inttostr(xmf) + ',' + inttostr(ymf) + '^FS';
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  prtstr, code: string;
begin
  if cbx1.Text = 'Code 11' then
    code := '^B1'
  else if cbx1.Text = 'Code 39' then
    code := '^B3'
  else if cbx1.Text = 'Code 49' then
    code := '^B4'
  else if cbx1.Text = 'Code 93' then
    code := '^BA'
  else if cbx1.Text = 'Code 128' then
    code := '^BC'
  else if cbx1.Text = 'EAN-8' then
    code := '^B8';
  prtstr := '^XA^IA6^XZ^FS^XA^FS^BY3,3^LH20,23^FS';
  prtstr := prtstr + '^FO' + '30,25' + code + ',' + '70^FD' + trim(Edit1.Text) + '^FS';
  prtstr := prtstr + PrtChnStr(10, 140, pchar(cbx2.Text), 14, 1, 2, pchar(Leftstr(Edit2.Text, 18)));
  prtstr := prtstr + '^PQ1^FS'; //打印1份
  prtstr := prtstr + '^PRC^FS^XZ^FS^XA^EG^XZ'; //打印结束
  Memo1.lines.clear;
  Memo1.lines.Add(prtstr);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  prtstr: string;
  filehandle: integer;
begin
  prtstr := Memo1.Text;
  filehandle := fileopen('LPT1', fmOpenWrite);
  if filehandle > 0 then
    filewrite(filehandle, prtstr[1], length(prtstr))
  else
    showmessage('打开并口错误');
  fileclose(filehandle);
end;

end.

