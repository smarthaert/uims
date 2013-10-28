unit ClassEnterprise;

interface

uses
  Classes, Windows, DBTables;

type
  TEnterprise = class(TObject)
  public
    RatepayingNo: string; //纳税代码
    TaxRegisterNo: string; //税务登记证号
    EnterpriseName: string; //委托企业全称
    AffiliateTown: string; //所属乡镇
    DetailAddress: string; //详细地址
    TelephoneNo: string; //联系电话
    Linkman: string; //联系人
    constructor Create;
    destructor Destroy; override;
    procedure CreateQuery;
    procedure FreeQuery;
    function GetInfo(ARatepayingNo, ATaxRegisterNo: string; AEnterpriseName: string = ''): Boolean;
    function Update: Boolean;
    function Insert: Boolean;
    function Delete: Boolean;
  private
    TmpQuery: TQuery;
  end;

implementation

uses
  SysUtils, Forms, DB, Dialogs;

{ Enterprise }

constructor TEnterprise.Create;
begin
  inherited;
  CreateQuery;
end;

procedure TEnterprise.CreateQuery;
begin
  try
    TmpQuery := TQuery.Create(nil); //创建TEMPQUERY查询
    TmpQuery.DatabaseName := 'JB';
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), '错误框', MB_OK + MB_ICONERROR);
      Application.Terminate; //关闭程序
    end;
  end;
end;

function TEnterprise.Delete: Boolean;
begin
  with TmpQuery do
  try
    try
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM Enterprise.DB ');
      SQL.Add(' WHERE  RatepayingNo="' + RatepayingNo + '"');
      Prepare;
      ExecSQL;
      Result := True; //成功，返回TRUE
    finally
      UnPrepare;
      Close;
      Application.MessageBox('删除企业信息成功！', '确认', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('删除企业信息出错', '错误框', MB_OK + MB_ICONERROR);
    Result := False;
  end;
end;

destructor TEnterprise.Destroy;
begin
  FreeQuery;
  inherited;
end;

procedure TEnterprise.FreeQuery;
begin
  TmpQuery.Free; //释放TEMPQUERY查询
end;

function TEnterprise.GetInfo(ARatepayingNo, ATaxRegisterNo: string;
  AEnterpriseName: string = ''): Boolean;
begin
  Result := False;
  with TmpQuery do
  try
    Close; //关闭TEMPQUERY查询
    SQL.Clear;
    SQL.Add(' SELECT * FROM Enterprise.DB');
    if ARatepayingNo = '' then
      SQL.Add(' WHERE RatepayingNo= ' + '"' + Trim(ARatepayingNo) + '"')
    else
      SQL.Add(' WHERE TaxRegisterNo=' + '"' + Trim(ATaxRegisterNo) + '"');
    Open; //开始查询
    First;
    if RecordCount > 0 then //如果查出来的记录数不为0(即有记录)
    begin //取出子表中的各个字段
      RatepayingNo := fieldbyname('RatepayingNo').asstring; {取纳税代码}
      TaxRegisterNo := fieldbyname('TaxRegisterNo').asstring; {取税务登记证号}
      EnterpriseName := fieldbyname('EnterpriseName').asstring; {取委托企业全称}
      AffiliateTown := fieldbyname('AffiliateTown').asstring; {取所属乡镇}
      DetailAddress := fieldbyname('DetailAddress').asstring; {取详细地址}
      TelephoneNo := fieldbyname('TelephoneNo').asstring; {取联系电话}
      Linkman := fieldbyname('Linkman').asstring; {取联系人}
      Result := True
    end;
  finally
    Close; //关闭TEMPQUERY查询
  end;
end;

function TEnterprise.Insert: Boolean;
begin
  with TmpQuery do
  try
    try
      Close; //关闭查询
      SQL.Clear; //清除原有SQL语句
      SQL.Add(' INSERT INTO Enterprise.DB ');
      SQL.Add('        (RatepayingNo,');
      SQL.Add('        TaxRegisterNo,');
      SQL.Add('        EnterpriseName,');
      SQL.Add('        AffiliateTown,');
      SQL.Add('        DetailAddress,');
      SQL.Add('        TelephoneNo,');
      SQL.Add('        Linkman)');
      SQL.Add(' VALUES ("' + RatepayingNo + '",'); //纳税代码
      SQL.Add('        "' + TaxRegisterNo + '",'); //税务登记证号
      SQL.Add('        "' + EnterpriseName + '",'); //委托企业全称
      SQL.Add('        "' + AffiliateTown + '",'); //所属乡镇
      SQL.Add('        "' + DetailAddress + '",'); //详细地址
      SQL.Add('        "' + TelephoneNo + '",'); //联系电话
      SQL.Add('        "' + Linkman + '")'); //联系人
      Prepare; //告诉BDE将执行一个SQL
      ExecSQL; //开始更新数据
      Result := True; //返回TRUE
    finally
      Unprepare; //告诉BDE完成SQL的执行
      Close; //关闭查询
      Application.MessageBox('添加企业信息成功！', '确认', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('添加企业信息出错', '错误框', MB_OK + MB_ICONERROR);
    Result := False;
  end;
end;

function TEnterprise.Update: Boolean;
begin
  with TmpQuery do
  try
    try
      Close; //关闭查询
      SQL.Clear; //清除原有SQL语句
      SQL.Add(' UPDATE Enterprise.DB ');
      SQL.Add(' SET    TaxRegisterNo="' + TaxRegisterNo + '",'); //税务登记证号
      SQL.Add('        EnterpriseName="' + EnterpriseName + '",'); //委托企业全称
      SQL.Add('        AffiliateTown="' + AffiliateTown + '",'); //所属乡镇
      SQL.Add('        DetailAddress="' + DetailAddress + '",'); //详细地址
      SQL.Add('        TelephoneNo="' + TelephoneNo + '",'); //联系电话
      SQL.Add('        Linkman="' + Linkman + '"'); //联系人
      SQL.Add(' WHERE  RatepayingNo="' + RatepayingNo + '"');
      Prepare; //告诉BDE将执行一个SQL
      ExecSQL; //开始更新数据
      Result := True; //返回TRUE
    finally
      Unprepare; //告诉BDE完成SQL的执行
      Close; //关闭查询
      Application.MessageBox('更新企业信息成功！', '确认', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('更新企业信息出错！', '错误', MB_OK + MB_ICONERROR);
    Result := False;
  end;
end;

end.

