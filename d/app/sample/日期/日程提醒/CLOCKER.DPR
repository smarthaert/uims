program clocker;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  shortcut in 'shortcut.pas' {frmshortcut};

{$R *.RES}
var
  MutexHandle: THandle;
  hPrevInst: Boolean;
begin
     // -== Check to see if the named mutex object existed before this call ==-
 	MutexHandle := CreateMutex(nil, TRUE, 'MysampleAppMutex');
 	if MutexHandle <> 0 then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
    // -== set hPrevInst property and close the mutex handle ==-
    begin
      MessageBox(0, '该程序已经运行!.',
                '电子提醒簿', mb_IconHand);
      hPrevInst := TRUE;
      CloseHandle(MutexHandle);
      Halt; // 'Halt' Is the actual one that prevents a second instance
           // of your app from running.
    end
    else
    begin
      // -== indicate no previous instance was found ==-
      hPrevInst := FALSE;
      end;
  end
  else
  begin
       // -== indicate no previous instance was found ==-
     hPrevInst := FALSE;
   end;

  Application.Initialize;
  Application.Title := '电子提醒簿';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.Run;

end.
