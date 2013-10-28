//////////////////////////////////////////////////////////////////////////////
//
//	Unit:        xlsvbar
//       
//      Description: Read vba code
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlsvbar;
{$Q-}
{$R-}

interface
uses xlsvba, xlsblob;

type

  TXLSVBAModule = class
  private
    FName: widestring;
    FSourceCode: widestring;
    function GetName: widestring;
    function GetSourceCode: widestring;
  public 
    constructor Create(ModuleName: widestring; ModuleSourceCode: widestring);
    destructor Destroy; override;
    property Name: widestring read GetName;
    property SourceCode: widestring read GetSourceCode;
  end;

  TXLSVBAProject = class
  private
    FVBAStorage: TXLSFileStorage;
    FVBA: TXLSFileStorage;
    FCount: integer;
    FModules: array of TXLSVBAModule;
    FCodePage: integer;
    FProjectName: widestring;

    FModuleName: widestring;
    FModuleStreamName: widestring;
    FModuleTextOffset: integer;
    FModuleIndex: integer;

    function GetCount: integer;
    function GetModule(index: integer): TXLSVBAModule; 
    function GetVBAStorage: TXLSFileStorage;
    function GetVBAProjectStream: TXLSBlob;
    function GetDirStream: TXLSBlob;
    function ParseVBAStorage: integer;
    function ParseVBAProjectStream(proj: TXLSBlob): integer;
    function ParseDirStream(data: TXLSBlob): integer;
    function GetStream(StreamName: widestring; Offset: integer): TXLSBlob;
    function ParseDirRecord(recid: word; recsize: integer; offset: integer; data: TXLSBlob): integer;
    function CreateModule: integer;
  public 
    constructor Create; 
    destructor Destroy; override;
    procedure Init(VBAStorage: TXLSFileStorage);
    property Count: integer read GetCount;
    property Item[index: integer]: TXLSVBAModule read GetModule; default;
  end;

 
implementation
uses SysUtils, math;


type

  TXLSVBADecompressor = class
  private
    FSrc: TXLSBlob;
    FDst: TXLSBlobList;
    FData: TXLSBlob;
    FOffset: integer;
    FCompressedEnd: integer;
    FCompressedRecordEnd: integer;
    FDecompressedCurrent: integer;
    FDecompressedChunkStart: integer;
    function DecompressContainer: integer;
    function DecompressChunk: integer;
    function DecompressRawChunk: integer;
    function DecompressTokenSequence: integer;
    function DecompressToken(ind: integer; flagbyte: byte): integer;
  public
    constructor Create(src: TXLSBlob; Offset: integer);
    function Process: TXLSBlob;
    destructor Destroy; override;
  end;



{TXLSVBADecompressor}
constructor TXLSVBADecompressor.Create(src: TXLSBlob; Offset: integer);
begin
  inherited Create;
  FSrc := src;
  FDst := TXLSBlobList.Create;
  FData := TXLSBlob.Create(4096);
  FOffset := Offset;
  FCompressedEnd := -1;
  FCompressedRecordEnd := integer(FSrc.DataLength);
  FDecompressedCurrent := 0;
  //FSrc.Dump;
end;

destructor TXLSVBADecompressor.Destroy;
begin
   FDst.Free;
   FData.Free;
   inherited Destroy;
end;

function TXLSVBADecompressor.DecompressContainer: integer;
var b: byte;
begin
  Result := 1;
  b := FSrc.GetByte(FOffset);
  //SignatureByte (1 byte): Specifies the beginning 
  //of the CompressedContainer. MUST be 0x01.
  if b <> $01 then begin
     Result := -1;                                
  end else begin
     Inc(FOffset);
     while FOffset < FCompressedRecordEnd do begin
       Result := DecompressChunk;
       if Result <> 1 then break; 
     end;
  end;   
end;

function TXLSVBADecompressor.DecompressChunk: integer;
var Size: integer;
    ChunkSignature: word;                                    
    CompressedFlag: boolean; 
    w: word;
begin
  Result := 1;
  //Chunk header
  w := FSrc.GetWord(FOffset);
  Size := (w and $0FFF) + 3;
  CompressedFlag := ((w and $8000) shr 15) = $0001;
  ChunkSignature := (w and $7000) shr 12;
  if ChunkSignature <> 3 then begin
     Result := -1;
  end;
  if Result = 1 then begin
     //w riteln('Chunk size: ', Size);
     //w riteln('Chunk flag:', CompressedFlag);

     FCompressedEnd := FOffset + Size;
     FDecompressedChunkStart := FDecompressedCurrent;
     if FCompressedEnd > FCompressedRecordEnd then FCompressedEnd := FCompressedRecordEnd;
     Inc(FOffset, 2);
     if CompressedFlag then begin
        while FOffset < FCompressedEnd do begin
          Result := DecompressTokenSequence()
        end; 
        if FData.DataLength > 0 then begin
           //w riteln('append ', FData.DataLength, ' bytes');
           FDst.Append(FData, true);
           FData.Reset;
        end;
     end else begin
        Result := DecompressRawChunk();   
     end; 
  end;
