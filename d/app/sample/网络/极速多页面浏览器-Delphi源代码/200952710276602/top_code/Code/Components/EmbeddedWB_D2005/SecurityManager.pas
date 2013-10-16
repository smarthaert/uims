//**************************************************************
//                                                             *
//             SecurityManager ver 2005 (oct 27, 2005)         *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006              *
//                     Freeware Component                      *
//                            by                               *
//                     Per Lindsø Larsen                       *
//                   per.lindsoe@larsen.dk                     *
//                                                             *
//  Contributions:                                             *
//  Eran Bodankin (bsalsa) bsalsa@bsalsa.no-ip.info            *
//         -  D2005 update                                     *
//                                                             *
//  Updated versions:                                          *
//  http://www.euromind.com/iedelphi                           *
//  http://groups.yahoo.com/group/delphi-webbrowser/           *
//**************************************************************

unit SecurityManager;

interface

uses
  Activex, UrlMon, Windows, SysUtils, Classes;
const
  DefaultActions: array[0..24] of DWORD = (
    $00001001, $00001004, $00001200, $00001201, $00001400, $00001402,
    $00001405, $00001406, $00001407, $00001601, $00001604, $00001605,
    $00001606, $00001607, $00001800, $00001802, $00001803, $00001804,
    $00001805, $00001A00, $00001A02, $00001A03, $00001A04, $00001C00,
    $00001E05);

  URLTEMPLATE_LOW = $10000;
  URLTEMPLATE_MEDLOW = $10500;
  URLTEMPLATE_MEDIUM = $11000;
  URLTEMPLATE_HIGH = $12000;
  URLACTION_MIN = $00001000;
  URLACTION_DOWNLOAD_MIN = $00001000;
  URLACTION_DOWNLOAD_SIGNED_ACTIVEX = $00001001;
  URLACTION_DOWNLOAD_UNSIGNED_ACTIVEX = $00001004;
  URLACTION_DOWNLOAD_CURR_MAX = $00001004;
  URLACTION_DOWNLOAD_MAX = $000011FF;
  URLACTION_ACTIVEX_MIN = $00001200;
  URLACTION_ACTIVEX_RUN = $00001200;
  URLACTION_ACTIVEX_OVERRIDE_OBJECT_SAFETY = $00001201; // aggregate next four
  URLACTION_ACTIVEX_OVERRIDE_DATA_SAFETY = $00001202; //
  URLACTION_ACTIVEX_OVERRIDE_SCRIPT_SAFETY = $00001203; //
  URLACTION_SCRIPT_OVERRIDE_SAFETY = $00001401; //
  URLACTION_ACTIVEX_CONFIRM_NOOBJECTSAFETY = $00001204; //
  URLACTION_ACTIVEX_TREATASUNTRUSTED = $00001205;
  URLACTION_ACTIVEX_CURR_MAX = $00001205;
  URLACTION_ACTIVEX_MAX = $000013FF;
  URLACTION_COOKIES = $00001A02;
  URLACTION_COOKIES_SESSION = $00001A03;
  URLACTION_SCRIPT_MIN = $00001400;
  URLACTION_SCRIPT_RUN = $00001400;
  URLACTION_SCRIPT_PASTE = $00001407;
  URLACTION_SCRIPT_JAVA_USE = $00001402;
  URLACTION_SCRIPT_SAFE_ACTIVEX = $00001405;
  URLACTION_CROSS_DOMAIN_DATA = $00001406;
  URLACTION_SCRIPT_CURR_MAX = $00001406;
  URLACTION_SCRIPT_MAX = $000015FF;
  URLACTION_HTML_MIN = $00001600;
  URLACTION_HTML_SUBMIT_FORMS = $00001601; // aggregate next two
  URLACTION_HTML_SUBMIT_FORMS_FROM = $00001602; //
  URLACTION_HTML_SUBMIT_FORMS_TO = $00001603; //
  URLACTION_HTML_SUBFRAME_NAVIGATE = $00001607;
  URLACTION_HTML_USERDATA_SAVE = $00001606;
  URLACTION_HTML_FONT_DOWNLOAD = $00001604;
  URLACTION_HTML_JAVA_RUN = $00001605; // derive from Java custom policy;
  URLACTION_HTML_CURR_MAX = $00001605;
  URLACTION_HTML_MAX = $000017FF;
  URLACTION_SHELL_MIN = $00001800;
  URLACTION_SHELL_INSTALL_DTITEMS = $00001800;
  URLACTION_SHELL_MOVE_OR_COPY = $00001802;
  URLACTION_SHELL_FILE_DOWNLOAD = $00001803;
  URLACTION_SHELL_VERB = $00001804;
  URLACTION_SHELL_WEBVIEW_VERB = $00001805;
  URLACTION_SHELL_CURR_MAX = $00001805;
  URLACTION_SHELL_MAX = $000019FF;
  URLACTION_NETWORK_MIN = $00001A00;
  URLACTION_CREDENTIALS_USE = $00001A00;
  URLACTION_AUTHENTICATE_CLIENT = $00001A01;
  URLACTION_CLIENT_CERT_PROMPT = $00001A04;
  URLACTION_NETWORK_CURR_MAX = $00001A04;
  URLACTION_NETWORK_MAX = $00001BFF;
  URLACTION_JAVA_MIN = $00001C00;
  URLACTION_JAVA_PERMISSIONS = $00001C00;
  URLACTION_JAVA_CURR_MAX = $00001C00;
  URLACTION_JAVA_MAX = $00001CFF;
  URLACTION_INFODELIVERY_MIN = $00001D00;
  URLACTION_INFODELIVERY_NO_ADDING_CHANNELS = $00001D00;
  URLACTION_INFODELIVERY_NO_EDITING_CHANNELS = $00001D01;
  URLACTION_INFODELIVERY_NO_REMOVING_CHANNELS = $00001D02;
  URLACTION_INFODELIVERY_NO_ADDING_SUBSCRIPTIONS = $00001D03;
  URLACTION_INFODELIVERY_NO_EDITING_SUBSCRIPTIONS = $00001D04;
  URLACTION_INFODELIVERY_NO_REMOVING_SUBSCRIPTIONS = $00001D05;
  URLACTION_INFODELIVERY_NO_CHANNEL_LOGGING = $00001D06;
  URLACTION_INFODELIVERY_CURR_MAX = $00001D06;
  URLACTION_INFODELIVERY_MAX = $00001DFF;
  URLACTION_CHANNEL_SOFTDIST_MIN = $00001E00;
  URLACTION_CHANNEL_SOFTDIST_PERMISSIONS = $00001E05;
  URLACTION_CHANNEL_SOFTDIST_MAX = $00001EFF;
  URLPOLICY_ACTIVEX_CHECK_LIST = $00010000;
  URLPOLICY_CREDENTIALS_SILENT_LOGON_OK = $00000000;
  URLPOLICY_CREDENTIALS_MUST_PROMPT_USER = $00010000;
  URLPOLICY_CREDENTIALS_CONDITIONAL_PROMPT = $00020000;
  URLPOLICY_CREDENTIALS_ANONYMOUS_ONLY = $00030000;
  URLPOLICY_AUTHENTICATE_CLEARTEXT_OK = $00000000;
  URLPOLICY_AUTHENTICATE_CHALLENGE_RESPONSE = $00010000;
  URLPOLICY_AUTHENTICATE_MUTUAL_ONLY = $00030000;
  URLPOLICY_JAVA_PROHIBIT = $00000000;
  URLPOLICY_JAVA_HIGH = $00010000;
  URLPOLICY_JAVA_MEDIUM = $00020000;
  URLPOLICY_JAVA_LOW = $00030000;
  URLPOLICY_JAVA_CUSTOM = $00800000;
  URLPOLICY_CHANNEL_SOFTDIST_PROHIBIT = $00010000;
  URLPOLICY_CHANNEL_SOFTDIST_PRECACHE = $00020000;
  URLPOLICY_CHANNEL_SOFTDIST_AUTOINSTALL = $00030000;
