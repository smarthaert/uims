unit Main;
interface
uses
  ComObj,ASPComponent_TLB,ASPTypeLibrary_TLB,ActiveX,Sysutils,Classes,Variants;
const error_code=-1024;
type
  TInputInfo=record      //表单域信息
  name:shortstring;      //表单域名
  value:string;          //表单域值
  filetype:shortstring;
  filesize:integer;
 end;

  TFileUpload = class(TAutoObject, IFileUpload)
  private
    fsize,ftype,fvalue:string;
    fRequest: IRequest; //ASP对象
    savepath:string;  //文件保存路径
    foverwrite:boolean; //是否覆盖文件
    fresult:integer;
    Inputs:array [0..40] of TInputInfo;
    fcount:integer;

    Function Mapfile(fs:Tfilestream):boolean;  //内存映射文件
    function getitem2(const buf:pchar;const filesize:integer):boolean;
    // 从编码数据获取信息
    function SeekItem(Item:OleVariant):integer;
  protected
    function  OnStartPage(const pUnk: IUnknown): Integer; safecall;
    procedure OnEndPage; safecall;
    function  Savefile(const path: WideString; overwrite: WordBool): Integer; safecall;
           //保存上传文件，path为保存路径
    function  InputCount: Integer; safecall; //返回表单域个数
    function  FileSize(Item: OleVariant): Integer; safecall;//返回文件大小
    function  FileType(Item: OleVariant): WideString; safecall;//返回文件类型
    function  Request(Item: OleVariant): WideString; safecall;//返回表单域值
  end;

implementation
uses Windows, ComServ;

function TFileUpload.SeekItem(Item:OleVariant):integer;
var t,i:integer;
temp:string;
begin
 result:=-1;
 t:=VarType(Item);
 if t=varOleStr then //Item是表单名
  begin
   temp:=item;
   for i:=0 to fcount-1 do
     if AnsiSameText(temp,Inputs[i].name) then
       begin
       result:=i; break;
      end;
  end else if t=varInteger then //Item 是序号
   begin
     i:=item;
     if i<fcount then result:=i-1;
   end;
end;

function  TFileUpload.FileSize(Item: OleVariant): Integer;
begin
  result:=0;
  if SeekItem(item)<>-1 then
    result:=Inputs[SeekItem(item)].filesize;
end;

function  TFileUpload.FileType(Item:OleVariant): WideString;
begin
  result:='';
  if SeekItem(item)<>-1 then
    result:=Inputs[SeekItem(item)].filetype ;
end;

function  TFileUpload.Request(Item: OleVariant): WideString;
begin
  result:='';
  if SeekItem(item)<>-1 then
    result:=Inputs[SeekItem(item)].value ;
end;

function  TFileUpload.InputCount: Integer;
begin
   result:=fcount;
end;

function  TFileUpload.Savefile(const path: WideString; overwrite: WordBool): Integer;
const fsize=8192;
var fs:Tfilestream;
total:integer;
size,p:OleVariant;
buffer:pchar;
filename:array[0..260] of char;
begin
    fcount:=0;
    fresult:=0;
    savepath:=path;
    if not directoryexists(savepath) then
      begin
       CreateDir(savepath);
      end;

    foverwrite:=overwrite;
    if savepath[length(savepath)]<>'\' then
     savepath:=savepath+'\';
    GetTempFileName(pchar(savepath),'upl',0,filename);
//    GetTempFileName

    try
     fs:=Tfilestream.create(filename,fmCreate);  //建立临时文件
    except
     fresult:=error_code;
     exit;
    end;

    total:=0;
    while total<frequest.Get_TotalBytes do  //获取客户端上传的数据
      begin
           size:=fsize;
           p:=frequest.BinaryRead(size);
           buffer:=VarArrayLock(P);   //safearray和pchar的转换
           fs.Write(buffer^,size);
           VarArrayUnlock(p);
           total:=total+size;
      end;
   Mapfile(fs); //内存映射文件处理数据
   if fresult<>0 then result:=fresult  else result:=fs.size;
   //成功返回整个编码数据的长度，否则负数的错误代码
   fs.Free;
   DeleteFile(filename);   //删除临时文件
end;

function TFileUpload.OnStartPage(const pUnk: IUnknown): Integer;
var
   Script: IScriptingContext;
begin
    if pUnk<>nil then
     begin
      Script := pUnk as IScriptingContext;  ////实现ASP和其组件的接口
      fRequest := Script.Request;
      result:=S_OK;
    end;
end;

procedure TFileUpload.OnEndPage;
begin
//
end;

