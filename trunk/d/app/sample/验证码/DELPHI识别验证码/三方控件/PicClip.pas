Unit PicClip;

Interface

Uses SysUtils, Classes, Controls, Windows, RTLConsts, Graphics;

Const
  PaletteMask = $02000000;

Type
  TCellRange = 1..MaxInt;

  TPicClip = Class(TComponent)
  Private
    FPicture: TPicture;
    FRows: TCellRange;
    FCols: TCellRange;
    FBitmap: TBitmap;
    FMasked: Boolean;
    FMaskColor: TColor;
    FOnChange: TNotifyEvent;
    Procedure CheckIndex(Index: Integer);
    Function GetCell(Col, Row: Cardinal): TBitmap;
    Function GetGraphicCell(Index: Integer): TBitmap;
    Function GetDefaultMaskColor: TColor;
    Function GetIsEmpty: Boolean;
    Function GetCount: Integer;
    Function GetHeight: Integer;
    Function GetWidth: Integer;
    Function IsMaskStored: Boolean;
    Procedure PictureChanged(Sender: TObject);
    Procedure SetHeight(Value: Integer);
    Procedure SetPicture(Value: TPicture);
    Procedure SetWidth(Value: Integer);
    Procedure SetMaskColor(Value: TColor);
  Protected
    Procedure AssignTo(Dest: TPersistent); Override;
    Procedure Changed; Dynamic;
  Public
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure Assign(Source: TPersistent); Override;
    Function GetIndex(Col, Row: Cardinal): Integer;
    Procedure Draw(Canvas: TCanvas; X, Y, Index: Integer);
    Procedure DrawCenter(Canvas: TCanvas; Rect: TRect; Index: Integer);
    Procedure LoadBitmapRes(Instance: THandle; ResID: PChar);
    Property Cells[Col, Row: Cardinal]: TBitmap Read GetCell;
    Property GraphicCell[Index: Integer]: TBitmap Read GetGraphicCell;
    Property IsEmpty: Boolean Read GetIsEmpty;
    Property Count: Integer Read GetCount;
  Published
    Property Cols: TCellRange Read FCols Write FCols Default 1;
    Property Height: Integer Read GetHeight Write SetHeight Stored False;
    Property Masked: Boolean Read FMasked Write FMasked Default True;
    Property Rows: TCellRange Read FRows Write FRows Default 1;
    Property Picture: TPicture Read FPicture Write SetPicture;
    Property MaskColor: TColor Read FMaskColor Write SetMaskColor Stored IsMaskStored;
    Property Width: Integer Read GetWidth Write SetWidth Stored False;
    Property OnChange: TNotifyEvent Read FOnChange Write FOnChange;
  End;

Implementation

{$B-}

function PaletteColor(Color: TColor): Longint;
begin
  Result := ColorToRGB(Color) or PaletteMask;
end;

procedure StretchBltTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcDC: HDC; SrcX, SrcY, SrcW, SrcH: Integer; Palette: HPalette;
  TransparentColor: TColorRef);
var
  Color: TColorRef;
  bmAndBack, bmAndObject, bmAndMem, bmSave: HBitmap;
  bmBackOld, bmObjectOld, bmMemOld, bmSaveOld: HBitmap;
  MemDC, BackDC, ObjectDC, SaveDC: HDC;
  palDst, palMem, palSave, palObj: HPalette;
