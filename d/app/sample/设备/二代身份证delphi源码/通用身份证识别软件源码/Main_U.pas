unit Main_U;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OBThread, jpeg, StdCtrls, ExtCtrls,IDCardClass_U;

type
  TIDCardRead_F = class(TForm)
    img_Cover: TImage;
    obthrd_ReadID: TOBThread;
    lbl_Info: TLabel;
    lbl_Con: TLabel;
    BtnGlyph_Read: TImage;
    BtnGlyph_UnRead: TImage;
    ID_Addr: TLabel;
    ID_Birth: TLabel;
    ID_Depart: TLabel;
    ID_ID: TLabel;
    ID_Name: TLabel;
    ID_Nation: TLabel;
    ID_NewAddr: TLabel;
    ID_Sex: TLabel;
    ID_Time: TLabel;
    Image_XP: TImage;
    ImageClose: TImage;
    ImageMin: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ImageCloseClick(Sender: TObject);
    procedure obthrd_ReadIDExecute(Sender: TObject; params: Pointer);
    procedure BtnGlyph_ReadClick(Sender: TObject);
    procedure BtnGlyph_UnReadClick(Sender: TObject);
    procedure ImageMinClick(Sender: TObject);
    procedure img_CoverMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    UsbOrCom: string;
    Port,pucSn,puiCHMsgLen,puiPHMsgLen: integer;
    StartReadID,PortEnable: Boolean;
    IDCard: TIDCard;
    procedure ReadIDCard();//读身份证
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IDCardRead_F: TIDCardRead_F;

implementation
uses IDCardDll_U ;
{$R *.dfm}

procedure TIDCardRead_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  IDCard.Destroy;
  StartReadID:= False;
  if PortEnable then
    SDT_ClosePort(Port);
end;

procedure TIDCardRead_F.FormCreate(Sender: TObject);
begin
  IDCard:= TIDCard.Create;
  PortEnable:= OpenUsbPort(Port);
  if PortEnable then
  begin
    UsbOrCom:= 'U';//连接的类型是通过Usb端口
    lbl_Con.Caption:= '连接类型：USB口连接';
    lbl_Con.Font.Color:= clGreen;
  end
  else begin
    PortEnable:= OPenComPort(Port);
    if PortEnable then
    begin
      UsbOrCom:= 'C' ;   //连接的类型是通过Com端口
      lbl_Con.Caption:= '连接类型：串口连接';
      lbl_Con.Font.Color:= clGreen;
    end
    else begin
      UsbOrCom:='';
      lbl_Con.Caption:= '连接类型：端口错误导致未连接';
      lbl_Con.Font.Color:= clRed;
    end;
  end;
  if not PortEnable then
    BtnGlyph_Read.Enabled:= False;
  StartReadID:= True;
  if (StartReadID) and (PortEnable) then
    BtnGlyph_ReadClick(nil);
end;

procedure TIDCardRead_F.ImageCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TIDCardRead_F.ReadIDCard;
var
  iRet : integer;
begin
  while (PortEnable) and (StartReadID) do
  begin
    Sleep(1000);
    iRet:= SDT_StartFindIDCard(Port, pucSn, 1); //查卡
    if iRet = 159 then
      iRet:= SDT_SelectIDCard(Port,pucSn,1) //选卡
    else Continue;
    if iRet= 144 then
    begin
      puiCHMsgLen:=0;
      puiPHMsgLen:=0;
      iRet:= SDT_ReadBaseMsgToFile(1001, 'wz.txt',puiCHMsgLen, 'zp.wlt',puiPHMsgLen,1); //存储文件
    end
    else Continue;
    if iRet =144 then
    begin
      UsbOrCom:='U';//连接的类型是通过Usb端口
      if UsbOrCom ='U' then
        iRet := GetBmp('zp.wlt',2)
      else if UsbOrCom='C' then //如果连接的类型是Com端口
        iRet := GetBmp('zp.wlt',1);

      if iRet=1 then
      begin
        Image_XP.Picture.LoadFromFile('zp.bmp');
        IDCard.InitInfo(ExtractFilePath(Application.ExeName) +'wz.txt');
        ID_Name.Caption:= IDCard.Name;
        ID_Sex.Caption:= IDCard.Sex_CName;
        ID_Nation.Caption:= IDCard.NATION_CName;
        ID_Birth.Caption:= IDCard.BIRTH;
        ID_Addr.Caption:= IDCard.ADDRESS;
        ID_ID.Caption:= IDCard.IDC;
        ID_Depart.Caption:= IDCard.REGORG;
        ID_Time.Caption:= IDCard.STARTDATE +'-'+IDCard.ENDDATE;
        DeleteFile('zp.bmp');
        DeleteFile('wz.txt');
      end
      else Continue;
    end;
  end;
end;

procedure TIDCardRead_F.obthrd_ReadIDExecute(Sender: TObject;
  params: Pointer);
begin
  ReadIDCard ;
end;

procedure TIDCardRead_F.BtnGlyph_ReadClick(Sender: TObject);
begin
  StartReadID:= True;
  BtnGlyph_Read.Visible:= False;
  BtnGlyph_UnRead.Visible:= True;
  obthrd_ReadID.Execute(nil);
end;

procedure TIDCardRead_F.BtnGlyph_UnReadClick(Sender: TObject);
begin
  BtnGlyph_Read.Visible:= True;
  BtnGlyph_UnRead.Visible:= False;
  StartReadID:= False;
end;

procedure TIDCardRead_F.ImageMinClick(Sender: TObject);
begin
  IDCardRead_F.WindowState:= wsMinimized;
end;

procedure TIDCardRead_F.img_CoverMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssleft in shift then
    Releasecapture;
  perform(WM_SYSCOMMAND,$F012,0);
end;

end.
