//***********************************************************
//        Export Favorites ver D2005 (oct. 20 , 2005)       *
//                                                          *
//                     For Delphi  7 , 2005                 *
//                     Freeware Component                   *
//                            by                            *
//                     Eran Bodankin (bsalsa)               *
//                                                          *
//       Based on a code by :  Troels Jakobsen              *
//                                                          *
//     Documentation and updated versions:                  *
//     http://groups.yahoo.com/group/delphi-webbrowser/     *
//***********************************************************
unit ExportFavorites;

interface
uses
  Classes,dialogs, IniFiles, ShellApi;

type
  PUrlRec = ^TUrlRec;
  TUrlRec = record
  Rep:     String;
  UrlName: String;
  UrlPath: String;
  Level  : Integer;
  end;

type
  TExportFavorite = class(TComponent)
  private
    fTargetFileName: string;
    fTargetPath: string;
    fFavoritesPath: string;
    fSuccessMessage: TStrings;
    fShowSuccessMessage: Boolean;
    FavFolder: String;
    FavList: TList;
    BmkList: TStringList;
    procedure GetFavoritesFolder;
    procedure SearchURL(Folder: String; Level: Integer);
    procedure MakeBookmarkFile;
    procedure TraverseFavList(Idx, PrevIdx: Integer);
    procedure SetSuccessMessage(Value: TStrings);
  protected
    procedure MakeDocumentTop;
    procedure MakeDocumentBottom;
    procedure MakeHeaderTop(UrlRec: PUrlRec);
    procedure MakeHeaderBottom(UrlRec: PUrlRec);
    procedure MakeBookmark(UrlRec: PUrlRec);
  public
    SuccessFlag : Boolean;
    NavigatePath: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExportFavorites;
  published

    property FavoritesPath: string read fFavoritesPath write fFavoritesPath;
    property TargetPath: string read fTargetPath write fTargetPath;
    property ShowSuccessMessage: Boolean read fShowSuccessMessage write fShowSuccessMessage;
    property TargetFileName: string read FTargetFileName write fTargetFileName;
    property SuccessMessage: TStrings read fSuccessMessage write SetSuccessMessage;
  end;

procedure Register;

implementation
uses Windows, SysUtils, MAPI, Registry, Forms;

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TExportFavorite]);
end;

constructor TExportFavorite.Create;
begin
  fFavoritesPath := 'Auto';
  fTargetPath := 'C:\';
  fTargetFileName := 'newbook.htm';
  fSuccessMessage := TStringList.Create;
  fSuccessMessage.Add('Your favorites have been exported successfully!');
  fSuccessMessage.Text:= 'Your favorites have been exported successfully!';
  fShowSuccessMessage := true;
  SuccessFlag := false;
  inherited;
end;

destructor TExportFavorite.Destroy;
begin
  fSuccessMessage.Free;
  inherited Destroy;
end;

procedure TExportFavorite.SetSuccessMessage(Value: TStrings);
begin
  fSuccessMessage.Assign(Value)
end;

procedure TExportFavorite.GetFavoritesFolder;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  Registry.RootKey := HKEY_CURRENT_USER;
  Registry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False);
  FavFolder := Registry.ReadString('Favorites');
  Registry.Free;
end;

procedure TExportFavorite.SearchURL(Folder: String; Level: Integer);
var
  Found: Integer;
  SearchRec: TSearchRec;
  UrlFile: TIniFile;
  UrlRec: PUrlRec;
