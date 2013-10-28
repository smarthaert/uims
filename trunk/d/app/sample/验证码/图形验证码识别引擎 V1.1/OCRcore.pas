unit OCRcore;

interface
//Download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtDlgs, ComCtrls, ShellAPI, IniFiles,
  GIFImage, JPEG, PNGimage, DateUtils;

type //字符特征码
  RChar = record
    MyChar: char;
    MyCharInfo: array[0..49, 0..49] of byte;
  end;

type //字符特征文件
  RCharInfo = record
    Sng: integer; //文件类型标识
    Ver: real; //版本号
    charwidth: byte; //字符宽度
    charheight: byte; //字符高度
    X0: byte; //第一个字符开始x偏移
    TotalChars: byte; //图象字符总数
    allcharinfo: array[0..35] of RChar;
  end;

type
  POCRengine = ^TOCRengine;
  TOCRengine = class(TObject)
  private
    _CusDiv : Boolean;
    _DivCmp : Byte; //  0:>  1:=  2:<
    _DivColr : TColor;
    _PicWidth, _PicHeight : Byte;
    _PicFormat : Byte ; // 0:unassigned  1:BMP  2:PNG  3:GIF  4:JPG
    _AlphaCase : boolean ;// true:UpperCase  false:LowerCase
    _ClrRect : boolean;
    _RectLen : Byte;
    _CmpChr, _CmpBg : boolean;
    _Fetched : Boolean;
    MyCharInfo: RCharInfo;
    procedure Init;
    procedure Fetch(itype: Integer; width,height,format: byte; url : String);
    function CMPBMP(SBMP: TBITMAP; x0, m: integer): integer;
    function CMPBMPPRO(SBMP: TBITMAP; x0, m: integer): integer;
    //
    //procedure DebugStr(Prefix,Content,Path : String);
    //procedure DebugLog(s : String);
  public
    _BITMAP : TBITMAP;
    _BbsType : Byte;
    _PicFile : String[100];
    _CodeUrl : String[200];
    _CodeStr : String[10];
    _TplName : String[50];
    _TimeSpend : Integer;
    procedure RecogForumCodeImg;
    procedure ShowAllCharInfo;
    function LoadCharInfo : boolean;
    function GetStringFromImage(SBMP: TBITMAP): string;
    function PIC2BMP(filename: string): TBITMAP;
    //
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  OCRlib, MyUtils;

constructor TOCRengine.Create;
begin
  _BITMAP := TBITMAP.Create;
end;


destructor TOCRengine.Destroy;
begin
  _BITMAP.free;
end;

procedure TOCRengine.Init;
begin
  _DivColr := $7FFFFF;
  _ClrRect := False;
  _CmpChr := False;
  _CmpBg := True;
  _AlphaCase := False;
  _PicFormat := 0;
  _CodeStr := '?';
  _TimeSpend := 0;
end;


