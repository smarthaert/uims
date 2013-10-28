program HXDGL;

uses
  Forms,
  HXDGLMain in 'HXDGLMain.pas' {MainForm},
  HxdInput in 'HxdInput.pas' {VerifyForm},
  MdkInput in 'MdkInput.pas' {NameForm},
  HIView in 'HIView.pas' {ViewForm},
  FFPHM in 'FFPHM.pas' {InvoiceForm},
  FHXDHM in 'FHXDHM.pas' {CodeForm},
  FLDRQ in 'FLDRQ.pas' {DateForm},
  FLDR in 'FLDR.pas' {ReceiveForm},
  FALLSH in 'FALLSH.pas' {GetAllForm},
  FALLJD in 'FALLJD.pas' {HandInAllForm},
  FALLWSH in 'FALLWSH.pas' {PrintAllNoGetForm},
  FYWYSH in 'FYWYSH.pas' {GetYWYForm},
  FYWYWSH in 'FYWYWSH.pas' {PrintYWYNoGetForm},
  FYWYJD in 'FYWYJD.pas' {HandInLDRForm},
  FYWYWJD in 'FYWYWJD.pas' {PrintLDRNoHandInForm},
  PREVIEW_WSH_ALL in 'PREVIEW_WSH_ALL.pas' {WSHALLForm},
  PREVIEW_WSH_YWY in 'PREVIEW_WSH_YWY.pas' {PrintNoCancel},
  FALLWJD in 'FALLWJD.pas' {PrintNoHandInAllForm},
  PREVIEW_WJD_ALL in 'PREVIEW_WJD_ALL.pas' {PrintNoHandInAll},
  PREVIEW_WJD_YWY in 'PREVIEW_WJD_YWY.pas' {PrintNoHandInLDR},
  DataOut in 'DataOut.pas' {DataOutForm},
  DataIn in 'DataIn.pas' {DataInForm},
  FYWY in 'FYWY.pas' {OperatorForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '核销单管理系统';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
