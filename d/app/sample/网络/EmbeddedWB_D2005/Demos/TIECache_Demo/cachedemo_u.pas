//***********************************************************
//               IECache Demo ver 1.01 (2006)      *
//                                                          *
//                       For Delphi 4/5/6                     *
//                     Freeware Component                   *
//                            by                            *
//                     Per Lindsø Larsen                    *
//                   per.lindsoe@larsen.mail.dk                  *
//                                                          *
//  Documentation and updated versions:                     *
//                                                          *
//               http://www.euromind.com/iedelphi           *
//***********************************************************

unit cachedemo_u;

interface

uses
  wininet, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IECache, StdCtrls, ExtCtrls, OleCtrls, SHDocVw_EWB, EmbeddedWB;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    RadioGroup1: TRadioGroup;
    Button2: TButton;
    Button1: TButton;
    IECache1: TIECache;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button3: TButton;
    OpenDlg: TOpenDialog;
    CheckBox1: TCheckBox;
    DeleteEntryBtn: TButton;
    WebBrowser1: TEmbeddedWB;
    procedure IECache1Entry(Sender: TObject; var Cancel: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DeleteEntryBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.IECache1Entry(Sender: TObject; var Cancel: Boolean);
begin
  listbox1.Items.add(IECache1.EntryInfo.SourceUrlName);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  x: Olevariant;
begin
  IECache1.SearchPattern := spAll;
  IECache1.RetrieveEntries(0);
  Webbrowser1.Navigate('about:blank', x, x, x, x);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  IECache1.SearchPattern := spAll;
//e.g.: set SearchPattern:=spCookies if you only want to delete cookies
  IECache1.ClearAllEntries;
  Listbox1.Items.Clear;
  IECache1.SearchPattern := spAll;
  IECache1.RetrieveEntries(0);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  Listbox1.Items.Clear;
  with IECache1 do
  begin
    case RadioGroup1.ItemIndex of
      0: SearchPattern := spAll;
      1: SearchPattern := spCookies;
      2: SearchPattern := spHistory;
      3: SearchPattern := spUrl;
    end;
    RetrieveEntries(0);
  end;
end;

function DTString(DT: TDatetime): string;
begin
  if DT < 0 then Result := '' else
    Result := DateTimeToStr(DT);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
  x: Olevariant;
begin
  while webbrowser1.busy do application.processmessages;
If Listbox1.Items.Count>0 then
  IECache1.GetEntryInfo(Listbox1.Items[Listbox1.Itemindex]);
  with IECache1.EntryInfo do
  begin
    if ((pos('.htm', Localfilename) > 0) or (pos('.gif', Localfilename) > 0) or (pos('.jpg', Localfilename) > 0))
      and Checkbox1.checked then Webbrowser1.Navigate(LocalFileName, x, x, x, x);
    Label1.Caption := 'Hitrate: ' + InttoStr(HitRate);
    Label2.Caption := 'FileSize: ' + InttoStr(FSize);
    Label3.Caption := 'Last access: ' + DTString(LastAccessTime);
    Label4.Caption := 'Last modified: ' + DTString(LastModifiedTime);
    Label5.Caption := 'Expire: ' + DTString(ExpireTime);
    Label6.Caption := LocalFileName;
  end;

  end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Listbox1.setfocus;
  listbox1.itemindex := 1;
  Listbox1Click(Sender);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  with OpenDlg do
  begin
    filter := 'Internet files|*.htm;*.html;*.gif;*.jpg';
    if Execute then
      if IECache1.CopyFileToCache(
        'file:///' + FileName,
        FileName,
        NORMAL_CACHE_ENTRY,
        StrtoDateTime('01-01-02 00:00:00')) = S_OK
        then
      begin
        Radiogroup1.ItemIndex := 0;
        Radiogroup1Click(Sender);
        listbox1.ItemIndex := Listbox1.Items.IndexOf('file:///' + FileName);
      end;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var
  x: Olevariant;
begin
  if not Checkbox1.checked then Webbrowser1.Navigate('about:blank', x, x, x, x);
  listbox1.setfocus;
end;

procedure TForm1.DeleteEntryBtnClick(Sender: TObject);
var
  x: Olevariant;
begin
  Webbrowser1.Navigate('about:blank', x, x, x, x);
  IECache1.DeleteEntry(Listbox1.Items[Listbox1.Itemindex]);
  RadioGroup1Click(Sender);
  Listbox1.setfocus;
end;

end.

