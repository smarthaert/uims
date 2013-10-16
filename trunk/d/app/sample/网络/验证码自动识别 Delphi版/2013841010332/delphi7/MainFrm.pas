unit MainFrm;


interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtDlgs;

type
  TMainForm = class(TForm)
    btnInit: TButton;
    panLogin: TPanel;
    btnLogin: TButton;
    btnUninit: TButton;
    panAction: TPanel;
    btnLogoff: TButton;
    btnDecode: TButton;
    btnGetResult: TButton;
    btnReport: TButton;
    btnDecodeWnd: TButton;
    btnDecodeBuf: TButton;
    OpenDialog1: TOpenDialog;
    btnGetOrigError: TButton;
    btnRegister: TButton;
    btnRecharge: TButton;
    btnRQueryBalance: TButton;
    btnReadInfo: TButton;
    btnChangeInfo: TButton;
    btnDecodeSync: TButton;
    btnDecodeWndSync: TButton;
    btnDecodeBufSync: TButton;
    btnDecodeFileSync: TButton;
    btnD2File: TButton;
    btnD2Buf: TButton;
    procedure btnInitClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnUninitClick(Sender: TObject);
    procedure btnLogoffClick(Sender: TObject);
    procedure btnDecodeClick(Sender: TObject);
    procedure btnGetResultClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure btnDecodeWndClick(Sender: TObject);
    procedure btnDecodeBufClick(Sender: TObject);
    procedure btnGetOrigErrorClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure btnRechargeClick(Sender: TObject);
    procedure btnRQueryBalanceClick(Sender: TObject);
    procedure btnReadInfoClick(Sender: TObject);
    procedure btnChangeInfoClick(Sender: TObject);
    procedure btnDecodeSyncClick(Sender: TObject);
    procedure btnDecodeWndSyncClick(Sender: TObject);
    procedure btnDecodeBufSyncClick(Sender: TObject);
    procedure btnDecodeFileSyncClick(Sender: TObject);
    procedure btnD2FileClick(Sender: TObject);
    procedure btnD2BufClick(Sender: TObject);
  private
    { Private declarations }
    idRequest : Integer;
    idVCode : Integer;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
uses Dama2;

procedure TMainForm.btnInitClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
begin

  err := Init('TestSoftware', '9503ce045ad14d83ea876ab578bd3184');
  s := Format('Init return %d', [err]);
  ShowMessage(s);

  if err = ERR_CC_SUCCESS then
  begin
    panLogin.Visible := true;
  end;
end;

procedure TMainForm.btnUninitClick(Sender: TObject);
begin
  Uninit();
  panLogin.Visible := false;
  panAction.Visible := false;

end;

procedure TMainForm.btnLoginClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var sysAnnouncementURL : array[0..4096] of char;
  var appAnnouncementURL : array[0..4096] of char;
begin
  err := Login('zh', '123456', '', sysAnnouncementURL, appAnnouncementURL);
  s := Format('Login return %d, sysUrl=%s, appUrl=%s',
    [err, sysAnnouncementURL, appAnnouncementURL]);
  ShowMessage(s);

  if err = ERR_CC_SUCCESS then
  begin
    panAction.Visible := true;
  end;

end;


procedure TMainForm.btnLogoffClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
begin
  err := Logoff();
  s := Format('Logoff return %d', [err]);
  ShowMessage(s);

  if err = ERR_CC_SUCCESS then
  begin
    panAction.Visible := false;
  end;

end;

procedure TMainForm.btnDecodeClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
begin
  err := Decode(
    'http://captcha.qq.com/getimage?aid=549000912&r=0.7257105156128585&uin=3056517021',   //url
    '',   //cookie
    '',   //referer
    4,    //length of verification code
    120,  //timeout, 秒
    327,  //type id
    0,    //download from local machine
    idRequest);
  s := Format('Decode return %d, requestID=%d', [err, idRequest]);
  ShowMessage(s);

end;

procedure TMainForm.btnGetResultClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var txtVCode : array[0..100] of char;
  var retCookie : array[0..4096] of char;
begin
  err := GetResult(idRequest, 5 * 1000, txtVCode, 100, idVCode, retCookie, 4096);
  if err = ERR_CC_SUCCESS then
  begin
    s := Format('GetResult return %d, requestID=%d, txtVCode=%s, idVCode=%d, cookie=%s',
      [err, idRequest, txtVCode, idVCode, retCookie]);
  end
  else
  begin
    s := Format('GetResult return %d, requestID=%d', [err, idRequest]);
  end;

  ShowMessage(s);

end;

procedure TMainForm.btnReportClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
begin
  err := ReportResult(idVCode, 1);
  s := Format('ReportResult return %d, VCodeID=%d', [err, idVCode]);

  ShowMessage(s);

end;

procedure TMainForm.btnDecodeWndClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var r : TRect;
begin
  r.Left := 0;
  r.Right := 0;
  r.Top := 0;
  r.Bottom := 0;
  err := DecodeWnd(
    'Button,ANY_NAME,1',   //Window Def
    @r,   //Rect
    4,    //length of verification code
    120,  //timeout, 秒
    327,  //type id
    idRequest);
  s := Format('DecodeWnd return %d, requestID=%d', [err, idRequest]);
  ShowMessage(s);

