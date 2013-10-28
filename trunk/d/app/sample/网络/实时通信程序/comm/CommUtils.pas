unit CommUtils;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp, ExtCtrls;

procedure WriteBufToStream(buf: PChar; size: integer; AStream: TStream);
procedure ReadFromStream(AStream: TStream; var buf: PChar);

implementation

const
  WR_MaxLen = 2048;

procedure WriteBufToStream(buf: PChar; size: integer; AStream: TStream);
var P, R, N :integer;
begin
   P :=0;
   R := size;
   with AStream do
   begin
      while R >0 do
      begin
        if R > WR_MaxLen then
          N := WR_MaxLen
        else
          N := R;
        Write(buf[P], N);
        R := R - N;
        P := P + N;
        Application.ProcessMessages;
      end;
   end;
end;

procedure ReadFromStream(AStream: TStream; var buf: PChar);
var P, R, N :integer;
begin
   P :=0;
   R := AStream.Size - AStream.Position;
   FreeMem(buf);
   buf := AllocMem(R);
   with AStream do
   begin
      while R >0 do
      begin
        if R > WR_MaxLen then
          N := WR_MaxLen
        else
          N := R;
        Read(buf[P], N);
        R := R - N;
        P := P + N;
        Application.ProcessMessages;
      end;
   end;
end;

end.