end;


function TXLSVBADecompressor.DecompressTokenSequence: integer;
var FlagByte: byte;
    i: integer;
begin
   Result := 1;
   FlagByte := FSrc.GetByte(FOffset);
   Inc(FOffset);
   if FOffset < FCompressedEnd then begin
      for i := 0 to 7 do begin
          if FOffset < FCompressedEnd then begin
             Result := DecompressToken(i, FlagByte);    
          end;
      end;
   end;
end;

function TXLSVBADecompressor.DecompressToken(ind: integer; flagbyte: byte): integer;
var flag: integer;
    b: byte;
    token: word;
    offset, length: integer;
    difference: integer;
    bitcount: integer;
    lengthmask: integer;
    offsetmask: integer;
    copysource: integer;
    i: integer;
begin
  Result := 1;
  //extract flag bit
  flag := (flagbyte shr ind) and 1;
  if flag = 0 then begin
     b := FSrc.GetByte(FOffset);
     FData.AddByte(b);
     Inc(FOffset);
     Inc(FDecompressedCurrent);
  end else begin
     token := FSrc.GetWord(FOffset);
     difference := FDecompressedCurrent - FDecompressedChunkStart;
     bitcount := math.ceil(math.log2(difference));
     if bitcount < 4 then bitcount := 4;
     lengthmask := $FFFF shr bitcount;
     offsetmask := not(lengthmask) and $FFFF;
     length := (token and lengthmask) + 3;
     offset := ((token and offsetmask) shr (16 - bitcount)) + 1;
     copysource := integer(FData.DataLength) - offset;
     //copy copysource, length to FDecompressedCurrent;
     for i := 0 to (length - 1) do begin
       FData.AddByte(FData.GetByte(copysource + i));
     end;   
     Inc(FDecompressedCurrent, length);
     Inc(FOffset, 2);
  end;
end;

function TXLSVBADecompressor.DecompressRawChunk: integer;
begin
  //w riteln('!!!decompress raw chunk 4096');
  Result := 1;
  FData.CopyData(FSrc, FOffset, 4096);
  Inc(FOffset, 4096);
  Inc(FDecompressedCurrent, 4096);
  FDst.Append(FData, true);
  FData.Reset;
end;

function TXLSVBADecompressor.Process: TXLSBlob;
var r: integer;
begin
  r := DecompressContainer();
  if r = 1 then begin
     FDst.GetData(0, FDst.TotalSize, Result);
  end else begin
     Result := nil;
  end;
end;

{TXLSVBAProject}

constructor TXLSVBAProject.Create;
begin
  inherited Create;
  FCount := 0;
  FModuleIndex := 0;
end;

destructor TXLSVBAProject.Destroy;
var i: integer;
begin
  if FCount > 0 then begin
     for i := 0 to FCount - 1 do begin
       FModules[i].Free;
     end;
  end;
  inherited Destroy;
end;

function TXLSVBAProject.GetCount: integer;
begin
  Result := FCount;
end;
                     
function TXLSVBAProject.GetModule(index: integer): TXLSVBAModule;  
begin
  if (index < 1) or (index > FCount) then begin
     raise Exception.Create('Invalid index');
  end;
  Result := FModules[index - 1];
end;

procedure TXLSVBAProject.Init(VBAStorage: TXLSFileStorage);
begin
  FVBAStorage := VBAStorage;
  ParseVBAStorage;
end;

function TXLSVBAProject.GetVBAStorage: TXLSFileStorage;
var r: TXLSFileItem;
begin
  Result := nil;
  if Assigned(FVBAStorage) then begin
     r := FVBAStorage.GetChildByName('vba');
     if Assigned(r) then begin
        if r is TXLSFileStorage then begin
           Result := r as TXLSFileStorage; 
        end;
     end;
  end;
end;

function TXLSVBAProject.GetVBAProjectStream: TXLSBlob;
var r: TXLSFileItem;
begin
  Result := nil;
  if Assigned(FVBA) then begin
     r := FVBA.GetChildByName('_vba_project');
     if Assigned(r) then begin
        if r is TXLSFileStream then begin
           Result := (TXLSFileStream(r)).Data; 
        end;
     end;
  end;
end;

function TXLSVBAProject.GetDirStream: TXLSBlob;
var r: TXLSFileItem;
    d: TXLSVBADecompressor;
