unit FastBMP;

interface          //  TFastBMP v1.2
                   //    Gordon Alex Cowie <gfody@jps.net>
uses Windows,      //    www.jps.net/gfody
     FastRGB;      //
                   //    This unit is Freeware. Comments, Ideas,
const              //    Optimizations, Corrections, and Effects
{$IFDEF VER90}     //    are welcome. See readme.rtf for a brief
  hSection=nil;    //    documentation. (2/14/99)
{$ELSE}
  hSection=0;
{$ENDIF}

type

TFastBMP=class (TFastRGB)
private
  procedure   Initialize;
public
  Handle,
  hDC:        Integer;
  bmInfo:     TBitmapInfo;
  bmHeader:   TBitmapInfoHeader;
  // constructors
  constructor Create(cx,cy:Integer);
  constructor CreateFromFile(lpFile:string);
  constructor CreateFromhBmp(hBmp:Integer);
  constructor CreateFromRes(hInst:Integer;lpName:string);
  constructor CreateCopy(hBmp:TFastBMP);
  destructor  Destroy; override;
  // gdi routines
  procedure   Draw(hDst,x,y:Integer);
  procedure   Stretch(hDst,x,y,w,h:Integer);
  procedure   DrawRect(hDst,x,y,w,h,sx,sy:Integer);
  procedure   TileDraw(hDst,x,y,w,h:Integer);
  // software (non gdi) routines
  procedure   Resize(Dst:TFastBMP);
  procedure   SmoothResize(Dst:TFastBMP);
  procedure   CopyRect(Dst:TFastBMP;x,y,w,h,sx,sy:Integer);
  procedure   Tile(Dst:TFastBMP);
end;

implementation

constructor TFastBMP.Create(cx,cy:Integer);
begin
  Width:=cx;
  Height:=cy;
  with bmHeader do
  begin
    biSize:=SizeOf(bmHeader);
    biWidth:=Width;
    biHeight:=-Height;
    biPlanes:=1;
    biBitCount:=24;
    biCompression:=BI_RGB;
  end;
  bmInfo.bmiHeader:=bmHeader;
  Handle:=CreateDIBSection(0,
                   bmInfo,
                   DIB_RGB_COLORS,
                   Bits,
                   hSection,
                   0);
  Initialize;
end;

constructor TFastBMP.CreateFromhBmp(hBmp:Integer);
var
Bmp:   TBITMAP;
memDC: Integer;
begin
  GetObject(hBmp,SizeOf(Bmp),@Bmp);
  Width:=Bmp.bmWidth;
  Height:=Bmp.bmHeight;
  Size:=((Width*3)+(Width mod 4))*Height;
  with bmHeader do
  begin
    biSize:=SizeOf(bmHeader);
    biWidth:=Width;
    biHeight:=-Height;
    biPlanes:=1;
    biBitCount:=24;
    biCompression:=BI_RGB;
  end;
  bmInfo.bmiHeader:=bmHeader;
  Handle:=CreateDIBSection(0,
                 bmInfo,
                 DIB_RGB_COLORS,
                 Bits,
                 hSection,
                 0);
  memDC:=GetDC(0);
  GetDIBits(memDC,hBmp,0,Height,Bits,bmInfo,DIB_RGB_COLORS);
  ReleaseDC(0,memDC);
  Initialize;
end;

constructor TFastBMP.CreateFromFile(lpFile:string);
var
hBmp: Integer;
begin
  hBmp:=LoadImage(0,PChar(lpFile),IMAGE_BITMAP,0,0,LR_LOADFROMFILE);
  CreateFromhBmp(hBmp);
  DeleteObject(hBmp);
end;

constructor TFastBMP.CreateFromRes(hInst:Integer;lpName:string);
var
hBmp: Integer;
begin
  hBmp:=LoadImage(hInst,PChar(lpName),IMAGE_BITMAP,0,0,0);
  CreateFromhBmp(hBmp);
  DeleteObject(hBmp);
end;

constructor TFastBMP.CreateCopy(hBmp:TFastBMP);
begin
  bmHeader:=hBmp.bmHeader;
  bmInfo:=hBmp.bmInfo;
  Width:=hBmp.Width;
  Height:=hBmp.Height;
  Size:=hBmp.Size;
  Handle:=CreateDIBSection(0,
                 bmInfo,
                 DIB_RGB_COLORS,
                 Bits,
                 hSection,
                 0);
  CopyMemory(Bits,hBmp.Bits,Size);
  Initialize;
