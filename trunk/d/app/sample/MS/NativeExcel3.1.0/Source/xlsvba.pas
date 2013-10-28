//////////////////////////////////////////////////////////////////////////////
//
//	Unit:        xlsvba
//       
//      Description: Read, store and write a storage folder
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

unit xlsvba;
{$Q-}
{$R-}

interface
uses ole, xlsblob;

type

  TXLSFileItem = class
  private
    FName: WideString;   
  public
    function Load(Parent: IStorage): integer; virtual; abstract;
    function Write(Parent: IStorage): integer; virtual; abstract;
    constructor Create(AName: WideString); 
    destructor Destroy; override;
    property Name: WideString read FName;
  end;

  TXLSFileStream = class(TXLSFileItem)
  private
    FData: TXLSBlob;
    FSize: LongWord;
    FUnknownSize: boolean;
  public
    function Load(Parent: IStorage): integer; override;
    function Write(Parent: IStorage): integer; override;
    constructor Create(AName: WideString; ASize: LongWord); overload; virtual;
    constructor Create(AName: WideString); overload; virtual;
    destructor Destroy; override;
    property Data: TXLSBlob read FData;
    property DataSize: longword read FSize;
  end;

  TXLSFileStorage = class(TXLSFileItem)
  private
    FChild: array of TXLSFileItem;
    FCount: integer;
    function GetChild(i: integer): TXLSFileItem;
  public
    function LoadFolder(Folder: IStorage): integer; 
    function Load(Parent: IStorage): integer; override;
    function Write(Parent: IStorage): integer; override;
    function GetChildByName(AName: widestring): TXLSFileItem;
    constructor Create(AName: WideString); virtual;
    destructor Destroy; override;
    property Count: integer read FCount;
    property Child[i: integer]: TXLSFileItem read GetChild;
  end;
 
implementation

uses SysUtils;

constructor TXLSFileItem.Create(AName: WideString); 
begin
  inherited Create;
  FNAme := AName;
end;

destructor TXLSFileItem.Destroy;
begin
  inherited Destroy;
end;

constructor TXLSFileStorage.Create(AName: WideString); 
begin
  inherited Create(AName);
  FCount := 0;
end;

destructor TXLSFileStorage.Destroy;
Var i: integer;
begin
  if FCount > 0 then begin
     for i := 1 to FCount do FChild[i - 1].Free; 
  end;
  inherited Destroy;
end;

function TXLSFileStorage.GetChild(i: integer): TXLSFileItem;
begin
   if (i < FCount) and (i >= 0) then begin
      Result := FChild[i];
   end else begin
      Result := nil;
   end;
end;

function TXLSFileStorage.GetChildByName(AName: widestring): TXLSFileItem;
var i: integer;
    lname: widestring;
begin
  Result := nil;
  if FCount > 0 then begin
     lname := lowercase(AName);
     for i := 0 to FCount - 1 do begin                  
       if lowercase(FChild[i].Name) = lname then begin
          Result := FChild[i];
          break; 
       end;
     end;
  end;
end;
                                

constructor TXLSFileStream.Create(AName: WideString; ASize: LongWord); 
begin
  inherited Create(AName);
  FSize := ASize;
  FUnknownSize := false;
  FData := nil;
end;

constructor TXLSFileStream.Create(AName: WideString); 
begin
  inherited Create(AName);
  FUnknownSize := true;
  FData := nil;
end;

destructor TXLSFileStream.Destroy;
begin
  FData.Free;
  inherited Destroy;
end;

function TXLSFileStream.Load(Parent: IStorage): integer; 
Var Str: IStream;
    Hr: HResult;
    rcnt: LongWord;
    l: Largeint;
begin
  Result := 1;
  Hr := Parent.OpenStream(PWideChar(FName),
                          nil,
                          STGM_READ
                          or STGM_DIRECT
                          or STGM_SHARE_EXCLUSIVE, 
                          0, Str);
  if (ole.SUCCEEDED(Hr)) then begin
     if FUnknownSize then begin
        Str.Seek(0, 2, l);
        FSize := trunc(l) - 1;
        Str.Seek(0, 0, l);
     end;

     FData := TXLSBlob.Create(FSize); 
     Str.Read(FData.Buff, FSize, @rcnt);
     FData.SetDataSize(rcnt);
     Str.Release;
  end else Result := -1;
  Str := nil;
end;

function TXLSFileStream.Write(Parent: IStorage): integer; 
Var Str: IStream;
    Hr: HResult;
begin
  Result := 1;

  Hr := Parent.CreateStream( PWideChar(FName),
                             STGM_CREATE or STGM_WRITE or
                             STGM_DIRECT or STGM_SHARE_EXCLUSIVE,
                             0,
                             0,
                             Str);
  if (ole.SUCCEEDED(Hr)) then begin
     FData.Write(Str); 
     Str.Release;
  end else Result := -1;
  Str := nil;
end;

function TXLSFileStorage.LoadFolder(Folder: IStorage): integer; 
Var 
    Enum:IEnumStatStg;
    Data:TStatStg;
begin
  Result := 1;
  Folder.EnumElements(0, nil, 0, Enum);
  try
    While Enum.Next(1, Data, nil) = 0 do begin
      Inc(FCount);
      SetLength(FChild, FCount);

      if Data.dwType = 1 then begin
         FChild[FCount - 1] := TXLSFileStorage.Create(Data.pwcsName);
      end else begin
         FChild[FCount - 1] := TXLSFileStream.Create(Data.pwcsName, Round(Data.cbSize));
      end;
      Result := FChild[FCount - 1].Load(Folder);
      if Result <> 1 then break;
    end;
  finally
    Enum := nil;
  end;
end;

function TXLSFileStorage.Load(Parent: IStorage): integer; 
Var Folder: IStorage;
    Hr: HResult;
begin
  Hr := Parent.OpenStorage(PWideChar(FName), nil,
                       STGM_READWRITE or
                       STGM_SHARE_EXCLUSIVE,
                       nil,
                       0,
                       Folder);
  if (ole.SUCCEEDED(Hr)) then begin
     Result := LoadFolder(Folder);
     Folder.Release;
  end else Result := -1;
  Folder := nil;
end;

function TXLSFileStorage.Write(Parent: IStorage): integer; 
Var Folder: IStorage;
    Hr: HResult;
    i: integer;
begin
  Result := 1;
  Hr := Parent.CreateStorage(PWideChar(FName),
                       STGM_READWRITE or
                       STGM_SHARE_EXCLUSIVE,
                       0,
                       0,
                       Folder);
  if (ole.SUCCEEDED(Hr)) then begin
     if FCount > 0 then begin
        for i := 1 to FCount do begin
            Result := FChild[i - 1].Write(Folder);
            if Result <> 1 then break
        end;
     end;
     Folder.Release;
  end else Result := -1;
  Folder := nil;
end;

end.

