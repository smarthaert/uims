//***********************************************************
//        Import Favorites ver D2005 (oct. 20 , 2005)       *
//                                                          *
//               For Delphi 5,6, 7 , 2005, 2006             *
//                     Freeware Component                   *
//                            by                            *
//                     Eran Bodankin (bsalsa)               *
//                     bsalsa@bsalsa.no-ip.info             *
//                                                          *
//           Based on idea's by:  Troels Jakobsen           *
//           that gave me the rights to use his idea's      *
//                                                          *
//     Documentation and updated versions:                  *
//     http://groups.yahoo.com/group/delphi-webbrowser/     *
//***********************************************************
unit ImportFavorites;

interface
uses
  Windows, SysUtils, Classes, Dialogs, IniFiles, Registry;

type
    PUrlRec = ^TUrlRec;
    TUrlRec = record
    Rep:     String;
    UrlName: String;
    UrlPath: String;        
    Level: Integer;
  end;

type
  TImportFavorite = class(TComponent)
  private
    fCurrentFileName: string;
    fCurrentFilePath: string;
    fTargetSubFolder: string;
    fFavoritesPath: string;
    FSuccessMessage: TStrings;
    FShowSuccessMessage: Boolean;
    BookmarkList: TStringList;
    L: TList;
    TargetFolder: String;
    LvlList: TStringList;
    procedure GetFavoritesFolder(var Folder: String);
    procedure Convert(Folder: String);
    procedure ScanBmkLine(I: Integer; Lvl: Integer);
    function FindFolder(HtmlStr: String; var Lvl: Integer): Boolean;
    function FindUrl(HtmlStr: String; Lvl: Integer): Boolean;
    function FindSectionEnd(HtmlStr: String; var Lvl: Integer): Boolean;
    procedure MakeFavorites;
    function MakeFolder(Folder: String): Boolean;
    function MakeUrlFile(UrlName, UrlPath: String): Boolean;
    procedure ReplaceIllChars(var S: String);
    procedure SetSuccessMessage(Value: TStrings);
  protected

  public
    SuccessFlag : Boolean;
    NavigatePath: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImportFavorites;
  published
    property CurrentFileName: string read fCurrentFileName write fCurrentFileName;
    property CurrentFilePath: string read fCurrentFilePath write fCurrentFilePath;
    property TargetSubFolder: string read fTargetSubFolder write fTargetSubFolder;
    property FavoritesPath: string read fFavoritesPath write fFavoritesPath;
    property ShowSuccessMessage: Boolean read fShowSuccessMessage write fShowSuccessMessage;
    property SuccessMessage: TStrings read fSuccessMessage write SetSuccessMessage;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TImportFavorite]);
end;

constructor TImportFavorite.Create;
begin
    fCurrentFileName:= 'newbook.htm';
    fCurrentFilePath:= 'C:\';
    fTargetSubFolder:= 'Imported Bookmarks';
    fFavoritesPath  := 'Auto';
    fSuccessMessage := TStringList.Create;
    fSuccessMessage.Add('Your favorites have been imported successfully!');
    fSuccessMessage.Text:='Your favorites have been imported to successfully!';
    fShowSuccessMessage := true;
    SuccessFlag := false;
    inherited;
end;

destructor TImportFavorite.Destroy;
begin
  fSuccessMessage.Free;
  inherited Destroy;
end;

procedure TImportFavorite.SetSuccessMessage(Value: TStrings);
begin
  fSuccessMessage.Assign(Value)
end;

procedure TImportFavorite.GetFavoritesFolder(var Folder: String);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  Registry.RootKey := HKEY_CURRENT_USER;
  Registry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False);
  Folder := Registry.ReadString('Favorites');
  Registry.Free;
end;

function SortFunction(Item1, Item2: Pointer): Integer;
var
  Rec1, Rec2: PUrlRec;
