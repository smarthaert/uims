unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDrawKline, uMyStockManager, uStockManager, Menus, ComCtrls,
  StdCtrls, ExtCtrls, Buttons, TDXGrobal;

type
   //主界面图形模式
   TStockDrawType = (DT_KLINE, DT_MIN, DT_F10);

  TRSRStockDemo = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    UpDown1: TUpDown;
    LBStocks: TListBox;
    Edit3: TEdit;
    UpDown2: TUpDown;
    Edit4: TEdit;
    UpDown3: TUpDown;
    Edit5: TEdit;
    UpDown4: TUpDown;
    CheckBox2: TCheckBox;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    TabSheet3: TTabSheet;
    Panel5: TPanel;
    TabSheet4: TTabSheet;
    Panel6: TPanel;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    K1: TMenuItem;
    SM: TStockManager;
    SDKLine: TStockDrawKLines;
    SDMins: TStockDrawMins;
    SDPK: TStockDrawPK;
    MSMSelect: TMySelectStocksManager;
    MSMAll: TAllStocksManager;
    SDDeals: TStockDrawDeals;
    ColorDialog1: TColorDialog;
    F10: TStockDrawF10;
    F101: TMenuItem;
    Label2: TLabel;
    N11: TMenuItem;
    N51: TMenuItem;
    N101: TMenuItem;
    N151: TMenuItem;
    N301: TMenuItem;
    N601: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N451: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SMConnect(Sender: TObject);
    procedure SMDisConnect(Sender: TObject);
    procedure SMCurStockChange(Sender: TObject);
    procedure SMInitStocks(Sender: TObject; Stock: TStockObject; MaxCount,
      Progress: Integer);
    procedure SMReadData(Sender: TObject; bufCount: Integer);
    procedure SMDecodePacket_REALPK(data: TTDX_REALPKDAT);
    procedure FormCreate(Sender: TObject);
    procedure LBStocksDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LBStocksDblClick(Sender: TObject);
    procedure LBStocksKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1DblClick(Sender: TObject);
    procedure MSMSelectDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure TabSheet1Show(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure F101Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }
    DrawType  :TStockDrawType;
    BoInit, BoBeginInit  :array[0..MARKETS_COUNT-1] of boolean;
    SocketRects  :array [0..MAX_TDXMANAGER-1] of TRect;
    LastVK :word;
    LastKeyTick  :longword;
    LastPageIndex  :Integer;

    RecvTotalBytes, RecvBytes  :LongWord;
  public
    { Public declarations }

    procedure CopyStockDrawCFG;
  end;

var
  RSRStockDemo: TRSRStockDemo;

implementation

{$R *.dfm}

procedure TRSRStockDemo.BitBtn1Click(Sender: TObject);
begin
   SM.Connect (ComboBox2.Text);
end;

procedure TRSRStockDemo.BitBtn2Click(Sender: TObject);
begin
   SM.DisConnect;
end;

procedure TRSRStockDemo.SMConnect(Sender: TObject);
var i: integer;
begin
   //if self.BoDrawKMin then
      SDKLine.Handle := Panel2.Handle;
   //else

   SDPK.Handle  := Panel3.Handle;
   SDDeals.Handle := Panel4.Handle;
   MSMSelect.Handle := Panel5.Handle;
   MSMAll.Handle  := Panel6.Handle;
   
   StatusBar1.Repaint;
   BitBtn1.Enabled  := False;
   BitBtn2.Enabled  := True;
   //如果有其它线程完成过初始化，就不必要再初始化了
   if BoBeginInit[0] and BoBeginInit[1] then exit;
   for i  := Low (BoBeginInit) to High (BoBeginInit) do
      BoBeginInit[i]  := True;
   SM.InitData;

end;

procedure TRSRStockDemo.SMDisConnect(Sender: TObject);
begin
   BitBtn1.Enabled  := True;
   BitBtn2.Enabled  := False;
   StatusBar1.Repaint;
end;

procedure TRSRStockDemo.SMCurStockChange(Sender: TObject);
var stkobj: TStockObject;
begin
   if SM.CurStock <> nil then begin
      SM.CurTDXManager.Get_TestRealPK(SM.CurStock.StkCode, SM.CurStock.Market, SM.CurStock.PK.LastDealTime);
      SM.CurTDXManager.Get_K_Days(SM.CurStock.StkCode, SM.CurStock.Market, 0, DEFAULT_KDAYS);
      SM.CurTDXManager.Get_Mins(SM.CurStock.StkCode, SM.CurStock.Market, 0);
      //SM.CurTDXManager.Get_Deals();
   end;
