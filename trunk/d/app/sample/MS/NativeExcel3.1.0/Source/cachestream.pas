//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         cachestream
//
//
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

unit cachestream;


interface
uses Classes;

{$I xlsdef.inc}

type

   TCacheStream = class (TStream)
   protected
      FStream: TStream;              // work stream
      FStreamPosition: int64;        // stream position
      FCachedStreamPosition: int64;  // current cached position 

      FCacheBuffer: array of byte; // cache buffer
      FCacheCapacity: longint;     // max limit size cache buffer
      FCacheStartPosition:int64;   // start position cache in stream
      FCachePosition: int64;       // position in cache
      FCacheSize:int64;            // size use cache
      FisCached:boolean;           // flag - use cache
      FisWriteCache: boolean;      // flag - write data in cache

      FFreeOnDestroy: boolean;  

      function getPosition:int64;
      function GetSize: int64; {$ifdef D7UP}override; {$endif}
      function ReadDirectly(var Buffer; Count: Longint): Longint;
      function ReadCached(var Buffer; Count: Longint): Longint;

      procedure CacheToStream;  

   public
      constructor Create(AStream: Tstream; ACacheCapacity: int64; FreeOnDestroy: boolean);
      destructor Destroy;override;
      {$ifdef D45}
      function Seek(Offset: Longint; Origin: Word): Longint; override;
      {$else}
      function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
      {$endif}
      function Read(var Buffer; Count: Longint): Longint; override;
      function Write(const Buffer; Count: Longint): Longint; override;

      property Position:int64 read getPosition;
      property Size:int64 read getSize;
   end;


   TNoStream = class (TStream)
   protected
      FStream: TStream;              // work stream
      FStreamPosition: int64;        // stream position
      FFreeOnDestroy: boolean;  

      function getPosition:int64;
      function GetSize: int64; {$ifdef D7UP}override; {$endif}
   public
      constructor Create(AStream: Tstream; ACacheCapacity: int64; FreeOnDestroy: boolean);
      destructor Destroy;override;
      {$ifdef D45}
      function Seek(Offset: Longint; Origin: Word): Longint; override;
      {$else}
      function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
      {$endif}
      function Read(var Buffer; Count: Longint): Longint; override;
      function Write(const Buffer; Count: Longint): Longint; override;
      property Position:int64 read getPosition;
      property Size:int64 read getSize;
   end;

implementation
uses sysutils;

constructor TCacheStream.Create(AStream: Tstream; ACacheCapacity: int64; FreeOnDestroy: boolean);
begin
  FFreeOnDestroy := FreeOnDestroy;
  FStream := AStream;
  //if Not(Assigned(AStream)) then writ eln('not assigned'); 
  FStreamPosition := AStream.Position;
  FCachedStreamPosition := FStreamPosition;

  //init cache
  FCacheCapacity := ACacheCapacity;
  SetLength(FCacheBuffer, FCacheCapacity);
  FCacheStartPosition := 0;
  FCachePosition := 0;
  FCacheSize := 0;
  FIsCached := false;
  FIsWriteCache := false;

end;

destructor TCacheStream.Destroy;
begin
  if FIsCached and FIsWriteCache then CacheToStream;
  setLength(FCacheBuffer, 0);
  if FFreeOnDestroy then FStream.Free;
end;

function TCacheStream.getPosition:int64;
begin
  Result := FCachedStreamPosition;
end;

function TCacheStream.GetSize:int64;
begin
  Result := FStream.Size;
  if FIsCached and FIsWriteCache then begin
     if Result < (FCacheStartPosition + FCacheSize) then begin
        Result := FCacheStartPosition + FCacheSize;
     end;
  end;
end;

