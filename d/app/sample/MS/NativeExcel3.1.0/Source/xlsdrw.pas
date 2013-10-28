//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsdrw
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

unit xlsdrw;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses 
{$IFDEF D2012}
     System.Classes, xlshash,
     Vcl.Graphics, System.Types;
{$ELSE}
     classes, xlshash,
     Graphics, {$IFDEF D45}Windows{$ELSE}Types{$ENDIF};   // -----> GC
{$ENDIF}

{$I xlsbase.inc}

type TMsoLineStyle = longword;

type
 TXLSShapes = class;

 TXLSColorFormat = class
 private
   FInterface: TObject;
   FPid: Word;
   function GetColorRGB: Longword;
   procedure SetColorRGB(Value: Longword);
   function GetSchemeColor: Longword;
   procedure SetSchemeColor(Value: Longword);
 public
   constructor Create(AInterface: TObject; APid: Word);
   property RGB: Longword read GetColorRGB write SetColorRGB;
   property SchemeColor: Longword read GetSchemeColor write SetSchemeColor;
 end;

 TXLSLineFormat = class
 private
   FInterface: TObject;
   FForeColor: TXLSColorFormat; 
   FBackColor: TXLSColorFormat; 
   function  GetStyle: TMsoLineStyle;
   procedure SetStyle(Value: TMsoLineStyle);
   function  GetVisible: boolean;
   procedure SetVisible(Value: boolean);
   function  GetWeight: double;
   procedure SetWeight(Value: double);
   function GetForeColor: TXLSColorFormat;
   procedure SetForeColor(Value: TXLSColorFormat);
   function GetBackColor: TXLSColorFormat;
   procedure SetBackColor(Value: TXLSColorFormat);
   function GetDashStyle: LongWord;
   procedure SetDashStyle(Value: Longword);
 public
   constructor Create(AInterface: TObject);
   destructor Destroy; override;
   property Style: TMsoLineStyle read GetStyle write SetStyle;
   property Visible: boolean read GetVisible write SetVisible;
   property Weight: double read GetWeight write SetWeight;
   property ForeColor: TXLSColorFormat read GetForeColor write SetForeColor;
   property BackColor: TXLSColorFormat read GetBackColor write SetBackColor;
   property DashStyle: Longword read GetDashStyle write SetDashStyle;
{
   property DashStyle
}
 end;

 TXLSFillFormat = class
 private
   FInterface: TObject;
   FForeColor: TXLSColorFormat; 
   FBackColor: TXLSColorFormat; 
   function  GetForeColor: TXLSColorFormat;
   procedure SetForeColor(Value: TXLSColorFormat);
   function  GetBackColor: TXLSColorFormat;
   procedure SetBackColor(Value: TXLSColorFormat);
   function  GetVisible: boolean;
   procedure SetVisible(Value: boolean);
 public
   constructor Create(AInterface: TObject);
   destructor Destroy; override;
   procedure Solid;
   property ForeColor: TXLSColorFormat read GetForeColor write SetForeColor;
   property BackColor: TXLSColorFormat read GetBackColor write SetBackColor;
   property Visible: boolean read GetVisible write SetVisible;
 end;

  
 TXLSShape = class
 private
   FParent: TXLSShapes;
   FInterface: TObject;
   FLine: TXLSLineFormat;
   FFill: TXLSFillFormat;
   function GetHeight: Double;
   function GetWidth: Double;
   procedure SetHeight(Value: Double);
   procedure SetWidth(Value: Double);
   function GetLine: TXLSLineFormat;
   function GetFill: TXLSFillFormat;
   function  GetVisible: boolean;
   procedure SetVisible(Value: boolean);
 public
   constructor Create(AInterface: TObject; AParent: TXLSShapes);
   destructor Destroy; override;
   procedure Delete;
   property Height: Double read GetHeight write SetHeight;
   property Width: Double read GetWidth write SetWidth;
   property Line: TXLSLineFormat read GetLine;
   property Fill: TXLSFillFormat read GetFill;
   property Visible: boolean read GetVisible write SetVisible;
   property _Interface: TObject read FInterface;
 end;

 TXLSComment = class
 private
   FInterface: TObject;
   FShape: TXLSShape;
   function GetText: Widestring;
   procedure SetText(Value: Widestring);
   function GetRow: integer;
   function GetCol: integer;
   function GetVisible: boolean;
   procedure SetVisible(Value: boolean);
   property Row: integer read GetRow;
   property Col: integer read GetCol;
 protected 
   procedure SetRow(ARow: integer);
   procedure SetCol(ACol: integer);
 public
   constructor Create(AInterface: TObject);
   destructor Destroy; override;
   property Text: Widestring read GetText write SetText;
   property Shape: TXLSShape read FShape;
   property Visible: boolean read GetVisible write SetVisible;
   property _Interface: TObject read FInterface;
 end;
 
 TXLSComments = class
 private
   FList: TList;
   FRowColHash: THashObject;
   FDrawing: TObject;
   function GetCommentByIndex(Index: integer): TXLSComment; 
