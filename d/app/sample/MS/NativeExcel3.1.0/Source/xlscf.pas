//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlscf
//       
//      Description:  Conditional formatting 
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

unit xlscf;

{$Q-}
{$R-}

interface
uses xlshash, xlsblob, xlscalc;

type

   TCondRange = class
   private
      FRow1, FCol1, FRow2, FCol2: integer;
      procedure SetRange(row1, col1, row2, col2: integer);
   public
      constructor Create(row1, col1, row2, col2: integer); overload;
      constructor Create(Range: TCondRange); overload;
      function IsContainRow(row: integer): boolean;
      function IsContainRange(row1, col1, row2, col2: integer): boolean;
      procedure ExtendRange(Range: TCondRange); 
      function ShiftRange(drow, dcol: integer): boolean;
      function AddData(data: TXLSBlob): integer;
      property Row1: integer read FRow1;
      property Row2: integer read FRow2;
      property Col1: integer read FCol1;
      property Col2: integer read FCol2;
   end;

   TCondFormatRule = class
   private
      FcfType: word;
      FOperator: word;
      FOpt: Longword;
      FFormula1: TXLSCompiledFormula;
      FFormula2: TXLSCompiledFormula;	  
      FFormatData: TXLSBlob;
      function GetFormatBlockSize(opt: longword): integer;
   public 
      constructor Create;
      destructor Destroy; override;
      function Store(DList: TXLSBlobList; 
                         calculator: TXLSCalculator;
                         sheetid: integer): integer;
      function Parse(DList: TXLSBlobList; 
                     calculator: TXLSCalculator): integer;
   end;

   TCondFormat = class
   private
      FTotalRange: TCondRange;
      FRanges: TObjectArray;
      FRules: TObjectArray;
      Fgrbit: Word;
      procedure RebuildTotalRange;
      function GetIsEmpty: boolean;
      function  GetItem(i: integer): TCondRange;
      procedure AddRange(item: TCondRange); 
      procedure AddRule(item: TCondFormatRule); 
      function SplitRange(SrcRange: TCondRange; 
               row1, col1, row2, col2: integer; 
              var NewRanges: TObjectArray): boolean;
      function MoveRange(SrcRange: TCondRange; 
               row1, col1, row2, col2: integer; 
               drow, dcol: integer;
               var NewRanges: TObjectArray): boolean;
   public 
      constructor Create();
      destructor Destroy(); override;

      procedure ClearRow(row: integer);
      procedure ClearCol(col: integer);
      procedure ClearRange(row1, col1, row2, col2: integer);

      procedure MoveRanges(row1, col1, row2, col2: integer;
                          drow, dcol: integer);
      function Store(DList: TXLSBlobList; calculator: TXLSCalculator;
              sheetid: integer): integer;
      function Parse(DList: TXLSBlobList): integer;
      function StoreRules(DList: TXLSBlobList; 
                         calculator: TXLSCalculator;
                         sheetid: integer): integer;
      function ParseRule(DList: TXLSBlobList; 
                         calculator: TXLSCalculator): integer;

      property Range[i: integer]: TCondRange read GetItem; default;
      property IsEmpty: boolean read GetIsEmpty;
   end;


   TCondFormatter = class
   private
      FArr: TObjectArray;
      FCalculator: TXLSCalculator;
      FSheetID: integer;
      FCurCondFormat: TCondFormat;
      function GetCount: integer;
      procedure ClearRowCol(row: integer; col: integer);
   public
      constructor Create(sheetid: integer; Calculator: TXLSCalculator);
      destructor Destroy(); override;

      procedure ClearRow(row: integer);
      procedure ClearCol(col: integer);
      procedure ClearRange(row1, col1, row2, col2: integer);
      procedure MoveRange(row1, col1, row2, col2: integer; drow, dcol:
              integer);
      
      function Store(DList: TXLSBlobList): integer;
      function Parse(RecID: word; datalist: TXLSBlobList): integer;

      property Count: integer read GetCount;
   end;



implementation

const
    cfHeaderRecID = $01B0;
    cfRuleRecID = $01B1;