begin
  { Create some DCs to hold temporary data }
  BackDC := CreateCompatibleDC(DstDC);
  ObjectDC := CreateCompatibleDC(DstDC);
  MemDC := CreateCompatibleDC(DstDC);
  SaveDC := CreateCompatibleDC(DstDC);
  { Create a bitmap for each DC }
  bmAndObject := CreateBitmap(SrcW, SrcH, 1, 1, nil);
  bmAndBack := CreateBitmap(SrcW, SrcH, 1, 1, nil);
  bmAndMem := CreateCompatibleBitmap(DstDC, DstW, DstH);
  bmSave := CreateCompatibleBitmap(DstDC, SrcW, SrcH);
  { Each DC must select a bitmap object to store pixel data }
  bmBackOld := SelectObject(BackDC, bmAndBack);
  bmObjectOld := SelectObject(ObjectDC, bmAndObject);
  bmMemOld := SelectObject(MemDC, bmAndMem);
  bmSaveOld := SelectObject(SaveDC, bmSave);
  { Select palette }
  palDst := 0; palMem := 0; palSave := 0; palObj := 0;
  if Palette <> 0 then begin
    palDst := SelectPalette(DstDC, Palette, True);
    RealizePalette(DstDC);
    palSave := SelectPalette(SaveDC, Palette, False);
    RealizePalette(SaveDC);
    palObj := SelectPalette(ObjectDC, Palette, False);
    RealizePalette(ObjectDC);
    palMem := SelectPalette(MemDC, Palette, True);
    RealizePalette(MemDC);
  end;
  { Set proper mapping mode }
  SetMapMode(SrcDC, GetMapMode(DstDC));
  SetMapMode(SaveDC, GetMapMode(DstDC));
  { Save the bitmap sent here }
  BitBlt(SaveDC, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY);
  { Set the background color of the source DC to the color,         }
  { contained in the parts of the bitmap that should be transparent }
  Color := SetBkColor(SaveDC, PaletteColor(TransparentColor));
  { Create the object mask for the bitmap by performing a BitBlt()  }
  { from the source bitmap to a monochrome bitmap                   }
  BitBlt(ObjectDC, 0, 0, SrcW, SrcH, SaveDC, 0, 0, SRCCOPY);
  { Set the background color of the source DC back to the original  }
  SetBkColor(SaveDC, Color);
  { Create the inverse of the object mask }
  BitBlt(BackDC, 0, 0, SrcW, SrcH, ObjectDC, 0, 0, NOTSRCCOPY);
  { Copy the background of the main DC to the destination }
  BitBlt(MemDC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Mask out the places where the bitmap will be placed }
  StretchBlt(MemDC, 0, 0, DstW, DstH, ObjectDC, 0, 0, SrcW, SrcH, SRCAND);
  { Mask out the transparent colored pixels on the bitmap }
  BitBlt(SaveDC, 0, 0, SrcW, SrcH, BackDC, 0, 0, SRCAND);
  { XOR the bitmap with the background on the destination DC }
  StretchBlt(MemDC, 0, 0, DstW, DstH, SaveDC, 0, 0, SrcW, SrcH, SRCPAINT);
  { Copy the destination to the screen }
  BitBlt(DstDC, DstX, DstY, DstW, DstH, MemDC, 0, 0,
    SRCCOPY);
  { Restore palette }
  if Palette <> 0 then begin
    SelectPalette(MemDC, palMem, False);
    SelectPalette(ObjectDC, palObj, False);
    SelectPalette(SaveDC, palSave, False);
    SelectPalette(DstDC, palDst, True);
  end;
  { Delete the memory bitmaps }
  DeleteObject(SelectObject(BackDC, bmBackOld));
  DeleteObject(SelectObject(ObjectDC, bmObjectOld));
  DeleteObject(SelectObject(MemDC, bmMemOld));
  DeleteObject(SelectObject(SaveDC, bmSaveOld));
  { Delete the memory DCs }
  DeleteDC(MemDC);
  DeleteDC(BackDC);
  DeleteDC(ObjectDC);
  DeleteDC(SaveDC);
end;

Procedure StretchBitmapTransparent(Dest: TCanvas; Bitmap: TBitmap;
  TransparentColor: TColor; DstX, DstY, DstW, DstH, SrcX, SrcY,
  SrcW, SrcH: Integer);
Var
  CanvasChanging: TNotifyEvent;
Begin
  If DstW <= 0 Then DstW := Bitmap.Width;
  If DstH <= 0 Then DstH := Bitmap.Height;
  If (SrcW <= 0) Or (SrcH <= 0) Then Begin
    SrcX := 0; SrcY := 0;
    SrcW := Bitmap.Width;
    SrcH := Bitmap.Height;
  End;
  If Not Bitmap.Monochrome Then
    SetStretchBltMode(Dest.Handle, STRETCH_DELETESCANS);
  CanvasChanging := Bitmap.Canvas.OnChanging;
  Bitmap.Canvas.Lock;
  Try
    Bitmap.Canvas.OnChanging := Nil;
    If TransparentColor = clNone Then Begin
      StretchBlt(Dest.Handle, DstX, DstY, DstW, DstH, Bitmap.Canvas.Handle,
        SrcX, SrcY, SrcW, SrcH, Dest.CopyMode);
    End
    Else Begin
      If TransparentColor = clDefault Then
        TransparentColor := Bitmap.Canvas.Pixels[0, Bitmap.Height - 1];
      If Bitmap.Monochrome Then TransparentColor := clWhite
      Else TransparentColor := ColorToRGB(TransparentColor);
      StretchBltTransparent(Dest.Handle, DstX, DstY, DstW, DstH,
        Bitmap.Canvas.Handle, SrcX, SrcY, SrcW, SrcH, Bitmap.Palette,
        TransparentColor);
    End;
  Finally
    Bitmap.Canvas.OnChanging := CanvasChanging;
    Bitmap.Canvas.Unlock;
  End;
End;

