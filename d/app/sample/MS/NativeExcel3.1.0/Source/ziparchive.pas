//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         ziparchive
//
//      Description:  zip archives
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2008 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit ZipArchive;
{$I xlsdef.inc}
{$Q-}
{$R-}

interface
uses classes, xlshash;


type
    TCompressionMethod = (
          cmStored, 
          cmShrunk, 
          cmReduced1, 
          cmReduced2, 
          cmReduced3, 
          cmReduced4, 
          cmImploded, 
          cmTokenizingReserved, 
          cmDeflated, 
          cmDeflated64, 
          cmDCLImploding, 
          cmPKWAREReserved
    ); 


   TLocalFile = class
   private
      FSignature: array[0..4] of byte;
      FVersionNeededToExtract: word; 
      FGeneralPurposeBitFlags: word; 
      FCompressionMethod:      word; 
      FLastModFileTimeDate:    longword;   
      FCrc32:                  longword;   
      FCompressedSize:         longword;
      FUncompressedSize:       longword;
      FFilenameLength:         word; 
      FExtrafieldLength:       word; 

      FFileName: widestring;
      FExtraField: widestring;
      FOffset: longint;
      FMinSize: integer;
      function GetSize: integer;
   public
      constructor Create; overload;
      constructor Create(AFileName: widestring; isFile: boolean; date: TDateTime);overload;
      procedure Store(outputstream: TStream);
      procedure Update(outputstream: TStream; crc32: longword; compressedsize: longword; auncompressedsize: longword);
      function Parse(inputstream: TStream; offset: longint): integer;

      property Size: integer read GetSize;
      property DataOffset: longint read FOffset;
      property CompressedSize: longword read FCompressedSize;
      property FileName: widestring read FFileName;
   end;


   TCentralDirectoryFile = class
   private
      FSignature: array[0..3] of byte; {0x50, 0x4b, 0x01, 0x02}
      FVersionMadeBy: word;
      FVersionNeededToExtract: word;
      FGeneralPurposeBitFlags: word;
      FCompressionMethod: word;
      FLastmodFileTimeDate: longword;
      FCrc32: longword;
      FCompressedSize: longword;
      FUnCompressedSize: longword;
      FFileNameLength: word;
      FExtraFieldLength: word;
      FFileCommentLength: word;
      FDiscNumberStart: word;
      FInternalFileAttributes: word;
      FExternalFileAttributes: longword;
      FRelativeOffsetOfLocalHeader: longword;
      FFileName: widestring;
      FExtraField: widestring;
      FFileComment: widestring;   
      FMinSize: integer; {4*7 + 2*9}
      FfaDirectory: longword; {0x00000010}
      FfaArchive: longword;   {0x00000020}
      function GetCompressionMethod: TCompressionMethod;
      function GetIsFolder: boolean;
      function GetSize: integer;
   public
      constructor Create;
      procedure Update(aCrc32, acompressedsize, auncompressedsize: longword);
      procedure CreateFolder(foldername: widestring; date: TDateTime; offset: longword);
      procedure CreateFile(filename: widestring; date: TDateTime; offset: longword);
      procedure Store(outputstream: TStream);
      function Parse(inputstream: TStream): integer;             
      property CompressionMethod: TCompressionMethod read GetCompressionMethod;
      property LocalFileHeaderOffset: longword read FRelativeOffsetOfLocalHeader;
      property FileName: widestring read FFileName;
      property IsFolder: boolean read GetIsFolder;
      property Size: integer read GetSize;
      property UnCompressedSize: longword read FUnCompressedSize;
   end;

   TZipEntry = class
   private
      FCdFile: TCentralDirectoryFile;
      FLFile: TLocalFile;

      function GetZipFileName: widestring;
      function GetFileName: widestring;
      function GetIsFolder: boolean;
      function GetInternalStream(inputstream: TStream): TStream;
      function GetCompressionMethod: TCompressionMethod;
      function GetOutputStream(outputstream: TStream): TStream;
   protected
      procedure StoreCentralDirectoryRecord(outputstream: TStream); 
      procedure UpdateFileProperties(crc32: longword; compressedsize: longword; uncompressedsize: longword; outputstream: TStream);
   public
      constructor Create; overload;
      constructor Create(cdfile: TCentralDirectoryFile); overload;
      destructor Destroy; override;
      function GetStream(inputstream: TStream): TStream;
      function ParseLocalHeader(inputstream: TStream): integer;
      procedure CreateFolder(foldername: widestring; date: TDateTime; outputstream: TStream);
      function CreateFile(filename: widestring; date: TDateTime; outputstream: TStream): TStream;

      property ZipFileName: widestring read GetZipFileName; 
      property FileName: widestring read GetFileName;
      property IsFolder: boolean read GetIsFolder;
      property CompressionMethod: TCompressionMethod read GetCompressionMethod;
   end;

   TZipEntries = class
   private
      FNameIndex: THashInteger;
      FIndexItem: TObjectArray;
      function GetCount: integer;
      function GetEntry(i: integer): TZipEntry;
      function GetEntryByName(name: widestring): TZipEntry;
      function ParseLocalHeaders(inputstream: TStream): integer;
   public
      constructor Create;
      destructor Destroy; override;
      function Add(item: TCentralDirectoryFile): integer; overload;
      function Add(item: TZipEntry): integer; overload;
      function OpenFile(filename: widestring; inputstream: TStream): TStream;
      function GetUncompressedSize(FileName: widestring): integer;
      function CreateFile(filename: widestring; outputstream: TStream): TStream;
      function Exists(filename: widestring): boolean;

      property Count: integer read GetCount;
      property Entries[i: integer]: TZipEntry read GetEntry; default;
      property EntriesByName[name: widestring]: TZipEntry read GetEntryByName;
      
   end;


   TEndOfCentralDirectoryRecord = class 
   private
      FSignature: array[0..3] of byte; {0x50, 0x4b, 0x05, 0x06} 
      FDiskNumber: word;  
      FStartDisk: word; 
      FThisDiskEntries: word;
      FTotalEntries: word;
      FSizeOfCD: longword;
      FOffsetOfStartCD: longword;
      FCommentLen: word;
      FComment: widestring;
    
      FMinSize: integer;{ = 4*3 + 5*2}
      FMaxSize: integer;{ = FMinSize + 0xFFFF}
      function  GetSize: integer;
      procedure ReadEOCD(Const buf; Offset: integer);
   protected
      FOffsetEOCD: longint;
      procedure Store(outputstream: TStream);
      function Parse(inputstream: TStream): longint;
   public
      constructor Create;
      procedure IncEntries;
      property OffsetOfStartCD: longword read FOffsetOfStartCD write FOffsetOfStartCD;
      property TotalEntries: word read FTotalEntries;
      property Size: integer read GetSize;
   end;   

   TCentralDirectory = class
   private
      FEOCD: TEndOfCentralDirectoryRecord;
      FZes: TZipEntries;
      procedure Store(outputstream: TStream);
   public
      constructor Create();
      destructor Destroy; override;
      function Parse(inputstream: TStream): integer;
      function CreateFile(filename: widestring; date: TDateTime; outputstream: TStream): TStream;
      procedure CreateFolder(foldername: widestring; date: TDateTime; outputstream: TStream);
      property Entries: TZipEntries read FZes;
   end;

  TArchiveMode = (ArchiveModeNone, ArchiveModeOpen, ArchiveModeCreate);

   TZipArchive = class
   private
      FInputStream: TStream;
      FOutputStream: TStream;
      Fcd: TCentralDirectory;
      FMode: TArchiveMode;
      FFreeOnDestroy: boolean;
      function GetZipEntries: TZipEntries;
      procedure Close;
  public
      constructor Create();
      destructor Destroy; override;
      procedure CreateArchive(filename: widestring); overload;
      procedure CreateArchive(stream: TStream); overload;
      procedure OpenArchive(filename: widestring); overload;
      procedure OpenArchive(stream: TStream); overload;
      function Exists(filename: widestring): boolean;
      function OpenFile(filename: widestring): TStream;
      function CreateFile(filename: widestring): TStream;
      procedure CreateFolder(foldername: widestring);
      property ZipEntries: TZipEntries read GetZipEntries;
      
  end;


  TZipSubStream = class(TStream) 
  private
     FBaseStream: TStream;
     FOffset: longint;
     FPosition: int64;
     FSize: int64;
  public
     Constructor Create(stream: TStream; Offset: int64; Size: int64);
     destructor Destroy; override;
     {$ifdef D45}
     function Seek(Offset: Longint; Origin: Word): Longint; override;
     {$else}
     function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
     {$endif}
     function  Read(Var buffer; count:longint):longint;override;
     function  Write(const buffer; count:longint):longint;override;
  end;

  function FileNameToZipFileName(filename: widestring): widestring;
  function SetUint16(var buffer; offset: integer; value: word): integer;
  function SetUint32(var buffer; offset: integer; value: longword): integer;
  function SetAnsiString(var buffer; offset: integer; value: AnsiString): integer;
  function GetAnsiString(const buffer; offset: integer; count: integer): AnsiString;
  function GetUint16(const buffer; offset: integer): word;
  function GetUint32(const buffer; offset: integer): longword;
  function LastIndexOf(value, searchvalue: widestring): integer;


