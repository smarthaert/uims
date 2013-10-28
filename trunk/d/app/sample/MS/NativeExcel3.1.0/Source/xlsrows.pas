//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsrows
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

unit xlsrows;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses  xlsstylexf, xlsblob;

{$I xlsbase.inc}

type

  TXLSRowInfo = class(TObject)
  private
     FHeight: Word;  //8.43
     FHeightSet: boolean;
     FXFIndex: integer;
     FXFIndexSet: boolean;
     FHidden: Boolean;
     FOutlineLevel: byte;
     FMinCol: integer;
     FMaxCol: integer; 
     FUnsynced: boolean;
    procedure SetHeight(const Value: single);
    procedure SetOutLineLevel(const Value: integer);
    function GetHeight: single;
    function GetOutlineLevel: integer;
  public
     property Height: single read GetHeight write SetHeight;
     property OutlineLevel: integer read GetOutLineLevel write SetOutlineLevel;
     property MinCol: integer read FMinCol write FMinCol; 
     property MaxCol: integer read FMaxCol write FMaxCol; 
     property CustomFormat: boolean read FXFIndexSet;
     property CustomHeight: boolean read FHeightSet;
     property Hidden: boolean read FHidden;
     property XFIndex: integer read FXFIndex;
     property XFIndexSet: boolean read FXFIndexSet;
     constructor Create; virtual;
  end;

  TXLSRows_A = array [0..255] of TXLSRowInfo;
  PXLSRows_A = ^TXLSRows_A;
  TXLSRows_B = array [0..255] of PXLSRows_A;
  PXLSRows_B = ^TXLSRows_B;
  TXLSRows_C = array [0..15] of PXLSRows_B;

  TXLSRowInfoList = class(TObject)
  private
     FXFList: TXLSStyleXFs;
     FRows: TXLSRows_C;
     FDefaultRowInfo: TXLSRowInfo;
     FMinRow: integer;
     FMaxRow: integer;
     FRowCount: integer;
     FMaxOutlineLevel: byte;
     function GetHidden(Index: integer): boolean;
     function GetHeight(Index: integer): Single;
     function GetXF(Index: integer): integer;
     procedure SetHidden(Index: integer; const Value: boolean);
     procedure SetHeight(Index: integer; const Value: Single);
     procedure SetXF(Index: integer; const Value: integer);
     procedure SetStdHeight(const Value: Single);
     function  GetStdHeight: Single;
     procedure CreateRowInfo(var Value: TXLSRowInfo);
     procedure Create_A(Var Value:PXLSRows_A);
     procedure Create_B(Var Value:PXLSRows_B);
     function GetOutlineLevel(Index: integer): integer;
     procedure SetOutlineLevel(Index: integer; Value: integer);
  public
     procedure DeleteRow(Index: integer);
     function IsEqualsToDefault(v: TXLSRowInfo): boolean;
     function GetRowInfoBlob(Index: integer): TXLSBlob;
     function GetDefRowInfoBlob: TXLSBlob;
     function AssignedBlock(Index: integer): boolean;
     function  IsHeightSet(Index: integer): boolean;
     function GetRowInfo(Index: integer):TXLSRowInfo;
     function  GetFirstVisible: integer;
     function FindNextRow(StartIndex: integer; var rowinfo: TXLSRowInfo): integer;
     procedure CopyRowFormat(dstrow: integer; SrcRowInfo:TXLSRowInfo);
     procedure CalcMaxOutlineLevel;
     property Rows[Index: integer]:TXLSRowInfo read GetRowInfo;
     property XFIndex[Index: integer]:integer read GetXF write SetXF;
     property Height[Index: integer]:Single read GetHeight write SetHeight;
     property Hidden[Index: integer]:boolean read GetHidden write SetHidden;
     property RowCount: integer read FRowCount;
     property MinRow: integer read FMinRow;
     property MaxRow: integer read FMaxRow;
     property OutlineLevel[Index: integer]: integer read GetOutlineLevel write SetOutlineLevel;
     property MaxOutlineLevel: byte read FMaxOutlineLevel write FMaxOutlineLevel; 
     constructor Create(XFList: TXLSStyleXFs); virtual;
     destructor Destroy; override;
     function GetOrDefaultRowInfo(Index: integer):TXLSRowInfo;
     function GetOrCreateRowInfo(Index: integer):TXLSRowInfo;
     procedure _SetRowInfo(arow: integer; aheight: word; aisheight: boolean; 
                           axf: integer; aisxf: boolean; aisHidden: boolean;
                           aoutlinelevel: byte; unsynced: boolean);
     property StdHeight: single read GetStdHeight write SetStdHeight;
  end;

