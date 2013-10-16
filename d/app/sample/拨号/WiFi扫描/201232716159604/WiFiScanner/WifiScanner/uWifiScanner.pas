unit uWifiScanner;
//This delphi source code was downloaded from www.delphibasics.info
//Author: RRUZ & Arhitect
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, ExtCtrls, ComCtrls,  nduWlanAPI,
  nduWlanTypes;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    procedure Scan();
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function DOT11_AUTH_ALGORITHM_To_String( Dummy :Tndu_DOT11_AUTH_ALGORITHM):String;
begin
    Result:='';
    case Dummy of
        DOT11_AUTH_ALGO_80211_OPEN          : Result:= '80211_OPEN';
        DOT11_AUTH_ALGO_80211_SHARED_KEY    : Result:= '80211_SHARED_KEY';
        DOT11_AUTH_ALGO_WPA                 : Result:= 'WPA';
        DOT11_AUTH_ALGO_WPA_PSK             : Result:= 'WPA_PSK';
        DOT11_AUTH_ALGO_WPA_NONE            : Result:= 'WPA_NONE';
        DOT11_AUTH_ALGO_RSNA                : Result:= 'RSNA';
        DOT11_AUTH_ALGO_RSNA_PSK            : Result:= 'RSNA_PSK';
        DOT11_AUTH_ALGO_IHV_START           : Result:= 'IHV_START';
        DOT11_AUTH_ALGO_IHV_END             : Result:= 'IHV_END';
    end;
end;

function DOT11_CIPHER_ALGORITHM_To_String( Dummy :Tndu_DOT11_CIPHER_ALGORITHM):String;
begin
    Result:='';
    case Dummy of
  	DOT11_CIPHER_ALGO_NONE      : Result:= 'NONE';
    DOT11_CIPHER_ALGO_WEP40     : Result:= 'WEP40';
    DOT11_CIPHER_ALGO_TKIP      : Result:= 'TKIP';
    DOT11_CIPHER_ALGO_CCMP      : Result:= 'CCMP';
    DOT11_CIPHER_ALGO_WEP104    : Result:= 'WEP104';
    DOT11_CIPHER_ALGO_WPA_USE_GROUP : Result:= 'WPA_USE_GROUP OR RSN_USE_GROUP';
    //DOT11_CIPHER_ALGO_RSN_USE_GROUP : Result:= 'RSN_USE_GROUP';
    DOT11_CIPHER_ALGO_WEP           : Result:= 'WEP';
    DOT11_CIPHER_ALGO_IHV_START     : Result:= 'IHV_START';
    DOT11_CIPHER_ALGO_IHV_END       : Result:= 'IHV_END';
    end;
end;

procedure TFORM1.Scan();
const
WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES =$00000001;
var
  hClient              : THandle;
  dwVersion            : DWORD;
  ResultInt            : DWORD;
  pInterface           : Pndu_WLAN_INTERFACE_INFO_LIST;
  i                    : Integer;
  j                    : Integer;
  pAvailableNetworkList: Pndu_WLAN_AVAILABLE_NETWORK_LIST;
  pInterfaceGuid       : PGUID;
  SDummy               : string;
  l:tlistItem;
begin
  ResultInt:=WlanOpenHandle(1, nil, @dwVersion, @hClient);
  if  ResultInt<> ERROR_SUCCESS then
  begin
     WriteLn('Error Open CLient'+IntToStr(ResultInt));
     Exit;
  end;

  ResultInt:=WlanEnumInterfaces(hClient, nil, @pInterface);
  if  ResultInt<> ERROR_SUCCESS then
  begin
     WriteLn('Error Enum Interfaces '+IntToStr(ResultInt));
     exit;
  end;

  for i := 0 to pInterface^.dwNumberOfItems - 1 do
  begin
   COMBOBOX1.Items.Add('Interface       ' + pInterface^.InterfaceInfo[i].strInterfaceDescription);
   edit1.Text:=('GUID            ' + GUIDToString(pInterface^.InterfaceInfo[i].InterfaceGuid));

   pInterfaceGuid:= @pInterface^.InterfaceInfo[pInterface^.dwIndex].InterfaceGuid;

      ResultInt:=WlanGetAvailableNetworkList(hClient,pInterfaceGuid,WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES,nil,pAvailableNetworkList);
      if  ResultInt<> ERROR_SUCCESS then
      begin
         WriteLn('Error WlanGetAvailableNetworkList '+IntToStr(ResultInt));
         Exit;
      end;

        for j := 0 to pAvailableNetworkList^.dwNumberOfItems - 1 do
        Begin
        l:=listview1.Items.Add;

           SDummy:=PChar(@pAvailableNetworkList^.Network[j].dot11Ssid.ucSSID);
           l.Caption:=(SDummy);
           l.SubItems.Add(Format('%d ',[pAvailableNetworkList^.Network[j].wlanSignalQuality])+'%');
           //SDummy := GetEnumName(TypeInfo(Tndu_DOT11_AUTH_ALGORITHM),integer(pAvailableNetworkList^.Network[j].dot11DefaultAuthAlgorithm)) ;
           SDummy:=DOT11_AUTH_ALGORITHM_To_String(pAvailableNetworkList^.Network[j].dot11DefaultAuthAlgorithm);
           l.SubItems.Add(SDummy);
           SDummy:=DOT11_CIPHER_ALGORITHM_To_String(pAvailableNetworkList^.Network[j].dot11DefaultCipherAlgorithm);
           l.SubItems.Add(SDummy);

        End;
  end;

  WlanCloseHandle(hClient, nil);

end;
procedure TForm1.FormCreate(Sender: TObject);
begin
Scan();
end;

end.

