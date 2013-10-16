{(((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
(                              THttpScan v4.02                               )
(                       Copyright (c) 2001 Michel Fornengo                   )
(                             All rights reserved.                           )
(                                                                            )
( home page:     http://www.delphicity.com                                   )
( contacts:      contact@delphicity.com                                      )
( support:       support@delphicity.com                                      )
((((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
( Description: url parser                                                    )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThCrkUrl;

interface

Uses WinInet;

const
   DEFAULTCRACKURLMAXSIZE = 1024;

type

   TCrackUrl = class (TObject)

   private
      PUrl : Pchar;
      FUrlFilePath : string;
      CrackUrlMaxSize: integer;
      szMemoryAssigned: Boolean;
      AssignMemorySize: integer;

      procedure szFreeMemory;
      procedure szAssignMemory (UrlLength: integer);
      procedure AssignOrCheckMemorySize (UrlLength: integer);

   public
      UrlComp : TUrlComponents;
      SingleHost : string;
      UrlPath_Wo_Host_and_File : string;
      CrackOk : boolean;

      constructor Create;
      destructor Destroy; override;
      function CrackUrl (_Url : string ; DownloadPath : string) : boolean;
      procedure CopyTCrackedUrl (Source : TCrackUrl);
      function Url : string;
   public
      property UrlFilePath : string read FUrlFilePath;
   end;

implementation

Uses SysUtils,
     ThTools;

constructor TCrackUrl.Create;
begin
   AssignMemorySize := DEFAULTCRACKURLMAXSIZE;
   SingleHost := '';
   UrlPath_Wo_Host_and_File := '';
   CrackUrlMaxSize := DEFAULTCRACKURLMAXSIZE;
   CrackOk := false;
end;

destructor TCrackUrl.Destroy;
begin
   szFreeMemory;
   inherited Destroy;
end;

function TCrackUrl.Url : string;
begin
   Url := PUrl;
end;

procedure TCrackUrl.CopyTCrackedUrl (Source : TCrackUrl);
begin
 with UrlComp do begin
   nPort := Source.UrlComp.nPort;

   StrLCopy (PUrl, PChar(Source.Url), CRACKURLMAXSIZE);

   StrLCopy (lpszScheme, Source.UrlComp.lpszScheme, CRACKURLMAXSIZE);
   StrLCopy (lpszHostName, Source.UrlComp.lpszHostname, CRACKURLMAXSIZE);
   StrLCopy (lpszUserName, Source.UrlComp.lpszUserName, CRACKURLMAXSIZE);
   StrLCopy (lpszPassword, Source.UrlComp.lpszPassword, CRACKURLMAXSIZE);
   StrLCopy (lpszUrlPath, Source.UrlComp.lpszUrlPath, CRACKURLMAXSIZE);
   StrLCopy (lpszExtraInfo, Source.UrlComp.lpszExtraInfo, CRACKURLMAXSIZE);

   dwStructSize := Source.UrlComp.dwStructSize;
   dwSchemeLength := Source.UrlComp.dwSchemeLength;
   dwHostNameLength := Source.UrlComp.dwHostNameLength;
   nScheme := Source.UrlComp.nScheme;
   dwUserNameLength := Source.UrlComp.dwUserNameLength;
   dwPasswordLength := Source.UrlComp.dwPasswordLength;
   dwUrlPathLength := Source.UrlComp.dwUrlPathLength;
   dwExtraInfoLength := Source.UrlComp.dwExtraInfoLength;

   UrlPath_Wo_Host_and_File := Source.UrlPath_Wo_Host_and_File;
   CrackOk := Source.CrackOk;
 end;
end;

procedure TCrackUrl.szFreeMemory;
begin
   if szMemoryAssigned then begin
      with UrlComp do begin
         FreeMem (lpszScheme);
         FreeMem (lpszHostName);
         FreeMem (lpszUserName);
         FreeMem (lpszPassword);
         FreeMem (lpszUrlPath);
         FreeMem (lpszExtraInfo);
      end;
      FreeMem (PUrl);
      szMemoryAssigned := false;
   end;
end;

procedure TCrackUrl.szAssignMemory (UrlLength: integer);
begin
   if szMemoryAssigned then begin
      szFreeMemory;
   end;
   GetMem (PUrl, UrlLength);
   with UrlComp do begin
      GetMem (lpszScheme, UrlLength);
      GetMem (lpszHostName, UrlLength);
      GetMem (lpszUserName, UrlLength);
      GetMem (lpszPassword, UrlLength);
      GetMem (lpszUrlPath, UrlLength);
      GetMem (lpszExtraInfo, UrlLength)
   end;
   szMemoryAssigned := true;
end;

procedure TCrackUrl.AssignOrCheckMemorySize (UrlLength: integer);
begin
   if UrlLength > AssignMemorySize then begin
      AssignMemorySize := UrlLength + 1;
      szAssignMemory (AssignMemorySize);
   end
   else if not szMemoryAssigned then begin
      szAssignMemory (AssignMemorySize);
   end;
end;

function TCrackUrl.CrackUrl (_Url : string ; DownloadPath : string) : boolean;
var
   islash : integer;
   TmpUrlPath : string;
   iPoint : integer;
   TempHost : string;
begin
   AssignOrCheckMemorySize (length (_Url));
   strPCopy (PUrl, _Url);
   with UrlComp do begin
      dwStructSize := sizeof (TUrlComponents);
      dwSchemeLength := CRACKURLMAXSIZE;
      dwHostNameLength := CRACKURLMAXSIZE;
      dwUserNameLength := CRACKURLMAXSIZE;
      dwPassWordLength := CRACKURLMAXSIZE;
      dwUrlPathLength := CRACKURLMAXSIZE;
      dwExtraInfoLength := CRACKURLMAXSIZE;

      CrackOk := InternetCrackUrl (PUrl, strlen (PUrl), ICU_DECODE or ICU_ESCAPE, UrlComp);
      TmpUrlPath := lpszUrlPath;
      islash := LastChar ('/', TmpUrlPath);
      if (islash > 0) and (islash < length (TmpUrlPath)) then begin
         if pos ('.', Copy (TmpUrlPath, islash + 1, MAXINT)) = 0 then begin // pas de point après le dernier /, c'est un chemin
            TmpUrlPath := TmpUrlPath + '/';
         end;
      end;
      UrlPath_Wo_Host_and_File := TmpUrlPath;
      if UrlPath_Wo_Host_and_File = '' then begin
         UrlPath_Wo_Host_and_File := '/';
      end;

      TempHost := UrlComp.lpszHostName;
      iPoint := LastChar ('.', TempHost);
      if iPoint > 1 then begin
         SingleHost := Copy (TempHost, 1, iPoint - 1);
         iPoint := LastChar ('.', SingleHost);
         if (iPoint > 0) and (iPoint < length (TempHost)) then begin
            SingleHost := copy (TempHost, iPoint + 1, MaxInt);
         end;
      end;

      if DownloadPath <> '' then begin
         FUrlFilePath := CreatePathFromUrl (DownloadPath, string (UrlComp.lpszHostName) + TmpUrlPath);
      end
      else begin
         FUrlFilePath := '';
      end;
   end;
   CrackUrl := CrackOk;
end;

end.
