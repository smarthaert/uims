{
  LkJSON v1.02

  14 september 2007

  Copyright (C) 2006,2007 Leonid Koninin
  leon_kon@users.sourceforge.net

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

  changes:

  v1.02 14/09/2007 * fix mistypes in diffrent places; thanx for reports
                     to Aleksandr Fedorov and Tobias Wrede
  v1.01 18/05/2007 * fix small bug in new text generation routine, check
                     library for leaks by fastmm4; thanx for idea and comments
                     for Glynn Owen
  v1.00 12/05/2007 * some fixes in new code (mistypes, mistypes...)
                   * also many fixes by ideas of Henri Gourvest - big thanx
                     for him again; he send me code for thread-safe initializing
                     of hash table, some FPC-compatible issues (not tested by
                     myself) and better code for localization in latest
                     delphi versions; very, very big thanx!
                   * rewritten procedure of json text generating, with wich
                     work of it speeds up 4-5 times (on test) its good for
                     a large objects
                   * started a large work for making source code self-doc
                     (not autodoc!)
  v0.99 10/05/2007 + add functions to list and object:
                      function getInt(idx: Integer): Integer;
                      function getString(idx: Integer): String;
                      function getWideString(idx: Integer):WideString;
                      function getDouble(idx: Integer): Double;
                      function getBoolean(idx: Integer): Boolean;
                   + add overloaded functions to object:
                      function getDouble(nm: String): Double; overload;
                      function getInt(nm: String): Integer; overload;
                      function getString(nm: String): String; overload;
                      function getWideString(nm: String): WideString; overload;
                      function getBoolean(nm: String): Boolean; overload;
                   * changed storing mech of TlkJSONcustomlist descendants from
                     dynamic array to TList; this gives us great speedup with
                     lesser changes; thanx for idea to Henri Gourvest
                   * also reworked hashtable to work with TList, so it also
                     increase speed of work
  v0.98 09/05/2007 * fix small bug in work with WideStrings(UTF8), thanx to
                     IVO GELOV to description and sources
  v0.97 10/04/2007 + add capabilities to work with KOL delphi projects; for
                     this will define KOL variable in begin of text; of course,
                     in this case object TlkJSONstreamed is not compiled.
  v0.96 03/30/2007 + add TlkJSONFuncEnum and method ForEach in all
                     TlkJSONcustomlist descendants
                   + add property UseHash(r/o) to TlkJSONobject, and parameter
                     UseHash:Boolean to object constructors; set ti to false
                     allow to disable using of hash-table, what can increase
                     speed of work in case of objects with low number of
                     methods(fields); [by default it is true]
                   + added conditional compile directive DOTNET for use in .Net
                     based delphi versions; remove dot in declaration below
                     (thanx for idea and sample code to Tim Radford)
                   + added property HashOf to TlkHashTable to allow use of
                     users hash functions; on enter is widestring, on exit is
                     cardinal (32 bit unsigned). Original HashOf renamed to
                     DefaultHashOf
                   * hash table object of TlkJSONobject wrapped by property called
                     HashTable
                   * fixed some minor bugs
  v0.95 03/29/2007 + add object TlkJSONstreamed what descendant of TlkJSON and
                     able to load/save JSON objects from/to streams/files.
                   * fixed small bug in generating of unicode strings representation
  v0.94 03/27/2007 + add properties NameOf and FieldByIndex to TlkJSONobject
                   * fix small error in parsing unicode chars
                   * small changes in hashing code (try to speed up)
  v0.93 03/05/2007 + add overloaded functions to list and object
                   + add enum type TlkJSONtypes
                   + add functions: SelfType:TlkJSONtypes and
                     SelfTypeName: String to every TlkJSONbase child
                   * fix mistype 'IndefOfName' to 'IndexOfName'
                   * fix mistype 'IndefOfObject' to 'IndexOfObject'
  v0.92 03/02/2007 + add some fix to TlkJSON.ParseText to fix bug with parsing
                     objects - object methods not always added properly
                     to hash array (thanx to Chris Matheson)
  ...
}

unit uLkJSON;
{$ifdef fpc}
  {$mode objfpc}{$H+}
  {.$DEFINE HAVE_FORMATSETTING}
{$else}
  {$if RTLVersion > 14.00}
    {$DEFINE HAVE_FORMATSETTING}
  {$ifend}
{$endif}

interface

{.$DEFINE KOL}
{.$define DOTNET}
{$define THREADSAFE}
{$define NEW_STYLE_GENERATE}

uses windows,
  SysUtils,
{$IFNDEF KOL}
  classes,
{$ELSE}
  kol,
{$ENDIF}
  variants;

type
  TlkJSONtypes = (jsBase, jsNumber, jsString, jsBoolean, jsNull,
    jsList, jsObject);

{$IFDEF DOTNET}

  TlkJSONdotnetclass = class
  public
    constructor Create;
    destructor Destroy; override;
    procedure AfterConstruction; virtual;
    procedure BeforeDestruction; virtual;
  end;

{$ENDIF DOTNET}

  TlkJSONbase = class{$IFDEF DOTNET}(TlkJSONdotnetclass){$ENDIF}
  protected
    function GetValue: variant; virtual;
    procedure SetValue(const AValue: variant); virtual;
    function GetChild(idx: Integer): TlkJSONbase; virtual;
    procedure SetChild(idx: Integer; const AValue: TlkJSONbase);
      virtual;
    function GetCount: Integer; virtual;
  public
    property Count: Integer read GetCount;
    property Child[idx: Integer]: TlkJSONbase read GetChild write SetChild;
    property Value: variant read GetValue write SetValue;
    class function SelfType: TlkJSONtypes; virtual;
    class function SelfTypeName: string; virtual;
  end;

  TlkJSONnumber = class(TlkJSONbase)
  protected
    FValue: extended;
    function GetValue: Variant; override;
    procedure SetValue(const AValue: Variant); override;
  public
    procedure AfterConstruction; override;
    class function Generate(AValue: extended = 0): TlkJSONnumber;
    class function SelfType: TlkJSONtypes; override;
    class function SelfTypeName: string; override;
  end;

  TlkJSONstring = class(TlkJSONbase)
  protected
    FValue: WideString;
    function GetValue: Variant; override;
    procedure SetValue(const AValue: Variant); override;
  public
    procedure AfterConstruction; override;
    class function Generate(const wsValue: WideString = ''): TlkJSONstring;
    class function SelfType: TlkJSONtypes; override;
    class function SelfTypeName: string; override;
  end;

  TlkJSONboolean = class(TlkJSONbase)
  protected
    FValue: Boolean;
    function GetValue: Variant; override;
    procedure SetValue(const AValue: Variant); override;
  public
    procedure AfterConstruction; override;
    class function Generate(AValue: Boolean = true): TlkJSONboolean;
    class function SelfType: TlkJSONtypes; override;
    class function SelfTypeName: string; override;
  end;

  TlkJSONnull = class(TlkJSONbase)
  protected
    function GetValue: Variant; override;
    function Generate: TlkJSONnull;
  public
    class function SelfType: TlkJSONtypes; override;
    class function SelfTypeName: string; override;
  end;

  TlkJSONFuncEnum = procedure(ElName: string; Elem: TlkJSONbase;
    data: pointer; var Continue: Boolean) of object;

  TlkJSONcustomlist = class(TlkJSONbase)
  protected