//   function GetCommentByRowCol(ARow, ACol: integer): TXLSComment;
   function RowColToKey(ARow, ACol: integer): WideString;
//   procedure RowColRegister(ARow, ACol: integer; AComment: TXLSComment);
   procedure RowColRegister(AComment: TXLSComment);
   procedure RowColUnRegister(ARow, ACol: integer);
   function GetCount: integer;
 public
   constructor Create(ADrawing: TObject);
   destructor Destroy; override;
   function  RegisterComment(AInterface: TObject): TXLSComment;
   function  GetComment(ARow, ACol: integer): TXLSComment;
   function  AddComment(ARow, ACol: integer): TXLSComment;
   procedure ClearComments(ARow1, ACol1, ARow2, ACol2: integer);
   procedure MoveComments(ARow1, ACol1, ARow2, ACol2: integer; drow, dcol: integer);
   property Items[Index: integer]: TXLSComment read GetCommentByIndex; default;
   property Count: integer read GetCount;
 end;

 TXLSPicture = class(TXLSShape)
 private
   procedure SetTransparentColor(Value: Longword);
   function  GetTransparentColor: Longword;     
   function GetTransparentColorDefined: boolean;
   function GetPictureID: integer;
 public
   destructor Destroy; override;
   property TransparentColor: Longword read GetTransparentColor write SetTransparentColor;
   property TransparentColorDefined: boolean read GetTransparentColorDefined;
   procedure ClearTransparentColor;
   property PictureID: integer read GetPictureID;
 end;

 TXLSShapes = class
 private
   FList: TList;
   FDrawing: TObject;
   function GetShapeByIndex(Index: integer): TXLSShape; 
   procedure DeleteShape(AShape: TXLSShape);  
   function  GetCount: integer;
 public
   constructor Create(ADrawing: TObject);
   destructor Destroy; override;
   function   RegisterPicture(AInterface: TObject): TXLSPicture;

   function AddPicture(FileName: WideString): TXLSPicture; overload;
   function AddPicture(Bitmap: {$ifdef D2012}Vcl.Graphics.TBitmap{$else}Graphics.TBitmap{$endif};
                       Transparent: Boolean = false): TXLSPicture; overload;  // -----> GC Add
   function AddPicture(Bitmap: {$ifdef D2012}Vcl.Graphics.TBitmap{$else}Graphics.TBitmap{$endif}; TransparentPixel: TPoint): TXLSPicture; overload; // -----> GC Add

   procedure  Delete;
   property   Items[Index: integer]: TXLSShape read GetShapeByIndex; default;
   property   Count: integer read GetCount;
 end;


implementation
uses  
     xlsdrwtp, xlsescher,
{$IFDEF D2012}
     System.SysUtils;
{$ELSE}
     SysUtils;
{$ENDIF}


{TXLSColorFormat}
constructor TXLSColorFormat.Create(AInterface: TObject; APid: Word);
begin
  inherited Create;
  FInterface := AInterface;
  FPid := APid;
end;

