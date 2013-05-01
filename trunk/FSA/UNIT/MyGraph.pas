unit MyGraph;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, jpeg, Registry;
type
  TCapMode = (cmCapFullScr, cmCapWindow, cmCapWindowClient, cmCapObject);
  TSaveType = (stBitMap, stJPEG);
  TPic = class
  private
    PicInfoStr: string;
  public
    function LoadPic(PathName: string): TBitMap;
    procedure SavePic(PathName: string; Pic: TBitMap;
      SaveType: TSaveType; PicQuality: Word);
    function GetLastLoadPicInfoStr: string;
  end;
////////////////////////////////////////////////////////////////////
//屏幕读取函数，分别抓取整个屏幕，当前窗口，
//当前窗口客户区，当前鼠标处对象
procedure CapFullScr(var Dest: TBitmap; IncludeCursor: boolean);
procedure CapWindow(WinHandle: HWND; var Dest: TBitmap; IncludeCursor: boolean);
procedure CapClient(WinHandle: HWND; var Dest: TBitmap; IncludeCursor: boolean);
procedure CapObject(var Dest: TBitmap; IncludeCursor: boolean);
procedure DrawCursor(var Dest: TBitmap; ObjectLeft, ObjectTop: Integer); //在以上函数中调用
function CapAndSaveToFile(PathName: AnsiString; CapMode: TCapMode; SaveType: TSaveType; CapCursor: Boolean;
  PicQuality: word; SaveBit: TPixelFormat; StretchMode: integer;
  StretchPer: integer; PicBreadth: integer; PicHeight: integer): Boolean;
//////////////////////////////////////////////////////////////////////
procedure BmpToJpeg(BmpPic: TBitmap; var JpegPic: TJpegImage; PicQuality: integer);
procedure JpegToBmp(JpegPic: TJPEGImage; var Bmp: TBitmap);
procedure JpegFileToBmp(JpegPathName, BmpPathName: string);
///////////////////////////////////////////////////////////////////////////
implementation

procedure CapFullScr(var Dest: TBitmap; IncludeCursor: boolean);
var
  DC: HDC;
begin
  Dest.Width := Screen.Width;
  Dest.Height := Screen.Height;
  DC := GetDC(0);
  bitblt(dest.canvas.handle, 0, 0, Screen.Width, Screen.Height, DC, 0, 0, SRCCOPY);
  if IncludeCursor then DrawCursor(Dest, 0, 0);
  ReleaseDC(0, DC);
end;

procedure CapWindow(WinHandle: HWND; var Dest: TBitmap; IncludeCursor: boolean);
var
  DC: HDC;
  r: TRect;
begin
  GetWindowRect(WinHandle, r);
  Dest.Width := r.Right - r.Left;
  Dest.Height := r.Bottom - r.Top;
  DC := GetWindowDC(WinHandle);
  bitblt(dest.canvas.handle, 0, 0, Dest.Width, Dest.height, DC, 0, 0, SRCCOPY);
  if IncludeCursor then DrawCursor(Dest, r.Left, r.Top);
  ReleaseDC(WinHandle, DC);
end;

procedure CapClient(WinHandle: HWND; var Dest: TBitmap; IncludeCursor: boolean);
var
  DC: HDC;
  _r, r: TRect;
begin
  GetWindowrect(WinHandle, _r);
  GetClientRect(WinHandle, r);
  Dest.Width := r.Right - r.Left;
  Dest.Height := r.Bottom - r.Top;
  DC := GetDC(WinHandle);
  bitblt(dest.canvas.handle, 0, 0, Dest.Width, Dest.height, DC, 0, 0, SRCCOPY);
  if IncludeCursor then DrawCursor(Dest, _r.Right - r.right, _r.bottom - r.bottom);
  ReleaseDC(WinHandle, DC);
end;

procedure CapObject(var Dest: TBitmap; IncludeCursor: boolean);
var
  DC: HDC;
  r: TRect;
  Pos: TPoint;
  WinHandle: HWND;
begin
  GetCursorPos(Pos);
  Winhandle := WindowFromPoint(Pos);
  GetWindowRect(WinHandle, r);
  Dest.Width := r.Right - r.Left;
  Dest.Height := r.Bottom - r.Top;
  DC := GetWindowDC(WinHandle);
  bitblt(dest.canvas.handle, 0, 0, Dest.Width, Dest.height, DC, 0, 0, SRCCOPY);
  Pos.x := Pos.x - r.Left - 10;
  pos.y := pos.y - r.Top - 10;
  if IncludeCursor then DrawCursor(Dest, r.Left, r.Top);
  ReleaseDC(WinHandle, DC);
end;

procedure DrawCursor(var Dest: TBitmap; ObjectLeft, ObjectTop: Integer);
var GlobalCur: TIcon;
  windowhld: hwnd;
  threadld: dword;
  Pos: TPoint;
begin
  GetCursorPos(Pos);
  windowhld := GetForegroundWindow;
  threadld := GetWindowThreadProcessId(Windowhld, nil);
  AttachThreadInput(GetCurrentThreadId, threadld, true);
  GlobalCur := TIcon.Create;
  GlobalCur.handle := GetCursor;
  AttachThreadInput(GetCurrentThreadId, threadld, false);
  Dest.canvas.brush.Style := bsclear;
  Dest.canvas.draw(Pos.x - ObjectLeft - 10,
    Pos.y - ObjectTop - 10, GlobalCur);
end;
////////////////////////////////////////////////////////////////////

procedure BmpToJpeg(BmpPic: TBitmap; var JpegPic: TJpegImage; PicQuality: integer);
begin
  JpegPic.Assign(BmpPic);
  JpegPic.CompressionQuality := PicQuality;
  Jpegpic.Compress;
end;

