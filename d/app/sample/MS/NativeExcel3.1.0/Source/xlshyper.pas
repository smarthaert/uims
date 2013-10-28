//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlshyper
//
//
//      Description:  Hyperlinks
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

unit xlshyper;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses xlsblob;

type 

  TXLSHyperlinkType = (xlHltURL, xlHltUNC, xlHltFile, xlHltNone);

  TXLSCustomHyperlinks = class;

  TXLSCustomHyperlink = class
  private

    FAnchorFirstRow: integer;
    FAnchorLastRow:  integer;
    FAnchorFirstCol: integer;
    FAnchorLastCol:  integer;

    FHyperLinkType:  TXLSHyperLinkType;
    FScreenTip:      WideString;  
    FDisplayText:    WideString;
    FTargetFrame:    WideString;
    FAddress:        WideString;
    FSubAddress:     WideString;
    FParent:         TXLSCustomHyperlinks;
    FIndex:          integer;
    procedure SetHyperLinkType(Addr, SubAddr: WideString);
    procedure SetAddress(Value: WideString);
    procedure SetSubAddress(Value: WideString);
    function  GetDisplayText: WideString;
    procedure SetDisplayText(Value: WideString);
    function  GetDataSize: integer;
//    function  GetDirUpLevel(FullPath: WideString): integer; 
    {$ifdef D2009} 
    function  GetDos83(FPath: WideString): AnsiString; 
    {$else}
    function  GetDos83(FPath: WideString): String; 
    {$endif}
    function  GetData: TXLSBlob;
    function  GetQuickTipData: TXLSBlob;
    procedure RemoveFormatting;
    procedure SetAnchor(FRow, FCol, LRow, LCol: integer);
    function  GetRange: IUnknown;
    procedure SetRange(ARange: IUnknown);
  public
    constructor Create(AParent: TXLSCustomHyperlinks);
    destructor  Destroy; override;
    procedure   Delete;
    property    Address:     WideString read FAddress       write SetAddress;
    property    SubAddress: WideString  read FSubAddress    write SetSubAddress;
    property    ScreenTip:   WideString read FScreenTip     write FScreenTip;
    property    DisplayText: WideString read GetDisplayText write SetDisplayText;    
    property    Range:       IUnknown read GetRange       write SetRange;
  end;

  TXLSCustomHyperlinks = class
  private
    FArr: Array of TXLSCustomHyperlink;
    FCapacity:  integer;
    FCount:     integer;
    FParent:    TObject;
    function    GetHyperLink(Index: integer): TXLSCustomHyperlink;
    procedure   Delete(Index: integer); overload;
    function    Add: TXLSCustomHyperlink; overload;
    procedure   ClearEmpty;
  public
    constructor Create(Parent: TObject);
    destructor  Destroy; override;
    function    Add(Anchor: IUnknown; Address:WideString; SubAddress: WideString=''; ScreenTip:WideString=''; TextToDisplay: Widestring=''): TXLSCustomHyperlink; overload;
    function    Add(r1, c1, r2, c2: integer; AAddress, ALocation, ATooltip, ADisplay: widestring): TXLSCustomHyperlink; overload;
    procedure   Delete; overload;
    procedure   Delete(Range: IUnknown); overload;
    function    GetCount(Range: IUnknown): integer;
    function    GetItem(Range: IUnknown; Index: integer): TXLSCustomHyperlink;
    property    Count: integer read FCount;
    function    Store(List: TXLSBlobList; Var DataSize: longword): integer;
    property    Item[Index: Integer]: TXLSCustomHyperlink read GetHyperLink; default;
    function    Load(Data: TXLSBlob): integer;
    function    LoadQuickTip(Data: TXLSBlob): integer;
    procedure   ClearRange(row1, col1, row2, col2: integer);
    procedure   Move(row1, col1, row2, col2: integer; drow, dcol: integer);
  end;

implementation