function TXLSColorFormat.GetColorRGB: Longword;
begin
  Result := 0;
  if Assigned(FInterface) then begin
     With TMsoShapeContainer(FInterface) do begin
       Result := Opt.LongValue[FPid];
       if (Result and $08000000) > 0 then begin
          Result := GetCustomColor(GetSchemeColor());
       end;
     end;
  end;
end;

procedure TXLSColorFormat.SetColorRGB(Value: Longword);
begin
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      Opt.LongValue[FPid] := (Value and $00FFFFFF);
    end;
  end;
end;

function TXLSColorFormat.GetSchemeColor: LongWord;
begin
  Result := $FFFFFFFF;
  if Assigned(FInterface) then begin
     With TMsoShapeContainer(FInterface) do begin
       Result := Opt.LongValue[FPid];
       if (Result and $08000000) > 0 then begin
         Result := Result and $00FFFFFF;

         if (Result = 64) or (Result = 65) then
            Result := xlColorIndexAutomatic
         else if Result = 0 then
            Result := xlColorIndexNone
         else if (Result > 7) and (Result < 64) then
            Result := Result - 7;
       end else begin
         Result := $FFFFFFFF;
       end;
     end;
  end;
end;

procedure TXLSColorFormat.SetSchemeColor(Value: LongWord);
Var ColorIndex: LongWord;
    Err: boolean;
begin
  Err := false;
  ColorIndex := 0;
  
  if Value = xlColorIndexAutomatic then
     ColorIndex := 65
  else if (Value = xlColorIndexNone) or (Value = 0) then
     ColorIndex := 0
  else if (Value = 80) then //Tip color
     ColorIndex := 80
  else if Value > 56 then
     //exception
     Err := true
  else
     ColorIndex := Value + 7;

  if not(Err) and Assigned(FInterface) then begin
     With TMsoShapeContainer(FInterface) do begin
       Opt.LongValue[FPid] := (ColorIndex or $08000000);
     end;
  end;
end;


{TXLSLineFormat}
constructor TXLSLineFormat.Create(AInterface: TObject);
begin
  inherited Create;
  FInterface := AInterface;
end;


destructor TXLSLineFormat.Destroy; 
begin
  FForeColor.Free;
  FBackColor.Free;
  inherited Destroy;
end;

function TXLSLineFormat.GetForeColor: TXLSColorFormat;
begin
  if not(Assigned(FForeColor)) then FForeColor := TXLSColorFormat.Create(FInterface, optlineColor);
  Result := FForeColor;
end;

procedure TXLSLineFormat.SetForeColor(Value: TXLSColorFormat);
begin
  ForeColor.RGB := Value.RGB;
end;

function TXLSLineFormat.GetBackColor: TXLSColorFormat;
begin
  if not(Assigned(FBackColor)) then FBackColor := TXLSColorFormat.Create(FInterface, optlineBackColor);
  Result := FBackColor;
end;

procedure TXLSLineFormat.SetBackColor(Value: TXLSColorFormat);
begin
  BackColor.RGB := Value.RGB;
end;


function TXLSLineFormat.GetStyle: TMsoLineStyle;
Var Val: Longword;
begin
  Result := msoLineSingle;
  if Assigned(FInterface) then begin
     With TMsoShapeContainer(FInterface) do begin
       if Opt.isDefined[optLineStyle] then begin
          Val := Opt.LongValue[optLineStyle];
          try Result := TMsoLineStyle(Val)
          except on E:Exception do
          end;
       end;
     end;
  end;
end;

procedure TXLSLineFormat.SetStyle(Value: TMsoLineStyle);
begin
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      Opt.LongValue[optLineStyle] := Value;
    end;
  end;
end;

function TXLSLineFormat.GetVisible: boolean;
Const btMask = $00000008;
Var Val: Longword;
begin
  Result := false;
  if Assigned(FInterface) then begin
     With TMsoShapeContainer(FInterface) do begin
       if Opt.isDefined[optfNoLineDrawDash] then begin
          Val := Opt.LongValue[optfNoLineDrawDash];
          Result := ((Val and btMask) > 0);
       end;
     end;
  end;
end;

