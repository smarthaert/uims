//**************************************************************
//                                                             *
//             UrlHistory ver 2005 (oct 27, 2005)              *                                                      *
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


unit UrlHistory;

interface

uses
  Windows, SysUtils, Classes, Activex, Comobj;

const
  STATURL_QUERYFLAG_ISCACHED = $00010000;
  STATURL_QUERYFLAG_NOURL = $00020000;
  STATURL_QUERYFLAG_NOTITLE = $00040000;
  STATURL_QUERYFLAG_TOPLEVEL = $00080000;
  STATURLFLAG_ISCACHED = $00000001;
  STATURLFLAG_ISTOPLEVEL = $00000002;
  IID_IEnumStatUrl: TGUID = (D1: $3C374A42; D2: $BAE4; D3: $11CF; D4: ($BF, $7D, $00, $AA, $00, $69, $46, $EE));
  IID_IUrlHistoryStg: TGUID = (D1: $3C374A41; D2: $BAE4; D3: $11CF; D4: ($BF, $7D, $00, $AA, $00, $69, $46, $EE));
  IID_IUrlHistoryStg2: TGUID = (D1: $AFA0DC11; D2: $C313; D3: $831A; D4: ($83, $1A, $00, $C0, $4F, $D5, $AE, $38));
  IID_IUrlHistoryNotify: TGUID = (D1: $BC40BEC1; D2: $C493; D3: $11D0; D4: ($83, $1B, $00, $C0, $4F, $D5, $AE, $38));
  SID_IEnumStatUrl = '{3C374A42-BAE4-11CF-BF7D-00AA006946EE}';
  SID_IUrlHistoryStg = '{3C374A41-BAE4-11CF-BF7D-00AA006946EE}';
  SID_IUrlHistoryStg2 = '{AFA0DC11-C313-11d0-831A-00C04FD5AE38}';
  SID_IURLHistoryNotify = '{BC40BEC1-C493-11d0-831B-00C04FD5AE38}';
  CLSID_CUrlHistory: TGUID = '{3C374A40-BAE4-11CF-BF7D-00AA006946EE}';

type
  TSTATURL = record
    cbSize: DWORD;
    pwcsUrl: DWORD;
    pwcsTitle: DWORD;
    ftLastVisited: FILETIME;
    ftLastUpdated: FILETIME;
    ftExpires: FILETIME;
    dwFlags: DWORD;
  end;

  PEntry = ^TEntry;
  TEntry = record
    Url: string;
    Title: string;
    Lastvisited,
      LastUpdated,
      Expires: TDateTime;
  end;

  IEnumSTATURL = interface(IUnknown)
    ['{3C374A42-BAE4-11CF-BF7D-00AA006946EE}']
    function Next(celt: Integer; out elt; pceltFetched: PLongint): HRESULT; stdcall;
    function Skip(celt: Longint): HRESULT; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumSTATURL): HResult; stdcall;
    function SetFilter(poszFilter: PWideChar; dwFlags: DWORD): HResult; stdcall;
  end;

  IUrlHistoryStg = interface(IUnknown)
    ['{3C374A41-BAE4-11CF-BF7D-00AA006946EE}']
    function AddUrl(pocsUrl: PWideChar; pocsTitle: PWideChar; dwFlags: Integer): HResult; stdcall;
    function DeleteUrl(pocsUrl: PWideChar; dwFlags: Integer): HResult; stdcall;
    function QueryUrl(pocsUrl: PWideChar; dwFlags: Integer; var lpSTATURL: TSTATURL): HResult; stdcall;
    function BindToObject(pocsUrl: PWideChar; var riid: TIID; out ppvOut: Pointer): HResult; stdcall;
    function EnumUrls(out ppenum: IEnumSTATURL): HResult; stdcall;
  end;

  IUrlHistoryStg2 = interface(IUrlHistoryStg)
    ['{AFA0DC11-C313-11D0-831A-00C04FD5AE38}']
    function AddUrlAndNotify(pocsUrl: PWideChar; pocsTitle: PWideChar; dwFlags: Integer;
      fWriteHistory: Integer; var poctNotify: Pointer;
      const punkISFolder: IUnknown): HResult; stdcall;
    function ClearHistory: HResult; stdcall;
  end;

  IUrlHistoryNotify = interface(IOleCommandTarget)
    ['{BC40BEC1-C493-11d0-831B-00C04FD5AE38}']
  end;

  TSortDirectionOption = (sdAscending, sdDescending);
  TSortFieldOption = (sfTitle, sfURL, sfLastVisited, sfLastUpdated, sfExpires);
  TSearchFieldOption = (seBoth, seTitle, seURL);