uses nexcel, sysutils,
     {$IFDEF D45}
        ComObj,
     {$ELSE}
         Variants,
     {$ENDIF}
     windows;

const 
    CommonGUID: array [1..16] of byte = ($D0, $C9, $EA, $79, 
                                         $F9, $BA, $CE, $11, 
                                         $8C, $82, $00, $AA,
                                         $00, $4B, $A9, $0B);

    URLGUID: array [1..16] of byte = ($E0, $C9, $EA, $79,
                                      $F9, $BA, $CE, $11, 
                                      $8C, $82, $00, $AA, 
                                      $00, $4B, $A9, $0B);
    FileGUID: array [1..16] of byte = ($03, $03, $00, $00, 
                                       $00, $00, $00, $00,
                                       $C0, $00, $00, $00,
                                       $00, $00, $00, $46);
    FileUnknown: array [1..24] of byte =
                                      ($FF, $FF, $AD, $DE, $00, $00, $00, $00,
                                       $00, $00, $00, $00, $00, $00, $00, $00,
                                       $00, $00, $00, $00, $00, $00, $00, $00);

function isintersect(fr1, fc1, lr1, lc1: integer;
                     fr2, fc2, lr2, lc2: integer): boolean;
  function max(v1,v2: integer): integer;
  begin
    if v1 > v2 then result := v1 else result := v2;
  end;

  function min(v1,v2: integer): integer;
  begin
    if v1 < v2 then result := v1 else result := v2;
  end;

begin
  Result := not((max(fr1,lr1) < min(fr2, lr2)) or
                (min(fr1,lr1) > max(fr2, lr2)) or
                (max(fc1,lc1) < min(fc2, lc2)) or
                (min(fc1,lc1) > max(fc2, lc2)))
end;

procedure TXLSCustomHyperlink.SetAddress(Value: WideString);
begin
  SetHyperLinkType(Value, SubAddress);
  FAddress := Value;
end;

procedure TXLSCustomHyperlink.SetSubAddress(Value: WideString);
begin
  SetHyperLinkType(Address, Value);
  FSubAddress := Value;
end;

procedure  TXLSCustomHyperlink.SetHyperLinkType(Addr, SubAddr: WideString);
begin
  Addr := lowercase(Addr);
  if (copy(Addr, 1, 7) = 'http://')  or
     (copy(Addr, 1, 8) = 'https://') or
     (copy(Addr, 1, 8) = 'mailto:')  or
     (copy(Addr, 1, 4) = 'www.')     or
     (copy(Addr, 1, 4) = 'ftp.')     then FHyperLinkType := xlHltURL
  else if (copy(Addr, 1, 2) = '\\')  then FHyperLinkType := xlHltUNC
  else if pos('/', Addr) > 0         then FHyperLinkType := xlHltURL
  else if (Addr = '')                then FHyperLinkType := xlHltNone
  else                                    FHyperLinkType := xlHltFile;
end;

function  TXLSCustomHyperlink.GetDisplayText: WideString;
begin
  Result := FDisplayText;
end;

procedure TXLSCustomHyperlink.SetAnchor(FRow, FCol, LRow, LCol: integer);
Var Tmp: integer;
begin
  if (FRow > LRow) then begin
    Tmp := FRow; 
    FRow := LRow;
    LRow := Tmp;
  end;

  if (FCol > LCol) then begin
    Tmp := FCol; 
    FCol := LCol;
    LCol := Tmp;
  end;

  FAnchorFirstRow := FRow;
  FAnchorLastRow  := LRow;
  FAnchorFirstCol := FCol;
  FAnchorLastCol  := LCol;

  with IXLSWorksheet(FParent.FParent) do begin
    with RCRange[FRow + 1, FCol + 1, LRow + 1, LCol + 1] do begin
      Font.Name := 'Arial';
      Font.Size := 10;
      Font.Bold := false; 
      Font.Italic := false; 
      Font.Underline := xlUnderlineStyleSingle; 
      Font.Color := $FF0000;
    end;
  end;
