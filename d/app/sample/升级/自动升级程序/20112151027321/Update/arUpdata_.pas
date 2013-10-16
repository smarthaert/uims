unit arUpdata_;
// Download by http://www.codefans.net
interface

uses
  Classes;

type
  arUpdata = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation
uses update;


procedure arUpdata.Execute;
begin
  UpdataFrm.ReadUpdateMessage(Updatafrm.inifile,
  Updatafrm.Updatefiles,Updatafrm.ProgressStatus);
  UpdataFrm.ShlExecute(Updatafrm.inifile);
end;

end.
