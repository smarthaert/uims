unit idispatch_interface;

interface

uses
  ComObj, ActiveX, example_TLB, StdVcl,
  SysUtils, Variants, Classes, Graphics,
  Dialogs, ImgList, Menus, ExtCtrls, StdCtrls, ComCtrls, //XPMan,
  ToolWin, Buttons,
  IniFiles,
  ShlObj;
  
type
  TTBrowserToDelphi = class(TAutoObject, ITBrowserToDelphi)
  protected
    { Protected declarations }
    function Get_GetSection: OleVariant; safecall;
    function Get_GetClose: OleVariant; safecall;
    function Get_GetClose2: OleVariant; safecall;
  end;

  procedure LoadInit;

implementation

uses ComServ, controls, UnitPublic, var_, const_, UnitWebBrowser, UnitMain,
  Public;

var
  Str: String;
  LastTimeURLList: TStringList;
  
procedure LoadInit;
var
  i:Integer;
  str1, str2:string;
  MyDir2: String;
begin
try
  if GreenVer then
  MyDir2 := GetTempDir
  else
  MyDir2 := ExtractFilePath(ParamStr(0));
  if MyDir2[Length(MyDir2)]<>'\' then MyDir2 := MyDir2 + '\';
  if not FileExists(MyDir2 + OpenURLListFile2) then
  begin
    exit;
  end;
  Str := '';      //ShowMessage(ExtractFilePath(ParamStr(0))+OpenURLListFile2);
  LastTimeURLList:=TStringList.Create;
  try
  LastTimeURLList.LoadFromFile(MyDir2 + OpenURLListFile2);
  for i:=0 to LastTimeURLList.Count-1 do
  begin
    //ShowMessage(LastTimeURLList[i]);
    if (Pos('/' + DataDir + '/' + LastOpenLoadFile, LastTimeURLList[i]) <> 0) then Continue;
    str1:=Copy(LastTimeURLList[i],1,Pos('#',LastTimeURLList[i])-1);
    str2:=Copy(LastTimeURLList[i],Pos('#',LastTimeURLList[i])+1,Length(LastTimeURLList[i])-Pos('#',LastTimeURLList[i]));
    //if Length(str1)>38 then str1 := (Copy(str1,1,38)+'...');
    //{
    if i = LastTimeURLList.Count-1 then
    Str := Str + Str1 + '$' + Str2
    else
    //}
    Str := Str + Str1 + '$' + Str2 + '$';
  end;
  //if Trim(Str) <> '' then LoadLastOpenValue := true;
  finally
    LastTimeURLList.Clear;
    LastTimeURLList.Free;
  end;
except end;
end;

function TTBrowserToDelphi.Get_GetSection: OleVariant;
begin
try
  {
  //Result := '要要搜2,http://www.11sou.com'; exit;
  //with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'OpenURLList.ini') do
  //begin
   Result := '要要搜2,http://www.11sou.com,haha,http://www.haha.com'; //ReadString('Data', '要要搜2', '要要搜2,http://www.11sou.com');
   //Free;
  //end;
  }
  //Result := '要要搜2,http://www.11sou.com,haha,http://www.haha.com'; //ReadString('Data', '要要搜2', '要要搜2,http://www.11sou.com');
  Result := Str;
except end;
end;

function TTBrowserToDelphi.Get_GetClose: OleVariant;
var
  i: Integer;
begin
try
  try
  
    LoadLastOpenOK := true;
    LoadLastOpenFlag := false;

  if not GoToNewPage then
  begin
    FormPublic.ClosePage(PageIndex);
    exit;
  end
  else
  begin
    {
    GoToNewPage := false;
    ThreadI := 99;
    RunProcess2.Create(False);
    }
    for i := 0 to wbList.Count - 1 do
    begin
      if TFormWebBrowser(wbList[i]).WebBrowser.Tag = LastUnCloseFlag then
      begin
        LoadLastOpenI := i;
        //FormPublic.ClosePage(LoadLastOpenI);
        Break;
      end;
    end;
    {
    Sleep(100);
    //MessageBox(FormMain.Handle, PChar(IntToStr(LoadLastOpenI + 1)), '', 0);
    FormPublic.TabClick2(LoadLastOpenI);
    Sleep(100);
    FormPublic.ClosePage(LoadLastOpenI);
    }
    TFormWebBrowser(wbList[LoadLastOpenI]).WebBrowser.Navigate('about:blank');
    TFormWebBrowser(wbList[LoadLastOpenI]).WebUrl := 'about:blank';
    if not GoToNewPage then
    begin
      FormMain.CBUrl.Text := 'about:blank';
      FormMain.CBUrl.SetFocus;
      TFormWebBrowser(wbList[LoadLastOpenI]).WebBrowser.Hint := ':BLANK';
    end;
    ///
  end;
  //Sleep(10);
  //TFormWebBrowser(wbList[LoadLastOpenI]).WebBrowser.Hint := 'llo';
    //FormPublic.ClosePage(LoadLastOpenI);
    //FormMain.CBUrl.Text := 'about:blank';

    //ShowWebIcon2 := false;
    {
    if LastOpenPageClose then
    begin
      FormPublic.ClosePage(LoadLastOpenI);
      exit;
    end;
    }

  finally
  end;
except end;
end;

function TTBrowserToDelphi.Get_GetClose2: OleVariant;
begin
try
  FormPublic.ClosePage({LoadLastOpenI}PageIndex);
  LoadLastOpenOK := true;
  LoadLastOpenFlag := false;
  //ShowWebIcon2 := false;
except end;
end;

initialization
begin
try
  TAutoObjectFactory.Create(ComServer, TTBrowserToDelphi, Class_TBrowserToDelphi, ciInternal, tmApartment);
  LoadInit;
except end;
end;

end.
