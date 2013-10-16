unit IBInstatusCallBack;
// Download by http://www.codefans.net
interface

uses SysUtils, Windows, UrlMon, ActiveX;

type TBindStatusCallback = class(TObject, IBindStatusCallback)
 protected
    FRefCount: Integer;
  // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): Integer; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
 public
  // IBindStatusCallback
   function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
   function GetPriority(out nPriority): HResult; stdcall;
   function OnLowResource(reserved: DWORD): HResult; stdcall;
   function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
     szStatusText: LPCWSTR): HResult; stdcall;
   function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
   function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
   function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;
     stgmed: PStgMedium): HResult; stdcall;
   function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
 end;

implementation

{ TBindStatusCallback }

uses Update; // where Form1 is

function TBindStatusCallback.QueryInterface(const IID: TGUID;
 out Obj): Integer;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
end;

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

function TBindStatusCallback.GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.GetPriority(out nPriority): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnDataAvailable(grfBSCF, dwSize: DWORD;formatetc: PFormatEtc; stgmed: PStgMedium): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnLowResource(reserved: DWORD): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnObjectAvailable(const iid: TGUID;punk: IUnknown): HResult;
begin
   Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnStopBinding(hresult: HResult;
 szError: LPCWSTR): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnProgress(ulProgress, ulProgressMax,ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult;
begin
   with UpdataFrm do
      begin
        if (ulProgress=ulProgressMax) and (arDownload) then  Caption := format('正在下载更新文件，共%d个文件已下载%d ...',[filecount,CurDown+1])
        else  Caption := format('正在下载更新文件，共%d个文件已下载%d ...',[filecount,CurDown]);
        Label2.Caption := ProgressStatus+#13+'已下载: '+IntToStr(ulProgress) +' 个字节 ...';
        Label2.Update;
        Progressbar2.Min := 1;
        Progressbar2.Max := filecount;
        Progressbar2.Position := CurDown+1;
        ProgressBar1.Min := 0;
        ProgressBar1.Max := ulProgressMax;
        ProgressBar1.Position := ulProgress;
        if ulProgress >0 then  arDownload := True;
      end;
   result := s_ok;
end;



end.
