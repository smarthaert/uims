unit marquee;

{
  TMarquee - written by Bill Wehnert (c) 1997 all rights reserved

  version 1.01   - Included the xprocs unit that I missed in first release
  version 1.00   - initial release

  This product and it's source are donated freely into the public domain.
  You may use this component as you see fit.

  You can distribute this unit (along with all of the other included files)
  to any and all takers.  You may NOT however charge for it, other than a
  distribution fee for the media it is distributed on.

  If you find this component usefull, please drop me a line at:
     wehnertb@bigfoot.com

  If you don't find this component usefull, or would like to see enhancements
  please write to the above address as well.


  Enjoy.


  Bill Wehnert
}

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, Menus;

const
   STX = chr(2);
   ETX = chr(3);

   BLKSEP = '|';
   CLRSEP = '%';

type
   TDirection = (tdLeft, tdRight, tdNone);
   TSpeed = (tsSlow, tsMedium, tsFast);

   TExitRequest = procedure (Sender: TObject) of Object;

   TMarquee = class(TCustomPanel)
   private
      { Private declarations }
      FActive: Boolean;
      FText: String;
      FDirection: TDirection;
      FSpeed: TSpeed;
      FTimer: TTimer;

      FOffString: Integer;                   // String Start Position
      FOffDisplay: Integer;                        // Display Start Position
      FMemoryImage: TBitMap;
      FItems: TStringList;
      FPM: TPopupMenu;
      FOnExitRequest: TExitRequest;

      SpeedMenu: TMenuItem;
      Slow: TMenuItem;
      Medium: TMenuItem;
      Fast: TMenuItem;
      DirMenu: TMenuItem;
      LeftMenu: TMenuItem;
      Right: TMenuItem;
      N: TMenuItem;
      ExitMenu: TMenuItem;
      Bmp: TImage;
      procedure WMSize(var Msg: TMessage); message WM_SIZE;
   protected
      { Protected declarations }
      procedure TimerFired(Sender: TObject);
      procedure SetActive(AActive: Boolean);
      procedure SetText(AText: String);
      procedure SetSpeed(ASpeed: TSpeed);
      procedure ClearRect(bFill: Boolean; var Rect: TRect);
   public
      { Public declarations }
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure BuildMenu;
      procedure KillMenu;

      procedure SlowClick(Sender: TObject);
      procedure MediumClick(Sender: TObject);
      procedure FastClick(Sender: TObject);
      procedure LeftClick(Sender: TObject);
      procedure RightClick(Sender: TObject);
      procedure ExitClick(Sender: TObject);

   published
      { Published declarations }
      property Active: Boolean read FActive write SetActive default False;
      property Align;
      property BevelInner;
      property BevelOuter;
      property BevelWidth;
      property BorderWidth;
      property BorderStyle;
      property Color;
      property Direction: TDirection read FDirection write FDirection default tdLeft;
      property Font;
      property Speed: TSpeed read FSpeed write SetSpeed default tsSlow;
      property Text: String read FText write SetText;

      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnExitRequest: TExitRequest read FOnExitRequest write FOnExitRequest;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDrag;
   end;

procedure Register;
function  GetColor(I: Integer): TColor;


implementation

uses xProcs;

procedure Register;
begin
   RegisterComponents('Marquee', [TMarquee]);
end;

procedure AdjustRect(var Rect: TRect; Adj: Integer);
begin
   Dec(Rect.Bottom, Adj);
   Dec(Rect.Right, Adj);
   Inc(Rect.Top, Adj);
   Inc(Rect.Left, Adj);
end;


constructor TMarquee.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FActive := False;
   Caption := '';
   FText   := '';
   FDirection := tdLeft;
   FSpeed := tsSlow;
   FTimer := TTimer.Create(Self);
   FItems := TStringList.Create;
   FMemoryImage := TBitMap.Create;
   Color  := clBlack;
   with FTimer do begin
      Enabled := False;
      OnTimer := TimerFired;
      Interval := 100;
   end;

   FOffString  := 1;
   FOffDisplay := 0;

   Bmp := TImage.Create(Self);
   Bmp.Visible := False;
   Bmp.Top := 0;
   Bmp.Left := 0;

   BuildMenu;
end;

destructor TMarquee.Destroy;
begin
   SetActive(False);
   FTimer.Enabled := False;
   FTimer.OnTimer := nil;
   FTimer.Free;
   FItems.Free;
   FMemoryImage.Free;
   KillMenu;
   FPM.Free;
   Bmp.Free;
   inherited Destroy;
end;


