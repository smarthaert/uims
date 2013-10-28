unit OCRlib;

interface
//Download by http://www.codefans.net
uses
  IniFiles, Classes, SysUtils,
  OCRcore, MyUtils;

type
  TEngineObj = record
    Engine : TOCRengine;
    Active : boolean;
    Handle : THandle;
  end;
const
  MAX_THREAD = 64;

var
  OCR : array[0..MAX_THREAD-1] of TEngineObj;

  function LoadOCRlib : boolean; stdcall;
  procedure FreeOCRlib ;stdcall;
  function CreateEngine(var h: THandle):boolean; stdcall;
  procedure FreeEngine(h: THandle) ; stdcall;
  function OCRForumCodeImg(h : THandle; iType : Byte; url,filename: PChar; var Code : PChar; var TimeSpend : Integer):boolean;stdcall;
  function SetTemplate(h : THandle; idx: Integer):boolean; stdcall;
  function OCRImage(h : THandle; var Code : PChar) : boolean; stdcall;
  procedure SetImage(h : THandle; filename : PChar); stdcall;

implementation

function LoadOCRlib : boolean;stdcall;
var
  Ini : TiniFile;
  OCRlib,RecSl : TStringList;
  i : Byte;
  Tmp : String;
  procedure InitEngineList;
  var
    j : Byte;
  begin
    for j:= 0 to MAX_THREAD-1 do
    begin
      OCR[i].Handle := 0;
      OCR[i].Engine := nil;
      OCR[i].Active := False;
    end;
  end;
begin
  Result := true;
  AppPath := ExtractFilePath(ParamStr(0));
  Ini := TiniFile.Create(AppPath+OCR_LIB_PATH+CONFIG_FILE);
  OCRlib := TStringList.Create;
  GetIniSecStrings(Ini,SECTION,OCRlib);
  if OCRlib.Count > 0 then
  begin
    SetLength(OCRlibRecs,OCRlib.Count);
    for i:= Low(OCRlibRecs) to High(OCRlibRecs) do
    begin
      RecSl := TStringList.Create;
      SeperateStrPro(OCRlib[i],WP,RecSl);
      if RecSl.Count > 8 then
      begin
        GetMem(OCRlibRecs[i], SizeOf(TOCRlibRec));
        try
          with OCRlibRecs[i]^ do
          begin
            TplName := RecSl[0];
            PicFormat := StrToInt(RecSl[1]);
            CusDiv := StrSpLeft(RecSl[2],Pp) = '1';
            Tmp := StrLeft(StrSpRight(RecSl[2],Pp),1);
            if Tmp = '<' then DivCmp := 2
            else if Tmp = '=' then DivCmp := 1
            else DivCmp := 0;
            DivColr := HexToInt(StrRight(StrSpRight(RecSl[2],Pp),6));
            PicWidth := StrToInt(StrSpLeft(RecSl[3],Xp));
            PicHeight := StrToInt(StrSpRight(RecSl[3],Xp));
            CmpBg := StrSpLeft(RecSl[4],Pp) = '1';
            CmpChr := StrSpRight(RecSl[4],Pp) = '1';
            ClrRect := StrSpLeft(RecSl[5],Pp) = '1';
            RectLen := StrToInt(StrSpRight(RecSl[5],Pp));
            CodeUrl := RecSl[6];
            AlphaCase := RecSl[7] = '1';
            BbsType := StrToInt(RecSl[8]);
          end;
        except on e : exception do
          begin
            Result := False;
            RecSl.Free;
            MsgBox('配置文件格式错误！'+#13#13+IntToStr(i+1)+':'+e.Message,0);
            break;
          end;
        end;
      end else begin
        Result := False;
        RecSl.Free;
        MsgBox('读取配置时发生错误，没有足够的参数！'+#13#13+
                IntToStr(i+1)+':'+'缺少'+
                IntToStr(9-RecSl.Count)+'项',0);
        Break;
      end;
      RecSl.Free;
    end;
  end;
  OCRlib.free;
  Ini.Free;
  InitEngineList;
end;

procedure FreeOCRlib ;stdcall;
var
  i : Byte;
begin
  for i:= Low(OCRlibRecs) to High(OCRlibRecs) do
  FreeMem(OCRlibRecs[i]);
end;


function CreateEngine(var h: THandle):boolean; stdcall;
var
  i : Integer;
begin
  Result := False;
  for i:= Low(OCR) to high(OCR) do
  begin
    if not OCR[i].Active then
    begin
      OCR[i].Engine := TOCRengine.Create;
      h := THandle(@OCR);
      OCR[i].Handle := h;
      OCR[i].Active := True;
      Result := True;
      Exit;
    end;
  end;
end;

procedure FreeEngine(h : THandle);stdcall;
var
  i : Integer;
begin
  for i:= Low(OCR) to high(OCR) do
  begin
    if (OCR[i].Handle = h) and OCR[i].Active then
    begin
      OCR[i].Engine.Free;
      OCR[i].Active := False;
      OCR[i].Handle := 0;
    end;
  end;
end;

function OCRForumCodeImg(h : THandle; iType : Byte; Url,FileName: PChar; var Code : PChar; var TimeSpend : Integer):boolean;stdcall;
begin
  With POCRengine(h)^ do
  begin
    _BbsType := iType;  //not used yet
    _PicFile := StrPas(FileName);
    _CodeUrl := StrPas(Url);
    RecogForumCodeImg;
    Code := @_CodeStr[1];
    TimeSpend := _TimeSpend;
    Result := _CodeStr<>'?';
  end;
end;

procedure SetImage(h : THandle; filename : PChar); stdcall;
begin
  with POCRengine(h)^ do
  _BITMAP := PIC2BMP(StrPas(filename));
end;

function SetTemplate(h : THandle; idx: Integer):boolean; stdcall;
begin
  Result := False;
  if (idx > -1) and (idx < High(OCRlibRecs)+1) then
  with POCRengine(h)^ do
  begin
    _TplName := OCRlibRecs[idx-1].TplName;
    Result := LoadCharInfo;
  end;
end;

function OCRImage(h : THandle; var Code : PChar) : boolean; stdcall;
begin
  with POCRengine(h)^ do
  begin
    GetStringFromImage(_BITMAP);
    Code := @_CodeStr[1];
    Result := _CodeStr<>'?';
  end;
end;

end.
