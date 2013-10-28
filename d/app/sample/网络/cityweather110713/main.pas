unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxpngimage, ExtCtrls, StdCtrls, IdHTTP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function CityToID(ACityName: string = ''): string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Weather;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  //ShowFrmWeatherModal('101180101');
  ShowFrmWeather(CityToID(ComboBox1.Text));
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  ShowFrmWeather(CityToID());
end;

function TForm1.CityToID(ACityName: string = ''): string; //101010100
var
  CityLst: TStrings;
  IdHtp: TIdHTTP;
  temp: WideString;
  I: Integer;
  Str, CityName: WideString;
begin
  IdHtp := TIdHTTP.Create(Self);
  CityLst := TStringList.Create;
  try
    if ACityName = EmptyStr then
    begin
      try
        temp := IdHtp.Get('http://www.ip138.com/ips8.asp'); //http://www.ip138.com/ips8.asp   http://www.ipseeker.cn
      except
      end;
      if temp <> EmptyStr then
      begin
        I := Pos('来自：', temp);
        Str := Copy(temp, I, 254);

        I := Pos('省', Str);
        Str := Copy(Str, Pos('省', Str) + 1, MaxInt);

        I := Pos('市', Str);
        CityName := Copy(Str, 1, I - 1);
        if CityName = EmptyStr then
          CityName := '北京';
      end;
    end
    else
      CityName := ACityName;

    CityLst.LoadFromFile('CityCode.Data');
    Result := CityLst.Values[CityName];

    if Result = EmptyStr then
      Result := '101010100';
  finally
    CityLst.Free;
    IdHtp.Free;
  end;
end;
//Download by http://www.codefans.net
procedure TForm1.FormCreate(Sender: TObject);
begin
  ComboBox1.Items.LoadFromFile('City.Data');
  ComboBox1.ItemIndex := 0; 
end;

end.

