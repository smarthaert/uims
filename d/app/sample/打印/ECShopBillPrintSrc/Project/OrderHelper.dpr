program OrderHelper;

uses
  Forms,
  Controls,
  untMain in '..\Source\untMain.pas' {frmMain},
  untLogin in '..\Source\untLogin.pas' {frmLogin},
  untSplash in '..\Source\untSplash.pas' {frmSplash},
  untConsts in '..\Source\untConsts.pas',
  untOrderInfo in '..\Source\untOrderInfo.pas' {frmOrderInfo},
  untSearchOrder in '..\Source\untSearchOrder.pas' {frmSearchOrder},
  untOrderReport in '..\Source\untOrderReport.pas',
  untAbout in '..\Source\untAbout.pas' {frmAbout},
  untTFastReportEx in '..\Source\untTFastReportEx.pas',
  untPrintWindow in '..\Source\untPrintWindow.pas' {frmPrintWindow},
  untAddFormat in '..\Source\untAddFormat.pas' {frmAddFormat};

{$R *.res}

begin
  Application.Title := '快递单打印';
  frmLogin:=TfrmLogin.Create(Application);
  frmLogin.ShowModal;
  if (frmLogin.ModalResult = mrOk) then
  begin
    try
      frmSplash:=TfrmSplash.Create(Application);
      with frmSplash do
      begin
        StartLoad;
        UpdateStatus('正在载入启动参数', 10);
        UpdateStatus('正在初始化配置', 25);
        UpdateStatus('载入客户端数据', 35);
        CheckVersion('正在检测版本号', 50);
        Application.Initialize;
        Application.CreateForm(TfrmMain, frmMain);
        UpdateStatus('开始载入远程配置数据', 60);
        UpdateStatus('开始载入远程权限数据', 70);
        UpdateStatus('开始载入远程订单数据', 90);
        Stopload;
      end;
    finally
      frmSplash.Close;
      frmSplash.Free;
    end;
    Application.Run;
  end
  else
    Exit;
end.
