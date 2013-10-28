//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlscols
//
//
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2009 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlscols;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses  xlsstylexf, xlsblob;

{$I xlsbase.inc}

type


  TXLSColumnInfo = class(TObject)
  private
     FWidth: Word;  //8.43
     FXFIndex: integer;
     FHidden: Boolean;
     FOutlineLevel: byte;
    procedure SetWidth(const Value: single);
    function GetWidth: single;
    procedure SetOutLineLevel(const Value: integer);
    function GetOutlineLevel: integer;
  public
     property OutlineLevel: integer read GetOutLineLevel write SetOutlineLevel;
     property Width: single read GetWidth write SetWidth;
     property XFIndex: integer read FXFIndex;
     property Hidden: boolean read FHidden;
     constructor Create; virtual;
     function isEqual(colinfo: TXLSColumnInfo): boolean;
  end;

  TXLSCols_A = array [0..255] of TXLSColumnInfo;
  PXLSCols_A = ^TXLSCols_A;
  TXLSCols_B = array [0..63] of PXLSCols_A;

  TXLSColumnInfoList = class(TObject)
  private
    FXFList: TXLSStyleXFs;
    FColumns: TXLSCols_B;
    FDefaultColInfo: TXLSColumnInfo;
    FMinCol: integer;
    FMaxCol: integer;
    FColCount: integer;
    FMaxOutlineLevel: byte;
    function CreateColumnInfo(Index: integer): TXLSColumnInfo; 
    function GetHidden(Index: integer): boolean;
    function GetWidth(Index: integer): Single;
    function GetXF(Index: integer): integer;
    procedure SetHidden(Index: integer; const Value: boolean);
    procedure SetWidth(Index: integer; const Value: Single);
    procedure SetStdWidth(const Value: Single);
    function  GetStdWidth: Single;
    procedure SetXF(Index: integer; const Value: integer);
    function GetOutlineLevel(Index: integer): integer;
    procedure SetOutlineLevel(Index: integer; Value: integer);
    function GetOrCreateColumnInfo(Index: integer): TXLSColumnInfo;
  public
     constructor Create(XFList: TXLSStyleXFs); virtual;
     destructor  Destroy; override;
     procedure _SetColInfo(acol: integer; awidth: integer; ahidden: boolean; axf: integer; aolnlevel: byte);
     function GetColumnInfo(Index: integer): TXLSColumnInfo;
     function GetFirstVisible: integer;
     procedure CopyColFormat(dstcol: integer; SrcColInfo:TXLSColumnInfo);
     function GetColInfoBlob(Index: integer; FileFormat:TXLSFileFormat; Count: integer): TXLSBlob;
     function GetDefColInfoBlob: TXLSBlob;
     function GetDefColWidthBlob: TXLSBlob;
     procedure CalcMaxOutLineLevel;
     procedure DeleteCol(col: integer);
     function FindNextColToStore(StartIndex: integer; Var MinCol, MaxCol: integer): boolean;

     property OutlineLevel[Index: integer]: integer read GetOutlineLevel write SetOutlineLevel;
     property MaxOutlineLevel: byte read FMaxOutlineLevel write FMaxOutlineLevel; 
     property XFIndex[Index: integer]:integer read GetXF write SetXF;
     property Width[Index: integer]:Single read GetWidth write SetWidth;
     property Hidden[Index: integer]:boolean read GetHidden write SetHidden;
     property StdWidth: Single read GetStdWidth write SetStdWidth;
     property Column[index: integer]: TXLSColumnInfo read GetColumnInfo; 
     property ColCount: integer read FColCount;
     property MinCol: integer read FMinCol;
     property MaxCol: integer read FMaxCol;
  end;

  function  Width2Excel(Value: Single):Word;
  function  Excel2Width(Value: Word):Single;

implementation

const DefaultXFIndex: integer = $0F;