// For each action specified above the system maintains
// a set of policies for the action.
// The only policies supported currently are permissions (i.e. is something allowed)
// and logging status.
// IMPORTANT: If you are defining your own policies don't overload the meaning of the
// loword of the policy. You can use the hiword to store any policy bits which are only
// meaningful to your action.
// For an example of how to do this look at the URLPOLICY_JAVA above

  URLPOLICY_ALLOW = $00;
  URLPOLICY_QUERY = $01;
  URLPOLICY_DISALLOW = $03;
// Notifications are not done when user already queried.
  URLPOLICY_NOTIFY_ON_ALLOW = $10;
  URLPOLICY_NOTIFY_ON_DISALLOW = $20;
// Logging is done regardless of whether user was queried.
  URLPOLICY_LOG_ON_ALLOW = $40;
  URLPOLICY_LOG_ON_DISALLOW = $80;
  URLPOLICY_MASK_PERMISSIONS = $0F;

type
  TJavaPolicyOption = (Prohibited, High, Medium, Low, Custom);
  TAllowDisAllowPolicyOption = (Allow, Disallow);

const
  JavaPolicyValues: array[0..4] of Cardinal =
  (URLPOLICY_JAVA_PROHIBIT,
    URLPOLICY_JAVA_HIGH,
    URLPOLICY_JAVA_MEDIUM,
    URLPOLICY_JAVA_LOW,
    URLPOLICY_JAVA_CUSTOM);
  AllowDisallowValues: array[0..1] of Cardinal = (URLPOLICY_ALLOW, URLPOLICY_DISALLOW);