procedure ResourceNotFound(ResID: PChar);
var
  S: string;
begin
  if LongRec(ResID).Hi = 0 then S := IntToStr(LongRec(ResID).Lo)
  else S := StrPas(ResID);
  raise EResNotFound.CreateFmt(SResNotFound, [S]);
end;

function MakeModuleBitmap(Module: THandle; ResID: PChar): TBitmap;
{$IFNDEF WIN32}
var
  S: TStream;
{$ENDIF}
begin
  Result := TBitmap.Create;
  try
{$IFDEF WIN32}
    if Module <> 0 then begin
      if LongRec(ResID).Hi = 0 then
        Result.LoadFromResourceID(Module, LongRec(ResID).Lo)
      else
        Result.LoadFromResourceName(Module, StrPas(ResID));
    end
    else begin
      Result.Handle := LoadBitmap(Module, ResID);
      if Result.Handle = 0 then ResourceNotFound(ResID);
    end;
{$ELSE}
    Result.Handle := LoadBitmap(Module, ResID);
    if Result.Handle = 0 then ResourceNotFound(ResID);
{$ENDIF}
  except
    Result.Free;
    Result := nil;
  end;
end;

procedure AssignBitmapCell(Source: TGraphic; Dest: TBitmap; Cols, Rows,
  Index: Integer);
var
  CellWidth, CellHeight: Integer;
begin
  if (Source <> nil) and (Dest <> nil) then begin
    if Cols <= 0 then Cols := 1;
    if Rows <= 0 then Rows := 1;
    if Index < 0 then Index := 0;
    CellWidth := Source.Width div Cols;
    CellHeight := Source.Height div Rows;
    with Dest do begin
      Width := CellWidth; Height := CellHeight;
    end;
    if Source is TBitmap then begin
      Dest.Canvas.CopyRect(Bounds(0, 0, CellWidth, CellHeight),
        TBitmap(Source).Canvas, Bounds((Index mod Cols) * CellWidth,
        (Index div Cols) * CellHeight, CellWidth, CellHeight));
      Dest.TransparentColor := TBitmap(Source).TransparentColor;
    end
    else begin
      Dest.Canvas.Brush.Color := clSilver;
      Dest.Canvas.FillRect(Bounds(0, 0, CellWidth, CellHeight));
      Dest.Canvas.Draw(-(Index mod Cols) * CellWidth,
        -(Index div Cols) * CellHeight, Source);
    end;
    Dest.Transparent := Source.Transparent;
  end;
end;

{TPicClip}
Constructor TPicClip.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FBitmap := TBitmap.Create;
  FRows := 1;
  FCols := 1;
  FMaskColor := GetDefaultMaskColor;
  FMasked := True;
End;

Destructor TPicClip.Destroy;
Begin
  FOnChange := Nil;
  FPicture.OnChange := Nil;
  FBitmap.Free;
  FPicture.Free;
  Inherited Destroy;
End;

Procedure TPicClip.Assign(Source: TPersistent);
Begin
  If Source Is TPicClip Then Begin
    With TPicClip(Source) Do Begin
      Self.FRows := Rows;
      Self.FCols := Cols;
      Self.FMasked := Masked;
      Self.FMaskColor := MaskColor;
      Self.FPicture.Assign(FPicture);
    End;
  End
  Else If (Source Is TPicture) Or (Source Is TGraphic) Then
    FPicture.Assign(Source)
  Else Inherited Assign(Source);
End;

{$IFDEF WIN32}
Type
  THack = Class(TImageList);
{$ENDIF}

Procedure TPicClip.AssignTo(Dest: TPersistent);
{$IFDEF WIN32}
Var
  I: Integer;
  SaveChange: TNotifyEvent;
{$ENDIF}
Begin
  If (Dest Is TPicture) Then Dest.Assign(FPicture)
  Else If (Dest Is TGraphic) And (FPicture.Graphic <> Nil) And
    (FPicture.Graphic Is TGraphic(Dest).ClassType) Then
    Dest.Assign(FPicture.Graphic)
{$IFDEF WIN32}
  Else If (Dest Is TImageList) And Not IsEmpty Then Begin
    With TImageList(Dest) Do Begin
      SaveChange := OnChange;
      Try
        OnChange := Nil;
        Clear;
        Width := Self.Width;
        Height := Self.Height;
        For I := 0 To Self.Count - 1 Do Begin
          If Self.Masked And (MaskColor <> clNone) Then
            TImageList(Dest).AddMasked(GraphicCell[I], MaskColor)
          Else TImageList(Dest).Add(GraphicCell[I], Nil);
        End;
        Masked := Self.Masked;
      Finally
        OnChange := SaveChange;
      End;
      THack(Dest).Change;
    End;
  End
{$ENDIF}
  Else Inherited AssignTo(Dest);
