unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, SUIForm, SUIButton, SUIEdit, StdCtrls, SUIMemo, SUIListBox;

type
  TForm2 = class(TForm)
    suiForm1: TsuiForm;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TsuiEdit;
    Edit2: TsuiEdit;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    Listkc: TsuiListBox;
    suiButton3: TsuiButton;
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.suiButton1Click(Sender: TObject);
var
  filevar:textfile;
  buf:string;
begin
listkc.Items.Append(edit1.text+':'+edit2.text);
 assignfile(filevar,'info.ds');
 buf:=edit1.text+':'+edit2.text;
 append(filevar);
 writeln(filevar,buf);
 closefile(filevar);
end;

procedure TForm2.suiButton3Click(Sender: TObject);
begin
 close;
end;

procedure TForm2.suiButton2Click(Sender: TObject);
begin
listkc.Items.Delete(listkc.ItemIndex);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ss:tstringlist;
  i:integer;
begin
  //Ìí¼Ó¼ÇÂ¼
  ss:=tstringlist.Create ;
  for i:=0 to listkc.items.count-1 do begin
    ss.Add(listkc.items.strings[i]);
  end;
  ss.savetoFile('info.ds');
  ss.Free;

end;

procedure TForm2.FormShow(Sender: TObject);
var
  ss:tstringlist;
  i:integer;
begin
 listkc.Clear;
 ss:=tstringlist.Create ;
 ss.LoadFromFile('info.ds');
 for i:=0 to ss.Count-1 do
   listkc.Items.Add(ss.Strings[i]);
 ss.free;

end;

end.