type
  TActiveXOptions = TAllowDisAllowPolicyOption;
  TJavaPermissionsOptions = TJavaPolicyOption;
  TScriptOptions = TAllowDisallowPolicyOption;
  TSubmitFormsOptions = TAllowDisallowPolicyOption;
  TCrossDomainDataOptions = TAllowDisallowPolicyOption;

  TUrlPolicyOptions = class(TPersistent)
  private
    FActiveX: TActiveXOptions;
    FCrossDomainData: TCrossDomainDataOptions;
    FJavaPermissions: TJavaPermissionsOptions;
    FSubmitForms: TSubmitFormsOptions;
    FScriptOptions: TScriptOptions;
  published
    property ActiveX: TActiveXOptions read FActiveX write FActiveX;
    property CrossDomainData: TCrossDomainDataOptions read FCrossDomainData write FCrossDomainData;
    property SubmitForms: TSubmitFormsOptions read FSubmitForms write FSubmitForms;
    property JavaPermissions: TJavaPermissionsOptions read FJavaPermissions write FJavaPermissions;
    property Scripts: TScriptOptions read FScriptOptions write FScriptOptions;
  end;
  TSetSecuritySiteEvent = function(Site: IInternetSecurityMgrSite): HResult of object;
  TGetSecuritySiteEvent = function(out Site: IInternetSecurityMgrSite): HResult of object;
  TMapUrlToZoneEvent = function(pwszUrl: LPCWSTR; out dwZone: DWORD;
    dwFlags: DWORD): HResult of object;
  TGetSecurityIdEvent = function(pwszUrl: LPCWSTR; pbSecurityId: Pointer;
    var cbSecurityId: DWORD; dwReserved: DWORD): HResult of object;
  TProcessUrlActionEvent = function(pwszUrl: LPCWSTR; dwAction: DWORD;
    pPolicy: Pointer; cbPolicy: DWORD; pContext: Pointer; cbContext: DWORD;
    dwFlags, dwReserved: DWORD): HResult of object;
  TQueryCustomPolicyEvent = function(pwszUrl: LPCWSTR; const guidKey: TGUID;
    out pPolicy: Pointer; out cbPolicy: DWORD; pContext: Pointer; cbContext: DWORD;
    dwReserved: DWORD): HResult of object;
  TSetZoneMappingEvent = function(dwZone: DWORD; lpszPattern: LPCWSTR;
    dwFlags: DWORD): HResult of object;
  TGetZoneMappingsEvent = function(dwZone: DWORD; out enumString: IEnumString;
    dwFlags: DWORD): HResult of object;
  TSecurityManager = class(TComponent, IInternetSecurityManager)
  private
    { Private declarations }
    FSetSecuritySite: TSetSecuritySiteEvent;
    FGetSecuritySite: TGetSecuritySiteEvent;
    FMapUrlToZone: TMapUrlToZoneEvent;
    FGetSecurityID: TGetSecurityIDEvent;
    FProcessUrlAction: TProcessUrlActionEvent;
    FQueryCustomPolicy: TQueryCustomPolicyEvent;
    FSetZoneMapping: TSetZoneMappingEvent;
    FGetZoneMappings: TGetZoneMappingsEvent;
    FUrlPolicyOptions: TUrlPolicyOptions;
  protected
    { Protected declarations }
  public
    { Public declarations }
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    function SetSecuritySite(Site: IInternetSecurityMgrSite): HResult; stdcall;
    function GetSecuritySite(out Site: IInternetSecurityMgrSite): HResult; stdcall;
    function MapUrlToZone(pwszUrl: LPCWSTR; out dwZone: DWORD;
      dwFlags: DWORD): HResult; stdcall;
    function GetSecurityId(pwszUrl: LPCWSTR; pbSecurityId: Pointer;
      var cbSecurityId: DWORD; dwReserved: DWORD): HResult; stdcall;
    function ProcessUrlAction(pwszUrl: LPCWSTR; dwAction: DWORD;
      pPolicy: Pointer; cbPolicy: DWORD; pContext: Pointer; cbContext: DWORD;
      dwFlags, dwReserved: DWORD): HResult; stdcall;
    function QueryCustomPolicy(pwszUrl: LPCWSTR; const guidKey: TGUID;
      out pPolicy: Pointer; out cbPolicy: DWORD; pContext: Pointer; cbContext: DWORD;
      dwReserved: DWORD): HResult; stdcall;
    function SetZoneMapping(dwZone: DWORD; lpszPattern: LPCWSTR;
      dwFlags: DWORD): HResult; stdcall;
    function GetZoneMappings(dwZone: DWORD; out enumString: IEnumString;
      dwFlags: DWORD): HResult; stdcall;
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }
    property OnSetSecuritySite: TSetSecuritySiteEvent read FSetSecuritySite write FSetSecuritySite;
    property OnGetSecuritySite: TGetSecuritySiteEvent read FGetSecuritySite write FGetSecuritySite;
    property OnMapUrlToZone: TMapUrlToZoneEvent read FMapUrlToZone write FMapUrlToZone;
    property OnGetSecurityID: TGetSecurityIDEvent read FGetSecurityID write FGetSecurityID;
    property OnProcessUrlAction: TProcessUrlActionEvent read FProcessUrlAction write FProcessUrlAction;
    property OnQueryCustomPolicy: TQueryCustomPolicyEvent read FQueryCustomPolicy write FQueryCustomPolicy;
    property OnSetZoneMapping: TSetZoneMappingEvent read FSetZoneMapping write FSetZoneMapping;
    property OnGetZoneMappings: TGetZoneMappingsEvent read FGetZoneMappings write FGetZoneMappings;
    property UrlPolicy: TUrlPolicyOptions read FUrlPolicyOptions write FUrlPolicyOptions;
  end;

