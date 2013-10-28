unit untOrderReport;

interface

uses SysUtils, frxClass, PHPRPC, Forms;

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
     add_time:string;
  end;

  TOrderPrintInfo = record
     SenderName,
     SenderAddress,
     SenderPhone,
     SenderZipCode,
     ContentName,
     RecipientName,
     RecipientAddress,
     RecipientZipCode,
     RecipientPhone,
     RecipientMobile,
     PayAmount_small,
     PayAmount_big,
     PayAmount_big2,
     PayAmount_big3,
     Payment,
     ShippingCode,
     To_Buyer:string;
  end;

  function getOrderInfo(OrderId: string; ServiceURL: string): TOrderInfo;
  function getOrderPrintInfo(OrderId: string; ServiceURL: string): TOrderPrintInfo;
  function postOrerShipping(OrderId: string; ServiceURL:string):Boolean;
  function OrderPrintPreview(OrderPrintInfo:TOrderPrintInfo; ReportModFile:string; IsShow: Boolean=True):Boolean;

implementation

uses untTFastReportEx;

function F2C(r: real): string;
var
tmp1,rr :string;  
l,i,j,k:integer;
const n1:array[0..9] of string=('Áã','Ò¼','·¡','Èþ','ËÁ','Îé','Â½','Æâ','°Æ','¾Á');
const n2:array[0..3] of string=('','Ê°','°Û','Çª');
const n3:array[0..2] of string=('Ôª','Íò','ÒÚ');
begin
  tmp1:=FormatFloat('#.00',r);
  l:=length(tmp1);
  rr:='';
  if strtoint(tmp1[l])<>0 then
  begin
    rr:='·Ö';
    rr:=n1[strtoint(tmp1[l])]+rr;
  end;
  
  if strtoint(tmp1[l-1])<>0 then
  begin
    rr:='½Ç'+rr;
    rr:=n1[strtoint(tmp1[l-1])]+rr;
  end;

  i:=l-3;
  j:=0;k:=0;
  while i>0 do
  begin
    if j mod 4=0 then
    begin
      rr:=n3[k]+rr;
      inc(k);if k>2 then k:=1;
      j:=0;
    end;
    if strtoint(tmp1[i])<>0 then
      rr:=n2[j]+rr;
    rr:=n1[strtoint(tmp1[i])]+rr;
    inc(j);
    dec(i);
  end;
  while pos('ÁãÁã',rr)>0 do
    rr:= stringreplace(rr,'ÁãÁã','Áã',[rfReplaceAll]);
  rr:=stringreplace(rr,'ÁãÒÚ','ÒÚÁã',[rfReplaceAll]);
  while pos('ÁãÁã',rr)>0 do
    rr:= stringreplace(rr,'ÁãÁã','Áã',[rfReplaceAll]);
  rr:=stringreplace(rr,'ÁãÍò','ÍòÁã',[rfReplaceAll]);
  while pos('ÁãÁã',rr)>0 do
    rr:= stringreplace(rr,'ÁãÁã','Áã',[rfReplaceAll]);
  rr:=stringreplace(rr,'ÁãÔª','ÔªÁã',[rfReplaceAll]);
  while pos('ÁãÁã',rr)>0 do
    rr:= stringreplace(rr,'ÁãÁã','Áã',[rfReplaceAll]);
  rr:=stringreplace(rr,'ÒÚÍò','ÒÚ',[rfReplaceAll]);
  if copy(rr,length(rr)-1,2)='Áã' then
    rr:=copy(rr,1,length(rr)-2);
  result:=rr;
  if r=0.00 then Result:='ÁãÔª';
end;

function xTOd(i: Real): string;
const 
  d='ÁãÒ¼·¡ÈþËÁÎéÂ½Æâ°Æ¾Á·Ö½ÇÔªÊ°°ÛÇªÍòÊ°°ÛÇªÒÚ';
var 
  m,k:string;
  j:integer; 
begin 
  k:='';
  //m:='00'+floattostr(int(i*100));
  m:= Format('%.7d',[Trunc(i*100)]);
  for j:=length(m) downto 3 do
   k:=k+d[(strtoint(m[Length(m)-j+1])+1)*2-1]+
      d[(strtoint(m[Length(m)-j+1])+1)*2]+ d[(10+j)*2-1]+d[(10+j)*2]; //'    ';//+ È¥µô Ê°°ÛÇªÒÚµ¥Î»
  xTOd:=k;
end;

function xTOd2(i: Real): string;
const 
  d='ÁãÒ¼·¡ÈþËÁÎéÂ½Æâ°Æ¾Á·Ö½ÇÔªÊ°°ÛÇªÍòÊ°°ÛÇªÒÚ';
var 
  m,k:string;
  j:integer; 
begin 
  k:='';
  //m:='0'+floattostr(int(i*100));
  m:=Format('%.6d',[Trunc(i*100)]);
  for j:=length(m) downto 3 do
   k:=k+d[(strtoint(m[Length(m)-j+1])+1)*2-1]+
      d[(strtoint(m[Length(m)-j+1])+1)*2]+ d[(10+j)*2-1]+d[(10+j)*2]; //'     ';//+ È¥µô  ÍòÊ°°ÛÇªÒÚ µ¥Î»
  xTOd2:=k;
