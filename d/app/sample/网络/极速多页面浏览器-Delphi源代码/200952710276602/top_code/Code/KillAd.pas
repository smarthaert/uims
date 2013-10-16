unit KillAd;

interface

uses
  Windows, Messages, SysUtils, Classes, Variants,
  MSHTML, ActiveX, 
  SHDocVw, EmbeddedWB;

var
  StopPopup: Boolean = true;   //×èÖ¹µ¯³ö¹ã¸æ
  StopFloatAd: Boolean =true;   //ÊÇ·ñ×èÖ¹Æ¯¸¡¹ã¸æ
  StopFlashAd: Boolean =true;  //ÊÇ·ñ×èÖ¹Flash¹ã¸æ
  //DisableScript:Boolean;  //ÊÇ·ñ½ûÖ¹SCRIPT
  //DisableShowGIF:Boolean; //ÊÇ·ñ½ûÖ¹ÏÔÊ¾GIFÍ¼Æ¬
  //DisableShowImage:Boolean; //ÊÇ·ñ½ûÖ¹ÏÔÊ¾allÍ¼Æ¬

procedure ClearAd(WB: TEmbeddedWB{Sender: TObject}; NoClearFlash: Boolean; Frame: Boolean = true);  //Çå³ýÆ¯¸¡¹ã¸æ,flash¹ã¸æ
//procedure ClearAd(Sender: TObject); //Çå³ýÆ¯¸¡¹ã¸æ,flash¹ã¸æ
//procedure ClearAd2(WB: TEmbeddedWB; NoClearFlash: Boolean);
//¿ìËÙÇå³ý¹ã¸æ
procedure ClearAd_(WB: TEmbeddedWB; NoClearFlash: Boolean);

procedure WebPageUnLock(WB: TEmbeddedWB);

//function GetFrame(FrameNo: Integer; WB: TEmbeddedWB): IWebbrowser2;
//function FrameCount(WB: TEmbeddedWB): LongInt;

implementation

uses UnitWebBrowser, var_;

procedure ClearAd(WB: TEmbeddedWB{Sender: TObject}; NoClearFlash: Boolean; Frame: Boolean);
//procedure ClearAd(Sender: TObject);
var
  Doc, Doc1: IHTMLDocument2;
  all: IHtmlelementcollection;
  HtmlFrame: IHtmlFramescollection2;
  i, j, len: integer;
  item, vj: OleVariant;
  //iw: IWebbrowser2;
  spdisp: idispatch;
