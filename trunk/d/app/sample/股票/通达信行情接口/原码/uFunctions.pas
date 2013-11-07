unit uFunctions;

interface
uses SysUtils, Classes, Windows;

//取的汉字拼音的首字母
function GetHzPy(const AHzStr: string): string;

implementation

function GetHzPy(const AHzStr: string): string;
const
  ChinaCode: array[0..25, 0..1] of Integer = ((1601, 1636), (1637, 1832), (1833, 2077),
    (2078, 2273), (2274, 2301), (2302, 2432), (2433, 2593), (2594, 2786), (9999, 0000),
    (2787, 3105), (3106, 3211), (3212, 3471), (3472, 3634), (3635, 3722), (3723, 3729),
    (3730, 3857), (3858, 4026), (4027, 4085), (4086, 4389), (4390, 4557), (9999, 0000),
    (9999, 0000), (4558, 4683), (4684, 4924), (4925, 5248), (5249, 5589));
var
  i, j, HzOrd: integer;
begin
  i := 1;
  while i <= Length(AHzStr) do begin
    if (AHzStr[i] >= #160) and (AHzStr[i + 1] >= #160) then begin
      HzOrd := (Ord(AHzStr[i]) - 160) * 100 + Ord(AHzStr[i + 1]) - 160;
      for j := 0 to 25 do begin
        if (HzOrd >= ChinaCode[j][0]) and (HzOrd <= ChinaCode[j][1]) then begin
          Result := Result + char(byte('A') + j);
          break;
        end;
      end;
      Inc(i);
    end else begin
    	Result := Result + AHzStr[i];
    end;
    Inc(i);
  end;
end;

end.
