//注意：应用程序生成后应修改名称
//SUpData.exe更新RASDIAL.exe

//更新RASDIAL.exe时使用以下指令
//tempFile:=SPath+'RASDIAL.exe';                     //系统升级文件的名称
//TBlobField(Table1.FieldByName('FileData')).SaveToFile(tempFile);//读取服务器文件写入RASDIAL.exe

unit UpTemp;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TUpTempForm = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    Image1: TImage;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function DownloadFile(Source, Dest: string): Boolean;
  public
    { Public declarations }
  end;

const
  Versions='1.10';                                   //系统 版本号（判断是否需要自动更新时用）
  CrLf=#13+#10;                                         //回车换行（生成业务点时从List中提取业务点时使用）

  //铁通西安分公司服务器IP：222.41.161.40
  iTest = 1;                                            //0-使用服务器、1-IP系统测试，使用本地IP

var
  UpTempForm: TUpTempForm;
  t,tt:integer;
  SPath:string;

implementation

uses
  UrlMon;
  
{$R *.dfm}



//系统自动更新
procedure TUpTempForm.FormCreate(Sender: TObject);
begin
  GetDir(0,SPath);                                      //获取当前目录名,0-当前驱动器,1-A,2-B,3-C...
  SPath:=SPath+'\';                                     //系统安装目录
  Timer1.Enabled:=true;
  t:=0;
  tt:=0;
end;

function TUpTempForm.DownloadFile(Source, Dest: string): Boolean;
begin
  try
    Result:=UrlDownloadToFile(nil, PChar(source), PChar(Dest), 0, nil) = 0;
  except
    Result := False;
  end;
end;

procedure TUpTempForm.Timer1Timer(Sender: TObject);
var
  i:integer;
  b:boolean;
  TSI:TStartupInfo;
  TPI:TProcessInformation;
  F:File;
  tempFile:String;
  BakFile:String;
begin
  Timer1.Enabled:=false;
  if (t<=5) then                                        //等待5秒
  begin
    t:=t+1;
  end
  else
  begin
    tempFile:='RASDIAL.exe';                            //更新RASDIAL.exe （UpData.exe）
    BakFile:='RASDIAL.bak';                             //更新RASDIAL.exe （UpData.exe）

    if (tt=0) then                                      //未下载
    begin
      if iTest=1 then                                     //测试
      begin
        b:=DownloadFile('\\127.0.0.1\UpData\'+tempFile, SPath+BakFile);
      end
      else
      begin
        b:=DownloadFile('\\222.41.161.40\UpData\'+tempFile, SPath+BakFile);
      end;

      if not b then                                       //若下载失败
      begin
        messagebeep(0);
//      showmessage('          系统升级失败！请与维护部门联系           ');
        Application.Terminate;
        exit;
      end;
      tt:=1;
    end;

    //删除原始文件
    if not DeleteFile(SPath+tempFile) then              //删除原始文件
    begin
      if FileExists(SPath+tempFile) then                //检测指定的文件否存在
      begin
        t:=0;                                             //重新计时
        Timer1.Enabled:=true;
        exit;
      end;
    end;

    tempFile:='RASDIAL.exe';                            //更新RASDIAL.exe （UpData.exe）
    BakFile:='RASDIAL.bak';                             //更新RASDIAL.exe （UpData.exe）

    //更改文件名。
    AssignFile(F,SPath+BakFile);                        //将BakFile文件与F变量建立连接，后面可以使用F变量对文件进行操作。
    ReName(F,SPath+tempFile);                           //tempFile
//  CloseFile(F);                                       //不需要关闭文件

    //运行升级程序时，升级程序应与原主程序this.exe在同一目录下。如果当它启动时，这个版本主程序应该退出，但要保证它不会删除任何文件，因为此时Application.Initialize还没有被调用。代码如下：
    FillChar(TSI, SizeOf(TSI), 0);
    TSI.CB := SizeOf(TSI);
    //打开并运行升级程序
    if CreateProcess (PChar(SPath+tempFile), nil, nil, nil, False, DETACHED_PROCESS, nil, nil, TSI, TPI) then
    begin
      Application.Terminate;                                     //正常
    end
    else     //但是，如果“升级程序”由于某些原因没有运行，我们此时应该告诉用户，他能通过其他方法得到一个更新的程序版本，这时我们依然退出主程序以便用户升级。如果必要的话，也可以继续装入并运行旧版本。
    begin
      messagebeep(0);
//    showmessage('          系统升级失败！请与维护部门联系           ');
      Application.Terminate;
    end;
  end;
  Timer1.Enabled:=true;
end;

end.
