unit Tool;

interface

uses windows,sysutils,forms, cpl,shlobj,Activex,stdctrls,messages,classes
     ,jpeg,graphics;

const
  CCH_MAXNAME=255;
  LNK_RUN_MIN=7;
  LNK_RUN_MAX=3;
  LNK_RUN_NORMAL=1;

type LINK_FILE_INFO=record
         FileName:array[0..MAX_PATH] of char;
         WorkDirectory:array[0..MAX_PATH] of char;
         IconLocation:array[0..MAX_PATH] of char;
         IconIndex:integer;
         Arguments:array[0..MAX_PATH] of char;
         Description:array[0..CCH_MAXNAME] of char;
         ItemIDList:PItemIDList;
         RelativePath:array[0..255] of char;
         ShowState:integer;
         HotKey:word;
     end;

type
  TFindCallBack=procedure (const info:TSearchRec;var bQuit,bSub:boolean);

procedure FindFile(var quit:boolean;const path: String;const filename:string='*.*';
                   proc:TFindCallBack=nil;bSub:boolean=true);
function GetControlAppInfo(const filename:string):string;
function GetBit(const x:dword;const bit:byte):dword;
function Registed:boolean;
function SelectDirectory(handle:hwnd;const Caption: string; const Root: WideString;out Directory: string): Boolean;
procedure RefreshSystem;
function InputBox(const ACaption, APrompt, ADefault: string): string;
procedure Jpg2Bmp(const source,dest:string);
procedure FitBitmap(const Source,Dest:string;const x,y:integer;const ColorBit:TPixelFormat);
function LinkFileInfo(const lnkFileName:string;var info:LINK_FILE_INFO;const bSet:boolean):boolean;

var
  RefreshKeyList:tstrings;

implementation

uses unit1;

function SHUpdateRecycleBinIcon():boolean;stdcall;external 'shell32.dll' name 'SHUpdateRecycleBinIcon';

procedure FindFile(var quit:boolean;const path: String;const filename:string='*.*';
                   proc:TFindCallBack=nil;bSub:boolean=true);
var
  fpath: String;
  info: TsearchRec;

 procedure ProcessAFile;
 begin
  if (info.Name<>'.') and (info.Name<>'..') and ((info.Attr and faDirectory)<>faDirectory) then
  begin
  if assigned(proc) then
    proc(info,quit,bsub);
  end;
 end;

 procedure ProcessADirectory;
 begin
  if (info.Name<>'.') and (info.Name<>'..') and ((info.attr and fadirectory)=fadirectory) then
    findfile(quit,fpath+info.Name,filename,proc,bsub);
 end;

begin
if quit then  exit;
fpath:=string(pchar(path));
if path[length(fpath)]<>'\' then
  fpath:=fpath+'\';
try
  if 0=findfirst(fpath+filename,faanyfile and (not fadirectory),info) then
  begin
    ProcessAFile;
    while 0=findnext(info) do
      begin
        if quit then
          begin
            findclose(info);
            exit;
          end;
        ProcessAFile;
      end;
  end;
finally
  findclose(info);
end;
try
  if bsub and (0=findfirst(fpath+'*',faanyfile,info)) then
    begin
      ProcessADirectory;
      while findnext(info)=0 do
        ProcessADirectory;
    end;
finally
  findclose(info);
end;
end;

function GetControlAppInfo(const filename:string):string;
var
Proc : TCPlApplet;
Mo : integer;
buf:pchar;
info2:cplinfo;
begin
  if lowercase(filename)='netcpl.cpl' then
  begin
    result:='网络属性';
    exit;
  end;
  if lowercase(filename)='s32lucp1.cpl' then
  begin
    result:='LiveUpdate';
    exit;
  end;
  if lowercase(filename)='modem.cpl' then
  begin
    result:='调制解调器';
    exit;
  end;
  if lowercase(filename)='sysdm.cpl' then
  begin
    result:='系统属性';
    exit;
  end;
  getmem(buf,255);
  MO:=LoadLibrary(pchar(filename));
  @Proc := GetProcAddress(mo,'CPlApplet');
  if @Proc<>nil then
  begin
    proc(0,CPL_INIT,0,0);
    proc(0,CPL_GETCOUNT,0,0);
    succeeded(proc(0,CPL_INQUIRE,0,integer(@info2)));
    loadstring(mo,info2.idName,buf,255);
    result:=buf;
    if lowercase(filename)='inetcpl.cpl' then
      result:=result+' / 用户';
  end;
  freemem(buf);
  FreeLibrary(Mo);
end;

function GetBit(const x:dword;const bit:byte):dword;
begin
  result:=(x shr (bit-1)) and 1;
end;

function Registed:boolean;
begin
  result:=false;
end;

function SelectDirectory(handle:hwnd;const Caption: string; const Root: WideString;out Directory: string): Boolean;
var
  lpbi:_browseinfo;
  buf:array [0..MAX_PATH] of char;
  id:ishellfolder;
  eaten,att:cardinal;
  rt:pitemidlist;
  initdir:pwidechar;
begin
  result:=false;
  lpbi.hwndOwner:=handle;
  lpbi.lpfn:=nil;
  lpbi.lpszTitle:=pchar(caption);
  lpbi.ulFlags:=BIF_RETURNONLYFSDIRS+16;
  SHGetDesktopFolder(id);
  initdir:=pwchar(root);
  id.ParseDisplayName(0,nil,initdir,eaten,rt,att);
  lpbi.pidlRoot:=rt;
  if root='' then lpbi.pidlRoot:=nil;
  getmem(lpbi.pszDisplayName,MAX_PATH);
  try
   result:=shgetpathfromidlist(shbrowseforfolder(lpbi),buf);
  except
   freemem(lpbi.pszDisplayName);
  end;
  if result then directory:=buf;
