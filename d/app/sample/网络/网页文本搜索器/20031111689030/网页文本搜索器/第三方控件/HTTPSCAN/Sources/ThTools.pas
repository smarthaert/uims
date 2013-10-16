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
( Description: thttpscan's various tools                                     )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThTools;

interface


   function SizeOfFile (PathFile : string) : integer;
   function CreateSubFilePathFromUrl (Url : string ) : string;
   procedure ReplaceCharInString (oldChar : char ; NewChar : char ; var S : string);
   function MFStrToInt (Chaine : string ; ErrorMessage : boolean ; DefaultValue : integer) : integer;
   function CreateandReturnTreeFromFilePath (FilePath : string) : string;
   function CreateFileNameFromNow : string;
   function CreatePathFromUrl (BasePath : string ; UrlWithoutHttp : string) : string;
   function RunExe (exepath : string ; WindowTitle : string) : boolean;
   function Run2Exe (exepath : string ; WindowTitle : string) : boolean;
   procedure SetConcDwnlds (Value : integer);
   function LastChar (id: Char; s: String): integer;

implementation

Uses Windows, SysUtils, Registry;

function LastChar (id: Char; s: String): integer;
var
   i: integer;
   Done: boolean;
begin
   i := length (s);
   if i > 0 then begin
      Done := false;
      while not Done do begin
         if s[i] = id then begin
            Done := true;
         end
         else begin
            dec (i);
            if i = 0 then begin
               Done := true;
            end;
         end;
      end;
   end;
   Result := i;
end;

function DirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function CreateandReturnTreeFromFilePath (FilePath : string) : string;
var
   islash : integer;
   CurTree, curdir : string;
   fini : boolean;
   NewPath : string;
begin
   // FILEPATH must contain a file name or finish by '\'
   CurTree := FilePath;
   islash := LastChar ('\', FilePath);
   if islash > 1 then begin
      if not DirectoryExists (Copy (FilePath, 1, iSlash)) then begin
         CurTree := '';
         NewPath := FilePath;
         fini := false;
         while not fini do begin
            islash := pos ('\', NewPath);
            if islash > 0 then begin
               Curdir := copy (NewPath, 1, islash);
               CurTree := CurTree + Curdir;
               CreateDir (Copy (CurTree, 1, length (CurTree) - 1));
               NewPath := copy (NewPath, islash + 1, length(NewPath) - islash);
            end
            else begin
               fini := true;
            end;
         end;
      end;
   end;
   // returned without '\'
   CreateandReturnTreeFromFilePath := Copy (CurTree, 1, length (CurTree) - 1);
end;

procedure RemplaceCaracteresIndesirables (var chaine : string ; ListeCaracteres : string ; CaractereSubstitution : char);
var
   i, j : integer;
begin
   for i := 1 to length (Chaine) do begin
       for j := 1 to length (ListeCaracteres) do begin
           if chaine[i] = ListeCaracteres[j] then begin
              chaine[i] := CaractereSubstitution;
           end;
       end;
   end;
end;

procedure ReplaceCharInString (oldChar : char ; NewChar : char ; var S : string);
var
   i : integer;
begin
   for i := 1 to length (S) do begin
      if S[i] = oldChar then begin
         S[i] := NewChar;
      end;
   end;
end;

function CreateSubFilePathFromUrl (Url : string ) : string;
var
   i : integer;
   UrlSubPath : string;
begin
   i := Pos ('//', Url);
   if i > 0 then begin
      UrlSubPath := Copy (Url, i + 2, length (Url));
      i := Pos ('?', Url);
      if i > 0 then begin
         UrlSubPath := Copy (UrlSubPath, 1, i);
      end;
      i := Pos ('#', Url);
      if i > 0 then begin
         UrlSubPath := Copy (UrlSubPath, 1, i);
      end;
      RemplaceCaracteresIndesirables (UrlSubPath, '|=*:;,<>', '$');
      for i := 1 to Length (UrlSubPath) do begin
          if UrlSubPath[i] = '/' then UrlSubPath[i] := '\';
      end;
   end;
   CreateSubFilePathFromUrl := UrlSubPath;
end;

function MFStrToInt (Chaine : string ; ErrorMessage : boolean ; DefaultValue : integer) : integer;
var
   i : integer;
   ok : boolean;
   Retour : integer;
begin
   ok := true;
   if Length (Chaine) = 0 then begin
      ok := false;
   end
   else begin
      for i := 1 to length (chaine) do begin
          if (chaine[i] < '0') or (chaine[i] > '9') then begin
             ok := false;
          end;
      end;
   end;
   if ok then begin
      Retour := StrToInt (Chaine);
   end
   else begin
      Retour := DefaultValue;
      if ErrorMessage then begin
         //Showmessage ('Incorrect value; ' + ' reseted to ' + IntToStr (Retour));
      end;
   end;
   MFStrToInt := Retour;
end;

procedure SetConcDwnlds (Value : integer);
begin
   With TRegistry.Create do begin
      try
         if OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', True) then begin
            if Value = -1 then begin
               Value := 2;
            end;
            WriteInteger ('MaxConnectionsPerServer', Value);
            WriteInteger ('MaxConnectionsPer1_0Server', Value + 2);
         end;
         CloseKey;
      finally
         Free;
      end;
   end;
end;

function CreateFileNameFromNow : string;
var
   Temp, Temp2 : string;
begin
   Temp := DateTimeToStr(Now);
   Temp2 := Copy (Temp, 7, 4) + '-' + Copy (Temp, 4, 2) + '-' + Copy (Temp, 1, 2) + '_' + Copy (Temp, 12, MAXINT) + '.txt';
   ReplaceCharInString (':', '.', Temp2);
   CreateFileNameFromNow := Temp2;
end;

function CreatePathFromUrl (BasePath : string ; UrlWithoutHttp : string) : string;
var
   TempPath : string;
   iSlash : integer;
begin
   TempPath := UrlWithoutHttp;
   iSlash :=  LastChar ('/', TempPath);
   if iSlash = 0 then begin
      TempPath := TempPath + '/index.html';
   end
   else if iSlash = length (TempPath) then begin
      TempPath := TempPath + 'index.html';
   end;
   ReplaceCharInString ('/', '\', TempPath);
   if BasePath[length (BasePath)] <> '\' then begin
      CreatePathFromUrl := BasePath + '\' + TempPath;
   end
   else begin
      CreatePathFromUrl := BasePath + TempPath;
   end;
end;

function SizeOfFile (PathFile : string) : integer;
var
   f : file;
   Returned : integer;
begin
   Returned := -1;
   AssignFile(f, PathFile);
   FileMode := 0;
   {$I-}
   Reset (f, 1);
   {$I+}
   if IOResult = 0 then begin
      Returned := FileSize (f);
      CloseFile (f);
   end;
   SizeOfFile := Returned;
end;

function RunExe (exepath : string ; WindowTitle : string) : boolean;
var
   resul : boolean;
   StartupInfo : TStartupInfo;
   ProcessInfo : TProcessInformation;
begin
   StartupInfo.cb := Sizeof (TstartupInfo);
   StartupInfo.lpReserved := nil;
   StartupInfo.lpDesktop := nil;
   StartupInfo.lpTitle := Pchar(WindowTitle);
   StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
   StartupInfo.wShowWindow := SW_MINIMIZE;
//   StartupInfo.wShowWindow := SW_SHOWMINNOACTIVE;
   StartupInfo.cbReserved2 := 0;
   StartupInfo.lpReserved2 := nil;;

   resul := CreateProcess (PChar (Exepath), // LPCTSTR lpApplicationName,	// pointer to name of executable module
               nil, // LPTSTR lpCommandLine,	// pointer to command line string
               nil, // LPSECURITY_ATTRIBUTES lpProcessAttributes,	// pointer to process security attributes
               nil, // LPSECURITY_ATTRIBUTES lpThreadAttributes,	// pointer to thread security attributes
               false, // BOOL bInheritHandles,	// handle inheritance flag
               CREATE_NEW_CONSOLE or IDLE_PRIORITY_CLASS or CREATE_SUSPENDED, // NORMAL_PRIORITY_CLASS, // DWORD dwCreationFlags,	// creation flags
               nil, // LPVOID lpEnvironment,	// pointer to new environment block
               nil, // LPCTSTR lpCurrentDirectory,	// pointer to current directory name
               StartupInfo, // LPSTARTUPINFO lpStartupInfo,	// pointer to STARTUPINFO
               ProcessInfo); // LPPROCESS_INFORMATION lpProcessInformation 	// pointer to PROCESS_INFORMATION
   RunExe := Resul;
end;

function Run2Exe (exepath : string ; WindowTitle : string) : boolean;
var
   resul : boolean;
   StartupInfo : TStartupInfo;
   ProcessInfo : TProcessInformation;
begin
   StartupInfo.cb := Sizeof (TstartupInfo);
   StartupInfo.lpReserved := nil;
   StartupInfo.lpDesktop := nil;
   StartupInfo.lpTitle := Pchar(WindowTitle);
   StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
   StartupInfo.wShowWindow := SW_MINIMIZE;
//   StartupInfo.wShowWindow := SW_SHOWMINNOACTIVE;
   StartupInfo.cbReserved2 := 0;
   StartupInfo.lpReserved2 := nil;;

   resul := CreateProcess (nil, // LPCTSTR lpApplicationName,	// pointer to name of executable module
               PChar (exepath), // LPTSTR lpCommandLine,	// pointer to command line string
               nil, // LPSECURITY_ATTRIBUTES lpProcessAttributes,	// pointer to process security attributes
               nil, // LPSECURITY_ATTRIBUTES lpThreadAttributes,	// pointer to thread security attributes
               false, // BOOL bInheritHandles,	// handle inheritance flag
               0, // NORMAL_PRIORITY_CLASS, // DWORD dwCreationFlags,	// creation flags
               nil, // LPVOID lpEnvironment,	// pointer to new environment block
               nil, // LPCTSTR lpCurrentDirectory,	// pointer to current directory name
               StartupInfo, // LPSTARTUPINFO lpStartupInfo,	// pointer to STARTUPINFO
               ProcessInfo); // LPPROCESS_INFORMATION lpProcessInformation 	// pointer to PROCESS_INFORMATION
   Run2Exe := Resul;
end;




end.


