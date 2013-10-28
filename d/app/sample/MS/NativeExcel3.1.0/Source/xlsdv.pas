//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsdv
//       
//      Description:  Data validation
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

unit xlsdv;

{$Q-}
{$R-}

interface
uses xlshash, xlsblob, xlscalc, xlsescher;

type

   TDVRange = class
   private
      FRow1, FCol1, FRow2, FCol2: integer;
      procedure SetRange(row1, col1, row2, col2: integer);
   public
      constructor Create(row1, col1, row2, col2: integer); overload;
      constructor Create(Range: TDVRange); overload;
      function IsContainRow(row: integer): boolean;
      function IsContainRange(row1, col1, row2, col2: integer): boolean;
      procedure ExtendRange(Range: TDVRange); 
      function ShiftRange(drow, dcol: integer): boolean;
      function AddData(data: TXLSBlob): integer;
      property Row1: integer read FRow1;
      property Row2: integer read FRow2;
      property Col1: integer read FCol1;
      property Col2: integer read FCol2;
   end;

   TDVRangeList = class
   private
      FTotalRange: TDVRange;
      FRanges: TObjectArray;
      procedure RebuildTotalRange;
      function GetIsEmpty: boolean;
      function  GetItem(i: integer): TDVRange;
      function GetCount: integer;
      procedure AddRange(item: TDVRange); 
      function SplitRange(SrcRange: TDVRange; 
               row1, col1, row2, col2: integer; 
              var NewRanges: TObjectArray): boolean;
      function MoveRange(SrcRange: TDVRange; 
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
      function Parse(data: TXLSBlob; Var offset: longword): integer;
      function GetDataSize: integer;
      function Store(data: TXLSBlob): integer;
      property Range[i: integer]: TDVRange read GetItem; default;
      property IsEmpty: boolean read GetIsEmpty;
      property Count: integer read GetCount;
   end;

   TDataValidation = class
   private
      FRanges: TDVRangeList;
      FOptions: Longword;
      FPromtBoxTitle: WideString;
      FErrorBoxTitle: WideString;
      FPromtBoxText: WideString;
      FErrorBoxText: WideString;

      FFormula1: TXLSCompiledFormula;
      FFormula2: TXLSCompiledFormula;	  
      function GetIsEmpty: boolean;
   public
      constructor Create();
      destructor Destroy(); override;
      procedure ClearRow(row: integer);
      procedure ClearCol(col: integer);
      procedure ClearRange(row1, col1, row2, col2: integer);

      procedure MoveRanges(row1, col1, row2, col2: integer;
                          drow, dcol: integer);
      function Parse(DList: TXLSBlobList; 
                         calculator: TXLSCalculator): integer;
      function Store(DList: TXLSBlobList; 
                         calculator: TXLSCalculator;
                         sheetid: integer): integer;
      property IsEmpty: boolean read GetIsEmpty;
   end;

   TDataValidator = class
   private
      FArr: TObjectArray;
      FCalculator: TXLSCalculator;
      FSheetID: integer;
      FOption: Word;
      FHorPos: Longword;
      FVerPos: Longword;
      FDrawing: TMSODrawing;
      function GetCount: integer;
      procedure ClearRowCol(row: integer; col: integer);
      function StoreDVHeader(DList: TXLSBlobList): integer;
   public
      constructor Create(sheetid: integer; Calculator: TXLSCalculator; ADrawing: TMSODrawing);
      destructor Destroy(); override;

      function Parse(RecID: word; datalist: TXLSBlobList): integer;
      function Store(DList: TXLSBlobList): integer;

      procedure ClearRow(row: integer);
      procedure ClearCol(col: integer);
      procedure ClearRange(row1, col1, row2, col2: integer);
      procedure MoveRange(row1, col1, row2, col2: integer; drow, dcol:
              integer);

      property Count: integer read GetCount;
   end;


implementation

const
    dvHeaderRecID = $01B2;
    dvRecID = $01BE;

{TDVRange}
constructor TDVRange.Create(row1, col1, row2, col2: integer);
begin
  inherited Create();
  SetRange(row1, col1, row2, col2);
end; 

constructor TDVRange.Create(Range: TDVRange);
begin
  inherited Create();
  SetRange(Range.Row1, Range.Col1, Range.Row2, Range.Col2);
end;

procedure TDVRange.SetRange(row1, col1, row2, col2: integer);
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

function  TDVRange.IsContainRow(row: integer): boolean;
begin
   Result := (Row1 >= row) and (Row2 <= row);
end;

function TDVRange.ShiftRange(drow, dcol: integer): boolean;
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

function TDVRange.IsContainRange(row1, col1, row2, col2: integer): boolean;
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

procedure TDVRange.ExtendRange(Range: TDVRange); 
begin
   if Range.Row1 < FRow1 then FRow1 := Range.Row1;
   if Range.Row2 > FRow2 then FRow2 := Range.Row2;
   if Range.Col1 < FCol1 then FCol1 := Range.Col1;
   if Range.Col2 > FCol2 then FCol2 := Range.Col2;
end;

function TDVRange.AddData(data: TXLSBlob): integer;
begin
    data.AddWord(FRow1);
    data.AddWord(FRow2);
    data.AddWord(FCol1);
    data.AddWord(FCol2);
    Result := 1;
end;

{TDVRangeList}
constructor TDVRangeList.Create;
begin
  FTotalRange := nil;
  FRanges := TObjectArray.Create(false);
end;

destructor TDVRangeList.Destroy();
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

  inherited Destroy;
end;

procedure TDVRangeList.RebuildTotalRange;
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
             FTotalRange := TDVRange.Create(Range[i]);
          end;
      end; 
  end;
end;

function TDVRangeList.GetIsEmpty: boolean;
begin
   Result := not(Assigned(FTotalRange));
end;


function TDVRangeList.GetCount: integer;
begin
    Result := FRanges.Count;
end;

function TDVRangeList.GetItem(i: integer): TDVRange;
var val: TObject;
begin
   val := FRanges[i];
   if Assigned(val) then
      Result := TDVRange(val)
   else 
      Result := nil;
end;

procedure TDVRangeList.AddRange(item: TDVRange); 
begin
    FRanges[FRanges.Count] := item;
end;

function TDVRangeList.SplitRange(SrcRange: TDVRange; row1, col1,
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
          NewRanges[cnt] := TDVRange.Create(srcrow1,
                  srccol1, row1 - 1, srccol2);
          srcrow1 := row1;
          cnt := cnt + 1;
      end;
      //2.Range
      if (col2 >= 0) and (srcrow1 <= srcrow2) and (col2 < srccol2) then begin
          NewRanges[cnt] := TDVRange.Create(srcrow1, col2 + 1,
                  srcrow2, srccol2);
          srccol2 := col2;
          cnt := cnt + 1;
      end;
      //3.Range
      if (row2 >= 0) and (row2 < srcrow2) and (srcrow1 <= srcrow2) and
         (srccol1 <= srccol2) then begin
          NewRanges[cnt] := TDVRange.Create(row2 + 1, srccol1,
                  srcrow2, srccol2);
          srcrow2 := row2;
          cnt := cnt + 1;
      end;
      //4.Range
      if (col1 >= 0) and (col1 >= srccol1) and (srcrow1 <= srcrow2) and
         (srccol1 <= srccol2) then begin
          NewRanges[cnt] := TDVRange.Create(srcrow1, srccol1,
                  srcrow2, col1 - 1);
      end;

   end;

end;

function TDVRangeList.MoveRange(SrcRange: TDVRange; 
         row1, col1, row2, col2: integer; 
         drow, dcol: integer;
         var NewRanges: TObjectArray): boolean;
var
    srcrow1, srcrow2, srccol1, srccol2: integer;
    r: TDVRange;
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
         r := TDVRange.Create(srcrow1, srccol1, 
                                srcrow2, srccol2);
         if r.ShiftRange(drow, dcol) then begin
            NewRanges[NewRanges.Count] := r;
         end else begin
            r.Free;
         end;
      end;
   end;
end;



procedure TDVRangeList.ClearRow(row: integer);
begin
   ClearRange(row, -1, row, -1);
end;
 

procedure TDVRangeList.ClearCol(col: integer);
begin
   ClearRange(-1, col, -1, col);
end;

procedure TDVRangeList.ClearRange(row1, col1, row2, col2: integer);
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

procedure TDVRangeList.MoveRanges(row1, col1, row2, col2: integer;
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

function TDVRangeList.GetDataSize: integer;
begin
    Result := (Count * 8) + 2;
end;

function TDVRangeList.Parse(data: TXLSBlob; Var offset: longword): integer;
var cnt, i: integer;
    r1, r2, c1, c2: integer;
    range: TDVRange;
begin
    Result := 1;
    cnt := data.GetWord(offset); Inc(offset, 2);
    if cnt > 0 then begin
        for i := 1 to cnt do begin
           r1 := data.GetWord(offset);
           r2 := data.GetWord(offset + 2);
           c1 := data.GetWord(offset + 4);
           c2 := data.GetWord(offset + 6);
           range := TDVRange.Create(r1, c1, r2, c2);
           AddRange(range);
           offset := offset + 8;
        end;
    end;
    RebuildTotalRange();
end;

function TDVRangeList.Store(data: TXLSBlob): integer;
var cnt, i: integer;
    lrange: TDVRange;
begin
   cnt := Count;
   data.AddWord(cnt);
   if cnt > 0 then begin
      for i := 0 to cnt - 1 do begin
          lrange := Range[i];
          data.AddWord(lrange.Row1); 
          data.AddWord(lrange.Row2); 
          data.AddWord(lrange.Col1); 
          data.AddWord(lrange.Col2); 
      end;
   end;
   Result := 1;
end;


{TDataValidation}
constructor TDataValidation.Create();
begin
   inherited Create;
   FRanges   := TDVRangeList.Create();
end;

destructor TDataValidation.Destroy(); 
begin
   FFormula1.Free;
   FFormula2.Free;
   FRanges.Free;
   inherited Destroy;
end;

procedure TDataValidation.ClearRow(row: integer);
begin
   ClearRange(row, -1, row, -1);
end;
 

procedure TDataValidation.ClearCol(col: integer);
begin
   ClearRange(-1, col, -1, col);
end;

procedure TDataValidation.ClearRange(row1, col1, row2, col2: integer);
begin
    if Assigned(FRanges) then
       FRanges.ClearRange(row1, col1, row2, col2);
end;

procedure TDataValidation.MoveRanges(row1, col1, row2, col2: integer;
                                drow, dcol: integer);
begin
    if Assigned(FRanges) then
       FRanges.MoveRanges(row1, col1, row2, col2, drow, dcol);
end;


function TDataValidation.GetIsEmpty: boolean;
begin
   if Assigned(FRanges) then begin
      Result := FRanges.IsEmpty;
   end else begin
      Result := true;
   end;
end;

function TDataValidation.Parse(DList: TXLSBlobList; 
                               calculator: TXLSCalculator): integer;
var data: TXLSBlob;
    offs: longword;      
    fsz1, fsz2: integer;
begin
  Result := 1;
  if DList.Count = 1 then begin
     data := DList[0];

     FOptions := data.GetLong(0); 
     offs := 4;
     FPromtBoxTitle := data.GetBiffString(offs, false, true);
     FErrorBoxTitle := data.GetBiffString(offs, false, true);
     FPromtBoxText  := data.GetBiffString(offs, false, true);
     FErrorBoxText  := data.GetBiffString(offs, false, true);
     fsz1 := data.GetWord(offs); Inc(offs, 2);
     Inc(offs, 2); //unused

     if fsz1 > 0 then begin
         FFormula1 := Calculator.GetTranslatedFormula(data, offs,
                 fsz1, $0600);
         offs := offs + longword(fsz1);
         if not(Assigned(FFormula1)) then Result := -1;
     end;
      
     if Result = 1 then begin 
        fsz2 := data.GetWord(offs); Inc(offs, 2);
        Inc(offs, 2); //unused

        if fsz2 > 0 then begin
           FFormula2 := Calculator.GetTranslatedFormula(data, offs,
                  fsz2, $0600);
           offs := offs + longword(fsz2);
           if not(Assigned(FFormula2)) then Result := -1;
        end;
     end;   

     if Result = 1 then begin
        Result := FRanges.Parse(data, offs); 
     end;   

  end;

end;


function TDataValidation.Store(DList: TXLSBlobList; calculator: TXLSCalculator;
                         sheetid: integer): integer;
var sz: integer;
    fd1: TXLSBlob;
    fs1: integer;
    fd2: TXLSBlob;
    fs2: integer;
    data: TXLSBlob;
    l: integer;
    formulaclass: integer;
begin
    fd1 := nil;
    fd2 := nil;
    fs1 := 0;
    fs2 := 0;
    formulaclass := 1;
    if (FOptions and $0000000F) = 3 then formulaclass := 0;


    try
       if Assigned(FFormula1) then begin
          Calculator.GetStoreDataExt(FFormula1, fd1, 0, 0, sheetid, formulaclass{class});
          if Assigned(fd1) then 
             fs1 := integer(fd1.DataLength) - 2;
       end;

       if Assigned(FFormula2) then begin
          Calculator.GetStoreDataExt(FFormula2, fd2, 0, 0, sheetid, formulaclass{class});
          if Assigned(fd2) then 
             fs2 := integer(fd2.DataLength) - 2;
       end;

       sz := 4 {header} + 4 {options} + 
             fs1 {formula 1} + 2 {size} +
             fs2 {formula 2} + 2 {size} + 
             4 {unused};

       l := Length(FPromtBoxTitle);
       sz := sz + l * 2 + 3; 
       if l = 0 then sz := sz + 1;
       if l = 1 then begin
          if FPromtBoxTitle[1] = #0 then sz := sz - 1;
       end;  

       l := Length(FErrorBoxTitle);
       sz := sz + l * 2 + 3; 
       if l = 0 then sz := sz + 1;
       if l = 1 then begin
          if FErrorBoxTitle[1] = #0 then sz := sz - 1;
       end;  

       l :=  Length(FPromtBoxText);
       sz := sz + l * 2 + 3; 
       if l = 0 then sz := sz + 1;
       if l = 1 then begin
          if FPromtBoxText[1] = #0 then sz := sz - 1;
       end;  

       l :=  Length(FErrorBoxText);
       sz := sz + l * 2 + 3; 
       if l = 0 then sz := sz + 1;
       if l = 1 then begin
          if FErrorBoxText[1] = #0 then sz := sz - 1;
       end;  

       sz := sz + FRanges.GetDataSize();

       
       data := TXLSBlob.Create(sz);
       data.AddWord(dvRecID);
       data.AddWord(sz - 4);

       data.AddLong(FOptions);

       l := Length(FPromtBoxTitle);
       if l = 0 then begin
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else if FPromtBoxTitle[1] = #0 then begin 
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else begin
          data.AddWord(l);
          data.AddByte(1);
          data.AddWideString(FPromtBoxTitle);
       end;

       l := Length(FErrorBoxTitle);
       if l = 0 then begin
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else if FErrorBoxTitle[1] = #0 then begin 
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else begin
          data.AddWord(l);
          data.AddByte(1);
          data.AddWideString(FErrorBoxTitle);
       end;

       l := Length(FPromtBoxText);
       if l = 0 then begin
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else if FPromtBoxText[1] = #0 then begin 
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else begin
          data.AddWord(l);
          data.AddByte(1);
          data.AddWideString(FPromtBoxText);
       end;

       l := Length(FErrorBoxText);
       if l = 0 then begin
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else if FErrorBoxText[1] = #0 then begin 
          data.AddWord(1);
          data.AddByte(0);
          data.AddByte(0);
       end else begin
          data.AddWord(l);
          data.AddByte(1);
          data.AddWideString(FErrorBoxText);
       end;
       
       data.AddWord(fs1); data.AddWord(0);
       if fs1 > 0 then begin
          data.CopyData(fd1, 2, fs1);
       end;

       data.AddWord(fs2); data.AddWord(0);
       if fs2 > 0 then begin
          data.CopyData(fd2, 2, fs2);
       end;
       FRanges.Store(data);

       DList.Append(data);
       Result := sz;

    finally
       fd1.Free;
       fd2.Free;
    end;
end;

{TDataValidator}
constructor TDataValidator.Create(sheetid: integer; Calculator: TXLSCalculator; ADrawing: TMSODrawing);
begin
   inherited Create;
   FSheetId := sheetid;
   FCalculator := Calculator; 
   FArr :=  TObjectArray.Create(false);
   FDrawing := ADrawing;
end;

destructor TDataValidator.Destroy(); 
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

function TDataValidator.GetCount: integer;
begin
  Result := FArr.Count;
end;


function TDataValidator.Parse(RecID: word; datalist: TXLSBlobList): integer;
var item: TDataValidation;
    data: TXLSBlob;
    objid: longword;
    sh: TObject;
begin
  Result := -1;
  if RecID = dvHeaderRecID then begin
     data := datalist[0];
     if Assigned(data) then begin
         FOption := data.GetWord(0);
         FHorPos := data.GetLong(2);
         FVerPos := data.GetLong(6);
         objid := data.GetLong(10);

         if objid <> $FFFFFFFF then begin
            sh := FDrawing.Shapes.ShapeByObjId[objid];
            if Assigned(sh) then begin
               FDrawing.Shapes.DeleteShape(TMsoShapeContainer(sh));
               TMsoShapeContainer(sh).Free;
            end; 
         end;

         Result := 1;
     end;
  end else if RecID = dvRecID then begin
     item := TDataValidation.Create();
     Result := item.Parse(datalist, FCalculator);
     if Result = 1 then begin
        FArr[Count] := item;
     end else begin
        item.Free;
        Result := -1;   
     end;
  end;
end;

function TDataValidator.StoreDVHeader(DList: TXLSBlobList): integer;
var data: TXLSBlob;
begin
   data := TXLSBlob.Create(18 + 4);
   data.AddWord(dvHeaderRecID); 
   data.AddWord(18);
   data.AddWord(FOption);
   data.AddLong(FHorPos);
   data.AddLong(FVerPos);
   data.AddLong($FFFFFFFF);
   data.AddLong(Count);
   DList.Append(data);
   Result := 18 + 4;
end;

function TDataValidator.Store(DList: TXLSBlobList): integer;
var i, cnt: integer;
    item: TDataValidation;
    size: integer;
    ret: integer;
begin
  FCalculator.SetMode('B');
  try
     cnt := Count;
     size := 0;
     if cnt > 0 then begin
        size := StoreDVHeader(DList);
        for i := 0 to cnt - 1 do begin
            item := TDataValidation(FArr[i]);
            ret := item.Store(DList, FCalculator, FSheetID);
            if ret > 0 then size := size + ret;
        end;
     end;
  finally
     FCalculator.SetMode('A');
  end;

  Result := size;
end;

procedure TDataValidator.ClearRow(row: integer);
begin
   ClearRowCol(row, -1);
end;

procedure TDataValidator.ClearCol(col: integer);
begin
   ClearRowCol(-1, col);
end;

procedure TDataValidator.ClearRowCol(row: integer; col: integer);
begin
   ClearRange(row, col, row, col);
end;


procedure TDataValidator.ClearRange(row1, col1, row2, col2: integer);
var i, j, cnt: integer;
    isremove: boolean;     
    NewArr: TObjectArray;
    item: TDataValidation;
begin
     cnt := Count;
     isremove := false;
     if cnt > 0 then begin
        for i := cnt - 1 downto 0 do begin
            item := TDataValidation(FArr[i]);
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
                item := TDataValidation(FArr[i]);
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

procedure TDataValidator.MoveRange(row1, col1, row2, col2: integer;
                                   drow, dcol: integer);
var i, j, cnt: integer;
    isremove: boolean;     
    NewArr: TObjectArray;
    item: TDataValidation;
begin
     cnt := Count;
     isremove := false;
     if cnt > 0 then begin
        for i := cnt - 1 downto 0 do begin
            item := TDataValidation(FArr[i]);
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
                item := TDataValidation(FArr[i]);
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

end.