function TCacheStream.ReadDirectly(var Buffer; Count: Longint): Longint;
Var readcount: longint;
begin
  if Count <= 0 then begin
      Result := 0;
  end else begin
     //data is not cached
     //read data directly from stream
     //synchronize StreamPosition and CachedStreamPositon
     if FStreamPosition <> FCachedStreamPosition then begin
        {$ifdef D45} 
        FStreamPosition := FStream.Seek(FCachedStreamPosition, soFromBeginning);
        {$else} 
        FStreamPosition := FStream.Seek(FCachedStreamPosition, soBeginning);
        {$endif} 

        if FCachedStreamPosition <> FStreamPosition then begin
           raise Exception.Create('Stream to cache synchronization failed'); 
        end;
     end;

     if Count < FCacheCapacity then begin
        //read to cache
        readcount := FStream.Read(PAnsiChar(@FCacheBuffer[0])^, FCacheCapacity);

        //set cache state
        if readcount > 0 then begin 
           FIsCached     := true;
           FIsWriteCache := false;
           FCacheStartPosition := FStreamPosition;
           FCacheSize  := readcount;  
           FStreamPosition := FStreamPosition + readcount;

           if readcount > Count then begin
              Result := Count;
           end else begin
              Result := readcount;
           end;

           if Result > 0 then begin
              //copy data from cache to buffer
              Move(PAnsiChar(@FCacheBuffer[0])^, Buffer, Result);
              FCachedStreamPosition := FCachedStreamPosition + Result;
           end;
           FCachePosition := Result;
        end else begin
           FIsCached     := false;
           Result := 0;
        end;
     end else begin
        //read to buffer
        readcount := FStream.Read(Buffer, Count);
        FStreamPosition := FStreamPosition + readcount;
        FCachedStreamPosition := FCachedStreamPosition  + readcount;
        FIsCached := false; 
        Result := readcount;
     end;
  end;      
end;


function TCacheStream.ReadCached(var Buffer; Count: Longint): Longint;
var countincache: longint;
begin
  countincache := 0;
  if FIsCached then begin
     if (FCachedStreamPosition >= FCacheStartPosition) and
        (FCachedStreamPosition <  (FCacheStartPosition + FCacheSize)) then begin
        countincache :=  FCacheSize - FCachePosition;
        if countincache < 0 then countincache := 0; 
        if countincache > Count then countincache := Count; 
     end; 
  end;

  if countincache > 0 then begin
     //copy data from cache to buffer
     Move((PAnsiChar(@FCacheBuffer[0]) + FCachePosition)^, Buffer, countincache);
     FCachedStreamPosition := FCachedStreamPosition + countincache;
     FCachePosition := FCachePosition + countincache;
  end;

  if countincache < Count then begin
     if (FIsCached and FIsWriteCache) then begin
        CacheToStream();
     end;
     Result := countincache + ReadDirectly((PAnsiChar(@Buffer) + countincache)^, Count - countincache); 
  end else begin
      Result := countincache;
  end;

end;

procedure TCacheStream.CacheToStream;
var writencount: longint;
begin
   if FisCached and FisWriteCache then begin
      if FCacheSize > 0 then begin

         //synchronize StreamPosition and CachedStreamPositon
         if FStreamPosition <> FCacheStartPosition then begin
            {$ifdef D45}
            FStreamPosition := FStream.Seek(FCacheStartPosition, soFromBeginning);
            {$else}
            FStreamPosition := FStream.Seek(FCacheStartPosition, soBeginning);
            {$endif}
            if FCacheStartPosition <> FStreamPosition then begin
               raise Exception.Create('Stream to cache synchronization failed'); 
            end;
         end;

//         StartTimer(6);

         writencount := FStream.Write(PAnsiChar(@FCacheBuffer[0])^, FCacheSize);
//         StopTimer(6);
         if writencount <> FCacheSize then begin
            raise Exception.Create('Can''t write cache into stream'); 
         end;
         FStreamPosition := FStreamPosition + writencount;
      end;
   end;

   FIsCached := false;
   FIsWriteCache := false;
   FCacheSize := 0; 
   FCachePosition := 0;
end;

function TCacheStream.Read(var Buffer; Count: Longint): Longint;
begin
  if Count <= 0 then begin
     Result := 0;
  end else begin
     if FIsCached then begin
        //try to read from cache 
        Result := ReadCached(Buffer, Count);
     end else begin
        //data is not cached
        //read data directly from stream
        Result := ReadDirectly(Buffer, Count);
     end;
  end;
end;

function TCacheStream.Write(const Buffer; Count: Longint): Longint;
var restcache: longint;
    offset: integer;
    b: PAnsiChar;
    wrcnt: longint;
