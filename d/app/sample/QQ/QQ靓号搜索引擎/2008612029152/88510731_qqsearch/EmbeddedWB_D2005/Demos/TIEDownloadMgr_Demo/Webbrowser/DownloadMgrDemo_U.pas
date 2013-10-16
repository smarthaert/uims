unit DownloadMgrDemo_U;

interface

uses
	{$IFDEF VER140}Variants,{$ENDIF} ActiveX, IEConst, Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, OleCtrls, EmbeddedWB, IEDownloadMgr, SHDocVw_EWB, EwbAcc;

type
  TForm1 = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    Button1: TButton;
    IEDownloadMgr1: TIEDownloadMgr;
    edUrl: TEdit;
    procedure Button1Click(Sender: TObject);
{$IFDEF VER140}
		function EmbeddedWB1QueryService(const rsid, iid: TGUID;
      out Obj:  IInterface ): HRESULT;
{$ELSE}
    function EmbeddedWB1QueryService(const rsid, iid: TGUID;
      out Obj: IUnknown ): HRESULT;
    procedure EmbeddedWB1AddressBar(Sender: TObject; AddressBar: WordBool);
    procedure edUrlKeyPress(Sender: TObject; var Key: Char);
{$ENDIF}
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
//  Embeddedwb1.Go('http://www.techvanguards.com/products/eventsinkimp/');
  Embeddedwb1.Go('http://www.web.de');
end;

function TForm1.EmbeddedWB1QueryService(const rsid, iid: TGUID;
  out Obj:{$IFDEF VER140} IInterface {$ELSE} IUnknown {$ENDIF}): HRESULT;
begin
  if IsEqualGuid(rsid, IID_IDownloadManager)
  then begin
    obj := IeDownloadMgr1 as IDownloadManager;
    Result := S_OK
  end else
    Result := E_NOINTERFACE;
end;

procedure TForm1.EmbeddedWB1AddressBar(Sender: TObject;
  AddressBar: WordBool);
begin
  ShowMessage('OnAddressBar');
end;

procedure TForm1.edUrlKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Embeddedwb1.Go(edUrl.Text);
  end;
end;

end.