function DisplayAction(UrlAction: DWORD): string;
function DisplayPolicy(UrlAction, UrlPolicy: DWORD): string;

procedure Register;

implementation

// Helper/debug function

function DisplayPolicy(UrlAction, UrlPolicy: DWORD): string;
begin
  case UrlPolicy of
    URLPOLICY_ALLOW: result := 'URLPOLICY_ALLOW';
    URLPOLICY_DISALLOW: result := 'URLPOLICY_DISALLOW';
    URLPOLICY_QUERY: result := 'URLPOLICY_QUERY';
    URLPOLICY_ACTIVEX_CHECK_LIST: result := 'URLPOLICY_ACTIVEX_CHECK_LIST';
    URLPOLICY_MASK_PERMISSIONS: result := 'URLPOLICY_MASK_PERMISSIONS';
    URLPOLICY_LOG_ON_DISALLOW: result := 'URLPOLICY_LOG_ON_DISALLOW';
    URLPOLICY_LOG_ON_ALLOW: result := 'URLPOLICY_LOG_ON_ALLOW';
    URLPOLICY_NOTIFY_ON_DISALLOW: result := 'URLPOLICY_NOTIFY_ON_DISALLOW';
    URLPOLICY_NOTIFY_ON_ALLOW: result := 'URLPOLICY_NOTIFY_ON_ALLOW';
  end;
  if UrlAction = URLACTION_CREDENTIALS_USE then begin
    if UrlPolicy = URLPOLICY_CREDENTIALS_ANONYMOUS_ONLY then result := 'URLPOLICY_CREDENTIALS_ANONYMOUS_ONLY' else
      if UrlPolicy = URLPOLICY_CREDENTIALS_CONDITIONAL_PROMPT then result := 'URLPOLICY_CREDENTIALS_CONDITIONAL_PROMPT' else
        if UrlPolicy = URLPOLICY_CREDENTIALS_MUST_PROMPT_USER then result := 'URLPOLICY_CREDENTIALS_MUST_PROMPT_USER' else
          if UrlPolicy = URLPOLICY_CREDENTIALS_SILENT_LOGON_OK then result := 'URLPOLICY_CREDENTIALS_SILENT_LOGON_OK';
  end else
    if UrlAction = URLACTION_CHANNEL_SOFTDIST_PERMISSIONS then begin
      if UrlPolicy = URLPOLICY_CHANNEL_SOFTDIST_AUTOINSTALL then result := 'URLPOLICY_CHANNEL_SOFTDIST_AUTOINSTALL' else
        if UrlPolicy = URLPOLICY_CHANNEL_SOFTDIST_PRECACHE then result := 'URLPOLICY_CHANNEL_SOFTDIST_PRECACHE' else
          if UrlPolicy = URLPOLICY_CHANNEL_SOFTDIST_PROHIBIT then result := 'URLPOLICY_CHANNEL_SOFTDIST_PROHIBIT' else
    end else
      if UrlAction = URLACTION_JAVA_PERMISSIONS then begin
        if UrlPolicy = URLPOLICY_JAVA_CUSTOM then result := 'URLPOLICY_JAVA_CUSTOM' else
          if UrlPolicy = URLPOLICY_JAVA_MEDIUM then result := 'URLPOLICY_JAVA_MEDIUM' else
            if UrlPolicy = URLPOLICY_JAVA_LOW then result := 'URLPOLICY_JAVA_LOW' else
              if UrlPolicy = URLPOLICY_JAVA_HIGH then result := 'URLPOLICY_JAVA_HIGH' else
                if UrlPolicy = URLPOLICY_JAVA_PROHIBIT then result := 'URLPOLICY_JAVA_PROHIBIT';
      end;
