unit DownloadFileFromWeb;

interface

uses
  Windows, SysUtils, UrlMon, ActiveX, Classes, ExtCtrls, shellapi;

type
  //下载流量状态回调接口类
  TOnThreadProgressEvent =
    procedure(AThread: TThread;                //线程
              ulProgress,                      //下载进度
              ulProgressMax,                   //最大进度
              ulStatusCode: integer;           //状态码
              szStatusText:string) of object;  //状态字符串
  TOnThreadCompleteEvent =
    procedure(AThread: TThread;                //线程
              Source_file,                     //源文件
              Dest_file: string;
              blStatus:boolean;
              ErrMessage:string) of object;

  TDownFile = class;
  TDownThread = class;

  //下载进度，完成信息回调接口
  TBindStatusCallback = class(TObject, IBindStatusCallback)
  private
    //下载线程
    FDownThread: TDownThread;
    FOnThreadProgress: TOnThreadProgressEvent;
    procedure CallThreadProgress(
          AThread: TThread;
          ulProgress,
          ulProgressMax,
          ulStatusCode: integer;
          szStatusText:string);
    procedure SetOnThreadProgress(const Value: TOnThreadProgressEvent);  //下载进度（线程）
  protected
    // IUnknown
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): Integer; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    // IBindStatusCallback
    function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
    function GetPriority(out nPriority): HResult; stdcall;
    function OnLowResource(reserved: DWORD): HResult; stdcall;
    function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;szStatusText: LPCWSTR): HResult; stdcall;
    function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
    function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
    function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;stgmed: PStgMedium): HResult; stdcall;
    function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
    property OnThreadProgress: TOnThreadProgressEvent read FOnThreadProgress write SetOnThreadProgress;
  end;

  //下载线程类
  TDownThread = class(TThread)
  private
    //回调
    FStatusCallback:TBindStatusCallback;
    //文件下载类
    FDownFile:TDownFile;
    //源文件名
    Source_file:string;
    //保存于本地的文件名
    Dest_file:string;
    //下载是否成功
    blDownOK:boolean;
    //出错信息
    ErrMessage:string;
    //取消
    FCancel:Boolean;
    //下载进度
    FOnThreadProgress:TOnThreadProgressEvent;
    //下载完成
    FOnThreadComplete:TOnThreadCompleteEvent;
    //调用下载进度回调
    procedure CallThreadProgress(AThread: TThread; ulProgress, ulProgressMax, ulStatusCode: integer; szStatusText:string);
    //调用下载完成事件
    procedure CallThreadComplete(AThread: TThread; Source_file, Dest_file: string; blStatus:boolean; ErrMessage:string);
    //设置线程进度事件
    //下载进度（线程）
    procedure SetOnThreadProgress(const Value: TOnThreadProgressEvent);
    //设置线程完成事件
    //下载完成（线程）
    procedure SetOnThreadComplete(const Value: TOnThreadCompleteEvent);
  protected
    procedure Execute;override;
  public
    constructor Create(URL,
                       FileName:string;
                       DownFile:TDownFile);
    destructor Destroy;override;
    //取消下载
    procedure Cancel;
  published
    property OnThreadProgress: TOnThreadProgressEvent read FOnThreadProgress write SetOnThreadProgress;
    property OnThreadComplete: TOnThreadCompleteEvent read FOnThreadComplete write SetOnThreadComplete;
  end;


  //文件下载控件
  TDownFile = class(TComponent)
  private
    //下载线程列表
    FDownThreads: TThreadList;
    //下载进度
    FOnThreadProgress: TOnThreadProgressEvent;
    //下载完成
    FOnThreadComplete: TOnThreadCompleteEvent;
    //移除线程
    procedure RemoveThread(AThread: TDownThread);
    ////////
    //procedure CallThreadProgress(AThread: TThread; ulProgress, ulProgressMax, ulStatusCode: integer; szStatusText:string);
    //procedure CallThreadComplete(AThread: TThread; Source_file, Dest_file: string; blStatus:boolean; ErrMessage:string);
    ////////
    //下载进度（线程）
    procedure SetOnThreadProgress(const Value: TOnThreadProgressEvent);
    //下载完成（线程）
    procedure SetOnThreadComplete(const Value: TOnThreadCompleteEvent);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //取消所有下载线程.
    procedure CancelThreads;
    //下载文件
    procedure ThreadDownFile(Source, Dest: string);
  published
    property OnThreadProgress: TOnThreadProgressEvent read FOnThreadProgress write SetOnThreadProgress;
    property OnThreadComplete: TOnThreadCompleteEvent read FOnThreadComplete write SetOnThreadComplete;
  end;

implementation

{ TBindStatusCallback }

function TBindStatusCallback._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TBindStatusCallback._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

procedure TBindStatusCallback.CallThreadProgress(AThread: TThread; ulProgress,
  ulProgressMax, ulStatusCode: integer; szStatusText: string);
begin
  if Assigned(FOnThreadProgress) then
    FOnThreadProgress(AThread, ulProgress, ulProgressMax, ulStatusCode, szStatusText);
end;