type

  TOnAcceptEvent = Procedure(Title, Url : String; LastVisited, LastUpdated, Expires: TDateTime;
                                var Accept : Boolean) of object;

  TOnDeleteEvent = procedure(Title, Url : String; LastVisited, LastUpdated, Expires: TDateTime;
                                var Delete : Boolean) of object;

  TUrlHistory = class(TComponent)
  private
    { Private declarations }
    FSearch : String;
    FAccept : Boolean;
    FDelete : Boolean;
    FOnDelete : TOnDeleteEvent;
    FOnAccept : TOnAcceptEvent;
    FSortDirection: TSortDirectionOption;
    FSortField: TSortFieldOption;
    FSearchField: TSearchFieldOption;
    Stg: IUrlHistoryStg2;
    Enum: IEnumStatUrl;
  protected
    { Protected declarations }
    procedure ClearList;
    procedure Accept(Title, Url : String; LastVisited, LastUpdated, Expires: TDateTime;
                                var Accept : Boolean);
    procedure Delete(Title, Url : String; LastVisited, LastUpdated, Expires: TDateTime;
                                var Delete : Boolean);
    procedure Loaded; override;
  public
    Items: TList;
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enumerate: Integer;
    function DeleteEntries: Integer;
    function AddUrl(Url: PWideChar; Title: PWideChar): HResult;
    function DeleteUrl(Url: PWideChar): HResult;
    function QueryUrl(Url: PWideChar; var Entry: TEntry): HResult;
    function ClearHistory: HResult;

  published
    { Published declarations }
    property OnAccept : TOnAcceptEvent read FOnAccept write FOnAccept;
    property OnDelete : TOnDeleteEvent read FOnDelete write FOnDelete;
    property SortField: TSortFieldOption read FSortField write FSortField;
    property SearchField: TSearchFieldOption read FSearchField write FSearchField;
    property Search : String read FSearch write FSearch;
    property SortDirection: TSortDirectionOption read FSortDirection write FSortDirection;
  end;

procedure Register;

implementation

var
  Ascending: Boolean;

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TUrlHistory]);
end;

function TitleSortFunc(Item1, Item2: Pointer): Integer;
begin
  if ((PEntry(Item1).Title < PEntry(Item2).Title) and Ascending)
    or ((PEntry(Item1).Title > PEntry(Item2).Title) and not Ascending)
    then result := -1
  else
    if PEntry(Item1).Title = PEntry(Item2).Title then result := 0
    else Result := 1;
end;

function UrlSortFunc(Item1, Item2: Pointer): Integer;
begin
  if ((PEntry(Item1).Url < PEntry(Item2).Url) and Ascending)
    or ((PEntry(Item1).Url > PEntry(Item2).Url) and not Ascending)
    then result := -1
  else
    if PEntry(Item1).Url = PEntry(Item2).Url then result := 0
    else Result := 1;
end;

function LastVisitedSortFunc(Item1, Item2: Pointer): Integer;
begin
  if ((PEntry(Item1).LastVisited < PEntry(Item2).LastVisited) and Ascending)
    or ((PEntry(Item1).LastVisited > PEntry(Item2).LastVisited) and not Ascending)
    then result := -1
  else
    if PEntry(Item1).LastVisited = PEntry(Item2).LastVisited then result := 0
    else Result := 1;
end;

function LastUpdatedSortFunc(Item1, Item2: Pointer): Integer;
begin
  if ((PEntry(Item1).LastUpdated < PEntry(Item2).LastUpdated) and Ascending)
    or ((PEntry(Item1).LastUpdated > PEntry(Item2).LastUpdated) and not Ascending)
    then result := -1
  else
    if PEntry(Item1).LastUpdated = PEntry(Item2).LastUpdated then result := 0
    else Result := 1;
end;

function ExpiresSortFunc(Item1, Item2: Pointer): Integer;
begin
  if ((PEntry(Item1).Expires < PEntry(Item2).Expires) and Ascending)
    or ((PEntry(Item1).Expires > PEntry(Item2).Expires) and not Ascending)
    then result := -1
  else
    if PEntry(Item1).Expires = PEntry(Item2).Expires then result := 0
    else Result := 1;
end;

function FileTimeToDt(Ft: TFileTime): TDateTime;
var
  l: Integer;
  lft: TFileTime;
begin
  FileTimeToLocalFiletime(Ft, lft);
  if FileTimeToDosDateTime(lft, Longrec(l).Hi, Longrec(l).Lo) then
    result := FiledateToDatetime(l) else
    result := 0;
end;

{ TUrlHistory }

function TUrlHistory.AddUrl(Url, Title: PWideChar): HResult;
begin
  Result := Stg.AddUrl(Url, Title, 0);