implementation
uses sysutils, 
     zlib_adler32, 
     zlib_zlibstream, 
     zlib_deftype, 
     wstream;

type

  {$ifdef D45}
  PLongWord = ^LongWord;   
  PWord = ^Word;   
  {$endif} 

  TZipOutputSubStream = class(TStream)
  private
      FBaseStream: TStream;
      FOffset: longint;
      FPosition: longint;
      FSize: longint;
      FCrc32: longword;
  public
     constructor Create(outputstream: TStream);
     destructor Destroy; override;
     {$ifdef D45}
     function Seek(Offset: Longint; Origin: Word): Longint; override;
     {$else}
     function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
     {$endif}
     function  Read(Var buffer; count:longint):longint;override;
     function  Write(const buffer; count:longint):longint;override;
     property Size: longint read FSize;
  end;

  TZipOutputStream = class(TStream)
  private
     FBaseStream: TStream;
     FSubStream: TZipOutputSubStream;
     FPosition: longint;
     FStartOffset: longint;
     FCrc32: longword;
     FZipEntry: TZipEntry;
     FZLibStream: TStream;
  public
     Constructor Create(stream: TStream; entry: TZipEntry);
     Destructor Destroy; override;
     {$ifdef D45}
     function Seek(Offset: Longint; Origin: Word): Longint; override;
     {$else}
     function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
     {$endif}
     function  Read(Var buffer; count:longint):longint;override;
     function  Write(const buffer; count:longint):longint;override;
  end;


{TZipArchive}

constructor TZipArchive.Create();
begin
  inherited Create();
  FFreeOnDestroy := false;
  FMode := ArchiveModeNone;
end;
 

destructor TZipArchive.Destroy;
begin
  Close;
  Fcd.Free;
  if FFreeOnDestroy then begin
     FOutputStream.Free;
     FInputStream.Free;
  end;

  inherited Destroy;
end;



procedure TZipArchive.CreateArchive(filename: widestring);
begin
   FOutputStream := TWFileStream.Create(filename, fmCreate);  
   FFreeOnDestroy := true;
   FInputStream := nil;
   Fcd := TCentralDirectory.Create();
   FMode := ArchiveModeCreate;
end; 

procedure TZipArchive.OpenArchive(filename: widestring);
var ret: integer;
begin
   FOutputStream := nil;
   FInputstream := TWFileStream.Create(filename, fmOpenRead);  
   FFreeOnDestroy := true;
   Fcd := TCentralDirectory.Create(); 
   ret := Fcd.Parse(FInputStream);
   Fmode :=  ArchiveModeOpen;
   if (ret <> 1) then raise Exception.Create('Can''t open zip archive'); 
end;