procedure TMarquee.BuildMenu;
begin
   FPM                     := TPopupMenu.Create(Self);
   SpeedMenu            :=  TMenuItem.Create(Self);
   Slow                    :=  TMenuItem.Create(Self);
   Medium                  :=  TMenuItem.Create(Self);
   Fast                    :=  TMenuItem.Create(Self);
   DirMenu              :=  TMenuItem.Create(Self);
   LeftMenu                :=  TMenuItem.Create(Self);
   Right                   :=  TMenuItem.Create(Self);
   N                       :=  TMenuItem.Create(Self);
   ExitMenu                :=  TMenuItem.Create(Self);

   SpeedMenu.Caption := 'S&peed';
   Slow.Caption         := '&Slow';
   Medium.Caption       := '&Medium';
   Fast.Caption         := '&Fast';

   DirMenu.Caption   := '&Direction';
   LeftMenu.Caption  := '&Left';
   Right.Caption     := '&Right';

   N.Caption            := '-';
   ExitMenu.Caption  := 'E&xit';

   Slow.OnClick         := SlowClick;
   Slow.Checked         := True;
   Medium.OnClick    := MediumClick;
   Fast.OnClick         := FastClick;

   LeftMenu.OnClick  := LeftClick;
   Right.OnClick        := RightClick;

   ExitMenu.OnClick  := ExitClick;

   FPM.Items.Add(SpeedMenu);
   FPM.Items[0].Add(Slow);
   FPM.Items[0].Add(Medium);
   FPM.Items[0].Add(Fast);

   FPM.Items.Add(DirMenu);
   FPM.Items[1].Add(LeftMenu);
   FPM.Items[1].Add(Right);

   FPM.Items.Add(N);
   FPM.Items.Add(ExitMenu);

   PopupMenu := FPM;

end;

procedure TMarquee.KillMenu;
begin
   FPM.Items[3].Free;                     // Exit
   FPM.Items[2].Free;                     // Spacer
   FPM.Items[1].Items[1].Free;         // Direction.Right
   FPM.Items[1].Items[0].Free;         // Direction.Left
   FPM.Items[1].Free;                     // Direction
   FPM.Items[0].Items[2].Free;         // Speed.Fast
   FPM.Items[0].Items[1].Free;         // Speed.Medium
   FPM.Items[0].Items[0].Free;         // Speed.Slow
   FPM.Items[0].Free;                     // Speed
end;

procedure TMarquee.SetSpeed(ASpeed: TSpeed);
begin
   if FActive then
      FTimer.Enabled := False;
   if ASpeed <> FSpeed then
   begin
      case ASpeed of
         tsSlow: begin
            FTimer.Interval := 100;
            Slow.Checked    := True;
            Medium.Checked  := False;
            Fast.Checked      := False;
          end;

         tsMedium: begin
            FTimer.Interval := 60;
            Slow.Checked    := False;
            Medium.Checked  := True;
            Fast.Checked      := False;
          end;

         tsFast: begin
            FTimer.Interval := 30;
            Slow.Checked    := False;
            Medium.Checked  := False;
            Fast.Checked      := True;
          end;
      end;
      FSpeed := ASpeed;
   end;
   if FActive then
      FTimer.Enabled := True;
end;


procedure TMarquee.TimerFired(Sender: TObject);
var MinLeft, MaxRight: Integer;
      TmpVar, I, TmpOff: Integer;
      TmpRect, Rect: TRect;
      //Bmp: TBitMap;
