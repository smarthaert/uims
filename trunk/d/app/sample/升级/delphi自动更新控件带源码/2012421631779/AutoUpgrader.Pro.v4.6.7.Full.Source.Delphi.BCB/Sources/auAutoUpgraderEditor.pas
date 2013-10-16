{*******************************************************************************

  AutoUpgrader Professional
  FILE: auAutoUpgraderEditor.pas - property editor for auAutoUpgrade component.

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
{$I auDefines.inc}

unit auAutoUpgraderEditor;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, Menus, Graphics,
  ExtCtrls, ComCtrls, SysUtils, Dialogs,
  Registry,
{$IFDEF D4}
  ImgList,
{$ENDIF}

{$IFDEF D6}
  DesignIntf, DesignWindows,
{$ELSE}
  DsgnIntf, DsgnWnds,
{$ENDIF}

  auAutoUpgrader, auExtAssociation;

type
  TauAutoUpgraderEditor = class(TDesignWindow)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DateEdit: TEdit;
    NumberEdit: TEdit;
    Label3: TLabel;
    ByDateRadio: TRadioButton;
    ByNumberRadio: TRadioButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    OKBtn: TButton;
    CancelBtn: TButton;
    ExportBtn: TButton;
    SaveDialog: TSaveDialog;
    AddBtn: TButton;
    DeleteBtn: TButton;
    CheckURLBtn: TButton;
    Panel1: TPanel;
    ImageList: TImageList;
    PopupMenu: TPopupMenu;
    ListView: TListView;
    AddItem: TMenuItem;
    DeleteItem: TMenuItem;
    RenameItem: TMenuItem;
    CheckURLItem: TMenuItem;
    N2: TMenuItem;
    Memo1: TMemo;
    TestBtn: TButton;
    Label6: TLabel;
    ReplaceRadio: TRadioButton;
    SetupRadio: TRadioButton;
    RedirectRadio: TRadioButton;
    procedure ExportBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure TestBtnClick(Sender: TObject);
    procedure ByDateRadioClick(Sender: TObject);
    procedure DateEditExit(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure ListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure CheckURLBtnClick(Sender: TObject);
    procedure RenameItemClick(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
  private
    procedure AddURLToList(URL: String);  
  public
    AutoUpgrader: TauAutoUpgrader;
  end;

{$IFNDEF D4}
type
  IDesigner = TDesigner;
  IFormDesigner = TFormDesigner;
{$ENDIF}

procedure ShowAutoUpgraderDesigner(Designer: IDesigner; AutoUpgrader: TauAutoUpgrader);

implementation

{$R *.DFM}

uses Messages, ClipBrd, auUtils, auAutoUpgraderAddURL, auAutoUpgraderUpgradeMsg;

const
  InfoFileSeparator = '#############################################################';

procedure ShowAutoUpgraderDesigner(Designer: IDesigner; AutoUpgrader: TauAutoUpgrader);
var
  Editor: TauAutoUpgraderEditor;

  function FindEditor(AutoUpgrader: TauAutoUpgrader): TauAutoUpgraderEditor;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to Screen.FormCount - 1 do
     if Screen.Forms[I] is TauAutoUpgraderEditor then
      if TauAutoUpgraderEditor(Screen.Forms[I]).AutoUpgrader = AutoUpgrader then
       begin
        Result := TauAutoUpgraderEditor(Screen.Forms[I]);
        Break;
       end;
  end;

begin
  if AutoUpgrader = nil then Exit;
  Editor := FindEditor(AutoUpgrader);
  if Editor <> nil then
   begin
    Editor.Show;
    if Editor.WindowState = wsMinimized then
      Editor.WindowState := wsNormal;
   end
  else
   begin
    Editor := TauAutoUpgraderEditor.Create(Application);
    try
      {$IFDEF D6}
      Editor.Designer := Designer;
      {$ELSE}
      Editor.Designer := IFormDesigner(Designer);
      {$ENDIF}
      Editor.AutoUpgrader := AutoUpgrader;
      Editor.Show;
    except
      Editor.Free;
      raise;
    end;
  end;
end;

// ---------------------------------------------------
procedure TauAutoUpgraderEditor.ExportBtnClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  TF: TextFile;

  procedure WriteCenterStr(St: String);
  var
    I, BQuote: Integer;
  begin
    BQuote := (Length(InfoFileSeparator) - 2 - Length(St)) div 2;
    Write(TF, '#');
    for I := 1 to BQuote do Write(TF, ' ');
    Write(TF, St);
    for I := 1 to BQuote do Write(TF, ' ');
    if not Odd(Length(St)) then Write(TF, ' ');
    WriteLn(TF, '#');
  end;

  procedure WriteRightStr(St: String);
  var
    I, BQuote: Integer;
  begin
    BQuote := (Length(InfoFileSeparator) - 6 - Length(St));
    Write(TF, '#');
    for I := 1 to BQuote do Write(TF, ' ');
    Write(TF, St);
    WriteLn(TF, '   #');
  end;

begin
  if SaveDialog.Execute then
   try
     AssignFile(TF, SaveDialog.FileName);
     Rewrite(TF);

     WriteLn(TF, InfoFileSeparator);
     WriteCenterStr('Generated by AutoUpgrader Pro at: ' + DateTimeToStr(Now));
     WriteLn(TF, InfoFileSeparator);
     WriteLn(TF);
     WriteLn(TF, '#message={' + Memo1.Text + '}'#13#10);
     I := ListView.Items.Count;
     if I <> 0 then
      for I := 0 to I - 1 do
       begin
        ListItem := ListView.Items[I];
        WriteLn(TF, '#url' + IntToStr(I + 1) + '=' + ListItem.Caption);
       end;

     Write(TF, #13#10'#method=');
     if ReplaceRadio.Checked then
       WriteLn(TF, '0 (self-upgrade)')
     else
       if SetupRadio.Checked then
         WriteLn(TF, '1 (use setup)')
       else
         WriteLn(TF, '2 (redirect)');
     WriteLn(TF);

     if ByDateRadio.Checked then
       WriteLn(TF, '#date=' + DateEdit.Text)
     else
       WriteLn(TF, '#version=' + NumberEdit.Text);

     CloseFile(TF);
   except
   end;
end;

procedure TauAutoUpgraderEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TauAutoUpgraderEditor.AddURLToList(URL: String);
var
  ListItem: TListItem;
begin
  ListItem := ListView.Items.Add;
  ListItem.Caption := URL;
  ListItem.ImageIndex := ImageList.Count;

  with TauExtAssociation.Create(Self) do
   try
     Extension := ExtractFileExt(URL);
     if Extension = '' then Extension := 'autmp'; // anything
     ImageList.AddIcon(SmallIcon);
   except
     Free;
   end; 
end;

procedure TauAutoUpgraderEditor.FormShow(Sender: TObject);
var
  I: Integer;
begin
  ListView.Columns[0].Width := ListView.Width - GetSystemMetrics(SM_CXVSCROLL);
  {$IFDEF D3}
  ListView.RowSelect := True;
  {$ENDIF}

  with AutoUpgrader do
   begin
    DateEdit.Text := VersionDate;
    NumberEdit.Text := VersionNumber;
    with InfoFile do
     begin
      I := Files.Count;
      if I <> 0 then
       for I := 0 to I - 1 do
        AddURLToList(Files[I]);
      Memo1.Text := UpgradeMsg;

      ReplaceRadio.Checked := False;
      SetupRadio.Checked := False;
      RedirectRadio.Checked := False;
      case UpgradeMethod of
        umSelfUpgrade: ReplaceRadio.Checked := True;
        umUseExternalSetup: SetupRadio.Checked := True;
        else RedirectRadio.Checked := True;
       end;
     end;

    if VersionControl = byDate then
     begin
      DateEdit.Enabled := True;
      NumberEdit.Enabled := False;
      DateEdit.Color := clWindow;
      NumberEdit.Color := clBtnFace;
      ByDateRadio.Checked := True;
      ByNumberRadio.Checked := False;
     end
    else
     begin
      DateEdit.Enabled := False;
      NumberEdit.Enabled := True;
      DateEdit.Color := clBtnFace;
      NumberEdit.Color := clWindow;
      ByDateRadio.Checked := False;
      ByNumberRadio.Checked := True;
     end;
   end;
end;

procedure TauAutoUpgraderEditor.OKBtnClick(Sender: TObject);
var
  I: Integer;
begin
  if AutoUpgrader <> nil then
   with AutoUpgrader do
    begin
     VersionDate := DateEdit.Text;
     VersionNumber := NumberEdit.Text;
     with InfoFile do
      begin
       Files.Clear;
       I := ListView.Items.Count;
       if I <> 0 then
        for I := 0 to I - 1 do
         Files.Add(ListView.Items[I].Caption);

       UpgradeMsg := Memo1.Text;

       if ReplaceRadio.Checked then
         UpgradeMethod := umSelfUpgrade
       else
         if SetupRadio.Checked then
           UpgradeMethod := umUseExternalSetup
         else
           UpgradeMethod := umRedirectToURL;
      end;

     if ByDateRadio.Checked then
       VersionControl := byDate
     else
       VersionControl := byNumber;
    end;

  Designer.Modified;
  Close;
end;

procedure TauAutoUpgraderEditor.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TauAutoUpgraderEditor.TestBtnClick(Sender: TObject);
begin
  ShowUpgradeBox(Memo1.Text);
end;

procedure TauAutoUpgraderEditor.ByDateRadioClick(Sender: TObject);
begin
  if ByDateRadio.Checked then
   begin
    DateEdit.Enabled := True;
    NumberEdit.Enabled := False;
    DateEdit.Color := clWindow;
    NumberEdit.Color := clBtnFace;
   end
  else
   begin
    DateEdit.Enabled := False;
    NumberEdit.Enabled := True;
    DateEdit.Color := clBtnFace;
    NumberEdit.Color := clWindow;
   end;
end;


{ sort of spell checking }
procedure TauAutoUpgraderEditor.DateEditExit(Sender: TObject);
var
  I: Integer;
  St: String;
  Valid: Boolean;
  Separators: Byte;
begin
  Valid := True;
  Separators := 0;

  St := DateEdit.Text;
  I := Length(St);
  if I <> 0 then
   for I := 1 to I do
    if ((St[I] < '0') or (St[I] > '9')) and (St[I] <> '/') then
      Valid := False
    else
     if St[I] = '/' then inc(Separators);

  if Separators <> 2 then Valid := False;

  if not Valid then
   begin
    Application.MessageBox('Date format is not valid "MM/DD/YYYY"', 'Invalid date format', mb_Ok or mb_IconExclamation);
    DateEdit.SetFocus;
   end;
end;

procedure TauAutoUpgraderEditor.ListViewChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  DeleteBtn.Enabled := ListView.Selected <> nil;
  DeleteItem.Enabled := DeleteBtn.Enabled;
  RenameItem.Enabled := DeleteBtn.Enabled;
  CheckURLBtn.Enabled := DeleteBtn.Enabled;
  CheckURLItem.Enabled := DeleteBtn.Enabled;
end;

procedure TauAutoUpgraderEditor.AddBtnClick(Sender: TObject);
begin
  with TauAddURLForm.Create(Application) do
   try
     if ShowModal = ID_OK then
       AddURLToList(URLEdit.Text);
   except
     Free;
   end;
end;

procedure TauAutoUpgraderEditor.RenameItemClick(Sender: TObject);
begin
  ListView.Selected.EditCaption;
end;

procedure TauAutoUpgraderEditor.DeleteBtnClick(Sender: TObject);
begin
  if ListView.Selected <> nil then
    ListView.Items.Delete(ListView.Selected.Index);

  if ListView.Items.Count = 0 then
    Imagelist.Clear;  
end;

procedure TauAutoUpgraderEditor.CheckURLBtnClick(Sender: TObject);
begin
  if ListView.Selected <> nil then
    OpenURL(ListView.Selected.Caption, True);
end;

procedure TauAutoUpgraderEditor.ListViewDblClick(Sender: TObject);
begin
  if ListView.Selected <> nil then
   ListView.Selected.EditCaption
end;

end.