function  Height2Excel(Value: Single):Word;
function  Excel2Height(Value: Word):Single;

implementation


const //XLSMaxRow: integer = 65535;
      XLSMaxCol: integer = 255;

function  Height2Excel(Value: Single):Word;
begin
  Result := Round((Round((Value - Trunc(Value))*4)/4 + Trunc(Value)) * 20);
end;

function  Excel2Height(Value: Word):Single;
begin
  Result := Round(Value/5)/4;
end;

{ TXLSRowInfo }

constructor TXLSRowInfo.Create;
begin
  inherited Create;
  FHeight := $FF;
  FHeightSet := false;
  FXFIndex := $0F;
  FXFIndexSet := false;
  FHidden := false;
  FMinCol := -1;
  FMaxCol := -1;
  FUnsynced := false;
end;

function TXLSRowInfo.GetHeight: single;
begin
  if FHidden then Result := 0
  else Result := Excel2Height(FHeight)
end;

procedure TXLSRowInfo.SetHeight(const Value: single);
begin
  FHidden := false;
  FHeight := Height2Excel(Value);
  FHeightSet := true;
  FUnsynced := true;
end;

procedure TXLSRowInfo.SetOutLineLevel(const Value: integer);
begin
  if (Value >= 1) and (Value <= 8) then FOutlineLevel := (Value - 1);
end;

function TXLSRowInfo.GetOutlineLevel: integer;
begin 
  Result := FOutlineLevel + 1; 
end;


{ TXLSRowInfoList }

constructor TXLSRowInfoList.Create(XFList: TXLSStyleXFs);
begin
  inherited Create;
  FDefaultRowInfo := TXLSRowInfo.Create;
  FDefaultRowInfo.FXFIndex := 0;
  FDefaultRowInfo.Height := 12.75;
  FXFList := XFList;
end;

destructor TXLSRowInfoList.Destroy;
Var row_c, row_b, row_a: Word;
    b: PXLSRows_B;
    a: PXLSRows_A;
begin
  for row_c := 0 to 15 do begin
    if Assigned(FRows[row_c]) then begin
       b := FRows[row_c];
       for row_b := 0 to 255 do begin
         if Assigned(b^[row_b]) then begin
            a := b^[row_b];
            for row_a := 0 to 255 do begin
               if Assigned(a^[row_a]) then begin
                  a^[row_a].Free;
               end;
            end;
            FreeMem(a, sizeof(TXLSRows_A));
         end;
       end;
       FreeMem(b, sizeof(TXLSRows_B));
    end;
  end;
  FDefaultRowInfo.Free;
  inherited Destroy;
end;

function TXLSRowInfoList.IsEqualsToDefault(v: TXLSRowInfo): boolean;
begin
   Result := (v.FHeight = FDefaultRowInfo.FHeight) and
             (v.FHeightSet = FDefaultRowInfo.FHeightSet) and
             (v.FXFIndex = FDefaultRowInfo.FXFIndex) and
             (v.FXFIndexSet = FDefaultRowInfo.FXFIndexSet) and
             (v.FHidden =  FDefaultRowInfo.FHidden) and
             (v.FUnsynced =  FDefaultRowInfo.FUnsynced);
end;

procedure TXLSRowInfoList.CreateRowInfo(var Value: TXLSRowInfo);
begin
  Value := TXLSRowInfo.Create;
  Value.FHeight := FDefaultRowInfo.FHeight;
end;

procedure TXLSRowInfoList.Create_A(var Value: PXLSRows_A);
begin
  GetMem(Value, sizeof(TXLSRows_A));
  FillChar(Value^, sizeof(TXLSRows_A), 0);
end;


procedure TXLSRowInfoList.Create_B(var Value: PXLSRows_B);
begin
  GetMem(Value, sizeof(TXLSRows_B));
  FillChar(Value^, sizeof(TXLSRows_B), 0);
end;

procedure TXLSRowInfoList.DeleteRow(Index: integer);
Var
  a: PXLSRows_A;
  b: PXLSRows_B;
  row_c, row_b, row_a: integer;
  i: integer; 