//    FValue: array of TlkJSONbase;
    fList:TList;
    function GetCount: Integer; override;
    function GetChild(idx: Integer): TlkJSONbase; override;
    procedure SetChild(idx: Integer; const AValue: TlkJSONbase);
      override;
    function ForEachElement(idx: Integer; var nm: string):
      TlkJSONbase; virtual;

    function _Add(obj: TlkJSONbase): Integer; virtual;
    procedure _Delete(idx: Integer); virtual;
    function _IndexOf(obj: TlkJSONbase): Integer; virtual;
  public
    procedure ForEach(cb: TlkJSONFuncEnum; data: pointer);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function getInt(idx: Integer): Integer; virtual;
    function getString(idx: Integer): String; virtual;
    function getWideString(idx: Integer):WideString; virtual;
    function getDouble(idx: Integer): Double; virtual;
    function getBoolean(idx: Integer): Boolean; virtual;
  end;

  TlkJSONlist = class(TlkJSONcustomlist)
  public
    function Add(obj: TlkJSONbase): Integer; overload;

    function Add(bool: Boolean): Integer; overload;
    function Add(nmb: double): Integer; overload;
    function Add(s: string): Integer; overload;
    function Add(const ws: WideString): Integer; overload;
    function Add(inmb: Integer): Integer; overload;

    procedure Delete(idx: Integer);
    function IndexOf(obj: TlkJSONbase): Integer;
    class function Generate: TlkJSONlist;
    class function SelfType: TlkJSONtypes; override;
    class function SelfTypeName: string; override;

  end;

  TlkJSONobjectmethod = class(TlkJSONbase)
  protected
    FValue: TlkJSONbase;
    FName: WideString;
    procedure SetName(const AValue: WideString);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    property Name: WideString read FName write SetName;
    class function Generate(const aname: WideString; aobj: TlkJSONbase):
      TlkJSONobjectmethod;
  end;

  PlkHashItem = ^TlkHashItem;
  TlkHashItem = packed record
    hash: cardinal;
    index: Integer;
  end;

  TlkHashFunction = function(const ws: WideString): cardinal of object;

  TlkHashTable = class
  private
    FHashFunction: TlkHashFunction;
    procedure SetHashFunction(const AValue: TlkHashFunction);
  protected
//    a_h: array[0..255] of array of TlkHashItem;
    a_x: array[0..255] of TList;
    procedure hswap(j, k, l: Integer);
    function InTable(const ws: WideString; var i, j, k: cardinal): Boolean;
  public
    function counters: string;

    function DefaultHashOf(const ws: WideString): cardinal;
    function SimpleHashOf(const ws: WideString): cardinal;

    property HashOf: TlkHashFunction read FHashFunction write
      SetHashFunction;

    function IndexOf(const ws: WideString): Integer;

    procedure AddPair(const ws: WideString; idx: Integer);
    procedure Delete(const ws: WideString);

    constructor Create;
    destructor Destroy; override;
  end;

  TlkJSONobject = class(TlkJSONcustomlist)
  protected
    ht: TlkHashTable;
    FUseHash: Boolean;
    function GetFieldByIndex(idx: Integer): TlkJSONbase;
    function GetNameOf(idx: Integer): WideString;
    procedure SetFieldByIndex(idx: Integer; const AValue:
      TlkJSONbase);
    function GetHashTable: TlkHashTable;
    function ForEachElement(idx: Integer; var nm: string):
      TlkJSONbase;
      override;
  public
    property UseHash: Boolean read FUseHash;
    property HashTable: TlkHashTable read GetHashTable;
    function GetField(nm: string): TlkJSONbase;
    procedure SetField(nm: string; const AValue: TlkJSONbase);

    function Add(const aname: WideString; aobj: TlkJSONbase): Integer;
      overload;

    function Add(const aname: WideString; bool: Boolean): Integer;
      overload;
    function Add(const aname: WideString; nmb: double): Integer; overload;
    function Add(const aname: WideString; s: string): Integer; overload;
    function Add(const aname: WideString; const ws: WideString): Integer;
      overload;
    function Add(const aname: WideString; inmb: Integer): Integer;
      overload;

    procedure Delete(idx: Integer);
    function IndexOfName(const aname: WideString): Integer;
    function IndexOfObject(aobj: TlkJSONbase): Integer;
    property Field[nm: string]: TlkJSONbase read GetField write SetField; default;

    constructor Create(bUseHash: Boolean = true);
    destructor Destroy; override;

    class function Generate(AUseHash: Boolean = true): TlkJSONobject;
    class function SelfType: TlkJSONtypes; override;
    class function SelfTypeName: string; override;

    property FieldByIndex[idx: Integer]: TlkJSONbase read GetFieldByIndex write SetFieldByIndex;
    property NameOf[idx: Integer]: WideString read GetNameOf;

    function getDouble(idx: Integer): Double; overload; override;
    function getInt(idx: Integer): Integer; overload; override;
    function getString(idx: Integer): String; overload; override;
    function getWideString(idx: Integer): WideString; overload; override;
    function getBoolean(idx: Integer): Boolean; overload; override;

    function getDouble(nm: String): Double; overload;
    function getInt(nm: String): Integer; overload;
    function getString(nm: String): String; overload;
    function getWideString(nm: String): WideString; overload;
    function getBoolean(nm: String): Boolean; overload;
  end;

  TlkJSON = class
  public
    class function ParseText(const txt: string): TlkJSONbase;
    class function GenerateText(obj: TlkJSONbase): string;
  end;

{$IFNDEF KOL}
  TlkJSONstreamed = class(TlkJSON)
    class function LoadFromStream(src: TStream): TlkJSONbase;
    class procedure SaveToStream(obj: TlkJSONbase; dst: TStream);
    class function LoadFromFile(srcname: string): TlkJSONbase;
    class procedure SaveToFile(obj: TlkJSONbase; dstname: string);
  end;
{$ENDIF}

implementation

uses math;

type
  ElkIntException = class(Exception)
  public
    idx: Integer;
    constructor Create(idx: Integer; msg: string);
  end;

// author of this routine is IVO GELOV
function code2utf(iNumber: Integer): UTF8String;
begin
  if iNumber < 128 then Result := chr(iNumber)
  else if iNumber < 2048 then
    Result := chr((iNumber shr 6) + 192) + chr((iNumber and 63) + 128)
  else if iNumber < 65536 then
    Result := chr((iNumber shr 12) + 224) + chr(((iNumber shr 6) and 63) + 128)
    + chr((iNumber and 63) + 128)
  else if iNumber < 2097152 then
    Result := chr((iNumber shr 18) + 240) + chr(((iNumber shr 12) and 63) + 128)
    + chr(((iNumber shr 6) and 63) + 128) + chr((iNumber and 63) + 128);
end;

{ TlkJSONbase }

