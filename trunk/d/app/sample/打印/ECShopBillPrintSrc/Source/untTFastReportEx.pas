unit untTFastReportEx;

interface

uses
  Windows, Messages, SysUtils, Classes, IniFiles, StrUtils, Forms, untOrderReport;

type

//  TOrderPrintInfo = record
//     SenderName,
//     SenderAddress,
//     SenderPhone,
//     SenderZipCode,
//     ContentName,
//     RecipientName,
//     RecipientAddress,
//     RecipientZipCode,
//     RecipientPhone,
//     RecipientMobile,
//     PayAmount_small,
//     PayAmount_big,
//     PayAmount_big2,
//     PayAmount_big3,
//     Payment,
//     ShippingCode,
//     To_Buyer:string;
//  end;

  TFastReportEx = class(TComponent)
  private
    { Private declarations }
    FAppDir: string;
  protected
    { Protected declarations }

  public
    { Public declarations }
    procedure PrintOrder(JobName: string; Order_id:string; OrderInfo: TOrderPrintInfo; batch: Boolean=False);
  published
    { Published declarations }
    property AppDirectory: string read FAppDir write FAppDir;
  end;

implementation

uses untPrintWindow, untConsts;

{ TFastReportEx }

procedure TFastReportEx.PrintOrder(JobName: string; Order_id:string;
  OrderInfo: TOrderPrintInfo; batch: Boolean);
var
  sAppDir: string;
begin
  if Trim(FAppdir) = '' then
  begin
    Application.MessageBox('请指定组件工作路径!', '提示', MB_ICONINFORMATION);
    Exit;
  end;


  if RightStr(FAppDir, 1) <> '\' then sAppDir := FAppDir + '\' else sAppDir := FAppDir;

  if not DirectoryExists(sAppDir + 'Reports') then
  begin
    try
      CreateDir(sAppDir + 'Reports');
    except
      Application.MessageBox(PChar('创建' + sAppDir + 'Reports,目录时发生错误,请重试!'), '系统错误', MB_ICONSTOP);
      Exit;
    end;
  end;

  try
    frmPrintWindow := TfrmPrintWindow.Create(nil);
    frmPrintWindow.isAppDir := sAppDir;
    frmPrintWindow.sFormatFileName := sAppDir + 'Reports\' + JobName + '.ini';
    frmPrintWindow.OrderPrintInfo:=OrderInfo;
    frmPrintWindow.order_id:=Order_id;
    frmPrintWindow.batch:=batch;//是否批量打印
    PIsPrint:=False;
    if batch and (PReportFile<>'') then
      frmPrintWindow.BitBtn5.Click
    else
      frmPrintWindow.ShowModal;
  finally
    frmPrintWindow.Free;
  end;
end;

end.