procedure TZipArchive.CreateArchive(stream: TStream);
begin
   FOutputStream := stream;  
   FFreeOnDestroy := false;
   FInputStream := nil;
   Fcd := TCentralDirectory.Create();
   FMode := ArchiveModeCreate;
end; 

procedure TZipArchive.OpenArchive(stream: TStream);
var ret: integer;
begin
   FOutputStream := nil;
   FInputstream := stream;  
   FFreeOnDestroy := false;
   Fcd := TCentralDirectory.Create(); 
   ret := Fcd.Parse(FInputStream);
   Fmode :=  ArchiveModeOpen;
   if (ret <> 1) then raise Exception.Create('Can''t open zip archive'); 
end;


function TZipArchive.GetZipEntries: TZipEntries;
begin
  Result := Fcd.Entries;
end;

function TZipArchive.Exists(filename: widestring): boolean;
begin
  {!!!!!!!! todo}
  Result := false;
end;

function TZipArchive.OpenFile(filename: widestring): TStream;
begin
  Result := Fcd.Entries.OpenFile(filename, FInputStream);
end;

function TZipArchive.CreateFile(filename: widestring): TStream;
begin
  if FMode = ArchiveModeCreate then begin
     Result := Fcd.CreateFile(filename, Now, FOutputStream);
  end else begin 
     raise Exception.Create('Invalid operation!');   
  end; 
end;

procedure TZipArchive.CreateFolder(foldername: widestring);
begin
  if FMode = ArchiveModeCreate then begin
     Fcd.CreateFolder(foldername, Now, FOutputStream);
  end else begin 
     raise Exception.Create('Invalid operation!');   
  end; 
end;

procedure TZipArchive.Close;
begin
  if FMode = ArchiveModeCreate then begin
     Fcd.Store(FOutputStream)
  end; 
end;

{TCentralDirectory}

constructor TCentralDirectory.Create;
begin
   inherited Create;
   FEOCD := TEndOfCentralDirectoryRecord.Create;
   FZes := TZipEntries.Create; 
end;

destructor TCentralDirectory.Destroy;
begin
   FEOCD.Free;
   FZes.Free;
   inherited Destroy;
end;


function TCentralDirectory.Parse(inputstream: TStream): integer;
var cnt, i: integer;
    lcdfile: TCentralDirectoryFile;
    res: integer;
begin
  Result := 1;
  if (FEOCD.Parse(inputstream) < 0) then Result := -1;

  if Result = 1 then begin
     inputstream.Position := FEOCD.OffsetOfStartCD;
     cnt := FEOCD.TotalEntries;
     for i := 0 to cnt - 1 do begin
        lcdfile := TCentralDirectoryFile.Create();
        res := lcdfile.Parse(inputstream); 
        if (res <> 1) then begin 
            lcdfile.Free;
            Result := -2;
            break;
        end;
        FZes.Add(lcdfile);
     end;
  end;

  if Result = 1 then begin
     Result := FZes.ParseLocalHeaders(inputstream);
  end;

end;

function TCentralDirectory.CreateFile(filename: widestring; date: TDateTime; outputstream: TStream): TStream;
var fname: widestring;
    pos: integer;
    foldername: widestring;
    filenm: widestring;
    entry: TZipEntry;
    
begin
   if trim(filename) = '' then begin
      raise Exception.Create('Invalid file name');  
   end;

   fname := FileNameToZipFileName(filename);
   pos := LastIndexOf(fname, '/');
   if (pos > 0) then begin
       foldername := Copy(fname, 1, pos);
       CreateFolder(foldername, date, outputstream);
       filenm := trim(Copy(fname, pos + 1, Length(fname) - pos));
       if (filenm = '') then begin
          raise Exception.Create('Invalid file name');  
       end;
   end;

   if (Entries.Exists(fname)) then begin
       raise Exception.Create('file already exist');  
   end;
   entry := TZipEntry.Create();
   Result := entry.CreateFile(fname, date, outputstream);
   Entries.Add(entry);
   FEOCD.IncEntries();
end;

procedure TCentralDirectory.CreateFolder(foldername: widestring; date: TDateTime; outputstream: TStream);
var zipname: widestring;
    curname: widestring;
    i, cnt: integer;
    s: integer;
    entry: TZipEntry;
begin
   zipname := FileNameToZipFileName(foldername);
   cnt := Length(zipname);
   s := -1;
   for i := 1 to cnt do begin
       if (zipname[i] = '/') or (i = cnt) then begin
          if s >= 1 then begin
             curname := Copy(zipname, s, i);
             if not(zipname[i] = '/') then curname := curname + '/';
             if not(Entries.Exists(curname)) then begin
                entry := TZipEntry.Create();
                entry.CreateFolder(curname, date, outputstream);
                Entries.Add(entry);
                FEOCD.IncEntries();  
             end; 
          end; 
       end else if s = -1 then begin
          s := i; 
       end;
   end;
end;


procedure TCentralDirectory.Store(outputstream: TStream);
var i, cnt: integer;
begin
  FEOCD.OffsetOfStartCD := outputstream.Position;
  //store central directory
  cnt := Entries.Count;
  for i := 0 to cnt - 1 do begin
      Entries[i].StoreCentralDirectoryRecord(outputstream);
  end;
  //store end of central directory record
  FEOCD.Store(outputstream);
end;

{TZipEntries}
constructor TZipEntries.Create;
begin 
   inherited Create;
   FNameIndex := THashInteger.Create;
   FIndexItem := TObjectArray.Create(true);
end;

destructor TZipEntries.Destroy;
begin
   FNameIndex.Free;
   FIndexItem.Free;
   inherited Destroy;
end;
  
function TZipEntries.GetCount: integer;
begin
  Result := FIndexItem.Count;
end;

function TZipEntries.GetEntry(i: integer): TZipEntry;
begin
  Result := TZipEntry(FIndexItem[i]);
end;

function TZipEntries.Add(item: TCentralDirectoryFile): integer;
var ze: TZipEntry;
    path: widestring;
    ind: integer;