end;

procedure RefreshSystem;
var
  i:integer;
  buf:array[0..MAX_PATH] of char;
begin
  SHUpdateRecycleBinIcon;
  SHChangeNotify(SHCNE_ASSOCCHANGED,SHCNF_IDLIST+SHCNF_FLUSH,nil,nil);
  SHChangeNotify(SHCNE_ALLEVENTS , SHCNF_FLUSH,nil,nil);
  form1.ProgressBar.Max:=RefreshKeyList.Count;
  form1.ProgressBar.Min:=0;
  for i:=0 to RefreshKeyList.Count-1 do
  begin
    strpcopy(buf,RefreshKeyList.Strings[i]);
    form1.ProgressBar.StepIt;
    application.ProcessMessages;
    SendMessage(HWND_BROADCAST,WM_SETTINGCHANGE,0,integer(@buf));
  end;
  RefreshKeyList.Clear;
  form1.ProgressBar.Position:=form1.ProgressBar.Min;
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  Form.Font:=application.MainForm.Font;
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(63, DialogUnits.Y, 8);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        AutoSize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Caption := APrompt;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := MulDiv(19, DialogUnits.Y, 8);
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption :='确定';
        ModalResult := idok;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := '取消';
        ModalResult := idCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      if ShowModal = idok then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result);
end;

procedure Jpg2Bmp(const source,dest:string);
var
  MyJpeg: TJpegImage;
  bmp: Tbitmap;
begin
bmp:=tbitmap.Create;
MyJpeg:= TJpegImage.Create;
try
  myjpeg.LoadFromFile(source);
  bmp.Assign(myjpeg);
  bmp.SaveToFile(dest);
finally
  bmp.free;
  myjpeg.Free;
end;
end;

procedure FitBitmap(const Source,Dest:string;const x,y:integer;const ColorBit:TPixelFormat);
var
  abmp,bbmp:tbitmap;
  scalex,scaley:real;
begin
  abmp:=tbitmap.Create;
  bbmp:=tbitmap.Create;
  try
    abmp.LoadFromFile(Source);
    scaley:=abmp.Height/y;
    scalex:=abmp.Width/x;
    bbmp.Width:=round(abmp.Width/scalex);
    bbmp.Height:=round(abmp.Height/scaley);
    bbmp.PixelFormat:=pf8bit;
    SetStretchBltMode(bbmp.Canvas.Handle,COLORONCOLOR);
    stretchblt(bbmp.Canvas.Handle,0,0,bbmp.Width,bbmp.Height,abmp.Canvas.Handle,0,0,abmp.Width,abmp.Height,srccopy);
    bbmp.SaveToFile(Dest);
 finally
   abmp.Free;
   bbmp.Free;
 end;
end;

function LinkFileInfo(const lnkFileName:string;var info:LINK_FILE_INFO;const bSet:boolean):boolean;
var
 hr:hresult;
 psl:IShelllink;
 wfd:win32_find_data;
 ppf:IPersistFile;
 lpw:pwidechar;
 buf:pwidechar;
begin
 result:=false;
 getmem(buf,MAX_PATH);
 try
 if SUCCEEDED(CoInitialize(nil)) then
 if (succeeded(cocreateinstance(clsid_shelllink,nil,clsctx_inproc_server,IID_IShellLinkA,psl))) then
 begin
   hr:=psl.QueryInterface(iPersistFile,ppf);
   if succeeded(hr) then
   begin
     lpw:=stringtowidechar(lnkfilename,buf,MAX_PATH);
     hr := ppf.Load(lpw, STGM_READ);
     if succeeded(hr) then
     begin
       hr := psl.Resolve(0, SLR_NO_UI);
       if succeeded(hr) then
       begin
         if bSet then
         begin
           psl.SetArguments(info.Arguments);
           psl.SetDescription(info.Description);
           psl.SetHotkey(info.HotKey);
           psl.SetIconLocation(info.IconLocation,info.IconIndex);
           psl.SetIDList(info.ItemIDList);
           psl.SetPath(info.FileName);
           psl.SetShowCmd(info.ShowState);
           psl.SetRelativePath(info.RelativePath,0);
           psl.SetWorkingDirectory(info.WorkDirectory);
           if succeeded(psl.Resolve(0,SLR_UPDATE)) then
             result:=true;
         end
         else
         begin
           psl.GetPath(info.FileName,MAX_PATH, wfd,SLGP_SHORTPATH );
           psl.GetIconLocation(info.IconLocation,MAX_PATH,info.IconIndex);
           psl.GetWorkingDirectory(info.WorkDirectory,MAX_PATH);
           psl.GetDescription(info.Description,CCH_MAXNAME);
           psl.GetArguments(info.Arguments,MAX_PATH);
           psl.GetHotkey(info.HotKey);
           psl.GetIDList(info.ItemIDList);
           psl.GetShowCmd(info.ShowState);
           result:=true;
         end;
       end;
     end;
   end;
 end;
 finally
 freemem(buf);
 end;
end;

initialization
  RefreshKeyList:=tstringlist.Create;

finalization
  RefreshKeyList.Free;

end.
