unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, Buttons,shellapi, TFlatSpeedButtonUnit,
  AnimationEffect,registry,des, TFlatGaugeUnit;

type
  Tabout = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    Label4: TLabel;
    FlatSpeedButton1: TFlatSpeedButton;
    FlatSpeedButton2: TFlatSpeedButton;
    AnimationEffect1: TAnimationEffect;
    Bevel2: TBevel;
    regLabel: TLabel;
    Gauge: TFlatGauge;
    EvaluationLabel: TLabel;
    Bevel1: TBevel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure FlatSpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FlatSpeedButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
 // TrialPeriod, DaysPassed: Integer;
    { Public declarations }
  end;
const programpath='\Software\dhsoft\config';
      syslevel='\Software\Microsoft\Windows\CurrentVersion';
var
  about: Tabout;


implementation
uses unit1,unit4;

{$R *.DFM}

procedure URLink(URL:PChar);
begin
ShellExecute(0, nil, URL, nil, nil, SW_NORMAL);
end;
procedure Tabout.SpeedButton1Click(Sender: TObject);
begin
  close;
end;

procedure Tabout.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label8.Font.Color:=clblue;
   label8.Font.Style:=[];
   label10.Font.Color:=clblue;
   label10.Font.Style:=[];
end;

procedure Tabout.Label10MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label10.Font.Color:=clwhite;
  label10.Font.Style:=[fsunderline];
end;

procedure Tabout.Label8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label8.Font.Color:=clwhite;
  label8.Font.Style:=[fsunderline];
end;

procedure Tabout.Label8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   URLink('mailto:dhzyx@elong.com');
end;

procedure Tabout.Label10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   URLink('http://www.delphi6th.com');
end;

procedure Tabout.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure Tabout.FlatSpeedButton1Click(Sender: TObject);
begin
   close;
end;

procedure Tabout.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
  form1.SysTray1.Active:=false;
end;

procedure Tabout.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   form1.SysTray1.Active:=true;
end;

procedure Tabout.FlatSpeedButton2Click(Sender: TObject);
begin
   form4:=tform4.Create(self);
   form4.ShowModal;
end;

procedure Tabout.FormActivate(Sender: TObject);
var
  {fw,
  SerialNum : pdword;
  a, b : dword;
  Buffer  : array [0..255] of char;}
  s,s1,s2:string;
begin
// if GetVolumeInformation('C:\', Buffer, SizeOf(Buffer), SerialNum, a, b, nil, 0) then
 //  begin
  //   edit3.Text:=copy(EncryStrHex(inttostr(SerialNum^),'i'),13,4)+copy(EncryStrHex(copy(inttostr(SerialNum^),3,3),'you'),1,2);
    // fw:=form1.edit1.Text+form1.edit2.Text+edit3.Text;
    // pw3:=copy(EncryStrHex(copy(inttostr(SerialNum^),7,3),'you'),7,10);
 //  end;

 with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('m4')='' then exit;
   s:=copy(readstring('AK'),1,6);
   s1:=copy(readstring('AK'),7,6);
   s2:=copy(readstring('AK'),13,6);
   if (copy(readstring('m4'),1,4)=copy(encrystrhex(copy(decryStrHex(s+s1+copy(s2,1,4),'i'),1,3),'i'),1,4)) and (copy(readstring('m4'),5,4)=copy(encrystrhex(copy(decryStrHex(s+s1+copy(s2,1,4),'i'),4,3),'love'),1,4))
    and (copy(readstring('m4'),9,4)=copy(encrystrhex(copy(decryStrHex(s+s1+copy(s2,1,4),'i'),7,2),'you'),1,4)) then
    begin
    reglabel.AutoSize:=true;
      with tregistry.Create do
   try

   rootkey:=HKEY_LOCAL_MACHINE;
   openkey(syslevel,true);
   reglabel.caption:='本软件已注册给'+#13#10+#13#10+readstring('RegisteredOwner')+#13#10
   + readstring('RegisteredOrganization');
   EvaluationLabel.Visible:=false;
   gauge.Visible:=false;
   Bevel1.Visible:=true;
   finally
   free;
   end;
      FlatSpeedButton2.Enabled:=false;
    end
    else
    begin
      reglabel.Caption:='这是未注册版本'+#13#10+'请注册！';
    end;
   finally
   free;
   end;

end;

procedure Tabout.FormCreate(Sender: TObject);
begin
    EvaluationLabel.Caption := '软件已使用了' + IntToStr(form1.blindguardian1.DaysPassed) + '天!';
     Gauge.MaxValue := form1.blindguardian1.TrialPeriod;
     Gauge.Progress := form1.blindguardian1.DaysPassed;
end;

end.

