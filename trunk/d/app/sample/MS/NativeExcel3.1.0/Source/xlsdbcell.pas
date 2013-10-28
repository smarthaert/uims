//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsdbcell
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

unit xlsdbcell;
{$Q-}
{$R-}

interface
uses xlsblob; 

type 

  TXLSDBCell = class
  private
    FStartRow: integer;
    FFinalRow: integer;

    FFinalOffset: longword;
    FStartOffset: longword;
    
    FBookmarkFirstRow: integer; 
    FBookmarkLastRow: integer; 

    FRowOffset: array[$00..$1F] of longword;
    FRowFlag:        array[$00..$1F] of boolean;
    FRowCount: integer;
  
    function GetRowBlockOffset: longword;
  public
    constructor Create(AStartRow: integer; AStartOffset: longword);
    destructor  Destroy; override;

    procedure StartRowBlock(AStartRow: integer; AStartOffset: longword);
    procedure AddRowBookmark(ARow: integer; AOffset: longword);
    procedure FinalRowBlock(AFinalRow: integer; AFinalOffset: longword);

    function GetData(AFileFormat: TXLSFileFormat): TXLSBlob;
    property DBCellOffset: longword read FFinalOffset;
    property BookmarkFirstRow: integer read FBookmarkFirstRow;
    property BookmarkLastRow: integer read FBookmarkLastRow;
  end;

  TXLSDBCellIndex = class
  private
    FArr: array [0..2048] of longword;
    FCount: integer;
    FFirstRow, FLastRow: integer;
  public
    constructor Create();
    destructor  Destroy; override;
    function GetDataSize(AFileFormat: TXLSFileFormat): integer;
    function GetData(AFileFormat: TXLSFileFormat; Offset: longword): TXLSBlob;
    procedure RegisterRowBlock(AFirstRow: integer; ALastRow: integer; ADBCellOffset: longword);
  end;



implementation

constructor TXLSDBCell.Create(AStartRow: integer; AStartOffset: longword);
begin
  inherited Create;
  StartRowBlock(AStartRow, AStartOffset);
end;

procedure TXLSDBCell.StartRowBlock(AStartRow: integer; AStartOffset: longword);
var i: integer;
begin
  FStartRow := AStartRow;
  FStartOffset := AStartOffset;

  FFinalRow := AStartRow;
  FFinalOffset := AStartOffset;

  FBookmarkFirstRow := -1;
  FBookmarkLastRow := -1;
  FRowCount := 0;

  for i := 0 to $1F do FRowFlag[i] := false;
end;

destructor TXLSDBCell.Destroy;
begin
  inherited Destroy;
end;

procedure TXLSDBCell.AddRowBookmark(ARow: integer; AOffset: longword);
begin

  if (FBookmarkFirstRow = -1) or (FBookmarkFirstRow > ARow) then begin
     FBookmarkFirstRow := ARow; 
  end; 

  if FBookmarkLastRow < ARow then begin
     FBookmarkLastRow := ARow; 
  end; 

  FRowOffset[ARow - FStartRow] := AOffset;
  if not(FRowFlag[ARow - FStartRow]) then Inc(FRowCount);
  FRowFlag[ARow - FStartRow] := true;
end;

procedure TXLSDBCell.FinalRowBlock(AFinalRow: integer; AFinalOffset: longword);
begin
  FFinalRow := AFinalRow;
  FFinalOffset := AFinalOffset;
end;

function TXLSDBCell.GetRowBlockOffset: longword;
begin
  Result := FFinalOffset - FStartOffset; 
end;

function TXLSDBCell.GetData(AFileFormat: TXLSFileFormat): TXLSBlob;
var Data: TXLSBlob;
    size: integer;
    i: integer;
    CurOffset: longword;
    Offset: integer;
    badoffset: boolean;
begin
   size := 4 + 2 * FRowCount;
   Data := TXLSBlob.Create(4 + size);
   Data.AddWord($00D7); Data.AddWord(size);
   badoffset := false;

   if FRowCount > 0 then begin
      Data.AddLong(GetRowBlockOffset());
      CurOffset := FStartOffset + 20 {one rowinfo record length};
      for i := 0 to $1F do begin
         if FRowFlag[i] then begin
            Offset := FRowOffset[i] - CurOffset;
            CurOffset := FRowOffset[i];
            if (Offset > $FFFF) or badoffset then begin
               Data.AddWord(0);
               badoffset := true; 
            end else begin
               Data.AddWord(Offset);
            end; 
         end;
      end;
   end else begin
      Data.AddLong(0);
   end;

   Result := Data;
end;


constructor TXLSDBCellIndex.Create();
begin
  inherited Create;
  FCount := 0; 
  FFirstRow := -1;
  FLastRow := -1;
end;

destructor  TXLSDBCellIndex.Destroy;
begin
  inherited Destroy;
end;

function TXLSDBCellIndex.GetDataSize(AFileFormat: TXLSFileFormat): integer;
begin
  if FFirstRow = -1 then begin
     Result := 0;
  end else begin
     if AFileFormat = xlExcel5 then Result := 4 + 12
                               else Result := 4 + 16;
     Result := Result + FCount * 4;
  end;
end;

function TXLSDBCellIndex.GetData(AFileFormat: TXLSFileFormat; Offset: longword): TXLSBlob;
var Data: TXLSBlob;
    lSize: integer;
    i: integer;
begin
  lSize := GetDataSize(AFileFormat);
  if lSize > 0 then begin
     Data := TXLSBlob.Create(lSize);
     Data.AddWord($020B);          //Record
     Data.AddWord(lSize - 4);      //Length
     Data.AddLong(0);
     if AFileFormat = xlExcel5 then begin
        Data.AddWord(FFirstRow);
        Data.AddWord(FLastRow + 1);
     end else begin
        Data.AddLong(FFirstRow);
        Data.AddLong(FLastRow + 1);
     end;

     Data.AddLong(0); //Absolute stream position of the DEFCOLWIDTH
     for i := 0 to FCount - 1 do begin
       Data.AddLong(FArr[i] + Offset); 
     end;
     Result := Data;
  end else begin
     Result := nil;
  end;
end;


procedure TXLSDBCellIndex.RegisterRowBlock(AFirstRow: integer; ALastRow: integer; ADBCellOffset: longword);
begin
  FArr[FCount] := ADBCellOffset;
  Inc(FCount);

  If (FFirstRow = -1) or (AFirstRow < FFirstRow) then FFirstRow := AFirstRow;
  If (FLastRow = -1)  or (ALastRow > FLastRow)   then FLastRow  := ALastRow;
end;


end.