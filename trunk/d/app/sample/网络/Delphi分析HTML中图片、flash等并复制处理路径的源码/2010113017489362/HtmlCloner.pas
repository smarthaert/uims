unit HtmlCloner;

{*****
  Sgxcn By 2010/8/12
  http://www.programbbs.com
******}

interface

uses
  Windows, Classes, SysUtils, RegExpr;

type
  THtmlCloner = class
  private
    FSrcRootPath: string;
    FDestResourcePath: string;
    FDestResourceUrl: string;

    //FRegxFile: string;
    //FRegxPath: string;
    FRegxPathRpl: string;

    FRegx: TRegExpr;
    procedure SetDestResourceUrl(const Value: string);
  public
    constructor Create;
    destructor Destory;
    //处理
    function Process(sSrc: string; sStatus: TStrings = nil): string;
    //源站点跟目录  必须带\
    property SrcRootPath: string read FSrcRootPath write FSrcRootPath;
    //目标资源路径  必须带\
    property DestResourcePath: string read FDestResourcePath write FDestResourcePath;
    //目标基础URL  必须带/
    property DestResourceUrl: string read FDestResourceUrl write SetDestResourceUrl;
  end;

implementation

{ THtmlCloner }

constructor THtmlCloner.Create;
begin
  FRegx := TRegExpr.Create;
  FRegx.Expression := '(src\s?=\s?["|''|\s]?)(\S+/)(\S+\.[^"^''^ ]+)';
  //FRegxFile := 'src\s?=\s?["|''|\s]?([^"^''^ ]+)';
  //FRegxPath := '(src\s?=\s?["|''|\s]?)(\S+/)(\S+\.[^"^''^ ]+)';
  FRegxPathRpl := '$1$3';
end;

destructor THtmlCloner.Destory;
begin
  FRegx.Free;
end;

function THtmlCloner.Process(sSrc: string; sStatus: TStrings): string;
var
  sFile: String;
begin
  //复制文件
  if FRegx.Exec(sSrc) then
  begin
    repeat
      sFile := FSrcRootPath + StringReplace(FRegx.Match[2], '/', '\', [rfReplaceAll]) + FRegx.Match[3];
      if FileExists(sFile) then
      begin
        CopyFile(PChar(sFile), PChar(FDestResourcePath + FRegx.Match[3]), false);
        if sStatus <> nil then
           sStatus.Append(sFile + '已经复制到' + FDestResourcePath + FRegx.Match[3] + '。');
      end
      else
      begin
        if sStatus <> nil then
           sStatus.Append(PChar(sFile) + '不存在。');
      end;
    until not FRegx.ExecNext;
  end;

  //处理HTML
  Result := FRegx.Replace(sSrc, FRegxPathRpl, true);
  if sStatus <> nil then
     sStatus.Append('源码转换完成！');
end;

procedure THtmlCloner.SetDestResourceUrl(const Value: string);
begin
  FDestResourceUrl := StringReplace(Value , '\', '/', [rfReplaceAll]);
  FDestResourceUrl := StringReplace(FDestResourceUrl , '$', '', [rfReplaceAll]);

  FRegxPathRpl := '$1' + FDestResourceUrl + '$3';
end;

end.

