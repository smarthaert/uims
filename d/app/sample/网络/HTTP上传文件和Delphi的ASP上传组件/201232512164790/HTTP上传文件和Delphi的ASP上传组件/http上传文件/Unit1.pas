unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, IdIntercept, IdLogBase, IdLogDebug, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    HTTP: TIdHTTP;
    memoHTML: TMemo;
    LogDebug: TIdLogDebug;
    Memo1: TMemo;
    cbURL: TComboBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure SendPostData(filename:string);
    procedure LogDebugLogItem(ASender: TComponent; var AText: String);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.SendPostData(filename:string);
  Const
  CRLF = #13#10;
  var
     Source: TMemoryStream;
     Source1: TMemoryStream;
     Response: TStringStream;
     S,s1: String;
begin
  Screen.Cursor := crHourGlass;
  try
    memoHTML.Clear;
    HTTP.Request.Username := '';
    HTTP.Request.Password := '';
    HTTP.Request.ProxyServer := '';
    HTTP.Request.ProxyPort := 80;
    HTTP.Request.ContentType := 'multipart/form-data';
    HTTP.Intercept := LogDebug;
    HTTP.InterceptEnabled := true;

    Response := TStringStream.Create('');
       try

          S := '-----------------------------7cf1d6c47c' + CRLF +
               'Content-Disposition: form-data; name="file1"; filename="'+filename+'"'+CRLF +
               'Content-Type: application/octet-stream' + CRLF + CRLF;

          //上传文件内容
          s1:='file one content. Contant-Type can be application/octet-stream or if'+
              'you want you can ask your OS fot the exact type.' + CRLF +
              '-----------------------------7cf1d6c47c' + CRLF + //分界符，用于分隔表单（Form）中的各个域
              'Content-Disposition: form-data; name="text1"' + CRLF + CRLF +
              'hello2' + CRLF +
              '-----------------------------7cf1d6c47c--';

          //提交的下一个表单内容域的内容
          s1:=CRLF +'-----------------------------7cf1d6c47c' + CRLF +
              'Content-Disposition: form-data; name="text1"' + CRLF + CRLF +
              'hello2' + CRLF +
              '-----------------------------7cf1d6c47c--';

          Source := TMemoryStream.Create;
          Source1 := TMemoryStream.Create;
          Source1.LoadFromFile(filename);
          Response:=TStringStream.Create('') ;
          Response.CopyFrom(source1,source1.Size);

          s:=s+Response.DataString;//因为只能传字符串
          Source.Position :=0;
          Source.Write(s[1],length(s));
          Source.Position :=source.Size ;
          Source.Write(s1[1],length(s1));
          Response.Position :=0;
          try
            HTTP.Post(cbURL.Text, Source, Response);
          finally
            Source.Free;
          end;
            memoHTML.Lines.Text := Response.DataString;
          finally
            Response.Free;
          end;
    finally
      Screen.Cursor := crDefault;
    end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if edit1.Text='' then
    begin
      showmessage('文件不能为空！');
      exit;
    end;
  Memo1.Lines.Clear;
  SendPostData(edit1.Text);
end;

procedure TForm1.LogDebugLogItem(ASender: TComponent; var AText: String);
begin
  Memo1.Lines.Add(AText);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  cbURL.ItemIndex :=0;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
   Edit1.Text :=OpenDialog1.FileName  
end;

end.
