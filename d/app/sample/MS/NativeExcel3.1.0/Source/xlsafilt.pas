//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsafilt
//
//
//      Description: Autofilter
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

unit xlsafilt;
{$Q-}
{$R-}

interface

uses xlsblob;

{$I xlsdef.inc}
{$I xlsbase.inc}

type 

  TXLSAutofilterDOPER = class
  private 
    FDataType: byte;
    FgrbitSgn: byte; 
    FValue: Variant;   
  public
    constructor Create(ADataType: byte; AgrbitSgn: byte; AValue: Variant);
    property DataType: byte read FDataType;
    property grbitSgn: byte read FgrbitSgn;
    property Value: variant read FValue;
  end;

  TXLSAutofilterItem = class
  private
    FShape: TObject;
    FJoin:  byte;
    FTop10: byte;
    FwTop10: Word;
    FDoper1: TXLSAutofilterDOPER;
    FDoper2: TXLSAutofilterDOPER; 
    function GetActive: boolean;
    procedure AddDoperData(Data: TXLSBlob; Doper: TXLSAutofilterDOPER);
    procedure AddDoperExtraData(Data: TXLSBlob; Doper: TXLSAutofilterDOPER; FileFormat:TXLSFileFormat);
    function  ParseData(Data: TXLSBlob; BiffVersion: Word): integer;
    function  ParseDoper(Data: TXLSBlob; Offset: integer; BiffVersion: Word): TXLSAutofilterDOPER;
    
  public
    constructor Create;
    destructor Destroy; override;
    function GetData(index:integer; FileFormat: TXLSFileFormat): TXLSBlob;
    property Shape: TObject read FShape write FShape;
    property Active: boolean read GetActive;
  end;

  TXLSAutofilter = class
  private
     FFieldCount: integer;
     FFirstRow: integer;
     FFirstCol: integer;
     FLastRow: integer;
     FLastCol: integer;
     FDrawing: TObject;
     FFields: Array of TXLSAutofilterItem; 
     function GetDefined: boolean;
     function GetActive: boolean;
  public
     constructor Create(ADrawing: TObject);
     procedure SetTopLeftField(AStartRow, AStartCol: integer);
     procedure SetFieldCount(AFieldCount: integer);
     procedure SetAutofilterShape(ARow, ACol: integer; AShape: TObject);
     procedure Clear(ADeleteShapes: boolean);
     procedure Add(ARow1, ACol1, ARow2, ACol2: integer);

     destructor  Destroy; override;
     function GetDataFilterMode(FileFormat: TXLSFileFormat): TXLSBlob;
     function GetData(FileFormat: TXLSFileFormat): TXLSBlob;
     function AddAutofilterData(Datalist: TXLSBlobList; var Size: longword; FileFormat: TXLSFileFormat): integer;
     function ParseAutofilterData(Data: TXLSBlob; BiffVersion: Word): integer;
     
     property Defined: boolean read GetDefined;
     property Active: boolean read GetActive;
     property FieldCount: integer read FFieldCount;
     property FirstRow: integer read FFirstRow; 
     property FirstCol: integer read FFirstCol; 
     property LastRow: integer read FLastRow; 
     property LastCol: integer read FLastCol; 

  end;

implementation

uses xlsescher;


const 

  //TXLSAutofilterDOPER.FDataType values
  vtNotUsed           = $00; //Filter condition not used
  vtRKNumber          = $02; //RK number
  vtIEEENumber        = $04; //IEEE number
  vtString            = $06; //String
  vtBool              = $08; //Boolean or error value
  vtMatchAllBlanks    = $0C; //Match all blanks
  vtMatchAllNonBlanks = $0E; //Match all non-blanks

  //TXLSAutofilterDOPER.FgrbitSgn values
  sgn_LT               = $01; // <
  sgn_EQ               = $02; // =
  sgn_LE               = $03; // <=
  sgn_GT               = $04; // >
  sgn_NE               = $05; // <>
  sgn_GE               = $06; // >=

  //FJoin values
  joinAnd              = $01;
  joinOr               = $00;

  //FTop10 Values
  top10NotUsed         = $00;
  top10TopItems        = $01;
  top10BottomItems     = $03;
  top10TopPrcnt        = $05;
  top10BottomPrcnt     = $07;


constructor TXLSAutofilter.Create(ADrawing: TObject);
begin
  FDrawing := ADrawing;
  FFieldCount := 0;
  FFirstRow := -1;
  FFirstCol := -1;
