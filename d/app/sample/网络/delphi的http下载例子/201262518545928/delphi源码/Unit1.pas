unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPServer, IdCustomHTTPServer,
  IdHTTPServer, ComCtrls, IdTCPConnection, IdTCPClient, IdHTTP, WinSkinData,
  Gauges;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    lbl1: TLabel;
    edt2: TEdit;
    lbl2: TLabel;
    btn1: TButton;
    lbl3: TLabel;
    IdAntiFreeze1: TIdAntiFreeze;
    tmr1: TTimer;
    dlgSave1: TSaveDialog;
    idhtp1: TIdHTTP;
    skndt1: TSkinData;
    Gauge1: TGauge;

  
    procedure btn1Click(Sender: TObject);
    procedure idhtp1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure idhtp1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}





procedure TForm1.btn1Click(Sender: TObject);
var
  stream:TMemoryStream;
begin
    if dlgSave1.Execute then
    edt2.Text:=dlgSave1.filename;
    IdAntiFreeze1.OnlyWhenIdle:=False;
    stream:=TMemoryStream.Create;
    btn1.Enabled:=False;
    btn1.Caption:='正在下载';
    try
      idhtp1.get(edt1.Text,stream);
      stream.savetofile(edt2.Text);
      stream.Free;
      MessageBox(handle,'下载完毕！','提示',MB_ICONINFORMATION + MB_OK);
      except
      MessageBox(handle,'网络出错！','提示',MB_ICONERROR + MB_OK);
      btn1.Enabled:=True;
      btn1.caption:='开始下载';
      stream.Free;
      Exit;
end;


end;

procedure TForm1.idhtp1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
    Gauge1.MaxValue:=AWorkCountMax;
    Gauge1.MinValue:=0;
    Gauge1.Progress:=0
end;

procedure TForm1.idhtp1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
     Gauge1.Progress:=AWorkCount;
end;

end.
