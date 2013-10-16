unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock, CNC, IPEdit;

type
  TForm1 = class(TForm)
    ipdt1: TIPEdit;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  wsdata: TWSAData;

implementation

{$R *.dfm}

function Ip2Str(Ip: cardinal): string;
var
  i: in_addr;
begin
  i.S_addr := ip;
  Result := strpas(inet_ntoa(i));
end;

function Str2IP(const HostName: string): cardinal;
var
  hostEnt: PHostEnt;
begin
  Result := 0;
  WSAStartup($0101, wsdata);
  hostEnt := GetHostByName(PChar(HostName));
  if Assigned(hostEnt) then
    if Assigned(hostEnt^.h_addr_list) then
      Move(hostEnt^.h_addr_list^[0], Result, 4);
  WSACleanup;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  if IPIsCNC(Str2IP(ipdt1.IPString)) then
    ShowMessage('ÍøÍ¨')
  else
    ShowMessage('·ÇÍøÍ¨');
end;

end.

