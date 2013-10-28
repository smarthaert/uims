{******************************************************************
** 文件名: BuildCode.pas
** 版　本: 1.0
** 创建人: zhjun
** 日　期: 2004.12.29
** 描　述: Code 39 条码输出模块
**-----------------------------------------------------------------
** 修改人:
** 日　期:
** 描　述:                     
**-----------------------------------------------------------------
******************************************************************}
unit BuildCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;


  function BuildCodes(CodeStr:string;CodeType:integer;Corner:integer;
           CHeight:integer;CWidth:integer;CWidthShort:integer;
           CTextOutSize:integer; var CodeCanvas:Timage):integer;

  procedure CodeEvaluate;
  function  CheckParameter(CodeStr:string;CodeType:integer;Corner:integer;
           CHeight:integer;CWidth:integer;CWidthShort:integer;CTextOutSize:integer;
            var CodeCanvas:Timage):boolean;
  function ClearCanvas(var CodeCanvas:Timage):boolean;                                        

  function TypeCode39(CodeStr:string;Corner:integer;CHeight,CWidth,CWidthShort:integer;
                   CTextOutSize:integer; var CodeCanvas:Timage):integer;


implementation

var
  CodeValue :array[0..43] of string;
  CodeValueA:array[0..43] of string;
  CodeOrder:string='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. *$/+%';

  place_X1,place_X2,place_Y1,place_Y2:integer;   //条码输出位置
  TextPlace_X,TextPlace_Y:integer;//字符输出位置
  CordWord_Place:integer;    //编码位置编号
  CordWord:string;           //单个字符
  i,j:integer;               //循环参数
  Code,CodeA:string;
  CodeStr:string;


function BuildCodes(CodeStr:string;CodeType:integer;Corner:integer;
CHeight,CWidth,CWidthShort:integer;CTextOutSize:integer;var CodeCanvas:Timage):integer;
begin
  if not CheckParameter(CodeStr,CodeType,Corner,CHeight,CWidth,CWidthShort,CTextOutSize,CodeCanvas) then
   exit;

  CodeEvaluate;//初始化二进制编码
  ClearCanvas(CodeCanvas);  //清除画布
  
  Case CodeType of
  0:  TypeCode39(CodeStr,Corner,CHeight,CWidth,CWidthShort,CTextOutSize,CodeCanvas);
  end;

end;

function ClearCanvas(var CodeCanvas:Timage):boolean;
var
ClientRect:TRect;
begin
  ClientRect.Left:=0;
  ClientRect.Top:=0;
  ClientRect.Right:=CodeCanvas.Width;
  ClientRect.Bottom:=CodeCanvas.Height;
  with CodeCanvas.Canvas do
  begin
    Brush.Style:=bssolid;
    Brush.Color:=ClWhite;
    FillRect(ClientRect);
  end;
  result:=true;
end;

//创建
function TypeCode39(CodeStr:string;Corner:integer;CHeight,CWidth,CWidthShort:integer;
                   CTextOutSize:integer;var CodeCanvas:Timage):integer;
begin
  place_X1:=20;        
  place_Y1:=20;
  TextPlace_X:=Place_X1+Cwidth;
  TextPlace_Y:=CHeight;

  Codecanvas.Canvas.Pen.Color:=clblack;

  for i := 1 to length(CodeStr) do
  begin
    Place_X1:=Place_X1+CWidth;
    //按顺序取单个字符
    CordWord:=copy(CodeStr,i,1);
    //获取字符的位置编号
    CordWord_Place:=Pos(CordWord,CodeOrder)-1;
    //按二进制编码顺序输出条码
    for j:= 1 to 5 do
    begin
      //画黑线
      Codecanvas.Canvas.Pen.Mode:=pmBlack;
      Code:=copy(CodeValue[CordWord_Place],j,1);
      CodeA:=copy(CodeValueA[CordWord_Place],j,1);
      if Code='1' then
      begin
        Codecanvas.Canvas.Pen.Color:=clblack;
        Place_X2:=Place_X1+CWidth;
        Codecanvas.Canvas.Rectangle(Place_X1,10,Place_X2,CHeight-10);
        Place_X1:=Place_X1+CWidth;
      end;
      if Code='0' then
      begin
        Codecanvas.Canvas.Pen.Color:=clblack;
        Place_X2:=Place_X1+CWidthShort;
        Codecanvas.Canvas.Rectangle(Place_X1,10,Place_X2,CHeight-10);
        Place_X1:=Place_X1+CWidthShort;
      end;

      //画白线
      Codecanvas.Canvas.Pen.Mode:=pmWhite;
      if CodeA='1' then
      begin
        Codecanvas.Canvas.Pen.Color:=clwhite;
        Place_X2:=Place_X1+CWidth;
        Codecanvas.Canvas.Rectangle(Place_X1,10,Place_X2,CHeight-10);
        Place_X1:=Place_X1+CWidth;
      end;
      if CodeA='0' then
      begin
        Codecanvas.Canvas.Pen.Color:=clwhite;
        Place_X2:=Place_X1+CWidthShort;
        Codecanvas.Canvas.Rectangle(Place_X1,10,Place_X2,CHeight-10);
        Place_X1:=Place_X1+CWidthShort;
      end;

   end;
  end;
  Codecanvas.Canvas.TextWidth('ddddd');
  Codecanvas.Canvas.Font.Name:='宋体';
  Codecanvas.Canvas.Font.Size:=CTextOutSize;
  Codecanvas.Canvas.TextOut(TextPlace_X,TextPlace_Y,Codestr);
