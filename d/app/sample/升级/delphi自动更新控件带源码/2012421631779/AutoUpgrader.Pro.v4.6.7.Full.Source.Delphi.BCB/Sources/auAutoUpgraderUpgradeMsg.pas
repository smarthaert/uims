{*******************************************************************************

  AutoUpgrader Professional
  FILE: auAutoUpgraderUpgradeMsg.pas - Upgrade Request form

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
unit auAutoUpgraderUpgradeMsg;

interface

uses
  Windows, Classes, Controls, Forms, ExtCtrls, StdCtrls,
  auAutoUpgrader;

type
  TauAutoUpgraderUpgradeMessageForm = class(TForm)
    BottomPanel: TPanel;
    YesBtn: TButton;
    LaterBtn: TButton;
    Label1: TLabel;
    Icon: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
  end;

var
  UpgradeMessageForm: TauAutoUpgraderUpgradeMessageForm = nil;

function ShowUpgradeBox(Msg: String): Boolean;

implementation

{$R *.DFM}

uses SysUtils;

function ShowUpgradeBox(Msg: String): Boolean;
var
  auProgramTitle: String;
begin
  auProgramTitle := Application.Title;
  { kludge for program title at design-time.
    next two lines may be commented. }
  if Pos(LoadStr(auDelphiStr), auProgramTitle) <> 0 then
    auProgramTitle := LoadStr(auAppTitle);

  { creating THIS form }
  if UpgradeMessageForm = nil then
    UpgradeMessageForm := TauAutoUpgraderUpgradeMessageForm.Create(Application);
  with UpgradeMessageForm do
   begin
    {** Loading resources **}
    if Msg <> '' then Msg := #10 + Msg + #10;
    Label1.Width := Width - Label1.Left - 11;
    Label1.Caption := AUFmtLangStr(auWelcome, [auProgramTitle, Msg]);

    Caption := AULangStr(auWizardTitle);
    YesBtn.Caption := AULangStr(auYes);
    LaterBtn.Caption := AULangStr(auLater);
    {***********************}
    
    { fix form height }
    UpgradeMessageForm.ClientHeight := Label1.Top + Label1.Height + BottomPanel.Height;

    Result := ShowModal = ID_YES;
   end;
end;

procedure TauAutoUpgraderUpgradeMessageForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    ExStyle := ExStyle or WS_EX_TOPMOST;;
end;

procedure TauAutoUpgraderUpgradeMessageForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  UpgradeMessageForm := nil;
end;

procedure TauAutoUpgraderUpgradeMessageForm.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE)
end;

end.
