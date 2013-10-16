{*******************************************************************************

  AutoUpgrader Professional
  FILE: auAutoUpgraderWizard.pas - Application Update Wizard form

  Copyright (c) 1999-2004 UtilMind Solutions
  All rights reserved.
  E-Mail: info@utilmind.com
  WWW: http://www.utilmind.com, http://www.appcontrols.com

  The entire contents of this file is protected by International Copyright
Laws. Unauthorized reproduction, reverse-engineering, and distribution of all
or any portion of the code contained in this file is strictly prohibited and
may result in severe civil and criminal penalties and will be prosecuted to
the maximum extent possible under the law.

*******************************************************************************}
unit auAutoUpgraderWizard;

interface

uses
  Messages, Classes, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls, 
  auAutoUpgrader, Graphics;

type
  TauAutoUpgraderWizardForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Bevel1: TBevel;
    WizardTitle: TLabel;
    LCurrentFile: TGroupBox;
    LAllFiles: TGroupBox;
    LDownloadingFileFrom: TLabel;
    LEstimatedTime: TLabel;
    LTransferRate: TLabel;
    ProgressCurrentFile: TProgressBar;
    ProgressAllFiles: TProgressBar;
    FinishBtn: TButton;
    CancelBtn: TButton;
    AllDownloading: TLabel;
    AboutShadow: TLabel;
    AboutLabel: TLabel;
    FileURL: TEdit;
    AfterNote: TLabel;
    LFileSize: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);    
    procedure FileURLKeyPress(Sender: TObject; var Key: Char);
    procedure FinishBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  protected
  private
    AutoUpgrader: TauAutoUpgrader;

    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;    
  public
    procedure Finish;
  end;

var
  WizardForm: TauAutoUpgraderWizardForm = nil;

procedure ShowAutoUpgraderWizard(aAutoUpgrader: TauAutoUpgrader);

implementation

{$R *.DFM}

uses Windows, SysUtils, auUtils;

type
  TauAutoUpgraderHack = class(TauAutoUpgrader)
  end;

procedure ShowAutoUpgraderWizard(aAutoUpgrader: TauAutoUpgrader);
begin
  { creating THIS form }
  if WizardForm = nil then
    WizardForm := TauAutoUpgraderWizardForm.Create(Application);
  with WizardForm do
   begin
    AutoUpgrader := aAutoUpgrader;

    { Component identifier }
    AboutLabel.Caption := #32 + LoadStr(auAutoUpgraderStr) + #32;
    AboutShadow.Caption := AboutLabel.Caption;

    {** Loading resources **}
    with AutoUpgrader do
     begin
      { stay on top flag }
      if Wizard.StayOnTop then
        SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);

      if Wizard.HideFileLocation then
       begin
        FileURL.Visible := False;
        LDownloadingFileFrom.Visible := False;
        LFileSize.Top := LDownloadingFileFrom.Top;
        LTransferRate.Top := LFileSize.Top + 16;
        LEstimatedTime.Top := LTransferRate.Top + 16;
        ProgressCurrentFile.Top := LEstimatedTime.Top + 20;
        LCurrentFile.Top := LCurrentFile.Top + 10;
        LCurrentFile.Height := LCurrentFile.Height - 30; 
       end;

      with Wizard, Pic118x218 do
       if Assigned(Graphic) and not Graphic.Empty then
        Image1.Picture.Assign(Pic118x218);
     end;

    { Preparing. . .}
    LEstimatedTime.Caption := AULangStr(auPreparing);

    Caption := AULangStr(auWizardTitle);
    WizardTitle.Caption := AULangStr(auDownloadingFiles);
    LCurrentFile.Caption := ' ' + AULangStr(auCurrentFile) + ' ';
    LAllFiles.Caption := ' ' + AULangStr(auAllFiles) + ' ';
    LDownloadingFileFrom.Caption := AULangStr(auDownloadingFrom);
    FinishBtn.Caption := AULangStr(auNext);
    CancelBtn.Caption := AULangStr(auCancel);
    {***********************}

    Show;
   end;
end;

procedure TauAutoUpgraderWizardForm.WMSysCommand(var Message: TWMSysCommand);
begin
  if Message.CmdType = SC_CLOSE then
    if Application.MessageBox(PChar(AULangStr(auInterrupt)), PChar(Application.Title), MB_YESNO or MB_ICONQUESTION) = ID_YES then
     begin
      inherited;
      AutoUpgrader.Abort(False);
     end
    else
  else
    inherited;
end;

procedure TauAutoUpgraderWizardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  WizardForm := nil;
  StopWait(TauAutoUpgraderHack(AutoUpgrader).FWaitHandle);  
end;

procedure TauAutoUpgraderWizardForm.FileURLKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TauAutoUpgraderWizardForm.FinishBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TauAutoUpgraderWizardForm.CancelBtnClick(Sender: TObject);
begin
  PostMessage(Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
end;

procedure TauAutoUpgraderWizardForm.Finish;
begin
  WizardTitle.Caption := AULangStr(auUpdateCompleted);

  AfterNote.Caption := AUFmtLangStr(auSuccessUpdate, [Application.Title]);
  AfterNote.AutoSize := True;
  LCurrentFile.Visible := False;
  LAllFiles.Visible := False;

  CancelBtn.Enabled := False;
  FinishBtn.Caption := AULangStr(auOK);
  FinishBtn.Enabled := True;
  FinishBtn.SetFocus;
end;

end.
