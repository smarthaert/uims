unit untOrderInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzCmboBx, RzButton, PHPRPC, Clipbrd;

type
  TOrderInfo = record
     order_id,
     order_sn,
     consignee,
     address,
     invoice_no,
     shipping_id,
     shipping_name,
     pay_name,
     add_time,
     zipcode,
     best_time,
     postscript,
     to_buyer:string;
  end;

  TfrmOrderInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cmbShippingName: TRzComboBox;
    edtInvoice_No: TRzEdit;
    lblOrderId: TLabel;
    lblOrderSn: TLabel;
    lblConsignee: TLabel;
    lblAddress: TLabel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    lblPayName: TLabel;
    lblAddTime: TLabel;
    Label9: TLabel;
    edtZipCode: TRzEdit;
    lblHint: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblPostScript: TLabel;
    edtTo_buyer: TRzEdit;
    Label13: TLabel;
    lblBest_Time: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure cmbShippingNameChange(Sender: TObject);
    procedure lblAddressClick(Sender: TObject);
    procedure lblOrderIdClick(Sender: TObject);
    procedure lblOrderSnClick(Sender: TObject);
    procedure lblConsigneeClick(Sender: TObject);
  private
    { Private declarations }
    FOrderId:string;
    FOrderInfo:TOrderInfo;
    FPayment:TArrayList;
    function getOrderInfo(AOrderId:string):TOrderInfo;
    function postOrderInfo(AOrderInfo:TOrderInfo):boolean;
    function getShippingList:TArrayList;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AOrderId: string); reintroduce;
  end;

var
  frmOrderInfo: TfrmOrderInfo;

implementation

{$R *.dfm}

uses untConsts, untMain;

{ TfrmOrderInfo }

constructor TfrmOrderInfo.Create(AOwner: TComponent; AOrderId:string);
var
  i:Integer;
  CurShippingName, ShippingName:string;
begin
  inherited Create(AOwner);
  FOrderId:=AOrderId;
  FOrderInfo:= getOrderInfo(AOrderId);
  lblOrderId.Caption:=FOrderInfo.order_id;
  lblOrderSn.Caption:=FOrderInfo.order_sn;
  lblConsignee.Caption:=FOrderInfo.consignee;
  lblAddress.Caption:=FOrderInfo.address;
  lblPayName.Caption:=FOrderInfo.pay_name;
  lblAddTime.Caption:=FOrderInfo.add_time;
  edtZipCode.Text:=FOrderInfo.zipcode;
  edtInvoice_No.Text:=FOrderInfo.invoice_no;
  CurShippingName:=FOrderInfo.shipping_name;
  lblBest_Time.Caption:=FOrderInfo.best_time;
  lblPostScript.Caption:=FOrderInfo.postscript;
  edtTo_buyer.Text:=FOrderInfo.to_buyer;
  
  FPayment:=getShippingList;
  for i:=0 to FPayment.Count-1 do
  begin
    ShippingName:= Utf8ToAnsi(FPayment.Items[i].Get('shipping_name'));
    cmbShippingName.Add(ShippingName);

    if CurShippingName = ShippingName then
      cmbShippingName.ItemIndex:=i;
  end;

  if FOrderInfo.pay_name = '网银在线' then
  begin
    lblHint.Caption:='提示:使用已付款快递单';
    lblHint.Font.Color:=clRed;
  end
  else
  begin
    lblHint.Caption:='提示:使用代收款快递单';
    lblHint.Font.Color:=clGreen;
  end;
end;

function TfrmOrderInfo.getOrderInfo(AOrderId: string): TOrderInfo;
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  res:Variant;
  OrderInfo:TOrderInfo;
begin
  PHPRPC_Client1 := TPHPRPC_Client.Create;
  try
    PHPRPC_Client1.URL := PServiceURL;
    clientProxy := PHPRPC_Client1.ToVariant;
    res := clientProxy.get_order_info(AOrderId);
    OrderInfo.order_id:=Utf8ToAnsi(res.Get('order_id'));
    OrderInfo.order_sn:=Utf8ToAnsi(res.Get('order_sn'));
    OrderInfo.consignee:=Utf8ToAnsi(res.Get('consignee'));
    OrderInfo.address:=Utf8ToAnsi(res.Get('address'));
    OrderInfo.invoice_no:=Utf8ToAnsi(res.Get('invoice_no'));
    OrderInfo.shipping_name:=Utf8ToAnsi(res.Get('shipping_name'));
    OrderInfo.pay_name:=Utf8ToAnsi(res.Get('pay_name'));
    OrderInfo.add_time:=Utf8ToAnsi(res.Get('add_time'));
    OrderInfo.zipcode:=Utf8ToAnsi(res.Get('zipcode'));
    OrderInfo.best_time:=Utf8ToAnsi(res.Get('best_time'));
    OrderInfo.postscript:=Utf8ToAnsi(res.Get('postscript'));
    OrderInfo.to_buyer:=Utf8ToAnsi(res.Get('to_buyer'));
  finally
    PHPRPC_Client1.Free;
  end;
  Result:=OrderInfo;
end;

function TfrmOrderInfo.getShippingList: TArrayList;
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  vhashmap: Variant;
  ohashmap: THashMap;