end;

destructor TFastBMP.Destroy;
begin
  DeleteDC(hDC);
  DeleteObject(Handle);
  FreeMem(Pixels);
  inherited;
end;

procedure TFastBMP.Initialize;
var
i: Integer;
x: Longint;
begin
  GetMem(Pixels,Height*SizeOf(PLine));
  Gap:=Width mod 4;
  RowInc:=(Width*3)+Gap;
  Size:=RowInc*Height;
  x:=Integer(Bits);
  for i:=0 to Height-1 do
  begin
    Pixels[i]:=Pointer(x);
    Inc(x,RowInc);
  end;
  hDC:=CreateCompatibleDC(0);
  SelectObject(hDC,Handle);
end;

procedure TFastBMP.Draw(hDst,x,y:Integer);
begin
  BitBlt(hDst,x,y,Width,Height,hDC,0,0,SRCCOPY);
end;

procedure TFastBMP.Stretch(hDst,x,y,w,h:Integer);
begin
  // some video drivers don't implement stretching dibs
  // very well. (diamond stealth fails when the scaling
  // factor is greater then 255). for reliable resizing
  // use the native 'resize' method.
  SetStretchBltMode(hDst,STRETCH_DELETESCANS);
  StretchBlt(hDst,x,y,w,h,hDC,0,0,Width,Height,SRCCOPY);
end;

procedure TFastBMP.DrawRect(hDst,x,y,w,h,sx,sy:Integer);
begin
  BitBlt(hDst,x,y,w,h,hDC,sx,sy,SRCCOPY);
end;

procedure TFastBMP.TileDraw(hDst,x,y,w,h:Integer);
var
wd,hd,
hBmp,
memDC: Integer;
begin
  memDC:=CreateCompatibleDC(hDst);
  hBmp:=CreateCompatibleBitmap(hDst,w,h);
  SelectObject(memDC,hBmp);
  Draw(memDC,0,0);
  wd:=Width;
  hd:=Height;
  while wd<w do
  begin
    BitBlt(memDC,wd,0,wd*2,h,memDC,0,0,SRCCOPY);
    Inc(wd,wd);
  end;
  while hd<h do
  begin
    BitBlt(memDC,0,hd,w,hd*2,memDC,0,0,SRCCOPY);
    Inc(hd,hd);
  end;
  BitBlt(hDst,x,y,w,h,memDC,0,0,SRCCOPY);
  DeleteDC(memDC);
  DeleteObject(hBmp);
end;

procedure TFastBMP.Resize(Dst:TFastBMP);
var
xCount,
yCount,
x,y,xP,yP,
xD,yD,
yiScale,
xiScale:  Integer;
xScale,
yScale:   Single;
Read,
Line:     PLine;
Tmp:      TFColor;
pc:       PFColor;
begin
  if(Dst.Width=0)or(Dst.Height=0)then Exit;
  if(Dst.Width=Width)and(Dst.Height=Height)then
  begin
    CopyMemory(Dst.Bits,Bits,Size);
    Exit;
  end;

  xScale:=Dst.Width/Width;
  yScale:=Dst.Height/Height;
  if(xScale<1)or(yScale<1)then
  begin  // shrinking
    xiScale:=(Width shl 16) div Dst.Width;
    yiScale:=(Height shl 16) div Dst.Height;
    yP:=0;
    for y:=0 to Dst.Height-1 do
    begin
      xP:=0;
      read:=Pixels[yP shr 16];
      pc:=@Dst.Pixels[y,0];
      for x:=0 to Dst.Width-1 do
      begin
        pc^:=Read[xP shr 16];
        Inc(pc);
        Inc(xP,xiScale);
      end;
      Inc(yP,yiScale);
    end;
  end
  else   // zooming
  begin
    yiScale:=Round(yScale+0.5);
    xiScale:=Round(xScale+0.5);
    GetMem(Line,Dst.Width*3);
    for y:=0 to Height-1 do
    begin
      yP:=Trunc(yScale*y);
      Read:=Pixels[y];
      for x:=0 to Width-1 do
      begin
        xP:=Trunc(xScale*x);
        Tmp:=Read[x];
        for xCount:=0 to xiScale-1 do
        begin
          xD:=xCount+xP;
          if xD>=Dst.Width then Break;
          Line[xD]:=Tmp;
        end;
      end;
      for yCount:=0 to yiScale-1 do
      begin
        yD:=yCount+yP;
        if yD>=Dst.Height then Break;
        CopyMemory(Dst.Pixels[yD],Line,Dst.Width*3);
      end;
    end;
    FreeMem(Line);
  end;