{TCondRange}
constructor TCondRange.Create(row1, col1, row2, col2: integer);
begin
  inherited Create();
  SetRange(row1, col1, row2, col2);
end; 

constructor TCondRange.Create(Range: TCondRange);
begin
  inherited Create();
  SetRange(Range.Row1, Range.Col1, Range.Row2, Range.Col2);
end;

procedure TCondRange.SetRange(row1, col1, row2, col2: integer);
begin
  if row1 < row2 then begin
     FRow1 := row1;
     FRow2 := row2;
  end else begin
     FRow2 := row1;
     FRow1 := row2;
  end;

  if col1 < col2 then begin
     FCol1 := col1;
     FCol2 := col2;
  end else begin
     FCol2 := col1;
     FCol1 := col2;
  end;
end;

function  TCondRange.IsContainRow(row: integer): boolean;
begin
   Result := (Row1 >= row) and (Row2 <= row);
end;

function TCondRange.ShiftRange(drow, dcol: integer): boolean;
begin
   Result := true;
   FRow1 := FRow1 + drow;
   FRow2 := FRow2 + drow;
   FCol1 := FCol1 + dcol;
   FCol2 := FCol2 + dcol;
   if FCol1 < 0 then FCol1 := 0;
   if FRow1 < 0 then FRow1 := 0;
   if FRow2 < 0 then Result := false;
   if FCol2 < 0 then Result := false;
end;

function TCondRange.IsContainRange(row1, col1, row2, col2: integer): boolean;
var iscontainrows: boolean;
    iscontaincols: boolean;
begin
   iscontainrows := false;
   if (row1 >= 0) and (row2 >= 0) then begin
      if (self.Row1 <= row2) and (self.Row2 >= row1) then begin
          iscontainrows := true;
      end;
   end else begin
      if (row1 < 0) and (row2 < 0) then begin
         iscontainrows := true;
      end else if (row1 < 0) then begin
         iscontainrows := self.Row1 <= row2;
      end else begin
         iscontainrows := self.Row2 >= row1;
      end;
   end;
   iscontaincols := false;

   if (col1 >= 0) and (col2 >= 0) then begin
      if (self.Col1 <= col2) and (self.Col2 >= col1) then begin
          iscontaincols := true;
      end;
   end else begin
      if (col1 < 0) and (col2 < 0) then begin
         iscontaincols := true;
      end else if (col1 < 0) then begin
         iscontaincols := self.Col1 <= col2;
      end else begin
         iscontaincols := self.Col2 >= col1;
      end;
   end;
   Result := iscontainrows and iscontaincols;
end;

procedure TCondRange.ExtendRange(Range: TCondRange); 
begin
   if Range.Row1 < FRow1 then FRow1 := Range.Row1;
   if Range.Row2 > FRow2 then FRow2 := Range.Row2;
   if Range.Col1 < FCol1 then FCol1 := Range.Col1;
   if Range.Col2 > FCol2 then FCol2 := Range.Col2;
end;

function TCondRange.AddData(data: TXLSBlob): integer;
begin
    data.AddWord(FRow1);
    data.AddWord(FRow2);
    data.AddWord(FCol1);
    data.AddWord(FCol2);
    Result := 1;
end;

{TCondFormat}
constructor TCondFormat.Create;
begin
  FTotalRange := nil;
  FRanges := TObjectArray.Create(false);
  FRules := TObjectArray.Create(false);
end;

destructor TCondFormat.Destroy();
var cnt, i: integer;
begin
  FTotalRange.Free;
  cnt := FRanges.Count;
  if cnt > 0 then begin
     for i := 0 to cnt do begin
        FRanges[i].Free;
     end;
  end;
  FRanges.Free;
  cnt := FRules.Count;
  if cnt > 0 then begin
     for i := 0 to cnt do begin
        FRules[i].Free;
     end;
  end;
  FRules.Free;
  inherited Destroy;
end;

