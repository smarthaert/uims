unit iiehttp3_funcs;

interface

//{$DEFINE TIEHTTP_GUNZIP}

uses classes, sysutils, tntlite;

//type TAnsiStringList = TStringList;
type bytestring = ansistring;

type arStr = array of ansistring;
function split(s: ansistring; char: ansichar): arstr;
procedure CheckAndDecompress(var inpStream: TMemoryStream; url : widestring; default_zip_method: ansichar = 'Z');
function Stream_To_ByteString(astream: TMemoryStream): bytestring;
function breakuu(s: bytestring) : bytestring;
{ Base64 encode and decode a string }
{** Written by David Barton (davebarton@bigfoot.com) **************************}
{** http://www.scramdisk.clara.net/ *******************************************}
function B64Encode(const S: bytestring): bytestring;
function B64Decode(const S: bytestring): bytestring;
function _UTF8ToWideString(s: ansistring): widestring;
function _WideStringToUTF8(s: widestring): ansistring;
function AnsiStringReplace(const S, OldPattern, NewPattern: ansistring; flags: TReplaceFlags): ansistring;

implementation

uses {zlibex} zlib {$IFDEF TIEHTTP_GUNZIP}, gunzip {$ENDIF};

function split(s: ansistring; char: ansichar): arstr;
var
  p,i : integer;
  substr : ansistring;
begin
  i := 1;
  repeat
    p := pos(char, s);
    if p=0 then p:=length(s)+1;
    substr := copy(s,1,p-1);
    delete(s,1,p);

    setlength(result, i);
    result[i-1] := substr;
    inc(i);
    if s='' then break;
  until false;
end;

{procedure ZLIB_DecompressStream(inpStream, outStream: TMemoryStream);
begin
  //
  //100% compatible with php gzuncompress
  //
  ZDeCompressStream(inpStream, outStream);
  outStream.Position := 0;
end;}

procedure ZLIB_DecompressStream(inpStream, outStream: TMemoryStream);
var InpBuf,OutBuf: Pointer;
var OutBytes,sz: integer;
begin
  //
  //100% compatible with php gzuncompress
  //
  InpBuf := nil;
  OutBuf := nil;
  sz := inpStream.size-inpStream.Position;
  if sz > 0 then try
    GetMem(InpBuf,sz);
    inpStream.Read(InpBuf^,sz);
    try
      DecompressBuf(InpBuf,sz,0,OutBuf,OutBytes);
      outStream.Write(OutBuf^,OutBytes);
    except
      OutBuf := nil; //it is freed on exception internally
    end;
  finally
    if InpBuf <> nil then FreeMem(InpBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;
  outStream.Position := 0;
end;

procedure DecompressStream(inpStream: TMemoryStream; var outStream: TMemoryStream; method: ansichar);
//method: Z ZLIB -- //100% compatible with php  gzcompress -- not compatible with aspx.DeflateStream
//        G GZIP -- //100% compatible with aspx GZipStream
begin
  if method='Z' then begin
    inpStream.Position := 8;
    ZLIB_DecompressStream(inpStream, outStream)
  end
  else if method='G' then begin
    inpStream.Position := 0;
    {$IFDEF TIEHTTP_GUNZIP}
    gunzip.gz_uncompress(inpStream, outStream)
    {$ENDIF}
  end;
  //else
  //  raise exception.Create('Unknown decompression method');
end;

procedure CheckAndDecompress(var inpStream: TMemoryStream; url : widestring; default_zip_method: ansichar = 'Z');
var
  must_decompress : boolean;
  zip_header : array[1..8] of ansichar;
  tmpStream : TMemoryStream;
  unzip_method : ansichar;
begin
  inpStream.Read(zip_header,8);
  //must_decompress := zip_header = #31'?#8#0#0#0#0#0;
  must_decompress := zip_header = #31#139#8#0#0#0#0#0;
  if not must_decompress then begin
    inpStream.position := 0;
    exit;
  end;
  //else: position of inpStream must stay at position 8 (length of lz header)

  //raise exception.create('compressed stream temporarily not supported');

  //inpStream.Position := 0;
  //inpStream.SaveToFile('c:\file1_php.gzip');
  //inpStream.Position := 8;

  tmpStream := TMemoryStream.Create;
  tmpStream.position := 0;

  unzip_method := default_zip_method;
  
  //php uses zlib based compression
  if (unzip_method=#0) or ((unzip_method<>'Z') and (unzip_method<>'G')) then
    unzip_method := 'Z'; //default method is zlib
  //todo: remove test G
  //unzip_method := 'G'; //default method is zlib

  //however asp/aspx on iis uses gzip compression (gzip.dll)
  {$IFDEF TIEHTTP_GUNZIP}
  if Pos('.asp', widelowercase(url))>0 then begin //.asp and .aspx
    //gzip (gunzip) decompression for asp and aspx pages
    //this is the default http compression for IIS5/6
    unzip_method := 'G';
  end;
  {$ENDIF}

  try
    DecompressStream(inpStream, tmpStream, unzip_method);
    //if tmpStream.Size = 0 then
    //  raise Exception.Create('no decompression results');
  except
    tmpStream.Size := 0;
  end;

  //try to decompress using the other algorithm
  if tmpStream.Size=0 then begin
    //try to switch decompression methods
    if unzip_method='Z' then
      unzip_method := 'G'
    else
      unzip_method := 'Z';  
    DecompressStream(inpStream, tmpStream, unzip_method);
  end;

  inpStream.free;
  inpStream := tmpStream;
end;


///////////////////////////////////////////////////////////////

function Stream_To_ByteString(astream: TMemoryStream): bytestring;
begin
  SetLength(result, astream.Size);
  if astream.Size > 0 then
    Move(astream.Memory^, result[1], astream.Size);
end;

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

function breakuu(s: bytestring) : bytestring;
var
  i : integer;
begin
  result := '';
  //showmessage(inttostr(length(s)));
  for i := 1 to length(s) do begin
    result := result + s[i];
    if  (i mod 64 = 0) then
      result := result + #13;
  end;
end;


////////////////////
////////////////////
////////////////////
////////////////////
const
  B64Table= 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

function B64Encode(const S: bytestring): bytestring;
{by David Barton (davebarton@bigfoot.com) **************************}
{** http://www.scramdisk.clara.net/ }
var
  i: integer;
  InBuf: array[0..2] of byte;
  OutBuf: array[0..3] of ansichar;
begin
  SetLength(Result,((Length(S)+2) div 3)*4);
  for i:= 1 to ((Length(S)+2) div 3) do
  begin
    if Length(S)< (i*3) then
      Move(S[(i-1)*3+1],InBuf,Length(S)-(i-1)*3)
    else
      Move(S[(i-1)*3+1],InBuf,3);
    OutBuf[0]:= B64Table[((InBuf[0] and $FC) shr 2) + 1];
    OutBuf[1]:= B64Table[(((InBuf[0] and $03) shl 4) or ((InBuf[1] and $F0) shr 4)) + 1];
    OutBuf[2]:= B64Table[(((InBuf[1] and $0F) shl 2) or ((InBuf[2] and $C0) shr 6)) + 1];
    OutBuf[3]:= B64Table[(InBuf[2] and $3F) + 1];
    Move(OutBuf,Result[(i-1)*4+1],4);
  end;
  if (Length(S) mod 3)= 1 then
  begin
    Result[Length(Result)-1]:= '=';
    Result[Length(Result)]:= '=';
  end
  else if (Length(S) mod 3)= 2 then
    Result[Length(Result)]:= '=';
end;

function B64Decode(const S: bytestring): bytestring;
{by David Barton (davebarton@bigfoot.com) **************************}
{** http://www.scramdisk.clara.net/ }
var
  i: integer;
  InBuf: array[0..3] of byte;
  OutBuf: array[0..2] of byte;
begin
  if (Length(S) mod 4)<> 0 then
    raise Exception.Create('Base64: Incorrect string format');
  SetLength(Result,((Length(S) div 4)-1)*3);
  for i:= 1 to ((Length(S) div 4)-1) do
  begin
    Move(S[(i-1)*4+1],InBuf,4);
    if (InBuf[0]> 64) and (InBuf[0]< 91) then
      Dec(InBuf[0],65)
    else if (InBuf[0]> 96) and (InBuf[0]< 123) then
      Dec(InBuf[0],71)
    else if (InBuf[0]> 47) and (InBuf[0]< 58) then
      Inc(InBuf[0],4)
    else if InBuf[0]= 43 then
      InBuf[0]:= 62
    else
      InBuf[0]:= 63;
    if (InBuf[1]> 64) and (InBuf[1]< 91) then
      Dec(InBuf[1],65)
    else if (InBuf[1]> 96) and (InBuf[1]< 123) then
      Dec(InBuf[1],71)
    else if (InBuf[1]> 47) and (InBuf[1]< 58) then
      Inc(InBuf[1],4)
    else if InBuf[1]= 43 then
      InBuf[1]:= 62
    else
      InBuf[1]:= 63;
    if (InBuf[2]> 64) and (InBuf[2]< 91) then
      Dec(InBuf[2],65)
    else if (InBuf[2]> 96) and (InBuf[2]< 123) then
      Dec(InBuf[2],71)
    else if (InBuf[2]> 47) and (InBuf[2]< 58) then
      Inc(InBuf[2],4)
    else if InBuf[2]= 43 then
      InBuf[2]:= 62
    else
      InBuf[2]:= 63;
    if (InBuf[3]> 64) and (InBuf[3]< 91) then
      Dec(InBuf[3],65)
    else if (InBuf[3]> 96) and (InBuf[3]< 123) then
      Dec(InBuf[3],71)
    else if (InBuf[3]> 47) and (InBuf[3]< 58) then
      Inc(InBuf[3],4)
    else if InBuf[3]= 43 then
      InBuf[3]:= 62
    else
      InBuf[3]:= 63;
    OutBuf[0]:= (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $03);
    OutBuf[1]:= (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $0F);
    OutBuf[2]:= (InBuf[2] shl 6) or (InBuf[3] and $3F);
    Move(OutBuf,Result[(i-1)*3+1],3);
  end;
  if Length(S)<> 0 then
  begin
    Move(S[Length(S)-3],InBuf,4);
    if InBuf[2]= 61 then
    begin
      if (InBuf[0]> 64) and (InBuf[0]< 91) then
        Dec(InBuf[0],65)
      else if (InBuf[0]> 96) and (InBuf[0]< 123) then
        Dec(InBuf[0],71)
      else if (InBuf[0]> 47) and (InBuf[0]< 58) then
        Inc(InBuf[0],4)
      else if InBuf[0]= 43 then
        InBuf[0]:= 62
      else
        InBuf[0]:= 63;
      if (InBuf[1]> 64) and (InBuf[1]< 91) then
        Dec(InBuf[1],65)
      else if (InBuf[1]> 96) and (InBuf[1]< 123) then
        Dec(InBuf[1],71)
      else if (InBuf[1]> 47) and (InBuf[1]< 58) then
        Inc(InBuf[1],4)
      else if InBuf[1]= 43 then
        InBuf[1]:= 62
      else
        InBuf[1]:= 63;
      OutBuf[0]:= (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $03);
      Result:= Result + char(OutBuf[0]);
    end
    else if InBuf[3]= 61 then
    begin
      if (InBuf[0]> 64) and (InBuf[0]< 91) then
        Dec(InBuf[0],65)
      else if (InBuf[0]> 96) and (InBuf[0]< 123) then
        Dec(InBuf[0],71)
      else if (InBuf[0]> 47) and (InBuf[0]< 58) then
        Inc(InBuf[0],4)
      else if InBuf[0]= 43 then
        InBuf[0]:= 62
      else
        InBuf[0]:= 63;
      if (InBuf[1]> 64) and (InBuf[1]< 91) then
        Dec(InBuf[1],65)
      else if (InBuf[1]> 96) and (InBuf[1]< 123) then
        Dec(InBuf[1],71)
      else if (InBuf[1]> 47) and (InBuf[1]< 58) then
        Inc(InBuf[1],4)
      else if InBuf[1]= 43 then
        InBuf[1]:= 62
      else
        InBuf[1]:= 63;
      if (InBuf[2]> 64) and (InBuf[2]< 91) then
        Dec(InBuf[2],65)
      else if (InBuf[2]> 96) and (InBuf[2]< 123) then
        Dec(InBuf[2],71)
      else if (InBuf[2]> 47) and (InBuf[2]< 58) then
        Inc(InBuf[2],4)
      else if InBuf[2]= 43 then
        InBuf[2]:= 62
      else
        InBuf[2]:= 63;
      OutBuf[0]:= (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $03);
      OutBuf[1]:= (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $0F);
      Result:= Result + char(OutBuf[0]) + char(OutBuf[1]);
    end
    else
    begin
      if (InBuf[0]> 64) and (InBuf[0]< 91) then
        Dec(InBuf[0],65)
      else if (InBuf[0]> 96) and (InBuf[0]< 123) then
        Dec(InBuf[0],71)
      else if (InBuf[0]> 47) and (InBuf[0]< 58) then
        Inc(InBuf[0],4)
      else if InBuf[0]= 43 then
        InBuf[0]:= 62
      else
        InBuf[0]:= 63;
      if (InBuf[1]> 64) and (InBuf[1]< 91) then
        Dec(InBuf[1],65)
      else if (InBuf[1]> 96) and (InBuf[1]< 123) then
        Dec(InBuf[1],71)
      else if (InBuf[1]> 47) and (InBuf[1]< 58) then
        Inc(InBuf[1],4)
      else if InBuf[1]= 43 then
        InBuf[1]:= 62
      else
        InBuf[1]:= 63;
      if (InBuf[2]> 64) and (InBuf[2]< 91) then
        Dec(InBuf[2],65)
      else if (InBuf[2]> 96) and (InBuf[2]< 123) then
        Dec(InBuf[2],71)
      else if (InBuf[2]> 47) and (InBuf[2]< 58) then
        Inc(InBuf[2],4)
      else if InBuf[2]= 43 then
        InBuf[2]:= 62
      else
        InBuf[2]:= 63;
      if (InBuf[3]> 64) and (InBuf[3]< 91) then
        Dec(InBuf[3],65)
      else if (InBuf[3]> 96) and (InBuf[3]< 123) then
        Dec(InBuf[3],71)
      else if (InBuf[3]> 47) and (InBuf[3]< 58) then
        Inc(InBuf[3],4)
      else if InBuf[3]= 43 then
        InBuf[3]:= 62
      else
        InBuf[3]:= 63;
      OutBuf[0]:= (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $03);
      OutBuf[1]:= (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $0F);
      OutBuf[2]:= (InBuf[2] shl 6) or (InBuf[3] and $3F);
      Result:= Result + Char(OutBuf[0]) + Char(OutBuf[1]) + Char(OutBuf[2]);
    end;
  end;
end;

function _UTF8ToWideString(s: ansistring): widestring;
begin
  result := UTF8Decode(s);
end;

function _WideStringToUTF8(s: widestring): ansistring;
begin
  result := UTF8Encode(s);
end;

function AnsiStringReplace(const S, OldPattern, NewPattern: ansistring; flags: TReplaceFlags): ansistring;
begin
  {$IFDEF UNICODE}
    zz result := sysutils.ansiStringReplace(S, OldPattern, NewPattern, Flags)
  {$ELSE}
    {ansi}StringReplace(S, OldPattern, NewPattern, Flags);
  {$ENDIF}
end;

////////////////////
////////////////////
////////////////////
////////////////////

end.