end;  

destructor TXLSAutofilter.Destroy;
begin
  Clear(false);
end;

procedure TXLSAutofilter.Clear(ADeleteShapes: boolean);
var i: integer;
begin
  if FFieldCount > 0 then begin
     for i := 1 to FFieldCount do begin
         if ADeleteShapes then begin 
            if Assigned(FFields[i - 1].Shape) then begin
               TMSODrawing(FDrawing).DeleteShape(TMsoShapeContainer(FFields[i - 1].Shape));
            end;
         end;
         FFields[i - 1].Free();
     end;
     FFieldCount := 0;
     SetLength(FFields, FFieldCount);
  end;
end;


procedure TXLSAutofilter.SetTopLeftField(AStartRow, AStartCol: integer);
begin
  FFirstRow := AStartRow + 1;
  FFirstCol := AStartCol + 1;
end;

procedure TXLSAutofilter.SetFieldCount(AFieldCount: integer);
var i: integer;
begin
  Clear(true);
  FFieldCount := AFieldCount;
  SetLength(FFields, FFieldCount);
  for i := 1 to FFieldCount do begin
      FFields[i - 1] := TXLSAutofilterItem.Create();
  end;
end;

procedure TXLSAutofilter.SetAutofilterShape(ARow, ACol: integer; AShape: TObject);
var i: integer;
begin
  if not(Defined) then begin
     SetTopLeftField(ARow, ACol); 
  end;

  if (ARow + 1) = FFirstRow then begin
     i := ACol - FFirstCol - 1;
     if (i >= 0) and (i < FFieldCount) then begin
        if Assigned(FFields[i].Shape) then begin
           TMSODrawing(FDrawing).DeleteShape(TMsoShapeContainer(FFields[i].Shape));
        end;

        FFields[i].Shape := AShape;
     end;
  end; 

end;

function TXLSAutofilter.GetActive: boolean;
var i: integer;
begin
  Result := false;
  if Defined then begin
     for i := 1 to FFieldCount do begin
         if FFields[i - 1].Active then begin
            Result := true;
            break; 
         end;
     end;
  end;
end;

function TXLSAutofilter.GetDataFilterMode(FileFormat: TXLSFileFormat): TXLSBlob;
var Data: TXLSBlob;
begin
  Result := nil;
  if Active then begin
     Data := TXLSBlob.Create(4);
     Data.AddWord($009B);
     Data.AddWord($0000);
     Result := Data;
  end;
end;


function TXLSAutofilter.GetData(FileFormat: TXLSFileFormat): TXLSBlob;
var Data: TXLSBlob;
begin
  Result := nil;
  if Defined then begin
     Data := TXLSBlob.Create(6);
     Data.AddWord($009D);        //Record identifier
     Data.AddWord($0002);        //Number of bytes to follow
     Data.AddWord(FFieldCount);  //Number of filters
     Result := Data;
  end;
end;

function TXLSAutofilter.AddAutofilterData(Datalist: TXLSBlobList; var Size: longword; FileFormat: TXLSFileFormat): integer;
var i: integer;
    Data: TXLSBlob;  
begin
  for i := 1 to FFieldCount do begin
      if FFields[i - 1].Active then begin
         Data := FFields[i - 1].GetData(i - 1, FileFormat);
         if Assigned(Data) then begin
            Size := Size + Data.GetDataSize;
            DataList.Append(Data);  
         end;
      end;
  end;
  Result := 1;
end;

function TXLSAutofilter.GetDefined: boolean;
begin
  Result :=  (FFieldCount > 0) and (FFirstCol > 0) and (FFirstRow > 0);
end;


procedure TXLSAutofilter.Add(ARow1, ACol1, ARow2, ACol2: integer);
var i: integer;
begin
  if Defined then Clear(true);

  FFirstRow := ARow1;
  FFirstCol := ACol1;
  FLastRow := ARow2;
  FLastCol := ACol2;

  SetFieldCount(ACol2 - ACol1 + 1);
  for i := 1 to FFieldCount do begin
      FFields[i - 1].Shape := TMSODrawing(FDrawing).AddAutofilterShape(ARow1 - 1, ACol1 + i - 1 - 1);
  end;
  
end;


