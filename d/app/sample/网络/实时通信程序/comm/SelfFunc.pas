unit SelfFunc;

interface

USES Forms,Windows,classes,FileCtrl, DB, DBTables,stdctrls,SysUtils,ComCtrls, ShellApi, shlobj,
     Controls, ExtCtrls, DBCtrls, Dgxk, Grids, DBGridEx, Buttons, Graphics,
     registry, DBGrids,ADODB, variants, messages, IdWinsock;
type
  TBrowseCallBackFunc = Function(var psFile:string) :integer;
  PForm=^Tform;

  procedure MsgBox(sInfo:string);
  procedure MsgBoxInfo(sInfo:string);
  procedure MsgBoxErr(sInfo:string);
  Function MsgBoxSel(sInfo:string):Boolean;
  Function MsgBoxSely(sInfo:string):Boolean;
  Function MsgBoxSel3(sInfo:string):integer;
  Function MsgBoxSelk(sInfo:string):boolean;
  Function strLeft(Str:String;n:integer):String;
  Function strRight(Str:String;n:integer):String;
  procedure RefreshQuery(oQuery:TQuery);
  procedure RefreshBrowse(oQuery:TQuery; const KeyFields:String; const KeyValues:String);
  Function ExecDel(sErrNote:string; nID:integer; oDelProc:TStoredProc):Boolean;
  function ExecuteURL(UrlString:String): boolean;
  Function FCopy(fS,fD:string;pgBar:TProgressBar):integer;
  Function iif(exp :boolean;value1,value2 :variant):variant;
  Function GetCmoney(const Outv :real):string;
  Function Space(const Count: integer):string;

  procedure CreateDlg(FormClass:TFormClass;oChildDlg:PForm);
  procedure DestroyDlg(FormClass:TFormClass;oChildDlg:PForm);

  const vrvZero=0; vrvNull=1; vrvEmpty=2;
              cYesChar ='√'; cNoChar = '×';

  Function ValidRecord(oDataSet:TDataSet; const Args: array of const):Boolean;
  procedure NewRecDefa(oQuery:TDataSet; const Args: array of const);
  Function ErrPost(E:EDatabaseError;oField:TField):Boolean;
  function fsumField(oField:TField):Double;
  procedure psumFields(Vars:array of PDouble;fFields:array of TField);
  procedure FsumFields(oDataSet:TDataSet; Vars:array of PDouble; FieldNames:array of String);
  procedure SumRecord(oDataSet,wDataSet:TDataSet; const Args: array of const);

  function SetParamValueByN(oADOQuery:TADOQuery; sParamN:string; vValue:Variant):boolean;

  function ShowDlgChild(FormClass:TFormClass;oChildDlg:PForm):integer;
  function setDigits(Value:Double;sFormat:String):Double;

  function BrowsePath(Handle:HWND; sTitle:string;var sPath:String):boolean;
  function GetMachineName:String;
  function GetIpAddr() :string;
  function GetWindowsVersion: String;
  function fExp(nBase:Extended;iPower:integer):Extended;
  procedure SetFormPixelEx(oForm:TForm);

  procedure AutoLaunch_Add(sName,sValue :string; nflag:integer);

  function CopyDir(psSource, psDesti :string; pfCallBack:TBrowseCallBackFunc):boolean;
  procedure BrowseDir(psSource:string; pfCallBack:TBrowseCallBackFunc);

  procedure SetSysDateFormat(sFormat :string);
  procedure SetSysTimeFormat(sFormat :string);
  function GetSysTimeFormat() :string;

  procedure AdjustToken();
  
implementation

procedure MsgBox(sInfo:string);
begin
     Application.MessageBox(PChar(sInfo),'操作提示',MB_ICONWARNING);
end;

procedure MsgBoxInfo(sInfo:string);
begin
     Application.MessageBox(PChar(sInfo),'提示信息',MB_ICONINFORMATION);
end;

procedure MsgBoxErr(sInfo:string);
begin
     Application.MessageBox(PChar(sInfo),'操作失败',MB_ICONSTOP);
end;

Function MsgBoxSel(sInfo:string):Boolean;
begin
     if Application.MessageBox(PChar(sInfo),'操作确认',
        MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2) = IDYES then
          Result := TRUE
     else Result := FALSE;
end;