end;

function TUrlHistory.ClearHistory: HResult;
begin
  Result:=Stg.ClearHistory;
end;

constructor TUrlHistory.Create(AOwner: TComponent);
begin
  inherited;
end;

function TUrlHistory.DeleteUrl(Url: PWideChar): HResult;
begin
  Result:=stg.DeleteUrl(Url, 0);
end;

procedure TUrlHistory.ClearList;
var
  I: Integer;
begin
  if Items <> nil then
  begin
    for I := 0 to Items.Count - 1 do
      Dispose(PEntry(Items[i]));
    items.Clear;
  end;
end;


function TUrlHistory.Enumerate: Integer;
var
  staturl: TStaturl;
  title, Url: string;
  Entry: PEntry;
  Fetched: Integer;
begin
  ClearList;
  Stg.EnumUrls(Enum);
  while enum.next(1, StatUrl, @Fetched) = S_OK do
  begin
Url:=PWidechar(Pointer(Staturl.pwcsUrl));
Title := PWidechar(Pointer(Staturl.pwcsTitle));
If FSearch<>'' then
If ((FSearchField=seUrl) and (Pos(FSearch,Url)=0)) or
((FSearchField=seTitle) and (Pos(FSearch,Title)=0)) or
((FSearchField=seBoth) and ((Pos(FSearch,Url)=0)) or (Pos(FSearch,Title)=0))
then Continue;
    Entry := New(PEntry);
    Entry.Url := Url;
    Entry.Title := Title;
    Entry.Lastvisited := FileTimeToDt(Staturl.ftLastVisited);
    Entry.LastUpdated := FileTimeToDt(Staturl.ftLastUpdated);
    Entry.Expires := FileTimeToDt(Staturl.ftExpires);
    FAccept:=True;
    If Assigned(FOnAccept) then FOnAccept(Entry.Title,Entry.Url,Entry.LastVisited,Entry.LastUpdated,Entry.Expires,FAccept);
    If FAccept then Items.Add(Entry);
  end;
  Ascending := BOOL(FSortDirection = sdAscending);
  case FSortField of
    sfTitle: items.Sort(TitleSortFunc);
    sfUrl: items.Sort(UrlSortFunc);
    sfLastVisited: items.Sort(LastVisitedSortFunc);
    sfLastUpdated: items.Sort(LastUpdatedSortFunc);
    sfExpires: items.Sort(ExpiresSortFunc);
  end;
  Result := Items.Count;
end;

procedure TUrlHistory.Loaded;
begin
  inherited;
  Items := TList.Create;
  Stg := CreateComObject(CLSID_CUrlHistory) as IUrlHistoryStg2;
end;


destructor TUrlHistory.Destroy;
begin
  Clearlist;
  if Items <> nil then Items.Free;
  inherited;
end;

procedure TUrlHistory.Accept(Title, Url: String; LastVisited, LastUpdated,
  Expires: TDateTime; var Accept: Boolean);
begin

end;

procedure TUrlHistory.Delete(Title, Url: String; LastVisited, LastUpdated,
  Expires: TDateTime; var Delete: Boolean);
begin

end;

function TUrlHistory.DeleteEntries: Integer;
var
StatUrl : TStatUrl;
Fetched : Integer;
begin
Result:=0;
  Stg.EnumUrls(Enum);
  while enum.next(1, StatUrl, @Fetched) = S_OK do
  begin
  FDelete := False;
  If Assigned(FOnDelete) then
  FOnDelete(PWidechar(Pointer(Staturl.pwcsUrl)),
    PWidechar(Pointer(Staturl.pwcsTitle)),
    FileTimeToDt(Staturl.ftLastVisited),
    FileTimeToDt(Staturl.ftLastUpdated),
    FileTimeToDt(Staturl.ftExpires),
    FDelete);
  If FDelete then
  begin
  Stg.DeleteUrl(PWidechar(Pointer(Staturl.pwcsUrl)),0);
  Inc(Result);
  end;
 end;
end;

function TUrlHistory.QueryUrl(Url: PWideChar; var Entry: TEntry): HResult;
var
Staturl : TStaturl;
begin
Result:=Stg.QueryUrl(Url,0,Staturl);
if Result=S_OK then begin
    Entry.Url := PWidechar(Pointer(Staturl.pwcsUrl));
    Entry.Title := PWidechar(Pointer(Staturl.pwcsTitle));
    Entry.Lastvisited := FileTimeToDt(Staturl.ftLastVisited);
    Entry.LastUpdated := FileTimeToDt(Staturl.ftLastUpdated);
    Entry.Expires := FileTimeToDt(Staturl.ftExpires);
   end;
end;

end.

