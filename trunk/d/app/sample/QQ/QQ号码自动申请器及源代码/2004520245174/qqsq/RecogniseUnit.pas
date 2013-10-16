(*//
标题:简单的图象识别
声明:本贴只作为技术交流
设计:Zswang
日期:2003-09-09

http://verify.tencent.com/getimage?0.13927358567975412
这是一个附加码～～

先分析下
难点：
1.四个数字加上了一些随机的布点～～
2.背景和字体颜色也随机～～

弱点：
1.数字大小一致，字体不会发生改变～～
2.只有两种颜色～～

思路：
取得背景色和字体色比较容易，谁的点多就是背景～～
这里是用TBitmap::PixelFormat来处理成单色～～

将标准的数字字体保存下来（就１０个），作为比较的元素～～
把两个图象重叠～～
比较重叠前和重叠后是否发生变化～～
这样就可以避免随机布点的干扰～～

话不多说，代码为例～～
//*)

unit RecogniseUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls, OleCtrls, SHDocVw,MSHTML,WinInet;

type
  TFormRecognise = class(TForm)
    ImageList1: TImageList;
    ButtonRefresh: TButton;
    Panel1: TPanel;
    WebBrowser1: TWebBrowser;
    procedure ButtonRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    procedure FillIEForm(aValidatecode:String;bPost:boolean=False);
    { Public declarations }
  end;

var
  FormRecognise: TFormRecognise;
const
  cURL='http://freeqq2.qq.com/nom_reg.shtml';
  cImgX=231;
  cImgY=314;
implementation

{$R *.dfm}

uses Math; //use Math.Min()
procedure TFormRecognise.FillIEForm(aValidatecode:String;bPost:boolean=False);
  procedure DoWithHtmlElement(aElementCollection:IHTMLElementCollection);
  var
    k:integer;
    vk:oleVariant;
    Dispatch: IDispatch;
    HTMLInputElement:IHTMLInputElement;
    HTMLSelectElement:IHTMLSelectElement;
    HTMLOptionElement: IHTMLOptionElement;
    HTMLTextAreaElement: IHTMLTextAreaElement;
    HTMLFormElement:IHTMLFormElement;
    HTMLOptionButtonElement:IHTMLOptionButtonElement;
  begin
    for k:=0 to aElementCollection.length -1 do
    begin
      Vk:=k;
      Application.ProcessMessages;
      Dispatch:=aElementCollection.item(Vk,0);
      if SUCCEEDED(Dispatch.QueryInterface(IHTMLFormElement,HTMLFormElement))then
      begin
        with HTMLFormElement do//表单
        begin
          //处理
          if bPost then
          begin
            HTMLFormElement.submit ;
            exit;
          end;
        end;
      end
      else if Succeeded(Dispatch.QueryInterface(IHTMLInputElement,HTMLInputElement)) then
      begin
        With HTMLInputElement do//单行文本
        begin
          if (UpperCase(Type_)='TEXT') or (UpperCase(Type_)='PASSWORD') then
          begin
            value:='qq';
            if Name='Validatecode' then Value:=aValidatecode
            else if Name='Passwd' then Value:='123456'
            else if Name='Passwd1' then Value:='123456';
          end
          else if (UpperCase(Type_)='CHECKBOX') then//复选框
          begin
            checked:=true;
          end
          else if (UpperCase(Type_)='RADIO') then//单选框
          begin
            checked :=true;
          end;
        end;
      end
      else if Succeeded(Dispatch.QueryInterface(IHTMLSelectElement,HTMLSelectElement)) then
      begin
        With HTMLSelectElement do//下拉框
        begin
          selectedIndex :=1;
        end;
      end
      else if Succeeded(Dispatch.QueryInterface(IHTMLTEXTAreaElement,HTMLTextAreaElement)) then
      begin
        with HTMLTextAreaElement do//多行文本
        begin
          value :='textarea';
        end;
      end
      else if Succeeded(Dispatch.QueryInterface(IHTMLOptionElement,HTMLOptionElement)) then
      begin
        with HTMLOptionElement do//下拉选项
        begin
          //处理
        end;
      end
      else if SUCCEEDED(Dispatch.QueryInterface(IHTMLOptionButtonElement,HTMLOptionButtonElement))then
      begin
        //不明
        //处理
      end
      else
        //showmessage('other');
        ;
    end;
  end;
var
  HTMLDocument:IHTMLDocument2;
  ElementCollection:IHTMLElementCollection;
begin
  HTMLDocument:=IHTMLDocument2(WebBrowser1.Document);
  if HTMLDocument<>nil then
  begin
    if HTMLDocument.frames.length =0 then//无框架
    begin
      ElementCollection:=HTMLDocument.Get_All;
      DoWithHtmlElement(ElementCollection);
    end;
  end;
end;
function SameCanvas(mCanvasA, mCanvasB: TCanvas): Boolean; { 比较两个画布是否相同 }
var
  I, J: Integer;
begin
  Result := False;
  if not Assigned(mCanvasA) then Exit;
  if not Assigned(mCanvasB) then Exit;
  for I := Min(mCanvasA.ClipRect.Left, mCanvasB.ClipRect.Left) to
    Min(mCanvasA.ClipRect.Right, mCanvasB.ClipRect.Right) do
    for J := Min(mCanvasA.ClipRect.Top, mCanvasB.ClipRect.Top) to
      Min(mCanvasA.ClipRect.Bottom, mCanvasB.ClipRect.Bottom) do
      if mCanvasA.Pixels[I, J] <> mCanvasB.Pixels[I, J] then Exit;
  Result := True;
end; { SameCanvas }

procedure TFormRecognise.ButtonRefreshClick(Sender: TObject);
  procedure fNumBitmap(mHandle: THandle; mIndex: Integer; mBitmap: TBitmap);
  var
    vDC: HDC;
  begin
    vDC := GetDC(mHandle);
    try
      mBitmap.Assign(nil);
      mBitmap.Width := 5;
      mBitmap.Height := 8;
      BitBlt(mBitmap.Canvas.Handle, 0, 0, mBitmap.Width, mBitmap.Height, vDC,
        CImgX + 6 * mIndex, CImgY, SRCCOPY);
      mBitmap.PixelFormat := pf8bit;
      mBitmap.PixelFormat := pf1bit;
    finally
      DeleteDC(vDC);
    end;
  end;

  function fGetNum(mHandle: THandle; mIndex: Integer): Integer;
  var
    I: Integer;
    vBitmapA: TBitmap;
    vBitmapB: TBitmap;
  begin
    Result := -1;
    vBitmapA := TBitmap.Create;
    vBitmapB := TBitmap.Create;
    fNumBitmap(mHandle, mIndex, vBitmapA);
    vBitmapB.Width := vBitmapA.Width;
    vBitmapB.Height := vBitmapA.Height;
    for I := 9 downto 0 do begin //8会覆盖3的基础码，所以反循环
      vBitmapB.Canvas.Draw(0, 0, vBitmapA);
      ImageList1.Draw(vBitmapB.Canvas, 0, 0, I);
      vBitmapB.PixelFormat := pf8bit;
      vBitmapB.PixelFormat := pf1bit;
      if SameCanvas(vBitmapA.Canvas, vBitmapB.Canvas) then begin
        Result := I;
        Exit;
      end;
    end;
    vBitmapA.Free;
    vBitmapB.Free;
  end;
  procedure AppendFile(aFileName,aContent:String);
  var
    StrList:TStringList;
  begin
    StrList:=TStringList.Create;
    //有则追加
    if FileExists(aFileName) then
      StrList.LoadFromFile(aFileName);
    StrList.Add(aContent);
    StrList.SaveToFile(aFileName);
    StrList.Free;
  end;

var
  S,tmpStr,tmpContent: string;
  I: Integer;
  HTMLDocument:IHTMLDocument2;
begin
  TButton(Sender).Enabled := False;
  if not InternetCheckConnection(PChar(CUrl), 1, 0) then
  Begin
    ShowMessage('网路不通!');
    Exit;
  End;
  WebBrowser1.Navigate(CURL);
  while WebBrowser1.ReadyState <READYSTATE_COMPLETE	 do
      Application.ProcessMessages;
  S := '';
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, 0, 0, SWP_NOSIZE);
  for I := 0 to 3 do S := S + IntToStr(fGetNum(WebBrowser1.Handle, I));
  SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, 0, 0, SWP_NOSIZE);
  //填 表
  FillIEForm(S);
  //提交
  FillIEForm('',True);
  //等待提交完毕
  while (WebBrowser1.LocationURL  =CURL) do
  Begin
    //强制结束
    If Tag=27 then Exit;
    Application.ProcessMessages;
  End;
  //显示完毕
  while WebBrowser1.ReadyState <READYSTATE_COMPLETE	 do
      Application.ProcessMessages;

  if Succeeded(WebBrowser1.Document.QueryInterface(IHTMLDocument2,HTMLDocument)) then
  Begin
    if assigned(HTMLDocument.body) then
    begin
      tmpStr:=HTMLDocument.body.OuterText;
      if tmpStr<>'' then
      begin
        if Pos('您申请的QQ号码为：',tmpStr)>0 then
        Begin
          tmpContent:=Copy(tmpStr,Pos('您申请的QQ号码为：',tmpStr),28)+
            #13#10+'　　　初始密码为123456';
          ShowMessage(tmpContent+#13#10+#13#10+'保存于<QQ号码申请列表.txt>');
          tmpContent:=tmpContent+'  于'+DateTimeTOStr(Now);
          //保存
          AppendFile(ExtractFilePath(Application.ExeName)+'QQ号码申请列表.txt',tmpContent);
        End
        else if Pos('此ip申请qq号码过多，请稍后再试!!',tmpStr)>0 then
          ShowMessage('此ip申请qq号码过多，请稍后再试!!')
        else
          ShowMessage('未知错误');
      end
      else
        ShowMessage('该IP已经申请过');
    End;
  End;
  WebBrowser1.Navigate('about:blank');
  ButtonRefresh.Enabled := True;
end;


procedure TFormRecognise.FormCreate(Sender: TObject);
begin
  //WebBrowser1.Navigate('http://freeqq2.qq.com/nom_reg.shtml');
  //WebBrowser1.Navigate('about:blank');
  WebBrowser1.Left:=Panel1.Left-CImgX+8;//-223    0        231
  WebBrowser1.Top:=Panel1.Top-CImgY+8;;  //-306    0        314
  WebBrowser1.Width:=CImgX+50;//300     52
  WebBrowser1.Height:=CImgY+50;//350    23
end;

procedure TFormRecognise.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Tag:=27;
  if WebBrowser1.Busy then
  Begin
    WebBrowser1.Navigate('about:blank');
    Application.Terminate;
  End;
end;

end.