procedure JpegToBmp(JpegPic: TJPEGImage; var Bmp: TBitmap);
begin
  Bmp.Assign(JpegPic);
end;

procedure JpegFileToBmp(JpegPathName, BmpPathName: string);
var
  JpegPic: TJPEGImage;
  BmpPic: TBitmap;
begin
  JpegPic := TJPEGImage.Create;
  BmpPic := TBitmap.Create;
  try
    JpegPic.LoadFromFile(JpegPathName);
    BmpPic.Assign(JpegPic);
    BmpPic.SaveToFile(BmpPathName);
  except
    on E: Exception do
      MessageBox(0, PChar(E.Message), '错误', MB_OK);
  end;
  JpegPic.Free;
  BmpPic.Free;
end;
///////////////////////////////////////////////////////////////////////

function CapAndSaveToFile(PathName: AnsiString; CapMode: TCapMode; SaveType: TSaveType;
  CapCursor: Boolean; PicQuality: word; SaveBit: TPixelFormat;
  StretchMode: integer; StretchPer: integer; PicBreadth: integer;
  PicHeight: integer): Boolean;
var
  Bmp: Tbitmap;
  TmpBmp: Tbitmap;
  Rect1, Rect2: Trect;
begin
  bmp := TbitMap.Create;
  try
    case CapMode of
      cmCapFullScr: CapFullScr(bmp, CapCursor);
      cmCapWindow: CapWindow(Getforegroundwindow, bmp, CapCursor);
      cmCapWindowClient: CapClient(Getforegroundwindow, bmp, CapCursor);
      cmCapObject: CapObject(bmp, CapCursor);
    end;
    if not DirectoryExists(ExtractFilePath(PathName)) then
    begin
      Result := False;
      Exit;
    end;
    bmp.PixelFormat := SaveBit;
   //缩放处理
    if StretchMode = 0 then
    begin
      if StretchPer <> 100 then
      begin
        tmpbmp := tbitmap.Create;
        tmpbmp.Assign(bmp);
        Rect1 := Rect(0, 0, Round(bmp.Width * StretchPer / 100), Round(bmp.Height * StretchPer / 100));
        Rect2 := Rect(0, 0, bmp.Width, bmp.Height);
        bmp.Canvas.CopyMode := cmSrcCopy;
        bmp.Width := rect1.Right;
        bmp.Height := Rect1.Bottom;
        bmp.Canvas.CopyRect(rect1, tmpbmp.Canvas, rect2);
        TmpBmp.Free;
      end;
    end
    else
    begin
      tmpbmp := tbitmap.Create;
      tmpbmp.Assign(bmp);
      Rect1 := Rect(0, 0, PicBreadth, PicHeight);
      Rect2 := Rect(0, 0, bmp.Width, bmp.Height);
      bmp.Canvas.CopyMode := cmSrcCopy;
      bmp.Width := rect1.Right;
      bmp.Height := Rect1.Bottom;
      bmp.Canvas.CopyRect(rect1, tmpbmp.Canvas, rect2);
      TmpBmp.Free;
    end;
    TPic.Create.SavePic(PathName, bmp, SaveType, PicQuality);
    bmp.Free;
    Result := True;
  except
    bmp.Free;
    Result := False;
  end;
end;
{ TPic }

function TPic.GetLastLoadPicInfoStr: string;
begin
  Result := PicInfoStr;
end;

function TPic.LoadPic(PathName: string): TBitMap;
var
  jpeg: TJPEGImage;
  Ext: string;
  PicTypeInfoStr: string;
begin
  Result := TBitMap.Create;
  Ext := ExtractFileExt(PathName);
  try
    if CompareText(Ext, '.bmp') = 0 then
      Result.LoadFromFile(PathName);
    PicTypeInfoStr := 'BMP位图';
     ////////////////////////////////////////////////////////////
    if ((ComPareText(Ext, '.jpg') = 0) or (ComPareText(Ext, '.jpeg') = 0)) then
    begin
      jpeg := TJPEGImage.Create;
      try
        jpeg.LoadFromFile(PathName);
        Result.Assign(jpeg);
        PicTypeInfoStr := 'JPEG图象';
      except
        jpeg.Free;
        raise;
      end;
    end;
     /////////////////////////////////////////////////////////////
    PicInfoStr := IntToStr(Result.Width) + 'x' + IntToStr(Result.Height);
    case Result.PixelFormat of
      pf1bit: PicInfoStr := PicInfoStr + 'x1位';
      pf4bit: PicInfoStr := PicInfoStr + 'x4位';
      pf8bit: PicInfoStr := PicInfoStr + 'x8位';
      pf15bit: PicInfoStr := PicInfoStr + 'x15位';
      pf16bit: PicInfoStr := PicInfoStr + 'x16位';
      pf24bit: PicInfoStr := PicInfoStr + 'x24位';
      pf32bit: PicInfoStr := PicInfoStr + 'x32位';
    end;
    PicInfoStr := PicInfoStr + ' ' + PicTypeInfoStr;
  except
    Result.Free;
    raise;
  end;
end;

procedure TPic.SavePic(PathName: string; Pic: TBitMap; SaveType: TSaveType;
  PicQuality: Word);
var
  jpeg: TJPEGImage;
begin
  case SaveType of
    stBitMap:
      Pic.SaveToFile(PathName);
   ///////////////////////////////////////////////////////////////
    stJPEG:
      begin
        Jpeg := TJpegImage.Create;
        try
          Jpeg.Assign(Pic);
          Jpeg.CompressionQuality := PicQuality;
          Jpeg.Compress;
          Jpeg.SaveToFile(PathName);
        except
          Jpeg.Free;
          raise;
        end;
      end;
   ///////////////////////////////////////////////////
  end;
end;
end.
