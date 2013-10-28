unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ImgList, ToolWin, ExtCtrls, cRollup;

type
  TFrmMain = class(TForm)
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton2: TToolButton;
    Rollup1: TRollup;
    procedure ToolButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButton4Click(Sender: TObject);
    procedure BUFormButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Query, Environment, GlbVar, ClassJX;

{$R Tax.RES}
{$R *.DFM}

procedure TFrmMain.ToolButton2Click(Sender: TObject);
var
  I: Integer;
begin
  if FrmMain.MDIChildCount > 0 then
    for I := FrmMain.MDIChildCount - 1 downto 0 do
      FrmMain.MDIChildren[I].Close;
  Close;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels[3].Text := FormatDateTime('YYYY-MM-DD HH:MM:SS AM/PM', Now);
end;

procedure TFrmMain.ToolButton1Click(Sender: TObject);
var
  ChildIndex: Integer;
begin
  {FrmMain是主窗体；FrmQuery是子窗体}
  if FrmMain.MDIChildCount = 0 then
  begin
    ChildIndex := 0;
    while (ChildIndex < FrmMain.MDIChildCount) and (FrmMain.MDIChildren[ChildIndex].Name <> FrmQuery.Name) do
      Inc(ChildIndex);
    if ChildIndex = FrmMain.MDIChildCount then
    {create new child here}
    begin
      Application.CreateForm(TFrmQuery, FrmQuery);
      FrmQuery.Show;
    end
    else
    {child form already exists so just bring it to the top}
      FrmMain.MDIChildren[ChildIndex].BringToFront;
  end;
end;

procedure TFrmMain.ToolButton3Click(Sender: TObject);
begin
  try
    FrmEnvironment := TFrmEnvironment.Create(Application);
    FrmEnvironment.ShowModal;
  finally
    FrmEnvironment.Free;
    FrmEnvironment := nil;
  end;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  I: Integer;
begin
  if Application.MessageBox('真的退出程序吗？', '提示框', MB_ICONINFORMATION + MB_OKCANCEL) = ID_OK then
  begin
    if FrmMain.MDIChildCount > 0 then
    begin
      for I := FrmMain.MDIChildCount - 1 downto 0 do
        FrmMain.MDIChildren[I].Close;
      CanClose := True;
    end
    else
      CanClose := True;
  end
  else
    CanClose := False;
end;

procedure TFrmMain.ToolButton4Click(Sender: TObject);
begin
  Rollup1.isRolledUp := True;
end;

procedure TFrmMain.BUFormButton1Click(Sender: TObject);
begin
  Rollup1.isRolledUp := not Rollup1.isRolledUp;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  FindBmp: TBitmap;
  ToolBmp: TBitmap;
  ExitBmp: TBitMap;
begin
  CurrEnvironment := TEnvironment.Create;
  FindBmp := TBitmap.Create;
  FindBmp.Handle := LoadBitmap(HInstance, 'FIND');
  ToolBmp := TBitmap.Create;
  ToolBmp.Handle := LoadBitmap(HInstance, 'TOOL');
  ExitBmp := TBitMap.Create;
  ExitBmp.Handle := LoadBitmap(HInstance, 'EXIT');
  ImageList1.Clear;
  ImageList1.Add(FindBmp,nil);
  ToolButton1.ImageIndex:=0;
  ImageList1.Add(ToolBmp,nil);
  ToolButton2.ImageIndex:=2;
  ImageList1.Add(ExitBmp,nil);
  ToolButton3.ImageIndex:=1;
end;

end.

