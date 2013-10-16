{-----------------------------------------------------------------------------
 Unit Name: 保存/读取文件数据
 Author:    Luo Xin Xi
 Purpose:   SMS (Read/Write) Thread
 History:
 Date:      2004-08-18
-----------------------------------------------------------------------------}
unit SaveMessage;


interface
uses
  classes, SysUtils, Forms;
type
  TSaveMessage = class(TThread)
  private
    iList: TList;
    XML: string;
    LogPath: string;
  protected
    procedure Execute; override;
    procedure showmessage;
    procedure WriteSubmitFile; //保存下行短信
    procedure WriteReportFile; //保存状态报告
    procedure WriteResponseFile; //保存回馈报告
    procedure writeDeliverFile; //保存上行短信
    procedure WriteXMLStr(iXML, Filename: string); //写入文件
  public
    constructor create; virtual;
    destructor destroy; override;
  end;

  TReadMessage = class(TThread)
  private
    SMSList: TStringList;
    XML: string;
  protected
    procedure Execute; override;
    procedure showmessage;
    procedure ReadSubmitFile; //
    procedure ReadReportFile;
    procedure ReadResponseFile;
    procedure ReadDeliverFile;
  public
    constructor create; virtual;
    destructor destroy; override;
  end;
implementation
uses
  Smgp13_XML, U_main, U_MsgInfo, CT_SMS_Xml;
{ TSaveMessage }

constructor TSaveMessage.create;
begin
  inherited create(True);
  FreeOnTerminate := True;
  SMGPGateWay.RzBitBtn1.Enabled:=False;
  Resume;
end;

destructor TSaveMessage.destroy;
begin
  inherited;
  SMGPGateWay.RzBitBtn1.Enabled:=True;
  XML := '数据保存完成，可以退出系统！';
  synchronize(showmessage);
end;

