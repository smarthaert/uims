unit Main;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, ComCtrls,
  auAutoUpgrader, auHTTP;

type    
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    Label6: TLabel;
    URLLabel1: TLabel;
    URLLabel2: TLabel;
    AutoUpgraderPro1: TauAutoUpgrader;
    procedure Button1Click(Sender: TObject);
    procedure AutoUpgraderPro1Aborted(Sender: TObject);
    procedure URLLabel1Click(Sender: TObject);
    procedure URLLabel2Click(Sender: TObject);
    procedure AutoUpgraderPro1NoUpdateAvailable(Sender: TObject);
    procedure AutoUpgraderPro1Progress(Sender: TObject;
      const FileURL: string; FileSize, BytesRead, ElapsedTime,
      EstimatedTimeLeft: Integer; PercentsDone, TotalPercentsDone: Byte;
      TransferRate: Single);
  private
    { Private declarations }
  public    
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
{$R WindowsXP.res}

uses auUtils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  AutoUpgraderPro1.CheckUpdate(False);
end;

procedure TForm1.AutoUpgraderPro1Aborted(Sender: TObject);
begin       
  // upgrade aborted
  Caption := 'Upgrade aborted';
  ProgressBar1.Position := 0;
end;

procedure TForm1.URLLabel1Click(Sender: TObject);
begin                                 
  OpenURL(URLLabel1.Caption, True);
end;

procedure TForm1.URLLabel2Click(Sender: TObject);
begin
  OpenURL(URLLabel2.Caption, True);
end;              

procedure TForm1.AutoUpgraderPro1NoUpdateAvailable(Sender: TObject);
begin
  Caption := 'No Update';
end;

procedure TForm1.AutoUpgraderPro1Progress(Sender: TObject;
  const FileURL: string; FileSize, BytesRead, ElapsedTime,
  EstimatedTimeLeft: Integer; PercentsDone, TotalPercentsDone: Byte;
  TransferRate: Single);
begin
  ProgressBar1.Position := PercentsDone;
end;

end.