begin
  PHPRPC_Client1 := TPHPRPC_Client.Create;
  try
    PHPRPC_Client1.URL := PServiceURL;
    clientProxy := PHPRPC_Client1.ToVariant;
    vhashmap := clientProxy.shipping_list();
    ohashmap:= THashMap(THashMap.FromVariant(UnSerialize(vhashmap,False)));
    Result := ohashmap.Values;
  finally
    PHPRPC_Client1.Free;
  end;
end;

function TfrmOrderInfo.postOrderInfo(AOrderInfo: TOrderInfo):boolean;
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  res:Variant;
  arraylist: TArrayList;
  i:integer;
begin
  PHPRPC_Client1 := TPHPRPC_Client.Create;
  arraylist := TArrayList.Create(13);
  try
    arraylist[0] := AOrderInfo.order_id;
    arraylist[1] := AOrderInfo.order_sn;
    arraylist[2] := AOrderInfo.consignee;
    arraylist[3] := AOrderInfo.address;
    arraylist[4] := AOrderInfo.invoice_no;
    arraylist[5] := AOrderInfo.shipping_id;
    arraylist[6] := AOrderInfo.shipping_name;
    arraylist[7] := AOrderInfo.pay_name;
    arraylist[8] := AOrderInfo.add_time;
    arraylist[9] := AOrderInfo.zipcode;
    arraylist[10]:= AOrderInfo.best_time;
    arraylist[11]:= AOrderInfo.postscript;
    arraylist[12]:= AOrderInfo.to_buyer;
    
    for i:=0 to arraylist.Count-1 do
      if arraylist.Items[i] = EmptyStr then arraylist.Delete(i);

    try
      PHPRPC_Client1.URL := PServiceURL;
      clientProxy := PHPRPC_Client1.ToVariant;
      res:=clientProxy.pos_order_info(arraylist.ToVariant);
      Result:=True;
    except
      Result:=false;
    end;
  finally
    PHPRPC_Client1.Free;
    arraylist.Free;
  end;
end;

procedure TfrmOrderInfo.cmbShippingNameChange(Sender: TObject);
var
  CurShippingName, ShippingId, ShippingName:string;
  i:Integer;
begin
  CurShippingName:=cmbShippingName.Items[cmbShippingName.ItemIndex];
  for i:=0 to FPayment.Count-1 do
  begin
    ShippingId:=Utf8ToAnsi(FPayment.Items[i].Get('shipping_id'));
    ShippingName:= Utf8ToAnsi(FPayment.Items[i].Get('shipping_name'));
    if CurShippingName = ShippingName then
    begin
      FOrderInfo.shipping_id:=ShippingId;
      FOrderInfo.shipping_name:=ShippingName;
    end;
  end;
end;

procedure TfrmOrderInfo.btnOKClick(Sender: TObject);
begin
  //修改订单
//  if edtInvoice_No.Text = EmptyStr then
//  begin
//    MessageBox( Self.Handle, PChar( RSTR_EMPTY_INVOICE_NO ),
//      PChar( STR_APPTITLE ), MB_ICONEXCLAMATION );
//    Exit;
//  end;

  if cmbShippingName.Items[cmbShippingName.ItemIndex] = EmptyStr then
  begin
    MessageBox( Self.Handle, PChar( RSTR_EMPTY_PAYMENT ),
      PChar( STR_APPTITLE ), MB_ICONEXCLAMATION );
   //Exit;
  end;
  
  Screen.Cursor:=crHourGlass;
  FOrderInfo.zipcode:=edtZipCode.Text;
  FOrderInfo.invoice_no:= edtInvoice_No.Text;
  FOrderInfo.to_buyer:=edtTo_buyer.Text;
  
  //配送方式
  cmbShippingNameChange(Self);

  if not postOrderInfo(FOrderInfo) then
  begin
    MessageBox( Self.Handle, PChar( RSTR_POST_ORDERINFOFAILMSG ),
      PChar( STR_APPTITLE ), MB_ICONEXCLAMATION );
  end;
  
  Screen.Cursor:=crDefault;
  Self.ModalResult:=mrOk;
end;

procedure TfrmOrderInfo.lblAddressClick(Sender: TObject);
begin
Clipboard.SetTextBuf(PChar(lblAddress.Caption));
frmMain.RzTrayIcon1.ShowBalloonHint(RSTR_MAIN_TITLE, RSTR_MAIN_MSG2);
end;

procedure TfrmOrderInfo.lblOrderIdClick(Sender: TObject);
begin
Clipboard.SetTextBuf(PChar(lblOrderId.Caption));
frmMain.RzTrayIcon1.ShowBalloonHint(RSTR_MAIN_TITLE, RSTR_MAIN_MSG2);
end;

procedure TfrmOrderInfo.lblOrderSnClick(Sender: TObject);
begin
Clipboard.SetTextBuf(PChar(lblOrderSn.Caption));
frmMain.RzTrayIcon1.ShowBalloonHint(RSTR_MAIN_TITLE, RSTR_MAIN_MSG2);
end;

procedure TfrmOrderInfo.lblConsigneeClick(Sender: TObject);
begin
Clipboard.SetTextBuf(PChar(lblConsignee.Caption));
frmMain.RzTrayIcon1.ShowBalloonHint(RSTR_MAIN_TITLE, RSTR_MAIN_MSG2);
end;

end.