function Width2Excel(Value: Single): Word;
Var  IntPart: LongWord;
begin
  IntPart := Trunc(Value);
  if IntPart > 0 then
     Result := ((IntPart shl 8) or $B6) + Round((Value - IntPart)* 256)
  else
     Result := Round((Value - IntPart)* 256 * 1.8);
end;

function Excel2Width(Value: Word): Single;
begin
  if Value >= 438 then
     Result := Round((Value - $B6)/256 * 100)/100
  else
     Result := Round(Value/(256 * 1.8) * 100)/100;
end;


{ TXLSColumnInfo }
constructor TXLSColumnInfo.Create;
begin
  inherited Create;
  FWidth := $924;
  FXFIndex := $0F;
end;


function TXLSColumnInfo.GetWidth: single;
begin
  Result := Excel2Width(FWidth);
end;

procedure TXLSColumnInfo.SetWidth(const Value: single);
begin
  FWidth := Width2Excel(Value);
end;


procedure TXLSColumnInfo.SetOutLineLevel(const Value: integer);
begin
  if (Value >= 1) and (Value <= 8) then FOutlineLevel := (Value - 1);
end;

function TXLSColumnInfo.GetOutlineLevel: integer;
begin 
  Result := FOutlineLevel + 1; 
end;

function TXLSColumnInfo.isEqual(colinfo: TXLSColumnInfo): boolean;
begin
  if Assigned(colinfo) then begin
     Result :=  (colinfo.FWidth        = FWidth)        and
                (colinfo.FXFIndex      = FXFIndex)      and
                (colinfo.FOutlineLevel = FOutlineLevel) and
                (colinfo.FHidden       = FHidden);
  end else begin
     Result := false;
  end;
end;

{ TXLSColumnInfoList }

constructor TXLSColumnInfoList.Create(XFList: TXLSStyleXFs);
begin
  inherited Create;
  FDefaultColInfo := TXLSColumnInfo.Create;
  FDefaultColInfo.FXFIndex := DefaultXFIndex;
  FXFList := XFList;
end;

destructor TXLSColumnInfoList.Destroy;
Var i, j: integer;
begin
  for i := 0 to 63 do begin
    if Assigned(FColumns[i]) then begin
       for j := 0 to 255 do begin
         if Assigned(FColumns[i]^[j]) then FColumns[i]^[j].Free;
       end;
       FreeMem(FColumns[i], sizeof(TXLSCols_A)); 
    end; 
  end;
  FDefaultColInfo.Free;
  inherited Destroy;
end;


function TXLSColumnInfoList.CreateColumnInfo(Index: integer): TXLSColumnInfo; 
Var ColInfo: TXLSColumnInfo;
    i: integer;
begin
  if (Index < 0) or (Index > $00003FFF) then begin
      Result := nil;
      exit;
  end;

  ColInfo := TXLSColumnInfo.Create;
  FXFList.ReplaceIndex(ColInfo.FXFIndex, FDefaultColInfo.FXFIndex);
  ColInfo.FXFIndex := FDefaultColInfo.FXFIndex;
  ColInfo.FWidth := FDefaultColInfo.FWidth;

  i := Index shr 8;

  if Not(Assigned(FColumns[i])) then begin
     GetMem(FColumns[i], sizeof(TXLSCols_A)); 
     FillChar(FColumns[i]^, sizeof(TXLSCols_A), 0);
  end;

  FColumns[i]^[Index and $000000FF] := ColInfo;

  if (Index < FMinCol) or (FColCount = 0) then FMinCol := Index;
  if (Index > FMaxCol) or (FColCount = 0) then FMaxCol := Index;
  Inc(FColCount);
  Result := ColInfo;
end;