procedure TSaveMessage.Execute;
begin
  if not DirectoryExists(extractfilepath(application.ExeName) + 'NOTransactData\') then
    ForceDirectories(extractfilepath(application.ExeName) + 'NOTransactData\');
  WriteSubmitFile;
  WriteReportFile;
  WriteResponseFile;
  writeDeliverFile;
end;

procedure TSaveMessage.showmessage;
begin
  SMGPGateWay.Memo1.Lines.Add('保存:' + XML);
end;

procedure TSaveMessage.writeDeliverFile;
var
  pDeliver: PCTDeliver;
begin
  LogPath := extractfilepath(application.ExeName) + 'NOTransactData\Deliver.Dat';
  iList := DeliverList.LockList;
  try
    if iList.Count > 0 then
    begin
      while iList.Count > 0 do
      begin
        pDeliver := PCTDeliver(iList.First);
        XML := WriteDeliver(pDeliver^);
        WriteXMLStr(XML, LogPath);
        synchronize(showmessage);
        iList.Delete(0);
        dispose(pDeliver);
        sleep(100);
      end
    end;
  finally
    DeliverList.UnlockList;
  end;
end;

procedure TSaveMessage.WriteReportFile;
var
  aReport: PReport;
begin
  LogPath := extractfilepath(application.ExeName) + 'NOTransactData\Report.Dat';
  iList := ReportList.LockList;
  try
    if iList.Count > 0 then
    begin
      while iList.Count > 0 do
      begin
        aReport := PReport(iList.First);
        XML := writeXmlReport(aReport^);
        WriteXMLStr(XML, LogPath);
        synchronize(showmessage);
        iList.Delete(0);
        dispose(aReport);
        sleep(100);
      end
    end;
  finally
    ReportList.UnlockList;
  end;
end;

procedure TSaveMessage.WriteResponseFile;
var
  aResponse: PResponse;
begin
  LogPath := extractfilepath(application.ExeName) + 'NOTransactData\Response.Dat';
  iList := ResponseList.LockList;
  try
    if iList.Count > 0 then
    begin
      while iList.Count > 0 do
      begin
        aResponse := PResponse(iList.First);
        XML := writeXMLResponse(aResponse^);
        WriteXMLStr(XML, LogPath);
        synchronize(showmessage);
        iList.Delete(0);
        dispose(aResponse);
        sleep(100);
      end
    end;
  finally
    ResponseList.UnlockList;
  end;
end;

procedure TSaveMessage.WriteSubmitFile;
var
  PSubmit: PxSubmit;
begin
  LogPath := extractfilepath(application.ExeName) + 'NOTransactData\Submit.Dat';
  iList := SubmitList.LockList; //what???????
  try
    if iList.Count > 0 then
    begin
      while iList.Count > 0 do
      begin
        PSubmit := PxSubmit(iList.First);
        XML := WriteSubmit(PSubmit^.sSubmit); //
        WriteXMLStr(XML, LogPath);
        synchronize(showmessage);
        iList.Delete(0);
        dispose(PSubmit);
        sleep(100);
      end
    end;
  finally
    SubmitList.UnlockList;
  end;
end;

procedure TSaveMessage.WriteXMLStr(iXML, Filename: string);
var
  files: TextFile;
begin
  try
    assignfile(files, Filename);
    if FileExists(Filename) then
    try
      Append(files);
    except
    end
    else
      rewrite(files);
    Filename := SysUtils.StringReplace(iXML, #13#10, '', [rfReplaceAll]); //替换回车换行符
    try
      writeln(files, Filename);
    except
    end;
  finally
    CloseFile(files);
  end;
end;

{ TReadMessage }

constructor TReadMessage.create;
begin
  inherited create(True);
  FreeOnTerminate := True;
  SMGPGateWay.RzBitBtn1.Enabled:=False;
  SMSList := TStringList.create;
  Resume;
end;

destructor TReadMessage.destroy;
begin
  FreeAndNIl(SMSList);
  SMGPGateWay.RzBitBtn1.Enabled:=true;
  inherited;
end;

procedure TReadMessage.Execute;
begin
  inherited;
  if not DirectoryExists(extractfilepath(application.ExeName) + 'NOTransactData\') then
    ForceDirectories(extractfilepath(application.ExeName) + 'NOTransactData\');
  ReadDeliverFile;
  ReadSubmitFile;
  ReadResponseFile;
  ReadReportFile;
end;

procedure TReadMessage.ReadDeliverFile;
var
  Filename: string;
  i: integer;
  pDeliver: PCTDeliver; //指针
  TCDeliver: TTCDeliver;
begin
  Filename := extractfilepath(application.ExeName) + 'NOTransactData\Deliver.dat';
  if FileExists(Filename) then
  try
    SMSList.Clear;
    SMSList.LoadFromFile(Filename);
  finally
    DeleteFile(Filename);
  end;
  for i := 0 to SMSList.Count - 1 do
  begin
    XML := SMSList.Strings[i]; //XML解析并存入 DeliverList中
    Fillchar(TCDeliver, sizeof(TCDeliver), 0);
    ReadDeliver(XML, TCDeliver);
    new(pDeliver);
    pDeliver^ := TCDeliver;
    DeliverList.Add(pDeliver);
    synchronize(showmessage);
    sleep(100);
  end;
end;

procedure TReadMessage.ReadReportFile;
var
  Filename: string;
  i: integer;
  iPReport: PReport; //指针
  iReport: TReport;
begin
  SMSList.Clear;
  Filename := extractfilepath(application.ExeName) + 'NOTransactData\Report.dat';
  if FileExists(Filename) then
  try
    SMSList.LoadFromFile(Filename);
  finally
    DeleteFile(Filename);
  end;
  for i := 0 to SMSList.Count - 1 do
  begin
    XML := SMSList.Strings[i]; //XML解析并存入 DeliverList中
    ReadCTSubmitReport(XML, iReport);
    new(iPReport);
    iPReport^ := iReport;
    ReportList.Add(iPReport);
    synchronize(showmessage);
    sleep(100);
  end;
end;

procedure TReadMessage.ReadResponseFile;
var
  Filename: string;
  i: integer;
  SPResponse: PResponse; //指针
  iResponse: TSPResponse;
begin
  SMSList.Clear;
  Filename := extractfilepath(application.ExeName) + 'NOTransactData\Response.dat';
  if FileExists(Filename) then
  try
    SMSList.LoadFromFile(Filename);
  finally
    DeleteFile(Filename);
  end;
  for i := 0 to SMSList.Count - 1 do
  begin
    XML := SMSList.Strings[i]; //XML解析并存入 DeliverList中
    ReadCTSubmitResp(XML, iResponse);
    new(SPResponse);
    SPResponse^ := iResponse;
    ResponseList.Add(SPResponse);
    synchronize(showmessage);
    sleep(100);
  end;
end;

procedure TReadMessage.ReadSubmitFile;
var
  Filename: string;
  i: integer;
  PSubmit: PxSubmit; //指针
  aSubmit: TTCSubmit;
begin
  SMSList.Clear;
  Filename := extractfilepath(application.ExeName) + 'NOTransactData\Submit.dat';
  if FileExists(Filename) then
  try
    SMSList.LoadFromFile(Filename);
  finally
    DeleteFile(Filename);
  end;
  for i := 0 to SMSList.Count - 1 do
  begin
    XML := SMSList.Strings[i]; //XML解析并存入 DeliverList中
    ReadSubmit(XML, aSubmit);
    new(PSubmit);
    PSubmit^.Resend := 0;
    PSubmit^.SequenceID := 0;
    PSubmit^.Then_DateTime := 0;
    PSubmit^.sSubmit.Mid := aSubmit.Mid;
    PSubmit^.sSubmit.MsgType := aSubmit.MsgType;
    PSubmit^.sSubmit.NeedReport := aSubmit.NeedReport;
    PSubmit^.sSubmit.Priority := aSubmit.NeedReport;
    PSubmit^.sSubmit.ServiceID := aSubmit.ServiceID;
    PSubmit^.sSubmit.FeeType := aSubmit.FeeType;
    PSubmit^.sSubmit.FeeCode := aSubmit.FeeCode;
    PSubmit^.sSubmit.FixedFee := aSubmit.FixedFee;
    PSubmit^.sSubmit.MsgFormat := aSubmit.MsgFormat;
    PSubmit^.sSubmit.ValidTime := aSubmit.ValidTime;
    PSubmit^.sSubmit.AtTime := aSubmit.AtTime;
    PSubmit^.sSubmit.SrcTermID := aSubmit.SrcTermID; //
    PSubmit^.sSubmit.ChargeTermID := aSubmit.ChargeTermID; //
    PSubmit^.sSubmit.DestTermIDCount := aSubmit.DestTermIDCount;
    PSubmit^.sSubmit.DestTermID := aSubmit.DestTermID;
    PSubmit^.sSubmit.MsgLength := aSubmit.MsgLength;
    PSubmit^.sSubmit.LinkID := aSubmit.LinkID;
    PSubmit^.sSubmit.MsgContent := aSubmit.MsgContent;
    SubmitList.Add(PSubmit);
    synchronize(showmessage);
    sleep(100);
  end;
end;

procedure TReadMessage.showmessage;
begin
  SMGPGateWay.Memo1.Lines.Add('读取:' + XML);
end;

end.