end;

// huge thanks to Vit Kovalcik for this awesome function!
// performs a fast bilinear interpolation <vkovalcik@iname.com>
procedure TFastBMP.SmoothResize(Dst:TFastBMP);
var
x,y,xP,yP,
yP2,xP2:     Integer;
Read,Read2:  PLine;
t,z,z2,iz2:  Integer;
pc:PFColor;
w1,w2,w3,w4: Integer;
Col1,Col2:   PFColor;
begin
  if(Dst.Width<1)or(Dst.Height<1)then Exit;
  if Width=1 then
  begin
    Resize(Dst);
    Exit;
  end;
  if(Dst.Width=Width)and(Dst.Height=Height)then
  begin
    CopyMemory(Dst.Bits,Bits,Size);
    Exit;
  end;
  xP2:=((Width-1)shl 15)div Dst.Width;
  yP2:=((Height-1)shl 15)div Dst.Height;
  yP:=0;
  for y:=0 to Dst.Height-1 do
  begin
    xP:=0;
    Read:=Pixels[yP shr 15];
    if yP shr 16<Height-1 then
      Read2:=Pixels[yP shr 15+1]
    else
      Read2:=Pixels[yP shr 15];
    pc:=@Dst.Pixels[y,0];
    z2:=yP and $7FFF;
    iz2:=$8000-z2;
    for x:=0 to Dst.Width-1 do
    begin
      t:=xP shr 15;
      Col1:=@Read[t];
      Col2:=@Read2[t];
      z:=xP and $7FFF;
      w2:=(z*iz2)shr 15;
      w1:=iz2-w2;
      w4:=(z*z2)shr 15;
      w3:=z2-w4;
      pc.b:=
        (Col1.b*w1+PFColor(Integer(Col1)+3).b*w2+
         Col2.b*w3+PFColor(Integer(Col2)+3).b*w4)shr 15;
      pc.g:=
        (Col1.g*w1+PFColor(Integer(Col1)+3).g*w2+
         Col2.g*w3+PFColor(Integer(Col2)+3).g*w4)shr 15;
      pc.r:=
        (Col1.r*w1+PFColor(Integer(Col1)+3).r*w2+
         Col2.r*w3+PFColor(Integer(Col2)+3).r*w4)shr 15;
      Inc(pc);
      Inc(xP,xP2);
    end;
    Inc(yP,yP2);
  end;
end;

procedure TFastBMP.CopyRect(Dst:TFastBMP;x,y,w,h,sx,sy:Integer);
var
n1,n2: Pointer;
i:     Integer;
begin
  if x<0 then
  begin
    sx:=sx+(-x);
    w:=w+x;
    x:=0;
  end;
  if y<0 then
  begin
    sy:=sy+(-y);
    h:=h+y;
    y:=0;
  end;
  if sx<0 then
  begin
    x:=x+(-sx);
    w:=w+sx;
    sx:=0;
  end;
  if sy<0 then
  begin
    y:=y+(-sy);
    h:=h+sy;
    sy:=0;
  end;
  if(sx>Width-1)or(sy>Height-1)then Exit;

  if sx+w>Width     then w:=w-((sx+w)-(Width));
  if sy+h>Height    then h:=h-((sy+h)-(Height));
  if x+w>Dst.Width  then w:=w-((x+w)-(Dst.Width));
  if y+h>Dst.Height then h:=h-((y+h)-(Dst.Height));

  n1:=@Dst.Pixels[y,x];
  n2:=@Pixels[sy,sx];
  for i:=0 to h-1 do
  begin
    CopyMemory(n1,n2,w*3);
    n1:=Ptr(Integer(n1)+Dst.RowInc);
    n2:=Ptr(Integer(n2)+RowInc);
  end;
end;

procedure TFastBMP.Tile(Dst:TFastBMP);
var
w,h,cy,cx: Integer;
begin
  CopyRect(Dst,0,0,Width,Height,0,0);
  w:=Width;
  h:=Height;
  cx:=Dst.Width;
  cy:=Dst.Height;
  while w<cx do
  begin
    Dst.CopyRect(Dst,w,0,w*2,h,0,0);
    Inc(w,w);
  end;
  while h<cy do
  begin
    Dst.CopyRect(Dst,0,h,w,h*2,0,0);
    Inc(h,h);
  end;
end;

end.