procedure TCondFormat.RebuildTotalRange;
var i, cnt: integer;
begin
  FTotalRange.Free;
  FTotalRange := nil;
  cnt := FRanges.Count;
  if cnt > 0 then begin
      for i := 0 to cnt - 1 do begin
          if Assigned(FTotalRange) then begin
             FTotalRange.ExtendRange(Range[i]);
          end else begin
             FTotalRange := TCondRange.Create(Range[i]);
          end;
      end; 
  end;
end;

function TCondFormat.GetIsEmpty: boolean;
begin
   Result := not(Assigned(FTotalRange));
end;


function TCondFormat.GetItem(i: integer): TCondRange;
var val: TObject;
begin
   val := FRanges[i];
   if Assigned(val) then
      Result := TCondRange(val)
   else 
      Result := nil;
end;

procedure TCondFormat.AddRule(item: TCondFormatRule); 
begin
    FRules[FRules.Count] := item;
end;

procedure TCondFormat.AddRange(item: TCondRange); 
begin
    FRanges[FRanges.Count] := item;
end;

function TCondFormat.SplitRange(SrcRange: TCondRange; row1, col1,
        row2, col2: integer; var NewRanges: TObjectArray): boolean;
var cnt: integer;
    srcrow1, srcrow2, srccol1, srccol2: integer;
begin
   Result := false;      
   NewRanges := nil;
   cnt := 0; 
   if SrcRange.IsContainRange(row1, col1, row2, col2) then begin
      Result := true;
      NewRanges := TObjectArray.Create(false);
      srcrow1 := SrcRange.Row1;
      srcrow2 := SrcRange.Row2;
      srccol1 := SrcRange.Col1;
      srccol2 := SrcRange.Col2;
      //1.Range
      if (row1 >= 0) and (row1 > srcrow1) then begin
          NewRanges[cnt] := TCondRange.Create(srcrow1,
                  srccol1, row1 - 1, srccol2);
          srcrow1 := row1;
          cnt := cnt + 1;
      end;
      //2.Range
      if (col2 >= 0) and (srcrow1 <= srcrow2) and (col2 < srccol2) then begin
          NewRanges[cnt] := TCondRange.Create(srcrow1, col2 + 1,
                  srcrow2, srccol2);
          srccol2 := col2;
          cnt := cnt + 1;
      end;
      //3.Range
      if (row2 >= 0) and (row2 < srcrow2) and (srcrow1 <= srcrow2) and
         (srccol1 <= srccol2) then begin
          NewRanges[cnt] := TCondRange.Create(row2 + 1, srccol1,
                  srcrow2, srccol2);
          srcrow2 := row2;
          cnt := cnt + 1;
      end;
      //4.Range
      if (col1 >= 0) and (col1 >= srccol1) and (srcrow1 <= srcrow2) and
         (srccol1 <= srccol2) then begin
          NewRanges[cnt] := TCondRange.Create(srcrow1, srccol1,
                  srcrow2, col1 - 1);
      end;

   end;

end;

function TCondFormat.MoveRange(SrcRange: TCondRange; 
         row1, col1, row2, col2: integer; 
         drow, dcol: integer;
         var NewRanges: TObjectArray): boolean;
var
    srcrow1, srcrow2, srccol1, srccol2: integer;
    r: TCondRange;
begin
   srcrow1 := SrcRange.Row1;
   srcrow2 := SrcRange.Row2;
   srccol1 := SrcRange.Col1;
   srccol2 := SrcRange.Col2;
   Result := SplitRange(SrcRange, row1, col1, row2, col2, NewRanges);
   if Result then begin
      if (row1 >= 0) and (srcrow1 < row1) then
         srcrow1 := row1;
      if (row2 >= 0) and (srcrow2 > row2) then
         srcrow2 := row2;
      if (col1 >= 0) and (srccol1 < col1) then
         srccol1 := col1;
      if (col2 >= 0) and (srccol2 > col2) then
         srccol2 := col2;
      if (srccol1 <= srccol2) and (srcrow1 <= srcrow2) then begin
         r := TCondRange.Create(srcrow1, srccol1, 
                                srcrow2, srccol2);
         if r.ShiftRange(drow, dcol) then begin
            NewRanges[NewRanges.Count] := r;
         end else begin
            r.Free;
         end;
      end;
   end;