procedure TXLSColumnInfoList.DeleteCol(col: integer);
var i: integer;
begin

   if (col < 0) or (col > $00003FFF) then begin
      exit;
   end;

  i := col shr 8;

  if Not(Assigned(FColumns[i])) then exit; 
  if Not(Assigned(FColumns[i]^[col and $000000FF])) then exit;

  FColumns[i]^[col and $000000FF].Free;
  FColumns[i]^[col and $000000FF] := nil;

  if FColCount > 1 then begin
     if col = FMinCol then begin
        for i := FMinCol + 1 to FMaxCol do begin
            if Assigned(GetColumnInfo(i)) then begin
               FMinCol := i;
               break;
            end else if i = FMaxCol then begin
               FMinCol := 0;
               FMaxCol := 0;
               FColCount := 0;
            end;
         end;
      end else if col = FMaxCol then begin
         for i := FMaxCol - 1 downto FMinCol do begin
            if Assigned(GetColumnInfo(i)) then begin
               FMaxCol := i;
               break;
            end else if i = FMinCol then begin
               FMinCol := 0;
               FMaxCol := 0;
               FColCount := 0;
            end;
         end;
      end;
   end;

   if FColCount > 0 then begin
      Dec(FColCount);
      if (FMinCol > FMaxCol) or (FColCount = 0) then begin
         FMinCol := 0;
         FMaxCol := 0;
         FColCount := 0;
      end;
   end;
end;

function TXLSColumnInfoList.GetColumnInfo(Index: integer): TXLSColumnInfo;
var i: integer;
begin
  if (Index < 0) or (Index > $00003FFF) then begin
      Result := nil;
      exit;
  end;

  i := Index shr 8;
  if Not(Assigned(FColumns[i])) then begin
     Result := nil;
  end else begin
     Result := FColumns[i]^[Index and $000000FF];
  end;
end;

procedure TXLSColumnInfoList.CopyColFormat(dstcol: integer; SrcColInfo:TXLSColumnInfo);
Var DstColInfo:TXLSColumnInfo;
begin

  DstColInfo := GetColumnInfo(dstcol);
  if Not(Assigned(DstColInfo)) then begin
     if Assigned(SrcColInfo) then 
        DstColInfo := CreateColumnInfo(dstcol);
  end;

  if Assigned(DstColInfo) then begin

     if not(Assigned(SrcColInfo)) then begin
        SrcColInfo := FDefaultColInfo;
     end;

     FXFList.ReplaceIndex(DstColInfo.FXFIndex, SrcColInfo.FXFIndex); 
     DstColInfo.FXFIndex := SrcColInfo.FXFIndex;
     DstColInfo.FHidden := SrcColInfo.FHidden;
     DstColInfo.FWidth := SrcColInfo.FWidth;
     DstColInfo.FOutlineLevel := SrcColInfo.FOutlineLevel;
  end;
end;

procedure TXLSColumnInfoList._SetColInfo(acol: integer; awidth: integer; ahidden: boolean; 
          axf: integer; aolnlevel: byte);
var colinfo: TXLSColumnInfo;
begin
  if (acol < 0) then begin
     //exception
  end else begin
    colinfo := GetColumnInfo(acol);
    if Not(Assigned(colinfo)) then colinfo := CreateColumnInfo(acol);
    if Assigned(colinfo) then begin
        with colinfo do begin
          FHidden := ahidden;
          if awidth >= 0 then FWidth := awidth;
          OutLineLevel := aolnlevel;
        end;
        SetXF(acol, axf);
    end;
  end;
end;

function TXLSColumnInfoList.GetColInfoBlob(Index: integer; FileFormat: TXLSFileFormat; Count: integer): TXLSBlob;
Var ColDx: Word;
    ixfe: Word;
    lSize: word;
    grbit: word;
    ollevel: byte;
    colinfo: TXLSColumnInfo;
begin
    colinfo := GetColumnInfo(Index);
    ColDx := colinfo.FWidth;
    if colinfo.FXFIndex > 0 then ixfe := FXFList.SaveIndex[colinfo.FXFIndex] - 1
    else ixfe := 0;
