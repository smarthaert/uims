{ MDI Embedded Web Browser Demo by bsalsa
 updates: http://www.bsalsa.com/ }

unit Child;

interface

uses
  Classes, Forms, OleCtrls,  EmbeddedWB, Controls, SHDocVw_EWB;     

type
  TChildFrm = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    procedure EmbeddedWB1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure EmbeddedWB1DownloadComplete(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  ChildFrm: TChildFrm;

implementation

uses frmMain;

{$R *.DFM}

procedure TChildFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TChildFrm.EmbeddedWB1DownloadComplete(Sender: TObject);
begin
   Caption := Caption+' ' + frmMain.MainFrm.IEAddress1.Text;
end;

procedure TChildFrm.EmbeddedWB1NewWindow2(ASender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
var
   NewApp: TChildFrm;
begin
   NewApp := TChildFrm.Create(Owner);
   NewApp.Visible := true;
   ppdisp := NewApp.EmbeddedWB1.Application;
end;

end.
