unit Update;
// Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, UrlMon,IBInstatusCallBack,
  inifiles, ExtCtrls, ShellApi;
  
type
  TUpdataFrm = class(TForm)
    UpdateBtn: TBitBtn;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    ProgressBar2: TProgressBar;
    Label1: TLabel;
    Label6: TLabel;
    CancelBtn: TBitBtn;
    procedure UpdateBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    procedure ResumeFrm;
  public
    ProgressStatus,inifile,infile,finished : string;
    filecount,CurDown: integer;
    arDownload,CrThread,AutoClose: Boolean;      //测试是否已经下载信息
    Updatefiles: TStrings;

    function ReadUpdateMessage(inifile: string; var UpdateLst: Tstrings;
         var ProgressStatus: string):Boolean;
    function ShlExecute(inifile: string):Boolean;
  end;
    function UpdateFile(Source,Dest:string):Boolean;


var
  UpdataFrm: TUpdataFrm;
  RevedByte:TBindStatusCallback ;


Const
  SectionStr = 'Updatefiles';
  SourcePath = 'http://192.168.1.39/SQL/update.ini';
  mainurl    = 'http://192.168.1.39/';

Resourcestring
          zzxz = '正在将：%s 下载到：%s ...';
          gxsb = '''%s''更新失败';
          gx   = '更新';
          gxwc = '更新完毕！';



implementation
uses arUpdata_, DownInifile;

{$R *.dfm}

var
  aUpdata: arUpdata;

function TUpdataFrm.ShlExecute(inifile: string):Boolean;
var
  ini: Tinifile;
  exeFile: string;
begin
   ini := Tinifile.Create(inifile);
   exeFile := ini.ReadString('shell','exefile','');
   if Not (exefile = '') then shellexecute(self.Handle,'open',pchar(exefile),nil,nil,sw_normal);
   ini.free;
   deletefile(inifile);
   Result := True;
end;

function UpdateFile(Source,Dest:string):Boolean;
begin
  if UrlDownloadToFile(nil,Pchar(Source),Pchar(Dest),0,RevedByte)=0 then  Result := True
  else  Result := False;
end;

procedure TUpdataFrm.ResumeFrm;
begin
  CrThread := False;
  if FileExists(inifile) then   Deletefile(inifile);
  Label2.Visible := False;
  Label5.Caption := format('%s',[finished]);
  Label5.Visible := True;
  Application.MessageBox('更新完毕.','提示',48);
  UpdateBtn.Enabled := True;
  if GetForeGroundWindow<>Application.Handle then  SetForeGroundWindow(Application.Handle);
end;


function TUpdataFrm.ReadUpdateMessage(inifile: string; var UpdateLst:Tstrings;var ProgressStatus: string):Boolean;
var
  ini,Mini: TIniFile;
  SectionLst: TStrings;
  allStr,Source,Dest: string;
  i :integer;
  UpDate,NowDate: TdateTime;
begin
   Result := false;
   Mini := Tinifile.Create(infile);
   UpDate := Mini.ReadDateTime('Message','UpDate',Now);
   ini := Tinifile.Create(inifile);
   NowDate := ini.ReadDateTime('Message','UpDate',Now);
   if Update >= NowDate then
     begin
       Mini.Free;
       ini.Free;
       aUpdata.Terminate;
       ResumeFrm;
       Exit;
     end;
   SectionLst := TStringList.Create;
   ini.ReadSection(SectionStr,SectionLst);
   filecount := SectionLst.Count;
   for i:=1 to filecount do
     begin
        allStr := ini.ReadString(SectionStr,SectionLst.Strings[i-1],'');
        Source := copy(allStr,1,pos('|',allStr)-1);
        Dest := copy(allStr,Pos('|',allStr)+1,Length(allStr));
        ProgressStatus := format(zzxz,[ExtractFileName(Dest),
        ExtractShortPathName(ExtractFilePath(Application.ExeName)+Dest)]);
        if Not UpdateFile(Source,Dest) then
          begin
            Result := false;
            Application.MessageBox(Pchar(Format(gxsb,[ExtractFileName(Dest)])),
            pchar(gx),16);
            if messageDlg('还要继续更新其他文件吗?',mtconfirmation,[mbyes,mbno],0)=mryes then
              begin
                CurDown := i;
                continue;
              end
            else
              begin
                ResumeFrm;
                exit;
              end;
            CancelBtnClick(UpdataFrm);
          end
        else result := true;
        CurDown := i;
     end;
   Mini.WriteDateTime('Message','Update',Nowdate);
   Mini.Free;
   ini.Free;
   aUpdata.Terminate;
   ResumeFrm;
end;


procedure TUpdataFrm.UpdateBtnClick(Sender: TObject);
begin
   Label5.Visible    := False;
   UpdateBtn.Enabled := False;
   arDownload        := False;
   CrThread          := False;
   filecount         := 1;
   CurDown           := 0;
   ProgressStatus    := '下载更新信息 ...';
   if UpdateFile(SourcePath,inifile) then
     begin
        Progressbar2.Position := 0;
        Progressbar1.Position := 0;
        aUpdata := arUpdata.Create(false);
        aUpdata.FreeOnTerminate := True;
        CrThread := True;
     end
   else ResumeFrm;
   if Not arDownload then
     begin
        Label5.Caption := '服务器连接失败，无法完成更新！';
        Application.MessageBox('服务器连接失败，无法完成更新！','更新',16);
     end;
end;


procedure TUpdataFrm.FormCreate(Sender: TObject);
var
  TempPath: array[0..255] of char;
  TPath: string;
begin
  RevedByte := TBindStatusCallback.Create;
  finished  := '完成更新...';
  GetTempPath(256,TempPath);
  TPath := TempPath;
  TPath := trim(TPath);
  if copy(TPath,Length(TPath),1)<>'\' then   TPath := TPath + '\';
  inifile   := TPath+'update.ini';
  infile     := Extractfilepath(Application.exename)+'Predate.ini';
  if (paramcount>0) and (paramstr(1)='#') then
    begin
      Show;
      update;
      AutoClose := True;
      UpdateBtnClick(Sender);
    end;
end;

procedure TUpdataFrm.CancelBtnClick(Sender: TObject);
begin
  if CrThread then
    begin
      aUpdata.Suspend;
      if MessageDlg('确定要取消更新吗？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
         begin
           aUpdata.Terminate;
           finished := '被用户终止...';
           ResumeFrm;
           Application.Terminate;
           exit;
         end
      else
        begin
          aUpdata.Resume;
          exit;
        end;
    end;
  Application.Terminate;
end;

end.
