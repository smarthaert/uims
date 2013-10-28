////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsemf
//      Description:
//      Ver.:         1.0 Prova
//      Note: Check only  wmf_Key = $9AC6CDD7  and emf_Key = $464D4520
//
//      Gamma Computer snc Via Matteotti 13
//      10036 Settimo T.se  Torino  Italia
//      gammac@infogammac.it
//      Author: G. Colangelo
//
////////////////////////////////////////////////////////////////////////

unit xlsemf;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

{$IFDEF ZLIB}
uses   
       Windows, SysUtils, Zlib, Classes, 
       xlsmd4, xlsblob;
type

  _PLACEABLEMETAHEADER = packed record
    Key: Longint;
    Handle: SmallInt;
    Box: TSmallRect;
    Inch: Word;
    Reserved: Longint;
    CheckSum: Word;
  end;

  TFBSEWMF = packed Record
 //  rgbUid:  array[0..15] of byte;  // Identifier of blip
    m_cb: Word;              // Cache of the metafile size
    m_rcBounds: TSmallRect;  // Boundary of metafile drawing commands
    m_ptSize: TPoint;        // Size of metafile in EMUs
    m_cbSave: Word;          // Cache of saved size (size of m_pvBits)
    m_fCompression: byte;    // MSOBLIPCOMPRESSION
    m_fFilter: byte;         // always msofilterNone
    EmfRgbUid :  array[0..15] of byte;
  end;

type

  TGWmfEmfRead = class
  private
    FFileName: AnsiString;
    Pmh : _PLACEABLEMETAHEADER;
    FBSEWMF: TFBSEWMF;
    Scp: Integer;
    FHeight: Double;
    FWidth: Double;
    StreamInput: TStream;
    StreamOutput: TMemoryStream;
    FileType: Integer;
    Start: Integer;

    function  CheckType(AFile: TStream): Integer;
    Procedure Compress(Stream: TStream);
    Procedure CompressStream(InStream, OutStream: TStream);
    function  CheckWmf(AFilename: WideString): Boolean;

    function  GetWidth: Double;
    function  GetHeight: Double;
    procedure FillBSEWMF;
    function  GetPixelsPerInch: integer;

  public

    constructor Create(AFilename: WideString);
    destructor Destroy; override;

    property  Height: Double read FHeight write FHeight;
    property  Width: Double  read FWidth  write FWidth;
    property  BSEWMF: TFBSEWMF read FBSEWMF write FBSEWMF;
    property  C_Stream: TMemoryStream read StreamOutput write StreamOutput;

  end;

{$ENDIF}


implementation

{$IFDEF ZLIB}
uses wstream;

{TWmfRead}
var

  GlobalPixelsPerInch: integer = -1;
  
constructor TGWmfEmfRead.Create(AFileName: WideString);
begin
  inherited Create;
  StreamOutput := TMemoryStream.Create;
  FFilename := AnsiString(AFileName);
  Scp := GetPixelsPerInch();
  Fheight := 0;
  Fwidth := 0;
  if CheckWmf(AFileName) then begin
    FillBSEWMF;
    FHeight := GetHeight;
    FWidth := GetWidth;
  end;
end;

destructor TGWmfEmfRead.Destroy;
begin
  StreamOutput.Free;
  inherited Destroy;
end;

function TGWmfEmfRead.GetPixelsPerInch: integer;
var
  DC: HDC;
begin
  if GlobalPixelsPerInch = -1 then begin
    DC := GetDC(0);
    GlobalPixelsPerInch := GetDeviceCaps(DC, LOGPIXELSY);
    ReleaseDC(0, DC);
  end;
  Result := GlobalPixelsPerInch;
end;

procedure  TGWmfEmfRead.CompressStream(InStream, OutStream: TStream);
var InBuf, OutBuf: Pointer;
    InBytes, OutBytes: integer;