end;

function  CheckParameter(CodeStr:string;CodeType:integer;Corner:integer;
       CHeight:integer;CWidth:integer;CWidthShort:integer; CTextOutSize:integer;
       var CodeCanvas:Timage):boolean;
begin
  result:=True;
  if COdeType<0 then
  begin
    Application.MessageBox('缺少参数！'+#13+'请求传递条码类型！', '系统提示',mb_OK or MB_ICONINFORMATION);
    result:=False;
    Exit;
  end;

  if CodeStr='' then
  begin
    Application.MessageBox('缺少参数！'+#13+'请求传递条码字符！', '系统提示',mb_OK or MB_ICONINFORMATION);
    result:=False;
    Exit;
  end;

  if Corner<0 then
    Corner:=0;
  if CHeight<0 then
    CHeight:=100;
  if CWidth<0 then
    CWidth:=6;
  if CWidthShort<0 then
    CWidthShort:=2;
  if CTextOutSize<0 then
    CTextOutSize:=9;

end;

procedure CodeEvaluate;
begin
  CodeValue[0] :='00110';        // 0
  CodeValue[1] :='10001';        // 1
  CodeValue[2] :='01001';        // 2
  CodeValue[3] :='11000';        // 3
  CodeValue[4] :='00101';        // 4
  CodeValue[5] :='10100';        // 5
  CodeValue[6] :='01100';        // 6
  CodeValue[7] :='00011';        // 7
  CodeValue[8] :='10010';        // 8
  CodeValue[9] :='01010';        // 9
  CodeValue[10]:='10001';        // A
  CodeValue[11]:='01001';        // B
  CodeValue[12]:='11000';        // C
  CodeValue[13]:='00101';        // D
  CodeValue[14]:='10100';        // E
  CodeValue[15]:='01100';        // F
  CodeValue[16]:='00011';        // G
  CodeValue[17]:='10010';        // H
  CodeValue[18]:='01010';        // I
  CodeValue[19]:='00110';        // J
  CodeValue[20]:='10001';        // K
  CodeValue[21]:='01001';        // L
  CodeValue[22]:='11000';        // M
  CodeValue[23]:='00101';        // N
  CodeValue[24]:='10100';        // O
  CodeValue[25]:='01100';        // P
  CodeValue[26]:='00011';        // Q
  CodeValue[27]:='10010';        // R
  CodeValue[28]:='01010';        // S
  CodeValue[29]:='00110';        // T
  CodeValue[30]:='10001';        // U
  CodeValue[31]:='01001';        // V
  CodeValue[32]:='11000';        // W
  CodeValue[33]:='00101';        // X
  CodeValue[34]:='10100';        // Y
  CodeValue[35]:='01100';        // Z
  CodeValue[36]:='00011';        // -
  CodeValue[37]:='10010';        // .
  CodeValue[38]:='01010';        // 空格
  CodeValue[39]:='00110';        // *
  CodeValue[40]:='00000';        // $
  CodeValue[41]:='00000';        // /
  CodeValue[42]:='00000';        // +
  CodeValue[43]:='00000';        // %

  CodeValueA[0] :='0100';        // 0
  CodeValueA[1] :='0100';        // 1
  CodeValueA[2] :='0100';        // 2
  CodeValueA[3] :='0100';        // 3
  CodeValueA[4] :='0100';        // 4
  CodeValueA[5] :='0100';        // 5
  CodeValueA[6] :='0100';        // 6
  CodeValueA[7] :='0100';        // 7
  CodeValueA[8] :='0100';        // 8
  CodeValueA[9] :='0100';        // 9
  CodeValueA[10]:='0010';        // A
  CodeValueA[11]:='0010';        // B
  CodeValueA[12]:='0010';        // C
  CodeValueA[13]:='0010';        // D
  CodeValueA[14]:='0010';        // E
  CodeValueA[15]:='0010';        // F
  CodeValueA[16]:='0010';        // G
  CodeValueA[17]:='0010';        // H
  CodeValueA[18]:='0010';        // I
  CodeValueA[19]:='0010';        // J
  CodeValueA[20]:='0001';        // K
  CodeValueA[21]:='0001';        // L
  CodeValueA[22]:='0001';        // M
  CodeValueA[23]:='0001';        // N
  CodeValueA[24]:='0001';        // O
  CodeValueA[25]:='0001';        // P
  CodeValueA[26]:='0001';        // Q
  CodeValueA[27]:='0001';        // R
  CodeValueA[28]:='0001';        // S
  CodeValueA[29]:='0001';        // T
  CodeValueA[30]:='1000';        // U
  CodeValueA[31]:='1000';        // V
  CodeValueA[32]:='1000';        // W
  CodeValueA[33]:='1000';        // X
  CodeValueA[34]:='1000';        // Y
  CodeValueA[35]:='1000';        // Z
  CodeValueA[36]:='1000';        // -
  CodeValueA[37]:='1000';        // .
  CodeValueA[38]:='1000';        // 空格
  CodeValueA[39]:='1000';        // *
  CodeValueA[40]:='1110';        // $
  CodeValueA[41]:='1101';        // /
  CodeValueA[42]:='1011';        // +
  CodeValueA[43]:='0111';        // %
end;


end.