begin
  row_c := (Index shr 16) and $0000000F;
  b := FRows[row_c];
  if not Assigned(b) then exit;

  row_b := (Index shr 8)  and $000000FF;
  a := b^[row_b];
  if not Assigned(b) then exit;

  row_a := Index and $000000FF;
  if not Assigned(a^[row_a]) then exit;
  a^[row_a].Free;
  a^[row_a] := nil;

  if FRowCount > 1 then begin
     if Index = FMinRow then begin
        for i := FMinRow + 1 to FMaxRow do begin
           if Assigned(GetRowInfo(i)) then begin
              FMinRow := i;
              break;
           end else if i = FMaxRow then begin
              FMinRow := FMaxRow + 1;
           end;
        end;
     end else if Index = FMaxRow then begin
        for i := FMaxRow - 1 downto FMinRow do begin
           if Assigned(GetRowInfo(i)) then begin
              FMaxRow := i;
              break;
           end else if i = FMinRow then begin
              FMaxRow := FMinRow - 1;
           end;
        end;
     end;
  end;

  Dec(FRowCount);
  if (FMinRow > FMaxRow) or (FRowCount = 0) then begin
     FMinRow := 0;
     FMaxRow := 0;
     FRowCount := 0;
  end;

end;

function TXLSRowInfoList.GetDefRowInfoBlob: TXLSBlob;
Var
    grbit: Word;
    miyRw: Word;
begin
  grbit := 0;
  miyRw := $00FF;
  if FDefaultRowInfo.FHeightSet then begin
     miyRw := FDefaultRowInfo.FHeight;
  end;

  Result := TXLSBlob.Create(8);
  Result.AddWord($0225);        //Record identifier
  Result.AddWord($0004);        //Number of bytes to follow
  Result.AddWord(grbit);        //Options
  Result.AddWord(miyRw);
end;

function TXLSRowInfoList.GetHeight(Index: integer): Single;
Var R:TXLSRowInfo;
begin
  if (Index < 0) then begin
     //exception
     Result := 0;
  end
  else begin
    R := GetRowInfo(Index);
    if Not(Assigned(R)) then R := FDefaultRowInfo;
    Result := R.Height;
  end;
end;

function TXLSRowInfoList.GetOutlineLevel(Index: integer): integer;
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     //exception
     Result := 1;
  end
  else begin
    R := GetRowInfo(Index);
    if Not(Assigned(R)) then R := FDefaultRowInfo;
    Result := R.OutlineLevel;
  end;
end;

procedure TXLSRowInfoList.SetOutlineLevel(Index: integer; Value: integer);
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     //exception
  end else if (Value >= 1) and (Value <= 8) then begin
    if Value = 1 then begin
       R := GetRowInfo(Index);
    end else begin
       R := GetOrCreateRowInfo(Index);
    end;
    if Assigned(R) then begin
       R.OutlineLevel := Value;
    end;
  end;
end;

function TXLSRowInfoList.AssignedBlock(Index: integer): boolean;
begin
  Result := Assigned(FRows[Index]);
end;


function TXLSRowInfoList.IsHeightSet(Index: integer): boolean;
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     Result := false;
  end
  else begin
    R := GetRowInfo(Index);
    if Not(Assigned(R)) then 
       Result := false
    else
       Result := R.FHeightSet;
  end;
end;

function TXLSRowInfoList.GetHidden(Index: integer): boolean;
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     //exception
     Result := false;
  end
  else begin
    R := GetRowInfo(Index);
    if Not(Assigned(R)) then R := FDefaultRowInfo;
    Result := R.FHidden;
  end;
end;

function TXLSRowInfoList.GetFirstVisible: integer;
begin
  Result := 0;
  while Hidden[Result] do inc(Result);
end;

function TXLSRowInfoList.GetOrDefaultRowInfo(Index: integer): TXLSRowInfo;
begin
  Result := GetRowInfo(Index);
  if Not(Assigned(Result)) then Result := FDefaultRowInfo;
end;

function TXLSRowInfoList.GetOrCreateRowInfo(Index: integer): TXLSRowInfo;
Var row_c, row_b, row_a: Word;
    a: PXLSRows_A;
    b: PXLSRows_B;
begin
  row_c := (Index shr 16) and $0000000F;
  row_b := (Index shr 8) and  $000000FF;

  if not(Assigned(FRows[row_c])) then Create_B(FRows[row_c]);
  b := FRows[row_c];

  if not Assigned(b^[row_b]) then Create_A(b^[row_b]);
  a := b^[row_b];

  row_a := Index and $000000FF;
  if not Assigned(a^[row_a]) then begin
     CreateRowInfo(a^[row_a]);
     if (Index < FMinRow) or (FRowCount = 0) then FMinRow := Index;
     if (Index > FMaxRow) or (FRowCount = 0) then FMaxRow := Index;
     Inc(FRowCount);
  end;

  Result := a^[row_a];