begin
  Result := 0;
  Rec1 := Item1;
  Rec2 := Item2;
  if Rec1.Rep < Rec2.Rep then Result := -1;
  if Rec1.Rep > Rec2.Rep then Result := 1;
  if Rec1.Rep = Rec2.Rep then
  begin
    if Rec1.UrlName < Rec2.UrlName then Result := -1;
    if Rec1.UrlName > Rec2.UrlName then Result := 1;
    if Rec1.UrlName = Rec2.UrlName then Result := 0;
  end;
end;

procedure TImportFavorite.Convert(Folder: String);
var
  I: Integer;
begin
  L := TList.Create;
  LvlList := TStringList.Create;
  LvlList.Add('');
  try
    ScanBmkLine(0, 0);
  finally
    L.Sort(SortFunction);
    MakeFavorites;
  for I := 0 to L.Count -1 do
      Dispose(PUrlRec(L[I]));
    L.Free;
    LvlList.Free;
  end;
end;

procedure TImportFavorite.ScanBmkLine(I: Integer; Lvl: Integer);
begin
  if I < BookmarkList.Count -1 then
  begin
    if not FindSectionEnd(BookmarkList[I], Lvl) then
      if not FindUrl(BookmarkList[I], Lvl) then
        FindFolder(BookmarkList[I], Lvl);
    ScanBmkLine(I+1, Lvl);
  end;
end;

function TImportFavorite.FindFolder(HtmlStr: String; var Lvl: Integer): Boolean;
const
  FolderSubStr: String = '<H3';
var
  J, Idx: Integer;
  S: array[0..255] of Char;
  UrlRec: PUrlRec;
  I: Integer;
  Folder: String;
  FName: String;
begin
  J := Pos(FolderSubStr, HtmlStr);
  Result := (J <> 0);
  if J <> 0 then
  begin
    Inc(Lvl);
    FillChar(S, SizeOf(S), 0);
    Idx := 1;
    for J := 1 to Length(HtmlStr)-1 do
      if HtmlStr[J] = '>' then
        Idx := J+1;
    for J := Idx to Length(HtmlStr)-5 do
      S[J-Idx] := HtmlStr[J];

    Folder := S;
    ReplaceIllChars(Folder);
    if LvlList.Count > Lvl then
      LvlList[Lvl] := Folder
    else
      LvlList.Add(Folder);
    FName := LvlList[Lvl];
    for I := Lvl-1 downto 1 do
      FName := LvlList[I] + '\' + FName;
    UrlRec := New(PUrlRec);
    UrlRec.Rep := FName;
    UrlRec.UrlName := '';
    UrlRec.UrlPath := '';
    UrlRec.Level := Lvl;
    L.Add(UrlRec);
  end;
end;  

function TImportFavorite.FindUrl(HtmlStr: String; Lvl: Integer): Boolean;
const
  UrlSubStr: String = 'http://';
var
  J, K: Integer;
  S1, S2, S3: array[0..255] of Char;
  Apo1, Apo2: PChar;
  I: Integer;
  SPath, SName: String;
  FName: String;
  UrlRec: PUrlRec;
begin
  J := Pos(UrlSubStr, HtmlStr);
  Result := (J <> 0);
  if J <> 0 then
  begin
    FillChar(S1, SizeOf(S1), 0);
    FillChar(S2, SizeOf(S2), 0);
    FillChar(S3, SizeOf(S3), 0);
    SPath := HtmlStr;
    Apo1 := StrScan(PChar(SPath), '"');
    for K := 1 to StrLen(Apo1) do
      S1[K-1] := Apo1[K];
    for K := 0 to Pos('"', S1) -2 do
      S2[K] := S1[K];
    SPath := S2;
    Apo2 := StrScan(Apo1, '>');
    for K := 1 to StrLen(Apo2) do
      S1[K-1] := Apo2[K];
    for K := 0 to Pos('<', S1) -2 do
      S3[K] := S1[K];
    SName := S3;
    ReplaceIllChars(SName);
    FName := LvlList[Lvl];
    for I := Lvl-1 downto 1 do
        FName := LvlList[I] + '\' + FName;
    UrlRec := New(PUrlRec);
    UrlRec.Rep := FName;
    UrlRec.UrlName:= SName;
    UrlRec.UrlPath := SPath;
    UrlRec.Level := Lvl;
    L.Add(UrlRec);
  end;
