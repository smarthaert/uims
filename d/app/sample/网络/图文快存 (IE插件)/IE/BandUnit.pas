{*******************************************************}
{                                                       }
{       IEBar 图文快存                                  }
{                                                       }
{       版权所有 (C) 2005　毕耜祯           　　　　　　}
{            转载请保留此信息 　　　　　　　　　　　　  }
{       网址：batconv.512j.com                          }
{       batconv@163.com                                 }
{*******************************************************}


unit BandUnit;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses 
 Windows, Sysutils, Messages, Registry, Shellapi, ActiveX, Classes, ComObj, 
  Shlobj, Dialogs, Commctrl,ShDocVW,IEForm;

type
 TGetMailBand = class(TComObject, IDeskBand, IObjectWithSite, IPersistStreamInit) 
 private 
     frmIE:TfrmMain;
     m_pSite:IInputObjectSite; 
   m_hwndParent:HWND; 
   m_hWnd:HWND; 
   m_dwViewMode:Integer; 
     m_dwBandID:Integer; 
  protected 

  public 
   {Declare IDeskBand methods here} 
     function GetBandInfo(dwBandID, dwViewMode: DWORD; var pdbi: TDeskBandInfo): 
        HResult; stdcall; 
     function ShowDW(fShow: BOOL): HResult; stdcall; 
     function CloseDW(dwReserved: DWORD): HResult; stdcall; 
     function ResizeBorderDW(var prcBorder: TRect; punkToolbarSite: IUnknown; 
        fReserved: BOOL): HResult; stdcall; 
     function GetWindow(out wnd: HWnd): HResult; stdcall; 
     function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall; 

     {Declare IObjectWithSite methods here} 
     function SetSite(const pUnkSite: IUnknown ):HResult; stdcall; 
     function GetSite(const riid: TIID; out site: IUnknown):HResult;stdcall; 

     {Declare IPersistStream methods here} 
     function GetClassID(out classID: TCLSID): HResult; stdcall; 
     function IsDirty: HResult; stdcall; 
     function InitNew: HResult; stdcall; 
     function Load(const stm: IStream): HResult; stdcall; 
     function Save(const stm: IStream; fClearDirty: BOOL): HResult; stdcall; 
     function GetSizeMax(out cbSize: Largeint): HResult; stdcall; 
 end; 

const 
 Class_GetMailBand: TGUID = '{954F618B-0DEC-4D1A-9317-E0FC96F87865}'; 
 //以下是系统接口的IID 
 IID_IUnknown: TGUID = ( 
     D1:$00000000;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46)); 
 IID_IOleObject: TGUID = ( 
     D1:$00000112;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46)); 
 IID_IOleWindow: TGUID = ( 
     D1:$00000114;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46)); 

 IID_IInputObjectSite : TGUID = ( 
     D1:$f1db8392;D2:$7331;D3:$11d0;D4:($8C,$99,$00,$A0,$C9,$2D,$BF,$E8)); 
 sSID_SInternetExplorer : TGUID = '{0002DF05-0000-0000-C000-000000000046}'; 
 sIID_IWebBrowserApp : TGUID= '{0002DF05-0000-0000-C000-000000000046}'; 

 //面板所允许的最小宽度和高度。 
 MIN_SIZE_X = 54; 
 MIN_SIZE_Y = 22; 
 EB_CLASS_NAME = '图文快存'; 
implementation 

uses ComServ; 


function TGetMailBand.GetWindow(out wnd: HWnd): HResult; stdcall; 
begin 
  wnd:=m_hWnd; 
  Result:=S_OK; 
end; 

function TGetMailBand.ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall; 
begin 
  Result:=E_NOTIMPL; 
end; 

function TGetMailBand.ShowDW(fShow: BOOL): HResult; stdcall; 
begin 
  if m_hWnd<>0 then 
     if fShow then 
        ShowWindow(m_hWnd,SW_SHOW) 
     else 
        ShowWindow(m_hWnd,SW_HIDE); 
  Result:=S_OK; 
end; 

function TGetMailBand.CloseDW(dwReserved: DWORD): HResult; stdcall; 
begin 
  if frmIE<>nil then 
     frmIE.Destroy; 
  Result:= S_OK; 
end; 

function TGetMailBand.ResizeBorderDW(var prcBorder: TRect; 
     punkToolbarSite: IUnknown;fReserved: BOOL): HResult; stdcall; 
begin 
  Result:=E_NOTIMPL; 
end; 

function TGetMailBand.SetSite(const pUnkSite: IUnknown):HResult;stdcall; 
var 
  pOleWindow:IOleWindow; 
  pOLEcmd:IOleCommandTarget; 
  pSP:IServiceProvider; 
  rc:TRect; 