end;

procedure TRSRStockDemo.SMInitStocks(Sender: TObject; Stock: TStockObject;
  MaxCount, Progress: Integer);
var i: integer;
    stkobj  :TStockObject;
begin

   if MaxCount <> Progress then exit;
   case Stock.market of
      0..1: BoInit[Stock.market]  := True;
   end;
   for i  := low (BoInit) to High(BoInit) do begin
      if not BoInit[i] then exit;
   end;


   MSMSelect.Load;
   MSMAll.Load;
   SM.GetSpecialPK;
   stkobj := SM.FindStock(PChar (Edit1.Text));
   if stkobj <> nil then
      SM.Get_TestRealPK(stkobj.StkCode, stkobj.Market, stkobj.PK.LastDealTime);
end;

procedure TRSRStockDemo.SMReadData(Sender: TObject; bufCount: Integer);
begin
   Inc (RecvTotalBytes, bufCount);
   RecvBytes  := bufCount;
   StatusBar1.Repaint;
end;

procedure TRSRStockDemo.SMDecodePacket_REALPK(data: TTDX_REALPKDAT);
begin
   if SM.CurStock = nil then
      SM.CurStock := SM.FindStock(data.PK.code, data.PK.MarketMode);
   if PageControl1.ActivePageIndex <> 0 then
      PageControl1.ActivePage.Repaint;
end;

procedure TRSRStockDemo.CopyStockDrawCFG;
begin
   MSMSelect.GDIMatrix := SDPK.GDIMatrix;
   MSMAll.GDIMatrix  := SDPK.GDIMatrix;
   SDDeals.GDIMatrix  := SDPK.GDIMatrix;
   SDKLine.GDIMatrix  := SDPK.GDIMatrix;
   SDMins.GDIMatrix := SDPK.GDIMatrix;
   MSMSelect.Colors.Assign(SDPK.Colors);
   MSMAll.Colors.Assign(SDPK.Colors);
   SDDeals.Colors.Assign(SDPK.Colors);
   SDKLine.Colors.Assign(SDPK.Colors);
   SDMins.Colors.Assign(SDPK.Colors);
   F10.Colors.Assign(SDPK.Colors);
   if CheckBox1.Checked
      then SDPK.AddTransparentColor(SDPK.Colors.Background)
   else
      SDPK.DeleteTransparentColor(SDPK.Colors.Background);
   SDPK.DoubleBuffered  := CheckBox2.Checked;


   MSMSelect.TransparentColors.Assign(SDPK.TransparentColors);
   MSMAll.TransparentColors.Assign(SDPK.TransparentColors);
   SDDeals.TransparentColors.Assign(SDPK.TransparentColors);
   SDKLine.TransparentColors.Assign(SDPK.TransparentColors);
   SDMins.TransparentColors.Assign(SDPK.TransparentColors);
   F10.TransparentColors.Assign(SDPK.TransparentColors);

   MSMSelect.DoubleBuffered := SDPK.DoubleBuffered;
   MSMAll.DoubleBuffered  := SDPK.DoubleBuffered;
   SDDeals.DoubleBuffered := SDPK.DoubleBuffered;
   SDKLine.DoubleBuffered := SDPK.DoubleBuffered;
   SDMins.DoubleBuffered  := SDPK.DoubleBuffered;
   F10.DoubleBuffered := SDPK.DoubleBuffered;
end;

procedure TRSRStockDemo.FormCreate(Sender: TObject);
begin
   With LBStocks do begin
      Style := lbOwnerDrawFixed;
      Ctl3D := false;
      ItemHeight := 20;
   end;

   if not StatusBar1.DoubleBuffered then
      StatusBar1.DoubleBuffered  := True;


   SDPK.GDIMatrix[0, 0] := 0.99;
   SDPK.GDIMatrix[1, 1] := 0.99;
   SDPK.GDIMatrix[2, 2] := 0.99;
   SDPK.GDIMatrix[3, 3] := 0.99;
   UpDown1.Position := Round (SDPK.GDIMatrix[3, 3] * 100);
   SDPK.AddTransparentColor(SDPK.Colors.Background);
   CopyStockDrawCFG;
