unit DownInifile;
// Download by http://www.codefans.net
interface

uses
  Classes, UrlMon;

type
  Dwninifile = class(TThread)
  private
  protected
  public
    procedure Execute; override;
  end;

implementation
uses  Update;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure Dwninifile.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ Dwninifile }


procedure Dwninifile.Execute;
begin
  { Place thread code here }
end;

end.
 