unit Resumedemo_U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  urlmon, IEDownload, StdCtrls, wininet;

type
  TForm1 = class(TForm)
    Button1: TButton;
    memo1: TMemo;
    IEDownload1: TIEDownload;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
      ulStatusCode: Cardinal; szStatusText: PWideChar; ElapsedTime, Speed,
      EstimatedTime: string);
    procedure IEDownload1Complete(Sender: TBSCB; Stream: TStream;
      Result: HRESULT);
    function IEDownload1Response(Sender: TBSCB; dwResponseCode: Cardinal;
      szResponseHeaders, szRequestHeaders: PWideChar;
      out szAdditionalRequestHeaders: PWideChar): HRESULT;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin

  if Button1.Caption <> 'Pause' then
  begin
    IEDownload1.go('http://www.microsoft.com/com/resources/OVI386.EXE', 'OVI386.EXE');
    Button1.Caption := 'Pause';
  end else
  begin
    IEDownload1.Cancel;
    Button1.Caption := 'Resume';
  end;
end;

procedure TForm1.IEDownload1Progress(Sender: TBSCB; ulProgress,
  ulProgressMax, ulStatusCode: Cardinal; szStatusText: PWideChar;
  ElapsedTime, Speed, EstimatedTime: string);
var
  s: string;
begin
  s := BindstatusText(ulStatusCode);
  if ulStatusCode = BINDSTATUS_DOWNLOADINGDATA then
    s := S + ' (' + InttoStr(ulProgress) + '/' + InttoStr(ulProgressMax) + ')';
  memo1.lines.add(s);
  Label1.Caption := 'Estimated time left: '+ EstimatedTime;
end;

procedure TForm1.IEDownload1Complete(Sender: TBSCB; Stream: TStream;
  Result: HRESULT);
begin
  if (Result = S_OK) then
  begin
    memo1.lines.add('Download complete...');
    Button1.Caption := 'Start Download';
  end
  else
    if (Result = E_ABORT) and (Sender.ResponseCode = 206) then
      memo1.lines.add('Cancelled by user...')
    else
      if (Result = E_ABORT) and (Sender.ResponseCode = 416) then
        memo1.lines.add('File allready downloaded...') else
        memo1.lines.add(Errortext(Result) + ' ' + ResponseCodeText(Sender.ResponseCode));
end;

function TForm1.IEDownload1Response(Sender: TBSCB;
  dwResponseCode: Cardinal; szResponseHeaders, szRequestHeaders: PWideChar;
  out szAdditionalRequestHeaders: PWideChar): HRESULT;
begin
  if dwResponseCode = 206 then
    memo1.lines.add('Resume supported by server...') else
    memo1.lines.add('Resume not supported by server...');
  Result := S_OK;
end;

end.