end;

procedure TRSRStockDemo.LBStocksDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var   lb: TListBox;
      str :string;
      stkobj: TStockObject;

      i, L, T :integer;
      _rc :TRect;
      image :TImage;
begin

   lb := LBStocks;
//文字颜色

   //设置背景颜色并填充背景
   With lb.Canvas do begin
      if(odSelected in State) then
         Brush.Color := clSilver
      else
         Brush.Color  := clWhite;
      FillRect (Rect);

      stkobj := TStockObject (lb.Items.Objects[Index]);


      L := Rect.Left + 2;

      SetBkMode(Handle,TRANSPARENT);//文字透明！

      Font.Size  := 12;
      Font.Style  := [fsBold];
      //L := Rect.Left + 32 + 10;
      Font.Color  := clMaroon;
      T := Rect.Top + 2;
      str := Format ('%s',[stkobj.StkCode]);
      TextOut(L, T, str);
      Inc (L, TextWidth (str+' '));

      Font.Color  := clBlue;
      str := stkobj.StkName;
      TextOut (L, T, str);

      if(odSelected in State) then
         begin

             Pen.Color := clGray;
             //如果当前项拥有焦点，画焦点虚框，当系统再绘制时变成XOR运算从而达到擦除焦点虚框的目的
             if(odFocused in State) then
                DrawFocusRect(Rect);
         end;
   end;
end;

procedure TRSRStockDemo.Edit1Change(Sender: TObject);
begin
   MSMAll.SearchStocks(TEdit(Sender).Text, LBStocks.Items);
end;

procedure TRSRStockDemo.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Case Key of
      VK_RETURN,VK_DOWN:
         begin
            Key := 0;
            LBStocks.SetFocus;
            if LBStocks.Count > 0 then
               LBStocks.ItemIndex := 0;

            if key = VK_RETURN then
               LBStocksDblClick (LBStocks);
         end;

   end;
end;

procedure TRSRStockDemo.LBStocksDblClick(Sender: TObject);
var index: integer;
    stkobj: TStockObject;
begin
   index  := TListBox (Sender).ItemIndex ;
   if index < 0 then exit;
   stkobj := TStockObject (TListBox (Sender).Items.Objects[index]);
   if stkobj = nil then exit;
   SM.CurStock  := stkobj;
   PageControl1.ActivePageIndex := 1;
   Edit1.Text := '';
end;

procedure TRSRStockDemo.LBStocksKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Case Key of
      VK_RETURN:
         begin
            Key := 0;
            LBStocksDblClick (LBStocks);
         end;

      VK_UP:
         begin
            if LBStocks.ItemIndex = 0 then
               Edit1.SetFocus;
         end;

   end;
end;

procedure TRSRStockDemo.UpDown1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
   if Sender = UpDown1 then
      SDPK.GDIMatrix[3, 3] := NewValue/100;
   if Sender = UpDown2 then
      SDPK.GDIMatrix[0, 0] := NewValue/100;
   if Sender = UpDown3 then
      SDPK.GDIMatrix[1, 1] := NewValue/100;
   if Sender = UpDown4 then
      SDPK.GDIMatrix[2, 2] := NewValue/100;
   CopyStockDrawCFG;
end;

procedure TRSRStockDemo.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if CheckBox1.Checked then
      SDPK.AddTransparentColor(SDPK.Colors.Background)
   else
      SDPK.DeleteTransparentColor(SDPK.Colors.Background);
   CopyStockDrawCFG;
end;

procedure TRSRStockDemo.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   SDPK.DoubleBuffered  := CheckBox2.Checked;
   CopyStockDrawCFG;
end;

procedure TRSRStockDemo.Panel1DblClick(Sender: TObject);
begin
   With ColorDialog1 do begin
      if Execute then begin
         TPanel(Sender).Color := Color;
         SDPK.Colors.Background  := Color;
         CopyStockDrawCFG;
      end;
   end;
end;

procedure TRSRStockDemo.MSMSelectDblClick(Sender: TObject);
begin
   PageControl1.ActivePageIndex := 1;
end;

procedure TRSRStockDemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   SM.DisConnect;
end;

procedure TRSRStockDemo.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
  function  GetBytesString (BytesCount: longword): string;