end;


// Helper/debug function

function DisplayAction(UrlAction: DWORD): string;
begin
  case
    UrlAction of
    URLACTION_DOWNLOAD_SIGNED_ACTIVEX: result := 'URLACTION_DOWNLOAD_SIGNED_ACTIVEX';
    URLACTION_DOWNLOAD_UNSIGNED_ACTIVEX: result := 'URLACTION_DOWNLOAD_UNSIGNED_ACTIVEX';
    URLACTION_ACTIVEX_RUN: result := 'URLACTION_ACTIVEX_RUN';
    URLACTION_ACTIVEX_OVERRIDE_OBJECT_SAFETY: result := 'URLACTION_ACTIVEX_OVERRIDE_OBJECT_SAFETY';
    URLACTION_ACTIVEX_OVERRIDE_DATA_SAFETY: result := 'URLACTION_ACTIVEX_OVERRIDE_DATA_SAFETY';
    URLACTION_ACTIVEX_OVERRIDE_SCRIPT_SAFETY: result := 'URLACTION_ACTIVEX_OVERRIDE_SCRIPT_SAFETY';
    URLACTION_SCRIPT_OVERRIDE_SAFETY: result := 'URLACTION_SCRIPT_OVERRIDE_SAFETY';
    URLACTION_ACTIVEX_CONFIRM_NOOBJECTSAFETY: result := 'URLACTION_ACTIVEX_CONFIRM_NOOBJECTSAFETY';
    URLACTION_ACTIVEX_TREATASUNTRUSTED: result := 'URLACTION_ACTIVEX_TREATASUNTRUSTED';
    URLACTION_CROSS_DOMAIN_DATA: result := 'URLACTION_CROSS_DOMAIN_DATA';
    URLACTION_HTML_SUBFRAME_NAVIGATE: result := 'URLACTION_HTML_SUBFRAME_NAVIGATE';
    URLACTION_HTML_USERDATA_SAVE: result := 'URLACTION_HTML_USERDATA_SAVE';
    URLACTION_COOKIES: result := 'URLACTION_COOKIES';
    URLACTION_COOKIES_SESSION: result := 'URLACTION_COOKIES_SESSION';
    URLACTION_SCRIPT_PASTE: result := 'URLACTION_SCRIPT_PASTE';
    URLACTION_SCRIPT_RUN: result := 'URLACTION_SCRIPT_RUN';
    URLACTION_SCRIPT_JAVA_USE: result := 'URLACTION_SCRIPT_JAVA_USE';
    URLACTION_SCRIPT_SAFE_ACTIVEX: result := 'URLACTION_SCRIPT_SAFE_ACTIVEX';
    URLACTION_HTML_SUBMIT_FORMS: result := 'URLACTION_HTML_SUBMIT_FORMS';
    URLACTION_HTML_SUBMIT_FORMS_FROM: result := 'URLACTION_HTML_SUBMIT_FORMS_FROM';
    URLACTION_HTML_SUBMIT_FORMS_TO: result := 'URLACTION_HTML_SUBMIT_FORMS_TO';
    URLACTION_HTML_FONT_DOWNLOAD: result := 'URLACTION_HTML_FONT_DOWNLOAD';
    URLACTION_HTML_JAVA_RUN: result := 'URLACTION_HTML_JAVA_RUN';
    URLACTION_SHELL_INSTALL_DTITEMS: result := 'URLACTION_SHELL_INSTALL_DTITEMS';
    URLACTION_SHELL_MOVE_OR_COPY: result := 'URLACTION_SHELL_MOVE_OR_COPY';
    URLACTION_SHELL_FILE_DOWNLOAD: result := 'URLACTION_SHELL_FILE_DOWNLOAD';
    URLACTION_SHELL_VERB: result := 'URLACTION_SHELL_VERB';
    URLACTION_SHELL_WEBVIEW_VERB: result := 'URLACTION_SHELL_WEBVIEW_VERB';
    URLACTION_CREDENTIALS_USE: result := 'URLACTION_CREDENTIALS_USE';
    URLACTION_CLIENT_CERT_PROMPT: result := 'URLACTION_CLIENT_CERT_PROMPT';
    URLACTION_AUTHENTICATE_CLIENT: result := 'URLACTION_AU:TICATE_CLIENT';
    URLACTION_JAVA_PERMISSIONS: result := 'URLACTION_JAVA_PERMISSIONS';
    URLACTION_INFODELIVERY_NO_ADDING_CHANNELS: result := 'URLACTION_INFODELIVERY_NO_ADDING_CHANNELS';
    URLACTION_INFODELIVERY_NO_EDITING_CHANNELS: result := 'URLACTION_INFODELIVERY_NO_EDITING_CHANNELS';
    URLACTION_INFODELIVERY_NO_REMOVING_CHANNELS: result := 'URLACTION_INFODELIVERY_NO_REMOVING_CHANNELS';
    URLACTION_INFODELIVERY_NO_ADDING_SUBSCRIPTIONS: result := 'URLACTION_INFODELIVERY_NO_ADDING_SUBSCRIPTIONS';
    URLACTION_INFODELIVERY_NO_EDITING_SUBSCRIPTIONS: result := 'URLACTION_INFODELIVERY_NO_EDITING_SUBSCRIPTIONS';
    URLACTION_INFODELIVERY_NO_REMOVING_SUBSCRIPTIONS: result := 'URLACTION_INFODELIVERY_NO_REMOVING_SUBSCRIPTIONS';
    URLACTION_INFODELIVERY_NO_CHANNEL_LOGGING: result := 'URLACTION_INFODELIVERY_NO_CHANNEL_LOGGING';
    URLACTION_CHANNEL_SOFTDIST_PERMISSIONS: result := 'URLACTION_CHANNEL_SOFTDIST_PERMISSIONS';
  end;
