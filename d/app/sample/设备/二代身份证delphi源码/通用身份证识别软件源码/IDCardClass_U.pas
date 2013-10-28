unit IDCardClass_U;
//Download by http://www.codefans.net
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
type
  TIDCard = class(TObject)
  private
    FMZList: TStringList;//民族代码列表；
    FMZ: string;//民族
    FName:string;   //姓名
    FSex_Code: string;   //性别代码
    FSex_CName: string;   //性别
    FIDC: string;      //身份证号码
    FNATION_Code: string;   //民族代码
    FNATION_CName: string;   //民族
    FBIRTH: string;     //出生日期
    FADDRESS: string;    //住址
    FREGORG: string;     //签发机关
    FSTARTDATE: string;    //身份证有效起始日期
    FENDDATE: string;    //身份证有效截至日期
    FPeriod_Of_Validity_Code: string;   //有效期限代码，许多原来系统上面为了一代证考虑，常常存在这样的字段，二代证中已经没有了
    FPeriod_Of_Validity_CName: string;   //有效期限

    procedure SetMZ(value: string);
    procedure SetName(value: string);
    procedure SetSex_Code(value: string);
    procedure SetSex_CName(value: string);
    procedure SeTIDCardC(value: string);
    procedure SetNATION_Code(value: string);
    procedure SetNATION_CName(value: string);
    procedure SetBIRTH(value: string);
    procedure SetADDRESS(value: string);
    procedure SetREGORG(value: string);
    procedure SetSTARTDATE(value: string);
    procedure SetENDDATE(value: string);
    procedure SetPeriod_Of_Validity_Code(value: string);
    procedure SetPeriod_Of_Validity_CName(value: string);

    function GetMZ: string;
    function GetName: string;
    function GetSex_Code: string;
    function GetSex_CName: string;
    function GeTIDCardC: string;
    function GetNATION_Code: string;
    function GetNATION_CName: string;
    function GetBIRTH: string;
    function GetADDRESS: string;
    function GetREGORG: string;
    function GetSTARTDATE: string;
    function GetENDDATE: string;
    function GetPeriod_Of_Validity_Code: string;
    function GetPeriod_Of_Validity_CName: string;
  public
    constructor Create();
    destructor Destroy();
    procedure InitInfo(FileName: string);
    property MZ: string read GetMZ ;
    property Name: string read GetName write SetName;
    property Sex_Code: string read GetSex_Code write SetSex_Code;
    property Sex_CName: string read GetSex_CName write SetSex_CName;
    property IDC: string read GeTIDCardC write SeTIDCardC;
    property NATION_Code: string read GetNATION_Code write SetNATION_Code;
    property NATION_CName: string read GetNATION_CName write SetNATION_CName;
    property BIRTH: string read GetBIRTH write SetBIRTH;
    property ADDRESS: string read GetADDRESS write SetADDRESS;
    property REGORG: string read GetREGORG write SetREGORG;
    property STARTDATE: string read GetSTARTDATE write SetSTARTDATE;
    property ENDDATE: string read GetENDDATE write SetENDDATE;
    property Period_Of_Validity_Code: string read GetPeriod_Of_Validity_Code write SetPeriod_Of_Validity_Code;
    property Period_Of_Validity_CName: string read GetPeriod_Of_Validity_CName write SetPeriod_Of_Validity_CName;
  end;
implementation

{ TIDCard }
constructor TIDCard.Create;
begin
  inherited;
  //----------以下先后循序不能错-----------//
  FMZList:= TStringList.Create;
  FMZList.Add('汉族');
  FMZList.Add( '蒙古族');
  FMZList.Add('回族');
  FMZList.Add('藏族');
  FMZList.Add('维吾尔族');
  FMZList.Add('苗族');
  FMZList.Add('彝族');
  FMZList.Add('壮族');
  FMZList.Add('布依族');
  FMZList.Add('朝鲜族');
  FMZList.Add('满族');
  FMZList.Add('侗族');
  FMZList.Add('瑶族');
  FMZList.Add('白族');
  FMZList.Add('土家族');
  FMZList.Add('哈尼族');
  FMZList.Add('哈萨克族');
  FMZList.Add('傣族');
  FMZList.Add('黎族');
  FMZList.Add('傈僳族');
  FMZList.Add('佤族');
  FMZList.Add('畲族');
  FMZList.Add('高山族');
  FMZList.Add('拉祜族');
  FMZList.Add('水族');
  FMZList.Add('东乡族');
  FMZList.Add('纳西族');
  FMZList.Add('景颇族');
  FMZList.Add('柯尔克孜族');
  FMZList.Add('土族');
  FMZList.Add('达翰尔族');
  FMZList.Add('仫佬族');
  FMZList.Add('羌族');
  FMZList.Add('布朗族');
  FMZList.Add('撒拉族');
  FMZList.Add('毛南族');
  FMZList.Add('仡佬族');
  FMZList.Add('锡伯族');
  FMZList.Add('阿昌族');
  FMZList.Add('普米族');
  FMZList.Add('塔吉克族');
  FMZList.Add('怒族');
  FMZList.Add('乌孜别克族');
  FMZList.Add('俄罗斯族');
  FMZList.Add('鄂温克族');
  FMZList.Add('德昂族');
  FMZList.Add('保安族');
  FMZList.Add('裕固族');
  FMZList.Add('京族');
  FMZList.Add('塔塔尔族');
  FMZList.Add('独龙族');
  FMZList.Add('鄂伦春族');
  FMZList.Add('赫哲族');
  FMZList.Add('门巴族');
  FMZList.Add('珞巴族');
  FMZList.Add('基诺族');
  FMZList.Add('其它');
  FMZList.Add('外国人入籍')
