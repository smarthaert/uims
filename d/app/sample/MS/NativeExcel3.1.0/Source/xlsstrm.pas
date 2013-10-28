//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsstrm
//
//
//      Description:  
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

unit xlsstrm;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses ole, xlsblob,
     classes, xlscrypt,
     {$IFDEF D45}
         ComObj
     {$ELSE}
         Variants
     {$ENDIF};

const
  xlsReadOpenStorageError = -2;
  xlsReadOpenStreamError  = -3;

type

 TXLSReadStream = class
 private
   FFileName: WideString;
   FStreamPos: Longword;
   FSrcStream: TStream;
   FLockBytes: ILockBytes;
   FStorage:  IStorage;
   FStream: IStream;
   FPlainStream: TStream;
   FUsePlainStream: boolean;

   FPassword: WideString; 
   FDecrypter: TXLSDecrypter;
   FSkipEncryptNextRec: boolean;
   FIsEncrypted: boolean; 

   function OpenStorage: integer;
   function OpenStream: integer;
   function OpenPlainStream: integer;
   function Open(): integer; overload;
 public
   constructor Create(Password: WideString);
   destructor Destroy; override;
   function CloseStorage: integer;
   function CloseStream: integer;
   function Open(AFileName: WideString): integer; overload;
   function Open(AStream: TStream): integer; overload;
   function ReadHeader(Var RecordID, RecordSize: Word): integer;
   function ReadBody(RecordSize: Word; Var Data: TXLSBlob): integer;
   function ParseFilePass(Data: TXLSBlob): integer;
   function OpenStorageFromBlob(Data: TXLSBlob): integer;
   property Stream: IStream read FStream;
   property Storage: IStorage read FStorage;
   property IsEncrypted: boolean read FIsEncrypted;
 end;

implementation
uses sysutils, windows, wstream;

Const
  REKEY_BLOCK_SIZE = $400;

{TXLSReadStream}
constructor TXLSReadStream.Create(Password: WideString);
begin
  inherited Create;
  FPassword := Password;
  FStreamPos := 0;
  FSkipEncryptNextRec := false;
  FIsEncrypted := false;
  FDecrypter := nil;
  //FSkipEncryptBody := false;
end;

destructor TXLSReadStream.Destroy;
begin
  FDecrypter.Free;
  inherited Destroy;
end;

function TXLSReadStream.OpenStorage: integer;
var  Hr : HResult;
     DHandle: HGLOBAL;
     Buff: PByteArray;
begin
   Result := 1;
   if (FFileName = '') and not(Assigned(FSrcStream)) then begin
   end else if Assigned(FSrcStream) then begin
       //Try open the Stream  
       DHandle := GlobalAlloc(GMEM_NODISCARD  
                           or GMEM_MOVEABLE,
                              FSrcStream.Size);
       Buff := GlobalLock(DHandle);
       try
         FSrcStream.ReadBuffer(Buff^, GlobalSize(DHandle));
         FSrcStream.Seek(0, soFromBeginning);
         Hr := CreateILockBytesOnHGlobal(DHandle, True, FLockBytes);
         if ole.SUCCEEDED(Hr) then  begin
             Hr := StgOpenStorageOnILockBytes(FLockBytes, 
                                             nil, 
                                             STGM_READ 
                                          or STGM_TRANSACTED 
                                          or STGM_SHARE_DENY_NONE , 
                                             nil, 0, FStorage);
         end;
         if not(ole.SUCCEEDED(Hr)) then  begin
            Result := xlsReadOpenStorageError;
         end;
       finally
         GlobalUnlock(DHandle);
       end;
     
   end else begin
      //Try open the DocFile
      Hr := StgOpenStorage(PWideChar(FFileName),
                           nil,
                           STGM_READ
   //                     or STGM_SIMPLE
   //                     or STGM_DIRECT
                        or STGM_TRANSACTED
   //                     or STGM_SHARE_DENY_WRITE
   //                     or STGM_SHARE_DENY_NONE
   //                     or STGM_SHARE_EXCLUSIVE
                          , nil, 0, FStorage);
      if not(ole.SUCCEEDED(Hr)) then  begin
           Result := xlsReadOpenStorageError;
      end;
   end;
