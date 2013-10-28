unit Unit1;
//download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,wininet,
  StdCtrls, ComCtrls, Buttons;
type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    ListView1: TListView;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Stop:boolean;
    Procedure AddInfo(  lpEntryInfo: PInternetCacheEntryInfo;id:integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord ;
  dwEntrySize, dwLastError: LongWord;
  id:integer;
begin
   Stop:=false;
   id:=0;
   ListView1.items.clear;

   dwEntrySize := 0;
   FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);

   GetMem(lpEntryInfo, dwEntrySize);

   hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
   if hCacheDir <> 0 then
      AddInfo(lpEntryInfo,id);
   id:=id+1;
   FreeMem(lpEntryInfo);

   repeat
     dwEntrySize := 0;
     FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
     dwLastError := GetLastError();
     if dwLastError = ERROR_INSUFFICIENT_BUFFER then
     begin
         GetMem(lpEntryInfo, dwEntrySize);
         if FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize) then
         begin
            AddInfo(lpEntryInfo,id);
            id:=id+1;
         end;
         FreeMem(lpEntryInfo);
     end;
     application.ProcessMessages;
   until (dwLastError = ERROR_NO_MORE_ITEMS) or Stop ;
end;

procedure TForm1.AddInfo(lpEntryInfo: PInternetCacheEntryInfo;id:integer);
begin
  with ListView1.items do
  begin
    Try
      BeginUpdate;
      with Add do
      begin
        Caption:=IntTostr(id);
        subitems.add(lpEntryInfo^.lpszSourceUrlName);
        Subitems.add(lpEntryInfo^.lpszLocalFileName);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
  I:integer;
begin
  if not Stop then exit;
  for i:=ListView1.Items.Count-1 downto 0 do
     DeleteUrlCacheEntry(Pchar(ListView1.Items[i].SubItems[0]));
  ListView1.items.clear;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Stop:=false;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Stop:=true;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
  I:integer;
begin
  if not Stop then exit;
  for i:=ListView1.Items.Count-1 downto 0 do
     if Listview1.Items[i].Selected then
     begin
        DeleteUrlCacheEntry(Pchar(ListView1.Items[i].SubItems[0]));
        ListView1.Items.Delete(i);
     end;
end;

end.