begin
  ze := TZipEntry.Create(item);
  path := lowercase(ze.ZipFileName);
  ind := FIndexItem.Count;
  FIndexItem[ind] := ze; 
  FNameIndex[path] := ind;  
  Result := ind;
end;

function TZipEntries.Add(item: TZipEntry): integer;
var path: widestring;
    ind: integer;
begin
  path := lowercase(item.ZipFileName);
  ind := FIndexItem.Count;
  FIndexItem[ind] := item; 
  FNameIndex[path] := ind;  
  Result := ind;
end;

function TZipEntries.GetEntryByName(name: widestring): TZipEntry;
var zipname: widestring;
begin
  zipname := lowercase(FileNameToZipFileName(name));
  if FNameIndex.KeyExists(zipname) then begin
     Result := TZipEntry(GetEntry(FNameIndex[zipname]));
  end else begin
//   raise;
     Result := nil;
  end;
end;

function TZipEntries.OpenFile(filename: widestring; inputstream: TStream): TStream;
var entry: TZipEntry;
begin
   entry := GetEntryByName(filename);
   if not Assigned(entry) then begin
      Result := nil;
   end else begin
      Result := entry.GetStream(inputstream);
   end;
end;

function TZipEntries.GetUncompressedSize(FileName: widestring): longint;
var entry: TZipEntry;
begin
   entry := GetEntryByName(filename);
   if not Assigned(entry) then begin
      Result := 0;
   end else begin
      Result := entry.FCdFile.UnCompressedSize;
   end;
end;


function TZipEntries.CreateFile(filename: widestring; outputstream: TStream): TStream;
begin
   //!!!!!! todo
   Result := nil;
end;

function TZipEntries.Exists(filename: widestring): boolean;
var entry: TZipEntry;
begin
  entry := GetEntryByName(filename); 
  Result := Assigned(entry);
end;

function TZipEntries.ParseLocalHeaders(inputstream: TStream): integer;
var i, cnt: integer;
begin
  Result := 1;
  cnt := self.Count;
  for i := 0 to cnt - 1 do begin
      Result := self[i].ParseLocalHeader(inputstream);
      if Result <> 1 then break;
  end;
end;


{TZipEntry}
constructor TZipEntry.Create(cdfile: TCentralDirectoryFile);
begin
   inherited Create;
   FCdFile := cdfile;
end;

destructor TZipEntry.Destroy; 
begin
  FCdFile.Free;
  FLfile.Free;
  inherited Destroy;
end;

constructor TZipEntry.Create;
begin
   inherited Create;
end;

function TZipEntry.GetFileName: widestring;
begin
  Result := FCdFile.FileName;
end;

function TZipEntry.GetZipFileName: widestring;
begin
  Result := FileNameToZipFileName(FCdfile.FileName);
end;

function TZipEntry.GetIsFolder: boolean;
begin
  Result := FCdFile.IsFolder;
end;

function TZipEntry.GetInternalStream(inputstream: TStream): TStream;
begin
  Result := TZipSubStream.Create(inputstream, FLFile.DataOffset, FLFile.CompressedSize);
end;

function TZipEntry.GetCompressionMethod: TCompressionMethod;
begin
  Result := FCdFile.CompressionMethod;
end;

function TZipEntry.GetStream(inputstream: TStream): TStream;
var strm: TZLibStream;
    basestream: TStream;
begin
  if (IsFolder) then raise Exception.Create('Can''t get the stream for folder'); 
  if (CompressionMethod = cmStored) then begin
      Result := GetInternalStream(inputstream);
  end else if (CompressionMethod = cmDeflated) then begin
      basestream := GetInternalStream(inputstream);
      strm := nil;
      if Assigned(basestream) then begin
          strm := TZLibStream.Create(basestream, CompressionMode_Decompress, -15); 
          if Assigned(strm) then begin
             //strm.SetLength(FCdFile.UnCompressedSize);
             strm.FreeBaseStreamOnDestroy := true;
          end else begin
             basestream.Free;
          end;
      end;
      Result := strm;
  end else begin 
      raise Exception.Create('Unsupported compression method');
  end;
end;

function TZipEntry.ParseLocalHeader(inputstream: TStream): integer;
begin
  FLfile := TLocalFile.Create();
  Result := FLfile.Parse(inputstream, FCdFile.LocalFileHeaderOffset);
end;

procedure TZipEntry.CreateFolder(foldername: widestring; date: TDateTime; outputstream: TStream);
var loffset: longword;
begin
  loffset := outputstream.Position; 
  FLFile := TLocalFile.Create(foldername, false, date);
  FLFile.Store(outputstream);
  FCdfile := TCentralDirectoryFile.Create();
  FCdfile.CreateFolder(foldername, date, loffset);
end;

function TZipEntry.CreateFile(filename: widestring; date: TDateTime; outputstream: TStream): TStream;
var loffset: longword;
begin
  loffset := outputstream.Position; 
  FLFile := TLocalFile.Create(filename, true, date);
  FLFile.Store(outputstream);
  FCdfile := TCentralDirectoryFile.Create();
  FCdfile.CreateFile(filename, date, loffset);
  Result := GetOutputStream(outputstream);
end;

function TZipEntry.GetOutputStream(outputstream: TStream): TStream;
begin
  Result := TZipOutputStream.Create(outputstream, self);
end;

procedure TZipEntry.StoreCentralDirectoryRecord(outputstream: TStream); 
begin
  FCdfile.Store(outputstream); 
end;

procedure TZipEntry.UpdateFileProperties(crc32: longword; compressedsize: longword; uncompressedsize: longword; outputstream: TStream);
var curpos: longint;
begin
   curpos := outputstream.Position;
   FLfile.Update(outputstream, crc32, compressedsize, uncompressedsize);
   FCdfile.Update(crc32, compressedsize, uncompressedsize);
   outputstream.Position := curpos; 
end;


constructor TLocalFile.Create;
begin
   inherited Create;
   FSignature[0] := $50;
   FSignature[1] := $4B;
   FSignature[2] := $03;
   FSignature[3] := $04;
   FMinSize := 4*5 + 2*5;
