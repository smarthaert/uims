//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsExpGr
//
//
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


unit xlsExpGr;
{$Q-}
{$R-}

{$I xlsdef.inc}

interface

uses
  Classes;

type


  TXLSGroupItem = class
  private
    FXLSColumn: integer;
    FFieldName: String;
    FFieldIndex: integer; 
    FFieldValue: Variant;
    FValueAssigned: boolean;
    FRowStart: integer;
  public
     constructor Create(AFieldName: String; AFieldIndex: integer; XlsColumn: integer);
     function GroupChanged(Value: Variant): boolean;
     procedure StartGroup(Row: integer; Value: Variant);
     procedure CloseGroup();
     property ValueAssigned: boolean read FValueAssigned;
     property RowStart: integer read FRowStart write FRowStart;
     property FieldName: string read FFieldName write FFieldName;
     property FieldIndex: integer read FFieldIndex write FFieldIndex;
     property ColumnOffset: integer read FXLSColumn;
  end;

  TXLSGroupStorage = class
  private
    FList: TStringList;
    FIndList: TStringList;  
    FEnabled :boolean;
    FTotalColumnsCount: integer;
    function GetCount: integer;
    function GetItem(Index: integer): TXLSGroupItem; 
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddGroup(AFieldName: String; AFieldIndex: integer; XlsColumn: integer);
    function IsGroupField(FieldName: String): boolean; overload;
    function IsGroupField(FieldIndex: Integer): boolean; overload;
    property Count: integer read GetCount;
    property Enabled: boolean read FEnabled write FEnabled;
    property TotalColumnsCount: integer read FTotalColumnsCount write FTotalColumnsCount;
    property Item[index: integer]: TXLSGroupItem read GetItem; default;
  end;


implementation

uses sysutils,
     {$IFDEF D45}
        ComObj
     {$ELSE}
         Variants
     {$ENDIF};


{TXLSGroupItem}
constructor TXLSGroupItem.Create(AFieldName: String; AFieldIndex: integer; XLSColumn: integer);
begin
  inherited Create;
  FFieldName := AFieldName;
  FValueAssigned := false;
  FRowStart := -1;
  FXLSColumn := XLSColumn;
  FFieldIndex := AFieldIndex;
end;

function TXLSGroupItem.GroupChanged(Value: Variant): boolean;
begin
   Result := false;
   if FRowStart = -1 then Result := true;
   If Not(Result) and not(FValueAssigned) then Result := true;
   If Not(Result) and (FFieldValue <> value) then Result := true;
end;

procedure TXLSGroupItem.StartGroup(Row: integer; Value: Variant);
begin
   FRowStart := Row;
   FFieldValue := Value;                
   FValueAssigned := true;
end;

procedure TXLSGroupItem.CloseGroup();
begin
   FRowStart := -1;
   FFieldValue := Null;                
   FValueAssigned := false;
end;


{TXLSGroupStorage}
constructor TXLSGroupStorage.Create;
begin
  inherited Create;
  FEnabled := false;
  FList := TStringList.Create;
  FIndList := TStringList.Create;
  FTotalColumnsCount := 0;
end;


destructor TXLSGroupStorage.Destroy; 
Var i, cnt: integer;
begin
   cnt := FList.Count;
   if cnt > 0 then begin
      for i := 0 to cnt - 1 do begin
          TXLSGroupItem(FList.Objects[i]).Free; 
      end;
   end;
   FList.Free;
   FIndList.Free;
   inherited Destroy;
end;

function TXLSGroupStorage.GetCount: integer;
begin
  Result := FList.Count;
end;

procedure TXLSGroupStorage.AddGroup(AFieldName: String; AFieldIndex: integer; XlsColumn: integer);
begin
  FList.AddObject(AFieldName, TXLSGroupItem.Create(AFieldName, AFieldIndex, XlsColumn));
  FIndList.Add(inttostr(AFieldIndex));
end;

function TXLSGroupStorage.GetItem(Index: integer): TXLSGroupItem; 
begin
   Result := TXLSGroupItem(FList.Objects[Index]);
end;

function TXLSGroupStorage.IsGroupField(FieldName: String): boolean; 
begin
   Result := (FList.IndexOf(FieldName) >= 0);
end;

function TXLSGroupStorage.IsGroupField(FieldIndex: integer): boolean; 
begin
   Result := (FIndList.IndexOf(inttostr(FieldIndex)) >= 0);
end;

end.