End;

Procedure TPicClip.Changed;
Begin
  If Assigned(FOnChange) Then FOnChange(Self);
End;

Function TPicClip.GetIsEmpty: Boolean;
Begin
  Result := (Picture.Graphic = Nil) Or Picture.Graphic.Empty;
End;

Function TPicClip.GetCount: Integer;
Begin
  If IsEmpty Then Result := 0
  Else Result := Cols * Rows;
End;

Procedure TPicClip.Draw(Canvas: TCanvas; X, Y, Index: Integer);
Var
  Image: TGraphic;
Begin
  If Index < 0 Then Image := Picture.Graphic
  Else Image := GraphicCell[Index];
  If (Image <> Nil) And Not Image.Empty Then Begin
    If FMasked And (FMaskColor <> clNone) And
      (Picture.Graphic Is TBitmap) Then
      StretchBitmapTransparent(Canvas, TBitmap(Image), FMaskColor, X, Y, TBitmap(Image).Width, TBitmap(Image).Height, 0, 0, TBitmap(Image).Width, TBitmap(Image).Height)
    Else Canvas.Draw(X, Y, Image);
  End;
End;

Procedure TPicClip.DrawCenter(Canvas: TCanvas; Rect: TRect; Index: Integer);
Var
  X, Y: Integer;
Begin
  X := (Rect.Left + Rect.Right - Width) Div 2;
  Y := (Rect.Bottom + Rect.Top - Height) Div 2;
  Draw(Canvas, X, Y, Index);
End;

Procedure TPicClip.LoadBitmapRes(Instance: THandle; ResID: PChar);
Var
  Bmp: TBitmap;
Begin
  Bmp := MakeModuleBitmap(Instance, ResID);
  Try
    Picture.Assign(Bmp);
  Finally
    Bmp.Free;
  End;
End;

Procedure TPicClip.CheckIndex(Index: Integer);
Begin
  If (Index >= Cols * Rows) Or (Index < 0) Then
    Raise EListError.CreateFmt(SListIndexError, [Index]);
End;

Function TPicClip.GetIndex(Col, Row: Cardinal): Integer;
Begin
  Result := Col + (Row * Cols);
  If (Result >= Cols * Rows) Or IsEmpty Then Result := -1;
End;

Function TPicClip.GetCell(Col, Row: Cardinal): TBitmap;
Begin
  Result := GetGraphicCell(GetIndex(Col, Row));
End;

Function TPicClip.GetGraphicCell(Index: Integer): TBitmap;
Begin
  CheckIndex(Index);
  AssignBitmapCell(Picture.Graphic, FBitmap, Cols, Rows, Index);
  If Picture.Graphic Is TBitmap Then
    If FBitmap.PixelFormat <> pfDevice Then
      FBitmap.PixelFormat := TBitmap(Picture.Graphic).PixelFormat;
  FBitmap.TransparentColor := FMaskColor Or PaletteMask;
  FBitmap.Transparent := (FMaskColor <> clNone) And Masked;
  Result := FBitmap;
End;

Function TPicClip.GetDefaultMaskColor: TColor;
Begin
  Result := clOlive;
  If (Picture.Graphic <> Nil) And (Picture.Graphic Is TBitmap) Then
    Result := TBitmap(Picture.Graphic).TransparentColor And
      Not PaletteMask;
End;

Function TPicClip.GetHeight: Integer;
Begin
  Result := Picture.Height Div FRows;
End;

Function TPicClip.GetWidth: Integer;
Begin
  Result := Picture.Width Div FCols;
End;

Function TPicClip.IsMaskStored: Boolean;
Begin
  Result := MaskColor <> GetDefaultMaskColor;
End;

Procedure TPicClip.SetMaskColor(Value: TColor);
Begin
  If Value <> FMaskColor Then Begin
    FMaskColor := Value;
    Changed;
  End;
End;

Procedure TPicClip.PictureChanged(Sender: TObject);
Begin
  FMaskColor := GetDefaultMaskColor;
  If Not (csReading In ComponentState) Then Changed;
End;

Procedure TPicClip.SetHeight(Value: Integer);
Begin
  If (Value > 0) And (Picture.Height Div Value > 0) Then
    Rows := Picture.Height Div Value;
End;

Procedure TPicClip.SetWidth(Value: Integer);
Begin
  If (Value > 0) And (Picture.Width Div Value > 0) Then
    Cols := Picture.Width Div Value;
End;

Procedure TPicClip.SetPicture(Value: TPicture);
Begin
  FPicture.Assign(Value);
End;

End.