end;

constructor TLocalFile.Create(AFileName: widestring; isFile: boolean; date: TDateTime);
begin
   inherited Create;
   FSignature[0] := $50;
   FSignature[1] := $4B;
   FSignature[2] := $03;
   FSignature[3] := $04;
   FMinSize := 4*5 + 2*5;
  
   FVersionNeededToExtract := 20;
   FGeneralPurposeBitFlags := 0;

   if isFile then begin
      FCompressionMethod   := 8;
   end else begin
      FCompressionMethod   := 0;
   end;
   FLastModFileTimeDate    := DateTimeToFileDate(date);
   FCrc32                  := 0;
   FCompressedSize         := 0;
   FUncompressedSize       := 0;
   FFileNameLength         := word(Length(AFileName));
   FExtraFieldLength       := 0;
   FFileName               := AFileName;
   FExtraField             := '';
end;

function TLocalFile.GetSize: integer;
begin
  Result := FMinSize + FFileNameLength + FExtraFieldLength;
end;

procedure TLocalFile.Store(outputstream: TStream);
var buff: array of byte;
    offs: integer;
    sz: integer;
begin
   sz := Size;
   SetLength(buff, sz);
   offs := 0;
   offs := offs + SetUint32(buff[0], offs, PLongWord(@(FSignature[0]))^);
   offs := offs + SetUint16(buff[0], offs, FVersionNeededToExtract);   
   offs := offs + SetUint16(buff[0], offs, FGeneralPurposeBitFlags);   
   offs := offs + SetUint16(buff[0], offs, FCompressionMethod);
   offs := offs + SetUint32(buff[0], offs, FLastModFileTimeDate);      
   offs := offs + SetUint32(buff[0], offs, FCrc32);                    
   offs := offs + SetUint32(buff[0], offs, FCompressedSize);           
   offs := offs + SetUint32(buff[0], offs, FUncompressedSize);         
   offs := offs + SetUint16(buff[0], offs, FFileNameLength);           
   offs := offs + SetUint16(buff[0], offs, FExtraFieldLength);           
   offs := offs + SetAnsiString(buff[0], offs, AnsiString(FFileName));           

   outputstream.Write(buff[0], offs);
   FOffset := outputstream.Position;
end;

procedure TLocalFile.Update(outputstream: TStream; crc32: longword; compressedsize: longword; auncompressedsize: longword);
var buff: array of byte;
    offs: integer;
begin
   outputstream.Position := (FOffset - Size + 14);
   SetLength(buff, 12);
   offs := 0;

   self.FCrc32 := crc32;
   self.FCompressedSize := CompressedSize;
   self.FUncompressedSize := AUncompressedSize;

   offs := offs + setuint32(buff[0], offs, Fcrc32);                    
   offs := offs + setuint32(buff[0], offs, Fcompressedsize);           
   setuint32(buff[0], offs, Funcompressedsize);
   outputstream.Write(buff[0], 12);
end;

function TLocalFile.Parse(inputstream: TStream; offset: longint): integer;
var buf: array of byte;
    i: integer;
begin
   Result := 1;
   SetLength(buf, FMinSize);
   inputstream.Position := offset;
   inputstream.Read(buf[0], fminsize);
   if ((buf[0] <> fsignature[0]) or
       (buf[1] <> fsignature[1]) or
       (buf[2] <> fsignature[2]) or
       (buf[3] <> fsignature[3])) then begin
       Result := -1;
   end;
   if Result = 1 then begin
     i := 4;

     Fversionneededtoextract := getuint16(buf[0], i); i := i + 2;
     Fgeneralpurposebitflags := getuint16(buf[0], i); i := i + 2;
     Fcompressionmethod      := getuint16(buf[0], i); i := i + 2;
     Flastmodfiletimedate    := getuint32(buf[0], i); i := i + 4;
     Fcrc32                  := getuint32(buf[0], i); i := i + 4;
     Fcompressedsize         := getuint32(buf[0], i); i := i + 4;
     Funcompressedsize       := getuint32(buf[0], i); i := i + 4;
     Ffilenamelength         := getuint16(buf[0], i); i := i + 2;
     Fextrafieldlength       := getuint16(buf[0], i); 

     SetLength(buf, Ffilenamelength);
     inputstream.Read(buf[0], Ffilenamelength);

     Ffilename := widestring(getansistring(buf[0], 0, Ffilenamelength));
     if (FExtraFieldLength > 0) then begin
        inputstream.Seek(FExtraFieldLength, {$ifdef D45}soFromCurrent{$else}soCurrent{$endif}); 
     end; 
     FOffset := Offset + Fminsize + Ffilenamelength + Fextrafieldlength; 
   end;
end; 

{TCentralDirectoryFile}
constructor TCentralDirectoryFile.Create;
begin
   inherited Create;
   FSignature[0] := $50;
   FSignature[1] := $4B;
   FSignature[2] := $01;
   FSignature[3] := $02;

   FMinSize := 4*7 + 2*9;
   FfaDirectory := $00000010;
   FfaArchive   := $00000020;
end;

function TCentralDirectoryFile.GetCompressionMethod: TCompressionMethod;
begin
   Result := TCompressionMethod(FCompressionMethod);
end;


function TCentralDirectoryFile.GetIsFolder: boolean;
begin
  Result := (FExternalFileAttributes and FfaDirectory) > 0; 
end;

procedure TCentralDirectoryFile.Update(aCrc32, acompressedsize, auncompressedsize: longword);
begin
  self.FCrc32 := acrc32;
  self.FCompressedSize := acompressedsize;
  self.FUncompressedSize := auncompressedsize;
end;

procedure TCentralDirectoryFile.CreateFolder(foldername: widestring;
                                             date: TDateTime;
                                             offset: longword);
