unit Tools;

interface

uses
  Registry,Windows;

  Function  Turn(Const S:String):String;
  Function  JustPathname(Const PathName:String):String;
  function  regReadString(const Path,Name: String): String;
  procedure regWriteString(const Path,Name,Value: String);
  function  ImeSet():String;

implementation

Function Turn;
Var
  I:Byte;
Begin
  Result := '';
  If S <> '' Then
    For I := 1 To Length(S) Do
      Result := S[I] + Result;
End;

Function JustPathName;
var
  SS:String;
  I:Integer;
begin
  SS := Turn(PathName);
  I := Pos('\',SS);  {pr. c:\rwewe\kokol.txt}
  If I = 0 Then
    I := Pos(':',SS);
  If I = 0 Then
    Result := '' {not path}
  else
    Result := Turn(Copy(SS,I+1,255));
End;

function regReadString;
var
  aRegistry : TRegistry;
begin
  aRegistry:=TRegistry.Create;
  try
    with aRegistry do
    begin
      RootKey:=HKEY_LOCAL_MACHINE;
      OpenKey(Path,True);
      Result:=ReadString(Name);
    end;
  finally
    aRegistry.Free;
  end;
end;

procedure regWriteString(const Path,Name,Value: String);
var
  aRegistry : TRegistry;
begin
  aRegistry:=TRegistry.Create;
  try
    with aRegistry do
    begin
      RootKey:=HKEY_LOCAL_MACHINE;
      OpenKey(Path,True);
      WriteString(Name,Value);
    end;
  finally
    aRegistry.Free;
  end;
end;

function ImeSet;
var
  CurrentUser:String;
begin
  CurrentUser:=regReadString('\SOFTWARE\Fly Dance Software\Tax','CurrentUser');
  Result:=regReadString('\SOFTWARE\Fly Dance Software\Tax',CurrentUser);
end;


end.