begin
  if Count <= 0 then begin
     Result := 0;
  end else begin

     Result := 0;
     offset := 0;
     b := PAnsiChar(@buffer);
     while true do begin

     if FIsCached and FIsWriteCache then begin
        //write to cache
        restcache :=  FCacheCapacity - FCachePosition;
        if restcache < 0 then restcache := 0;
        if restcache > Count then restcache := Count;
        if restcache > 0 then begin
             Move((b + offset)^, PAnsiChar(PAnsiChar(@FCacheBuffer[0]) + FCachePosition)^,
                  restcache);
             FCachePosition := FCachePosition + restcache;
             if FCachePosition > FCacheSize then FCacheSize := FCachePosition;
             FCachedStreamPosition := FCachedStreamPosition + restcache;
        end; 

        if restcache < Count then begin
           CacheToStream;
           Result := Result + restcache;
           offset := offset + restcache;
           Count := Count - restcache;
           continue;
        end else begin
           Result := Result + restcache;
           break;
        end;

     end else begin
        if Count > FCacheCapacity then begin
           //write directly
           //synchronize StreamPosition and CachedStreamPositon
           if FStreamPosition <> FCachedStreamPosition then begin
              {$ifdef D45} 
              FStreamPosition := FStream.Seek(FCachedStreamPosition, soFromBeginning);
              {$else} 
              FStreamPosition := FStream.Seek(FCachedStreamPosition, soBeginning);
              {$endif} 

              if FCachedStreamPosition <> FStreamPosition then begin
                 raise Exception.Create('Stream to cache synchronization failed'); 
              end;
           end;
           wrcnt := FStream.Write((b + offset)^, Count);
           Result := Result + wrcnt;
           FCachedStreamPosition := FCachedStreamPosition + wrcnt;
           FStreamPosition := FStreamPosition + wrcnt;  
           break;
        end else begin
           //start cache and write to cache
           FCacheStartPosition := FCachedStreamPosition;
           Move(PAnsiChar(b + offset)^, PAnsiChar(@FCacheBuffer[0])^, Count);
           FCachePosition := Count;
           FCacheSize := Count;  
           FCachedStreamPosition := FCachedStreamPosition + Count;  
           FIsCached := true;
           FIsWriteCache := true;
           Result := Result + Count;
           break;
        end;  
     end;
     end;
  end;
end;

{$ifdef D45}
function TCacheStream.Seek(Offset: Longint; Origin: word): Longint;
{$else}
function TCacheStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$endif}
Var newpos: int64;
begin
   newpos := FCachedStreamPosition;

   {$ifdef D45}
   case Origin of 
       soFromBeginning: 
          newpos := Offset;
       soFromCurrent: 
          newpos := FCachedStreamPosition + Offset;
       soFromEnd: 
          newpos := Size + Offset;
   end;    
   {$else}
   case Origin of 
       soBeginning: 
          newpos := Offset;
       soCurrent:
          newpos := FCachedStreamPosition + Offset;
       soEnd:
          newpos := Size + Offset;
   end;    
   {$endif}
           
   if newpos <> FCachedStreamPosition then begin
      if FIsCached {and FIsWriteCache} and 
         ((newpos < FCacheStartPosition) or 
          (newpos > (FCacheStartPosition + FCacheSize))) then begin
         CacheToStream; 
      end;

      if (newpos < FCachedStreamPosition) or (newpos < FStreamPosition) then begin
         FCachedStreamPosition := newpos;   
      end else begin
         if FIsCached then begin
            if newpos <=  (FCacheStartPosition + FCacheSize) then begin
               FCachedStreamPosition := newpos;   
            end else begin
               {$ifdef D45}
               FStreamPosition := FStream.Seek(newpos, soFromBeginning);
               {$else}
               FStreamPosition := FStream.Seek(newpos, soBeginning);
               {$endif}
               FCachedStreamPosition := FStreamPosition; 
            end; 
         end else begin
            {$ifdef D45}
            FStreamPosition := FStream.Seek(newpos, soFromBeginning);
            {$else}
            FStreamPosition := FStream.Seek(newpos, soBeginning);
            {$endif}
            FCachedStreamPosition := FStreamPosition; 
         end;
      end;

      if FIsCached then begin
         FCachePosition := FCachedStreamPosition -  FCacheStartPosition;
      end; 

   end;
         
   Result := FCachedStreamPosition;
end;

constructor TNoStream.Create(AStream: Tstream; ACacheCapacity: int64; FreeOnDestroy: boolean);
begin
  FFreeOnDestroy := FreeOnDestroy;
  FStream := AStream;
end;

destructor TNoStream.Destroy;
begin
  if FFreeOnDestroy then FStream.Free;
end;

function TNoStream.getPosition:int64;
begin
  Result := 0;
end;

function TNoStream.GetSize:int64;
begin
  Result := 0;
end;

function TNoStream.Read(var Buffer; Count: Longint): Longint;
begin
    Result := Count;
end;

function TNoStream.Write(const Buffer; Count: Longint): Longint;
begin
   Result := Count;
end;

{$ifdef D45}
function TNoStream.Seek(Offset: Longint; Origin: word): Longint;
{$else}
function TNoStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$endif}
begin
   Result := 0;
end;

end.
