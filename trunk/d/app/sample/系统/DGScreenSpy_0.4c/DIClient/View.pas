{*******************************************}
{      DGScreenSpy - Client                 }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************}
unit View;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, ComCtrls, IdTCPServer, ZLibEx;

type
  PSpyCmd = ^TSpyCmd;
  TSpyCmd = packed record
    Cmd:  Byte;
    Size: Integer;
  end;

  PCtlCmd = ^TCtlCmd;
  TCtlCmd = packed record
    Cmd:  Byte;
    X, Y: Word;
  end;
  
  TfrmView = class(TForm)
    sbA: TScrollBox;
    pbA: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pbAPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pbAMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pbAMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    FRecBmp, FScrBmp: TBitmap;
    FCCmd: TCtlCmd;
    FRect: TRect;
    FItem: TListItem;
    FSysMenu: HMENU;
    FControl: Boolean;
    //
    procedure SetSize(nWidth, nHeight: Word);
    procedure SendCmd(ACmd: TCtlCmd);
    procedure CheckMenu(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    property Item: TListItem read FItem write FItem;
    procedure ReadData(ss: TMemoryStream; Cmd: Byte);
  end;

const
  BSIZE = 16;
  IDM_SEP   = 200;
  IDM_CTRL  = 201;
  IDM_CTRLS = 'Control';

var
  frmView: TfrmView;

implementation 
{$R *.dfm}

procedure TfrmView.CheckMenu(var Msg: TMessage);
begin
  case Msg.WParam of
    IDM_CTRL:
    begin
      FControl := not FControl;
      if FControl then
        ModifyMenu(FSysMenu, IDM_CTRL, MF_BYCOMMAND or MF_CHECKED, IDM_CTRL, IDM_CTRLS)
      else
        ModifyMenu(FSysMenu, IDM_CTRL, MF_BYCOMMAND or MF_UNCHECKED, IDM_CTRL, IDM_CTRLS);
    end;
    else
      inherited;
  end;
end;

procedure TfrmView.CreateParams(var Params: TCreateParams); 
begin
  inherited;
  Params.WndParent := 0;
end;

procedure TfrmView.FormCreate(Sender: TObject);
begin
  inherited;
  DoubleBuffered := True;
  FSysMenu := GetSystemMenu(Handle, False);
  AppendMenu(FSysMenu, MF_SEPARATOR, IDM_SEP, nil);
  AppendMenu(FSysMenu, MF_STRING,    IDM_CTRL, IDM_CTRLS);
  //
  FControl := False;
  FRecBmp  := TBitmap.Create;
  FScrBmp  := TBitmap.Create;
end;

procedure TfrmView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  try
    if Assigned(FItem) then
    begin
      FItem.SubItems.Objects[0] := nil;
      FItem := nil;
    end;
  except
  end;
  FCCmd.Cmd := 3;
  SendCmd(FCCmd);
  FRecBmp.Free;
  FScrBmp.Free;
  FRecBmp := nil;
  FScrBmp := nil;
  Action  := caFree;
end;

procedure TfrmView.ReadData(ss: TMemoryStream; Cmd: Byte);
begin
  try
    while (ss.Position < ss.Size) do
    begin
      ss.Read(FRect, SizeOf(TRect));
      with FRecBmp do
      begin
        Width  := FRect.Right - FRect.Left;
        Height := FRect.Bottom - FRect.Top;
        LoadFromStream(ss);
      end;
      if (Cmd = 1) then SetSize(FRecBmp.Width * BSIZE, FRecBmp.Height * BSIZE);
      FScrBmp.Canvas.Lock;
      FRecBmp.Canvas.Lock;
      FScrBmp.Canvas.Draw(FRect.Left, FRect.Top, FRecBmp);
      FRecBmp.Canvas.Unlock;
      FScrBmp.Canvas.Unlock;
    end;
  except
  end;
  pbAPaint(nil);
end;

procedure TfrmView.SetSize(nWidth, nHeight: Word);
begin
  if (pbA.Width <> nWidth) or (pbA.Height <> nHeight) then
  begin
    pbA.Left   := 0;
    pbA.Top    := 0;
    pbA.Width  := nWidth;
    pbA.Height := nHeight;
    ClientWidth    := nWidth;
    ClientHeight   := nHeight;
    FScrBmp.Width  := nWidth;
    FScrBmp.Height := nHeight;
  end;
end;

procedure TfrmView.pbAPaint(Sender: TObject);
begin
  try
    pbA.Canvas.Lock;
    FScrBmp.Canvas.Lock;
    BitBlt(pbA.Canvas.Handle,
           sbA.HorzScrollBar.Position,
           sbA.VertScrollBar.Position,
           sbA.Width,
           sbA.Height,
           FScrBmp.Canvas.Handle,
           sbA.HorzScrollBar.Position,
           sbA.VertScrollBar.Position,
           SRCCOPY);
    FScrBmp.Canvas.Unlock;
    pbA.Canvas.Unlock;
  except
  end;
end;

procedure TfrmView.SendCmd(ACmd: TCtlCmd);
begin
  try
    if Assigned(FItem) and TIdPeerThread(FItem.Data).Connection.Connected then
      TIdPeerThread(FItem.Data).Connection.WriteBuffer(ACmd, SizeOf(TCtlCmd));
  except
    Close;
  end;
end;

procedure TfrmView.pbAMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if FControl then
  begin
    FCCmd.Cmd := 11;
    FCCmd.X := X;
    FCCmd.Y := Y;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmView.pbAMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FControl then
  begin
    FCCmd.X := X;
    FCCmd.Y := Y;
    if Button = mbLeft then
      FCCmd.Cmd := 12
    else
      FCCmd.Cmd := 13;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmView.pbAMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FControl then
  begin
    FCCmd.X := X;
    FCCmd.Y := Y;
    if Button = mbLeft then
      FCCmd.Cmd := 14
    else
      FCCmd.Cmd := 15;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if FControl then
  begin
    FCCmd.Cmd := 16;
    FCCmd.X := Key;
    SendCmd(FCCmd);
  end;
end;

procedure TfrmView.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if FControl then
  begin
    FCCmd.Cmd := 17;
    FCCmd.X := Key;
    SendCmd(FCCmd);
  end;
end;

end.