procedure TXLSLineFormat.SetVisible(Value: boolean);
Const btMask = $00000008;
Var Val: Longword;
begin
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      if Opt.isDefined[optfNoLineDrawDash] then begin
        Val := Opt.LongValue[optfNoLineDrawDash];
      end else begin
        Val := $00080000;
      end;
      if Value then Val := Val or  btMask
               else Val := Val and not(btMask);
      Opt.LongValue[optfNoLineDrawDash] := Val;
    end;
  end;
end;

function TXLSLineFormat.GetWeight: Double;
Var Val: Longword;
begin
  Val := 9525;
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      if Opt.isDefined[optLineWidth] then begin
        Val := Opt.LongValue[optLineWidth];
      end;
    end;
  end;
  Result := Val / 12700;
end;

procedure TXLSLineFormat.SetWeight(Value: double);
Var Val: Longword;
begin
  if (Value < 0) or (Value > 1584) then begin
    //invalid value
    exit;
  end;
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      Val := trunc(Value * 12700);
      Opt.LongValue[optlineWidth] := Val;
    end;
  end;
end;

function TXLSLineFormat.GetDashStyle: Longword;
begin
  Result := 0;
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      Result := Opt.LongValue[optlineDashing];
      if Result = msoLineSquareDot then begin
        if Opt.isDefined[optlineEndCapStyle] then begin
          if Opt.LongValue[optlineEndCapStyle] = 0 then begin
            Result := msoLineRoundDot;
          end;
        end; 
      end;
    end;
  end;
end;

procedure TXLSLineFormat.SetDashStyle(Value: Longword);
begin
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      if Value = msoLineSquareDot then begin
        Opt.DeleteItem(optlineEndCapStyle);
        Opt.LongValue[optlineDashing]     := 2;
      end else if Value = msoLineRoundDot then begin
        Opt.LongValue[optlineEndCapStyle] := 0;
        Opt.LongValue[optlineDashing]     := 2;
      end else begin
        Opt.DeleteItem(optlineEndCapStyle);
        Opt.LongValue[optlineDashing] := Value;
      end;
    end;
  end;
end;

{TXLSFillFormat}
constructor TXLSFillFormat.Create(AInterface: TObject);
begin
  inherited Create;
  FInterface := AInterface;
end;


destructor TXLSFillFormat.Destroy; 
begin
  FForeColor.Free;
  FBackColor.Free;
  inherited Destroy;
end;

function TXLSFillFormat.GetForeColor: TXLSColorFormat;
begin
  if not(Assigned(FForeColor)) then FForeColor := TXLSColorFormat.Create(FInterface, optFillColor);
  Result := FForeColor;
end;

procedure TXLSFillFormat.SetForeColor(Value: TXLSColorFormat);
begin
  ForeColor.RGB := Value.RGB;
end;

function TXLSFillFormat.GetBackColor: TXLSColorFormat;
begin
  if not(Assigned(FBackColor)) then FBackColor := TXLSColorFormat.Create(FInterface, optFillBackColor);
  Result := FBackColor;
end;

procedure TXLSFillFormat.SetBackColor(Value: TXLSColorFormat);
begin
  BackColor.RGB := Value.RGB;
end;

function  TXLSFillFormat.GetVisible: boolean;
const btMask = $00000010;
var Val: Longword;
begin
  Result := false;
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      if Opt.isDefined[optfNoFillHitTest] then begin
        Val := Opt.LongValue[optfNoFillHitTest];
      end else begin
        Val := $00100000;  //dafault false value
      end;
      Result := ((Val and btMask) = btMask);
    end;
  end;
end;

procedure TXLSFillFormat.SetVisible(Value: boolean);
const btMask = $00000010;
var Val: Longword;
    btVal: Longword;
begin 
  if Value then btVal := $00000010
           else btVal := $00000000;

  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      //Get value
      if Opt.isDefined[optfNoFillHitTest] then begin
        Val := Opt.LongValue[optfNoFillHitTest];
      end else begin
        Val := $00100000;  //dafault false value
      end;
      //Modify and set value
      Val := ((Val and not(btMask)) or btVal);
      Opt.LongValue[optfNoFillHitTest] := Val;
    end;
  end;