begin
   FVersionMadeBy               := 20;
   FVersionNeededToExtract      := 20;
   FGeneralPurposeBitFlags      := 0;
   FCompressionMethod           := 0;
   FLastModFileTimeDate         := DateTimeToFileDate(date);
   FCrc32                       := 0;
   FCompressedSize              := 0;
   FUncompressedSize            := 0;
   FFileNameLength              := word(Length(foldername));
   FExtraFieldLength            := 0;
   FFileCommentLength           := 0;
   FDiscNumberStart             := 0;
   FInternalFileAttributes      := 0;
   FExternalFileAttributes      := FfaDirectory;
   FRelativeOffsetOfLocalHeader := offset;
   FFileName                    := foldername;
   FExtraField                  := '';
   FFileComment                 := '';   
end;

procedure TCentralDirectoryFile.CreateFile(filename: widestring;
                                               date: TDateTime;
                                             offset: longword);
begin
   FVersionMadeBy               := 20;
   FVersionNeededToExtract      := 20;
   FGeneralPurposeBitFlags      := 0;
   FCompressionMethod           := word(cmDeflated);
   FLastModFileTimeDate         := DateTimeToFileDate(date);
   FCrc32                       := 0;
   FCompressedSize              := 0;
   FUncompressedSize            := 0;
   FFileNameLength              := word(Length(filename));
   FExtraFieldLength            := 0;
   FFileCommentLength           := 0;
   FDiscNumberStart             := 0;
   FInternalFileAttributes      := 0;
   FExternalFileAttributes      := FfaArchive;
   FRelativeOffsetOfLocalHeader := offset;
   FFileName                    := filename;
   FExtraField                  := '';
   FFileComment                 := '';   
end;

function TCentralDirectoryFile.GetSize: integer;
begin
  Result := fMinSize + FFileNameLength + FExtraFieldLength + FFileCommentLength;
end;


procedure TCentralDirectoryFile.Store(outputstream: TStream);
var buff: array of byte;
    offs: integer;
begin
     SetLength(buff, Size);
     offs := 0;
     
     offs := offs + SetUint32(buff[0], offs, PLongWord(@(FSignature[0]))^);
 
     offs := offs + setuint16(buff[0], offs, FVersionMadeBy);
     offs := offs + setuint16(buff[0], offs, FVersionNeededToExtract);
     offs := offs + setuint16(buff[0], offs, FGeneralPurposeBitFlags);
     offs := offs + setuint16(buff[0], offs, FCompressionMethod);
     offs := offs + setuint32(buff[0], offs, FLastModFileTimeDate);
     offs := offs + setuint32(buff[0], offs, FCrc32);
     offs := offs + setuint32(buff[0], offs, FCompressedSize);
     offs := offs + setuint32(buff[0], offs, FUncompressedSize);
     offs := offs + setuint16(buff[0], offs, FFileNameLength);
     offs := offs + setuint16(buff[0], offs, FExtraFieldLength);
     offs := offs + setuint16(buff[0], offs, FFilecommentlength);
     offs := offs + setuint16(buff[0], offs, FDiscNumberStart);
     offs := offs + setuint16(buff[0], offs, FInternalFileAttributes);
     offs := offs + setuint32(buff[0], offs, FExternalFileAttributes);
     offs := offs + setuint32(buff[0], offs, FRelativeOffsetOfLocalHeader);
     offs := offs + setansistring(buff[0], offs, AnsiString(FFileName));
     outputstream.Write(buff[0], offs);
end;

function TCentralDirectoryFile.Parse(inputstream: TStream): integer;
var buf: array of byte;
    i: integer;
begin
    Result := 1;
    SetLength(buf, FMinSize);
    inputstream.Read(buf[0], FMinSize);

     if ((buf[0] <> FSignature[0]) or
         (buf[1] <> FSignature[1]) or
         (buf[2] <> FSignature[2]) or
         (buf[3] <> FSignature[3])) then begin
         Result := -1;
     end;

     if Result = 1 then begin
        i := 4;
        FVersionMadeBy          := getuint16(buf[0], i); i := i + 2;
        FVersionNeededToExtract := getuint16(buf[0], i); i := i + 2;
        FGeneralPurposeBitFlags := getuint16(buf[0], i); i := i + 2;
        FCompressionMethod      := getuint16(buf[0], i); i := i + 2;
        FLastModFileTimeDate    := getuint32(buf[0], i); i := i + 4;
        FCrc32                  := getuint32(buf[0], i); i := i + 4;
        FCompressedSize         := getuint32(buf[0], i); i := i + 4;
        FUncompressedSize       := getuint32(buf[0], i); i := i + 4;
        FFileNameLength         := getuint16(buf[0], i); i := i + 2;
        FExtraFieldLength       := getuint16(buf[0], i); i := i + 2;
        FFileCommentLength      := getuint16(buf[0], i); i := i + 2;
        FDiscNumberStart        := getuint16(buf[0], i); i := i + 2;
        FInternalFileAttributes := getuint16(buf[0], i); i := i + 2;
        FExternalFileAttributes := getuint32(buf[0], i); i := i + 4;
        FRelativeOffsetOfLocalHeader := getuint32(buf[0], i);

        SetLength(buf, FFileNameLength);
        inputstream.Read(buf[0], FFileNameLength);
        FFileName := widestring(getansistring(buf[0], 0, FFileNameLength));
        if ((FExtraFieldLength > 0) or (FFileCommentLength > 0)) then begin 
           inputstream.Seek(FExtraFieldLength + FFileCommentLength, {$ifdef D45}soFromCurrent{$else}soCurrent{$endif}); 
        end;
     end;
end;


{TZipSubStream}
constructor TZipSubStream.Create(stream: TStream; Offset: int64; Size: int64);
begin
   inherited Create;
   FBaseStream := stream;
   FOffset := Offset;
   FPosition := 0;
   FSize := Size;
end;

destructor TZipSubStream.Destroy;
begin
   inherited Destroy;
end;