begin 
  if Assigned(pUnkSite) then begin 
     m_hwndParent := 0; 

     m_pSite:=pUnkSite as IInputObjectSite; 
     pOleWindow := PunkSIte as IOleWindow; 
     //获得父窗口IE面板窗口的句柄 
     pOleWindow.GetWindow(m_hwndParent); 

     if(m_hwndParent=0)then begin 
        Result := E_FAIL; 
        exit; 
     end; 

     //获得父窗口区域 
     GetClientRect(m_hwndParent, rc); 

     if not Assigned(frmIE) then begin 
        //建立TIEForm窗口，父窗口为m_hwndParent 
        frmIE:=TfrmMain.CreateParented(m_hwndParent);

        m_Hwnd:=frmIE.Handle; 

        SetWindowLong(frmIE.Handle, GWL_STYLE, GetWindowLong(frmIE.Handle, 
           GWL_STYLE) Or WS_CHILD); 
        //根据父窗口区域设置窗口位置 
        with frmIE do begin 
           Left :=rc.Left ; 
           Top:=rc.top; 
           Width:=rc.Right - rc.Left; 
           Height:=rc.Bottom - rc.Top; 
        end; 
        frmIE.Visible := True; 

        //获得与浏览器相关联的Webbrowser对象。 
        pOLEcmd:=pUnkSite as IOleCommandTarget; 
        pSP:=pOLEcmd as  IServiceProvider; 

        if Assigned(pSP)then begin 
          pSP.QueryService(IWebbrowserApp, IWebbrowser2,frmIE.IEThis); 
        end; 
     end; 
  end; 

  Result := S_OK; 
end; 
//Download by http://www.codefans.net
function TGetMailBand.GetSite(const riid: TIID; out site: IUnknown):HResult;stdcall; 
begin 
  if Assigned(m_pSite) then result:=m_pSite.QueryInterface(riid, site) 
  else 
    Result:= E_FAIL; 
end; 

function TGetMailBand.GetBandInfo(dwBandID, dwViewMode: DWORD; var pdbi: TDeskBandInfo): 
     HResult; stdcall; 
begin 
  Result:=E_INVALIDARG; 
  if not Assigned(frmIE) then frmIE:=TfrmMain.CreateParented(m_hwndParent); 
  if(@pdbi<>nil)then begin 
     m_dwBandID := dwBandID;
     m_dwViewMode := dwViewMode;

     if(pdbi.dwMask and DBIM_MINSIZE)<>0 then begin 
        pdbi.ptMinSize.x := MIN_SIZE_X; 
        pdbi.ptMinSize.y := MIN_SIZE_Y; 
     end; 

     if(pdbi.dwMask and DBIM_MAXSIZE)<>0 then begin 
        pdbi.ptMaxSize.x := -1; 
        pdbi.ptMaxSize.y := -1; 
     end; 

     if(pdbi.dwMask and DBIM_INTEGRAL)<>0 then begin 
        pdbi.ptIntegral.x := 1; 
        pdbi.ptIntegral.y := 1; 
     end; 

     if(pdbi.dwMask and DBIM_ACTUAL)<>0 then begin 
        pdbi.ptActual.x := 0; 
        pdbi.ptActual.y := 0; 
     end; 

     if(pdbi.dwMask and DBIM_MODEFLAGS)<>0 then 
        pdbi.dwModeFlags := DBIMF_VARIABLEHEIGHT; 

     if(pdbi.dwMask and DBIM_BKCOLOR)<>0 then 
        pdbi.dwMask := pdbi.dwMask and (not DBIM_BKCOLOR); 
  end; 
end; 


function TGetMailBand.GetClassID(out classID: TCLSID): HResult; stdcall; 
begin 
  classID:= Class_GetMailBand; 
  Result:=S_OK;
end; 

function TGetMailBand.IsDirty: HResult; stdcall; 
begin 
  Result:=S_FALSE;
end; 

function TGetMailBand.InitNew: HResult; 
begin 
 Result := E_NOTIMPL;
end; 

function TGetMailBand.Load(const stm: IStream): HResult; stdcall; 
begin 
  Result:=S_OK;
end; 

function TGetMailBand.Save(const stm: IStream; fClearDirty: BOOL): HResult; stdcall; 
begin 
  Result:=S_OK; 
end; 

function TGetMailBand.GetSizeMax(out cbSize: Largeint): HResult; stdcall; 
begin 
  Result:=E_NOTIMPL; 
end; 


//TIEClassFac类实现COM组件的注册 
type 
  TIEClassFac=class(TComObjectFactory) // 
  public 
     procedure UpdateRegistry(Register: Boolean); override; 
  end; 

procedure TIEClassFac.UpdateRegistry(Register: Boolean); 
var 
 ClassID: string; 
 a:Integer; 
begin 
  inherited UpdateRegistry(Register); 
  if Register then begin 
    ClassID:=GUIDToString(Class_GetMailBand); 
    with TRegistry.Create do
      try 
        //添加附加的注册表项 
        RootKey:=HKEY_LOCAL_MACHINE; 
        OpenKey('\SOFTWARE\Microsoft\Internet Explorer\Toolbar',False); 
        a:=0; 
        WriteBinaryData(GUIDToString(Class_GetMailBand),a,0); 
        OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved',True); 
        WriteString (GUIDToString(Class_GetMailBand),EB_CLASS_NAME); 
        RootKey:=HKEY_CLASSES_ROOT; 
        OpenKey('\CLSID\'+GUIDToString(Class_GetMailBand),False);
        WriteString('',EB_CLASS_NAME); 
      finally 
        Free; 
      end; 
  end 
  else begin
     with TRegistry.Create do 
     try 
        RootKey:=HKEY_LOCAL_MACHINE; 
        OpenKey('\SOFTWARE\Microsoft\Internet Explorer\Toolbar',False); 
        DeleteValue(GUIDToString(Class_GetMailBand)); 
        OpenKey('\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved',False); 
        DeleteValue(GUIDToString(Class_GetMailBand));
     finally 
        Free; 
     end; 
  end; 
end; 

initialization 
  TIEClassFac.Create(ComServer, TGetMailBand, Class_GetMailBand,
     '图文快存', '', ciMultiInstance, tmApartment);
end. 

