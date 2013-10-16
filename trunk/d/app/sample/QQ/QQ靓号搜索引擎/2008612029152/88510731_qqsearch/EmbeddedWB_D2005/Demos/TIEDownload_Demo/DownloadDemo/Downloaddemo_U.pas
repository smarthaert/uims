unit Downloaddemo_U;

interface

uses
   windows, Dialogs, SysUtils, Classes, Forms, UrlMon, IEDownload, StdCtrls, Controls,
   ComCtrls, OleCtrls, SHDocVw_EWB, EmbeddedWB, IEAddress, ExtCtrls;

type
   TMyRecord = record
      ulProgress: string;
      ElapsedTime: string;
      Speed: string;
      EstimatedTime: string;
      Url: string;
   end;
   PMyRecord = ^TMyRecord;

type
   TForm1 = class(TForm)
      IEDownload1: TIEDownload;
      StatusBar1: TStatusBar;
      Panel1: TPanel;
      Panel2: TPanel;
      btnStart: TButton;
      btnStop: TButton;
      memo1: TMemo;
      memo2: TMemo;
      Label1: TLabel;
      Label2: TLabel;
      IEAddress1: TIEAddress;
      Panel3: TPanel;
      Panel4: TPanel;
      EmbeddedWB1: TEmbeddedWB;
      ListView: TListView;
      ProgressBar1: TProgressBar;
    procedure IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
      ulStatusCode: Cardinal; szStatusText: PWideChar; Downloaded, ElapsedTime,
      Speed, RemainingTime, Status: string);
      function IEDownload1BeginningTransaction(Sender: TBSCB; szURL,
         szHeaders: PWideChar; dwReserved: Cardinal;
         out szAdditionalHeaders: PWideChar): HRESULT;
      procedure IEDownload1BusyStateChange(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure btnStopClick(Sender: TObject);
      procedure IEDownload1ErrorText(Sender: TBSCB; Text: string);
      procedure IEDownload1RespondText(Sender: TBSCB; Text: string);
      procedure IEDownload1StatusText(Sender: TBSCB; Text: string);
      procedure btnStartClick(Sender: TObject);
      procedure IEDownload1Data(Sender: TBSCB; var Buffer: PByte;
         var BufLength: Cardinal);
      procedure IEDownload1Complete(Sender: TBSCB; Stream: TStream;
         Result: HRESULT);
   private
    { Private declarations }
   end;

var
   Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.btnStartClick(Sender: TObject);
begin
   IEDownload1.DownloadUrlToFile(IEAddress1.Text);
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
   IEDownload1.cancel;
end;

procedure TForm1.IEDownload1Data(Sender: TBSCB; var Buffer: PByte;
   var BufLength: Cardinal);    
begin
   memo2.Lines.Add(PChar(Buffer));
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   EmbeddedWB1.AssignEmptyDocument;
end;

function TForm1.IEDownload1BeginningTransaction(Sender: TBSCB; szURL,
   szHeaders: PWideChar; dwReserved: Cardinal;
   out szAdditionalHeaders: PWideChar): HRESULT;
begin
   memo1.Lines.Add('Downloading from:' + IEDownload1.Url);
   Result := S_OK;
end;

procedure TForm1.IEDownload1BusyStateChange(Sender: TObject);
begin
   btnStart.Enabled := not IEDownload1.Busy;
   btnStop.Enabled := IEDownload1.Busy;
end;

procedure TForm1.IEDownload1Complete(Sender: TBSCB; Stream: TStream;
   Result: HRESULT);
begin
   if (Result = S_OK) and (Stream <> nil) then
      begin
        EmbeddedWB1.LoadFromStream(Stream);
        memo1.Lines.Add('Download complete...');
      end
   else
      memo1.Lines.Add(ErrorText(Result) + ' ' + ResponseCodeText(Sender.ResponseCode));
end;

procedure TForm1.IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
  ulStatusCode: Cardinal; szStatusText: PWideChar; Downloaded, ElapsedTime,
  Speed, RemainingTime, Status: string);
   var
   ListItem: TListItem;
   st: string;
begin
   ProgressBar1.Max := ulProgressMax;
   ProgressBar1.Position := ulProgress;
   ListView.Items.BeginUpdate();
   ListItem := ListView.Items.Add();
   ListItem.Caption := IEAddress1.Text;
   ListItem.SubItems.Add(Speed);
   ListItem.SubItems.Add(Downloaded);
   ListItem.SubItems.Add(RemainingTime);
   ListItem.SubItems.Add(ElapsedTime);
   ListItem.SubItems.Add(Status);
   ListView.Items.EndUpdate();
   st := BindStatusText(ulStatusCode);
   if ulStatusCode = BINDSTATUS_DOWNLOADINGDATA then
      begin
         st := st + ' (' + InttoStr(ulProgress) + '/' + IntToStr(ulProgressMax) + ')';
         memo1.Lines.Add(st);
      end;
end;

procedure TForm1.IEDownload1StatusText(Sender: TBSCB; Text: string);
begin
   StatusBar1.Panels[0].Text := 'Status: ' + Text;
end;

procedure TForm1.IEDownload1ErrorText(Sender: TBSCB; Text: string);
begin
   StatusBar1.Panels[1].Text := 'Errors: ' + Text;
end;

procedure TForm1.IEDownload1RespondText(Sender: TBSCB; Text: string);
begin
   StatusBar1.Panels[2].Text := 'Respond: ' + Text;
end;

end.

