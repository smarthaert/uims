unit Unit4;
////控制打印的unit
//download by http://www.codefans.net
interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids,strutils;

procedure printData(adoQuery1:Tadoquery;var f:textfile);
implementation


procedure writeHalfLn(var f:textfile);
begin
Write(f,chr(27)+chr(74)+chr(15));
end;




function space(count:integer):string;
var
  str:string;
  i:integer;
begin
  str:='';
  for i:=1 to count do
  begin
    str:=str+' ';
  end;
  result:=str;
end;
function getWideString(strdata:string;strSpace:string):string;
var
  i:integer;
  len:integer;
  //strReturn:string;
begin
  result:='';
  len:=length(strdata);
  for i:=1 to len do
  begin
    result:=result+midbstr(strdata,i,1);
    if (i<>len) then
    begin
      result:=result+strSpace;
    end;
  end;
end;


procedure writeWideString(strdata:string;int:integer;var f:textfile);
var
  i:integer;
  len:integer;
  //strReturn:string;
begin
  //result:='';
  len:=length(strdata);
  for i:=1 to len do
  begin
    write(f,midbstr(strdata,i,1));
    //result:=result+midbstr(strdata,i,1);
    if (i<>len) then
    begin
      //result:=result+strSpace;
      Write(f,chr(27)+chr(92)+chr(int)+chr(00));
    end;
  end;
end;
procedure printData(adoQuery1:tadoquery;var f:textfile);
var
  apNumber:string;
  custName:string;
  checkDuiGong:string;
  UNITCODE:string;
  idCODE:string;
  i:integer;
  itemp:integer;
  itemp2:integer;
  stemp:string;

  i2:integer;
