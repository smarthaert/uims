unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var strsql: string;
begin
strsql := 'Insert into msgComm(GateName, smid, smmobile, smcalled, smfee, smfeeno, smfmt, smmsgs, scheduletime, expiretime, mtflag, MsgId, reportflag, extdata, smflag)'+
          ' values(NULL, ''%s'', ''%s'', ''%s'', 1, ''%s'', 15, ''%s'', NULL, NULL, 0, NULL, 1, NULL, 0)';
   with adoQuery1 do
   begin
     close;
     sql.clear;
     sql.Add(Format(strsql, [edit3.text, edit2.text, edit4.text, edit1.text, memo1.lines.text]));
     execsql;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ADOConnection1.Open;
end;

end.