end;

procedure TXLSFillFormat.Solid;
begin
  if Assigned(FInterface) then begin
    With TMsoShapeContainer(FInterface) do begin
      Opt.DeleteItem(optfillBlip);      //Remove texture blip
      Opt.DeleteItem(optfillBlipName);  //Remove texture blipname
      Opt.DeleteItem(optfillBlipFlags);  //Remove fillBlipFlags
      Opt.LongValue[optfillType] := 0; //Solid
    end;
  end;
end;

{TXLSShape}

constructor TXLSShape.Create(AInterface: TObject; AParent: TXLSShapes);
begin
  inherited Create;
  FParent := AParent;
  FInterface := AInterface;
end;

destructor TXLSShape.Destroy;
begin
  FLine.Free;
  FFill.Free;
  inherited Destroy;
end;

function TXLSShape.GetHeight: Double;
begin
  Result := TMsoShapeContainer(FInterface).Height;
end;

function TXLSShape.GetWidth: Double;
begin
  Result := TMsoShapeContainer(FInterface).Width;
end;

procedure TXLSShape.SetHeight(Value: Double);
begin
 TMsoShapeContainer(FInterface).Height := Value;
end;

procedure TXLSShape.SetWidth(Value: Double);
begin
 TMsoShapeContainer(FInterface).Width := Value;
end;

procedure TXLSShape.Delete;
begin
  if Assigned(FParent) then FParent.DeleteShape(self);
end;

function TXLSShape.GetLine: TXLSLineFormat;
begin
  if Not(Assigned(FLine)) then FLine := TXLSLineFormat.Create(FInterface);
  Result := FLine;
end;

function TXLSShape.GetFill: TXLSFillFormat;
begin
  if Not(Assigned(FFill)) then FFill := TXLSFillFormat.Create(FInterface);
  Result := FFill;
end;

function  TXLSShape.GetVisible: boolean;
begin
  Result := TMsoShapeContainer(FInterface).Visible;
end;

procedure TXLSShape.SetVisible(Value: boolean);
begin
  TMsoShapeContainer(FInterface).Visible := Value;
end;


{TXLSComment}
function TXLSComment.GetText: Widestring;
begin
  Result := TMsoShapeTextBox(FInterface).Text;
end;

procedure TXLSComment.SetText(Value: Widestring);
begin
  TMsoShapeTextBox(FInterface).Text := Value;
end;

constructor TXLSComment.Create(AInterface: TObject);
begin
  inherited Create;
  FInterface := AInterface;
  FShape := TXLSShape.Create(FInterface, nil);
end;

destructor TXLSComment.Destroy;
begin
  FShape.Free;
  
  inherited Destroy;
end;

function TXLSComment.GetVisible: boolean;
begin
  Result := TMsoShapeTextBox(FInterface).Visible;
end;

procedure TXLSComment.SetVisible(Value: boolean);
begin
  TMsoShapeTextBox(FInterface).Visible := Value;
end;


function TXLSComment.GetRow: integer;
begin
  Result := TMsoShapeTextBox(FInterface).Row;
end;

function TXLSComment.GetCol: integer;
begin
  Result := TMsoShapeTextBox(FInterface).Col;
end;

procedure TXLSComment.SetRow(ARow: integer);
begin
   TMsoShapeTextBox(FInterface).Row := ARow;
end;

procedure TXLSComment.SetCol(ACol: integer);
begin
   TMsoShapeTextBox(FInterface).Col := ACol;
end;


{TXLSComments}
constructor TXLSComments.Create(ADrawing: TObject);
begin
  inherited Create;
  FList := TList.Create;
  FRowColHash := THashObject.Create;
  FRowColHash.FreeOnDestroy := false;
  FDrawing := ADrawing;
end;

destructor TXLSComments.Destroy; 
Var i, cnt: integer;
begin
  FRowColHash.Free;
  cnt := Count;
  if cnt > 0 then begin
     for i := cnt downto 1 do begin
       Items[i].Free;
     end;
  end;
  FList.Free;
  inherited Destroy;
