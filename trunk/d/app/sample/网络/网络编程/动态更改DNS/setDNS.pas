unit setDNS;
    {Download by http://www.codefans.net}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, StdCtrls, Mask, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edt1: TLabeledEdit;
    Edt2: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  function isNT:boolean;
  end;

var
  Form1: TForm1;

procedure SetTCPIPDNSAddresses(sIPs : string);
procedure SaveStringToRegistry_LOCAL_MACHINE(sKey, sItem, sVal : string);

implementation

{$R *.dfm}
procedure TForm1.Button1Click(Sender: TObject);
var
  s : string;
begin
  s := Edt1.Text + ',' + Edt2.Text;
  if s=',' then s := '';
  SetTCPIPDNSAddresses(s);
end;

function TForm1.isNT:boolean;
var
  reg : TRegIniFile;
begin
  reg := TRegIniFile.Create( '' );
  reg.RootKey := HKEY_LOCAL_MACHINE;
  if reg.OpenKey('Software\Microsoft\Windows NT',false)
  then Result := true
  else Result := false;
  reg.Free;
end;

procedure SetTCPIPDNSAddresses(sIPs : string);
begin
  if Form1.isNT
  then SaveStringToRegistry_LOCAL_MACHINE('SYSTEM\CurrentControlSet' +'\Services\Tcpip\Parameters','NameServer',sIPs)
  else SaveStringToRegistry_LOCAL_MACHINE('SYSTEM\CurrentControlSet' +'\Services\VxD\MSTCP','NameServer',sIPs );
end;

procedure SaveStringToRegistry_LOCAL_MACHINE(sKey, sItem, sVal : string);
var
  reg : TRegIniFile;
begin
  reg := TRegIniFile.Create('');
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.WriteString(sKey, sItem, sVal + #0);
  reg.Free;
end;

end.