end;



procedure TCondFormat.ClearRow(row: integer);
begin
   ClearRange(row, -1, row, -1);
end;
 

procedure TCondFormat.ClearCol(col: integer);
begin
   ClearRange(-1, col, -1, col);
end;

procedure TCondFormat.ClearRange(row1, col1, row2, col2: integer);
var i, cnt: integer;
    j, cntj: integer;
    NewRanges: TObjectArray;
    tmp: TObjectArray;
    tmpcnt: integer;
begin
    if not(isEmpty) then begin
       if FTotalRange.IsContainRange(row1, col1, row2, col2) then begin
          tmp := TObjectArray.Create(false);
          tmpcnt := 0;
          cnt := FRanges.Count;
          for i := cnt - 1 downto 0 do begin
             if SplitRange(Range[i], row1, col1, row2, col2, NewRanges) then
             begin
               cntj := NewRanges.Count;
               if cntj > 0 then begin
                  for j := 0 to cntj - 1 do begin
                     tmp[tmpcnt] := NewRanges[j];
                     Inc(tmpcnt);
                     NewRanges[j] := nil;
                  end;
               end;
               FRanges[i].Free;
               FRanges[i] := nil;
               NewRanges.Free;
             end else begin
               tmp[tmpcnt] := FRanges[i];
               Inc(tmpcnt);
               FRanges[i] := nil;
             end;
          end;
          FRanges.Free;
          FRanges := tmp;
          RebuildTotalRange();
       end;
    end;
end;

procedure TCondFormat.MoveRanges(row1, col1, row2, col2: integer;
                                drow, dcol: integer);
var i, cnt: integer;
    j, cntj: integer;
    NewRanges: TObjectArray;
    tmp: TObjectArray;
    tmpcnt: integer;
begin
    if not(isEmpty) then begin
       if FTotalRange.IsContainRange(row1, col1, row2, col2) then begin
          tmp := TObjectArray.Create(false);
          tmpcnt := 0;
          cnt := FRanges.Count;
          for i := cnt - 1 downto 0 do begin
             if MoveRange(Range[i], row1, col1, row2, col2, 
                          drow, dcol, NewRanges) then
             begin
               cntj := NewRanges.Count;
               if cntj > 0 then begin
                  for j := 0 to cntj - 1 do begin
                     tmp[tmpcnt] := NewRanges[j];
                     Inc(tmpcnt);
                     NewRanges[j] := nil;
                  end;
               end;
               FRanges[i].Free;
               FRanges[i] := nil;
               NewRanges.Free;
             end else begin
               tmp[tmpcnt] := FRanges[i];
               Inc(tmpcnt);
               FRanges[i] := nil;
             end;
          end;
          FRanges.Free;
          FRanges := tmp;
          RebuildTotalRange();
       end;
    end;
end;

function TCondFormat.Store(DList: TXLSBlobList;
        calculator: TXLSCalculator;
        sheetid: integer): integer;
var sz: integer;
    data: TXLSBlob;
    rangecnt: integer;
    rulecnt: integer;
    i: integer;
    size, tmp: integer;
begin
  sz := 4 + 14;
  data := nil;
  rangecnt :=  FRanges.Count;
  rulecnt := FRules.Count;
  size := 0; 
  if rangecnt <= 0 then sz := 0;
  if rulecnt <= 0 then sz := 0;
  if sz > 0  then begin
     try
        sz := sz + rangecnt * 8;
        data := TXLSBlob.Create(sz);
        data.AddWord(cfHeaderRecID);
        data.AddWord(sz - 4);
        data.AddWord(rulecnt);
        data.AddWord(Fgrbit);
        FTotalRange.AddData(data);
        data.AddWord(rangecnt);
        for i := 0 to rangecnt - 1 do begin
           Range[i].AddData(data);  
        end;
        DList.Append(data);
        size := size + sz; 
        data := nil;
     finally
        data.Free;
     end;
     tmp := StoreRules(DList, calculator, sheetid);
     if tmp >= 0 then begin
        size := size + tmp;
     end else begin
        size := -1;
     end;
  end;
  Result := size;