end;

procedure TMainForm.btnDecodeBufClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var
  MyFile : TMemoryStream;
  Filebuf : array of pchar; //这里声明的是动态数组
  iLen : Int64;
begin
  OpenDialog1.Filter := 'JPEG file|*.jpg;*.jpeg||';
  OpenDialog1.Options := [ofReadOnly];

  if not OpenDialog1.Execute() then exit;

  //读文件
  MyFile := TMemoryStream.Create;
  MyFile.LoadFromFile(OpenDialog1.FileName);
  iLen := MyFile.Size;//获得指定文件的大小
  SetLength(FileBuf, iLen);//设置动态数组的长度为文件的大小
  MyFile.ReadBuffer(FileBuf[0], iLen);//读取TXT文件全部数据
  FreeAndNil(MyFile);

  //请求打码
  err := DecodeBuf(
    FileBuf,     //buf
    iLen,       //Data length
    'jpg',      //extention name
    4,    //length of verification code
    120,  //timeout, 秒
    327,  //type id
    idRequest);
  s := Format('Decode return %d, requestID=%d', [err, idRequest]);
  ShowMessage(s);

end;

procedure TMainForm.btnGetOrigErrorClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
begin
  err := GetOrigError();
  s := Format('OrigError=%d', [err]);
  ShowMessage(s);
end;

procedure TMainForm.btnRegisterClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
begin
  err := Register('newuser', '123456', '12345678', '13600000000', '12345678@qq.com', 2) ;
  s := Format('Register return %d', [err]);
  ShowMessage(s);

end;

procedure TMainForm.btnRechargeClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var bal : Integer;
begin
  err := Recharge('zh', '12345678901234567890123456789012', bal) ;
  s := Format('Recharge(zh,12345678901234567890123456789012) return %d, balance=%d',
    [err, bal]);
  ShowMessage(s);

end;

procedure TMainForm.btnRQueryBalanceClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var bal : Integer;
begin
  err := QueryBalance(bal) ;
  s := Format('QueryBalance() return %d, balance=%d',
    [err, bal]);
  ShowMessage(s);

end;

procedure TMainForm.btnReadInfoClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  Var
  userName : array[0..100] of char;
  qq  : array[0..100] of char;
  email : array[0..100] of char;
  telno : array[0..100] of char;
  sendMode : Integer;
begin
  err := ReadInfo(userName, qq, telno, email, sendMode);
  s := Format('ReadInfo() return %d, username=%s, qq=%s, telno=%s, email=%s, sendMode=%d',
    [err, userName, qq, telno, email, sendMode]);
  ShowMessage(s);

end;

procedure TMainForm.btnChangeInfoClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  Var
  userName : array[0..100] of char;
  qq  : array[0..100] of char;
  email : array[0..100] of char;
  telno : array[0..100] of char;
  dyncVCode : AnsiString;
  sendMode : Integer;
begin
  err := ReadInfo(userName, qq, telno, email, sendMode);
  s := Format('ReadInfo() return %d, username=%s, qq=%s, telno=%s, email=%s, sendMode=%d',
    [err, userName, qq, telno, email, sendMode]);
  ShowMessage(s);
  if err <> ERR_CC_SUCCESS then exit;
  dyncVCode := '';

  err := ERR_CC_NEED_DYNC_VCODE;
  while err = ERR_CC_NEED_DYNC_VCODE do
  begin
    err := ChangeInfo('123456', '123456', qq, telno, email, PAnsiChar(dyncVCode), sendMode);
    if err = ERR_CC_NEED_DYNC_VCODE then
    begin
        //输入动态验证码
        dyncVCode := InputBox('输入动态验证码', '输入动态验证码', '');
        if  dyncVCode = '' then exit;
    end;
  end;

  s := Format('ChangeInfo() return %d', [err]);
  ShowMessage(s);

end;

procedure TMainForm.btnDecodeSyncClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var vcodeText : array[0..100] of char;
  var retCookie : array[0..4096] of char;
begin
  err := DecodeSync(
    'http://captcha.qq.com/getimage?aid=549000912&r=0.7257105156128585&uin=3056517021',   //url
    '',   //cookie
    '',   //referer
    30,  //timeout, 秒
    327,  //type id
    vcodeText,
    retCookie);
  if err < 0 then
  begin
      s := Format('DecodeSync return %d', [err]);
      ShowMessage(s);
      exit;
  end;

  idVCode := err;
  s := Format('DecodeSync success: text=%s, id=%d', [vcodeText, idVCode]);
  ShowMessage(s);

end;

procedure TMainForm.btnDecodeWndSyncClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var r : TRect;
  var vcodeText : array[0..100] of char;