Function MsgBoxSely(sInfo:string):Boolean;
begin
     if Application.MessageBox(PChar(sInfo),'操作确认',
        MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON1) = IDYES then
          Result := TRUE
     else Result := FALSE;
end;

Function MsgBoxSel3(sInfo:string):integer;
begin
	case Application.MessageBox(PChar(sInfo),'操作确认',
        MB_ICONQUESTION+MB_YESNOCANCEL+MB_DEFBUTTON2) of
    IDYES: Result :=1;
    IDNO: Result :=2;
    else Result :=0;
	end;
end;

Function MsgBoxSelk(sInfo:string):boolean;
begin
       if Application.MessageBox(PChar(sInfo),'操作确认',
        MB_ICONQUESTION+MB_OKCANCEL+MB_DEFBUTTON1) = IDOK then
          Result := TRUE
     else Result := FALSE;
end;

function ExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): THandle;
var
  zFileName, zParams, zDir: array[0..79] of Char;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil, StrPCopy(zFileName, FileName),
                         StrPCopy(zParams, Params), StrPCopy(zDir, DefaultDir), ShowCmd);
end;

function ExecuteURL(UrlString:String): boolean;
begin
    result := (ExecuteFile(URLString, '', '', SW_SHOWNOACTIVATE) > 32);
end;

function setDigits(Value:Double;sFormat:String):Double;
begin
  Result:=strToFloat(FormatFloat(sFormat,Value));
end;

function GetWindowsVersion: String;
var
  Ver: TOsVersionInfo;
begin
  Ver.dwOSVersionInfoSize := SizeOf(Ver);
  GetVersionEx(Ver);
  with Ver do begin
    case dwPlatformId of
      VER_PLATFORM_WIN32s: Result := '32s';
      VER_PLATFORM_WIN32_WINDOWS:
        begin
          dwBuildNumber := dwBuildNumber and $0000FFFF;
          if (dwMajorVersion > 4) or ((dwMajorVersion = 4) and
            (dwMinorVersion >= 10)) then
            Result := '98' else
            Result := '95';
        end;
      VER_PLATFORM_WIN32_NT: Result := 'NT';
    end;
  end;
end;

procedure SetSysDateFormat(sFormat :string);
var
  regf:TRegistry;
const
 sKey = 'Control Panel\International';
begin
  regf := TRegistry.Create;
  regf.RootKey := HKEY_CURRENT_USER;
  regf.OpenKey(sKey, true);
  regf.WriteString('sShortDate', sFormat);
  regf.Free;