end;

function getOrderInfo(OrderId: string; ServiceURL:string): TOrderInfo;
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  res:Variant;
  OrderInfo:TOrderInfo;
begin
  PHPRPC_Client1 := TPHPRPC_Client.Create;
  try
    PHPRPC_Client1.URL := ServiceURL;
    clientProxy := PHPRPC_Client1.ToVariant;
    res := clientProxy.get_order_info(OrderId);
    OrderInfo.order_id:=Utf8ToAnsi(res.Get('order_id'));
    OrderInfo.order_sn:=Utf8ToAnsi(res.Get('order_sn'));
    OrderInfo.consignee:=Utf8ToAnsi(res.Get('consignee'));
    OrderInfo.address:=Utf8ToAnsi(res.Get('address'));
    OrderInfo.invoice_no:=Utf8ToAnsi(res.Get('invoice_no'));
    OrderInfo.shipping_name:=Utf8ToAnsi(res.Get('shipping_name'));
    OrderInfo.pay_name:=Utf8ToAnsi(res.Get('pay_name'));
    OrderInfo.add_time:=Utf8ToAnsi(res.Get('add_time'));
  finally
    PHPRPC_Client1.Free;
  end;
  Result:=OrderInfo;
end;

function getOrderPrintInfo(OrderId: string; ServiceURL: string): TOrderPrintInfo;
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  res:Variant;
  Temp:string;
  OrderPrintInfo:TOrderPrintInfo;
begin
  Screen.Cursor:=-11;
  PHPRPC_Client1 := TPHPRPC_Client.Create;
  try
    PHPRPC_Client1.URL := ServiceURL;
    clientProxy := PHPRPC_Client1.ToVariant;
    res := clientProxy.get_order_print_info(OrderId);
    OrderPrintInfo.SenderName:=Utf8ToAnsi(res.Get('sendername'));
    OrderPrintInfo.SenderAddress:=Utf8ToAnsi(res.Get('senderaddress'));
    OrderPrintInfo.SenderZipCode:=Utf8ToAnsi(res.Get('senderzipcode'));
    OrderPrintInfo.SenderPhone:=Utf8ToAnsi(res.Get('senderphone'));
    OrderPrintInfo.ContentName:=Utf8ToAnsi(res.Get('contentname'));
    OrderPrintInfo.RecipientName:=Utf8ToAnsi(res.Get('recipientname'));
    OrderPrintInfo.RecipientAddress:=Trim(Utf8ToAnsi(res.Get('recipientaddress')));
    OrderPrintInfo.RecipientZipCode:=Utf8ToAnsi(res.Get('recipientzipcode'));
    OrderPrintInfo.RecipientPhone:=Utf8ToAnsi(res.Get('recipientphone'));
    OrderPrintInfo.RecipientMobile:=Utf8ToAnsi(res.Get('recipientmobile'));
    OrderPrintInfo.PayAmount_small:=Utf8ToAnsi(res.Get('payamount_small'));
    Temp:=Utf8ToAnsi(res.Get('payamount_big'));
    OrderPrintInfo.PayAmount_big:=F2C(strtofloat(Temp));
    OrderPrintInfo.PayAmount_big2:=xTOd(StrToFloat(Temp));
    OrderPrintInfo.PayAmount_big3:=xTOd2(StrToFloat(Temp));
    OrderPrintInfo.Payment:=Utf8ToAnsi(res.Get('payment'));
    OrderPrintInfo.ShippingCode:=Utf8ToAnsi(res.Get('shipping_code'));
    OrderPrintInfo.To_Buyer:=Utf8ToAnsi(res.Get('to_buyer'));
  finally
    PHPRPC_Client1.Free;
    Screen.Cursor:=0;
  end;
  Result:=OrderPrintInfo;
end;

function postOrerShipping(OrderId: string; ServiceURL:string):Boolean;
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  res:Variant;
begin
  Result:=True;
  PHPRPC_Client1 := TPHPRPC_Client.Create;
  try
    PHPRPC_Client1.URL := ServiceURL;
    clientProxy := PHPRPC_Client1.ToVariant;
    try
      res := clientProxy.pos_order_shipping(OrderId);
    except
      Result:=False;
    end;
  finally
    PHPRPC_Client1.Free;
  end;
end;

function OrderPrintPreview(OrderPrintInfo:TOrderPrintInfo; ReportModFile:string; IsShow: Boolean=True):Boolean;
var
  frxReport1: TfrxReport;
begin
  frxReport1:=TfrxReport.Create(nil);
  //frxReport1.PrintOptions.Printer:='´òÓ¡»úÃû';
  try
    frxReport1.LoadFromFile(ReportModFile);
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
    if IsShow then
      frxReport1.ShowReport()
    else
      if frxReport1.PrepareReport then
        frxReport1.Print;
  finally
    frxReport1.Free;
  end;
  Result:=True;
end;

end.