begin
try
  try   
  {
  StopPopup:=true;
  StopFloatAd:=true;
  StopFlashAd:=true;
  }
  //if FileExists(ExtractFilePath(ParamStr(0))+'txt.txt') then exit;
  if (StopPopup = false)
  and (StopFloatAd = false)
  and (StopFlashAd = false)
  //and (DisableShowImage=false)
  then exit;    //Halt;
  //if WB.LocationURL = 'about:blank' then exit;
  //MessageBox(0,PChar(WB.LocationURL),'',0);     exit;
  //if not TFormWebBrowser(wbList[PageIndex]).NoCleanAd then exit;
  //Doc := WB.Document as IHTMLDocument2;      //hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
  if not SUCCEEDED(WB.document.QueryInterface(IHTMLDocument2, Doc)) then exit;
  if Doc <> nil then
  begin
    //Doc := (sender as TWebBrowser).Document as IHTMLDocument2;
    if Doc = nil then exit;
    all := doc.all;
    len := all.length;
    for i := 0 to len - 1 do
    begin
      item := all.item(i, varempty);

      //Æ¯¸¡¹ã¸æ
      if not NoClearFlash then
      begin
        if StopFloatAd then
        begin
          if (LowerCase(item.style.position) = 'absolute') then
          begin
            //item.outerHTML:='[Í¼Æ¬]';
            item.style.visibility := 'hidden';
          end;
          //if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then item.style.visibility:='hidden';
          //if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then item.style.visibility:='hidden';
        end;
      end;

    {
    //½ûÖ¹SCRIPT
    if DisableScript then
    if (UpperCase(item.tagname)='SCRIPT') then
    begin
      item.style.visibility:='hidden';
    end;
    }

    {
    if (UpperCase(item.tagname)='SCRIPT') then
    begin
      if (Pos('.js',LowerCase(item.src))>0) or (Pos('ad',LowerCase(item.src))>0) then
      item.style.visibility:='hidden';
    end;
    }
    {
    //ÆÁ±ÎgifÍ¼Æ¬
    if DisableShowGIF then
    if ((UpperCase(item.tagname)='IMG') and (Pos('.gif',LowerCase(item.src))>0)) then
    //item.visibility:='hidden';
    item.style.visibility:='hidden';

    //ÆÁ±ÎALLÍ¼Æ¬
    if DisableShowImage then
    if (UpperCase(item.tagname)='IMG') then
    item.style.visibility:='hidden';
    //item.src:=MyDir+WebPageDir+'IMG2.jpg';
    }
    if NoClearFlash then exit;
    //Flash¹ã¸æ
    if StopFlashAd = false then exit;  //and (StopFlashAd=true)
    if (Pos('mail.google.com', LowerCase(WB.LocationURL))>0) then exit;
    if (UpperCase(item.tagname) = 'OBJECT') and (item.classid = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000') then
      item.style.visibility := 'hidden';
    if (UpperCase(item.tagname) = 'EMBED') and (Pos('.swf', LowerCase(item.src)) > 0) then
      item.style.visibility := 'hidden';
    if (UpperCase(item.tagname) = 'PARAM ') and (LowerCase(item.name) = 'movie') then
      item.style.visibility := 'hidden';
    end;
  //
  //exit;
  {
  //if WB.Busy then exit;
  for i:= 0 to FrameCount(WB)-1 do
  begin
    //Doc:=WB.Document as IHTMLDocument2;
    iw:=GetFrame(i,WB);
    Doc:=iw.Document as IHTMLDocument2;
    if Doc=nil then exit;
    all:=doc.all;
    l:=all.length;
    for j:=0 to l-1 do
    begin
      item:=all.item(j,varempty);

      //Æ¯¸¡¹ã¸æ
      if StopFloatAd then
      begin
        if (LowerCase(item.style.position)='absolute') then
        begin
          //item.outerHTML:='[Í¼Æ¬]';
          item.style.visibility:='hidden';
        end;
        //if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then item.style.visibility:='hidden';
        //if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then item.style.visibility:='hidden';
      end;
      //ÆÁ±ÎgifÍ¼Æ¬
      if DisableShowGIF then
      if ((UpperCase(item.tagname)='IMG') and (Pos('.gif',LowerCase(item.src))>0)) then
      //item.visibility:='hidden';
      item.style.visibility:='hidden';

      //ÆÁ±ÎALLÍ¼Æ¬
      if DisableShowImage then
      if (UpperCase(item.tagname)='IMG') then
      item.style.visibility:='hidden';
      //item.src:=MyDir+WebPageDir+'IMG2.jpg';

      //Flash¹ã¸æ
      if StopFlashAd=false then exit;  //and (StopFlashAd=true)
      if (Pos('mail.google.com',LowerCase(WB.LocationURL))>0) then exit;
      if (UpperCase(item.tagname)='OBJECT') and (item.classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000') then
        item.style.visibility:='hidden';
      if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then
        item.style.visibility:='hidden';
      if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then
        item.style.visibility:='hidden';
    end;
  end;
  }
    if not Frame then exit;
    HtmlFrame := doc.Get_frames;
    //ShowMessage(IntToStr(HtmlFrame.length));
    if HtmlFrame.length > 1 then
    begin
      for j := 0 to HtmlFrame.length - 1 do
      begin
        //Application.ProcessMessages;
        vj := j;
        spDisp := HtmlFrame.item(vj);
        if SUCCEEDED(spDisp.QueryInterface(IHTMLWindow2, WB)) then
        begin
          //Memo2.Lines.Add(HtmlWin.name); //Ð´ÉÏframeµÄname
          //if SUCCEEDED(WB.document.QueryInterface(IHTMLDocument2, Doc)) then
          //begin
            doc1 := WB.document as IHTMLDocument2;
            all := doc1.all;
            len := all.length;
            for i := 0 to len - 1 do
            begin
              item := all.item(i, varempty);

              //Æ¯¸¡¹ã¸æ
              if not NoClearFlash then
              begin
                if StopFloatAd then
                begin
                  if (LowerCase(item.style.position) = 'absolute') then
                  begin
                    //item.outerHTML:='[Í¼Æ¬]';
                    item.style.visibility := 'hidden';
                  end;
                  //if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then item.style.visibility:='hidden';
                  //if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then item.style.visibility:='hidden';
                end;
                //if NoClearFlash then exit;
                //Flash¹ã¸æ
                if StopFlashAd = false then exit;  //and (StopFlashAd=true)
                //if (Pos('mail.google.com', LowerCase(WB.LocationURL)) > 0) then exit;
                if (UpperCase(item.tagname) = 'OBJECT') and (item.classid = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000') then
                  item.style.visibility := 'hidden';
                if (UpperCase(item.tagname) = 'EMBED') and (Pos('.swf', LowerCase(item.src)) > 0) then
                  item.style.visibility := 'hidden';
                if (UpperCase(item.tagname) = 'PARAM ') and (LowerCase(item.name) = 'movie') then
                  item.style.visibility := 'hidden';
             end;
            end;
          //end;
        end;
      end;
    end;
  end;
  finally end;
except end;
end;

{
procedure ClearAd2(WB:TEmbeddedWB;NoClearFlash: Boolean);
var
  Doc, Doc1: IHTMLDocument2;
  all: IHtmlelementcollection;
  HtmlFrame: IHtmlFramescollection2;
  i, j, len: integer;
  item, vj: OleVariant;
  //iw: IWebbrowser2;
  spdisp: idispatch;
begin
try
  try
  Doc := WB.Document as IHTMLDocument2;
  if Doc = nil then exit;

  all := doc.all;
  len := all.length;
  for i := 0 to len - 1 do
  begin
    item := all.item(i, varempty);

    //Æ¯¸¡¹ã¸æ
    if not NoClearFlash then
    begin
      //if StopFloatAd then
      begin
        if (LowerCase(item.style.position)='absolute') then
        begin
          //item.outerHTML:='<...>';
          item.style.visibility:='hidden';
        end;
      end;
    end;

    if NoClearFlash then exit;
    //Flash¹ã¸æ
    //if StopFlashAd=false then exit;
    if (Pos('mail.google.com',LowerCase(WB.LocationURL))>0) then exit;
    if (UpperCase(item.tagname)='OBJECT') and (item.classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000') then
    begin
      item.style.visibility:='hidden';
    end;
    if (UpperCase(item.tagname)='EMBED')
    and (Pos('.swf',LowerCase(item.src))>0) then item.style.visibility:='hidden';
    if (UpperCase(item.tagname)='PARAM ')
    and (LowerCase(item.name)='movie') then item.style.visibility:='hidden';
  end;


    HtmlFrame := doc.Get_frames;
    //ShowMessage(IntToStr(HtmlFrame.length));
    if HtmlFrame.length > 1 then
    begin
      for j := 0 to HtmlFrame.length - 1 do
      begin
        //Application.ProcessMessages;
        vj := j;
        spDisp := HtmlFrame.item(vj);
        if SUCCEEDED(spDisp.QueryInterface(IHTMLWindow2, WB)) then
        begin
          //Memo2.Lines.Add(HtmlWin.name); //Ð´ÉÏframeµÄname
          //if SUCCEEDED(WB.document.QueryInterface(IHTMLDocument2, Doc)) then
          //begin
            doc1 := WB.document as IHTMLDocument2;
            all := doc1.all;
            len := all.length;
            for i := 0 to len - 1 do
            begin
              item := all.item(i, varempty);

              if (UpperCase(item.tagname) = 'BODY') then
              begin
                //item.oncontextmenu := 'window.event.returnvalue=false';
                item.oncontextmenu := 'return true';
                item.onselectstart := 'return true';
                item.ondragstart := 'return true';
                item.onbeforecopy := 'return true';
                item.onselect := ''; //document.selection.empty();
                item.oncopy := ''; //document.selection.empty()
                item.onmouseup := ''; //document.selection.empty()
                //item.onkeydown := 'onKeyDown()';
                //<BODY oncontextmenu = "return false" onselectstart="return false" onkeydown=onKeyDown() ondragstart="return false" text=#666666 bgColor=#000000 topMargin=2>
              end;
            end;
          //end;
        end;
      end;
    end;
  finally end;
except end;
end;
}

procedure ClearAd_(WB:TEmbeddedWB;NoClearFlash: Boolean);
var
  Doc:IHTMLDocument2;
  all:IHtmlelementcollection;
  HtmlFrame:IHtmlFramescollection2;
  i,j,l:integer;
  item:OleVariant;
begin
try
  {
  StopPopup:=true;
  StopFloatAd:=true;
  StopFlashAd:=true;
  }
  //if FileExists(ExtractFilePath(ParamStr(0))+'txt.txt') then exit;
  if (StopPopup=false)
  and (StopFloatAd=false)
  and (StopFlashAd=false)
  //and (DisableShowImage=false)
  then exit;
  {
    if TOBMainForm.FPageControl.PageCount=0 then exit;
    //if Self.PclParent.ActivePageIndex>=0 then
    if TOBMainForm.FPageControl.ActivePageIndex>=0 then
    begin
      CurrentIndex:=TOBMainForm.FPageControl.ActivePageIndex;
      //if TFrameWebBrowser(TOBMainForm.FFrameList.Items[CurrentIndex]).WebBrowser.Document=nil then exit;
      WB:=(TFrameWebBrowser(TOBMainForm.FFrameList.Items[CurrentIndex]).WebBrowser);
    end;
  }
  Doc := WB.Document as IHTMLDocument2;
  //Doc:=(sender as TWebBrowser).Document as IHTMLDocument2;
  if Doc = nil then exit;
  all:=doc.all;
  l:=all.length;
  for i:=0 to l-1 do
  begin
    item:=all.item(i,varempty);

    //Æ¯¸¡¹ã¸æ
    if not NoClearFlash then
    begin
    if StopFloatAd then
    begin
      if (LowerCase(item.style.position)='absolute') then
      begin
        //item.outerHTML:='[Í¼Æ¬]';
        item.style.visibility:='hidden';
      end;
      //if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then item.style.visibility:='hidden';
      //if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then item.style.visibility:='hidden';
    end;
    end;
    {
    //½ûÖ¹SCRIPT
    if DisableScript then
    if (UpperCase(item.tagname)='SCRIPT') then
    begin
      item.style.visibility:='hidden';
    end;

    //ÆÁ±ÎgifÍ¼Æ¬
    if DisableShowGIF then
    if ((UpperCase(item.tagname)='IMG') and (Pos('.gif',LowerCase(item.src))>0)) then
    //item.visibility:='hidden';
    item.style.visibility:='hidden';

    //ÆÁ±ÎALLÍ¼Æ¬
    if DisableShowImage then
    if (UpperCase(item.tagname)='IMG') then
    item.style.visibility:='hidden';
    //item.src:=MyDir+WebPageDir+'IMG2.jpg';
    }
    if NoClearFlash then exit;
    //Flash¹ã¸æ
    if StopFlashAd=false then exit;  //and (StopFlashAd=true)
    if (Pos('mail.google.com',LowerCase(WB.LocationURL))>0) then exit;
    if (UpperCase(item.tagname)='OBJECT') and (item.classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000') then
      item.style.visibility:='hidden';
    if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then
      item.style.visibility:='hidden';
    if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then
      item.style.visibility:='hidden';
  end;
  //
  {
  for i:= 0 to FrameCount(WB)-1 do
  begin
    //Doc:=WB.Document as IHTMLDocument2;
    Doc:=GetFrame(i,WB).Document as IHTMLDocument2;
    if Doc=nil then exit;
    all:=doc.all;
    l:=all.length;
    for j:=0 to l-1 do
    begin
      item:=all.item(j,varempty);

      //Æ¯¸¡¹ã¸æ
      if StopFloatAd then
      begin
        if (LowerCase(item.style.position)='absolute') then
        begin
          //item.outerHTML:='[Í¼Æ¬]';
          item.style.visibility:='hidden';
        end;
        //if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then item.style.visibility:='hidden';
        //if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then item.style.visibility:='hidden';
      end;

      //½ûÖ¹SCRIPT
      if DisableScript then
      if (UpperCase(item.tagname)='SCRIPT') then
      begin
        item.style.visibility:='hidden';
      end;

      //ÆÁ±ÎgifÍ¼Æ¬
      if DisableShowGIF then
      if ((UpperCase(item.tagname)='IMG') and (Pos('.gif',LowerCase(item.src))>0)) then
      //item.visibility:='hidden';
      item.style.visibility:='hidden';

      //ÆÁ±ÎALLÍ¼Æ¬
      if DisableShowImage then
      if (UpperCase(item.tagname)='IMG') then
      item.style.visibility:='hidden';
      //item.src:=MyDir+WebPageDir+'IMG2.jpg';

      //Flash¹ã¸æ
      if StopFlashAd=false then exit;  //and (StopFlashAd=true)
      if (UpperCase(item.tagname)='OBJECT') and (item.classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000') then
        item.style.visibility:='hidden';
      if (UpperCase(item.tagname)='EMBED') and (Pos('.swf',LowerCase(item.src))>0) then
        item.style.visibility:='hidden';
      if (UpperCase(item.tagname)='PARAM ') and (LowerCase(item.name)='movie') then
        item.style.visibility:='hidden';
    end;
  end;
  }
except end;
end;

procedure WebPageUnLock(WB:TEmbeddedWB);
var
  Doc, Doc1: IHTMLDocument2;
  all: IHtmlElementCollection;
  i, j, len: integer;
  item, vj: OleVariant;
  spdisp: idispatch;
  //HtmlWin, oneframe: Ihtmlwindow2;
  HtmlFrame: ihtmlframescollection2;
begin
try
  try
  //doc := WB.Document as IHTMLDocument2;
  if not SUCCEEDED(WB.document.QueryInterface(IHTMLDocument2, Doc)) then exit;
  if Doc <> nil then
  begin
    ////Doc := (sender as TWebBrowser).Document as IHTMLDocument2;
    //Doc := WB.Document as IHTMLDocument2;
    //if Doc=nil then exit;
    all := doc.all;
    len := all.length;
    for i := 0 to len - 1 do
    begin
      item := all.item(i, varempty);

      if (UpperCase(item.tagname)='BODY') then
      begin
        //item.oncontextmenu:='window.event.returnvalue=false';
        item.oncontextmenu := 'return true';
        item.onselectstart := 'return true';
        item.ondragstart := 'return true';
        item.onbeforecopy := 'return true';
        item.onselect := ''; //document.selection.empty();
        item.oncopy := ''; //document.selection.empty()
        item.onmouseup := ''; //document.selection.empty()
        //item.onkeydown := 'onKeyDown()';
        //<BODY oncontextmenu="return false" onselectstart="return false" onkeydown=onKeyDown() ondragstart="return false" text=#666666 bgColor=#000000 topMargin=2>
      end;   //http://www.sciequip.com.cn/product.asp?SubProductID=2765
    end;
    
    HtmlFrame := doc.Get_frames;
    //ShowMessage(IntToStr(HtmlFrame.length));
    if HtmlFrame.length > 1 then
    begin
      for j := 0 to HtmlFrame.length - 1 do
      begin
        //Application.ProcessMessages;
        vj := j;
        spDisp := HtmlFrame.item(vj);
        if SUCCEEDED(spDisp.QueryInterface(IHTMLWindow2, WB)) then
        begin
          //Memo2.Lines.Add(HtmlWin.name); //Ð´ÉÏframeµÄname
          //if SUCCEEDED(WB.document.QueryInterface(IHTMLDocument2, Doc)) then
          //begin
            doc1 := WB.document as IHTMLDocument2;
            all := doc1.all;
            len := all.length;
            for i := 0 to len - 1 do
            begin
              item := all.item(i, varempty);

              if (UpperCase(item.tagname) = 'BODY') then
              begin
                //item.oncontextmenu := 'window.event.returnvalue=false';
                item.oncontextmenu := 'return true';
                item.onselectstart := 'return true';
                item.ondragstart := 'return true';
                item.onbeforecopy := 'return true';
                item.onselect := ''; //document.selection.empty();
                item.oncopy := ''; //document.selection.empty()
                item.onmouseup := ''; //document.selection.empty()
                //item.onkeydown := 'onKeyDown()';
                //<BODY oncontextmenu = "return false" onselectstart="return false" onkeydown=onKeyDown() ondragstart="return false" text=#666666 bgColor=#000000 topMargin=2>
              end;
            end;
          //end;
        end;
      end;
    end;
  end;
  finally
  end;
except end;
end;

{
function GetFrame(FrameNo:Integer;WB:TEmbeddedWB):IWebbrowser2;
var
  OleContainer: IOleContainer;
  enum: IEnumUnknown;
  unk: IUnknown;
  Fetched: PLongint;
begin
try
  //
  //while ReadyState <> READYSTATE_COMPLETE do
    //Forms.Application.ProcessMessages;
  //
  if WB.Busy then exit;
  if Assigned(WB.document) then
  begin
    Fetched := nil;
    OleContainer := WB.Document as IOleContainer;
    OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum);
    Enum.Skip(FrameNo);
    Enum.Next(1, Unk, Fetched);
    Result := Unk as IWebbrowser2;
  end else Result := nil;
except end;
end;

function FrameCount(WB:TEmbeddedWB):LongInt;
var
  OleContainer: IOleContainer;
  enum: IEnumUnknown;
  unk: array[0..99] of IUnknown; // CHANGED from "unk: IUnknown;"
  EnumResult: HRESULT;
begin
try
  //
  //while ReadyState <> READYSTATE_COMPLETE do
    //Forms.Application.ProcessMessages;
  //
  if Assigned(WB.document) then
  begin
    OleContainer := WB.Document as IOleContainer;
    EnumResult := OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum);
    if EnumResult = S_OK then // Added per OLE help
      Enum.Next(100, Unk, @Result)
    else // Added per OLE help
      Enum := nil;
  end else
    Result := 0;
except end;
end;
}

end.