end;

procedure TXLSRowInfoList._SetRowInfo(arow: integer; aheight: word; aisheight: boolean; 
                      axf: integer; aisxf: boolean; aisHidden: boolean;
                      aoutlinelevel: byte; unsynced: boolean);
Var RInfo: TXLSRowInfo;
begin
  if (arow >= 0) {and (arow <= 64535)} then begin
     RInfo := GetOrCreateRowInfo(arow);
     if Assigned(RInfo) then begin
        RInfo.FHeight := aheight;
        RInfo.FHeightSet := aisheight;
        if axf = $FFF then aisxf := false;
        if aisxf then  begin
           RInfo.FXFIndex := axf;
           FXFList.IncReferredCount(axf);
        end else begin
           RInfo.FXFIndex := 0;
        end;
        RInfo.FXFIndexSet:= aisxf;
        RInfo.FHidden := aishidden;
        RInfo.OutlineLevel := aoutlinelevel;
        RInfo.FUnsynced := unsynced; 
     end;
  end; 
end;

function TXLSRowInfoList.GetRowInfo(Index: integer): TXLSRowInfo;
Var
  a: PXLSRows_A;
  b: PXLSRows_B;
  row_c, row_b, row_a: integer;
begin
  row_c := (Index shr 16) and $0000000F;
  Result := nil;
  if Index >= 0 then begin
     b := FRows[row_c];

     if Assigned(b) then begin
        row_b := (Index shr 8)  and $000000FF;
        a := b^[row_b];
        if Assigned(a) then begin
           row_a := Index and $000000FF;
           Result := a^[row_a]; 
        end;
     end;
  end;
end;

function TXLSRowInfoList.GetRowInfoBlob(Index: integer): TXLSBlob;
Var RowInfo: TXLSRowInfo;
    grbit: Word;
    ixfe: Word;
    miyRw: Word;
    //SetRowHeight: boolean;
    ollevel: byte;
    colmin, colmax: integer;
begin
  grbit := $0100;
  ixfe := $000F;
  miyRw := $00FF;
  //SetRowHeight := false;
  colmin := -1;
  colmax := -1;

  RowInfo := GetRowInfo(Index);
  if Assigned(RowInfo) then begin
     if RowInfo.FXFIndexSet then begin
        if RowInfo.FXFIndex > 0 then ixfe := FXFList.SaveIndex[RowInfo.FXFIndex] - 1
        else ixfe := 0;
        grbit := grbit or $80;
     end;
     if RowInfo.FHidden then begin
        grbit := grbit or $20;
     end;
     if RowInfo.FHeightSet then begin
        miyRw := RowInfo.FHeight;
        if not(RowInfo.FHidden) and RowInfo.FUnsynced then grbit := grbit or $40;
        //SetRowHeight := true;
     end;
     ollevel := OutlineLevel[Index];
     grbit := grbit or ((ollevel - 1) and $07);

     if ((OutlineLevel[index - 1] <> ollevel) or
         (OutlineLevel[index + 1] <> ollevel)) then begin
         grbit := grbit or $10;
     end;
     if MaxOutlineLevel < (ollevel - 1) then MaxOutlineLevel := ollevel - 1;
     colmin := RowInfo.MinCol;
     colmax := RowInfo.MaxCol;
  end;

  if colmin < 0 then colmin := 0;
  if colmax > XLSMaxCol then colmax := XLSMaxCol;

  //if not(SetRowHeight) then miyRw := miyRw or $8000;

  Result := TXLSBlob.Create(20);
  Result.AddWord($0208);        //Record identifier
  Result.AddWord($0010);        //Number of bytes to follow
  Result.AddWord(Index);          //row
  Result.AddWord(colmin);        //colMic First defined column
  Result.AddWord(colmax + 1);    //colMac Last defined column + 1
  Result.AddWord(miyRw);
  Result.AddWord($0000);        //irwMac Used by Excel to optimise loading
  Result.AddWord($0000);        //Reserved
  Result.AddWord(grbit);        //Options: fUnsynced
  Result.AddWord(ixfe);         //XF index
end;

function TXLSRowInfoList.GetXF(Index: integer): integer;
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     //exception
     Result := 0;
  end
  else begin
    R := GetRowInfo(Index);
    if Not(Assigned(R)) then R := FDefaultRowInfo;
    if (R.FXFIndexSet) then Result := R.FXFIndex
                       else Result := 0;
  end;
end;