{procedure TOCRengine.DebugStr(Prefix,Content,Path : String);
var
  sl : TStringList;
  filename : String;
begin
  filename := Copy(ExtractFileName(_PicFile),1,5);
  sl := TStringList.create;
  sl.add(Content);
  sl.SaveToFile(Path+'\'+filename+'_'+Prefix+'.txt');
  sl.free;
end;

procedure TOCRengine.DebugLog(s : String);
var
  f : textFile;
  FileName : String;
begin
  //if bLogFTP then
  //begin
    FileName := ExtractFilePath(Application.ExeName)+'OCR.log';
    try
      AssignFile(f,FileName);
      if FileExists(FileName) then
        Append(f)
      else
        ReWrite(f);
      WriteLn(f,DateTimeToStr(now)+' : '+s);
    finally
      CloseFile(f);
    end;
  //end;
end;             }

procedure TOCRengine.RecogForumCodeImg;
var
  BeginTime,EndTime : TDateTime;
begin
  if (_PicFile<>'')and(_CodeUrl<>'')and(_BbsType<>0) then
  begin
    BeginTime := Now;
    //_BITMAP.Assign(PIC2BMP(_PicFile));
    //_BITMAP.Canvas.Lock;
    _BITMAP := PIC2BMP(_PicFile);
    //_BITMAP.Canvas.Unlock;
    //_BITMAP.SaveToFile(AppPath + copy(ExtractFileName(_PicFile),1,5)+'_BITMAP'+'.bmp');
    if _Fetched then
    begin
        while not bCanLoad do Sleep(100);
        //DebugStr('PIC_W_H',IntToStr(_PicWidth)+'*'+IntToStr(_PicHeight),'e:');
      //if WaitForSingleObject(mEvent, INFINITE) = WAIT_OBJECT_0 then
      //begin
        //ResetEvent(mEvent);
        bCanLoad := False;
        LoadCharInfo;
        bCanLoad := True;
        //ShowAllCharInfo;
        //SetEvent(mEvent);
      //end;
      _CodeStr := GetStringFromImage(_BITMAP);
      if _AlphaCase then
      _CodeStr := UpperCase(_CodeStr);
    end;
    EndTime := Now;
    _TimeSpend := MilliSecondsBetween(EndTime,BeginTime);
    //_BITMAP.SaveToFile(AppPath + copy(ExtractFileName(_PicFile),1,5)+'_BITMAP'+'.bmp');
  end;
end;


procedure TOCRengine.Fetch(itype: Integer; width,height,format: byte; url : String);
var
  Rec : POCRlibRec;
begin
  _Fetched := FetchOCRtype(itype,url,width,height,format,Rec);
  if _Fetched then
  begin
    _CusDiv := Rec.CusDiv;
    _TplName := Rec.TplName;
    if _CusDiv then
    begin
      _DivCmp := Rec.DivCmp;
      _DivColr := Rec.DivColr;
    end;
    _AlphaCase := Rec.AlphaCase;
    _ClrRect := Rec.ClrRect;
    _RectLen := Rec.RectLen;
    _CmpChr := Rec.CmpChr;
    _CmpBg := Rec.CmpBg;
    if (not _CmpBg) and (not _CmpChr) then
    begin
      _CmpChr := False;
      _CmpBg := True;
    end;
  end;
end;


procedure TOCRengine.ShowAllCharInfo;
var
  BMP: TBITMAP;
  i, j, k: integer;
begin
  BMP := TBITMAP.Create;

  BMP.Width := (MyCharInfo.charwidth + 5) * 36 - 5;
  BMP.Height := MyCharInfo.charheight;
  BMP.Canvas.Brush.Color := clMoneygreen;
  BMP.Canvas.FloodFill(1, 1, clblack, fsBorder);

  for k := 0 to 35 do
    for i := 0 to MyCharInfo.charwidth do
      for j := 0 to MyCharInfo.charheight do
        if MyCharInfo.allcharinfo[K].MyCharInfo[i, j] > 0 then
          BMP.Canvas.Pixels[i + k * (MyCharInfo.charwidth + 5), j] := clblack;
  //BMP.SaveToFile(AppPath + copy(ExtractFileName(_PicFile),1,5)+'_CharInfo'+'.bmp');
  BMP.Free;
end;


function TOCRengine.LoadCharInfo : boolean;
var
  P: file of RCharInfo;
  //h: THandle;
begin
  Result := True;
  {TRY
    repeat
      h := CreateMutex(NIL, TRUE, 'OCR_PROCESS');
      Application.ProcessMessages;
    until GetLastError <> ERROR_ALREADY_EXISTS;  }
    try
      Assignfile(P, AppPath+OCR_Lib_Path + _TplName);
      reset(P);
      read(p, MycharInfo);
    except
      CloseFile(P);
      Result := False;
    end;
    CloseFile(P);
  //  CloseHandle(H);
  {FINALLY
    ReleaseMutex(H);
    CloseHandle(h);
  END;  }
end;

function TOCRengine.PIC2BMP(filename : string): TBITMAP;
var
  GIF: TGIFImage;
  jpg: TJPEGImage;
  BMP: TBITMAP;
  PNG: TPNGobject;
  FileEx: string;
  i, j, x: Byte;
  b : boolean;
  //
  SrcRGB : pByteArray;
  ClPixel : TColor;
begin
  Init;
  b := False;
  ClPixel := 0;
  FileEx := UpperCase(ExtractFileExt(filename));
  BMP := TBITMAP.Create;
  if FileEx = '.PNG' then
  begin
    PNG := TPNGobject.Create;
    try
      PNG.LoadFromFile(filename);
      _PicFormat := 2;
      BMP.Assign(PNG);
    except
      //not png image
    end;
    PNG.Free;
  end else if FileEx = '.BMP' then
    try
      BMP.LoadFromFile(filename);
      _PicFormat := 1;
    except
      //not bmp image
    end
  else if FileEx = '.GIF' then
  begin
    GIF := TGIFImage.Create;
    try
      GIF.LoadFromFile(filename);
      _PicFormat := 3;
      BMP.Assign(GIF);
    except
      //not gif image
    end;
    GIF.Free;
  end else if (FileEx = '.JPG') or (FileEx = '.JPEG') then
  begin
    JPG := TJPEGImage.Create;
    try
      JPG.LoadFromFile(filename);
      _PicFormat := 4;
      JPG.Grayscale := TRUE;
      BMP.Assign(JPG);
    except
      //not jpg image
    end;
    JPG.Free;
  end;
  //
  if _PicFormat = 0 then
    try
      BMP.LoadFromFile(FileName);
      _PicFormat := 1;
    except
    end;
  if _PicFormat = 0 then
  begin
    PNG := TPNGobject.Create;
    try
      PNG.LoadFromFile(FileName);
      _PicFormat := 2;
      BMP.Assign(PNG);
    finally
      PNG.Free;
    end;
  end;
  if _PicFormat = 0 then
  begin
    GIF := TGIFImage.Create;
    try
      GIF.LoadFromFile(FileName);
      _PicFormat := 3;
      BMP.Assign(GIF);
    finally
      GIF.Free;
    end;
  end;
  if _PicFormat = 0 then
  begin
    JPG := TJPEGImage.Create;
    try
      JPG.LoadFromFile(FileName);
      JPG.Grayscale := TRUE;
      BMP.Assign(JPG);
      _PicFormat := 4;
    finally
      JPG.Free;
    end;
  end;

  _PicWidth := BMP.Width;
  _PicHeight := BMP.Height;
  BMP.SaveToFile(_PicFile+'.BMP');

  Fetch(_BbsType,_PicWidth,_PicHeight,_PicFormat,_CodeUrl);

  Bmp.PixelFormat := pf24Bit;

  // make picture only black and white
  for j := 0 to BMP.Height - 1 do
  begin
    SrcRGB := BMP.ScanLine[j];
    for i := 0 to BMP.Width - 1 do
    begin
      if _ClrRect then
      begin
        x := _RectLen;
        if (i<x)or(j<x)or(i>BMP.Width-1-x)or(j>BMP.Height-1-x) then
        begin
          SrcRGB[i*3]   := $ff;
          SrcRGB[i*3+1] := $ff;
          SrcRGB[i*3+2] := $ff;
          continue;
        end;
      end;
      ClPixel := HexToInt(IntToHex(SrcRGB[i*3],2)+
                            IntToHex(SrcRGB[i*3+1],2)+
                            IntToHex(SrcRGB[i*3+2],2));
      if _CusDiv then
      begin
        case _DivCmp of
        0:  b := ClPixel > _DivColr;
        1:  b := ClPixel = _DivColr;
        2:  b := ClPixel < _DivColr;
        end;
      end else
        b := ClPixel > _DivColr;
      if b then begin
        SrcRGB[i*3]   := $ff;
        SrcRGB[i*3+1] := $ff;
        SrcRGB[i*3+2] := $ff;
      end else begin
        SrcRGB[i*3]   := 0;
        SrcRGB[i*3+1] := 0;
        SrcRGB[i*3+2] := 0;
      end;
    end;
  end;
  {BMP.Canvas.lock;
  for i := 0 to BMP.Width - 1 do
    for j := 0 to BMP.Height - 1 do
    begin
      if _ClrRect then
      begin
        x := _RectLen;
        if (i<x)or(j<x)or(i>BMP.Width-1-x)or(j>BMP.Height-1-x) then
        begin
          BMP.Canvas.Pixels[i, j] := clwhite;
          continue;
        end;
      end;
      if _CusDiv then
      begin
        case _DivCmp of
        0:  b := BMP.Canvas.Pixels[i, j] > _DivColr;
        1:  b := BMP.Canvas.Pixels[i, j] = _DivColr;
        2:  b := BMP.Canvas.Pixels[i, j] < _DivColr;
        end;
      end else
        b := BMP.Canvas.Pixels[i, j] > _DivColr;
      if b then
        BMP.Canvas.Pixels[i, j] := clwhite
      else
        BMP.Canvas.Pixels[i, j] := clblack;
    end;
  BMP.Canvas.Unlock;  }

  result := BMP;
end;

//比较图片上X0开始的字符是否是指定字符M
function TOCRengine.CMPBMP(SBMP: TBITMAP; x0, m: integer): integer;
var
  i, j: integer;
  //
  SrcRGB : pByteArray;
begin
  result := 0;
  for j := 0 to MycharInfo.charheight -1 do
  begin
    SrcRGB := SBMP.ScanLine[j];
    for i := 0 to MycharInfo.charwidth -1 do
    begin
      if _CmpChr and (SrcRGB[(x0+i)*3] = 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 0) then
        Inc(Result);
      if _CmpBg and (SrcRGB[(x0+i)*3] > 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 1) then
        Inc(Result);
    end;
  end;

  {
  result := 0;
  SBMP.Canvas.Lock;
  for i := 0 to MycharInfo.charwidth - 1 do
    for j := 0 to MycharInfo.charHeight - 1 do
    begin
      if _CmpChr and (SBMP.Canvas.Pixels[x0 + i, j] = 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 0) then
        Inc(Result);
      if _CmpBg and (SBMP.Canvas.Pixels[x0 + i, j] > 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 1) then
        Inc(Result);
    end;
  SBMP.Canvas.Unlock;  }
end;


function TOCRengine.CMPBMPPRO(SBMP: TBITMAP; x0, m: integer): integer;
var
  i, j : integer;
  xj : byte;
  Ret : Integer;
  //
  SrcRGB : pByteArray;
begin
  result := 99999;
  for xj := 0 to _BITMAP.Height - MycharInfo.charheight do
  begin
    Ret := 0;
    for j := 0 to MycharInfo.charHeight - 1 do
    begin
      SrcRGB := SBMP.ScanLine[j+xj];
      for i := 0 to MycharInfo.charwidth - 1 do
      begin
        if _CmpChr and (SrcRGB[(x0+i)*3] = 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 0) then
          Inc(Ret);
        if _CmpBg  and (SrcRGB[(x0+i)*3] > 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 1) then
          Inc(Ret);
      end;
    end;
    if result > Ret then
    result := Ret;
  end;

  {result := 99999;
  SBMP.Canvas.Lock;
  for xj := 0 to _BITMAP.Height - MycharInfo.charheight do
  begin
    Ret := 0;
    for i := 0 to MycharInfo.charwidth - 1 do
      for j := 0 to MycharInfo.charHeight - 1 do
      begin
        if _CmpChr and (SBMP.Canvas.Pixels[x0 + i, j+xj] = 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 0) then
          Inc(Ret);
        if _CmpBg  and (SBMP.Canvas.Pixels[x0 + i, j+xj] > 0) and (MycharInfo.allcharinfo[m].MyCharInfo[i, j] = 1) then
          Inc(Ret);
      end;
    if result > Ret then
    result := Ret;
  end;
  SBMP.Canvas.Unlock;   }
end;


function TOCRengine.GetStringFromImage(SBMP: TBITMAP): string;
var
  k, m, x: integer;
  alike : Integer;
  S : String;
  Sort : boolean;
  SlAlike : TStringList;
begin
  //DebugStr('SBMP_W_H',IntToStr(SBMP.Width)+'*'+IntToStr(SBMP.Height),'e:');
  result := '';
  SlAlike := TStringList.Create;
  for k := 0 to MycharInfo.TotalChars - 1 do
  begin
    x := MycharInfo.X0 + MyCharInfo.charwidth * k;
    //DebugLog('k:'+IntToStr(k)+'  '+'x:'+IntToStr(x));
    SlAlike.Clear;
    Sort := True;
    for m := 35 downto 0 do
    begin
      if m>9 then
        S := Chr(m+87)
      else
        S := IntToStr(m);
      if SBMP.Height = MycharInfo.charheight then
        Alike := CMPBMP(SBMP, x, m)
      else
        Alike := CMPBMPPRO(SBMP, x, m);
      //DebugLog('m:'+s+'  '+'Alike:'+IntToStr(Alike));
      if Alike = 0 then
      begin
        Result := Result + S;
        //DebugLog('get_it:'+s);
        //DebugStr('GET_IT','GET '+S+ ' AS '+IntToStr(k+1)+ 'TH NUM','e:');

        Sort := False;
        break;
      end else
        SlAlike.Add(S + Sp + IntToStr(Alike));
    end;
    if Sort then
    begin
      SlQuickSort(SlAlike,0,SlAlike.Count-1);
      result := result + GetHead(SlAlike[0],Sp);
      //DebugLog('get_it_by_sort:'+GetHead(SlAlike[0],Sp));
      //DebugStr('GET_IT_SORT','GET '+GetHead(SlAlike[0],Sp)+ ' AS '+IntToStr(k)+ 'TH NUM','e:');

      //SlAlike.SaveToFile('f:\'+IntToStr(k)+'.txt');
    end;
  end;
  SlAlike.Free;
end;


end.