//    if FileFormat = xlExcel5 then lSize := 16 else lSize := 15;
    lSize := 16;
    Result := TXLSBlob.Create(lSize);
    Result.AddWord($007D);  //Record identifier
    Result.AddWord(lSize - 4);  //Number of bytes to follow
    Result.AddWord(Index);
    if ((Index + Count - 1) = 255) and (count > 1) then
       Result.AddWord($0100)
    else
       Result.AddWord(Index + Count - 1);
    Result.AddWord(ColDx);
    Result.AddWord(ixfe);
    ollevel := colinfo.OutlineLevel;
    if MaxOutlineLevel < (ollevel - 1) then MaxOutlineLevel := ollevel - 1;

    grbit := (ord(colinfo.FHidden) and $0001) or  //hidden
             (((ollevel - 1) and $07) shl 8); //outlinelevel
    grbit := grbit or $0002;
    Result.AddWord(grbit); //Option flags

//    if FileFormat = xlExcel5 then
       Result.AddWord($0002)  //Reserved
//    else 
//       Result.AddByte($00);    //Reserved
end;

function TXLSColumnInfoList.GetDefColInfoBlob: TXLSBlob;
Var ColDx: Word;
begin
    ColDx := FDefaultColInfo.FWidth;
    if ColDx <> $924 then begin
      Result := TXLSBlob.Create(6);
      Result.AddWord($0099);  //Record identifier
      Result.AddWord($0002);  //Number of bytes to follow
      Result.AddWord(ColDx);
    end else begin
      Result := nil; 
    end;
end;

function TXLSColumnInfoList.GetDefColWidthBlob: TXLSBlob;
//Var ColDx: Word;
begin
//    ColDx := FDefaultColInfo.FWidth div 296;
    Result := TXLSBlob.Create(6);
    Result.AddWord($0055);  //Record identifier
    Result.AddWord($0002);  //Number of bytes to follow
    Result.AddWord(8);
end;


function TXLSColumnInfoList.GetHidden(Index: integer): boolean;
var colinfo: TXLSColumnInfo;
begin
  if (Index < 0) then begin
     //exception
     Result := false;
  end
  else begin
    colinfo := GetColumnInfo(Index);
    if Not(Assigned(colinfo)) then Result := FDefaultColInfo.FHidden
    else Result := colinfo.FHidden;
  end;
end;

function TXLSColumnInfoList.GetOrCreateColumnInfo(Index: integer): TXLSColumnInfo;
begin
  Result := GetColumnInfo(Index);
  if Not(Assigned(Result)) then Result := CreateColumnInfo(Index);
end;

function TXLSColumnInfoList.GetFirstVisible: integer;
begin
  Result := 0;
  while Hidden[Result] do inc(Result);
end;


function TXLSColumnInfoList.GetWidth(Index: integer): Single;
var colinfo: TXLSColumnInfo;
begin
  if Index < 0 then begin
     //exception
     Result := FDefaultColInfo.Width;
  end
  else begin
    colinfo := GetColumnInfo(Index);
    if Not(Assigned(colinfo)) then Result := FDefaultColInfo.Width
    else Result := colinfo.Width;
  end;
end;

function TXLSColumnInfoList.GetXF(Index: integer): integer;
var colinfo: TXLSColumnInfo;
begin
  if (Index < 0) then begin
     //exception
     Result := FDefaultColInfo.FXFIndex;
  end
  else begin
    colinfo := GetColumnInfo(Index);
    if Not(Assigned(colinfo)) then Result := FDefaultColInfo.FXFIndex
    else Result := colinfo.FXFIndex;
  end;
end;

procedure TXLSColumnInfoList.SetHidden(Index: integer;
  const Value: boolean);
var colinfo: TXLSColumnInfo;
begin
  if (Index < 0) then begin
     //exception
  end
  else begin
    colinfo := GetOrCreateColumnInfo(Index);
    if Assigned(colinfo) then colinfo.FHidden := Value;
  end;
end;