end;

function TXLSComments.RegisterComment(AInterface: TObject): TXLSComment;
begin
  Result := TXLSComment.Create(AInterface);
  FList.Add(Result);
  RowColRegister(Result);
end;

function TXLSComments.GetCommentByIndex(Index: integer): TXLSComment;
begin
  Result := nil;
  if (Index > 0) and (Index <= Count) then begin
     Result := TXLSComment(FList.Items[Index - 1]); 
  end;
end;

function TXLSComments.RowColToKey(ARow, ACol: integer): WideString;
begin
  Result := inttohex(ARow, 6) + inttohex(ACol, 6);
end;

function TXLSComments.GetComment(ARow, ACol: integer): TXLSComment;
begin
  Result := TXLSComment(FRowColHash[RowColToKey(ARow, ACol)]); 
end;

//procedure TXLSComments.RowColRegister(ARow, ACol: integer; AComment: TXLSComment);
//begin
//  FRowColHash[RowColToKey(ARow, ACol)] := AComment;
//end;

procedure TXLSComments.RowColRegister(AComment: TXLSComment);
begin
  FRowColHash[RowColToKey(AComment.Row, AComment.Col)] := AComment;
end;

procedure TXLSComments.RowColUnRegister(ARow, ACol: integer);
begin
  FRowColHash.DeleteKey(RowColToKey(ARow, ACol));
end;

function TXLSComments.AddComment(ARow, ACol: integer): TXLSComment;
Var lInterface: TObject;
begin
  Result := GetComment(ARow, ACol);
  if Not(Assigned(Result)) then begin
     lInterface := TMsoDrawing(FDrawing).AddComment(ARow, ACol);
     if Assigned(lInterface) then begin
        Result := RegisterComment(lInterface);
        //RowColRegister(ARow, ACol, Result);
     end;
  end;
end;

procedure TXLSComments.ClearComments(ARow1, ACol1, ARow2, ACol2: integer);
var i, cnt: integer;
    Comment: TXLSComment;
begin
  cnt := Count;
  if cnt > 0 then begin
    for i := cnt downto 1 do begin
      Comment := Items[i];
      if (Comment.Row >= ARow1) and
         (Comment.Row <= ARow2) and
         (Comment.Col >= ACol1) and
         (Comment.Col <= ACol2) then begin
        FList.Delete(i - 1);
        RowColUnRegister(Comment.Row, Comment.Col);
        TMSODrawing(FDrawing).DeleteShape(TMsoShapeContainer(Comment.FInterface));
        TMsoShapeContainer(Comment.FInterface).Free;
        Comment.Free; 
      end;
    end;
  end; 
end;

procedure TXLSComments.MoveComments(ARow1, ACol1, ARow2, ACol2: integer; drow, dcol: integer);
var i, cnt: integer;
    Comment: TXLSComment;
    arr: TIntegerArray;
    j, arrcnt: integer;
begin
  arr := TIntegerArray.Create;
  cnt := Count;
  arrcnt := 0;
  if cnt > 0 then begin
    for i := cnt downto 1 do begin
      Comment := Items[i];                   
      if (Comment.Row >= ARow1) and
         (Comment.Row <= ARow2) and
         (Comment.Col >= ACol1) and
         (Comment.Col <= ACol2) then begin
        Inc(arrcnt);  
        arr[arrcnt] := i;
        RowColUnRegister(Comment.Row, Comment.Col);
      end;
    end;
  end; 

  if arrcnt > 0 then begin
     for j := 1 to arrcnt do begin
        Comment := Items[arr[j]];
        Comment.SetRow(Comment.Row + drow);
        Comment.SetCol(Comment.Col + dcol);
        RowColRegister(Comment);
        TMsoShapeContainer(Comment.FInterface).Move(drow, dcol);
     end;
  end;

  arr.Free;
end;



function TXLSComments.GetCount: integer;
begin
  Result := FList.Count;
end;



{TXLSPicture}
destructor TXLSPicture.Destroy;
begin
  inherited Destroy;