begin
  InBuf := nil;
  OutBuf := nil;

  try
    GetMem(InBuf, InStream.Size);
    InStream.Position := 0;
    InBytes := InStream.Read(InBuf^, InStream.Size);
    {$IFDEF D2009}
    ZLib.ZCompress(InBuf, InBytes, OutBuf, OutBytes);
    {$ELSE}
    ZLib.CompressBuf(InBuf, InBytes, OutBuf, OutBytes);
    {$ENDIF}
    OutStream.Write(OutBuf^, OutBytes);
  finally
    if InBuf <> nil then FreeMem(InBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;
end;

procedure TGWmfEmfRead.Compress(Stream: TStream);
var StreamTmp: TMemoryStream;
begin
  Stream.Position := 0;
  Stream.Position := Start;

  StreamTmp := TMemoryStream.Create;
  StreamTmp.Position := 0;
  StreamTmp.CopyFrom(Stream, Stream.Size - Start);

  CompressStream(StreamTmp, StreamOutput);

  FBSEWMF.m_cbSave := StreamOutput.Size;  
  StreamOutput.Position := 0;

  StreamTmp.Free;
end;


function TGWmfEmfRead.CheckType(AFile: TStream): Integer;
var 
  Buff: Longword;
begin
  Result := 0;
  AFile.Position := 0;
  AFile.ReadBuffer(Buff, SizeOf(Buff));

  if Buff = $9AC6CDD7 then begin
    Result := 1;
  end else begin
    AFile.Position := 40;
    AFile.ReadBuffer(Buff, SizeOf(Buff));
    if Buff = $464D4520 then Result := 2;
  end;
end;

function TGWmfEmfRead.CheckWmf(AFileName: WideString): Boolean;
var  
  Buff: Longword;  
  h:   TMD4Hash;
  SBuff, LBuff: Pointer;  
  i: integer;
  Size: integer; 
begin
  Result := false;
 
  StreamInput := TWFileStream.Create(AFilename, fmOpenRead);
  FileType := CheckType(StreamInput);

  case FileType of
    1: begin
         Start := 22;
         StreamInput.Position := 0;
         FBSEWMF.m_cb := StreamInput.Size - 22;
         StreamInput.ReadBuffer(Pmh, SizeOf(Pmh));
         StreamInput.Position := 0;
         Compress(StreamInput);
         StreamInput.Free;
         Result := true;
       end;

    2: begin
          {  DWORD RecordType;       /* Record type */
             DWORD RecordSize;       /* Size of the record in bytes */
             LONG  BoundsLeft;       /* Left inclusive bounds */
             LONG  BoundsRight;      /* Right inclusive bounds */
             LONG  BoundsTop;        /* Top inclusive bounds */
             LONG  BoundsBottom;     /* Bottom inclusive bounds */
             LONG  FrameLeft;        /* Left side of inclusive picture frame */
             LONG  FrameRight;       /* Right side of inclusive picture frame */
             LONG  FrameTop;         /* Top side of inclusive picture frame */
             LONG  FrameBottom;      /* Bottom side of inclusive picture frame */
             DWORD Signature;        /* Signature ID (always 0x464D4520) */
             DWORD Version;          /* Version of the metafile */
             DWORD Size;             /* Size of the metafile in bytes */
             DWORD NumOfRecords;     /* Number of records in the metafile */
             WORD  NumOfHandles;     /* Number of handles in the handle table */
             WORD  Reserved;         /* Not used (always 0) */
             DWORD SizeOfDescrip;    /* Size of description string in WORDs */
             DWORD OffsOfDescrip;    /* Offset of description string in metafile */
             DWORD NumPalEntries;    /* Number of color palette entries */
             LONG  WidthDevPixels;   /* Width of reference device in pixels */
             LONG  HeightDevPixels;  /* Height of reference device in pixels */
             LONG  WidthDevMM;       /* Width of reference device in millimeters */
             LONG  HeightDevMM;      /* Height of reference device in millimeters */}

         StreamInput.Position := 0;
         FBSEWMF.m_fCompression := $00;
         FBSEWMF.m_fFilter := $FE;

         StreamInput.Position := 4;
         StreamInput.ReadBuffer(Buff, SizeOf(Buff));

         Buff := 0;
         FBSEWMF.m_cb := StreamInput.Size - Buff;
         Start := Buff;

         StreamInput.ReadBuffer(FBSEWMF.m_rcBounds.Left,    SizeOf(Buff));
         StreamInput.ReadBuffer(FBSEWMF.m_rcBounds.Top,     SizeOf(Buff));
         StreamInput.ReadBuffer(FBSEWMF.m_rcBounds.Right,   SizeOf(Buff));
         StreamInput.ReadBuffer(FBSEWMF.m_rcBounds.Bottom,  SizeOf(Buff));

         FBSEWMF.m_ptSize.x := Trunc((((FBSEWMF.m_rcBounds.Right)  / 96) * 2540) * 360);
         FBSEWMF.m_ptSize.y := Trunc((((FBSEWMF.m_rcBounds.bottom) / 96) * 2540) * 360);

         h := TMD4Hash.Create;

         try
           h.Init;

           Size := StreamInput.Size;
           GetMem(SBuff, StreamInput.Size);
           GetMem(LBuff, 16);
 
           StreamInput.Position := 0;
           StreamInput.ReadBuffer(SBuff^, StreamInput.Size);
           StreamInput.Position := 0;

           h.Update(SBuff^, Size);
           h.MDFinal(LBuff^);

           for i := 0 to 15 do begin
             {$ifdef D2009}
             FBSEWMF.EmfRgbUid[i] := PByte(PAnsiChar(LBuff) + i)^;
             {$else}
             FBSEWMF.EmfRgbUid[i] := PByte(PChar(LBuff) + i)^;
             {$endif}
           end;

           FreeMem(SBuff);
           FreeMem(LBuff);

         finally
           h.Free;
         end;

         StreamInput.Position := 0;
         Compress(StreamInput);

         StreamOutput.Position := 0;
         FBSEWMF.m_cbSave := StreamOutput.Size;

         StreamInput.Free;
         Result := true;
       end;
  end;
end;

function TGWmfEmfRead.GetHeight: Double;
begin
  if FileType = 2 then begin
    Result := FBSEWMF.m_rcBounds.Bottom * 0.75;
  end else begin
//    Result := (((Pmh.Box.Bottom - Pmh.Box.Top) / Pmh.Inch) * 2540) * 
//              (Scp / 2540) * 0.75;
    Result := ((Pmh.Box.Bottom - Pmh.Box.Top) / Pmh.Inch) * Scp * 0.75;
  end;
end;

function TGWmfEmfRead.GetWidth: Double;
begin
  if FileType = 2 then begin
    Result := FBSEWMF.m_rcBounds.Right * 0.75;
  end else begin
//    Result := (((Pmh.Box.right - Pmh.Box.left)/Pmh.Inch) * 2540)*(Scp/2540)* 0.75;
    Result := ((Pmh.Box.Right - Pmh.Box.Left) / Pmh.Inch) * Scp * 0.75;
  end;
end;

procedure TGWmfEmfRead.FillBSEWMF;
begin
  if FileType <> 2 then begin
    FBSEWMF.m_rcBounds := Pmh.Box;
    FBSEWMF.m_ptSize.X := Trunc((((Pmh.Box.Right - Pmh.Box.Left) / Pmh.Inch) * 2540) * 360);
    FBSEWMF.m_ptSize.y := Trunc((((Pmh.Box.Bottom - Pmh.Box.Top) / Pmh.Inch) * 2540) * 360);
    FBSEWMF.m_fCompression := $00;
    FBSEWMF.m_fFilter := $FE;
  end;
end;

{$ENDIF}

end.
