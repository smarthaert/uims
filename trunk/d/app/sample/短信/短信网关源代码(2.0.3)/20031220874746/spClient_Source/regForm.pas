unit regForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, inifiles, ShellAPI, ExtCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    BtnNext: TButton;
    Button3: TButton;
    btnPrev: TButton;
    Button2: TButton;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel2: TBevel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    RichEdit2: TRichEdit;
    Bevel1: TBevel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    TabSheet3: TTabSheet;
    Label6: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Edit4: TEdit;
    Label8: TLabel;
    Edit5: TEdit;
    TabSheet4: TTabSheet;
    Edit2: TEdit;
    Label2: TLabel;
    Label9: TLabel;
    lbMobile: TLabel;
    label10: TLabel;
    Edit6: TEdit;
    Label11: TLabel;
    TabSheet5: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Panel3: TPanel;
    Label14: TLabel;
    Edit7: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    btnOk: Boolean;
  end;

var
  Form2: TForm2;

implementation

uses main;

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
  ShellExecute(handle,nil,pchar('http://www.pohoo.com/User/'), nil,nil, sw_shownormal);
end;

procedure TForm2.BtnNextClick(Sender: TObject);
var
  IniFile: TIniFile;

  FileAttrs: Integer;
  sr: TSearchRec;
  ports :integer;
  id, pwd, ip, err : string;

  hDll:THandle;
  GetIP: function: string;
  strDllName,strErrMsg, s: String;
  F: TextFile;
  TT:DWORD;
begin
  btnNext.Caption := '下一步>>';
  case PageControl1.ActivePageIndex of
    0:
    begin
      if (copy(Edit1.Text, 1, 3) > '134') and (copy(Edit1.Text, 1, 3) <= '139')
        and (Length(Edit1.Text)=11) then
      begin
        if not form1.ClientSocket.Active then
        begin
          //Panel3.Caption := '现正在连接短信网关...';
          IniFile := TIniFile.Create('.\spClient.ini');
          ports := IniFile.ReadInteger('configs','ports',8021);
          ip := IniFile.ReadString('configs','ip','211.162.36.89');
          IniFile.Free;

          try
            if form1.ClientSocket.Active then form1.ClientSocket.Close;
            form1.ClientSocket.Address := ip;
            form1.ClientSocket.Port := ports;
            form1.ClientSocket.Host := form1.ClientSocket.Address;
            form1.ClientSocket.Active := True;

            TT:=GetTickCount();
            while (GetTickCount()-TT<8000) and (not form1.ClientSocket.Active) do
              Application.ProcessMessages;
          except
            Panel3.Caption := '连接出错，请确认spClient.INI文件中的IP地址及端口号是否正确！';;
            exit;
          end;
        end;

        if form1.ClientSocket.Active then
        begin
          //Panel3.Caption := '连接成功！';
          if form1.strStep = -1 then
          begin
            form1.SendMsg(Format('Regist Step=1&Mobile=%s', [Edit1.Text]));
            TT:=GetTickCount();
            while (GetTickCount()-TT<8000) and (form1.strStep = -1) do
              Application.ProcessMessages;
          end;
          if (form1.strStep = 1) then
            if (form1.strRegCode = 130) then
            begin
              PageControl1.ActivePageIndex := 4;
              Label14.Visible := True;
              Edit7.Visible := True;
              btnNext.Caption := '完成';
            end else if form1.strRegCode = 0 then
            begin
              PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;
            end
          else PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;
        end else begin
          Panel3.Caption := '连接短信网关失败！请重试。';
        end;

      end else Application.MessageBox('输入的手机号码有误，请您输入中国移动手机用户！', '提示', MB_OK);
    end;
    1:
    begin
      if RadioButton1.Checked then
        PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;
    end;
    2:
    begin
      if (edit3.Text <> '') and (edit4.Text <> '') and (edit5.Text = edit3.Text) then
      begin
        PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;
      end;
    end;
    3:
    begin
      form1.SendMsg(Format('Regist Step=2&Mobile=%s&CheckPwd=%s&UserPwd=%s&User=%s&Email=%s',
                  [Edit1.Text, Edit4.Text, Edit3.Text, Edit2.Text, Edit6.Text]));
      TT:=GetTickCount();
      while (GetTickCount()-TT<8000) and (not (form1.strStep = 2)) do
        Application.ProcessMessages;
      btnNext.Caption := '完成';
      PageControl1.ActivePageIndex := PageControl1.ActivePageIndex +1;
    end;
    4:
    begin
      if ((form1.strStep = 2) and (form1.strRegCode in [141, 0])) then
      begin
        IniFile := TIniFile.Create('.\tcp.ini');
        IniFile.WriteString('configs','id',edit1.text);
        IniFile.WriteString('configs','spwd',edit3.Text);
        IniFile.Free;
        btnOK := True;
        Close;
      end else if ((form1.strStep = 1) and (form1.strRegCode in [130, 0])) then
      begin
        IniFile := TIniFile.Create('.\tcp.ini');
        IniFile.WriteString('configs','id',edit1.text);
        IniFile.WriteString('configs','spwd',edit7.Text);
        IniFile.Free;
        btnOK := True;
        Close;
      end else PageControl1.ActivePage := TabSheet3;
    end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  form1.strStep := -1;
  form1.strRegCode := -1;
  btnOK := False;
end;

procedure TForm2.btnPrevClick(Sender: TObject);
begin
  btnNext.Caption := '下一步>>';
  if PageControl1.ActivePageIndex > 0 then
    if form1.strStep = 1 then
      PageControl1.ActivePageIndex := 0
    else PageControl1.ActivePageIndex := PageControl1.ActivePageIndex -1;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    #13: btnNext.Click;
  end;
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  lbMobile.Caption := Edit1.Text;
  form1.strStep := -1;
  form1.strRegCode := -1;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  form2 := nil;
end;

end.