procedure TXLSColumnInfoList.SetWidth(Index: integer; const Value: Single);
var colinfo: TXLSColumnInfo;
begin
  if (Index < 0) then begin
     //exception
  end
  else begin
    colinfo := GetOrCreateColumnInfo(Index);
    if Assigned(colinfo) then colinfo.Width := Value;
  end;
end;

procedure TXLSColumnInfoList.SetStdWidth(const Value: single);
begin FDefaultColInfo.Width := Value end;

function TXLSColumnInfoList.GetStdWidth: Single;
begin Result := FDefaultColInfo.Width end;


procedure TXLSColumnInfoList.SetXF(Index: integer; const Value: integer);
var colinfo: TXLSColumnInfo;
begin
  if (Index < 0) then begin
     //exception
  end
  else begin
    colinfo := GetOrCreateColumnInfo(Index);
    if Assigned(colinfo) then begin
       FXFList.ReplaceIndex(colinfo.FXFIndex, Value);
       colinfo.FXFIndex := Value;
    end;
  end;
end;

function TXLSColumnInfoList.GetOutlineLevel(Index: integer): integer;
var colinfo: TXLSColumnInfo;
begin
  if (Index < 0) then begin
     //exception
     Result := 1;
  end
  else begin
    colinfo := GetColumnInfo(Index);
    if Not(Assigned(colinfo)) then Result := 1
                              else Result := colinfo.OutlineLevel;
  end;
end;

procedure TXLSColumnInfoList.SetOutlineLevel(Index: integer; Value: integer);
var colinfo: TXLSColumnInfo;
begin
  if (Index < 0) then begin
     //exception
  end else if (Value >= 1) and (Value <= 8) then begin
    if Value = 1 then begin
       colinfo := GetColumnInfo(Index); 
       if Assigned(colinfo) then colinfo.OutlineLevel := Value;
    end else begin
       colinfo := GetOrCreateColumnInfo(Index); 
       if Assigned(colinfo) then colinfo.OutlineLevel := Value;
    end;
  end;
end;

procedure TXLSColumnInfoList.CalcMaxOutLineLevel;
var i, j: integer;
    c: TXLSColumnInfo;
begin
  FMaxOutlineLevel := 0;
  for i := 0 to 63 do begin
     if Assigned(FColumns[i]) then begin
        for j := 0 to 255 do begin
            if Assigned(FColumns[i]^[j]) then begin
               c := FColumns[i]^[j];
               if c.OutlineLevel > FMaxOutlineLevel then 
                  FMaxOutlineLevel := c.OutlineLevel; 
            end;
        end; 
     end;
  end;
  if FMaxOutLineLevel > 0 then Dec(FMaxOutLineLevel);
end;

function TXLSColumnInfoList.FindNextColToStore(StartIndex: integer; Var MinCol, MaxCol: integer): boolean;
var si, i, sj, j: integer;
    c: TXLSColumnInfo;
    ex: boolean;
begin
  Result := false;
  c := nil;
  ex := false;
  si :=  StartIndex shr 8;
  sj :=  StartIndex and $000000FF; 
  if si > 63 then exit;
  MinCol := -1;
  MaxCol := -1;
  for i := si to 63 do begin
     if Assigned(FColumns[i]) then begin
        for j := sj to 255 do begin
            if Assigned(FColumns[i]^[j]) then begin
               if Result then begin
                   if c.IsEqual(FColumns[i]^[j]) then begin
                      Inc(MaxCol);
                   end else begin
                      ex := true;
                      break;
                   end 
               end else begin
                   c := FColumns[i]^[j];
                   MinCol := (i shl 8) or j;
                   MaxCol := MinCol;
                   Result := true;
               end;
            end else begin
               if Result then begin
                  ex := true;
                  break;
               end; 
            end;
        end; 
     end else begin
        if Result then break;
     end;
     sj := 0;   
     if ex then break;
  end;
end;
  

end.