{  SendMessage(HWND_BROADCAST,
              WM_SETTINGCHANGE,
              0,
              LongInt(PChar('HKEY_CURRENT_USER\Control Panel\International\')));
 }
end;

procedure SetSysTimeFormat(sFormat :string);
var
  regf:TRegistry;
  h :THandle;
const
 sKey = 'Control Panel\International';
begin
  regf := TRegistry.Create;
  regf.RootKey := HKEY_CURRENT_USER;
  regf.OpenKey(sKey, true);
  regf.WriteString('sTimeFormat', sFormat);
  regf.Free;
  SendMessage(FindWindow('Progman', 'Program Manager'), WM_COMMAND, 106597,
   0);
end;

function GetSysTimeFormat() :string;
var
  regf:TRegistry;
const
 sKey = 'Control Panel\International';
begin
  regf := TRegistry.Create;
  regf.RootKey := HKEY_CURRENT_USER;
  regf.OpenKey(sKey, true);
  result := regf.ReadString('sTimeFormat');
  regf.Free;
end;

procedure AdjustToken();
var
  hdlProcessHandle : Cardinal;
  hdlTokenHandle : Cardinal;
  tmpLuid : Int64;
  tkpPrivilegeCount : Int64;
  tkp : TOKEN_PRIVILEGES;
  tkpNewButIgnored : TOKEN_PRIVILEGES;
  lBufferNeeded : Cardinal;
  Privilege : array[0..0] of _LUID_AND_ATTRIBUTES;
begin
         hdlProcessHandle := GetCurrentProcess;
         OpenProcessToken(hdlProcessHandle,
                         (TOKEN_ADJUST_PRIVILEGES Or TOKEN_QUERY),
                          hdlTokenHandle);

         // Get the LUID for shutdown privilege.
         LookupPrivilegeValue('', 'SeShutdownPrivilege', tmpLuid);
         Privilege[0].Luid := tmpLuid;
         Privilege[0].Attributes := SE_PRIVILEGE_ENABLED;
         tkp.PrivilegeCount := 1;   // One privilege to set
         tkp.Privileges[0] := Privilege[0];
         // Enable the shutdown privilege in the access token of this
         // process.
         AdjustTokenPrivileges(hdlTokenHandle,
                               False,
                               tkp,
                               Sizeof(tkpNewButIgnored),
                               tkpNewButIgnored,
                               lBufferNeeded);

 end;


//*****************

Function strLeft(Str:String;n:integer):String;
begin
  Result := Copy(Str,1,n);
end;

Function strRight(Str:String;n:integer):String;
begin
  Result := Copy(Str,Length(Str)-n+1, n);
end;

Function FCopy(fS,fD:string;pgBar:TProgressBar):integer;
var Fin,Fout:integer;
    i,size :longint;
    buff :array[0..1024] of byte;
begin
  fin := FileOpen(fs, fmOpenRead +fmShareDenyWrite);
 if fin= -1 then
  begin
   Result := 1;
   Exit;
  end;
 fout := FileCreate(fD);
 if fout =-1 then
 begin
  FileClose(Fin);
  Result := 2;
  Exit;
 end;
  size := FileSeek(Fin,0,2);
  if size =-1 then
  begin
    Result := 3;
    Exit;
  end;
 pgBar.Min := 0;
 pgBar.Max := size Div 1024;
 pgBar.step :=1;
 FileSeek(Fin,0,0);
 Repeat
  size := fileRead(Fin,buff,1024);
  if FileWrite(Fout,buff,size)< size then
  begin
    result :=4;     //磁盘空间不够或其它原因无法继续拷贝
    FileClose(Fin);
    FileSeek(Fout,0,0);
    buff[0] := byte(-1);
    FileWrite(Fout,buff,1);
    FileClose(FOut);

    DeleteFile(Fd); //删除未完整拷贝文件
    Exit;
  end;
  pgBar.StepIt;
  pgBar.Parent.Update;
 until size <> 1024 ;
 FileClose(Fin);
 FileClose(Fout);
 Result := 0;
 pgBar.Position := pgBar.Max;
end;

Function iif(exp :boolean;value1,value2 :variant):variant;
begin
  if exp then
   Result := value1
 else Result := value2;
end;


function NumTOChinaCode(i:Real):string;
const
  d='零壹贰叁肆伍陆柒捌玖分角圆拾佰仟万拾佰仟亿';
var
  m,k:string;
  j:integer;
begin
  k:='';
  m:=floattostr(int(i*100));
  for j:=length(m) downto 1 do
    k:=k+d[(strtoint(m[Length(m)-j+1])+1)*2-1]+
      d[(strtoint(m[Length(m)-j+1])+1)*2]+d[(10+j)*2-1]+d[(10+j)*2];
  result:=k;
end;

var
 Cdigs:array[0..9] of string=('零','壹','贰','叁','肆','伍',
         '陆','柒','捌','玖');
 Cdsets:array[1..18] of string=('万','仟','佰','拾','亿',
       '仟','佰','拾','万','仟','佰','拾','圆','','角','分','厘','毫');

Function GetCmoney(const Outv :real):string;
var DStr,outStr,tmpstr: string;
    dsize,i:integer;
    CanZ: boolean;
begin
    CanZ := False;
    Dstr := formatfloat('0.0000',Outv);
    dsize := length(Dstr);
    outStr :='';
    for i:=dsize Downto 1 do
    begin
      if Dstr[i]='0' then
       begin
         if Canz then
          begin
           CanZ := False;
           tmpstr := '零'
          end
         else tmpstr := '';

         if (CdSets[18-(Dsize-i)]='圆') or
            (CdSets[18-(Dsize-i)]='万') or
            (CdSets[18-(Dsize-i)]='亿')
         then tmpstr := CdSets[18-(Dsize-i)]+tmpstr;
       end
     else
      if Dstr[i]='.' then
       begin
         //   if Copy(dstr,dsize-3,4)='0000' then
          //      tmpstr := '整'
             tmpstr := '';
       end
      else if Dstr[i]='-' then
         TmpStr := '负'
     else
      begin
        tmpStr := Cdigs[StrToInt(Dstr[i])] + CdSets[18-(Dsize-i)];
        if Not CanZ then
           CanZ := true;
      end;
      OutStr := TmpStr+OutStr;
    end;
   if Copy(dstr,dsize-2,3)='000' then 
     OutStr :=OutStr+ '整';
  Result := OutStr;
end;

function BrowsePath(Handle:HWND; sTitle:string; var sPath:String):boolean;
var info : browseinfo;
    lpBuffer : Pchar;
    pidlBrowse,pidlPrograms :PItemIDList;
begin
   Result := False;                           
   GetMem(lpBuffer,MAX_PATH);
   if lpBuffer = nil then
    Exit;
    if ( Not SUCCEEDED(SHGetSpecialFolderLocation(
            handle, CSIDL_DESKTOP, pidlPrograms))) then
        Exit;

    info.hwndOwner := Handle;
    info.pidlRoot := pidlprograms;
    info.pszDisplayName := lpBuffer;
    info.lpszTitle := pchar(sTitle);//sHint;
    info.lpfn := nil;
    info.ulFlags :=  0; //BIF_RETURNONLYFSDIRS ;//or BIF_BROWSEFORCOMPUTER;
    info.lParam :=0;
    info.iImage := 0;
    pidlBrowse := SHBrowseForFolder(info);
  if (SHGetPathFromIDList(pidlBrowse, lpBuffer)) then
  begin
     Result := True;
     sPath := lpBuffer
  end;
    FreeMem(lpBuffer);
end;

procedure psumFields(Vars:array of PDouble;fFields:array of TField);
var tmp:Double;
  Book :TBookMark;
  i:integer;
  oDataSet:TDataSet;
begin
   oDataSet := fFields[0].DataSet;
   Book := oDataset.GetBookmark;
    oDataset.DisableControls;
   oDataset.First;
   for i:=0 to High(vars) do
   vars[i]^ :=0;
   try
     while Not oDataSet.Eof do
     begin
       for i:=0 to High(vars) do
       vars[i]^ := vars[i]^+ TFloatField(fFields[i]).Value;
       oDataSet.Next;
     end;
   finally
     oDataSet.EnableControls;
     oDataSet.GotoBookmark(Book);
     oDataSet.FreeBookmark(Book);
   end;
end;

procedure FsumFields(oDataSet:TDataSet; Vars:array of PDouble; FieldNames:array of String);
var tmp:Double;
  Book :TBookMark;
  i:integer;
  vIdx :array of Integer;
begin
  for i:=0 to High(vars) do
   vars[i]^ :=0;
  if oDataset.IsEmpty then
   Exit;

   Book := oDataset.GetBookmark;
    oDataset.DisableControls;
   oDataset.First;
   try
      VIdx := VarArrayCreate([0, High(FieldNames)], varInteger);
     for i:= 0 to High(FieldNames) do
        VIdx[i] := oDataSet.FieldByName(FieldNames[i]).Index;
                   
     while Not oDataSet.Eof do
     begin
       for i:=0 to High(vars) do
       vars[i]^ := vars[i]^+
              oDataSet.Fields[vIdx[i]].AsFloat;
       oDataSet.Next;
     end;
   finally
     oDataSet.EnableControls;
     oDataSet.GotoBookmark(Book);
     oDataSet.FreeBookmark(Book);
   end;
end;

function fsumField(oField:TField):Double;
var tmp:Double;
  Book :TBookMark;
begin
   Book := oField.Dataset.GetBookmark;
   oField.Dataset.DisableControls;
   oField.Dataset.First;
   tmp:=0;
   try
     while Not oField.DataSet.Eof do
     begin
       tmp :=tmp+oField.AsFloat;
       oField.DataSet.Next;
     end;
   finally
     Result := Tmp;
     oField.DataSet.EnableControls;
     OField.DataSet.GotoBookmark(Book);
     oField.DataSet.FreeBookmark(Book);
   end;
end;
//*****************

Function Space(const Count: integer):string;
var i:integer;
begin
  Result :='';
  for i:=1 to Count do
  Result := Result +' ';
end;

//****************
procedure RefreshQuery(oQuery:TQuery);
var SavePlace:TBookMark;
begin
//浏览窗口刷新数据,并恢复记录指针
   	with oQuery do
    begin
    	DisableControls;
	    SavePlace := GetBookmark;
        Close;
        Open;
		try
        	GotoBookmark(SavePlace);
		Except
        	Last;
        end;
    	FreeBookmark(SavePlace);
		EnableControls;
    end
end;

procedure RefreshBrowse(oQuery:TQuery;
	const KeyFields:String; const KeyValues:String);
begin
//刷新浏览窗口数据,并按编码定位记录
   	with oQuery do
    begin
    	DisableControls;
        Close;
        Open;
        if not IsEmpty then
        	if not Locate(KeyFields,KeyValues,[])
            	then Last;
		EnableControls;
    end
end;

Function ExecDel(sErrNote:string; nID:integer; oDelProc:TStoredProc):Boolean;
begin
//浏览窗口删除记录
	Result :=False;
	if nID =0 then MessageBeep(0)
	else if MsgBoxSel('是否真的要删除此'+sErrNote+ '？') then
    with oDelProc do
    begin
		ParamByName('@nID').Value := nID;
    	Prepare;
    	ExecProc;
        if Params[0].Value <>0 then
        begin
	    	if Params[0].Value =-101 then MsgBoxErr('此' +sErrNote+ '已启用，不能删除!')
    	    else MsgBoxErr('无法删除此' +sErrNote+ ',可能是因为共享冲突,请重试！');
        end
        else Result :=True;
    end;
end;

procedure CreateDlg(FormClass:TFormClass;oChildDlg:PForm);
begin
//连接通用输入对话框,与<DestroyDlg>联用
	if oChildDlg^=nil then
    begin
    	Application.CreateForm(FormClass, oChildDlg^);
        oChildDlg^.Tag :=1;
    end
    else oChildDlg^.Tag := oChildDlg^.Tag +1;
end;

procedure DestroyDlg(FormClass:TFormClass;oChildDlg:PForm);
begin
//断开连接通用输入对话框,与<CreateDlg>联用
	if oChildDlg^<>nil then
    begin
        oChildDlg^.Tag := oChildDlg^.Tag -1;
        if oChildDlg^.Tag <=0 then
        begin
        	oChildDlg^.Release;
            oChildDlg^ :=nil;
        end;
    end;
end;

Function ValidRecord(oDataSet:TDataSet; const Args: array of const):Boolean;
var i:integer; lInValid:Boolean; oField:TField;
begin
//数据完整性检验
  lInValid :=False;
  for i:=0 to Trunc(High(Args)/2) do
  begin
  	oField := oDataSet.FieldByName(Args[i*2].VPChar);
  	Case Args[i*2+1].VInteger of
    	vrvZero: lInValid := (oField.AsFloat =0);
        vrvNull: lInValid := oField.IsNull;
        vrvEmpty: lInValid := (trim(oField.AsString) ='');
    end;
    if lInValid then
    begin
    	MsgBox('请正确输入' +oField.DisplayLabel+ '！');
    	oField.FocusControl;
    	break;
    end;
  end;
  Result := not (lInValid);
end;

procedure NewRecDefa(oQuery:TDataSet; const Args: array of const);
var i:integer; oField:TField;
begin
//设置新增记录默认值
  for i:=0 to Trunc(High(Args)/2) do
  begin
  	oField := oQuery.FieldByName(Args[i*2].VPChar);
    oField.AssignValue(Args[i*2+1]);
  end;
end;

Function ErrPost(E:EDatabaseError; oField:TField):Boolean;
var sErrMsg :Array[1..4] of string;
	i :integer;
 const eKeyViol=9729;
     var  successPost:boolean;
begin
      successPost:=False;
   if (E is EDBEngineError) then
    case (E As EDBEngineError).Errors[0].Errorcode of
     eKeyViol:
    begin
        MsgBox('保存错误,请注意' +oField.DisplayLabel+ '不能重复！');
    	oField.FocusControl;
        successPost:=True;
    end;
    end;
      Result :=successPost;
end;

procedure SumRecord(oDataSet,wDataSet:TDataSet; const Args: array of const);
var i,k :integer;
	oaField :array of TField;
    nSum :array of double;
	SavePlace:TBookMark;
begin
//单据明细汇总
	k :=Trunc(High(Args)/2);
     //	if not (TFloatField(Args[1].VObject).DataSet.State in [dsEdit,dsInsert])
       //	then   TFloatField(Args[1].VObject).DataSet.Edit;
   if Not wDataSet.Modified then
       wDataSet.Edit;
	if oDataSet.IsEmpty then
    begin
		for i:=0 to k do
	        	TFloatField(Args[i*2+1].VObject).Value :=0;
        Exit;
    end;

    SetLength(oaField,k+1);
    SetLength(nSum,k+1);
	for i:=0 to k do
	begin
		oaField[i] := oDataSet.FieldByName(Args[i*2].VPChar);
        nSum[i] :=0;
	end;

	with oDataSet do
    begin
		DisableControls;
		try
		    SavePlace := GetBookmark;
			First;
			while not EOF do
			begin
            	for i:=0 to k do nSum[i] :=nSum[i] +oaField[i].AsFloat;
				Next;
			end;
        	GotoBookmark(SavePlace);
		finally
			EnableControls;
		end;
	end;
	for i:=0 to k do
		TFloatField(Args[i*2+1].VObject).Value :=nSum[i];
end;

function ShowDlgChild(FormClass:TFormClass;oChildDlg:PForm):integer;
begin
//	oChildDlg^ :=FormClass.Create(Application);
      Application.CreateForm(FormClass,oChildDlg^);
      Result:=oChildDlg^.ShowModal();
    oChildDlg^.Release;
end;

function fExp(nBase:Extended;iPower:integer):Extended;
var i:integer;
    nTemp:Extended;
begin
  if iPower >0 then
    nTemp := nBase
  else
    nTemp := 1;
  for i:=1 to iPower-1 do
   nTemp := nTemp *nBase;
  Result := nTemp;
end;

function GetMachineName:string;
var ps:array[0..MAX_COMPUTERNAME_LENGTH] of Char;
    n:Cardinal;
begin
    n := MAX_COMPUTERNAME_LENGTH+1;
    GetComputerName(ps,n);
    Result := string(Ps);
end;

function GetIpAddr() :string;
var
  thisHost : PHostEnt;
  InAddr : in_addr;
  WSAData: TWSAData;
  MyName :array[0..100] of char;
begin                  
 result := '';
 WSAStartup(2, WSAData);
 if(GetHostName(MyName, 80)= SOCKET_ERROR) then
     Exit;
 thisHost := GetHostByName(MyName);
 if ThisHost = nil then
   Exit;
  with thisHost^ do          
 result:= Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]),
              Byte(h_addr^[2]), Byte(h_addr^[3])]);
  WSACleanup();
