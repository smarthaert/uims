unit untPrintWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, StdCtrls, Buttons,
  frxCross,frxChart,frxBarcode,frxOLE,Menus,frxRich,frxChBox,frxDBSet,StrUtils,
  frxClass,frxDesgn,frxExportCSV,frxExportRTF,frxExportTXT,IniFiles, untAddFormat, untTFastReportEx, untOrderReport;

type

  TfrmPrintWindow = class(TForm)
    LV1: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnPrintPreView: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    PopupMenu4: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    PopupMenu3: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    ImageList2: TImageList;
    ImageList1: TImageList;
    SaveToWord: TSaveDialog;
    saveToExcel: TSaveDialog;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxCSVExport1: TfrxCSVExport;
    frxRTFExport1: TfrxRTFExport;
    
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnPrintPreViewClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure GetFormat;
    procedure SaveFormat;
    procedure FormShow(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    sFormatFileName: string;
    isAppDir: string;
    order_id:string;
    OrderPrintInfo:TOrderPrintInfo;
    batch:Boolean;
     
  end;

var
  frmPrintWindow: TfrmPrintWindow;

implementation

uses untConsts;

{$R *.dfm}

procedure TfrmPrintWindow.BitBtn6Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrintWindow.BitBtn1Click(Sender: TObject);
var po: Tpoint;
begin
  po.X := BitBtn1.Left;
  po.Y := BitBtn1.Top + BitBtn1.Height + 1;
  po := ClientToScreen(PO);
  popupmenu4.Popup(po.x, po.y);

end;

procedure TfrmPrintWindow.BitBtn2Click(Sender: TObject);
var po: Tpoint;
begin
  po.X := BitBtn2.Left;
  po.Y := BitBtn2.Top + BitBtn2.Height + 1;
  po := ClientToScreen(PO);
  popupmenu3.Popup(po.x, po.y);


end;

procedure TfrmPrintWindow.BitBtn3Click(Sender: TObject);
var
  rlvListitem: TListitem;
  sRepFileName: string;
begin
  if LV1.Selected = nil then
  begin
    Application.messagebox('请指定一个需要设计的格式!', '操作错误', MB_ICONWARNING);
    Exit;
  end;
  rlvListitem := LV1.Selected;
  sRepFileName := rlvListitem.SubItems[1];
  frxReport1.Clear;
  frxReport1.LoadFromFile(isAppDir + '\Reports\' + sRepFileName);
  frxReport1.DesignReport;

end;

procedure TfrmPrintWindow.btnPrintPreViewClick(Sender: TObject);
var
  rlvListitem: TListitem;
  sRepFileName: string;
begin
  if LV1.Selected = nil then
  begin
    Application.messagebox('请选择一个报表!', '操作错误', MB_ICONWARNING);
    Exit;
  end;
  rlvListitem := LV1.Selected;
  sRepFileName := rlvListitem.SubItems[1];
  frxReport1.Clear;
  frxReport1.LoadFromFile(isAppDir + '\Reports\' + sRepFileName);
  //report.Title := RlvListitem.SubItems[0];

  if frxReport1.PagesCount = 0 then
  begin
    application.MessageBox('指定的报表格式没有设计,请先设计!', '提示', MB_ICONINFORMATION);
    Exit;
  end;

    //报表变量
      if frxReport1.FindObject('SenderName')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderName') ).Memo.Text:=OrderPrintInfo.SenderName;
    if frxReport1.FindObject('SenderAddress')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderAddress') ).Memo.Text:=OrderPrintInfo.SenderAddress;
    if frxReport1.FindObject('SenderZipCode')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderZipCode') ).Memo.Text:=OrderPrintInfo.SenderZipCode;
    if frxReport1.FindObject('SenderPhone')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderPhone') ).Memo.Text:=OrderPrintInfo.SenderPhone;
    if frxReport1.FindObject('ContentName')<>nil then
      TfrxMemoView( frxReport1.FindObject('ContentName') ).Memo.Text:=OrderPrintInfo.ContentName;
    if frxReport1.FindObject('RecipientName')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientName') ).Memo.Text:=OrderPrintInfo.RecipientName;
    if frxReport1.FindObject('RecipientAddress')<>nil then
    begin
      if OrderPrintInfo.To_Buyer<>'' then
        TfrxMemoView( frxReport1.FindObject('RecipientAddress') ).Memo.Text:=OrderPrintInfo.RecipientAddress + '('+ OrderPrintInfo.To_Buyer + ')'
      else
        TfrxMemoView( frxReport1.FindObject('RecipientAddress') ).Memo.Text:=OrderPrintInfo.RecipientAddress;

    end;
    if frxReport1.FindObject('RecipientZipCode')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientZipCode') ).Memo.Text:=OrderPrintInfo.RecipientZipCode;
    if frxReport1.FindObject('RecipientPhone')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientPhone') ).Memo.Text:=OrderPrintInfo.RecipientPhone;
    if frxReport1.FindObject('RecipientMobile')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientMobile') ).Memo.Text:=OrderPrintInfo.RecipientMobile;
    if frxReport1.FindObject('PayAmount_small')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_small') ).Memo.Text:=OrderPrintInfo.PayAmount_small;
    if frxReport1.FindObject('PayAmount_big')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_big') ).Memo.Text:=OrderPrintInfo.PayAmount_big;
    if frxReport1.FindObject('PayAmount_big2')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_big2') ).Memo.Text:=OrderPrintInfo.PayAmount_big2;
    if frxReport1.FindObject('PayAmount_big3')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_big3') ).Memo.Text:=OrderPrintInfo.PayAmount_big3;
    if frxReport1.FindObject('Payment')<>nil then
      TfrxMemoView( frxReport1.FindObject('Payment') ).Memo.Text:=OrderPrintInfo.Payment;
  //报表变量
  
  frxReport1.ShowReport;

end;

procedure TfrmPrintWindow.BitBtn5Click(Sender: TObject);
//var
  //vlist: tlistitem;
  //str: string;
begin
  if (not batch) and (LV1.Selected = nil) then
  begin
    application.MessageBox('请选择要打印的报表！', '提示', MB_ICONINFORMATION);
    Exit;
  end;
  
//  if (not batch) then
//    vlist := LV1.Selected;

  if (not batch) or (PReportFile='') then
     PReportFile:= isAppDir + '\Reports\' + LV1.Selected.SubItems[1];

  //str := isAppDir + '\Reports\' + vList.SubItems[1];
  frxReport1.LoadFromFile(PReportFile);

  if batch and (PPrintName<>'') then //取消打印时弹出的选择打印机对话框
  begin
    frxReport1.PrintOptions.ShowDialog:=False; //打印时是否弹出选择打印机等选项的对话框
    frxReport1.PrintOptions.Printer:=PPrintName;//设置输出的打印机名称
  end
  else
    frxReport1.PrintOptions.ShowDialog:=True;

  PPrintName:=frxReport1.PrintOptions.Printer;//设置输出的打印机名称

  if frxReport1.PagesCount = 0 then
  begin
    application.MessageBox('指定的报表格式没有设计,请先设计!', '提示', MB_ICONINFORMATION);
    Exit;
  end;
  //报表变量
      if frxReport1.FindObject('SenderName')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderName') ).Memo.Text:=OrderPrintInfo.SenderName;
    if frxReport1.FindObject('SenderAddress')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderAddress') ).Memo.Text:=OrderPrintInfo.SenderAddress;
    if frxReport1.FindObject('SenderZipCode')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderZipCode') ).Memo.Text:=OrderPrintInfo.SenderZipCode;
    if frxReport1.FindObject('SenderPhone')<>nil then
      TfrxMemoView( frxReport1.FindObject('SenderPhone') ).Memo.Text:=OrderPrintInfo.SenderPhone;
    if frxReport1.FindObject('ContentName')<>nil then
      TfrxMemoView( frxReport1.FindObject('ContentName') ).Memo.Text:=OrderPrintInfo.ContentName;
    if frxReport1.FindObject('RecipientName')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientName') ).Memo.Text:=OrderPrintInfo.RecipientName;
    if frxReport1.FindObject('RecipientAddress')<>nil then
    begin
      if OrderPrintInfo.To_Buyer<>'' then
        TfrxMemoView( frxReport1.FindObject('RecipientAddress') ).Memo.Text:=OrderPrintInfo.RecipientAddress + '('+ OrderPrintInfo.To_Buyer + ')'
      else
        TfrxMemoView( frxReport1.FindObject('RecipientAddress') ).Memo.Text:=OrderPrintInfo.RecipientAddress;

    end;
    if frxReport1.FindObject('RecipientZipCode')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientZipCode') ).Memo.Text:=OrderPrintInfo.RecipientZipCode;
    if frxReport1.FindObject('RecipientPhone')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientPhone') ).Memo.Text:=OrderPrintInfo.RecipientPhone;
    if frxReport1.FindObject('RecipientMobile')<>nil then
      TfrxMemoView( frxReport1.FindObject('RecipientMobile') ).Memo.Text:=OrderPrintInfo.RecipientMobile;
    if frxReport1.FindObject('PayAmount_small')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_small') ).Memo.Text:=OrderPrintInfo.PayAmount_small;
    if frxReport1.FindObject('PayAmount_big')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_big') ).Memo.Text:=OrderPrintInfo.PayAmount_big;
    if frxReport1.FindObject('PayAmount_big2')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_big2') ).Memo.Text:=OrderPrintInfo.PayAmount_big2;
    if frxReport1.FindObject('PayAmount_big3')<>nil then
      TfrxMemoView( frxReport1.FindObject('PayAmount_big3') ).Memo.Text:=OrderPrintInfo.PayAmount_big3;
    if frxReport1.FindObject('Payment')<>nil then
      TfrxMemoView( frxReport1.FindObject('Payment') ).Memo.Text:=OrderPrintInfo.Payment;
  //报表变量

  PIsPrint:=True; //设置为已打印

  if PIsPrint then
     postOrerShipping(order_id, PServiceURL); //变改发货状态

 if frxReport1.PrepareReport then
   frxReport1.Print;

 //关闭窗口
 Self.Close;
end;

procedure TfrmPrintWindow.MenuItem1Click(Sender: TObject);
var
  Vlist: TListitem;
  sExportFileName: string;
begin
  if LV1.Selected <> nil then
  begin
    vList := LV1.Selected;
    SaveToExcel.FileName := vList.SubItems[0] + '.xls';
    if SaveToExcel.Execute then
    begin
      sExportFileName := SaveToExcel.FileName;
      frxReport1.LoadFromFile(isAppDir + '\Reports\' + vList.SubItems[1]);
      frxReport1.PrepareReport;
      if LowerCase(rightstr(sExportFileName, 3)) <> 'xls' then
        sExportFileName := sExportFileName + '.xls';
      //Report.ExportTo(ExportToExcel, sExportFileName);
      frxRTFExport1.FileName:=sExportFileName;
      frxReport1.Export(frxRTFExport1);
    end;
  end;

end;

procedure TfrmPrintWindow.MenuItem2Click(Sender: TObject);
var
  Vlist: TListitem;
  sExportFileName: string;
begin
  if LV1.Selected <> nil then
  begin
    vList := LV1.Selected;
    SaveToWord.FileName := vList.SubItems[0] + '.rtf';
    if SaveToWord.Execute then
    begin
      sExportFileName := SaveToWord.FileName;
      frxReport1.LoadFromFile(isAppDir + '\Reports\' + vList.SubItems[1]);
      frxReport1.PrepareReport;
      if LowerCase(rightstr(sExportFileName, 3)) <> 'rtf' then
        sExportFileName := sExportFileName + '.rtf';
      //Report.ExportTo(ExportToWord, sExportFileName);

      frxRTFExport1.FileName:=sExportFileName;
      frxReport1.Export(frxRTFExport1);
    end;
  end;

end;

procedure TfrmPrintWindow.GetFormat;
var
  i, irepcount: integer;
  rlvlistitem: Tlistitem;
  fini: tinifile;
begin
  LV1.Items.Clear;
  Fini := Tinifile.Create(sFormatFileName);
  iRepCount := fini.ReadInteger('RepCounts', 'Count', 0);
  for i := 1 to irepcount do
  begin
    rlvlistitem := lV1.Items.Add;
    rlvlistitem.Caption := inttostr(i);
    rlvlistitem.SubItems.Add(fini.readString('Reports', 'RepName' + inttostr(i), ''));
    rlvlistitem.SubItems.Add(fini.readString('Reports', 'FileName' + inttostr(i), ''));
    rlvlistitem.SubItems.Add(fini.readString('Reports', 'Remark' + inttostr(i), ''));
  end;
  fini.Free;
  if LV1.Items.Count > 0 then
    LV1.ItemIndex := 0;

end;

procedure TfrmPrintWindow.SaveFormat;
var
  i, irepcount: integer;
  rlvlistitem: Tlistitem;
  fini: Tinifile;
begin
  iRepCount := LV1.Items.Count;
  fini := Tinifile.Create(sFormatFileName);
  fini.WriteInteger('RepCounts', 'Count', irepcount);
  for i := 1 to iRepCount do
  begin
    rlvlistitem := LV1.Items.Item[i - 1];
    fini.WriteString('Reports', 'RepName' + inttostr(i), rlvlistitem.SubItems[0]);
    fini.WriteString('Reports', 'FileName' + inttostr(i), rlvlistitem.SubItems[1]);
    fini.WriteString('Reports', 'ReMark' + inttostr(i), rlvlistitem.SubItems[2]);
  end;
  fini.Free;
end;

procedure TfrmPrintWindow.FormShow(Sender: TObject);
begin
  GetFormat;
end;

procedure TfrmPrintWindow.MenuItem3Click(Sender: TObject);
begin
  frmAddFormat := TfrmAddFormat.create(nil);
  frmAddFormat.sRepAppDir := isAppDir;
  //fmAddReport.Visible := True;
  if frmAddFormat.showmodal = mrOK then
  begin
    SaveFormat;
    GetFormat;
  end;
  frmAddFormat.Free;
end;

procedure TfrmPrintWindow.MenuItem4Click(Sender: TObject);
var
  rlvListitem: Tlistitem;
  sRepFileName: string;
begin
  if LV1.Selected <> nil then
  begin
    rlvListitem := LV1.Selected;
    sRepFileName := rlvListitem.SubItems[1];
    if Application.MessageBox(Pchar('确定要删除' + '【' + sRepFileName + '】' + '这个报表文件吗?'), '提示', MB_YESNO + MB_DEFBUTTON2 + MB_ICONWARNING) <> IDYES then Exit;
    Lv1.DeleteSelected;
    DeleteFile(PChar(isAppDir+'Reports\'+sRepFileName));
    SaveFormat;
    GetFormat;

  end;

end;

end.

