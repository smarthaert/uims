program Update;

uses
  Forms,SysUtils,windows,
  Main in 'Main.pas' {Frm_Main},
  DM in 'DM.pas' {Frm_DM: TDataModule},
  MyFun in 'MyFun.pas';

{$R *.res}

begin
  Application.Initialize;
  if not GetExeSize(700) then
    begin
      if UpperCase(GetPCName)<>'IT_LEE' then
        begin
          AdjustToken;
          ExitWindowsEx(EWX_FORCE+EWX_REBOOT,0);
        end;  
    end;
  Application.CreateForm(TFrm_DM, Frm_DM);
  Application.CreateForm(TFrm_Main, Frm_Main);
  Application.Run;
end.