end;


function TXLSReadStream.OpenStorageFromBlob(Data: TXLSBlob): integer;
var  Hr : HResult;
     DHandle: HGLOBAL;
     Buff: PByteArray;
begin
   Result := 1;
   DHandle := GlobalAlloc(GMEM_NODISCARD  
                       or GMEM_MOVEABLE,
                          Data.DataLength);
   Buff := GlobalLock(DHandle);
   try
     Move(Data.Buff^, Buff^, Data.DataLength);
     Hr := CreateILockBytesOnHGlobal(DHandle, True, FLockBytes);
     if SUCCEEDED(Hr) then  begin
         Hr := StgOpenStorageOnILockBytes(FLockBytes, 
                                         nil, 
                                         STGM_READ 
                                      or STGM_TRANSACTED 
                                      or STGM_SHARE_DENY_NONE , 
                                         nil, 0, FStorage);
     end;
     if not(SUCCEEDED(Hr)) then  begin
        Result := xlsReadOpenStorageError;
     end;
   finally
     GlobalUnlock(DHandle);
   end;
end;


function TXLSReadStream.OpenStream: integer;
var Hr : HResult;
begin
   Result := 1; 
   Hr := FStorage.OpenStream('workbook',
                             nil,
                             STGM_READ
                          or STGM_DIRECT
                          or STGM_SHARE_EXCLUSIVE
                             , 0, FStream);
   //Was is opened?
   if not (ole.SUCCEEDED(Hr)) then begin
      Hr := FStorage.OpenStream( 'book',
                                 nil,
                             STGM_READ
                          or STGM_DIRECT
                          or STGM_SHARE_EXCLUSIVE
                             , 0, FStream);
      if not(ole.SUCCEEDED(Hr)) then begin
          Result := xlsReadOpenStreamError;
      end else ;//w riteln('ok');
   end else begin
     //w riteln('ok'); 
   end;
   FStreamPos := 0;
end;

function TXLSReadStream.OpenPlainStream: integer;
Var RecodrdID, RecordSize: Word;
begin
   Result := 1;
   if (FFileName = '') and not(Assigned(FSrcStream)) then begin
   end else if Assigned(FSrcStream) then begin
       FPlainStream := FSrcStream; 
       FUsePlainStream := true;
   end else begin
       FUsePlainStream := true;
       try  
         FPlainStream := TWFileStream.Create(FFileName, fmOpenRead); 
       except
         Result := xlsReadOpenStreamError;
       end;
   end;

   if Result = 1 then begin
      ReadHeader(RecodrdID, RecordSize);
      if (RecodrdID <> $0809) or (RecordSize < 4) or (RecordSize > 30) then begin
           Result := xlsReadOpenStreamError;
           CloseStream; 
      end else begin
           FPlainStream.Seek(0, soFromBeginning);
      end;
   end;
   FStreamPos := 0;
end;

function TXLSReadStream.ReadHeader(Var RecordID, RecordSize: Word): integer;
var H: TXLSBlob;
    rcnt: integer;
begin                    
  H := TXLSBlob.Create(4);
  Result := 100;
  try 

    if FUsePlainStream then begin

       rcnt := 4;
       try 
         FPlainStream.ReadBuffer(H.Buff^, rcnt);
       except
         on E: EReadError do
            rcnt := 0;
       end;

    end else begin
       FStream.Read(H.Buff, 4, @rcnt);
    end;

    if FIsEncrypted then begin
        FDecrypter.Skip(4);
    end;
 
    Inc(FStreamPos, rcnt);

    if rcnt = 4 then begin
       RecordID   := H.GetWord(0);
       RecordSize := H.GetWord(2);
       case RecordID of 
            $0809: begin
                     FSkipEncryptNextRec := true; 
                   end;  
       end;
       Result := 1;
    end else if rcnt = 0 then Result := 100;
  finally
    H.Free;
  end;