function TFileUpload.getitem2(const buf:pchar; const filesize:integer):boolean;
  const
  head='Content-Disposition: form-data; name="';
  filetag='"; filename="';
  file_type='Content-Type: ';
  var
  curr:integer;
  taglen:integer;
  tag:array[0..50] of char;
  temp:array[0..300] of char;
  i,k,p,t:integer;
  savefile,isfile:boolean;
  fs:Tfilestream;
  filename:string;
     function seekstring(from:integer;str:pchar):integer;
     var        //扫描指定字符串
      i:integer;
     begin
        result:=-1;
        for i:=from to filesize-1 do
         if buf[i]=str^ then
          if strLcomp(str,pchar(@buf[i]),strlen(str))=0 then
            begin
             result:=i;
             break;
            end;
     end;

    function seektag(from:integer):integer;
     var     //快速扫描标记
     i:integer;
     begin
        result:=-1;
        for i:=from to filesize-1 do
          if pdword(@buf[i])^=$2d2d2d2d then //$2d2d2d2d ='----'
            if strLcomp(tag,pchar(@buf[i]),taglen)=0 then
               begin
                result:=i;
                break;
               end;
     end;
begin
  curr:=0;
  tag[0]:=#0;
  t:=seekstring(0,#13#10);
  taglen:=t;
  strlcopy(tag,buf,taglen);
  curr:=taglen+2;
   while curr+2<filesize do
      begin ////1
          if strlcomp(head,@buf[curr],strlen(head))=0 then
           begin   //检查表单域标记
              curr:=curr+strlen(head);
              t:=seekstring(curr,'"');
              strlcopy(temp,@buf[curr],t-curr);
              Inputs[fcount].name:=strpas(temp);//获取表单域名
              isfile:=false;
              if strlcomp(@buf[t],filetag,strlen(filetag))=0 then
                begin //若是文件
                   t:=t+strlen(filetag);
                   k:=seekstring(t,'"');
                   strlcopy(temp,@buf[t],k-t);
                   isfile:=true;
                   Inputs[fcount].value:=extractfilename(temp); //文件名
                   t:=seekstring(k,file_type)+strlen(file_type);
                   curr:=seekstring(t,#13#10);
                   strlcopy(temp,@buf[t],curr-t);
                   Inputs[fcount].filetype:=strpas(temp);//文件类型
                   curr:=curr+4;
                end else
                begin
                  curr:=t+5;
                end;
               t:=seektag(curr);   //扫描下个标记
               if not isfile then
               begin
                 buf[t-2]:=#0;
                 Inputs[fcount].value:=strpas(@buf[curr]);//表单域值
                 inc(fcount);
                 curr:=t+2+taglen;
               end else
               begin
                  filename:=savepath+Inputs[fcount].value ;
                  Inputs[fcount].filesize:=t-2-curr;     //文件大小
                  savefile:=fileexists(filename) and not foverwrite;
                  if (length(Inputs[fcount].value)>0) and not savefile then
                   try
                     fs:=Tfilestream.create(filename,fmCreate); //生成文件
                     fs.Writebuffer(buf[curr],t-2-curr);
                   finally
                     fs.Free;
                   end;
                  inc(fcount);
                  curr:=t+2+taglen;
               end;
          end else
          begin
             exit;
          end;
      end;
end;

function TFileUpload.Mapfile(fs:Tfilestream):boolean;
var
  FMapHandle: THandle;  // 文件映射句柄
  PData: PChar;      // 文件视图的地址
begin
  FMapHandle := CreateFileMapping(fs.Handle, nil,
       PAGE_READWRITE	, 0, fs.size, nil);
       //只读方式创建文件内存映射对象
  if FMapHandle = 0 then
   begin //创建文件内存映射对象错误
     fresult:=error_code+1;
     exit;
   end;
  PData := MapViewOfFile(FMapHandle, FILE_MAP_WRITE	, 0, 0,
     fs.size); //映射文件视图，返回映射视图的初始地址

  if PData=nil then  //创建映射视图出错
     begin
      CloseHandle(FMapHandle); //关闭文件映射对象
      fresult:=error_code+2;
      exit;
   end;
  try
   getitem2(pdata,fs.size);
  except
    fresult:=error_code+3;
  end;
   UnmapViewOfFile(PData); //删除文件视图
   CloseHandle (FMapHandle);
end;

initialization
  TAutoObjectFactory.Create(ComServer, TFileUpload, CLASS_CoIFileUpload, ciMultiInstance,
    tmApartment);
end.
