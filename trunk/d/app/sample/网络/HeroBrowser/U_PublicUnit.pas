unit U_PublicUnit;

interface

Uses SysUtils, StrUtils;

function FormatUrl(Var Url: String): Boolean;



implementation

function FormatUrl(Var Url: String): Boolean;
begin
  Result := False;
  If (SameText(LeftBStr(Url, 3), 'res')
    or (Pos('.', Url) = 0)) Then
      Exit;

  Result := True;
  Url := StringReplace(Url, '#top', '', [rfReplaceAll, rfIgnoreCase]);
end;

end.