function TlkJSONbase.GetChild(idx: Integer): TlkJSONbase;
begin
  result := nil;
end;

function TlkJSONbase.GetCount: Integer;
begin
  result := 0;
end;

function TlkJSONbase.GetValue: variant;
begin
  result := variants.Null;
end;

class function TlkJSONbase.SelfType: TlkJSONtypes;
begin
  result := jsBase;
end;

class function TlkJSONbase.SelfTypeName: string;
begin
  result := 'jsBase';
end;

procedure TlkJSONbase.SetChild(idx: Integer; const AValue:
  TlkJSONbase);
begin

end;

procedure TlkJSONbase.SetValue(const AValue: variant);
begin

end;

{ TlkJSONnumber }

procedure TlkJSONnumber.AfterConstruction;
begin
  inherited;
  FValue := 0;
end;

class function TlkJSONnumber.Generate(AValue: extended): TlkJSONnumber;
begin
  result := TlkJSONnumber.Create;
  result.FValue := AValue;
end;

function TlkJSONnumber.GetValue: Variant;
begin
  result := FValue;
end;

class function TlkJSONnumber.SelfType: TlkJSONtypes;
begin
  result := jsNumber;
end;

class function TlkJSONnumber.SelfTypeName: string;
begin
  result := 'jsNumber';
end;

procedure TlkJSONnumber.SetValue(const AValue: Variant);
begin
  FValue := VarAsType(AValue, varDouble);
end;

{ TlkJSONstring }

procedure TlkJSONstring.AfterConstruction;
begin
  inherited;
  FValue := '';
end;

class function TlkJSONstring.Generate(const wsValue: WideString): TlkJSONstring;
begin
  result := TlkJSONstring.Create;
  result.FValue := wsValue;
end;

function TlkJSONstring.GetValue: Variant;
begin
  result := FValue;
end;

class function TlkJSONstring.SelfType: TlkJSONtypes;
begin
  result := jsString;
end;

class function TlkJSONstring.SelfTypeName: string;
begin
  result := 'jsString';
end;

procedure TlkJSONstring.SetValue(const AValue: Variant);
begin
  FValue := VarToWideStr(AValue);
end;

{ TlkJSONboolean }

procedure TlkJSONboolean.AfterConstruction;
begin
  FValue := false;
end;

class function TlkJSONboolean.Generate(AValue: Boolean): TlkJSONboolean;
begin
  result := TlkJSONboolean.Create;
  result.Value := AValue;
end;

function TlkJSONboolean.GetValue: Variant;
begin
  result := FValue;
end;

class function TlkJSONboolean.SelfType: TlkJSONtypes;
begin
  Result := jsBoolean;
end;

class function TlkJSONboolean.SelfTypeName: string;
begin
  Result := 'jsBoolean';
end;

procedure TlkJSONboolean.SetValue(const AValue: Variant);
begin
  FValue := boolean(AValue);
end;

{ TlkJSONnull }

function TlkJSONnull.Generate: TlkJSONnull;
begin
  result := TlkJSONnull.Create;
end;

function TlkJSONnull.GetValue: Variant;
begin
  result := variants.Null;
end;

class function TlkJSONnull.SelfType: TlkJSONtypes;
begin
  result := jsNull;
end;

class function TlkJSONnull.SelfTypeName: string;
begin
  result := 'jsNull';
end;

{ TlkJSONcustomlist }

function TlkJSONcustomlist._Add(obj: TlkJSONbase): Integer;
begin
  if not Assigned(obj) then
    begin
      result := -1;
      exit;
    end;
  result := fList.Add(obj);
end;

procedure TlkJSONcustomlist.AfterConstruction;
begin
  inherited;
  fList := TList.Create;
end;

procedure TlkJSONcustomlist.BeforeDestruction;
var
  i: Integer;
begin
  for i := (Count - 1) downto 0 do _Delete(i);
  fList.Free;
  inherited;
end;

procedure TlkJSONcustomlist._Delete(idx: Integer);
begin
  if not ((idx < 0) or (idx >= Count)) then
    begin
      if fList.Items[idx]<>nil then TlkJSONbase(fList.Items[idx]).Free;
      fList.Delete(idx);
    end;
end;

function TlkJSONcustomlist.GetChild(idx: Integer): TlkJSONbase;
begin
  if (idx < 0) or (idx >= Count) then
    begin
      result := nil;
    end
  else
    begin
      result := fList.Items[idx];
    end;
end;

function TlkJSONcustomlist.GetCount: Integer;
begin
  result := fList.Count;
end;

function TlkJSONcustomlist._IndexOf(obj: TlkJSONbase): Integer;
var
  i: Integer;
begin
  result := fList.IndexOf(obj);
end;

procedure TlkJSONcustomlist.SetChild(idx: Integer; const AValue:
  TlkJSONbase);
begin
  if not ((idx < 0) or (idx >= Count)) then
    begin
      if fList.Items[idx]<>nil then TlkJSONbase(fList.Items[idx]).Free;
      fList.Items[idx] := AValue;
    end;
end;

///---- renamed to here

procedure TlkJSONcustomlist.ForEach(cb: TlkJSONFuncEnum; data:
  pointer);
var
  i: Integer;
  doCont: Boolean;
  obj: TlkJSONbase;
  ws: string;
begin
  if not assigned(cb) then exit;
  doCont := true;
  for i := 0 to GetCount - 1 do
    begin
      obj := ForEachElement(i, ws);
      if assigned(obj) then cb(ws, obj, data, doCont);
      if not doCont then break;
    end;
end;

function TlkJSONcustomlist.ForEachElement(idx: Integer; var nm:
  string): TlkJSONbase;
begin
  nm := inttostr(idx);
  result := GetChild(idx);
end;

function TlkJSONcustomlist.getDouble(idx: Integer): Double;
var
  jn:TlkJSONnumber;
begin
  jn := Child[idx] as TlkJSONnumber;
  if not assigned(jn) then result := 0
  else result := jn.Value;
end;

function TlkJSONcustomlist.getInt(idx: Integer): Integer;
var
  jn:TlkJSONnumber;
begin
  jn := Child[idx] as TlkJSONnumber;
  if not assigned(jn) then result := 0
  else result := round(int(jn.Value));
end;

function TlkJSONcustomlist.getString(idx: Integer): String;
var
  js:TlkJSONstring;
begin
  js := Child[idx] as TlkJSONstring;
  if not assigned(js) then result := ''
  else result := VarToStr(js.Value);
end;

function TlkJSONcustomlist.getWideString(idx: Integer): WideString;
var
  js:TlkJSONstring;
begin
  js := Child[idx] as TlkJSONstring;
  if not assigned(js) then result := ''
  else result := VarToWideStr(js.Value);
end;

function TlkJSONcustomlist.getBoolean(idx: Integer): Boolean;
var
  jb:TlkJSONboolean;
begin
  jb := Child[idx] as TlkJSONboolean;
  if not assigned(jb) then result := false
  else result := jb.Value;
end;

{ TlkJSONobjectmethod }