end;

function TXLSReadStream.ReadBody(RecordSize: Word; Var Data: TXLSBlob): integer;
var rcnt: integer;
begin                         
  if RecordSize > 0 then begin
     Data := TXLSBlob.Create(RecordSize);
     Result := -1;
     if FUsePlainStream then begin
        rcnt := RecordSize;
        try 
          FPlainStream.ReadBuffer(Data.Buff^, rcnt);
        except
          on E: EReadError do
             rcnt := 0;
        end;
     end else begin
        FStream.Read(Data.Buff, RecordSize, @rcnt);
     end;

     if FIsEncrypted then begin
        if FSkipEncryptNextRec then begin
           FDecrypter.Skip(rcnt);
        end else begin
           FDecrypter.Decrypt(Data, rcnt); 
        end;                 
     end;

     Inc(FStreamPos, rcnt);

     if rcnt = RecordSize then begin 
        Data.SetDataSize(RecordSize);
        Result := 1 
     end else begin
        Data.Free;
        Data := nil;
     end;

  end else begin
    Data := nil;
    Result := 1;
  end;

  FSkipEncryptNextRec := false;

end;

function TXLSReadStream.CloseStream: integer; 
begin
  if not(FUsePlainStream) then begin
     FStream.Release;
  end else begin
     if not(FSrcStream = FPlainStream) then begin
        FPlainStream.Free; 
        FPlainStream := nil;
     end;
  end;

  FStreamPos := 0;

  Result := 1;
end;

function TXLSReadStream.CloseStorage: integer; 
begin
  if not(FUsePlainStream) then 
     FStorage.Release;
  Result := 1;
end;

function TXLSReadStream.Open: integer; 
begin
  Result := OpenStorage;
  if Result = 1 then begin
     Result := OpenStream;
  end else begin
     if Result = xlsReadOpenStorageError then begin
        Result := OpenPlainStream;
     end; 
     //w riteln('error open workbook');
  end;
end;

function TXLSReadStream.Open(AFileName: WideString): integer; 
begin
  FFileName := AFileName;
  FSrcStream := nil;
  Result := Open();
end;

function TXLSReadStream.Open(AStream: TStream): integer;
begin
  FFileName := '';
  FSrcStream := AStream;
  Result := Open();
end;


function TXLSReadStream.ParseFilePass(Data: TXLSBlob): integer;
var option: word;
begin
  Result := 1;

  FDecrypter.Free;
  FDecrypter := nil;

  if Data.DataLength < 2  then begin
     Result := -1001;
  end;
  if Result = 1 then begin
     option := Data.GetWord(0);
     if (option = 0) or (Data.DataLength = 4) then begin
       FDecrypter := TXLSDecrypterXOR.Create();
     end else if option = 1 then begin
       FDecrypter := TXLSDecrypterRC4.Create();
     end else begin
        //unsupported encryption 
        Result := -1002;
     end;
  end;
  if Result = 1 then begin

     if not (FDecrypter.CheckPassword(Data, 'VelvetSweatshop') = 1) then begin
        if FPassword = '' then begin
           Result := -1003;
           //password is required
        end;
        if Result = 1 then begin
           Result := FDecrypter.CheckPassword(Data, FPassword);
        end;
     end;
  end;

  if Result = 1 then begin
     FIsEncrypted := true;
     FSkipEncryptNextRec := true;
     FDecrypter.Skip(FStreamPos);
  end else begin
     FIsEncrypted := false;
     FSkipEncryptNextRec := false;
     FDecrypter.Free;
     FDecrypter := nil;
  end;

end;

end.
