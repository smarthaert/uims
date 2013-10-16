unit DownloadForm_U;

interface

uses
  {$IFDEF VER140}Variants,{$ENDIF} Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IEDownload, ComCtrls, urlmon;

type
  TDownloadForm = class(TForm)
    Button1: TButton;
    IEDownload1: TIEDownload;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
      ulStatusCode: Cardinal; szStatusText: PWideChar; ElapsedTime, Speed,
      EstimatedTime: string);
    procedure IEDownload1Complete(Sender: TBSCB; Stream: TStream;
      Result: HRESULT);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Download(Url: string);
  end;




implementation

{$R *.dfm}


uses registry;

procedure TDownloadForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDownloadForm.Button1Click(Sender: TObject);
begin
  IEDownload1.Cancel;
  close;
end;

function FileNameFromUrl(Url: string): string;
var
  i: Integer;
begin
  i := Length(Url);
  repeat
    Result := Url[i] + Result;
    Dec(i);
  until (url[i] = '/') or (i = 0);
end;

function GetDownloadDirectory: string;
var
  Reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Internet Explorer', True) then
      result := Reg.Readstring('Download Directory');
  finally
    reg.free;
  end;
end;

procedure TDownloadForm.Download(Url: string);
var
  FName: string;
begin
  FName := GetDownloadDirectory + FilenameFromUrl(url);
If Length(Url)>70 then Label1.Caption:=Copy(Url,1,70)+'...' else
  Label1.Caption := 'Url: ' + Url;
  Label2.Caption := 'Filename: ' + FName;
  Iedownload1.Go(url, FName);
end;

procedure TDownloadForm.IEDownload1Progress(Sender: TBSCB; ulProgress,
  ulProgressMax, ulStatusCode: Cardinal; szStatusText: PWideChar;
  ElapsedTime, Speed, EstimatedTime: string);

var
  s: string;
begin
  Progressbar1.Position := ulProgress;
  Progressbar1.Max := ulProgressMax;
  s := BindstatusText(ulStatusCode);
  if ulStatusCode = BINDSTATUS_DOWNLOADINGDATA then
    s := S + ' (' + InttoStr(ulProgress) + '/' + InttoStr(ulProgressMax) + ')';
  memo1.lines.add(s);
  Label3.Caption := 'Estimated time: ' + EstimatedTime;
end;


procedure TDownloadForm.IEDownload1Complete(Sender: TBSCB; Stream: TStream;
  Result: HRESULT);
begin
  if (Result = S_OK) then memo1.lines.add('Download complete...') else
    memo1.lines.add(Errortext(Result) + ' ' + ResponseCodeText(Sender.ResponseCode));
end;

end.