procedure TlkJSONobjectmethod.AfterConstruction;
begin
  inherited;
  FValue := nil;
  FName := '';
end;

procedure TlkJSONobjectmethod.BeforeDestruction;
begin
  FName := '';
  if FValue <> nil then
    begin
      FValue.Free;
      FValue := nil;
    end;
  inherited;
end;

class function TlkJSONobjectmethod.Generate(const aname: WideString;
  aobj: TlkJSONbase): TlkJSONobjectmethod;
begin
  result := TlkJSONobjectmethod.Create;
  result.FName := aname;
  result.FValue := aobj;
end;

procedure TlkJSONobjectmethod.SetName(const AValue: WideString);
begin
  FName := AValue;
end;

{ TlkJSONlist }

function TlkJSONlist.Add(obj: TlkJSONbase): Integer;
begin
  result := _Add(obj);
end;

function TlkJSONlist.Add(nmb: double): Integer;
begin
  Result := self.Add(TlkJSONnumber.Generate(nmb));
end;

function TlkJSONlist.Add(bool: Boolean): Integer;
begin
  Result := self.Add(TlkJSONboolean.Generate(bool));
end;

function TlkJSONlist.Add(inmb: Integer): Integer;
begin
  Result := self.Add(TlkJSONnumber.Generate(inmb));
end;

function TlkJSONlist.Add(const ws: WideString): Integer;
begin
  Result := self.Add(TlkJSONstring.Generate(ws));
end;

function TlkJSONlist.Add(s: string): Integer;
begin
  Result := self.Add(TlkJSONstring.Generate(s));
end;

procedure TlkJSONlist.Delete(idx: Integer);
begin
  _Delete(idx);
end;

class function TlkJSONlist.Generate: TlkJSONlist;
begin
  result := TlkJSONlist.Create;
end;

function TlkJSONlist.IndexOf(obj: TlkJSONbase): Integer;
begin
  result := _IndexOf(obj);
end;

class function TlkJSONlist.SelfType: TlkJSONtypes;
begin
  result := jsList;
end;

class function TlkJSONlist.SelfTypeName: string;
begin
  result := 'jsList';
end;

{ TlkJSONobject }

function TlkJSONobject.Add(const aname: WideString; aobj: TlkJSONbase):
  Integer;
var
  mth: TlkJSONobjectmethod;
begin
  if not assigned(aobj) then
    begin
      result := -1;
      exit;
    end;
  mth := TlkJSONobjectmethod.Create;
  mth.FName := aname;
  mth.FValue := aobj;
  result := self._Add(mth);
  if FUseHash then ht.AddPair(aname, result);
end;

procedure TlkJSONobject.Delete(idx: Integer);
var
  mth: TlkJSONobjectmethod;
begin
  if (idx >= 0) and (idx < Count) then
    begin
//      mth := FValue[idx] as TlkJSONobjectmethod;
      mth := TlkJSONobjectmethod(fList.Items[idx]);
      if FUseHash then ht.Delete(mth.FName);
    end;
  _Delete(idx);
end;

class function TlkJSONobject.Generate(AUseHash: Boolean = true): TlkJSONobject;
begin
  result := TlkJSONobject.Create(AUseHash);
end;

function TlkJSONobject.GetField(nm: string): TlkJSONbase;
var
  mth: TlkJSONobjectmethod;
  i: Integer;
begin
  i := IndexOfName(nm);
  if i = -1 then
    begin
      result := nil;
    end
  else
    begin
//      mth := TlkJSONobjectmethod(FValue[i]);
      mth := TlkJSONobjectmethod(fList.Items[i]);
      result := mth.FValue;
    end;
end;

function TlkJSONobject.IndexOfName(const aname: WideString): Integer;
var
  mth: TlkJSONobjectmethod;
  i: Integer;
begin
  if not FUseHash then
    begin
      result := -1;
      for i := 0 to Count - 1 do
        begin
//          mth := TlkJSONobjectmethod(FValue[i]);
          mth := TlkJSONobjectmethod(fList.Items[i]);
          if mth.Name = aname then
            begin
              result := i;
              break;
            end;
        end;
    end
  else
    begin
      result := ht.IndexOf(aname);
    end;
end;

function TlkJSONobject.IndexOfObject(aobj: TlkJSONbase): Integer;
var
  mth: TlkJSONobjectmethod;
  i: Integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    begin
//      mth := TlkJSONobjectmethod(FValue[i]);
      mth := TlkJSONobjectmethod(fList.Items[i]);
      if mth.FValue = aobj then
        begin
          result := i;
          break;
        end;
    end;
end;

procedure TlkJSONobject.SetField(nm: string; const AValue:
  TlkJSONbase);
var
  mth: TlkJSONobjectmethod;
  i: Integer;
begin
  i := IndexOfName(nm);
  if i <> -1 then
    begin
//      mth := TlkJSONobjectmethod(FValue[i]);
      mth := TlkJSONobjectmethod(fList.Items[i]);
      mth.FValue := AValue;
    end;
end;

function TlkJSONobject.Add(const aname: WideString; nmb: double): Integer;
begin
  Result := self.Add(aname, TlkJSONnumber.Generate(nmb));
end;

function TlkJSONobject.Add(const aname: WideString; bool: Boolean):
  Integer;
begin
  Result := self.Add(aname, TlkJSONboolean.Generate(bool));
end;

function TlkJSONobject.Add(const aname: WideString; s: string): Integer;
begin
  Result := self.Add(aname, TlkJSONstring.Generate(s));
end;

function TlkJSONobject.Add(const aname: WideString; inmb: Integer):
  Integer;
begin
  Result := self.Add(aname, TlkJSONnumber.Generate(inmb));
end;

function TlkJSONobject.Add(const aname, ws: WideString): Integer;
begin
  Result := self.Add(aname, TlkJSONstring.Generate(ws));
end;

class function TlkJSONobject.SelfType: TlkJSONtypes;
begin
  Result := jsObject;
end;

class function TlkJSONobject.SelfTypeName: string;
begin
  Result := 'jsObject';
end;

function TlkJSONobject.GetFieldByIndex(idx: Integer): TlkJSONbase;
var
  nm: WideString;
begin
  nm := GetNameOf(idx);
  if nm <> '' then
    begin
      result := Field[nm];
    end
  else
    begin
      result := nil;
    end;
end;

function TlkJSONobject.GetNameOf(idx: Integer): WideString;
var
  mth: TlkJSONobjectmethod;
begin
  if (idx < 0) or (idx >= Count) then
    begin
      result := '';
    end
  else
    begin
      mth := Child[idx] as TlkJSONobjectmethod;
      result := mth.Name;
    end;
end;

procedure TlkJSONobject.SetFieldByIndex(idx: Integer;
  const AValue: TlkJSONbase);
var
  nm: WideString;
begin
  nm := GetNameOf(idx);
  if nm <> '' then
    begin
      Field[nm] := AValue;
    end;
end;

function TlkJSONobject.ForEachElement(idx: Integer;
  var nm: string): TlkJSONbase;
begin
  nm := GetNameOf(idx);
  result := GetFieldByIndex(idx);
end;