procedure TXLSRowInfoList.SetHeight(Index: integer; const Value: Single);
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     //exception
  end
  else begin
    R := GetOrCreateRowInfo(Index);
    if Assigned(R) then begin
       R.Height := Value;
    end;
  end;
end;

procedure TXLSRowInfoList.SetHidden(Index: integer; const Value: boolean);
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     //exception
  end
  else begin
    R := GetOrCreateRowInfo(Index);
    if Assigned(R) then R.FHidden := Value;
  end;
end;

procedure TXLSRowInfoList.SetXF(Index: integer; const Value: integer);
Var R:TXLSRowInfo;
begin
  if {(Index > 65535) or }(Index < 0) then begin
     //exception
  end
  else begin
    R := GetOrCreateRowInfo(Index);
    if Assigned(R) then begin
       FXFList.ReplaceIndex(R.FXFIndex, Value);
       R.FXFIndex := Value;
       R.FXFIndexSet := true;
    end;
  end;
end;

procedure TXLSRowInfoList.CopyRowFormat(dstrow: integer; SrcRowInfo:TXLSRowInfo);
Var DstRowInfo:TXLSRowInfo;
begin

  DstRowInfo := GetRowInfo(dstrow);
  if Not(Assigned(DstRowInfo)) then begin
     if Assigned(SrcRowInfo)  then DstRowInfo := GetOrCreateRowInfo(dstrow);
  end;

  if Assigned(DstRowInfo) then begin

     if not(Assigned(SrcRowInfo)) and (DstRowInfo.MinCol < 0) then begin
        DeleteRow(dstrow);
     end else begin

        if not(Assigned(SrcRowInfo)) then begin
           SrcRowInfo := FDefaultRowInfo;
        end;

        FXFList.ReplaceIndex(DstRowInfo.FXFIndex, SrcRowInfo.FXFIndex); 
        DstRowInfo.FXFIndex := SrcRowInfo.FXFIndex;
        DstRowInfo.FXFIndexSet := SrcRowInfo.FXFIndexSet;
        DstRowInfo.FHidden := SrcRowInfo.FHidden;
        DstRowInfo.FHeight := SrcRowInfo.FHeight;
        DstRowInfo.FHeightSet :=  SrcRowInfo.FHeightSet;
        DstRowInfo.FOutlineLevel := SrcRowInfo.FOutlineLevel;
     end;
  end;

end;


procedure TXLSRowInfoList.SetStdHeight(const Value: Single);
begin FDefaultRowInfo.Height := Value end;

function TXLSRowInfoList.GetStdHeight: Single;
begin Result := FDefaultRowInfo.Height end;


procedure TXLSRowInfoList.CalcMaxOutlineLevel;
Var row_c, row_b, row_a: Word;
    b: PXLSRows_B;
    a: PXLSRows_A;
begin
  FMaxOutlineLevel := 0;
  for row_c := 0 to $0000000F do begin
    if Assigned(FRows[row_c]) then begin
       b := FRows[row_c];
       for row_b := 0 to $000000FF do begin
         if Assigned(b^[row_b]) then begin
            a := b^[row_b];
            for row_a := 0 to $000000FF do begin
               if Assigned(a^[row_a]) then begin
                  if a^[row_a].OutlineLevel > FMaxOutlineLevel then FMaxOutlineLevel := a^[row_a].OutlineLevel;
               end;
            end;
         end;
       end;
    end;
  end;
  if FMaxOutLineLevel > 0 then Dec(FMaxOutLineLevel);
end;

function TXLSRowInfoList.FindNextRow(StartIndex: integer; var rowinfo: TXLSRowInfo): integer;
var row_c, row_b, row_a: word;
    sc, sb, sa: word;
    b: PXLSRows_B;
    a: PXLSRows_A;
begin
  Result := -1;
  if (StartIndex < 0) or (StartIndex > $FFFFF) then exit;
  sc := (StartIndex shr 16) and $000F;
  sb := (StartIndex shr  8) and $00FF;
  sa := (StartIndex)        and $00FF;
  for row_c := sc to $000F do begin
    if Assigned(FRows[row_c]) then begin
       b := FRows[row_c];
       for row_b := sb to $00FF do begin
         if Assigned(b^[row_b]) then begin
            a := b^[row_b];
            for row_a := sa to $00FF do begin
               if Assigned(a^[row_a]) then begin
                  rowinfo := a^[row_a];  
                  Result := row_a or (row_b shl 8) or (row_c shl 16);
                  break;
               end;
            end;
         end;
         sa := 0;
         if Result >= 0 then break;
       end;
    end;
    sb := 0;
    if Result >= 0 then break;
  end;
end;

end.
