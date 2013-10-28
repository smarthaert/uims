//***********************************************************
//               IEDownloadManager  (Oct 15, 2001)          *
//                                                          *
//                         ver. 1.0                         *
//                                                          *
//                       For Delphi 5 & 6                   *
//                                                          *
//                            by                            *
//                     Per Lindsø Larsen                    *
//                   per.lindsoe@larsen.mail.dk             *
//                                                          *
//                                                          *
//                                                          *
//        Updated versions:                                 *
//                                                          *
//               http://www.euromind.com/iedelphi           *
//***********************************************************

unit IEDownloadMgr;

interface

uses
  IEConst, Windows, Messages, SysUtils, Classes,activex,urlmon, wininet,DownloadForm_u;

type

  TIEDownloadMgr = class(TComponent, {$IFNDEF VER140} IUnknown, {$ENDIF} IDownloadManager)
  private
    { Private declarations }
   DownloadForm : TDownloadForm;
  protected
    { Protected declarations }
    function Download(
      pmk: IMoniker; // Identifies the object to be downloaded
      pbc: IBindCtx; // Stores information used by the moniker to bind
      dwBindVerb: DWORD; // The action to be performed during the bind
      grfBINDF: DWORD; // Determines the use of URL encoding during the bind
      pBindInfo: PBindInfo; // Used to implement IBindStatusCallback::GetBindInfo
      pszHeaders: PWidechar; // Additional headers to use with IHttpNegotiate
      pszRedir: PWidechar; // The URL that the moniker is redirected to
      uiCP: UINT // The code page of the object's display name
      ): HRESULT; stdcall;
  public
    { Public declarations }

  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TIEDownloadMgr]);
end;

{ TIEDownloadMgr }

function TIEDownloadMgr.Download(pmk: IMoniker; pbc: IBindCtx; dwBindVerb,
  grfBINDF: DWORD; pBindInfo: PBindInfo; pszHeaders, pszRedir: PWidechar;
  uiCP: UINT): HRESULT;
var
  Url: PWidechar;
begin
  if DownloadForm = nil then Downloadform := TDownloadform.Create(nil);
  Downloadform.show;
  pmk.GetDisplayName(pbc, nil, Url);
  Downloadform.Download(Url);
  Result:=S_OK;
end;
end.