begin
  Result := nil;
  if Assigned(FVBA) then begin
     r := FVBA.GetChildByName('dir');
     if Assigned(r) then begin
        if r is TXLSFileStream then begin
           d := TXLSVBADecompressor.Create((TXLSFileStream(r)).Data, 0);
           Result := d.Process();
           d.Free;
        end;
     end;
  end;
end;

function TXLSVBAProject.GetStream(StreamName: widestring; Offset: integer): TXLSBlob;
var r: TXLSFileItem;
    d: TXLSVBADecompressor;
begin
  Result := nil;
  if Assigned(FVBA) then begin
     r := FVBA.GetChildByName(StreamName);
     if Assigned(r) then begin
        if r is TXLSFileStream then begin
           d := TXLSVBADecompressor.Create((TXLSFileStream(r)).Data, Offset);
           Result := d.Process();
           d.Free;
        end;
     end;
  end;
end;


function TXLSVBAProject.ParseVBAProjectStream(proj: TXLSBlob): integer;
var w: word;
begin
  Result := 1;
  
  //reserved1 (2 bytes) must be 0x61CC
  w := proj.GetWord(0);
  if w <> $61CC then begin
     //invalid _VBA_Project stream
     Result := -1; 
  end;
  
  //Version (2 bytes): An unsigned integer that specifies 
  //the version of VBA used to create the VBA project. 
  //MUST be ignored on read. MUST be 0xFFFF on write. 

  //if Result = 1 then begin
  
end;

function TXLSVBAProject.ParseDirRecord(recid: word; recsize: integer; offset: integer; data: TXLSBlob): integer;
begin
   //w riteln('recid:', inttohex(recid, 4), ' size:', recsize);
   Result := recsize;  
   case recid of
      $01: begin
             //projectsyskind
             //w riteln('projectsyskind');
             Result := recsize; 
           end;
      $02: begin
             //projectlcid
             //w riteln('projectlcid');
             Result := recsize; 
           end;
      $14: begin
             //PROJECTLCIDINVOKE
             //w riteln('PROJECTLCIDINVOKE');
             Result := recsize; 
           end;
      $03: begin
             //PROJECTCODEPAGE
             FCodePage := data.GetWord(offset);
             //w riteln('PROJECTCODEPAGE ', FCodePage);
             Result := recsize; 
           end;
      $04: begin
             //PROJECTNAME
             if recsize > 0 then begin
                FProjectName := StringToWideStringEx(data.GetString(offset, recsize), FCodePage);
             end else begin
                FProjectName := '';
             end; 
             //w riteln('PROJECTNAME ', String(FProjectName));
             Result := recsize; 
           end;
      $05: begin
             //PROJECTDOCSTRING
             //w riteln('PROJECTDOCSTRING');
             Result := recsize + 2; //+reserved        
             Result := Result + integer(data.GetLong(offset + Result)) + 4;
    
           end;
            
      $06: begin
             //PROJECTHELPFILEPATH  
             //w riteln('PROJECTHELPFILEPATH');
             Result := recsize + 2; //+reserved        
             Result := Result + integer(data.GetLong(offset + Result)) + 4;
           end;
      $07: begin
             //PROJECTHELPCONTEXT  
             //w riteln('PROJECTHELPCONTEXT');
             Result := recsize;                         
           end;
      $08: begin
             //PROJECTLIBFLAGS  
             //w riteln('PROJECTLIBFLAGS');
             Result := recsize;        
           end;
      $09: begin
             //PROJECTVERSION  
             //w riteln('PROJECTVERSION');
             //ignore size
             Result := 6;        
           end;
      $0C: begin
             //PROJECTCONSTANTS  
             //w riteln('PROJECTCONSTANTS');
             Result := recsize + 2; //+reserved        
             Result := Result + integer(data.GetLong(offset + Result)) + 4;
           end;
      $16: begin
             //REFERENCENAME 
             //w riteln('REFERENCENAME');
             Result := recsize + 2; //+reserved        
             Result := Result + integer(data.GetLong(offset + Result)) + 4;
             //id := data.GetWord(offset + Result);
             //w riteln('id ', inttohex(id, 4));
           end;
      $33: begin
             //REFERENCEORIGINAL
             //w riteln('REFERENCEORIGINAL');
             Result := recsize;        
           end; 
      $2F: begin  
             //REFERENCECONTROL
             //w riteln('!!!!REFERENCECONTROL');
             Result := recsize;        
             //NameRecordExtended optional recid $16  
           end;
      $30: begin
             //continue  REFERENCECONTROL  reserved3
             Result := recsize;        
           end;

      $0D: begin
             //w riteln('!!!REFERENCEREGISTERED'); 
             Result := recsize;        
           end;
      $0E: begin
             //w riteln('REFERENCEPROJECT'); 
             Result := recsize;        
           end;
      $0F: begin
             //w riteln('PROJECTMODULES'); 
             FCount := data.GetWord(offset);
             if FCount > 0 then SetLength(FModules, FCount);
             //w riteln('cnt=', cnt);
             Result := recsize;
             //skip cookie
             Inc(Result, 8);
           end;
      $19: begin
             //namerecord
             FModuleName := StringToWideStringEx(data.GetString(offset, recsize), FCodePage);
             Result := recsize; 
             //w riteln('modulename=', string(fmodulename));
             FModuleStreamName := '';
             FModuleTextOffset := -1;
           end;
      $47: begin
             //modulenameunicode
             //w riteln('moduleunicodename');
             Result := recsize;   
           end; 
      $1A: begin
             //modulestreamname
             //w riteln('modulestreamname');
             Result := recsize;                    
             FModuleStreamName := StringToWideStringEx(data.GetString(offset, recsize), FCodePage);
             //w riteln('modulestreamname: ', string(fmodulestreamname));
           end; 
      $32: begin
             //unicodestreamname (skip)
             //w riteln('unicodemodulestreamname');
             Result := recsize;
           end; 
      $1C: begin
             //moduledocstring (skip)
             //w riteln('moduledocstring');
             Result := recsize;
           end; 
      $48: begin
             //moduledocstringunicode (skip)
             //w riteln('moduledocstringunicode');
             Result := recsize;
           end; 
      $31: begin
             //moduleoffset
             //w riteln('moduleoffset');
             Result := recsize;
             FModuleTextOffset := data.GetLong(offset);    
             //w riteln('moduletextoffset', FModuleTextOffset);
           end;                             
      $1E: begin
             //modulehelpcontext (skip)
             //w riteln('modulehelpcontext');
             Result := recsize;
           end; 
      $2C: begin
             //modulecookie (skip)
             //w riteln('modulecookie');
             Result := recsize;
           end; 
      $21,
      $22: begin
             //moduletype (skip)
             //w riteln('moduletype');
             Result := recsize;
           end; 
      $25: begin
             //modulereadonly (skip)
             //w riteln('modulereadonly');
             Result := recsize;
           end; 
      $28: begin
             //moduleprivate (skip)
             //w riteln('moduleprivate');
             Result := recsize;
           end; 
      $2B: begin
             //module terminator 
             //w riteln('moduleterminator');
             Result := recsize;
             //create module
             CreateModule;
           end; 
      $10: begin
             //dir terminator 
             //w riteln('dir terminator');
             Result := recsize;
           end; 
   end; 
