unit UnitTimeThread;

interface

uses
  Classes,SysUtils;

type
  TimeThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure DoEverySecond;
  end;

implementation
uses UnitMainForm;
{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TimeThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TimeThread }
procedure TimeThread.DoEverySecond;
begin
  frmMainForm.DoEverySecond;
end;
procedure TimeThread.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    Synchronize(DoEverySecond);
    Sleep(1000);
  end;
end;

end.
 