begin
   ClearRect(False, Rect);

   Bmp.Height := Rect.Bottom - Rect.Top;
   Bmp.Width  := Rect.Right - Rect.Left;
   Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
   Bmp.Canvas.Font.Assign(Canvas.Font);

   MinLeft  := Rect.Left;
   MaxRight := Rect.Right;

   case FDirection of
      tdNone:
         begin
            for i:=0 to Pred(FItems.Count) do
            begin
               Canvas.Font.Color := TColor(FItems.Objects[i]);
               Canvas.TextOut(0, 0, FItems.Strings[i]);
            end;
         end;
      tdLeft:
         begin
            if FOffDisplay = 0 then
               TmpVar := Width
            else
               TmpVar := Width - FOffDisplay;
            BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
            TmpRect := Classes.Rect(Bmp.Left, Bmp.Top, Bmp.Left + bmp.Width, Bmp.Top + Bmp.Height);
            Bmp.Canvas.FillRect(TmpRect);
            for i := 0 to Pred(FItems.Count) do
            begin
               TmpOff := Bmp.Canvas.TextWidth(FItems.Strings[i]);
               Bmp.Canvas.Font.Color := TColor(FItems.Objects[i]);
               Bmp.Canvas.TextOut(TmpVar, 0, FItems.Strings[i]);
               BitBlt(Canvas.Handle, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
               Inc(TmpVar, TmpOff + 5);
            end;
            Inc(FOffDisplay, 5);
            if FOffDisplay >= (Width + Canvas.TextWidth(FText)) then
               FOffDisplay := 0;
            Application.ProcessMessages;
         end;
      tdRight:
         begin
            TmpVar := FOffDisplay + 3;
            BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
            TmpRect := Classes.Rect(Bmp.Left, Bmp.Top, Bmp.Left + bmp.Width, Bmp.Top + Bmp.Height);
            Bmp.Canvas.FillRect(TmpRect);
            for i := 0 to Pred(FItems.Count) do
            begin
               TmpOff := Bmp.Canvas.TextWidth(FItems.Strings[i]);
               Bmp.Canvas.Font.Color := TColor(FItems.Objects[i]);
               Bmp.Canvas.TextOut(TmpVar, 0, FItems.Strings[i]);
               BitBlt(Canvas.Handle, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
               Inc(TmpVar, TmpOff + 5);
            end;
            Inc(FOffDisplay, 5);
            if FOffDisplay >= MaxRight then
               FOffDisplay := (MinLeft - Canvas.TextWidth(FText));      // This puts us "N" chars to the left of the beginning
         end;
   end;
end;


procedure TMarquee.SetActive(AActive: Boolean);
begin
   if FActive <> AActive then
   begin
      FTimer.Enabled := AActive;
      FActive := AActive;
   end;
end;


function GetColor(I: Integer): TColor;
begin
   case I of
      1: Result := clLime;
      2: Result := clYellow;
      3: Result := clRed;
      else Result := I;
   end;
end;

procedure TMarquee.ClearRect(bFill: Boolean; var Rect: TRect);
begin
   Rect := GetClientRect;
   AdjustRect(Rect, BorderWidth);
   if BevelOuter <> bvNone then
      AdjustRect(Rect, BevelWidth);
   if BevelInner <> bvNone then
      AdjustRect(Rect, BevelWidth);

   AdjustRect(Rect, 4);

   Canvas.Brush.Color := Color;
   Canvas.Brush.Style := bsSolid;
   if bFill then
      Canvas.FillRect(Rect);
end;

procedure TMarquee.SetText(AText: String);
var tsList: TStringList;
      i: Integer;
      nClr: TColor;
      Item: String;
      Rect: TRect;
begin

   if FActive then
      FTimer.Enabled := False;

   FItems.Clear;
   FText := AText;

   ClearRect(True, Rect);

   tsList := TStringList.Create;
   try
      if Pos(BLKSEP, AText) = 0 then
         tsList.Add(AText)
      else
         strTokenToStrings(AText, BLKSEP, tsList);
      for i:=0 to Pred(tsList.Count) do
      begin
         if strTokenCount(tsList.Strings[i], CLRSEP) = 2 then
          begin
            nClr := GetColor(StrToInt(strTokenAt(tsList.Strings[i], CLRSEP, 0)));
            Item := strTokenAt(tsList.Strings[i], CLRSEP, 1);
            FItems.AddObject(Item, TObject(nClr));
          end
         else
            FItems.AddObject(tsList.Strings[i], TObject(GetColor(1)));
      end;
   finally
      tsList.Free;
   end;

   if FActive then
      FTimer.Enabled := True;
end;




procedure TMarquee.SlowClick(Sender: TObject);
begin
   Speed := tsSlow;
end;

procedure TMarquee.MediumClick(Sender: TObject);
begin
   Speed := tsMedium;
end;

procedure TMarquee.FastClick(Sender: TObject);
begin
   Speed := tsFast;
end;

procedure TMarquee.LeftClick(Sender: TObject);
begin
   Direction := tdLeft;
   LeftMenu.Checked := True;
   Right.Checked := False;
end;

procedure TMarquee.RightClick(Sender: TObject);
begin
   Direction := tdRight;
   Right.Checked := True;
   LeftMenu.Checked := False;
end;

procedure TMarquee.ExitClick(Sender: TObject);
begin
   if Assigned(FOnExitRequest) then
      FOnExitRequest(Sender);
end;

procedure TMarquee.WMSize(var Msg: TMessage);
begin
   FOffDisplay := 0;
   Bmp.Free;
   Bmp := TImage.Create(Self);
end;
end.