end;


procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TSecurityManager]);
end;

{ TSecurityManager }

constructor TSecurityManager.Create(Owner: TComponent);
begin
  inherited;
  FUrlPolicyOptions := TUrlPolicyOptions.Create;
end;

destructor TSecurityManager.Destroy;
begin
  FUrlPolicyOptions.Free;
  inherited;
end;

function TSecurityManager.GetSecurityId(pwszUrl: LPCWSTR;
  pbSecurityId: Pointer; var cbSecurityId: DWORD;
  dwReserved: DWORD): HResult;
begin
  if Assigned(FGetSecurityID) then
    Result := FGetSecurityID(pwszUrl, pbSecurityID, cbSecurityID, dwReserved) else
    Result := INET_E_DEFAULT_ACTION;
end;

function TSecurityManager.GetSecuritySite(
  out Site: IInternetSecurityMgrSite): HResult;
begin
  if Assigned(FGetSecuritySite) then
    Result := FGetSecuritySite(site) else
    Result := INET_E_DEFAULT_ACTION;
end;

function TSecurityManager.GetZoneMappings(dwZone: DWORD;
  out enumString: IEnumString; dwFlags: DWORD): HResult;
begin
  if Assigned(FGetZoneMappings) then
    result := FGetZoneMappings(dwZone, enumString, dwFlags) else
    Result := INET_E_DEFAULT_ACTION;
