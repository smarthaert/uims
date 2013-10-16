{*******************************************************************************

  AutoUpgrader Professional
  FILE: auAutoUpgraderPassword.pas - Password Request form

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
unit auAutoUpgraderPassword;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls,
  ExtCtrls, auAutoUpgrader, Graphics;

type
  TauAutoUpgraderPasswordForm = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    BottomPanel: TPanel;
    UsernameLab: TLabel;
    PasswordLab: TLabel;
    UsernameEdit: TEdit;
    PasswordEdit: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
  private
    AutoUpgrader: TauAutoUpgrader;
  public
  end;

var
  PasswordForm: TauAutoUpgraderPasswordForm = nil;

function ShowPasswordBox(aAutoUpgrader: TauAutoUpgrader; FileName: String): Boolean;

implementation

{$R *.DFM}

function ShowPasswordBox(aAutoUpgrader: TauAutoUpgrader; FileName: String): Boolean;
begin
  { creating THIS form }
  if PasswordForm = nil then
    PasswordForm := TauAutoUpgraderPasswordForm.Create(Application);
  with PasswordForm do
   begin
    AutoUpgrader := aAutoUpgrader;

    {** Loading resources **}
    with AutoUpgrader do
     begin
      Label1.Width := ClientWidth - Label1.Left - 18;
      Label1.Caption := AUFmtLangStr(auPasswordRequired, [FileName]);

      Caption := AULangStr(auEnterPassword);
      UsernameLab.Caption := AULangStr(auUsername);
      UsernameEdit.Text := HTTPUsername; { auto-fill username }
      PasswordLab.Caption := AULangStr(auPassword);
      OKBtn.Caption := AULangStr(auOK);
      CancelBtn.Caption := AULangStr(auCancel);
     end;
    {***********************}
    
    { fix form height }
    PasswordForm.ClientHeight := Label1.Top + Label1.Height + BottomPanel.Height;

    Result := ShowModal = ID_OK;
   end;
end;

procedure TauAutoUpgraderPasswordForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  PasswordForm := nil;
end;

procedure TauAutoUpgraderPasswordForm.OKBtnClick(Sender: TObject);
begin
  with AutoUpgrader do
   begin
    HTTPUsername := UsernameEdit.Text;
    HTTPPassword := PasswordEdit.Text;
   end; 
end;

end.