function TXLSAutofilter.ParseAutofilterData(Data: TXLSBlob; BiffVersion: Word): integer;
var index: integer;
begin
  Result := 1;
  index := Data.GetWord(0);
  if index < FFieldCount then begin
     Result := FFields[index].ParseData(Data, BiffVersion);  
  end;
end;



{TXLSAutofilterItem}

constructor TXLSAutofilterItem.Create;
begin
  inherited Create;
  FShape := nil;
  FDoper1 := nil;
  FDoper2 := nil;
  FJoin   := 0;
  FTop10  := 0;
  FwTop10 := 10;
end;

destructor TXLSAutofilterItem.Destroy;
begin
  FDoper1.Free;
  FDoper2.Free;
  inherited destroy;
end;

function TXLSAutofilterItem.GetActive: boolean;
begin
  Result := (FTop10 <> top10NotUsed);
  if not(Result) then begin
     if Assigned(FDoper1) then begin
        Result := (FDoper1.DataType <> vtNotUsed);
     end; 
  end;
end;


procedure TXLSAutofilterItem.AddDoperExtraData(Data: TXLSBlob; Doper: TXLSAutofilterDOPER; FileFormat:TXLSFileFormat);
var str: widestring;
begin
  if Assigned(Doper) then begin
     if Doper.DataType = vtString then begin
        str := Doper.FValue;
        if FileFormat = xlExcel5 then begin
           {$ifdef D2009}
           Data.AddString(AnsiString(str)); 
           {$else}
           Data.AddString(str); 
           {$endif}
        end else begin
           Data.AddByte(1);
           Data.AddWideString(str); 
        end;
     end;
  end;
end;

procedure TXLSAutofilterItem.AddDoperData(Data: TXLSBlob; Doper: TXLSAutofilterDOPER);
var lw_value: Longword;
    str: widestring;
begin
  if Assigned(Doper) then begin
     Data.AddByte(Doper.DataType);
     Data.AddByte(Doper.grbitSgn);
     case Doper.DataType of
        vtNotUsed,
        vtMatchAllBlanks,
        vtMatchAllNonBlanks: 
                       begin
                          Data.AddLong(0); 
                          Data.AddLong(0);
                       end;        
          
           vtRKNumber: begin
                          lw_value := Doper.Value;
                          Data.AddLong(lw_value);
                          Data.AddLong(0);     
                       end;

         vtIEEENumber: begin
                          Data.AddDouble(Doper.Value);
                       end;

             vtString: begin
                          Data.AddLong(0);
                          str := Doper.Value; 
                          Data.AddByte(Length(str));
                          Data.AddWord(0);
                          Data.AddByte(0);      
                       end;

               vtBool: begin
                          Data.AddByte(0); //error flag
                          Data.AddByte(Doper.Value);
                          Data.AddLong(0);
                          Data.AddWord(0);
                       end;             
     end; 
  end else begin
     Data.AddWord(0); Data.AddWord(0);
     Data.AddWord(0); Data.AddWord(0);
     Data.AddWord(0);
  end; 
end;

function TXLSAutofilterItem.ParseData(Data: TXLSBlob; BiffVersion: Word): integer;
var opt: Word;
    offs: integer;
    len: integer;
    wstr: widestring;
begin
   opt := Data.GetWord(2);

   FJoin := opt and 3;
   FTop10 := (opt shr 4) and 3;
   FwTop10 := (opt and $FF80) shr 7;
   FDoper1.Free;
   FDoper2.Free;
   offs := 4;
   FDoper1 := ParseDoper(Data,  offs, BiffVersion);
   offs := offs + 10; 
   FDoper2 := ParseDoper(Data, offs, BiffVersion);
   offs := offs + 10;

   if FDoper1.DataType = vtString then begin
      len := FDoper1.Value;
      if BiffVersion = $0500 then begin
         wstr := widestring(Data.GetString(offs, len));
         offs := offs + len; 
      end else begin
         if Data.GetByte(offs) = 1 then begin
            //widestring
            wstr := Data.GetWideString(offs + 1, len * 2);
            offs := offs + 1 + len * 2;
         end else begin
            wstr := widestring(Data.GetString(offs + 1, len));
            offs := offs + 1 + len;
         end;
      end;
      FDoper1.FValue := wstr;

   end; 

   if FDoper2.DataType = vtString then begin
      len := FDoper2.Value;
      if BiffVersion = $0500 then begin
         wstr := widestring(Data.GetString(offs, len));
         //offs := offs + len; 
      end else begin
         if Data.GetByte(offs) = 1 then begin
            //widestring
            wstr := Data.GetWideString(offs + 1, len * 2);
            //offs := offs + 1 + len * 2;
         end else begin
            wstr := widestring(Data.GetString(offs + 1, len));
            //offs := offs + 1 + len;
         end;
      end;
      FDoper2.FValue := wstr;
   end; 

   Result := 1;
       