end;

function TXLSVBAProject.ParseDirStream(data: TXLSBlob): integer;
var id: word;
    size: integer;
    offset: integer;
    len: integer;
begin
  Result := 1; 
  offset :=  0;
  len := data.DataLength;
  while offset <= (len - 6) do begin 
      id := data.GetWord(offset);
      size := integer(data.GetLong(offset + 2));
      inc(offset, 6);
      size := ParseDirRecord(id, size, offset, data);
      inc(offset, size);
      //w riteln('>> offset:',  offset, ' len:', data.DataLength);
      if id = $10 then break; //dir terminator
  end;
end;

function TXLSVBAProject.ParseVBAStorage: integer;
var proj: TXLSBlob;
    dir: TXLSBlob;
begin
   Result := 1;
   proj := nil;
   dir := nil;

   FVBA := GetVBAStorage();
   if Not(Assigned(FVBA)) then begin
      Result := -1;
   end;
   if Result = 1 then begin
      proj := GetVBAProjectStream;
      if not(Assigned(proj)) then Result := -1;            
   end;
   if Result = 1 then begin
      Result := ParseVBAProjectStream(proj);
   end;
   if Result = 1 then begin
      dir := GetDirStream;
      if not(Assigned(dir)) then Result := -1;            
   end;
   if Result = 1 then begin
      Result := ParseDirStream(dir);
      dir.Free; 
   end;
end;

function TXLSVBAProject.CreateModule: integer;
var d: TXLSBlob;
    sc: widestring;
begin
  Result := 1;
  d := GetStream(FModuleStreamName, FModuleTextOffset);
  if Assigned(d) then begin
     sc := StringToWideStringEx(d.GetString(0, d.DataLength), FCodePage);
  end else begin
     sc := '';
  end;
  FModules[FModuleIndex] := TXLSVBAModule.Create(FModuleName, sc);
  Inc(FModuleIndex);
end;



function TXLSVBAModule.GetName: widestring;
begin
  Result := FName;
end;


function TXLSVBAModule.GetSourceCode: widestring;
begin
  Result := FSourceCode;
end;

constructor TXLSVBAModule.Create(ModuleName: widestring; ModuleSourceCode: widestring);
begin
   inherited Create;
   FName := ModuleName;
   FSourceCode := ModuleSourceCode;
end;

destructor TXLSVBAModule.Destroy;
begin
   inherited Destroy;
end;


end.