end;

procedure SetFormPixelEx(oForm:TForm);
var nw,nh,i,j, nchgsize:integer;
    wbl,hbl:real;
begin
 with oForm do
  begin
    nw := screen.Width;
    nh := screen.Height;
    wbl := nw/800;
    hbl := nh/600;
    width := trunc(Width*wbl);
    Height := trunc(Height*wbl);
    if nw = 800 then
       Exit;
    case nw  of
      800 : nchgsize := 0;
      640 : nchgsize := -1;
      1024 : nchgsize := 1;
    end;
    if nw >1024 then
      nchgsize := 2;

    for i:=0 to ComponentCount -1 do
     begin
       if Components[i] is TControl then
         with TControl(Components[i]) do
         begin
            Width := trunc(Width*wbl);
            Height := trunc(Height*hbl);
            top := trunc(top*hbl);
            left := trunc(left*wbl);
          end;

          if (Components[i] is TLabel) or  (Components[i] is TPanel)
             or (Components[i] is TEdit)
             or (Components[i] is TDBEdit)
             or (Components[i] is TDgxk)
             or (Components[i] is TCustomGrid)
             or (Components[i] is TBitBtn)
             or (Components[i] is TButton)
             or (Components[i] is TSpeedButton) then
            with TLabel(Components[i]) do
            begin
               if not ((nchgsize <0) and (Font.Size <=10)
                 and  not (fsBold in Font.Style)
                     )  then
                  Font.Size := Font.Size + nchgsize;
                 // ParentFont := false;
            end;

          if (Components[i] is TCustomGrid) then
            with TDBGrid(Components[i]) do
            begin
                for j:=0 to  Columns.Count -1 do
                begin
                   Columns[j].Width := trunc(Columns[j].Width * wbl);
                   Columns[j].Font.Size := Columns[j].Font.Size+ nchgsize;
                   Columns[j].Title.Font.Size := Columns[j].Title.Font.Size+
                          nchgsize;
                end;
             end;
                  
             if (Components[i] is TDBGridEx) then
               with TDBGridEx(Components[i]) do
                begin
                  FooterFont.Size := FooterFont.Size +nchgsize;
                  if RowHeight >0 then
                    RowHeight := Round(RowHeight *hbl)+1
                end;
     end;

      Font.Size := Font.Size + nchgsize;
   end;