var str: string;
    fM, fK  :double;
    recvCount :Longword;
begin
   recvCount  := BytesCount;
   fK := recvCount / 1024;
   fM := fK / 1024;
   if fM > 1 then
      str := Format ('%.02fMB',[fM])
   else if fK > 1 then
      str := Format ('%.02fKB', [fK])
   else
      str := Format ('%dBytes', [recvCount]);

   Result := str;
end;
var aStock  :TStockObject;
      change  :Single;
      str, str2     :string;
      HW      :integer;
      RC, _rc  :TRect;
      i, n   :Integer;

      BMP :TBitMap;
begin
//

   BMP  := TBitMap.Create; try
   BMP.Width  := Rect.Right - Rect.Left;
   BMP.Height := Rect.Bottom - Rect.Top;
   RC.Top := 0;
   RC.Left  := 0;
   RC.Right := BMP.Width;
   RC.Bottom  := BMP.Height;
   //RC := Rect;

   With BMP.Canvas do begin
      Brush.Color := SDPK.Colors.Background;
      FillRect (RC);
      Inc (RC.Top, 1);
      Dec (RC.Bottom, 1);
      if Panel = StatusBar.Panels[0] then begin
          aStock  := SM.Stock999999;
          if Assigned (aStock) then begin
             change := aStock.PK.Close - aStock.PK.YClose;
             Font.Color := SDPK.Colors.Background;
             str  := '上证：';
             HW   := TextWidth (str);
             Font.Style := Font.Style - [fsBold];
             TextOut (RC.Left, RC.Top , str);
             if change > 0 then begin
                Font.Color  := SDPK.Colors.Up;
                str2        := '↑';
             end else if change < 0 then begin
                Font.Color  := SDPK.Colors.Down ;
                str2        := '↓';
             end else begin
                Font.Color  := SDPK.Colors.Black;
                str2        := ''
             end;

             str  := Format('%.02f %.02f %.02f%% %.01f亿 %s',[
                aStock.PK.Close,
                change,
                change / aStock.PK.YClose * 100,
                aStock.PK.Amount / 100000000,
                str2
                ]);
             Font.Style := Font.Style + [fsBold];
             TextOut (RC.Left + HW, RC.Top, str);
          end;
      end;

      if Panel = StatusBar.Panels[1] then begin
          aStock  := SM.Stock399001;
          if Assigned (aStock) then begin
             change := aStock.PK.Close - aStock.PK.YClose;
             Font.Color := SDPK.Colors.Background;
             str  := '深证：';
             HW   := TextWidth (str);
             Font.Style := Font.Style - [fsBold];
             TextOut (RC.Left, RC.Top , str);
             if change > 0 then begin
                Font.Color  := SDPK.Colors.Up;
                str2        := '↑';
             end else if change < 0 then begin
                Font.Color  := SDPK.Colors.Down;
                str2        := '↓';
             end else begin
                Font.Color  := SDPK.Colors.Black;
                str2        := ''
             end;

             str  := Format('%.02f %.02f %.02f%% %.01f亿 %s',[
                aStock.PK.Close,
                change,
                change / aStock.PK.YClose * 100,
                aStock.PK.Amount / 100000000,
                str2
                ]);
             Font.Style := Font.Style + [fsBold];
             TextOut (RC.Left + HW, RC.Top, str);
          end;
      end;

      if Panel = StatusBar.Panels[2] then begin
         _rc  := RC;
         _rc.Left := _rc.Left + 2;
         for i  := low (SM.TDXSockMans) to High (SM.TDXSockMans) do begin
            SocketRects[i]        := _RC;
            SocketRects[i].Left   := _rc.Left;
            SocketRects[i].Right  := _rc.Left + 12;

            if SM.TDXSockMans[i].IdTCPClient.Connected then begin
               Brush.Color := SDPK.Colors.Line;
               Font.Color := SDPK.Colors.White;
            end else begin
               Brush.Color  := SDPK.Colors.White;
               Font.Color := SDPK.Colors.Line;
            end;

            FillRect(SocketRects[i]);
            n := SM.TDXSockMans[i].FMsgList.Count;
            if n <> 0 then
               TextOut (SocketRects[i].Left + 2, SocketRects[i].Top, IntToStr (n) );

            Inc ( _rc.Left, 12 + 2 );
         end;
      end;

      if Panel = StatusBar.Panels[3] then begin
         Font.Color := SDPK.Colors.CaptionText;

         str  := Format ('数据:%s/%dB',[GetBytesString (RecvTotalBytes), RecvBytes]);
         TextOut (RC.Left + 2, RC.Top, str);
      end;

   end;

   SDPK.IGDIDraw (StatusBar1.Canvas, BMP, Rect);

   finally BMP.Free; end;