begin
  r.Left := 0;
  r.Right := 0;
  r.Top := 0;
  r.Bottom := 0;
  err := DecodeWndSync(
    'Button,ANY_NAME,1',   //Window Def
    @r,   //Rect
    30,  //timeout, 秒
    327,  //type id
    vcodeText);

  if err < 0 then
  begin
      s := Format('DecodeWndSync return %d', [err]);
      ShowMessage(s);
      exit;
  end;

  idVCode := err;
  s := Format('DecodeWndSync success: text=%s, id=%d', [vcodeText, idVCode]);
  ShowMessage(s);

end;

procedure TMainForm.btnDecodeBufSyncClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var
  MyFile : TMemoryStream;
  Filebuf : array of pchar; //这里声明的是动态数组
  iLen : Int64;
  var vcodeText : array[0..100] of char;
begin
  OpenDialog1.Filter := 'JPEG file|*.jpg;*.jpeg||';
  OpenDialog1.Options := [ofReadOnly];

  if not OpenDialog1.Execute() then exit;

  //读文件
  MyFile := TMemoryStream.Create;
  MyFile.LoadFromFile(OpenDialog1.FileName);
  iLen := MyFile.Size;//获得指定文件的大小
  SetLength(FileBuf, iLen);//设置动态数组的长度为文件的大小
  MyFile.ReadBuffer(FileBuf[0], iLen);//读取TXT文件全部数据
  FreeAndNil(MyFile);

  //请求打码
  err := DecodeBufSync(
    FileBuf,     //buf
    iLen,       //Data length
    'jpg',      //extention name
    120,  //timeout, 秒
    327,  //type id
    vcodeText);

  if err < 0 then
  begin
      s := Format('DecodeBufSync return %d', [err]);
      ShowMessage(s);
      exit;
  end;

  idVCode := err;
  s := Format('DecodeBufSync success: text=%s, id=%d', [vcodeText, idVCode]);
  ShowMessage(s);

end;

procedure TMainForm.btnDecodeFileSyncClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var vcodeText : array[0..100] of char;
begin
  OpenDialog1.Filter := 'Image file|*.jpg;*.jpeg;*.bmp;*.png;*.gif||';
  OpenDialog1.Options := [ofReadOnly];

  if not OpenDialog1.Execute() then exit;
  //请求打码
  err := DecodeFileSync(
    PAnsiChar(OpenDialog1.FileName),     //FilePath
    30,  //timeout, 秒
    327,  //type id
    vcodeText);

  if err < 0 then
  begin
      s := Format('DecodeFileSync return %d', [err]);
      ShowMessage(s);
      exit;
  end;

  idVCode := err;
  s := Format('DecodeFileSync success: text=%s, id=%d', [vcodeText, idVCode]);
  ShowMessage(s);

end;

procedure TMainForm.btnD2FileClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var vcodeText : array[0..100] of char;
begin
  OpenDialog1.Filter := 'Image file|*.jpg;*.jpeg;*.bmp;*.png;*.gif||';
  OpenDialog1.Options := [ofReadOnly];

  if not OpenDialog1.Execute() then exit;
  //请求打码
  err := D2File('9503ce045ad14d83ea876ab578bd3184', //软件KEY
    'test', //用户名
    'test', //密码
    PAnsiChar(OpenDialog1.FileName),     //FilePath
    30,  //timeout, 秒
    101,  //type id
    vcodeText);

  if err < 0 then
  begin
      s := Format('D2File return %d', [err]);
      ShowMessage(s);
      exit;
  end;

  idVCode := err;
  s := Format('D2File success: text=%s, id=%d', [vcodeText, idVCode]);
  ShowMessage(s);
  panLogin.Visible := true;
  panAction.Visible := true;

end;

procedure TMainForm.btnD2BufClick(Sender: TObject);
  Var err : Integer;
  var s : AnsiString;
  var
  MyFile : TMemoryStream;
  Filebuf : array of pchar; //这里声明的是动态数组
  iLen : Int64;
  var vcodeText : array[0..100] of char;
begin
  OpenDialog1.Filter := 'Image file|*.jpg;*.jpeg;*.bmp;*.png;*.gif||';
  OpenDialog1.Options := [ofReadOnly];

  if not OpenDialog1.Execute() then exit;

  //读文件
  MyFile := TMemoryStream.Create;
  MyFile.LoadFromFile(OpenDialog1.FileName);
  iLen := MyFile.Size;//获得指定文件的大小
  SetLength(FileBuf, iLen);//设置动态数组的长度为文件的大小
  MyFile.ReadBuffer(FileBuf[0], iLen);//读取TXT文件全部数据
  FreeAndNil(MyFile);

  //请求打码
  err := D2Buf('9503ce045ad14d83ea876ab578bd3184', //软件KEY
    'test', //用户名
    'test', //密码
    FileBuf,     //buf
    iLen,       //Data length
    30,  //timeout, 秒
    101,  //type id
    vcodeText);

  if err < 0 then
  begin
      s := Format('D2Buf return %d', [err]);
      ShowMessage(s);
      exit;
  end;

  idVCode := err;
  s := Format('D2Buf success: text=%s, id=%d', [vcodeText, idVCode]);
  ShowMessage(s);
  panLogin.Visible := true;
  panAction.Visible := true;

end;

end.
