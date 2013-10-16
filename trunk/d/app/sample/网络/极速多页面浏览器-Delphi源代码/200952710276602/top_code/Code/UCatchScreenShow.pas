unit UCatchScreenShow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Clipbrd, JPEG;

type
  TCatchScreenShowForm = class(TForm)
    ChildImage: TImage;
    ChildTimer: TTimer;
    SaveDialog1: TSaveDialog;
    procedure ChildTimerTimer(Sender: TObject);
    procedure ChildImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ChildImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CatchScreenShowForm: TCatchScreenShowForm;
  foldx,x1,y1,x2,y2,oldx,oldy,foldy : Integer;
  Flag,Trace : Boolean;
implementation

uses UnitMain, var_;

{$R *.DFM}

procedure BMPToJPG(BmpFileName:string);
var
  Jpeg : TJPEGImage;
  Bmp : TBitmap;
begin
try
  if not FileExists(BmpFileName) then exit;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromFile(BmpFileName);
    Jpeg := TJPEGImage.Create;
    try
      Jpeg.Assign(Bmp);
      Jpeg.Compress;
      Jpeg.SaveToFile(ChangeFileExt(BmpFileName,'.jpg'));
    finally
      Jpeg.Free;
    end;
  finally
     Bmp.Free;
  end;
except end;
end;

procedure TCatchScreenShowForm.ChildTimerTimer(Sender: TObject);
var
  Fullscreen:Tbitmap;
  FullscreenCanvas:TCanvas;
  DC:HDC;
begin
  ChildTimer.Enabled := False;
  Fullscreen := TBitmap.Create;
  Fullscreen.Width := Screen.width;
  Fullscreen.Height := Screen.Height;
  DC:=GetDC(0);
  FullscreenCanvas := TCanvas.Create;
  FullscreenCanvas.Handle := DC;
  Fullscreen.Canvas.CopyRect(Rect(0,0,Screen.Width,Screen.Height),FullscreenCanvas,
  Rect(0,0,Screen.Width,Screen.Height));
  FullscreenCanvas.Free;
  ReleaseDC(0,DC);
  ChildImage.picture.Bitmap:=fullscreen;
  ChildImage.Width := Fullscreen.Width;
  ChildImage.Height:=Fullscreen.Height;
  Fullscreen.free;
  CatchScreenShowForm.WindowState := wsMaximized;
  CatchScreenShowForm.show;
  messagebeep(1);
  foldx:=-1;
  foldy:=-1;
  ChildImage.Canvas.Pen.mode := Pmnot; //笔的模式为取反
  ChildImage.Canvas.pen.color := clblack; //笔为黑色
  ChildImage.Canvas.brush.Style := bsclear;//空白刷子
  Flag := True;
end;


procedure TCatchScreenShowForm.ChildImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if trace=true then//是否在追踪鼠标？
  begin//是，擦除旧的矩形并画上新的矩形
    with ChildImage.canvas do
    begin
        rectangle(x1,y1,oldx,oldy);
        Rectangle(x1,y1,x,y);
        oldx:=x;
        oldy:=y;
    end;
  end
  else if flag=true then//在鼠标所在的位置上画十字
  begin
    with ChildImage.canvas do
        begin
          MoveTo(foldx,0);//擦除旧的十字
          LineTo(foldx,Screen.Height);
          MoveTo(0,foldy);
          LineTo(Screen.Width,foldy);
          MoveTo(x,0);//画上新的十字
          LineTo(x,Screen.Height);
          MoveTo(0,y);
          LineTo(Screen.Width,y);
          foldx:=x;
          foldy:=y;
        end;
  end;
end;

procedure TCatchScreenShowForm.ChildImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Width,Height : Integer;
  NewBitmap : TBitmap;
  Clipboard: TClipboard;
begin
try
  if (Trace = False) then//TRACE表示是否在追踪鼠标
  begin//首次点击鼠标左键，开始追踪鼠标。
    Flag := False;
    with ChildImage.canvas do
    begin
      MoveTo(foldx,0);
      LineTo(foldx,screen.height);
      MoveTo(0,foldy);
      LineTo(screen.width,foldy);
    end;
    x1 := x;
    y1 := y;
    oldx := x;
    oldy := y;
    Trace := True;
    ChildImage.Canvas.Pen.mode:=pmnot;//笔的模式为取反
    //这样再在原处画一遍矩形，相当于擦除矩形。
    ChildImage.canvas.pen.color := clblack;//笔为黑色
    ChildImage.canvas.brush.Style := bsclear;//空白刷子
  end
  else
  begin//第二次点击，表示已经得到矩形了，把它拷贝到FORM1中的IMAGE部件上。
    //{
    x2 := x;
    y2 := y;
    Trace := False;
    ChildImage.Canvas.Rectangle(x1,y1,oldx,oldy);
    Width := abs(x2-x1);
    Height := abs(y2-y1);
    FormMain.ShowImage.Width := Width;
    FormMain.ShowImage.Height := Height;

    NewBitmap:=Tbitmap.create;
    NewBitmap.Width := Width;
    NewBitmap.Height := Height;
    NewBitmap.Canvas.CopyRect
    (Rect(0,0,width,Height),CatchScreenShowForm.ChildImage.Canvas,
    Rect(x1,y1,x2,y2));//拷贝
    FormMain.ShowImage.Picture.Bitmap := NewBitmap;//放到CatchScreenForm的ShowImage上
    try
    CatchScreenShowForm.Hide;
    //NewBitmap.Free;
    //CatchScreenForm.Show;
    //}
    //FormMain.Show;
    //finally
      if GetScreenSave then
      begin
        if SaveDialog1.Execute then
        begin
          if Trim(SaveDialog1.FileName) <> '' then
          begin
            if FileExists(SaveDialog1.FileName) then
            if MessageBox(Handle, PChar('文件:<' + ExtractFileName(SaveDialog1.FileName) + '>已经存在,确认要覆盖此文件吗?'),'询问',MB_YESNO+MB_ICONINFORMATION)=ID_No then exit;
            if (ExtractFileExt(SaveDialog1.FileName) = '') then SaveDialog1.FileName := SaveDialog1.FileName + '.bmp';
            FormMain.ShowImage.Picture.SaveToFile(SaveDialog1.FileName);
            if (LowerCase(ExtractFileExt(SaveDialog1.FileName)) = '.jpg') then
            BMPToJPG(SaveDialog1.FileName);
          end;
        end;
          try
          finally
            Clipboard := TClipboard.Create;
            Clipboard.Assign(FormMain.ShowImage.Picture.Bitmap);
            Clipboard.Free;
          end;
      end
      else
      begin
        Clipboard := TClipboard.Create;
        Clipboard.Assign(FormMain.ShowImage.Picture.Bitmap);
        Clipboard.Free;
      end;
    finally
      NewBitmap.Free;
    end;
  end;
except end;
end;

procedure TCatchScreenShowForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
