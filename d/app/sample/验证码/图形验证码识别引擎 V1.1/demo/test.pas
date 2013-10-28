unit test;

interface

uses
  Classes, SysUtils, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TOCRTest = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

uses
  demo;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TOCRTest.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TOCRTest }

procedure TOCRTest.Execute;
var
  Code : PChar;
  TimeUsed,i : Integer;
  Resp : TMemoryStream;
  FileName,CodeUrl : String;
  h : THandle;
  HTTP : TidHttp;
  ANTI : TidAntiFreeze;
  //
  IP,PORT,USR,PWD : String;
  UseProxy,NeedAcct : boolean;
begin
  with frmMain do begin
  if not bCanOCR then exit;
  btnStartTest.Enabled := FALSE;
  btnStopTest.Enabled := TRUE;
  CodeUrl := Cbb.Text;
  //
  UseProxy := chkProxyEnable.Checked;
  IP := Trim(edtProxyServer.Text);
  PORT := Trim(edtProxyPort.Text);
  NeedAcct := chkNeedAcct.Checked;
  USR := Trim(edtProxyUserName.Text);
  PWD := Trim(edtProxyPassWord.Text);
  //
  CreateEngine(h);
  for i:=0 to 19 do
  begin
    if Terminated then exit;
    pb.Position := i;
    HTTP := TidHttp.Create(nil);
    ANTI := TidAntiFreeze.Create(HTTP);
    HTTP.ReadTimeout := 5000;
    with HTTP.ProxyParams do
    begin
      if UseProxy then
      begin
        ProxyServer := IP;
        ProxyPort := StrToInt(PORT);
        if NeedAcct then
        begin
          BasicAuthentication := True;
          ProxyUsername := USR;
          ProxyPassword := PWD;
        end;
      end;
    end;
    Resp := TMemoryStream.Create;
    Try
      HTTP.Get(cbb.Text,Resp);
      FileName := AppPath+CodeImgFolder+'Img'+IntToStr(i);
      Resp.SaveToFile(FileName);
      Resp.Free;
      if OCRForumCodeImg(h,-1,PChar(CodeUrl),PChar(FileName),Code,TimeUsed) then
      begin
        Imgs[i].Picture.LoadFromFile(FileName+'.BMP');
        Imgs[i].Hint := Format('Ê¶±ðºÄÊ± : %d ms',[TimeUsed]);
        RecogCodes[i].Text := StrPas(Code);
      end;
    Except
    end;
    ANTI.Free;
    HTTP.Free;
  end;
  FreeEngine(h);
  btnStartTest.Enabled := TRUE;
  btnStopTest.Enabled := FALSE;
  end;
end;

end.


