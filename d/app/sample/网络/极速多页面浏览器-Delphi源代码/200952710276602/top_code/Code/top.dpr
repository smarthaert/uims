program top;

{$DEFINE ATSAMEON}
//{$DEFINE InstallOn}
//{$DEFINE DEBUG}

uses
  Forms,
  Windows,
  Messages,
  SysUtils,
  IniFiles,
  UnitMain in 'UnitMain.pas' {FormMain},
  var_ in 'var_.pas',
  const_ in 'const_.pas',
  UnitPublic in 'UnitPublic.pas' {FormPublic},
  UnitGroup in 'UnitGroup.pas' {GroupForm},
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  UnitCPU in 'UnitCPU.pas',
  GetPathUnit in 'GetPathUnit.pas' {GetPathForm},
  UnitSet in 'UnitSet.pas' {SetForm},
  UnitHelp in 'UnitHelp.pas' {HelpForm},
  UCatchScreenShow in 'UCatchScreenShow.pas' {CatchScreenShowForm},
  Public in 'Public.pas',
  UnitWebBrowser in 'UnitWebBrowser.pas' {FormWebBrowser},
  KillAd in 'KillAd.pas',
  UnitWmp in 'UnitWmp.pas' {FormWmp},
  UnitAutoHint in 'UnitAutoHint.pas',
  UnitHintShow in 'UnitHintShow.pas',
  idispatch_interface in 'idispatch_interface.pas',
  example_TLB in 'example_TLB.pas',
  UnitUpdate in 'UnitUpdate.pas' {FormUpdate};

{$R *.res}
{$R example.tlb}

{$IFDEF ATSAMEON}
//{$IFDEF InstallOn}
//{$ELSE}
var
  //程序启动时候检查本身是否已经运行
  //Hnd:THandle;
  IniFile:TIniFile;
  //sstr:string;

  //HMutex: THandle;
  //Errno: Integer;
  //

  Found: HWND;
  //Atom: TAtom;
  I: Integer;
  Str: string;
  ds: TCopyDataStruct;
  //ParamOK: Boolean = false;
//{$ENDIF}
{$ENDIF}
begin
try
{$IFDEF ATSAMEON}
//{$IFDEF InstallOn}
//{$ELSE}

  if FileExists(ExtractFilePath(ParamStr(0)) + ConfigFile) then
  begin
  Hnd:=CreateMutex(nil,False,AuthorInformation);
  //if (FileExists(ExtractFilePath(ParamStr(0))+ConfigFile)) then
  //begin
    if GetLastError=ERROR_ALREADY_EXISTS then
    begin
      IniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + ConfigFile);
      try   //MessageBox(0,PChar(ExtractFilePath(ParamStr(0))+ConfigFile),'',0);
      str:=IniFile.ReadString('RunData','RunOne','1');
      //Str2:=IniFile.ReadString('RunData','InstallOne','0');
      //if (InstallOn) and (Trim(Str2) = '1') then begin
      if Trim(str)='1' then
      begin   //MessageBox(0,'ok.','',0);
        Found := FindWindow(AppName, nil);
        if (Found <> 0) and (SendMessage(Found, WM_FOUNDHE, 0, 0) = APPTAG) then
        begin
        try
          {
          //if not ParamOK then
          //begin
            //if ParamCount >= 1 then
            for I := 1 to ParamCount do
            begin
              begin
                Atom:=GlobalAddAtom(PChar(ParamStr(I)));
                SendMessage(Found, WM_OPENPAGE, Atom, 0);
                GlobalDeleteAtom(Atom);
              end;
            end;
            //exit;
          //end;

          Atom := GlobalAddAtom(PChar(APPNAME));
          SendMessage(Found, WM_OPENPAGE, Atom, 0);
          GlobalDeleteAtom(Atom);

          Application.Terminate;
          Exit;
          }
        AppToExit := True;
        try
          ds.cbData := Length (APPNAME) + 1; 
          GetMem (ds.lpData, ds.cbData ); //为传递的数据区分配内存
          StrCopy (ds.lpData, PChar (APPNAME));
          SendMessage (Found, WM_COPYDATA, Application.Handle, Cardinal(@ds));
          FreeMem (ds.lpData);
        finally
          for I := 1 to ParamCount do
          begin
          ds.cbData := Length (ParamStr(I)) + 1;
          GetMem (ds.lpData, ds.cbData ); //为传递的数据区分配内存
          StrCopy (ds.lpData, PChar (ParamStr(I)));
          SendMessage (Found, WM_COPYDATA, Application.Handle, Cardinal(@ds));
          FreeMem (ds.lpData);
          end;
        end;
        finally
          Application.Terminate;
        end;
        end;
      end;
      finally
      //IsLibrary := true;
      IniFile.Free;
      end;
    end;
  //end;
  end;
//{$ENDIF}
{$ENDIF}
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormPublic, FormPublic);
  Application.CreateForm(TGroupForm, GroupForm);
  Application.CreateForm(TSetForm, SetForm);
  Application.CreateForm(TFormHintShow, FormHintShow);
  Application.CreateForm(TCatchScreenShowForm, CatchScreenShowForm);
  Application.CreateForm(TFormWmp, FormWmp);
  Application.CreateForm(TFormUpdate, FormUpdate);
  Application.Run;
except end;
end.