end;

function TSecurityManager.MapUrlToZone(pwszUrl: LPCWSTR; out dwZone: DWORD;
  dwFlags: DWORD): HResult;
begin
  if Assigned(FMapUrlToZone) then
    Result := FMapUrlToZone(pwszUrl, dwZone, dwFlags) else
    Result := INET_E_DEFAULT_ACTION;
end;

function TSecurityManager.ProcessUrlAction(pwszUrl: LPCWSTR;
  dwAction: DWORD; pPolicy: Pointer; cbPolicy: DWORD; pContext: Pointer;
  cbContext, dwFlags, dwReserved: DWORD): HResult;
var
  dwPolicy: DWORD;
begin
  if Assigned(FProcessUrlAction) then
    Result := FProcessUrlAction(pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved) else
  begin
    Result := S_FALSE;
    dwPolicy := URLPOLICY_ALLOW;
    if (dwAction <= URLACTION_ACTIVEX_MAX) and (dwAction >= URLACTION_ACTIVEX_MIN)
      then
      dwPolicy := AllowDisallowValues[Ord(FUrlPolicyOptions.FActiveX)] else

      if ((dwAction <= URLACTION_JAVA_MAX) and (dwAction >= URLACTION_JAVA_MIN)) or
        (dwAction = URLACTION_HTML_JAVA_RUN) then
        dwPolicy := JavaPolicyValues[Ord(FUrlPolicyOptions.FJavaPermissions)] else

        if ((dwAction = URLACTION_HTML_SUBMIT_FORMS_TO) or (dwAction = URLACTION_HTML_SUBMIT_FORMS_FROM)) then
          dwPolicy := AllowDisallowValues[Ord(FUrlPolicyOptions.FSubmitforms)] else

          if (dwAction = URLACTION_CROSS_DOMAIN_DATA) then
            dwPolicy := AllowDisallowValues[Ord(FUrlPolicyOptions.FCrossDomainData)] else

            if (dwAction <= URLACTION_SCRIPT_MAX) and (dwAction >= URLACTION_SCRIPT_MIN) then
              dwPolicy := AllowDisallowValues[Ord(FUrlPolicyOptions.FScriptOptions)] else

              Result := INET_E_DEFAULT_ACTION;
    if (Result = S_FALSE) and (cbPolicy >= SizeOf(DWORD)) then
    begin
      Dword(ppolicy^) := dwpolicy;
      Result := S_OK;
    end;
  end;
end;


function TSecurityManager.QueryCustomPolicy(pwszUrl: LPCWSTR;
  const guidKey: TGUID; out pPolicy: Pointer; out cbPolicy: DWORD;
  pContext: Pointer; cbContext, dwReserved: DWORD): HResult;
begin
  if Assigned(FQueryCustomPolicy) then
    Result := FQueryCustomPolicy(pwszUrl, guidKey, pPolicy, cbPolicy, pContext, cbContext, dwReserved) else
    Result := INET_E_DEFAULT_ACTION;
end;

function TSecurityManager.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  result := inherited Queryinterface(iid, obj);
end;

function TSecurityManager.SetSecuritySite(
  Site: IInternetSecurityMgrSite): HResult;
begin
  if Assigned(FSetSecuritySite) then
    Result := FSetSecuritySite(site) else
    Result := INET_E_DEFAULT_ACTION;
end;

function TSecurityManager.SetZoneMapping(dwZone: DWORD;
  lpszPattern: LPCWSTR; dwFlags: DWORD): HResult;
begin
  if Assigned(FSetZoneMapping) then
    Result := FSetZoneMapping(dwZone, lpszPattern, dwFlags) else
    Result := INET_E_DEFAULT_ACTION;
end;


end.