end;


function TCondFormat.Parse(DList: TXLSBlobList): integer;
var data: TXLSBlob;
    cnt: integer;
    i, offs: integer;
    r1,c1,r2,c2: integer;
    range: TCondRange; 
begin
  if DList.Count = 1 then begin
     data := DList[0];
     //cnt := data.GetWord(0);
     Fgrbit := (data.GetWord(2) and $0001);
     offs := 4 + 8;
     cnt := data.GetWord(offs);
     Inc(offs, 2);
     if (cnt > 0) then begin
        for i := 0 to cnt - 1 do begin
           r1 := data.GetWord(offs);
           r2 := data.GetWord(offs + 2);
           c1 := data.GetWord(offs + 4);
           c2 := data.GetWord(offs + 6);
           range := TCondRange.Create(r1, c1, r2, c2);
           AddRange(range);
           offs := offs + 8;
        end;
     end;
     RebuildTotalRange();
  end;
  Result := 1;
end;

function TCondFormat.StoreRules(DList: TXLSBlobList; 
                         calculator: TXLSCalculator;
                         sheetid: integer): integer;
var cnt, i: integer;
    rule: TCondFormatRule;
    ret, size: integer;
begin
    Result := 1;
    size := 0;
    cnt := FRules.Count;
    if cnt > 0 then begin
       for i := 0 to cnt - 1 do begin
           rule := TCondFormatRule(FRules[i]);
           if Assigned(rule) then begin
                ret := rule.Store(DList, calculator, sheetid);
                if ret >= 0 then begin
                   size := size + ret;
                end else begin
                   Result := ret;
                end;
           end else begin
                //    
           end;
           if Result <> 1 then break;
       end;
    end;
    if Result = 1 then Result := size;
end;

function TCondFormat.ParseRule(DList: TXLSBlobList; 
                               calculator: TXLSCalculator): integer;
var rule: TCondFormatRule; 
begin
  if DList.Count = 1 then begin
     rule := TCondFormatRule.Create();
     Result := rule.Parse(DList, calculator);
     if Result = 1 then begin
         AddRule(rule);
     end else begin
         rule.Free;
     end;
  end;
  Result := 1;
end;

constructor TCondFormatter.Create(sheetid: integer; Calculator: TXLSCalculator);
begin
  inherited Create;
  FSheetID := sheetid;
  FCalculator := Calculator;
  FArr := TObjectArray.Create(false);
  FCurCondFormat := nil;
end;

destructor TCondFormatter.Destroy();
var cnt, i: integer;
begin
  cnt := FArr.Count;
  if cnt > 0 then begin
     for i := 0 to cnt do begin
        FArr[i].Free;
     end;
  end;
  FArr.Free;
  inherited Destroy;
end;

procedure TCondFormatter.ClearRow(row: integer);
begin
   ClearRowCol(row, -1);
end;

procedure TCondFormatter.ClearCol(col: integer);
begin
   ClearRowCol(-1, col);
end;

procedure TCondFormatter.ClearRowCol(row: integer; col: integer);
begin
   ClearRange(row, col, row, col);
end;


procedure TCondFormatter.ClearRange(row1, col1, row2, col2: integer);
var i, j, cnt: integer;
    isremove: boolean;     
    NewArr: TObjectArray;
    item: TCondFormat;
begin
     cnt := Count;
     isremove := false;
     if cnt > 0 then begin
        for i := cnt - 1 downto 0 do begin
            item := TCondFormat(FArr[i]);
            item.ClearRange(row1, col1, row2, col2);
            if item.IsEmpty then begin
               item.Free;
               item := nil;
               FArr[i] := item; 
               isremove := true; 
            end; 
        end;
        if isremove then begin
            NewArr := TObjectArray.Create(false);
            j := 0;
            for i := 0 to cnt - 1 do begin
                item := TCondFormat(FArr[i]);
                if Assigned(item) then begin
                   NewArr[j] := item;
                   Inc(j);
                   FArr[i] := nil;
                end;
            end;
            FArr.Free;
            FArr := NewArr;
        end;
     end;