end;

procedure AutoLaunch_Add(sName,sValue :string; nflag:integer);
var
 regf:tRegistry;
begin
      regf:=tregistry.create;
      regf.rootkey:=hkey_local_machine;
      regf.openkey('software\microsoft\windows\currentversion\run',true);
      regf.DeleteValue(sName);
      if nflag =1 then
         regf.writestring(sName, sValue);
      regf.free;
end;

function SetParamValueByN(oADOQuery:TADOQuery; sParamN:string; vValue:Variant):boolean;
var i:integer;
begin
        result := false;
        for i:=0 to oADOQuery.Parameters.Count -1 do
        if UPPERCASE(oADOQuery.Parameters[i].Name)= UPPERCASE(sParamN)
        then begin
                  oADOQuery.Parameters[i].Value := vValue;
                  result := true;
             end;
      if not result then
        MsgBox('参数'+sParamN+'不存在!');

end;

function CopyDir(psSource, psDesti :string; pfCallBack:TBrowseCallBackFunc):boolean;
var tStack :TStringList;
  Status: Integer;
  SearchRec: TSearchRec;
  tsCurrent :string;
  tsDesti,tsTemp,tsTemp2 :string;
begin
  result := false;
  tStack := TStringList.Create;
  tStack.Add(psSource);
 while tStack.Count >0 do
 begin
    tsCurrent := tStack[tStack.Count -1];  //出栈
    tStack.Delete(tStack.Count -1);

    tsTemp := Copy(tsCurrent, length(psSource)+1, 255); //相对路径
    tsDesti := psDesti+iif(StrLeft(tsTemp,1)='\','','\')+ tsTemp;
    if not DirectoryExists(tsDesti) then
        CreateDir(tsDesti);

    tsTemp := tsCurrent + iif(strright(tsCurrent,1)='\','','\')+'*.*';
    Status := FindFirst(tsTemp, faAnyFile, SearchRec);

    while Status = 0 do
    begin
      if (SearchRec.Attr and faDirectory = faDirectory) then //directory
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          tsTemp := tsCurrent+iif(strright(tsCurrent,1)='\','','\')+
                     SearchRec.Name;  //取得绝对路径
          tStack.Add(tsTemp);  //进栈
        end;
      end
     else  //file
      begin
         tsTemp := tsCurrent+iif(strright(tsCurrent,1)='\','','\')+
                     SearchRec.Name;
         tsTemp2 := tsDesti+iif(strright(tsDesti,1)='\','','\')+
                     SearchRec.Name;

          if @pfCallBack <> nil then
            pfCallBack(tsTemp);

          CopyFile(PChar(tsTemp), PChar(tsTemp2), LongBool(1));
      end;
      Status := FindNext(SearchRec);
    end;
  end;
   result := true;
end;

procedure BrowseDir(psSource:string; pfCallBack:TBrowseCallBackFunc);
var tStack :TStringList;
  Status: Integer;
  SearchRec: TSearchRec;
  tsCurrent :string;
  tsDesti,tsTemp,tsTemp2 :string;
begin
//  Result := 0;
  tStack := TStringList.Create;
  tStack.Add(psSource);
 while tStack.Count >0 do
 begin
    tsCurrent := tStack[tStack.Count -1];  //出栈
    tStack.Delete(tStack.Count -1);

    tsTemp := Copy(tsCurrent, length(psSource)+1, 255); //相对路径

    tsTemp := tsCurrent + iif(strright(tsCurrent,1)='\','','\')+'*.*';
    Status := FindFirst(tsTemp, faAnyFile, SearchRec);

    while Status = 0 do
    begin
      if (SearchRec.Attr and faDirectory = faDirectory) then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          tsTemp := tsCurrent+iif(strright(tsCurrent,1)='\','','\')+
                     SearchRec.Name;
          tStack.Add(tsTemp);  //进栈
        end;
      end
     else  //file
      begin
         tsTemp := tsCurrent+iif(strright(tsCurrent,1)='\','','\')+
                     SearchRec.Name;

          if @pfCallBack <> nil then
            pfCallBack(tsTemp);
      end;
      Status := FindNext(SearchRec);
    end;
  end;
end;

end.