end;

function TIDCard.GetADDRESS: string;
begin
  Result:= FADDRESS;
end;

function TIDCard.GetBIRTH: string;
begin
  Result:= FBIRTH;
end;

function TIDCard.GetENDDATE: string;
begin
  Result:= FENDDATE;
end;

function TIDCard.GeTIDCardC: string;
begin
  Result:= FIDC;
end;

function TIDCard.GetMZ: string;
begin
  Result:= FMZ;
end;

function TIDCard.GetName: string;
begin
  Result:= FName;
end;

function TIDCard.GetNATION_CName: string;
begin
  Result:= FNATION_CName;
end;

function TIDCard.GetNATION_Code: string;
begin
  Result:= FNATION_Code;
end;

function TIDCard.GetPeriod_Of_Validity_CName: string;
begin
  Result:= FPeriod_Of_Validity_CName;
end;

function TIDCard.GetPeriod_Of_Validity_Code: string;
begin
  Result:= FPeriod_Of_Validity_Code;
end;

function TIDCard.GetREGORG: string;
begin
  Result:= FREGORG;
end;

function TIDCard.GetSex_CName: string;
begin
  Result:= FSex_CName
end;

function TIDCard.GetSex_Code: string;
begin
  Result:= FSex_Code;
end;

function TIDCard.GetSTARTDATE: string;
begin
  Result:= FSTARTDATE;
end;

procedure TIDCard.SetADDRESS(value: string);
begin
  FADDRESS:= value;
end;

procedure TIDCard.SetBIRTH(value: string);
begin
  FBIRTH:= value;
end;

procedure TIDCard.SetENDDATE(value: string);
begin
  FENDDATE:= value;
end;

procedure TIDCard.SeTIDCardC(value: string);
begin
  FIDC:= value;
end;

procedure TIDCard.SetMZ(value: string);
begin
  FMZ:= value;
end;

procedure TIDCard.SetName(value: string);
begin
  FName:= value;
end;

procedure TIDCard.SetNATION_CName(value: string);
begin
  FNATION_CName:= value;
end;

procedure TIDCard.SetNATION_Code(value: string);
begin
  FNATION_Code:= value;
end;

procedure TIDCard.SetPeriod_Of_Validity_CName(value: string);
begin
  FPeriod_Of_Validity_CName:= value;
end;

procedure TIDCard.SetPeriod_Of_Validity_Code(value: string);
begin
  FPeriod_Of_Validity_Code:= value;
end;

procedure TIDCard.SetREGORG(value: string);
begin
  FREGORG:= value;
end;

procedure TIDCard.SetSex_CName(value: string);
begin
  FSex_CName:= value;
end;

procedure TIDCard.SetSex_Code(value: string);
begin
  FSex_Code:= value;
end;

procedure TIDCard.SetSTARTDATE(value: string);
begin
  FSTARTDATE:= value;
end;

procedure TIDCard.InitInfo(FileName: string);
var
  iFileHandle,iFileLength: Integer;
  Buffer: PWideChar;
  wInfo :WideString;
begin
  iFileHandle := FileOpen(FileName, fmOpenRead);
  iFileLength := FileSeek(iFileHandle,0,2);
  FileSeek(iFileHandle,0,0);
  Buffer := PWideChar(AllocMem(iFileLength +2));
  FileRead(iFileHandle, Buffer^, iFileLength);
  FileClose(iFileHandle);
  wInfo:=WideChartostring(buffer);
  SetName(trim(copy(wInfo,1,15)));
  SetSex_Code(trim(copy(wInfo,16,1)));
  if FSex_Code = '1' then
    SetSex_CName('男')
  else if FSex_Code = '2' then
    SetSex_CName('女');
  SetNATION_Code(trim(copy(wInfo,17,2)));
  if FMZList<> nil then
    SetNATION_CName(FMZList.Strings[StrToInt(FNATION_Code)-1]);
  SetBIRTH(trim(copy(wInfo,19,8)));
  SetADDRESS(trim(copy(wInfo,27,35)));
  SeTIDCardC(trim(copy(wInfo,62,18)));
  SetREGORG(trim(copy(wInfo,80,15)));
  SetSTARTDATE(trim(copy(wInfo,95,8)));
  SetENDDATE(trim(copy(wInfo,103,8)));
end;


destructor TIDCard.Destroy;
begin
  FMZList.Free;
end;

end.
