unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OoMisc, AdPort, StdCtrls, RzEdit,Clipbrd;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ApdComPort1: TApdComPort;
    RzMemo1: TRzMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    procedure ApdComPort1TriggerAvail(CP: TObject; Count: Word);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
//Download by http://www.codefans.net
var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure SimulateNumKey(NumStr: String);
var
   i, nLen : Integer;
   ks : TKeyboardState;
   bCapsLock : Boolean;
   C : char;
begin
   GetKeyboardState(ks);
   bCapsLock := Odd(ks[VK_CAPITAL]);

   nLen := Length(NumStr);
   for i := 1 to nLen  do
   begin
      C := NumStr[i];
      case C of
         '0'..'9':
            begin
               Keybd_Event(VkKeyScan(C), 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
            end;
         'A'..'Z':
            if bCapsLock = false then
               begin
                  Keybd_Event(VK_SHIFT, 0, 0, 0);
                  Keybd_Event(VkKeyScan(C), 0, 0, 0);
                  Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
                  Keybd_Event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0);
               end
            else
               begin
                  Keybd_Event(VkKeyScan(C), 0, 0, 0);
                  Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
               end;
         'a'..'z':
            if bCapsLock = true then
               begin
                  Keybd_Event(VK_SHIFT, 0, 0, 0);
                  Keybd_Event(VkKeyScan(C), 0, 0, 0);
                  Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
                  Keybd_Event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0);
               end
            else
               begin
                  Keybd_Event(VkKeyScan(C), 0, 0, 0);
                  Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
               end;
         '!','@','#','$','%','^','&','*','(',')':
            begin
               Keybd_Event(VK_SHIFT, 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
               Keybd_Event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0);
            end;
         '-', '=', '\', '[', ']', ';', '''', ',', '.', '/':
            begin
               Keybd_Event(VkKeyScan(C), 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
            end;
         '_', '+', '|', '{', '}', ':', '"', '<', '>', '?':
            begin
               Keybd_Event(VK_SHIFT, 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
               Keybd_Event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0);
            end;
      else
         begin
               Keybd_Event(VkKeyScan(C), 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
         end;
      end
   end;
end;

procedure CopySimulateNumKey(NumStr: String);
var
   i, nLen : Integer;
   ks : TKeyboardState;
   bCapsLock : Boolean;
   C : char;
begin
   GetKeyboardState(ks);
   bCapsLock := Odd(ks[VK_CAPITAL]);

   C:='V';
Keybd_Event(VK_CONTROL, 0, 0, 0);
Keybd_Event(VkKeyScan(C), 0, 0, 0);
Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
Keybd_Event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);

//加回车
   C:=#13;
               Keybd_Event(VkKeyScan(C), 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);
{   C:=#10;
               Keybd_Event(VkKeyScan(C), 0, 0, 0);
               Keybd_Event(VkKeyScan(C), 0, KEYEVENTF_KEYUP, 0);}
end;

procedure TForm1.ApdComPort1TriggerAvail(CP: TObject; Count: Word);
var
  I : Word;
  C : Char;
  S : String;
begin
  S := '';
  for I := 1 to Count do begin
    C := ApdComPort1.GetChar;
    case C of
      #0..#31 : {Don't display} ;
      else S := S + C;
    end;
  end;
//  SimulateNumKey(S);
  Clipboard.Clear;
  Clipboard.AsText:=S;
  CopySimulateNumKey(S);
  rzmemo1.Lines.Add(S);
//  ShowMessage('Got an OnTriggerAvail event for: ' + S);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  apdcomport1.Open:=False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Edit1.CopyToClipboard;//將 Edit1 的文字複製到剪貼簿
Clipboard.AsText := Edit1.Text;//同樣將 Edit1 的內容複製到剪貼簿(需要 uses Clipbrd;)
Edit2.PasteFromClipboard;//將剪貼簿內容複製到 Edit2
Clipboard.Clear;//清空剪貼簿(需要 uses Clipbrd;)
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
{  if(apdcomport1.Open=True)then
  begin
    apdcomport1.Open :=False;
    Sleep(5000);
  end;
  apdcomport1.Open :=true;}
end;

end.
