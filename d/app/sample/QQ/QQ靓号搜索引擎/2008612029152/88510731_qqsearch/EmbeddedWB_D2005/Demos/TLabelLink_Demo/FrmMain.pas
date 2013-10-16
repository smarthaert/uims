unit FrmMain;

interface

uses
   Classes, Controls, Forms, Dialogs, StdCtrls, LinkLabel, ImgList;

type
  TForm2 = class(TForm)
    LinkLabel1: TLinkLabel;
    LinkLabel2: TLinkLabel;
    LinkLabel3: TLinkLabel;
    LinkLabel4: TLinkLabel;
    ImageList1: TImageList;
    LinkLabel5: TLinkLabel;
    procedure LinkLabel1Launch(var Successs: Boolean; const ErrorText: string;
      var Result: Cardinal);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.LinkLabel1Launch(var Successs: Boolean;
  const ErrorText: string; var Result: Cardinal);
begin
   if not Successs then Showmessage(ErrorText);
end;


end.