function TlkJSONobject.GetHashTable: TlkHashTable;
begin
  result := ht;
end;

constructor TlkJSONobject.Create(bUseHash: Boolean);
begin
  inherited Create;
  FUseHash := bUseHash;
  ht := TlkHashTable.Create;
end;

destructor TlkJSONobject.Destroy;
begin
  if assigned(ht) then FreeAndNil(ht);
  inherited;
end;

function TlkJSONobject.getDouble(idx: Integer): Double;
var
  jn:TlkJSONnumber;
begin
  jn := FieldByIndex[idx] as TlkJSONnumber;
  if not assigned(jn) then result := 0
  else result := jn.Value;
end;

function TlkJSONobject.getInt(idx: Integer): Integer;
var
  jn:TlkJSONnumber;
begin
  jn := FieldByIndex[idx] as TlkJSONnumber;
  if not assigned(jn) then result := 0
  else result := round(int(jn.Value));
end;

function TlkJSONobject.getString(idx: Integer): String;
var
  js:TlkJSONstring;
begin
  js := FieldByIndex[idx] as TlkJSONstring;
  if not assigned(js) then result := ''
  else result := vartostr(js.Value);
end;

function TlkJSONobject.getWideString(idx: Integer): WideString;
var
  js:TlkJSONstring;
begin
  js := FieldByIndex[idx] as TlkJSONstring;
  if not assigned(js) then result := ''
  else result := VarToWideStr(js.Value);
end;

function TlkJSONobject.getDouble(nm: String): Double;
begin
  result := getDouble(IndexOfName(nm));
end;

function TlkJSONobject.getInt(nm: String): Integer;
begin
  result := getInt(IndexOfName(nm));
end;

function TlkJSONobject.getString(nm: String): String;
begin
  result := getString(IndexOfName(nm));
end;

function TlkJSONobject.getWideString(nm: String): WideString;
begin
  result := getWideString(IndexOfName(nm));
end;

function TlkJSONobject.getBoolean(idx: Integer): Boolean;
var
  jb:TlkJSONboolean;
begin
  jb := FieldByIndex[idx] as TlkJSONboolean;
  if not assigned(jb) then result := false
  else result := jb.Value;
end;

function TlkJSONobject.getBoolean(nm: String): Boolean;
begin
  result := getBoolean(IndexOfName(nm));
end;

{ TlkJSON }

class function TlkJSON.GenerateText(obj: TlkJSONbase): string;
var
{$IFDEF HAVE_FORMATSETTING}
  fs: TFormatSettings;
{$ENDIF}
  pt1,pt0,pt2:PAnsiChar;
  ptsz:cardinal;