begin
  Found := FindFirst(Folder+'\*.*', faAnyFile, SearchRec);
  while Found = 0 do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      if (SearchRec.Attr and faDirectory > 0) then
        begin
          if not (SearchRec.Attr and faSysFile > 0) then
          begin
            UrlRec := New(PUrlRec);
            UrlRec.Rep := Copy(Folder+'\'+SearchRec.Name, Length(FavFolder)+2, Length(Folder+'\'+SearchRec.Name));
            UrlRec.UrlName := '';
            UrlRec.UrlPath := '';
            UrlRec.Level := Level;
            FavList.Add(UrlRec);
          end;
          SearchURL(Folder+'\'+SearchRec.Name, Level+1);   // Recursion
        end
      else
        begin
          if UpperCase(ExtractFileExt(SearchRec.Name)) = '.URL' then
          begin
            UrlRec := New(PUrlRec);
            UrlRec.Rep := Copy(Folder, Length(FavFolder)+2, Length(Folder));
            UrlRec.UrlName:= Copy(SearchRec.Name, 0, Length(SearchRec.Name)-3);
            UrlFile := TIniFile.Create(Folder+'\'+SearchRec.Name);
            UrlRec.UrlPath := UrlFile.ReadString('InternetShortcut', 'URL', 'no path');
            UrlRec.Level := Level;
            UrlFile.Free;
            FavList.Add(UrlRec);
          end;
        end;
      Found := FindNext(SearchRec);
  end;
end;

procedure TExportFavorite.TraverseFavList(Idx, PrevIdx: Integer);
var
  UrlRec, PrevUrlRec: PUrlRec;
  X: Integer;
begin
  if Idx < FavList.Count then
  begin
    UrlRec := FavList[Idx];
    if PrevIdx = -1 then
      PrevUrlRec := nil
    else
      PrevUrlRec := FavList[PrevIdx];
   if UrlRec.UrlName = '' then
    begin
      if PrevUrlRec <> nil then
      begin
        X := PrevUrlRec.Level;
        while UrlRec.Level <= X do
        begin
          MakeHeaderBottom(PrevUrlRec);
          Dec(PrevUrlRec.Level);
          Dec(X);
        end;
      end;
      MakeHeaderTop(UrlRec);
      PrevIdx := Idx;
    end
    else
      MakeBookmark(UrlRec);
     TraverseFavList(Idx+1, PrevIdx);
  end;
end;

procedure TExportFavorite.MakeDocumentTop;
begin
  BmkList.Add('<!-- Made with ' + Application.Title + ' -->');
  BmkList.Add('');
  BmkList.Add('<TITLE>' + 'Exported Favorites' + '</TITLE>');
  BmkList.Add('<H1>' + 'Exported Favorites' + '</H1>');
  BmkList.Add('');
  BmkList.Add('<DL><P>');
end;

procedure TExportFavorite.MakeDocumentBottom;
begin
  BmkList.Add('');
  BmkList.Add('</DL><P>');
end; 

procedure TExportFavorite.MakeHeaderTop(UrlRec: PUrlRec);
var
  I, Idx: Integer;
  S: String;
  A: array[0..255] of Char;
begin
  FillChar(A, SizeOf(A), 0);
  Idx := 1;
  for I := 1 to Length(UrlRec.Rep) do
    if UrlRec.Rep[I] = '\' then
      Idx := I+1;
  for I := Idx to Length(UrlRec.Rep) do
      A[I-Idx] := UrlRec.Rep[I];
      BmkList.Add('');
  for I := 1 to UrlRec.Level do
    S := S + '    ';
  BmkList.Add(S + '<DT><H3>' + A + '</H3>');
  BmkList.Add(S + '<DL><P>');
end;

procedure TExportFavorite.MakeHeaderBottom(UrlRec: PUrlRec);
var
  I: Integer;
  S: String;
begin
  for I := 1 to UrlRec.Level do
    S := S + '    ';
    BmkList.Add(S + '</DL><P>');
    BmkList.Add('');
end;

procedure TExportFavorite.MakeBookmark(UrlRec: PUrlRec);
var
  I: Integer;
  S: String;
begin
  Delete(UrlRec.UrlName, Length(UrlRec.UrlName), 1);
  for I := 1 to UrlRec.Level do
    S := S + '    ';
    BmkList.Add(S + '<DT><A HREF="' + UrlRec.UrlPath + '">' +
              UrlRec.UrlName + '</A>' + '<BR>');
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

procedure TExportFavorite.MakeBookmarkFile;
begin
    if fTargetPath = '' then
    begin
      MessageDlg('The target path is invalid.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
      exit;
    end;
  if fTargetFileName = '' then
   begin
    MessageDlg('The target file name is invalid.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    exit;
   end;
  if not (pos('htm', fTargetFileName) >1) then
   begin
    MessageDlg('The target file name extention is invalid.'+#10+#13+'Please change it to "*.htm".', mtError, [MbOk], 0);
    exit;
   end;
  if fFavoritesPath = '' then
   begin
    MessageDlg('The Location path is invalid.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    exit;
   end;
    if fSuccessMessage.Text = '' then
   begin
    MessageDlg('You must enter a message or turn off messages.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    exit;
   end;
    NavigatePath := fTargetPath + fTargetFileName;
    BmkList := TStringList.Create;
    MakeDocumentTop;
    TraverseFavList(0, -1);
    MakeDocumentBottom;
  try
    BmkList.SaveToFile(fTargetPath+'\'+fTargetFileName);
  except on EFCreateError do
    begin
      MessageDlg('The target file name is invalid.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    end;
  end;
  BmkList.Free;
  if ShowSuccessMessage then
     MessageDlg(SuccessMessage.Text, mtInformation, [MbOk], 0);
end;

procedure TExportFavorite.ExportFavorites;
 var
  I: Integer;
begin
     FavList := TList.Create;
  if fFavoritesPath = 'Auto' then GetFavoritesFolder
  else FavFolder := fFavoritesPath;
  if (FavFolder <> '') and (pos('Favorites', FavFolder) >1) then
  begin
    SearchURL(FavFolder, 1);
    FavList.Sort(SortFunction);
    MakeBookmarkFile;
    SuccessFlag:= true;
  end
  else
   begin
    MessageDlg('The favorites file path is invalid.'+#10+#13+'Please change it.', mtError, [MbOk], 0);
    exit;
   end;
  for I := 0 to FavList.Count -1 do
    Dispose(PUrlRec(FavList[I]));
    FavList.Free;
end;

end.