end;
 

function TXLSAutofilterItem.ParseDoper(Data: TXLSBlob; Offset: integer; BiffVersion: Word): TXLSAutofilterDOPER;
Var vt, sgn: byte;
    value: variant; 
    {$IFNDEF D45}
    lw_value: Longword;
    {$ENDIF}
    {$IFDEF D45}
    lw_value: integer;
    {$ENDIF}
    db_value: double;
begin
   vt := Data.GetByte(Offset);
   sgn := Data.GetByte(Offset + 1);
   lw_value := 0;
   value := lw_value;
   case vt of
        vtNotUsed,
        vtMatchAllBlanks,
        vtMatchAllNonBlanks: 
                       begin
                         lw_value := 0;
                         value := lw_value;
                       end;        
          
           vtRKNumber: begin
                          lw_value := Data.GetLong(offset + 2);
                          value := lw_value;
                       end;

         vtIEEENumber: begin
                          db_value := Data.GetDouble(offset + 2);
                          value := db_value;
                       end;

             vtString: begin
                          lw_value := Data.GetByte(offset + 2 + 4);
                          value := lw_value;
                       end;

               vtBool: begin
                          lw_value := Data.GetByte(offset + 2 + 1);
                          value := lw_value;
                       end;             
   end;

   Result := TXLSAutofilterDOPER.Create(vt, sgn, value);

end;
 

function TXLSAutofilterItem.GetData(index: integer; FileFormat: TXLSFileFormat): TXLSBlob;
var sz: integer;
    str: WideString;
    opt: Word;
    simple1, simple2: word;
begin
  if Active then begin
     sz := 2 + 2 + 10 + 10;
     if Assigned(FDoper1) then begin
        if FDoper1.DataType =  vtString then begin
           str :=  FDoper1.Value;
           if FileFormat = xlExcel5 then begin
              sz := sz + Length(str);   
           end else begin
              sz := sz + 1 + Length(str) * 2;   
           end; 
        end;
     end;  

     if Assigned(FDoper2) then begin
        if FDoper2.DataType =  vtString then begin
           str :=  FDoper2.Value;
           if FileFormat = xlExcel5 then begin
              sz := sz + Length(str);   
           end else begin
              sz := sz + 1 + Length(str) * 2;   
           end; 
        end;
     end;  

     Result := TXLSBlob.Create(4 + sz);
     Result.AddWord($009E);
     Result.AddWord(sz);
     Result.AddWord(index);
 
     opt := 0;
     opt := opt or FJoin;

     simple1 := 0;
     simple2 := 0;

     if Assigned(FDoper1) then begin
        if (FDoper1.FDataType <> vtNotUsed) and (FDoper1.FgrbitSgn =  sgn_EQ) then begin
           simple1 := 1;  
        end;
     end;  

     if Assigned(FDoper2) then begin
        if (FDoper2.FDataType <> vtNotUsed) and (FDoper2.FgrbitSgn =  sgn_EQ) then begin
           simple2 := 1;  
        end;
     end;  

     opt := opt or (simple1 shl 2);
     opt := opt or (simple2 shl 3);

     if FileFormat = xlExcel97 then begin
        opt := opt or (FTop10 shl 4);
        if FTop10 <> top10NotUsed then begin
           opt := opt or ((FwTop10 shl 7) and $FF80);
        end;
     end; 

     Result.AddWord(opt);

     AddDoperData(Result, FDoper1); 
     AddDoperData(Result, FDoper2); 

     AddDoperExtraData(Result, FDoper1, FileFormat); 
     AddDoperExtraData(Result, FDoper2, FileFormat); 

  end else begin
     Result := nil;
  end;
end;


{TXLSAutofilterDOPER}
constructor TXLSAutofilterDOPER.Create(ADataType: byte; AgrbitSgn: byte; AValue: Variant);
begin
  FDataType := ADataType;
  FgrbitSgn := AgrbitSgn;
  FValue    := AValue;
end;


end.