end;

function TImportFavorite.FindSectionEnd(HtmlStr: String; var Lvl: Integer): Boolean;
const
  EndSubStr: String = '</DL>';
var
  J: Integer;
begin
  J := Pos(EndSubStr, HtmlStr);
  Result := (J <> 0);
  if J <> 0 then
  begin
    Dec(Lvl);
  end;
end;

procedure TImportFavorite.MakeFavorites;
var
  I: Integer;
  UrlRec: PUrlRec;
begin
  for I := 0 to L.Count -1 do
  begin
    UrlRec := L[I];
    if UrlRec.UrlName = '' then
      MakeFolder(TargetFolder + '\' + UrlRec.Rep)
    else
      MakeUrlFile(TargetFolder + '\' + UrlRec.Rep + '\' + UrlRec.UrlName + '.url', UrlRec.UrlPath);
  end;
end; 

function TImportFavorite.MakeFolder(Folder: String): Boolean;
begin
 if CreateDirectory(PChar(Folder), nil) then result := true
 else result :=false;
end;

function TImportFavorite.MakeUrlFile(UrlName, UrlPath: String): Boolean;
var
  UrlFile: TIniFile;
begin
  UrlFile := TIniFile.Create(UrlName);
  UrlFile.WriteString('InternetShortcut', 'URL', UrlPath);
  UrlFile.Free;
  result:= true;
end;

procedure TImportFavorite.ReplaceIllChars(var S: String);
const
  ReplacedChar: Char = '-';
var
  I: Integer;
begin
  for I := 1 to Length(S) do
    if S[I] in ['\', '/', ':', '*', '?', '"', '<', '>', '|'] then
      S[I] := ReplacedChar;
end;

procedure TImportFavorite.ImportFavorites;
var
  R: TSearchRec;
  FavFolder: String;         
begin
  if fCurrentFilePath = '' then
    begin
      MessageDlg('The favorites file path is invalid.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
      exit;
    end;
  if fCurrentFileName = '' then
   begin
    MessageDlg('The Current file name is invalid.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    exit;
   end;
  if not (pos('htm', fCurrentFileName) >1) then
   begin
    MessageDlg('The target file name extention is invalid.'+#10+#13+'Please change it to "*.htm".', mtError, [MbOk], 0);
    exit;
   end;
    if fTargetSubFolder = '' then
   begin
    MessageDlg('You must a proper sub folder name.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    exit;
   end;
 if fSuccessMessage.Text = '' then
   begin
    MessageDlg('You must enter a message or turn off messages.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    exit;
   end;
 if not FileExists(fCurrentFilePath +'\'+ fCurrentFileName) then
  begin
    MessageDlg('The Favorite file you specified does not exist in the current path.', mtError, [MbOk], 0);
  end
  else
  begin
    BookmarkList := TStringList.Create;
    BookmarkList.LoadFromFile(fCurrentFilePath +'\'+ fCurrentFileName);

   if fFavoritesPath = 'Auto' then GetFavoritesFolder(FavFolder)
   else FavFolder := fFavoritesPath;
    if (FavFolder <> '') and (pos('Favorites', FavFolder) >1) then
    begin
      CreateDirectory(PChar(FavFolder+'\'+TargetSubFolder), nil);
      if FindFirst(FavFolder+'\'+TargetSubFolder, faDirectory, R) = 0 then
      begin
        TargetFolder := FavFolder+'\'+TargetSubFolder;
        Convert(FavFolder+'\'+TargetSubFolder);
        if fShowSuccessMessage then
        MessageDlg('The bookmarks have been imported into your favorites successfully!'+#10+#13+
        'You can find them in the favorite as a sub folder.', mtInformation, [MbOk], 0);
        SuccessFlag :=true;
      end
      else
      begin
        MessageDlg('The subfolder name you specified is invalid.', mtError, [MbOk], 0);
        SuccessFlag :=false;
      end;
      FindClose(R);
    end;
    BookmarkList.Free;
  end;
end;

end.