end;

procedure TXLSCustomHyperlink.SetRange(ARange: IUnknown);
begin
  if Assigned(ARange) then begin
    with IXLSRange(ARange) do begin
      if Worksheet = IXLSWorksheet(FParent.FParent) then begin
         RemoveFormatting;
         SetAnchor(FirstRow, FirstCol, LastRow, LastCol);
      end;
    end;
  end;
end;

procedure TXLSCustomHyperlink.RemoveFormatting;
begin
  with IXLSWorksheet(FParent.FParent) do begin
    with RCRange[FAnchorFirstRow + 1, FAnchorFirstCol + 1, 
                 FAnchorLastRow  + 1, FAnchorLastCol  + 1] do begin
      Font.Name := 'Arial';
      Font.Size := 10;
      Font.Bold := false; 
      Font.Italic := false; 
      Font.Underline := xlUnderlineStyleNone; 
      Font.Color := $000000;
    end;
  end;
end;


procedure TXLSCustomHyperlink.SetDisplayText(Value: WideString);
Var r: IXLSRange;
begin
  FDisplayText := Value;
  with IXLSWorksheet(FParent.FParent) do begin
    r :=  RCRange[FAnchorFirstRow + 1, FAnchorFirstCol + 1,
                  FAnchorLastRow + 1, FAnchorLastCol + 1][1,1];
    {if r.Value = Null then} r.Value := '''' + Value;
  end;
end;

constructor TXLSCustomHyperlink.Create(AParent: TXLSCustomHyperlinks);
begin
  inherited Create;
  FParent := AParent;
end;

destructor  TXLSCustomHyperlink.Destroy;
begin
  inherited Destroy;
end;

procedure   TXLSCustomHyperlink.Delete;
begin
  if Assigned(FParent) then FParent.Delete(FIndex);
end;

function  TXLSCustomHyperlink.GetDataSize: integer;
Var 
   {$ifdef D2009}
   AddressDos83: AnsiString;
   {$else}
   AddressDos83: String;
   {$endif}
begin
  Result := 4  {Record header}+ 
            8  {Range}        + 
            16 {CommonGUID}   + 
            4  {Unknown value}+ 
            4  {Option};

  if FDisplayText  <> '' then Result := Result + 4 + (Length(FDisplayText) + 1) * 2;
  if FTargetFrame  <> '' then Result := Result + 4 + (Length(FTargetFrame) + 1) * 2;

  case FHyperlinkType of
      xlHltURL: begin
                   Inc(Result, 16);
                   Inc(Result, 4 + (Length(FAddress) + 1) * 2);  
                end;
      xlHltUNC: Inc(Result, 4 + (Length(FAddress) + 1) * 2);
     xlHltFile: begin
                  Inc(Result, 16 + 2 + 4);
                  AddressDos83 := GetDos83(FAddress);
                  If AddressDos83 <> '' then Inc(Result, Length(AddressDos83) + 1);  
                  Inc(Result, 24 + 4 + 4 + 2 + Length(FAddress) * 2);
                end;
  end;
  
  if FSubAddress  <> '' then Result := Result + 4 + (Length(FSubAddress) + 1) * 2;

end;

{$ifdef D2009}
function TXLSCustomHyperlink.GetDos83(FPath: WideString): AnsiString; 
{$else}
function TXLSCustomHyperlink.GetDos83(FPath: WideString): String; 
{$endif}
Var //Res: String;
   {$ifdef D2009}
    P: AnsiString;
   {$else}
    P: String;
   {$endif}
begin
   SetLength(Result, 255);
   {$ifdef D2009}
   P := AnsiString(FPath);
   SetLength(Result, GetShortPathNameA(PAnsiChar(P), 
                                      PAnsiChar(Result), 255));
   {$else}
   P := FPath;
   SetLength(Result, GetShortPathName(PChar(P), PChar(Result), 255));
   {$endif}
//   Result := Res;
end;

{function  TXLSCustomHyperlink.GetDirUpLevel(FullPath: WideString): integer; 
Var l: integer;
    ShortPath: WideString;
begin
  Result := 0;
  ShortPath := FullPath;
  l := Length(ShortPath);
  while Copy(ShortPath, 1, 3) = '..\' do begin
    Inc(Result);
    Dec(l, 3);
    ShortPath := copy(ShortPath, 4, l);
  end;
end;}

function  TXLSCustomHyperlink.GetData: TXLSBlob;
Var Sz: integer;
    i :integer;
    Opt: LongWord;
    //DirUpLevel: integer;
    {$ifdef D2009}
    AddressDos83: AnsiString;
    {$else}
    AddressDos83: String;
    {$endif}
    r1, r2, c1, c2: integer;
begin

  r1 := FAnchorFirstRow;
  r2 := FAnchorLastRow;
  c1 := FAnchorFirstCol;
  c2 := FAnchorLastCol;

  if ModifyRangeBiff8(r1, c1, r2, c2) then begin
     Sz := GetDataSize();
  end else begin
     Sz := 0;
  end;

  if Sz > 0 then begin
    Result := TXLSBlob.Create(Sz);
    With Result do begin
       AddWord($01B8);
       AddWord(Sz - 4);   //4

       AddWord(r1);
       AddWord(r2);
       AddWord(c1);
       AddWord(c2);  //8

       for i := 1 to 16 do AddByte(CommonGUID[i]); //16

       AddLong($00000002);                         //4

       Opt := 0; 

       if FDisplayText  <> '' then Opt := Opt or $0014;
       if FTargetFrame  <> '' then Opt := Opt or $0080;

       case FHyperlinkType of 
          xlHltURL:   begin
                        Opt := Opt or $0001;
                        if Copy(Address, 1, 2) <> '..' then Opt := Opt or $0002;
                      end;
          xlHltUNC:   Opt := Opt or $0103;
          xlHltFile:  begin
                        Opt := Opt or $0001;
                        if Copy(Address, 1, 2) <> '..' then Opt := Opt or $0002;
                      end;
       end;

       if (FSubAddress <> '') then Opt := Opt or $0008;

       AddLong(Opt);                      //4
       
       if FDisplayText <> '' then begin
          AddLong(Length(FDisplayText) + 1);
          AddWideString(FDisplayText);
          AddWord(0); 
       end; 

       if FTargetFrame <> '' then begin
          AddLong(Length(FTargetFrame) + 1);
          AddWideString(FTargetFrame);
          AddWord(0); 
       end; 

       case FHyperlinkType of
          xlHltURL:   begin 
                        for i := 1 to 16 do AddByte(URLGUID[i]); //16
                        AddLong((Length(FAddress) + 1) * 2);
                        AddWideString(FAddress);
                        AddWord(0); 
                      end;
          xlHltUNC:   begin
                        AddLong((Length(FAddress) + 1));
                        AddWideString(FAddress);
                        AddWord(0); 
                      end;
          xlHltFile:  begin
                        for i := 1 to 16 do AddByte(FileGUID[i]); //16

                        //DirUpLevel := GetDirUpLevel(FAddress);
                        //AddWord(DirUpLevel);
                        AddWord(0);  

                        AddressDos83 := GetDos83(FAddress);

                        if AddressDos83 = '' then  AddLong(0)
                        else begin
                          AddLong(Length(AddressDos83) + 1);
                          AddString(AddressDos83); AddByte(0); 
                        end;

                        for i := 1 to 24 do AddByte(FileUnknown[i]); //24
                        AddLong(4 + 2 + Length(FAddress) * 2);
                        AddLong(Length(FAddress) * 2);
                        AddByte($03); AddByte($00); 
                        AddWideString(FAddress);      
                      end;
       end;

       if FSubAddress <> '' then begin
           AddLong(Length(FSubAddress) + 1);
           AddWideString(FSubAddress);
           AddWord(0); 
       end; 
       
    end;
  end else
    Result := nil;
end;

function  TXLSCustomHyperlink.GetQuickTipData: TXLSBlob;
Var Sz: integer;
    r1, r2, c1, c2: integer;
begin

  r1 := FAnchorFirstRow;
  r2 := FAnchorLastRow;
  c1 := FAnchorFirstCol;
  c2 := FAnchorLastCol;

  ModifyRangeBiff8(r1, c1, r2, c2);

  Sz := 0;
  if FScreenTip <> '' then begin
     Sz := 4 + 2 + 8 + (Length(FScreenTip) + 1) * 2;
  end;

  if Sz > 0 then begin
    Result := TXLSBlob.Create(Sz);
    With Result do begin
       AddWord($0800);
       AddWord(Sz - 4);   //4
       AddWord($0800);

       AddWord(r1);
       AddWord(r2);
       AddWord(c1);
       AddWord(c2); 
       
       AddWideString(FScreenTip); 
       AddWord($0000);
    end;
  end else
    Result := nil;
end;

function  TXLSCustomHyperlink.GetRange: IUnknown;
begin
  Result := nil;
  if Assigned(FParent) then begin
     if Assigned(FParent.FParent) then begin
        with IXLSWorksheet(FParent.FParent) do begin
           Result := RCRange[FAnchorFirstRow + 1, FAnchorFirstCol + 1, 
                             FAnchorLastRow  + 1, FAnchorLastCol  + 1];
        end;
     end;
  end;
end;


function TXLSCustomHyperlinks.GetHyperLink(Index: integer): TXLSCustomHyperlink;
begin
  if (Index > 0) and (Index <= FCount) then begin
     Result := FArr[Index - 1];
  end else begin
     Result := nil;
  end;
end;

constructor TXLSCustomHyperlinks.Create(Parent: TObject);
begin
  inherited Create;
  FParent := Parent;
end;

destructor TXLSCustomHyperlinks.Destroy;
Var i: integer;
begin
  if FCount > 0 then begin
     for i :=  0 to FCount - 1 do begin
       if Assigned(FArr[i]) then begin
          FArr[i].Free;
          FArr[i] := nil;
       end;
     end;
     FCount := 0;
  end;
  SetLength(FArr, 0);
  inherited Destroy;
end;

function TXLSCustomHyperlinks.Add: TXLSCustomHyperlink;
begin
  Inc(FCount);
  if FCount > FCapacity then begin
     FCapacity := FCapacity + 5;
     SetLength(FArr, FCapacity);
  end;
  FArr[FCount - 1] := TXLSCustomHyperlink.Create(self);
  Result := FArr[FCount - 1];
  Result.FIndex := FCount;  
end;

function TXLSCustomHyperlinks.Add(Anchor: IUnknown; Address: WideString; 
                                                SubAddress: WideString; 
                                                ScreenTip:  WideString; 
                                                TextToDisplay: Widestring): TXLSCustomHyperlink;
begin
  Result := Self.Add();
  if Assigned(Result) then begin
     With IXLSRange(Anchor) do begin
        Result.SetAnchor(FirstRow, FirstCol, LastRow, LastCol);
     end;
     Result.Address := Address;
     Result.SubAddress := SubAddress;
     if TextToDisplay = '' then begin
        TextToDisplay := Address;
        if SubAddress <> '' then begin 
           if (TextToDisplay <> '') then 
               TextToDisplay := TextToDisplay + '#' + SubAddress
           else 
               TextToDisplay := SubAddress;
        end;
     end;
     Result.DisplayText := TextToDisplay;
     Result.ScreenTip := ScreenTip;
  end;
end;


procedure TXLSCustomHyperlinks.Delete(Index: integer);
Var i: integer;
begin
  if (Index > 0) and (Index <= FCount) then begin
     FArr[Index - 1].RemoveFormatting;
     FArr[Index - 1].Free;
     for i := index to FCount - 1 do begin
       FArr[i - 1] := FArr[i];
       Dec(FArr[i - 1].FIndex);
     end;
     FArr[FCount - 1] := nil;
     Dec(FCount);
  end; 
end;

procedure TXLSCustomHyperlinks.Delete;
Var i: integer;
begin
  if FCount > 0 then begin
     for i :=  FCount - 1 downto 0  do begin
       if Assigned(FArr[i]) then Delete(i + 1);
     end;
     FCount := 0;
  end;
end;

procedure  TXLSCustomHyperlinks.Delete(Range: IUnknown);
Var r: IXLSRange;
    i: integer;
begin
  if Assigned(Range) then begin
     r := IXLSRange(Range);
     if r.Worksheet = IXLSWorksheet(FParent) then begin
        if FCount > 0 then begin
           for i := FCount - 1 downto 0 do begin
             if Assigned(FArr[i]) then begin
                if isintersect(FArr[i].FAnchorFirstRow, FArr[i].FAnchorFirstCol,
                               FArr[i].FAnchorLastRow,  FArr[i].FAnchorLastCol,
                               r.firstrow,              r.firstcol,
                               r.lastrow,               r.lastcol) 
                then Delete(i + 1);
             end;
           end;
        end;       
     end;
  end;
end;

function TXLSCustomHyperlinks.GetCount(Range: IUnknown): integer;
Var r: IXLSRange;
    i: integer;
begin
  Result := 0;
  if Assigned(Range) then begin
     r := IXLSRange(Range);
     if r.Worksheet = IXLSWorksheet(FParent) then begin
        if FCount > 0 then begin
           for i := 0 to FCount - 1 do begin
             if Assigned(FArr[i]) then begin
                if isintersect(FArr[i].FAnchorFirstRow, FArr[i].FAnchorFirstCol,
                               FArr[i].FAnchorLastRow,  FArr[i].FAnchorLastCol,
                               r.firstrow,              r.firstcol,
                               r.lastrow,               r.lastcol) 
                then Inc(Result);
             end;
           end;
        end;       
     end;
  end;
end;

function  TXLSCustomHyperlinks.GetItem(Range: IUnknown; Index: integer): TXLSCustomHyperlink;
Var r: IXLSRange;
    i: integer;
begin
  Result := nil;
  if Assigned(Range) and (Index > 0) and (Index <= Count) then begin
     r := IXLSRange(Range);
     if r.Worksheet = IXLSWorksheet(FParent) then begin
        for i := 0 to FCount - 1 do begin
          if Assigned(FArr[i]) then begin
             if isintersect(FArr[i].FAnchorFirstRow, FArr[i].FAnchorFirstCol,
                            FArr[i].FAnchorLastRow,  FArr[i].FAnchorLastCol,
                            r.firstrow,              r.firstcol,
                            r.lastrow,               r.lastcol) 
             then begin
                Dec(Index);
                if Index = 0 then begin  
                   Result := FArr[i];
                   break;
                end; 
             end;
          end;
        end;
     end;
  end;
end;


function TXLSCustomHyperlinks.Store(List: TXLSBlobList; Var DataSize: longword): integer;
Var i: integer;
    D: TXLSBlob;
begin
  Result := 1;
  if FCount > 0 then begin
     for i :=  0 to FCount - 1 do begin
       if Assigned(FArr[i]) then begin
          D := FArr[i].GetData();
          if Assigned(D) then begin
             Inc(DataSize, D.GetBuffSize);
             List.Append(D);
             if FArr[i].ScreenTip <> '' then begin
                D := FArr[i].GetQuickTipData();
                if Assigned(D) then begin
                   Inc(DataSize, D.GetBuffSize);
                   List.Append(D);
                end;
             end; 
          end;
       end;
     end;
  end;
end;

function TXLSCustomHyperlinks.Load(Data: TXLSBlob): integer;
Var D: TXLSBlob;
    fr, fc, lr, lc: integer;
    opt: LongWord;
    offset: longword;
    len: integer;
    descr: widestring;
    targ: widestring; 
    addr: widestring; 
    subaddr: widestring;
    hltype: TXLSHyperlinkType;
    DirUpLevelCount: word;
begin

  D := Data;

  //Range
  fr := D.GetWord(0); lr := D.GetWord(2);
  fc := D.GetWord(4); lc := D.GetWord(6);

  //Option
  opt := D.GetLong(28);
  offset := 32;

  //Description
  if (opt and $14) = $14 then begin
     len := D.GetLong(offset) - 1; 
     descr := D.GetWideString(offset + 4, len * 2);
     Inc(offset, 4 + len * 2 + 2);       
  end;

  //TargetFrame
  if (opt and $80) = $80 then begin
     len := D.GetLong(offset) - 1; 
     targ := D.GetWideString(offset + 4, len * 2);
     Inc(offset, 4 + len * 2 + 2);       
  end; 
  
  hltype := xlHltNone;
  if (opt and $100) = $100 then begin
     //UNC
     hltype := xlHltUNC;
     len := D.GetLong(offset) - 1; 
     addr := D.GetWideString(offset + 4, len * 2);
     Inc(offset, 4 + len * 2 + 2); 
  end else if (opt and $1) = $1 then begin
     //URL or File 
     if D.GetLong(offset) = $79EAC9E0 then begin
        //URL
        Inc(offset, 16);
        hltype := xlHltURL;
        len := D.GetLong(offset); 
        inc(offset, 4);
        if len > 0 then begin
           len := (len div 2) - 1;   
           addr := D.GetWideString(offset, len * 2);
           inc(offset, len * 2 + 2);
        end;
     end else if D.GetLong(offset) = $00000303 then begin
        //Local file
        Inc(offset, 16);
        DirUpLevelCount := D.GetWord(offset);
        Inc(offset, 2);
        len := D.GetLong(offset); 
        Inc(offset, 4);
        if len > 0 then  begin
           addr := widestring(D.GetString(offset, len - 1)); 
           Inc(offset, len);
        end;
        Inc(offset, 24);
        len := D.GetLong(offset); 
        inc(offset, 4);
        if len > 0 then begin
           len := D.GetLong(offset); 
           Inc(offset, 4 + 2);
           if len > 0 then addr := D.GetWideString(offset, len);      
           Inc(offset, len);
        end;

        while DirUpLevelCount > 0 do begin
           addr := '..\' + addr;
           Dec(DirUpLevelCount);
        end; 

        hltype := xlHltFile;
     end;
  end;

  if (opt and $8) = $8 then begin
     len     := D.GetLong(offset) - 1; 
     subaddr := D.GetWideString(offset + 4, len * 2);      
  end;

  with Self.Add() do begin
     FHyperLinkType := hltype;
     
     FAnchorFirstRow := fr;
     FAnchorLastRow  := lr;
     FAnchorFirstCol := fc;
     FAnchorLastCol  := lc;

     FAddress := addr; 
     FSubAddress := subaddr; 
     FDisplayText := descr; 
     FTargetFrame := targ; 
     Result := FIndex;
  end;
  
end;


function TXLSCustomHyperlinks.LoadQuickTip(Data: TXLSBlob): integer;
Var D: TXLSBlob;
    fr, fc, lr, lc: integer;
    len: integer;
begin
  Result := 1;
  D := Data;
  if Count > 0 then begin
     with Item[Count] do begin
        if ScreenTip = '' then begin
           //Range
           fr := D.GetWord(2); lr := D.GetWord(4);
           fc := D.GetWord(6); lc := D.GetWord(8);
           if (fr = FAnchorFirstRow) and 
              (lr = FAnchorLastRow)  and    
              (fc = FAnchorFirstCol) and    
              (lc = FAnchorLastCol)  then begin
              len := (D.GetBuffSize - 12);
              ScreenTip := D.GetWideString(10, len);
           end;   
        end; 
     end;
  end;

end;

//r1, r2, c1, c2: zero-based index of rows/columns
function TXLSCustomHyperlinks.Add(r1, c1, r2, c2: integer; AAddress, ALocation, ATooltip, ADisplay: widestring): TXLSCustomHyperlink;
begin
  Result := Self.Add();
  with Result do begin
     SetHyperLinkType(AAddress, ALocation);
     
     FAnchorFirstRow := r1;
     FAnchorLastRow  := r2;
     FAnchorFirstCol := c1;
     FAnchorLastCol  := c2;

     FAddress := AAddress; 
     FSubAddress := ALocation; 
     FScreenTip := ATooltip;
     FDisplayText := ADisplay; 
  end;
end;

procedure TXLSCustomHyperlinks.ClearEmpty;
Var i: integer;
    idelta: integer;
begin
   idelta := 0;
   for i := 0 to FCount - 1 do begin
      if not(Assigned(FArr[i])) then begin
         Inc(idelta);
      end else begin
         if idelta > 0 then begin
            FArr[i - idelta] := FArr[i];
            Dec(FArr[i - idelta].FIndex, idelta);
            FArr[i] := nil;
         end;
      end;
   end;
   Dec(FCount, idelta);
end;

procedure TXLSCustomHyperlinks.ClearRange(row1, col1, row2, col2: integer);
Var i: integer;
    isdel: boolean;
begin
  isdel := false;
  for i := 0 to FCount - 1 do begin
     if Assigned(FArr[i]) then begin
        if isintersect(FArr[i].FAnchorFirstRow, FArr[i].FAnchorFirstCol,
                            FArr[i].FAnchorFirstRow,  FArr[i].FAnchorFirstCol,
                            row1,              col1,
                            row2,              col2) 
        then begin
           FArr[i].Free;
           FArr[i] := nil;
           isdel := true; 
        end;
     end;
  end;
  if isdel then ClearEmpty;
end;

procedure TXLSCustomHyperlinks.Move(row1, col1, row2, col2: integer; drow, dcol: integer);
Var i: integer;
    isdel: boolean;
    h: TXLSCustomHyperlink;
begin
  isdel := false;
  for i := 0 to FCount - 1 do begin
     if Assigned(FArr[i]) then begin
        h := FArr[i];

        if isintersect(h.FAnchorFirstRow, h.FAnchorFirstCol,
                       h.FAnchorFirstRow,  h.FAnchorFirstCol,
                            row1,              col1,
                            row2,              col2) 
        then begin
           h.FAnchorFirstRow := h.FAnchorFirstRow + drow;
           h.FAnchorLastRow := h.FAnchorLastRow + drow;
           h.FAnchorFirstCol := h.FAnchorFirstCol + dcol;
           h.FAnchorLastCol := h.FAnchorLastCol + dcol;

           if (h.FAnchorFirstRow < 0) or 
              (h.FAnchorLastRow  < 0) or 
              (h.FAnchorLastCol  < 0) or 
              (h.FAnchorFirstCol < 0) or 
              (h.FAnchorFirstRow > XLSMaxRow) or 
              (h.FAnchorLastRow > XLSMaxRow) or 
              (h.FAnchorFirstCol > XLSMaxCol) or 
              (h.FAnchorLastCol > XLSMaxCol)  
           then begin
             h.Free;
             FArr[i] := nil;
             isdel := true; 
           end;
        end;
     end;
  end;

  if isdel then begin
     ClearEmpty;
  end;
end;

end.
