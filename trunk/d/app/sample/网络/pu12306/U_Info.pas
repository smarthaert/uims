unit U_Info;

interface
//Download by http://www.codefans.net

uses
 SysUtils, windows, classes, forms;

Type
    TInfo=class(TObject)
    private
      FUserName:Ansistring;
      FPassword:Ansistring;
      FDate:AnsiString;
      FCHeCHi:ansiString;
      FRenYuan:ansiString;

    public
      workPath:ansiString;    //Application/SRC/*.js
      constructor Create;
      destructor Destroy; override;
      property UserName:Ansistring read FUserName write FUserName;
      property Password:Ansistring read FPassword write FPassword;
      property Date:AnsiString read FDate write FDate;
      property CheChi:ansiString read FCHeCHi write FCHeCHi;
      property RenYuan:ansiString read FRenYuan write FRenYuan;
  end;

    function myTrim(s:ansiString):ansiString;

var
  INFO:TInfo;

implementation

{ TInfo }

constructor TInfo.Create;
begin
  workPath:=extractfilepath(application.ExeName)+'SRC/';
  if not DirectoryExists(workPath) then
     CreateDir(workPath);

  //test
  self.FRenYuan:='1,2';
end;

destructor TInfo.Destroy;
begin
  inherited;
end;

function  myTrim(s: ansiString): ansiString;
var
  t:ansiString;
begin
   t:=s;
   t:=StringReplace(t, '''', ' ', [rfReplaceAll]);
   t:=StringReplace(t, '"', ' ', [rfReplaceAll]);
   t:=StringReplace(t, '<', ' ', [rfReplaceAll]);
   result:=t;
end;



end.