end;

procedure TCondFormatter.MoveRange(row1, col1, row2, col2: integer;
                                   drow, dcol: integer);
var i, j, cnt: integer;
    isremove: boolean;     
    NewArr: TObjectArray;
    item: TCondFormat;
begin
     cnt := Count;
     isremove := false;
     if cnt > 0 then begin
        for i := cnt - 1 downto 0 do begin
            item := TCondFormat(FArr[i]);
            item.MoveRanges(row1, col1, row2, col2, drow, dcol);
            if item.IsEmpty then begin
               item.Free;
               item := nil;
               FArr[i] := item; 
               isremove := true; 
            end; 
        end;
        if isremove then begin
            NewArr := TObjectArray.Create(false);
            j := 0;
            for i := 0 to cnt - 1 do begin
                item := TCondFormat(FArr[i]);
                if Assigned(item) then begin
                   NewArr[j] := item;
                   Inc(j);
                   FArr[i] := nil;
                end;
            end;
            FArr.Free;
            FArr := NewArr;
        end;
     end;
end;

function TCondFormatter.Store(DList: TXLSBlobList): integer;
var i, cnt: integer;
    item: TCondFormat;
    size: integer;
    ret: integer;
begin
  FCalculator.SetMode('B');
  try
     cnt := Count;
     size := 0;
     if cnt > 0 then begin
        for i := 0 to cnt - 1 do begin
            item := TCondFormat(FArr[i]);
            ret := item.Store(DList, FCalculator, FSheetID);
            if ret > 0 then size := size + ret;
        end;
     end;
  finally
     FCalculator.SetMode('A');
  end;
  Result := size;
end;

function TCondFormatter.Parse(RecID: word; datalist: TXLSBlobList): integer;
begin
  Result := -1;
  if RecID = cfHeaderRecID then begin
     FCurCondFormat := TCondFormat.Create();
     Result := FCurCondFormat.Parse(datalist);
     if Result = 1 then begin
        FArr[Count] := FCurCondFormat;
     end else begin
        FCurCondFormat.Free;
        FCurCondFormat := nil;
        Result := -1;   
     end;
  end else if RecID = cfRuleRecID then begin
     if Assigned(FCurCondFormat) then begin
        Result := FCurCondFormat.ParseRule(datalist, FCalculator);      
     end else begin
        Result := -1; 
     end;
  end;
end;


function TCondFormatter.GetCount: integer;
begin
  Result := FArr.Count;
end;

{TCondFormatRule}
constructor TCondFormatRule.Create;
begin
   FFormatData := nil; 
end;

destructor TCondFormatRule.Destroy; 
begin
   FFormatData.Free;    
   FFormula1.Free;
   FFormula2.Free;
   inherited Destroy;
end;


{
Offset Size Contents
0  1 Type of the conditional formatting:
        01H = Compare with current cell value (the comparison specified below is used)
        02H = Evaluate a formula (condition is met if formula evaluates to a value not equal to 0)
1  1 Comparison operator:
        00H = No comparison (only valid for formula type, see above)
        01H = Between      05H = Greater than
        02H = Not between  06H = Less than
        03H = Equal        07H = Greater or equal
        04H = Not equal    08H = Less or equal
2  2 Size of the formula data for first value or formula (sz1)
4  2 Size of the formula data for second value or formula (sz2, used for second part of
       “Between” and “Not between” comparison, this field is 0 for other comparisons)
6  4 Option flags (see below)
10 2 Not used
[12]  118 (optional, only if font = 1, see option flags) Font formatting block, see below
[var]   8 (optional, only if align = 1, see option flags) Alignment formatting block, see below
[var.]  8 (optional, only if bord = 1, see option flags) Border formatting block, see below
[var.]  4 (optional, only if patt = 1, see option flags) Pattern formatting block, see below
[var.]  2 (optional, only if prot = 1, see option flags) Protection formatting block, see below
var.  sz1 Formula data for first value or formula (RPN token array without size field, ?3)
var.  sz2 Formula data for second value or formula (RPN token array without size field, ?3)
}