{$ifndef NEW_STYLE_GENERATE}
  function gn_base(obj: TlkJSONbase): string;
  var
    ws: string;
    i, j: Integer;
    xs: TlkJSONstring;
  begin
    result := '';
    if not assigned(obj) then exit;
    if obj is TlkJSONnumber then
      begin
{$ifdef HAVE_FORMATSETTING}
        result := FloatToStr(TlkJSONnumber(obj).FValue, fs);
{$else}
        result := FloatToStr(TlkJSONnumber(obj).FValue);
        i := pos(DecimalSeparator, result);
        if (DecimalSeparator <> '.') and (i > 0) then
          result[i] := '.';
{$endif}
      end
    else if obj is TlkJSONstring then
      begin
        ws := UTF8Encode(TlkJSONstring(obj).FValue);
        i := 1;
        result := '"';
        while i <= length(ws) do
          begin
            case ws[i] of
              '/', '\', '"': result := result + '\' + ws[i];
              #8: result := result + '\b';
              #9: result := result + '\t';
              #10: result := result + '\n';
              #13: result := result + '\r';
              #12: result := result + '\f';
            else
              if ord(ws[i]) < 32 then
                result := result + '\u' + inttohex(ord(ws[i]), 4)
              else
                result := result + ws[i];
            end;
            inc(i);
          end;
        result := result + '"';
      end
    else if obj is TlkJSONboolean then
      begin
        if TlkJSONboolean(obj).FValue then
          result := 'true'
        else
          result := 'false';
      end
    else if obj is TlkJSONnull then
      begin
        result := 'null';
      end
    else if obj is TlkJSONlist then
      begin
        result := '[';
        j := TlkJSONobject(obj).Count - 1;
        for i := 0 to j do
          begin
            if i > 0 then result := result + ',';
            result := result + gn_base(TlkJSONlist(obj).Child[i]);
          end;
        result := result + ']';
      end
    else if obj is TlkJSONobjectmethod then
      begin
        try
          xs := TlkJSONstring.Create;
          xs.FValue := TlkJSONobjectmethod(obj).FName;
          result := gn_base(TlkJSONbase(xs)) + ':';
          result := result +
            gn_base(TlkJSONbase(TlkJSONobjectmethod(obj).FValue));
        finally
          if assigned(xs) then FreeAndNil(xs);
        end;
      end
    else if obj is TlkJSONobject then
      begin
        result := '{';
        j := TlkJSONobject(obj).Count - 1;
        for i := 0 to j do
          begin
            if i > 0 then result := result + ',';
            result := result + gn_base(TlkJSONobject(obj).Child[i]);
          end;
        result := result + '}';
      end;
  end;
{$else}
  procedure get_more_memory;
  var delta: Integer;
  begin
    delta := 20000;
    if pt0 = nil then
      begin
        pt0 := AllocMem(delta);
        ptsz := 0;
        pt1 := pt0;
      end
    else
      begin
        ReallocMem(pt0,ptsz+delta);
        pt1 := pointer(cardinal(pt0)+ptsz);
      end;
    ptsz := ptsz + delta;
    pt2 := pointer(cardinal(pt1)+delta);
  end;

  procedure mem_ch(ch:char);
  begin
    if pt1 >= pt2 then get_more_memory;
    pt1^ := ch;
    inc(pt1);
  end;

  procedure mem_write(rs: String);
  var i: Integer;
  begin
    for i := 1 to length(rs) do
      begin
        if pt1 >= pt2 then get_more_memory;
        pt1^ := rs[i];
        inc(pt1);
      end;
  end;

  procedure gn_base(obj: TlkJSONbase);
  var
    ws: string;
    i, j: Integer;
    xs: TlkJSONstring;
  begin
    if not assigned(obj) then exit;
    if obj is TlkJSONnumber then
      begin
{$ifdef HAVE_FORMATSETTING}
        mem_write(FloatToStr(TlkJSONnumber(obj).FValue, fs));
{$else}
        ws := FloatToStr(TlkJSONnumber(obj).FValue);
        i := pos(DecimalSeparator, ws);
        if (DecimalSeparator <> '.') and (i > 0) then ws[i] := '.';
        mem_write(ws);
{$endif}
      end
    else if obj is TlkJSONstring then
      begin
        ws := UTF8Encode(TlkJSONstring(obj).FValue);
        i := 1;
        mem_ch('"');
        while i <= length(ws) do
          begin
            case ws[i] of
              '/', '\', '"':
                begin
                  mem_ch('\');
                  mem_ch(ws[i]);
                end;
              #8: mem_write('\b');
              #9: mem_write('\t');
              #10: mem_write('\n');
              #13: mem_write('\r');
              #12: mem_write('\f');
            else
              if ord(ws[i]) < 32 then
                mem_write('\u' + inttohex(ord(ws[i]), 4))
              else
                mem_ch(ws[i]);
            end;
            inc(i);
          end;
        mem_ch('"');
      end
    else if obj is TlkJSONboolean then
      begin
        if TlkJSONboolean(obj).FValue then
          mem_write('true')
        else
          mem_write('false');
      end
    else if obj is TlkJSONnull then
      begin
        mem_write('null');
      end
    else if obj is TlkJSONlist then
      begin
        mem_ch('[');
        j := TlkJSONobject(obj).Count - 1;
        for i := 0 to j do
          begin
            if i > 0 then mem_ch(',');
            gn_base(TlkJSONlist(obj).Child[i]);
          end;
        mem_ch(']');
      end
    else if obj is TlkJSONobjectmethod then
      begin
        try
          xs := TlkJSONstring.Create;
          xs.FValue := TlkJSONobjectmethod(obj).FName;
          gn_base(TlkJSONbase(xs));
          mem_ch(':');
          gn_base(TlkJSONbase(TlkJSONobjectmethod(obj).FValue));
        finally
          if assigned(xs) then FreeAndNil(xs);
        end;
      end
    else if obj is TlkJSONobject then
      begin
        mem_ch('{');
        j := TlkJSONobject(obj).Count - 1;
        for i := 0 to j do
          begin
            if i>0 then mem_ch(',');
            gn_base(TlkJSONobject(obj).Child[i]);
          end;
        mem_ch('}');
      end;
  end;
{$endif NEW_STYLE_GENERATE}

begin
{$ifdef HAVE_FORMATSETTING}
  GetLocaleFormatSettings(GetThreadLocale, fs);
  fs.DecimalSeparator := '.';
{$endif}
{$ifdef NEW_STYLE_GENERATE}
  pt0 := nil;
  get_more_memory;
  gn_base(obj);
  mem_ch(#0);
  result := string(pt0);
  freemem(pt0);
{$else}
  result := gn_base(obj);
{$endif}
end;

class function TlkJSON.ParseText(const txt: string): TlkJSONbase;
{$ifdef HAVE_FORMATSETTING}
var
  fs: TFormatSettings;
{$endif}

  function js_base(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean; forward;

  function xe(idx: Integer): Boolean;{$IFDEF FPC}inline;{$ENDIF}
  begin
    result := idx <= length(txt);
  end;

  procedure skip_spc(var idx: Integer);{$IFDEF FPC}inline;{$ENDIF}
  begin
    while (xe(idx)) and (ord(txt[idx]) < 33) do
      inc(idx);
  end;

  procedure add_child(var o, c: TlkJSONbase);
  var
    i: Integer;
  begin
    if o = nil then
      begin
        o := c;
      end
    else
      begin
        if o is TlkJSONobjectmethod then
          begin
            TlkJSONobjectmethod(o).FValue := c;
          end
        else if o is TlkJSONlist then
          begin
            TlkJSONlist(o)._Add(c);
          end
        else if o is TlkJSONobject then
          begin
            i := TlkJSONobject(o)._Add(c);
            if TlkJSONobject(o).UseHash then
              TlkJSONobject(o).ht.AddPair(TlkJSONobjectmethod(c).Name, i);
          end;
      end;
  end;

  function js_boolean(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  var
    js: TlkJSONboolean;
  begin
    skip_spc(idx);
    if copy(txt, idx, 4) = 'true' then
      begin
        result := true;
        ridx := idx + 4;
        js := TlkJSONboolean.Create;
        js.FValue := true;
        add_child(o, TlkJSONbase(js));
      end
    else if copy(txt, idx, 5) = 'false' then
      begin
        result := true;
        ridx := idx + 5;
        js := TlkJSONboolean.Create;
        js.FValue := false;
        add_child(o, TlkJSONbase(js));
      end
    else
      begin
        result := false;
      end;
  end;

  function js_null(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  var
    js: TlkJSONnull;
  begin
    skip_spc(idx);
    if copy(txt, idx, 4) = 'null' then
      begin
        result := true;
        ridx := idx + 4;
        js := TlkJSONnull.Create;
        add_child(o, TlkJSONbase(js));
      end
    else
      begin
        result := false;
      end;
  end;

  function js_integer(idx: Integer; var ridx: Integer): Boolean;
  begin
    result := false;
    while (xe(idx)) and (txt[idx] in ['0'..'9']) do
      begin
        result := true;
        inc(idx);
      end;
    if result then ridx := idx;
  end;

  function js_number(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  var
    js: TlkJSONnumber;
    ws: string;
{$IFNDEF HAVE_FORMATSETTING}
    i: Integer;
{$ENDIF}
  begin
    skip_spc(idx);
    result := xe(idx);
    if not result then exit;
    if txt[idx] in ['+', '-'] then
      begin
        inc(idx);
        result := xe(idx);
      end;
    if not result then exit;
    result := js_integer(idx, idx);
    if not result then exit;
    if (xe(idx)) and (txt[idx] = '.') then
      begin
        inc(idx);
        result := js_integer(idx, idx);
        if not result then exit;
      end;
    if (xe(idx)) and (txt[idx] in ['e', 'E']) then
      begin
        inc(idx);
        if (xe(idx)) and (txt[idx] in ['+', '-']) then inc(idx);
        result := js_integer(idx, idx);
        if not result then exit;
      end;
    if not result then exit;
    js := TlkJSONnumber.Create;
    ws := copy(txt, ridx, idx - ridx);
{$IFDEF HAVE_FORMATSETTING}
    js.FValue := StrToFloat(ws, fs);
{$ELSE}
    i := pos('.', ws);
    if (DecimalSeparator <> '.') and (i > 0) then
      ws[pos('.', ws)] := DecimalSeparator;
    js.FValue := StrToFloat(ws);
{$ENDIF}
    add_child(o, TlkJSONbase(js));
    ridx := idx;
  end;

  function js_string(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  var
    js: TlkJSONstring;
    fin: Boolean;
    ws: WideString;
  begin
    skip_spc(idx);
    ws := '';
    result := xe(idx);
    if not result then exit;
    result := txt[idx] = '"';
    if not result then exit;
    inc(idx);
    result := false;
    repeat
      fin := not xe(idx);
      if not fin then
        begin
          if txt[idx] = '\' then
            begin
              inc(idx);
              if not xe(idx) then exit;
              case txt[idx] of
                '\': ws := ws + '\';
                '"': ws := ws + '''';
                '/': ws := ws + '/';
                'b': ws := ws + #8;
                'f': ws := ws + #12;
                'n': ws := ws + #10;
                'r': ws := ws + #13;
                't': ws := ws + #9;
                'u':
                  begin
//                    ws := ws + widechar(strtoint('$' +
//                      copy(txt, idx + 1, 4)));
                    ws := ws + code2utf(strtoint('$' + copy(txt, idx + 1, 4)));
                    idx := idx + 4;
                  end;
              end;
            end
          else if txt[idx] <> '"' then
            begin
              ws := ws + txt[idx];
            end
          else
            begin
              fin := true;
              result := true;
            end;
          inc(idx);
        end;
    until fin;
    if not result then exit;
    js := TlkJSONstring.Create;
    js.FValue := UTF8Decode(ws);
    add_child(o, TlkJSONbase(js));
    ridx := idx;
  end;

  function js_list(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  var
    js: TlkJSONlist;
  begin
    result := false;
    try
      js := TlkJSONlist.Create;
      skip_spc(idx);
      result := xe(idx);
      if not result then exit;
      result := txt[idx] = '[';
      if not result then exit;
      inc(idx);
      while js_base(idx, idx, TlkJSONbase(js)) do
        begin
          skip_spc(idx);
          if (xe(idx)) and (txt[idx] = ',') then inc(idx);
        end;
      result := (xe(idx)) and (txt[idx] = ']');
      if not result then exit;
      inc(idx);
    finally
      if not result then
        begin
          js.Free;
        end
      else
        begin
          add_child(o, TlkJSONbase(js));
          ridx := idx;
        end;
    end;
  end;

  function js_method(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  var
    mth: TlkJSONobjectmethod;
    ws: TlkJSONstring;
  begin
    result := false;
    try
      ws := nil;
      mth := TlkJSONobjectmethod.Create;
      skip_spc(idx);
      result := xe(idx);
      if not result then exit;
      result := js_string(idx, idx, TlkJSONbase(ws));
      if not result then exit;
      skip_spc(idx);
      result := xe(idx) and (txt[idx] = ':');
      if not result then exit;
      inc(idx);
      mth.FName := ws.FValue;
      result := js_base(idx, idx, TlkJSONbase(mth));
    finally
      if ws <> nil then ws.Free;
      if result then
        begin
          add_child(o, TlkJSONbase(mth));
          ridx := idx;
        end
      else
        begin
          mth.Free;
        end;
    end;
  end;

  function js_object(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  var
    js: TlkJSONobject;
  begin
    result := false;
    try
      js := TlkJSONobject.Create;
      skip_spc(idx);
      result := xe(idx);
      if not result then exit;
      result := txt[idx] = '{';
      if not result then exit;
      inc(idx);
      while js_method(idx, idx, TlkJSONbase(js)) do
        begin
          skip_spc(idx);
          if (xe(idx)) and (txt[idx] = ',') then inc(idx);
        end;
      result := (xe(idx)) and (txt[idx] = '}');
      if not result then exit;
      inc(idx);
    finally
      if not result then
        begin
          js.Free;
        end
      else
        begin
          add_child(o, TlkJSONbase(js));
          ridx := idx;
        end;
    end;
  end;

  function js_base(idx: Integer; var ridx: Integer; var o:
    TlkJSONbase): Boolean;
  begin
    skip_spc(idx);
    result := js_boolean(idx, idx, o);
    if not result then result := js_null(idx, idx, o);
    if not result then result := js_number(idx, idx, o);
    if not result then result := js_string(idx, idx, o);
    if not result then result := js_list(idx, idx, o);
    if not result then result := js_object(idx, idx, o);
    if result then ridx := idx;
  end;

var
  idx: Integer;
begin
{$ifdef HAVE_FORMATSETTING}
  GetLocaleFormatSettings(GetThreadLocale, fs);
  fs.DecimalSeparator := '.';
{$endif}

  result := nil;
  if txt = '' then exit;
  try
    idx := 1;
    if not js_base(idx, idx, result) then FreeAndNil(result);
  except
    if assigned(result) then FreeAndNil(result);
  end;
end;

{ ElkIntException }

constructor ElkIntException.Create(idx: Integer; msg: string);
begin
  self.idx := idx;
  inherited Create(msg);
end;

{ TlkHashTable }

procedure TlkHashTable.AddPair(const ws: WideString; idx: Integer);
var
  i, j, k: cardinal;
  p,p2: PlkHashItem;
begin
  if InTable(ws, i, j, k) then
    begin
// if string is already in table, changing index
//      a_h[j, k].index := idx;
      PlkHashItem(a_x[j].Items[k])^.index := idx;
    end
  else
    begin
//      k := length(a_h[j]);
//      SetLength(a_h[j], k + 1);
//      a_h[j, k].hash := i;
//      a_h[j, k].index := idx;
//// sorting array of hashes
//      while (k > 0) and (a_h[j, k].hash < a_h[j, k - 1].hash) do
//        begin
//          hswap(j, k, k - 1);
//          dec(k);
//        end;
//--- new version
      GetMem(p,sizeof(TlkHashItem));
      k := a_x[j].Add(p);
      p^.hash := i;
      p^.index := idx;
      while (k>0) and (PlkHashItem(a_x[j].Items[k])^.hash <
        PlkHashItem(a_x[j].Items[k-1])^.hash) do
        begin
          a_x[j].Exchange(k,k-1);
          dec(k);
        end;
    end;
end;

function TlkHashTable.counters: string;
var
  i, j: Integer;
  ws: string;
begin
  ws := '';
  for i := 0 to 15 do
    begin
      for j := 0 to 15 do
//        ws := ws + format('%.3d ', [length(a_h[i * 16 + j])]);
        ws := ws + format('%.3d ', [a_x[i * 16 + j].Count]);
      ws := ws + #13#10;
    end;
  result := ws;
end;

procedure TlkHashTable.Delete(const ws: WideString);
var
  i, j, k: cardinal;
begin
  if InTable(ws, i, j, k) then
    begin
//      while k < high(a_h[j]) do
//        begin
//          hswap(j, k, k + 1);
//          inc(k);
//        end;
//      SetLength(a_h[j], k);
      FreeMem(a_x[j].Items[k]);
      a_x[j].Delete(k);
    end;
end;

{$IFDEF THREADSAFE}
const
  rnd_table: array[0..255] of byte =
(216,191,234,201,12,163,190,205,128,199,210,17,52,43,38,149,40,207,186,89,92,179,142,93,208,215,162,
161,132,59,246,37,120,223,138,233,172,195,94,237,32,231,114,49,212,75,198,181,200,239,90,121,252,211,
46,125,112,247,66,193,36,91,150,69,24,255,42,9,76,227,254,13,192,7,18,81,116,107,102,213,104,15,250,
153,156,243,206,157,16,23,226,225,196,123,54,101,184,31,202,41,236,3,158,45,96,39,178,113,20,139,6,
245,8,47,154,185,60,19,110,189,176,55,130,1,100,155,214,133,88,63,106,73,140,35,62,77,0,71,82,145,180,
171,166,21,168,79,58,217,220,51,14,221,80,87,34,33,4,187,118,165,248,95,10,105,44,67,222,109,160,103,
242,177,84,203,70,53,72,111,218,249,124,83,174,253,240,119,194,65,164,219,22,197,152,127,170,137,204,
99,126,141,64,135,146,209,244,235,230,85,232,143,122,25,28,115,78,29,144,151,98,97,68,251,182,229,56,
159,74,169,108,131,30,173,224,167,50,241,148,11,134,117,136,175,26,57,188,147,238,61,48,183,2,129,
228,27,86,5);
{$ELSE}
var
  rnd_table: array[0..255] of byte;
{$ENDIF}

function TlkHashTable.DefaultHashOf(const ws: WideString): cardinal;
{$IFDEF DOTNET}
var
  i, j: Integer;
  x1, x2, x3, x4: byte;
begin
  result := 0;
//  result := 0;
  x1 := 0;
  x2 := 1;
  for i := 1 to length(ws) do
    begin
      j := ord(ws[i]);
// first version of hashing
      x1 := (x1 + j) {and $FF};
      x2 := (x2 + 1 + (j shr 8)) {and $FF};
      x3 := rnd_table[x1];
      x4 := rnd_table[x3];
      result := ((x1 * x4) + (x2 * x3)) xor result;
    end;
end;
{$ELSE}
var
  x1, x2, x3, x4: byte;
  p: PWideChar;
begin
  result := 0;
  x1 := 0;
  x2 := 1;
  p := PWideChar(ws);
  while p^ <> #0 do
  begin
    inc(x1, ord(p^)) {and $FF};
    inc(x2, 1 + (ord(p^) shr 8)) {and $FF};
    x3 := rnd_table[x1];
    x4 := rnd_table[x3];
    result := ((x1 * x4) + (x2 * x3)) xor result;
    inc(p);
  end;
end;
{$ENDIF}

procedure TlkHashTable.hswap(j, k, l: Integer);
var
  h: TlkHashItem;
begin
//  h := a_h[j, k];
//  a_h[j, k] := a_h[j, l];
//  a_h[j, l] := h;
  a_x[j].Exchange(k,l);
end;

function TlkHashTable.IndexOf(const ws: WideString): Integer;
var
  i, j, k: Cardinal;
begin
  if not InTable(ws, i, j, k) then
    begin
      result := -1;
    end
  else
    begin
//      result := a_h[j, k].index;
      result := PlkHashItem(a_x[j].Items[k])^.index;
    end;
end;

function TlkHashTable.InTable(const ws: WideString; var i, j, k: cardinal):
  Boolean;
var
  l, wu, wl: Integer;
  x: Cardinal;
  fin: Boolean;
begin
  i := HashOf(ws);
  j := i and $FF;
  result := false;
//  if length(a_h[j]) < 25 then
  if a_x[j].Count < 25 then
    begin
//// for small array use linear search
//      for l := 0 to high(a_h[j]) do
//        if a_h[j, l].hash = i then
//          begin
//            k := l;
//            result := true;
//            break;
//          end;
      for l := 0 to a_x[j].Count-1 do
        if PlkHashItem(a_x[j].Items[l])^.hash = i then
          begin
            k := l;
            result := true;
            break;
          end;
    end
  else
    begin
// for larger array use "binary" search, becouse array is sorted
//      wl := low(a_h[j]);
//      wu := high(a_h[j]);
      wl := 0;
      wu := a_x[j].Count-1;
      repeat
        fin := true;
        if PlkHashItem(a_x[j].Items[wl])^.hash = i then
          begin
            k := wl;
            result := true;
          end
        else if PlkHashItem(a_x[j].Items[wu])^.hash = i then
          begin
            k := wu;
            result := true;
          end
        else if (wu - wl) > 1 then
          begin
            fin := false;
            x := (wl + wu) shr 1;
            if PlkHashItem(a_x[j].Items[x])^.hash > i then
              begin
                wu := x;
              end
            else
              begin
                wl := x;
              end;
          end;
      until fin;
    end;
end;

{$ifndef THREADSAFE}
procedure init_rnd;
var
  x0: Integer;
  i: Integer;
begin
  x0 := 5;
  for i := 0 to 255 do
    begin
      x0 := (x0 * 29 + 71) and $FF;
      rnd_table[i] := x0;
    end;
end;
{$endif}

procedure TlkHashTable.SetHashFunction(const AValue: TlkHashFunction);
begin
  FHashFunction := AValue;
end;

constructor TlkHashTable.Create;
var
  i: Integer;
begin
  inherited;
//  for i := 0 to 255 do SetLength(a_h[i], 0);
  for i := 0 to 255 do a_x[i] := TList.Create;
  HashOf := {$IFDEF FPC}@{$ENDIF}DefaultHashOf;
end;

destructor TlkHashTable.Destroy;
var
  i,j: Integer;
begin
//  for i := 0 to 255 do SetLength(a_h[i], 0);
  for i := 0 to 255 do
    begin
      for j := 0 to a_x[i].Count-1 do Freemem(a_x[i].Items[j]);
      a_x[i].Free;
    end;
  inherited;
end;

function TlkHashTable.SimpleHashOf(const ws: WideString): cardinal;
var
  i: Integer;
begin
  result := length(ws);
  for i := 1 to length(ws) do result := result + ord(ws[i]);
end;

{ TlkJSONstreamed }
{$IFNDEF KOL}

class function TlkJSONstreamed.LoadFromFile(srcname: string):
  TlkJSONbase;
var
  fs: TFileStream;
begin
  result := nil;
  if not FileExists(srcname) then exit;
  try
    fs := TFileStream.Create(srcname, fmOpenRead);
    result := LoadFromStream(fs);
  finally
    if Assigned(fs) then FreeAndNil(fs);
  end;
end;

class function TlkJSONstreamed.LoadFromStream(src: TStream):
  TlkJSONbase;
var
  ws: string;
  len: int64;
begin
  result := nil;
  if not assigned(src) then exit;
  len := src.Size - src.Position;
  SetLength(ws, len);
  src.Read(pchar(ws)^, len);
  result := ParseText(ws);
end;

class procedure TlkJSONstreamed.SaveToFile(obj: TlkJSONbase;
  dstname: string);
var
  fs: TFileStream;
begin
  if not assigned(obj) then exit;
  try
    fs := TFileStream.Create(dstname, fmCreate);
    SaveToStream(obj, fs);
  finally
    if Assigned(fs) then FreeAndNil(fs);
  end;
end;

class procedure TlkJSONstreamed.SaveToStream(obj: TlkJSONbase;
  dst: TStream);
var
  ws: string;
begin
  if not assigned(obj) then exit;
  if not assigned(dst) then exit;
  ws := GenerateText(obj);
  dst.Write(pchar(ws)^, length(ws));
end;

{$ENDIF}

{ TlkJSONdotnetclass }

{$IFDEF DOTNET}

procedure TlkJSONdotnetclass.AfterConstruction;
begin

end;

procedure TlkJSONdotnetclass.BeforeDestruction;
begin

end;

constructor TlkJSONdotnetclass.Create;
begin
  inherited;
  AfterConstruction;
end;

destructor TlkJSONdotnetclass.Destroy;
begin
  BeforeDestruction;
  inherited;
end;

{$ENDIF DOTNET}

{$ifndef THREADSAFE}
initialization
  init_rnd;
{$ENDIF}
end.