end;

procedure TXLSPicture.SetTransparentColor(Value: Longword);
begin
  TMsoShapePictureFrame(FInterface).TransparentColor := Value;
end;

function  TXLSPicture.GetTransparentColor: Longword;     
begin
  Result := TMsoShapePictureFrame(FInterface).TransparentColor;
end;

function TXLSPicture.GetPictureID: integer;
begin
  Result := TMsoShapePictureFrame(FInterface).PictureID;
end;

function TXLSPicture.GetTransparentColorDefined: boolean;
begin
  Result := TMsoShapePictureFrame(FInterface).TransparentColorDefined;
end;

procedure TXLSPicture.ClearTransparentColor;
begin
  TMsoShapePictureFrame(FInterface).ClearTransparentColor;
end;

{TXLSPictures}
constructor TXLSShapes.Create(ADrawing: TObject);
begin
  inherited Create;
  FList := TList.Create;
  FDrawing := ADrawing;
end;

destructor TXLSShapes.Destroy; 
Var i, cnt: integer;
begin
  cnt := Count;
  if cnt > 0 then begin
    for i := 1 to cnt do Items[i].Free;
  end;
  FList.Free;
  inherited Destroy;
end;

procedure TXLSShapes.DeleteShape(AShape: TXLSShape);
begin
  if Assigned(AShape) then begin
    TMSODrawing(FDrawing).DeleteShape(TMsoShapeContainer(AShape.FInterface));
    FList.Remove(AShape);
    AShape.Free;
  end;
end;

procedure TXLSShapes.Delete;
var i, cnt: integer;
    Shape: TXLSShape;
begin
  cnt := Count;
  if cnt > 0 then begin
    for i := 1 to cnt do begin
      Shape := FList[i - 1];
      TMSODrawing(FDrawing).DeleteShape(TMsoShapeContainer(Shape.FInterface));
      Shape.Free;
    end;
    FList.Free; 
    FList := TList.Create;
  end;
end;

function TXLSShapes.GetCount: integer;
begin
  Result := FList.Count;
end;

function TXLSShapes.RegisterPicture(AInterface: TObject): TXLSPicture;
begin
  Result := TXLSPicture.Create(AInterface, self);
  FList.Add(Result);
end;

function TXLSShapes.GetShapeByIndex(Index: integer): TXLSShape;
begin
  Result := nil;
  if (Index > 0) and (Index <= Count) then begin
     Result := TXLSShape(FList.Items[Index - 1]); 
  end;
end;

function TXLSShapes.AddPicture(FileName: WideString): TXLSPicture;
Var lInterface: TObject;
begin
  Result := nil;
  if FileExists(FileName) then begin
    lInterface := TMsoDrawing(FDrawing).AddPicture(FileName);
    if Assigned(lInterface) then begin
       Result := RegisterPicture(lInterface);
    end;
  end;
end;

// -----> GC  start	-  Gamma Computer snc Settino T. Italy
function TXLSShapes.AddPicture(Bitmap: {$ifdef D2012}Vcl.Graphics.TBitmap{$else}Graphics.TBitmap{$endif};
                               Transparent: Boolean): TXLSPicture;
Var lInterface: TObject;
begin
  Result := nil;
  lInterface := TMsoDrawing(FDrawing).AddPicture(Bitmap);
  if Assigned(lInterface) then begin
    Result := RegisterPicture(lInterface);
    if Assigned(Result) and Transparent then begin
      Result.TransparentColor := Bitmap.Canvas.Pixels[0, 0];
    end;
  end;
end;

function TXLSShapes.AddPicture(Bitmap: {$ifdef D2012}Vcl.Graphics.TBitmap{$else}Graphics.TBitmap{$endif}; 
                               TransparentPixel: TPoint): TXLSPicture;
begin
  Result := AddPicture(Bitmap);
  if Assigned(Result) then begin
    Result.TransparentColor := Bitmap.Canvas.Pixels[TransparentPixel.X, TransparentPixel.Y];
  end;
end;
 // -----> GC  end	-  Gamma Computer snc Settino T. Italy


end.