function TCondFormatRule.GetFormatBlockSize(opt: longword): integer;
begin
    Result := 0;
    if (opt and $04000000) > 0 then Result := Result + 118; //font
    if (opt and $08000000) > 0 then Result := Result + 8;   //align
    if (opt and $10000000) > 0 then Result := Result + 8;   //bord
    if (opt and $20000000) > 0 then Result := Result + 4;   //patt
    if (opt and $40000000) > 0 then Result := Result + 2;   //prot
end;

        
function TCondFormatRule.Store(DList: TXLSBlobList; 
                         calculator: TXLSCalculator;
                         sheetid: integer): integer;
var sz: integer;
    fd1: TXLSBlob;
    fs1: integer;
    fd2: TXLSBlob;
    fs2: integer;
    frmsz: integer;
    data: TXLSBlob;
begin
    fd1 := nil;
    fd2 := nil;
    fs1 := 0;
    fs2 := 0;

    try
       if Assigned(FFormula1) then begin
          Calculator.GetStoreDataExt(FFormula1, fd1, 0, 0, sheetid, 1{value class});
          if Assigned(fd1) then 
             fs1 := integer(fd1.DataLength) - 2;
       end;

       if Assigned(FFormula2) then begin
          Calculator.GetStoreDataExt(FFormula2, fd2, 0, 0, sheetid, 1{value class});
          if Assigned(fd2) then 
             fs2 := integer(fd2.DataLength) - 2;
       end;

       frmsz := GetFormatBlockSize(FOpt); 

       sz := 4  {header} +
             12 {rule header block} +
             frmsz {format block} +
             fs1 + fs2;

       data := TXLSBlob.Create(sz);
       data.AddWord(cfRuleRecID);
       data.AddWord(sz - 4);

       data.AddByte(FcfType);
       data.AddByte(FOperator);
       data.AddWord(fs1);
       data.AddWord(fs2);
       data.AddLong(FOpt);
       data.AddWord(0); //unused 2 bytes

       if frmsz > 0 then begin
          data.CopyData(FFormatData, 0, frmsz);
       end;

       if fs1 > 0 then begin
          data.CopyData(fd1, 2, fs1);
       end;

       if fs2 > 0 then begin
          data.CopyData(fd2, 2, fs2);
       end;

       DList.Append(data);
       Result := sz;

    finally
       fd1.Free;
       fd2.Free;
    end;
end;

function TCondFormatRule.Parse(DList: TXLSBlobList; 
                               calculator: TXLSCalculator): integer;
var data: TXLSBlob;
    fsz1, fsz2: integer;    
    formatsz: integer;
    offs: integer;
begin
  Result := 1;
  if DList.Count = 1 then begin
     data := DList[0];
     FcfType := data.GetByte(0);
     FOperator := data.GetByte(1);
     fsz1 := data.GetWord(2);
     fsz2 := data.GetWord(4);
     FOpt := data.GetLong(6);
     formatsz := GetFormatBlockSize(FOpt);
     offs := 10 + 2;
     if formatsz > 0 then begin
         FFormatData := TXLSBlob.Create(formatsz);
         FFormatData.CopyData(data, offs, formatsz);
         offs := offs + formatsz;
     end;
 
     FFormula1.Free;
     FFormula1 := nil;
     FFormula2.Free;
     FFormula2 := nil;

     if fsz1 > 0 then begin
         FFormula1 := Calculator.GetTranslatedFormula(data, offs,
                 fsz1, $0600);
         offs := offs + fsz1;
         if not(Assigned(FFormula1)) then Result := -1;
     end;

     if (fsz2 > 0) and (Result = 1) then begin
         FFormula2 := Calculator.GetTranslatedFormula(data, offs,
                 fsz2, $0600);
         //offs := offs + fsz2;
         if not(Assigned(FFormula2)) then Result := -1;
     end;

  end;
end;

end.