end;

procedure TRSRStockDemo.TabSheet1Show(Sender: TObject);
begin
   Panel1.Color := SDPK.Colors.Background;

   UpDown1.Position := Round (SDPK.GDIMatrix[3,3]*100);
   UpDown2.Position := Round (SDPK.GDIMatrix[0,0]*100);
   UpDown3.Position := Round (SDPK.GDIMatrix[1,1]*100);
   UpDown4.Position := Round (SDPK.GDIMatrix[2,2]*100);
   CheckBox1.Checked  := SDPK.IsTransparentColor(SDPK.Colors.Background);
   CheckBox2.Checked  := SDPK.DoubleBuffered;
end;

procedure TRSRStockDemo.N1Click(Sender: TObject);
begin
   if PopupMenu1.PopupComponent = Panel6 then begin
      if (MSMAll.ItemIndex >= LOW (MSMAll.StockDraws) )
      and (MSMAll.ItemIndex <= HIGH (MSMALL.StockDraws)) then
      MSMSelect.Add(MSMAll.StockDraws[MSMAll.ItemIndex].stkinfo.Code,
          MSMAll.StockDraws[MSMAll.ItemIndex].stkinfo.Name);
   end else begin
      if SM.CurStock <> nil then
         MSMSelect.Add(SM.CurStock.StkCode, SM.CurStock.StkName);
   end;
end;

procedure TRSRStockDemo.N2Click(Sender: TObject);
begin
   if PopupMenu1.PopupComponent = Panel5 then begin
      if (MSMSelect.ItemIndex >= LOW (MSMSelect.StockDraws) )
      and (MSMSelect.ItemIndex <= HIGH (MSMSelect.StockDraws)) then
      MSMSelect.Delete(MSMSelect.StockDraws[MSMSelect.ItemIndex].stkinfo.Code,
          MSMSelect.StockDraws[MSMSelect.ItemIndex].stkinfo.Name);
   end;
end;

procedure TRSRStockDemo.N3Click(Sender: TObject);
begin
   DrawType := DT_MIN;
   SDMins.Handle  := Panel2.Handle;
end;

procedure TRSRStockDemo.F101Click(Sender: TObject);
begin
   DrawType := DT_F10;
   F10.Handle := panel2.Handle;
   if SM.CurStock <> nil then
      SM.CurTDXManager.Get_F10(SM.CurStock.StkCode, SM.CurStock.Market);
end;

procedure TRSRStockDemo.N11Click(Sender: TObject);
var mi  :TMenuItem;
    i :TKLineDateMode;
begin
   DrawType := DT_KLINE;
   SDKLine.Handle := panel2.Handle;
   if SM.CurStock = nil then exit;
   SM.CurStock.KLineCount := DEFAULT_KDAYS;
   SM.CurStock.KLineStart := DEFAULT_KLINES - 1;
   mi := TMenuItem(Sender);

   for i  := KD_MIN to KD_YEAR do begin
      if Pos (KLineDateModeStr[i], mi.Caption) = 1 then begin
         SM.CurTDXManager.Get_K_Lines(SM.CurStock.StkCode, SM.CurStock.Market, 0, DEFAULT_KDAYS, i);
      end;
   end;
end;

procedure TRSRStockDemo.N12Click(Sender: TObject);
var stkobj: TStockObject;
begin
   stkobj := SM.CurStock;
   if stkobj = nil then exit;
   stkobj.KLineStart  := stkobj.KLineStart + stkobj.KLineCount;
   stkobj.KLineCount  := stkobj.KLineCount + stkobj.KLineCount;
end;

procedure TRSRStockDemo.N13Click(Sender: TObject);
var stkobj: TStockObject;
begin
   stkobj := SM.CurStock;
   if stkobj = nil then exit;
   stkobj.KLineStart  := stkobj.KLineStart - stkobj.KLineCount div 2 -1;
   stkobj.KLineCount  := stkobj.KLineCount div 2;
end;

end.
