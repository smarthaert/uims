{*******************************************************}
{              EmbeddedWB - Drag And Drop Demo          }
{  by  Eran Bodankin (bsalsa) bsalsa@bsalsa.com         }
{                       Enjoy!                          }
{   UPDATES:                                            }
{               http://www.bsalsa.com                   }
{*******************************************************}

unit frmMain;

interface

uses
   sysUtils, Classes, Controls, Forms, EmbeddedWB, StdCtrls, IEAddress,
   ExtCtrls, Dialogs, ActiveX, OleCtrls, SHDocVw_EWB, Windows, ComObj;

type
   TForm1 = class(TForm)
      Panel1: TPanel;
      Button1: TButton;
      IEAddress1: TIEAddress;
      Panel2: TPanel;
      Memo1: TMemo;
      Panel3: TPanel;
      EmbeddedWB1: TEmbeddedWB;
      Label1: TLabel;
      Label2: TLabel;
    function EmbeddedWB1DragEnter(const dataObj: IDataObject;
      grfKeyState: Integer; pt: TPoint; var dwEffect: Integer;
      Status: string): HRESULT;
      procedure FormDestroy(Sender: TObject);
      function EmbeddedWB1DragOver2(grfKeyState: Integer; pt: TPoint;
         var dwEffect: Integer; Status: string): HRESULT;
      function EmbeddedWB1DropEvent(const dataObj: IDataObject;
         grfKeyState: Integer; pt: TPoint; var dwEffect: Integer;
         Status: string): HRESULT;
      function EmbeddedWB1GetDropTarget(const pDropTarget: IDropTarget;
         out ppDropTarget: IDropTarget): HRESULT;
      function EmbeddedWB1DragLeave: HRESULT;
      procedure FormCreate(Sender: TObject);
      procedure Button1Click(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
   end;

var
   Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
   Memo1.Clear;
   EmbeddedWB1.Go(IEAddress1.Text);
end;

function TForm1.EmbeddedWB1DragEnter(const dataObj: IDataObject;
  grfKeyState: Integer; pt: TPoint; var dwEffect: Integer;
  Status: string): HRESULT;
begin
   Memo1.Lines.Add('============');
   Memo1.Lines.Add('OnDragEnter event - Key Status: ' + IntToStr(grfKeyState));
   Memo1.Lines.Add('OnDragEnter event - Point X: ' + IntToStr(pt.x) + ' Point Y: ' + IntToStr(pt.y));
   Memo1.Lines.Add('OnDragEnter event - Command: ' + IntToStr(dwEffect) + ' - ' + Status);
   Memo1.Lines.Add('============');
   Result := S_OK;
end;

function TForm1.EmbeddedWB1DragLeave: HRESULT;
begin
   Memo1.Lines.Add('OnDragLeave event.');
   Memo1.Lines.Add('============');
   Result := S_OK;
end;

function TForm1.EmbeddedWB1DragOver2(grfKeyState: Integer; pt: TPoint;
   var dwEffect: Integer; Status: string): HRESULT;
begin
   Memo1.Lines.Add('OnDragOver2 event - Key State: ' + IntToStr(grfKeyState));
   Memo1.Lines.Add('OnDragOver2 event - Point X: ' + IntToStr(pt.x) + ' Point Y: ' + IntToStr(pt.y));
   Memo1.Lines.Add('OnDragOver2 event - Command: ' + IntToStr(dwEffect) + ' - ' + Status);
   Memo1.Lines.Add('============');
   Result := S_OK;
end;

function TForm1.EmbeddedWB1DropEvent(const dataObj: IDataObject;
   grfKeyState: Integer; pt: TPoint; var dwEffect: Integer;
   Status: string): HRESULT;
begin
   Memo1.Lines.Add('OnDrop event - Key State: ' + IntToStr(grfKeyState));
   Memo1.Lines.Add('OnDrop event - Point X: ' + IntToStr(pt.x) + ' Point Y: ' + IntToStr(pt.y));
   Memo1.Lines.Add('OnDrop event - Command: ' + IntToStr(dwEffect) + ' - ' + Status);
   Memo1.Lines.Add('============');
   Result := S_OK;
end;

function TForm1.EmbeddedWB1GetDropTarget(const pDropTarget: IDropTarget;
   out ppDropTarget: IDropTarget): HRESULT;
begin
   Memo1.Lines.Add('OnGetDropTarget event.');
   Memo1.Lines.Add('============');
   Result := S_OK;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   OleCheck(RegisterDragDrop(Handle, EmbeddedWB1));
// To disable Drag and drop, remove the OleCheck
// and use the boolean property EnableDragAndDrop after removing the OleCheck
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   RevokeDragDrop(EmbeddedWB1.Handle);
end;

initialization
   OleInitialize(nil);
finalization
   try
      OleUninitialize;
   except
   end;
end.