{$ifdef D45}
function TZipSubStream.Seek(Offset: Longint; Origin: word): Longint;
{$else}
function TZipSubStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$endif}
var pos: int64;
begin
   pos := FPosition;
{$ifdef D45}
   case origin of 
     soFromBeginning: pos := offset; 
     soFromCurrent:   pos := FPosition + offset; 
     soFromEnd:       pos := FSize + offset;
   end;
{$else}
   case origin of 
     soBeginning:    pos := offset; 
     soCurrent:      pos := FPosition + offset; 
     soEnd:          pos := FSize + offset;
   end;
{$endif}

   if pos < 0 then raise Exception.Create('negative position');
   if pos > FSize then raise Exception.Create('invalid position');

   FPosition := pos;
   Result := FPosition; 
end;

function  TZipSubStream.Read(Var buffer; count:longint):longint;
var rest: int64;
    rc: longint;
begin
  rest := FSize - FPosition;
  if (count > rest) then count := rest;
  FBaseStream.Position := FOffset + FPosition;
  rc := FBaseStream.Read(buffer, count);  
  FPosition := FPosition + rc;
  Result := rc; 
end;

function  TZipSubStream.Write(const buffer; count:longint):longint;
begin
  raise Exception.Create('Unsupported feature');
end;


{TZipOutputStream}
Constructor TZipOutputStream.Create(stream: TStream; entry: TZipEntry);
begin
  inherited Create;
  FBaseStream := stream; 
  FZipEntry := entry;
  FStartOffset := stream.Position;
  FSubStream := TZipOutputSubStream.Create(stream);
  FPosition := 0;
  FCrc32 := 0;
  FZLibStream := TZLibStream.Create(FSubStream, CompressionMode_Compress, -15);
end;

destructor TZipOutputStream.Destroy;
var compressedsize: longint;
    uncompressedsize: longint;
begin
  FZLibStream.Free; 
  compressedsize := FSubStream.Size;
  uncompressedsize := FPosition;
  FSubStream.Free;
  FZipEntry.UpdateFileProperties(FCrc32, compressedsize, uncompressedsize, FBaseStream);
  inherited Destroy;
end;

{$ifdef D45}
function TZipOutputStream.Seek(Offset: Longint; Origin: word): Longint;
{$else}
function TZipOutputStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$endif}
var pos: int64;
begin
   pos := FPosition;
{$ifdef D45}
   case origin of 
     soFromBeginning: pos := offset; 
     soFromCurrent:   pos := FPosition + offset; 
     soFromEnd:       pos := FPosition + offset;
   end;
{$else}
   case origin of 
     soBeginning: pos := offset; 
     soCurrent:   pos := FPosition + offset; 
     soEnd:       pos := FPosition + offset;
   end;
{$endif}
   if pos <> FPosition then raise Exception.Create('Unsupported feature');
   Result := FPosition; 
end;

function TZipOutputStream.Read(Var buffer; count:longint):longint;
begin
  raise Exception.Create('Read: Unsupported feature');
end;

function TZipOutputStream.Write(const buffer; count:longint):longint;
begin
  FZLibStream.Write(buffer, count);
  FPosition := FPosition + count;
  FCrc32 := Adler32_crc32(FCrc32, buffer, count); 
  Result := count;
end;


{TEndOfCentralDirectoryRecord}
constructor TEndOfCentralDirectoryRecord.Create;
begin
  inherited Create;
  FSignature[0] := $50;
  FSignature[1] := $4B;
  FSignature[2] := $05;
  FSignature[3] := $06;

  FMinSize := 4*3 + 5*2;
  FMaxSize := FMinSize + $FFFF;

  FOffsetEOCD := -1;
end;

procedure TEndOfCentralDirectoryRecord.IncEntries;
begin
  Inc(FTotalEntries);
end;


function TEndOfCentralDirectoryRecord.GetSize: integer;
begin
  Result := FMinSize + FCommentLen;
end;

procedure TEndOfCentralDirectoryRecord.Store(outputstream: TStream);
var buff: array of byte;
    offs: integer;
    sz: integer;
begin
   FOffsetEOCD := outputstream.Position;
   FSizeOfCD := longword(FOffsetEOCD) - longword(FOffsetOfStartCD);
   sz := Size;
   SetLength(buff, sz);
   offs := 0;
   offs := offs + SetUint32(buff[0], offs, PLongWord(@(FSignature[0]))^);
   offs := offs + setuint16(buff[0], offs, FDiskNumber);
   offs := offs + setuint16(buff[0], offs, FStartDisk);
   offs := offs + setuint16(buff[0], offs, {FThisDiskEntries}FTotalEntries);
   offs := offs + setuint16(buff[0], offs, FTotalEntries);
   offs := offs + setuint32(buff[0], offs, FSizeOfCD);
   offs := offs + setuint32(buff[0], offs, FOffsetOfStartCD);
   offs := offs + setuint16(buff[0], offs, FCommentLen);
   {offs := offs + } setansistring(buff[0], offs, AnsiString(FComment));
   outputstream.Write(buff[0], sz);
end;


procedure TEndOfCentralDirectoryRecord.ReadEOCD(Const buf; Offset: integer);
var i: integer;
begin
     i := Offset + 4; 

     FDiskNumber          := getuint16(buf, i); i := i + 2;
     FStartDisk           := getuint16(buf, i); i := i + 2;
     FThisDiskEntries     := getuint16(buf, i); i := i + 2;
     FTotalEntries        := getuint16(buf, i); i := i + 2;
     FSizeOfCD            := getuint32(buf, i); i := i + 4;
     FOffsetOfStartCD     := getuint32(buf, i); i := i + 4;
     FCommentLen          := getuint16(buf, i); //i := i + 2;

     //Console.WriteLine("dn={0}, sd={1}, de={2}, te={3} sz={4:x5} off={5:x8}",
     //                  disknumber, startdisk, thisdiskentries,
     //                  totalentries, SizeOfCD, offsetOfStartCD,
     //                  commentlen);
end; 


function TEndOfCentralDirectoryRecord.Parse(inputstream: TStream): longint;
var lsize: longint;
    ok: boolean;
    startscan: longint;
    endscan: longint;
    scansize: integer;
    bufsize: integer;
    buf: array of byte;
    i, j: integer;
    rc: integer;
    pos: longint; 
