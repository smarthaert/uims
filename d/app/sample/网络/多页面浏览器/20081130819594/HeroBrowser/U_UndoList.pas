unit U_UndoList;

interface

Uses SysUtils, Classes, IniFiles, U_PublicInterface;

Type
  TPageUndoList = class(TList, IPageUndoList)
  private
    FRefCount: Integer;
    FMaxCount: Integer;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function Add(UndoItem: TUndoItem): PUndoItem; stdcall;
    procedure Delete(UndoItem: PUndoItem); stdcall;
    function GetItem(Index: Integer): PUndoItem; stdcall;
    function ItemCount: Integer; stdcall;
    function GetMaxItemCount: Integer; stdcall;
    procedure SetMaxItemCount(const Value: Integer); stdcall;
  public
    procedure Clear; virtual;
    property RefCount: Integer read FRefCount;
  End;

  TIniPageUndoListPersistent = Class(TInterfacedObject)
  private
    FIniFile: TIniFile;
  protected
    procedure Save(UndoList: IPageUndoList; FilePath: String); stdcall;
    procedure Load(FilePath: String; UndoList: IPageUndoList); stdcall;
  public
    constructor Create;
    destructor Destroy; override;
  End;

implementation

{ TPageUndoList }

function TPageUndoList.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TPageUndoList._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TPageUndoList._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
    Destroy;
end;

function TPageUndoList.Add(UndoItem: TUndoItem): PUndoItem;
Var
  eUndoItem: PUndoItem;
begin
  New(eUndoItem);

  eUndoItem^ := UndoItem; 

  If Count >= FMaxCount Then
    Delete(Items[Count -1]);

  Insert(0, eUndoItem);
  Result := eUndoItem;
end;

procedure TPageUndoList.Clear;
Var
  I: Integer;
begin
  For I := 0 To Count - 1 Do
    Dispose(PUndoItem(Items[I]));
  inherited;
end;

function TPageUndoList.ItemCount: Integer;
begin
  Result := Count;
end;

procedure TPageUndoList.Delete(UndoItem: PUndoItem);
begin
  Remove(UndoItem);
  Dispose(UndoItem);
end;

function TPageUndoList.GetItem(Index: Integer): PUndoItem;
begin
  Result := Items[Index];
end;


function TPageUndoList.GetMaxItemCount: Integer;
begin
  Result := FMaxCount;
end;

procedure TPageUndoList.SetMaxItemCount(const Value: Integer);
begin
  If FMaxCount = Value Then Exit;

  FMaxCount := Value;

  While Count > FMaxCount Do
    Delete(Items[Count]);
end;

{ TIniPageUndoListPersistent }

constructor TIniPageUndoListPersistent.Create;
begin
  inherited;
end;

destructor TIniPageUndoListPersistent.Destroy;
begin

  inherited;
end;

procedure TIniPageUndoListPersistent.Load(FilePath: String; UndoList:
    IPageUndoList);
Var
  IniFile: TIniFile;
begin
  If UndoList = Nil Then Exit;

  IniFile := TIniFile.Create(FilePath);
  Try

  Finally
    IniFile.Free;
  End;
end;

procedure TIniPageUndoListPersistent.Save(UndoList: IPageUndoList; FilePath:
    String);
begin

end;

end.