function TBindStatusCallback.GetBindInfo(out grfBINDF: DWORD;
  var bindinfo: TBindInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.GetPriority(out nPriority): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnDataAvailable(grfBSCF, dwSize: DWORD;
  formatetc: PFormatEtc; stgmed: PStgMedium): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnLowResource(reserved: DWORD): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnObjectAvailable(const iid: TGUID;
  punk: IInterface): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnStartBinding(dwReserved: DWORD;
  pib: IBinding): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnStopBinding(hresult: HResult;
  szError: LPCWSTR): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.QueryInterface(const IID: TGUID;
  out Obj): Integer;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

procedure TBindStatusCallback.SetOnThreadProgress(
  const Value: TOnThreadProgressEvent);
begin
  FOnThreadProgress := Value;
end;

function TBindStatusCallback.OnProgress(ulProgress, ulProgressMax,
  ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult;
begin
  Result := S_OK;
  CallThreadProgress(FDownThread,ulProgress,ulProgressMax,ulStatusCode,szStatusText);
end;

{ TDownFile }

procedure TDownFile.CancelThreads;
var
  DownThread: TDownThread;
  objList: TList;
begin
  objList := FDownThreads.LockList();
  try
    while objList.Count > 0 do
    begin
      DownThread := TDownThread(objList.Items[0]);
      objList.Delete(0);
      DownThread.Cancel();
    end;//while
  finally
    FDownThreads.UnlockList();
  end;
end;

constructor TDownFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDownThreads := TThreadList.Create();
end;

procedure TDownFile.RemoveThread(AThread: TDownThread);
var
  objList: TList;
begin
  objList := FDownThreads.LockList();
  try
    objList.Remove(AThread);
  finally
    FDownThreads.UnlockList();
  end;
end;

destructor TDownFile.Destroy;
begin
  CancelThreads();
  FDownThreads.Free();
  inherited;
end;

procedure TDownFile.SetOnThreadComplete(const Value: TOnThreadCompleteEvent);
begin
  FOnThreadComplete := Value;
end;

procedure TDownFile.SetOnThreadProgress(const Value: TOnThreadProgressEvent);
begin
  FOnThreadProgress := Value;
end;

procedure TDownFile.ThreadDownFile(Source, Dest: string);
var
  DownThread:TDownThread;
  objList: TList;
begin
  objList := FDownThreads.LockList();
  try
    DownThread := TDownThread.Create(Source, Dest, Self);
    DownThread.OnThreadProgress:=OnThreadProgress;
    DownThread.OnThreadComplete:=OnThreadComplete;
    objList.Add(DownThread);
    DownThread.Resume;
  finally
    FDownThreads.UnlockList();
  end;
end;

{ TDownThread }

procedure TDownThread.CallThreadComplete(AThread: TThread; Source_file,
  Dest_file: string; blStatus: boolean; ErrMessage: string);
begin
  if Assigned(FOnThreadComplete) then
  begin
    FOnThreadComplete(AThread, Source_file, Dest_file, blStatus, ErrMessage);
  end;
end;

procedure TDownThread.CallThreadProgress(AThread: TThread; ulProgress,
  ulProgressMax, ulStatusCode: integer; szStatusText: string);
begin
  if Assigned(FOnThreadProgress) then
  begin
    FOnThreadProgress(AThread, ulProgress, ulProgressMax, ulStatusCode, szStatusText);
  end;
end;

procedure TDownThread.Cancel;
begin
  FCancel := True;
  FDownFile := nil;
end;

constructor TDownThread.Create(URL, FileName: string; DownFile: TDownFile);
begin
  inherited Create(True);
  //下载回调过程
  FStatusCallback := TBindStatusCallback.Create;
  FStatusCallback.FDownThread := Self;
  //终止释放
  FreeOnTerminate := True;
  //下载文件
  FDownFile := DownFile;
  //源文件
  Source_file := URL;
  //下载文件
  Dest_file := FileName;
  //取消
  FCancel := False;
end;

destructor TDownThread.Destroy;
begin
  if FDownFile<>nil then
  begin
    FDownFile.RemoveThread(Self);
  end;
  FStatusCallback.Free();
  inherited;
end;

procedure TDownThread.Execute;
begin
  //出错消息
  ErrMessage:='';
  //是否下载成功
  blDownOK:=False;
  //下载文件
  try
    if UrlDownloadToFile(nil,Pchar(Source_file),Pchar(Dest_file), 0, FStatusCallback) = 0 then
    begin
      blDownOK:=True;
    end;
  except
    on E:Exception do
    begin
      ErrMessage := e.Message;
    end;
  end;
  //如果取消，那么应该在下载一半也要取消,否则执行完这个执行体，
  if FCancel then Exit;
  //如果FDownFile已经释放,线程还只执行到这里，那么会出错.
  CallThreadComplete(Self, Source_file, Dest_file, blDownOK, ErrMessage);
end;

procedure TDownThread.SetOnThreadComplete(const Value: TOnThreadCompleteEvent);
begin
  FOnThreadComplete := Value;
end;

procedure TDownThread.SetOnThreadProgress(const Value: TOnThreadProgressEvent);
begin
  FOnThreadProgress := Value;
  FStatusCallback.OnThreadProgress := Value;
end;

end.