begin
    ok := true;
    lsize := inputstream.Size;
    FOffsetEOCD := -1;
    if (lsize <= FMinSize) then ok := false;
    if ok then begin   
       startscan := lsize - 1;
       endscan := lsize - FMaxSize;
       if (endscan < 0) then endscan := 0;
       scansize := (startscan - endscan + 1);
       bufsize := 256;
       if (bufsize > scansize) then bufsize := scansize;
       SetLength(buf, bufsize); 
       i := 0;
       while i < scansize do begin
           if bufsize > (scansize - i) then begin
              rc := scansize - i;
           end else begin
              rc := bufsize;
           end;
           pos := startscan - i - rc + 1;
           inputstream.Position := pos;
           inputstream.Read(buf[0], rc);
           for j := rc - 1 downto 3 do begin
               if (buf[j] =  FSignature[3]) then begin
                  if ((buf[j - 1] = FSignature[3 - 1]) and
                      (buf[j - 2] = FSignature[3 - 2]) and 
                      (buf[j - 3] = FSignature[3 - 3])) then begin
                         //found
                         FOffsetEOCD := pos + j - 3;

                         if (pos + rc) < (FOffsetEOCD + FMinSize)  then begin
                            ReadEOCD(buf[0], j - 3); 
                         end else begin
                            inputstream.Position := FOffsetEOCD;
                            inputstream.Read(buf[0], FMinSize); 
                            ReadEOCD(buf[0], 0); 
                         end;

                         Result := FOffsetEOCD;
                         exit;
                    end;
                end;
            end; 
            if rc <= 3 then break;
            i := i + (rc - 3); 
       end;
    end;  
    Result := -1;  
end;

{TZipOutputSubStream}
constructor TZipOutputSubStream.Create(outputstream: TStream);
begin
   inherited Create;
   FBaseStream := outputstream;
   FOffset := FBaseStream.Position;
   FPosition := 0;
   FSize := 0;
   FCrc32 := 0;
end;

destructor TZipOutputSubStream.Destroy;
begin
  inherited Destroy;
end;

{$ifdef D45}
function TZipOutputSubStream.Seek(Offset: Longint; Origin: word): Longint;
{$else}
function TZipOutputSubStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$endif}
var pos: int64;
begin
   pos := FPosition;
{$ifdef D45}
   case origin of 
     soFromBeginning: pos := offset; 
     soFromCurrent:   pos := FPosition + offset; 
     soFromEnd:       pos := FPosition + offset;
   end;
{$else}
   case origin of 
     soBeginning: pos := offset; 
     soCurrent:   pos := FPosition + offset; 
     soEnd:       pos := FPosition + offset;
   end;
{$endif}
   if pos <> FPosition then raise Exception.Create('Unsupported feature');
   Result := FPosition; 
end;

function TZipOutputSubStream.Read(Var buffer; count:longint):longint;
begin
  raise Exception.Create('Read: Unsupported feature');
end;

function TZipOutputSubStream.Write(const buffer; count:longint):longint;
begin
  FBaseStream.Write(buffer, count);
  FPosition := FPosition + count;
  FSize := FSize + count; 
  FCrc32 := Adler32_crc32(FCrc32, buffer, count); 
  Result := count;
end;


function SetAnsiString(var buffer; offset: integer; value: AnsiString): integer;
Var BuffPos: PAnsiChar;
    StrLen: integer;
begin

  StrLen := Length(value);
  if StrLen > 0 then begin
    BuffPos := PAnsiChar(@buffer) + offset;
    Move(PAnsiChar(value)^, BuffPos^, StrLen);
  end;

  Result := StrLen;
end;

function SetUint16(var buffer; offset: integer; value: word): integer;
begin
   PWord(PAnsiChar(@buffer) + offset)^ := value;
   Result := 2;
end;

function SetUint32(var buffer; offset: integer; value: longword): integer;
begin
   PLongWord(PAnsiChar(@buffer) + offset)^ := value;
   Result := 4;
end;

function GetUint16(const buffer; offset: integer): word;
begin
   Result := PWord(PAnsiChar(@buffer) + offset)^;
end;

function GetUint32(const buffer; offset: integer): longword;
begin
   Result := PLongWord(PAnsiChar(@buffer) + offset)^;
end;

function GetAnsiString(const buffer; offset: integer; count: integer): AnsiString;
begin
  System.SetString(Result, PAnsiChar(@buffer) + offset, count);
end;

function WideStringReplace(src: widestring; fv, rv: widestring): widestring;
begin
  //!!!!!!!!!!!!!!!! todo: wide string support
  Result := StringReplace(src, fv, rv, [rfReplaceAll]);
end;

function FileNameToZipFileName(filename: widestring): widestring;
var p: integer;
begin
   Result := WideStringReplace(filename, '\\', '/'); 
   p := Pos(WideString(':/'), Result);
   if p > 1 then begin
      Result := Copy(Result, p + 2, Length(Result) - p - 1);   
   end;
   if Length(Result) > 0 then begin
      if Result[1] = '/' then begin
         Result := Copy(Result, 2, Length(Result) - 1);   
      end;
   end;
end;

function LastIndexOf(value, searchvalue: widestring): integer;
var vcnt, i: integer;
    scnt: integer;
    ecnt: integer;
begin
  vcnt := Length(value);
  scnt := Length(searchvalue);
  if scnt = 0 then begin
     Result := vcnt;
     exit;
  end;
  if vcnt < scnt then begin
     Result := -1;
     exit;
  end;

  i := vcnt;
  ecnt := 0;
  while i > 0 do begin
     if value[i] = searchvalue[scnt - ecnt] then begin
        inc(ecnt);
        if ecnt = scnt then begin
           Result := i;
           exit;  
        end;
        dec(i);
     end else begin
        i := i + ecnt - 1;
        ecnt := 0;
     end;
  end;

  Result := -1;

end;

end.