begin
  ////申报号
  apNumber:=ADOQuery1.FieldByName('apNumber').AsString;


  stemp:=midbstr(apNumber,1,6);
  //移到绝对5.2cm处
  itemp:=round(5.2/2.54*60);
  Write(f,chr(27)+chr(36)+chr(itemp)+chr(0));
  //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
  i2:=21;
  writeWideString(stemp,i2,f);

  stemp:=midbstr(apNumber,7,4);
  //移到绝对8.9cm处
  itemp:=round(8.9/2.54*60);
  itemp2:=0;
  if(itemp>255) then
  begin
    itemp2:=itemp div 256;
    itemp:=itemp mod 256;
  end;
  Write(f,chr(27)+chr(36)+chr(itemp)+chr(itemp2));
  //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
  i2:=21;
  writeWideString(stemp,i2,f);

  stemp:=midbstr(apNumber,11,2);
  //移到绝对11.6cm处
  itemp:=round(11.6/2.54*60);
  itemp2:=0;
  if(itemp>255) then
  begin
    itemp2:=itemp div 256;
    itemp:=itemp mod 256;
  end;
  Write(f,chr(27)+chr(36)+chr(itemp)+chr(itemp2));
  //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
  i2:=21;
  writeWideString(stemp,i2,f);

  stemp:=midbstr(apNumber,13,6);
  //移到绝对5.2cm处
  itemp:=round(13.4/2.54*60);
  itemp2:=0;
  if(itemp>255) then
  begin
    itemp2:=itemp div 256;
    itemp:=itemp mod 256;
  end;
  Write(f,chr(27)+chr(36)+chr(itemp)+chr(itemp2));
  //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
  i2:=21;
  writeWideString(stemp,i2,f);

  stemp:=midbstr(apNumber,19,4);
  //移到绝对5.2cm处
  itemp:=round(17.1/2.54*60);
  itemp2:=0;
  if(itemp>255) then
  begin
    itemp2:=itemp div 256;
    itemp:=itemp mod 256;
  end;
  Write(f,chr(27)+chr(36)+chr(itemp)+chr(itemp2));
  //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
  i2:=21;
  writeWideString(stemp,i2,f);

  writeln(f);
  //stemp:=getWideString(stemp,'  ');
  //write(f,Space(26)+stemp);
  {
  stemp:=midbstr(apNumber,7,4);
  stemp:=getWideString(stemp,'  ');
  write(f,Space(4)+stemp);

  stemp:=midbstr(apNumber,11,2);
  stemp:=getWideString(stemp,'  ');
  write(f,Space(4)+stemp);

  stemp:=midbstr(apNumber,13,6);
  stemp:=getWideString(stemp,'  ');
  write(f,Space(4)+stemp);

  stemp:=midbstr(apNumber,19,4);
  stemp:=getWideString(stemp,'  ');
  write(f,Space(4)+stemp);

  writeln(f);
  }
  //midbstr(apNumber,1,1)
  //Write(f,chr(27)+chr(74)+chr($CF)+chr($00));
  //writeln(f,Space(26)+apNumber);

  ////收款人姓名
  //第2行
  writeln(f);
  custName:=ADOQuery1.FieldByName('custName').AsString;
  //Write(f,chr(27)+chr(ord('\'))+chr($CF)+chr($00));
  writeln(f,space(26)+custName);

  ////对公,组织机构代码
  writeln(f);
  //第4.5行
  ///writehalfln(f);
  writeln(f);
  UNITCODE:=ADOQuery1.FieldByName('UNITCODE').AsString;
  if  (trim(UNITCODE)<>'') then
  begin
    write(f,space(10)+'√');

    ////组织机构代码
    stemp:=midbstr(UNITCODE,1,8);
    //stemp:=unitcode;
    //移到绝对5.2cm处
    itemp:=round(10.6/2.54*60);
    itemp2:=0;
    if(itemp>255) then
    begin
      itemp2:=itemp div 256;
      itemp:=itemp mod 256;
    end;
    Write(f,chr(27)+chr(36)+chr(itemp)+chr(itemp2));
    //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
    i2:=round(0.37/2.54*180);
    writeWideString(stemp,i2,f);

    stemp:=midbstr(UNITCODE,9,1);
    //stemp:=unitcode;
    //移到绝对5.2cm处
    itemp:=round(15.8/2.54*60);
    itemp2:=0;
    if(itemp>255) then
    begin
      itemp2:=itemp div 256;
      itemp:=itemp mod 256;
    end;
    Write(f,chr(27)+chr(36)+chr(itemp)+chr(itemp2));
    //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
    i2:=round(0.37/2.54*180);
    writeWideString(stemp,i2,f);

    writeln(f);
    //writeln(f,space(10)+'√'+space(44)+UNITCODE);
  end
  //如果不是对公的,直接输空行
  else
  begin
    writeln(f);
  end;
  //第6.5行
  ///writehalfln(f);

  ////对私,个人身份证号,是否中国居民
  writeln(f);
  idCODE:=ADOQuery1.FieldByName('idCODE').AsString;
  if  trim(idCODE)<>'' then
  begin

     //在对私上打勾,不换行
    write(f,space(10)+'√');
    //输出个人身份证号码
    writeln(f,space(41)+trim(idcode));




    //在"中国居民个人"上打上'v'.
    if  trim(ADOQuery1.FieldByName('custype').AsString)='D' then
    begin
      writeln(f,space(27)+'√');
    end
    else
    begin
    writeln(f,space(63)+'√');
    end;
  end
  else
  begin
    writeln(f);
    writeln(f);
  end;

  ////结算方式
  //第11行
  writeln(f);



  {writeln(f,space(27)+'√');
  writeln(f,space(40)+'√');
  writeln(f,space(54)+'√');
  writeln(f,space(65)+'√');
  writeln(f,space(76)+'√');
  writeln(f,space(86)+'√');
  writeln(f,space(97)+'√');
  }
  if  trim(ADOQuery1.FieldByName('paymethod').AsString)='L' then
  begin
    writeln(f,space(27)+'√');
  end
  else if  trim(ADOQuery1.FieldByName('paymethod').AsString)='C' then
  begin
    writeln(f,space(40)+'√');
  end
  else if  trim(ADOQuery1.FieldByName('paymethod').AsString)='G' then
  begin
    writeln(f,space(54)+'√');
  end
  else if  trim(ADOQuery1.FieldByName('paymethod').AsString)='T' then
  begin
    writeln(f,space(65)+'√');
  end
  else if  trim(ADOQuery1.FieldByName('paymethod').AsString)='D' then
  begin
    writeln(f,space(76)+'√');
  end
  else if  trim(ADOQuery1.FieldByName('paymethod').AsString)='M' then
  begin
    writeln(f,space(86)+'√');
  end
  else
  begin
    writeln(f,space(97)+'√');
  end;

  ////收入款币种及金额
  writeln(f);
  writeln(f,space(33)+trim(ADOQuery1.FieldByName('TXCCY').AsString)+space(2)+trim(ADOQuery1.FieldByName('txamt').AsString));

  ////结汇金额和银行卡号,金额为0.00(或说账号为空)则不显示
  writeln(f);
  //第15行
  writeln(f);
  if(trim(ADOQuery1.FieldByName('lcyacc').AsString)<>'')then
  begin
     writeln(f,space(33)+trim(ADOQuery1.FieldByName('lcyamt').AsString)+space(37)+trim(ADOQuery1.FieldByName('lcyacc').AsString));
  end
  else
  begin
    //writeln(f,space(32)+trim(ADOQuery1.FieldByName('lcyamt').AsString)+space(42)+trim(ADOQuery1.FieldByName('lcyacc').AsString));
    writeln(f);
  end;
  ////现汇金额和银行卡号
  writeln(f);
  if(trim(ADOQuery1.FieldByName('fcyacc').AsString)<>'')then
  begin
     writeln(f,space(33)+trim(ADOQuery1.FieldByName('fcyamt').AsString)+space(37)+trim(ADOQuery1.FieldByName('fcyacc').AsString));
  end
  else
  begin
    //writeln(f,space(32)+trim(ADOQuery1.FieldByName('fcyamt').AsString)+space(42)+trim(ADOQuery1.FieldByName('fcyacc').AsString));
    writeln(f);
  end;
  //writeln(f,space(32)+trim(ADOQuery1.FieldByName('fcyamt').AsString)+space(42)+trim(ADOQuery1.FieldByName('fcyacc').AsString));

  ////其它金额和银行卡号
  writeln(f);
  //第20行
  writeln(f);
  if(trim(ADOQuery1.FieldByName('othacc').AsString)<>'')then
  begin
     writeln(f,space(33)+trim(ADOQuery1.FieldByName('othamt').AsString)+space(37)+trim(ADOQuery1.FieldByName('othacc').AsString));
  end
  else
  begin
    //writeln(f,space(32)+trim(ADOQuery1.FieldByName('lcyamt').AsString)+space(42)+trim(ADOQuery1.FieldByName('lcyacc').AsString));
    writeln(f);
  end;

  //writeln(f,space(32)+trim(ADOQuery1.FieldByName('othamt').AsString)+space(42)+trim(ADOQuery1.FieldByName('othacc').AsString));

  ////国内,国外银行扣费币种及金额
  writeln(f);
  writeln(f,space(32)+trim(ADOQuery1.FieldByName('INCHARGECCY').AsString)+space(2)+trim(ADOQuery1.FieldByName('INCHARGEamt').AsString)+space(37)+trim(ADOQuery1.FieldByName('OUTCHARGECCY').AsString)+space(2)+trim(ADOQuery1.FieldByName('OUTCHARGEamt').AsString));

  ////付款人名称
  writeln(f);
  //第25行
  writeln(f,space(26)+trim(ADOQuery1.FieldByName('OPPNAME').AsString));

  ////付款人常住国家及代码   申报日期
  writeln(f);
  writeln(f);
  ///writeln(f,space(34)+trim(ADOQuery1.FieldByName('countryCodeName.countryName').AsString)+space(16)+trim(ADOQuery1.FieldByName('COUNTRYCODE').AsString)+space(22)+trim(ADOQuery1.FieldByName('RPTDATE').AsString));
  itemp:=52-length(trim(ADOQuery1.FieldByName('countryCode').AsString));
  if(itemp<0) then itemp:=0;
  write(f,space(itemp)+trim(ADOQuery1.FieldByName('countryCode').AsString));

  //国家代码
  stemp:=trim(ADOQuery1.FieldByName('COUNTRYCODE').AsString);
  //移到绝对5.2cm处
  itemp:=round(10.2/2.54*60);
  itemp2:=0;
  if(itemp>255) then
  begin
    itemp2:=itemp div 256;
    itemp:=itemp mod 256;
  end;
  Write(f,chr(27)+chr(36)+chr(itemp)+chr(itemp2));
  //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
  i2:=round(0.42/2.56*180);
  writeWideString(stemp,i2,f);

  //stemp:=trim(ADOQuery1.FieldByName('rptdate').AsString);
  write(f,space(15)+trim(ADOQuery1.FieldByName('rptdate').AsString));

  writeln(f);
  //writeln(f,space(34)+trim(ADOQuery1.FieldByName('countryName').AsString)+space(2)+trim(ADOQuery1.FieldByName('COUNTRYCODE').AsString)+space(22)+trim(ADOQuery1.FieldByName('RPTDATE').AsString));


  ////是否预收付款和退款
  writeln(f);
  //下面是第30行
  if  trim(ADOQuery1.FieldByName('paytype').AsString)='A' then
  begin
    writeln(f,space(53)+'√');
  end
  else
  begin
    writeln(f,space(82)+'√');
  end;

  ////是否为核销项下收汇
  writeln(f);

  if  trim(ADOQuery1.FieldByName('iswriteoff').AsString)='Y' then
  begin
    writeln(f,space(53)+'√');
  end
  else
  begin
    writeln(f,space(82)+'√');
  end;
  
  writeln(f);
  //外债编号
  writeln(f);
  //第35行
  writeln(f,space(26)+trim(ADOQuery1.FieldByName('BILLNO').AsString));

  ////交易编码,相应币种及金额,交易附言 金额为0.00(或说交易编码为空)则不显示
  writeln(f);
  //writeln(f);
  if(trim(ADOQuery1.FieldByName('txcode1').AsString)<>'')then
  begin

     write(f,space(19));
     //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
     i2:=round(0.4/2.54*180);
     writeWideString(trim(ADOQuery1.FieldByName('txcode1').AsString),i2,f);
    writeln(f,space(15)+trim(ADOQuery1.FieldByName('txamt1').AsString)+space(20)+ trim(ADOQuery1.FieldByName('txrem1').AsString));

  end
  else
  begin
    writeln(f);
  end;


  writeln(f);
  writeln(f);
  //第40行
  if(trim(ADOQuery1.FieldByName('txcode2').AsString)<>'')then
  begin
    write(f,space(19));
     //写有间距的字符串,i2代表间距为i2*1/180英寸.这里为0.3cm
     i2:=round(0.4/2.54*180);
     writeWideString(trim(ADOQuery1.FieldByName('txcode2').AsString),i2,f);
     writeln(f,space(15)+trim(ADOQuery1.FieldByName('txamt2').AsString)+space(20)+ trim(ADOQuery1.FieldByName('txrem2').AsString));

    ///writeln(f,space(18)+trim(ADOQuery1.FieldByName('txcode2').AsString)+space(32)+trim(ADOQuery1.FieldByName('txamt2').AsString)+space(22)+
    ///trim(ADOQuery1.FieldByName('txrem2').AsString));
  end
  else
  begin
    writeln(f);
  end;
  ////填报人签章,填报人电话
  writeln(f);
  writeln(f);
  writeln(f);
  writeln(f);
  //第45行
  if(trim(ADOQuery1.FieldByName('idCODE').AsString)<>'') then
  begin
    writeln(f,space(26)+trim(ADOQuery1.FieldByName('custName').AsString)+space(50)+trim(ADOQuery1.FieldByName('rpttel').AsString));
  end
  else
  begin
    writeln(f);
  end;

  ////银行经办人签章,银行业务编号
  writeln(f);
  writeln(f);
  writeln(f);
  writeln(f);
  //第50行
  //writeln(f,space(50)+trim(ADOQuery1.FieldByName('rptuser').AsString)+space(25)+trim(ADOQuery1.FieldByName('busicode').AsString));
  writeln(f,space(50)+'xxx'+space(26)+trim(ADOQuery1.FieldByName('busicode').AsString));

  {
  ////输出19行空行
  for i:=1 to 19 do
  begin
    writeln(f);
  end;
  }
  //再输出0.x毫米,一个单位为0.14毫米
  //Write(f,chr(27)+chr(74)+chr(7));
end;
end.
 