{ SDI Embedded Web Browser Demo by bsalsa
 updates: http://www.bsalsa.com/ }
unit frmMain;

interface

uses
  Classes, Controls, Forms, OleCtrls, EmbeddedWB, SHDocVw_EWB, Dialogs,
  StdCtrls, ExtCtrls, Windows, Messages;

type
  TForm1 = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    pnlAddressBar: TPanel;
    edUrl: TEdit;
    btnGo: TButton;
    procedure EmbeddedWB1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure FormShow(Sender: TObject);
    procedure EmbeddedWB1AddressBar(Sender: TObject; AddressBar: WordBool);
    procedure edUrlKeyPress(Sender: TObject; var Key: Char);
    procedure EmbeddedWB1NewWindow3(ASender: TObject;
      var ppDisp: IDispatch; var Cancel: WordBool; dwFlags: Cardinal;
      const bstrUrlContext, bstrUrl: WideString);
    procedure EmbeddedWB1WindowSetHeight(ASender: TObject;
      Height: Integer);
    procedure EmbeddedWB1Move(Sender: TObject; X, Y: Integer);
    procedure EmbeddedWB1Resize(Sender: TObject; Width, Height: Integer);
    procedure btnGoClick(Sender: TObject);
    procedure EmbeddedWB1MoveBy(Sender: TObject; cx, cy: Integer);
    procedure EmbeddedWB1ResizeBy(Sender: TObject; cx, cy: Integer);
    procedure EmbeddedWB1WindowSetLeft(ASender: TObject; Left: Integer);
    procedure EmbeddedWB1WindowSetResizable(ASender: TObject;
      Resizable: WordBool);
    procedure EmbeddedWB1WindowSetWidth(ASender: TObject; Width: Integer);
    procedure FormCreate(Sender: TObject);
    procedure EmbeddedWB1Visible(Sender: TObject; Visible: WordBool);
    procedure EmbeddedWB1WindowSetTop(ASender: TObject; Top: Integer);
  private
    { Private declarations }
    m_Rect: TRect;
    m_bCreatedManually: Boolean;
    m_bResizable: Boolean;
    m_bFullScreen: Boolean;
  protected
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  SysUtils;

const
  SZ_BOOL: array[boolean] of String = ('false', 'true');

var
	iBorderThick,
	iBorderSize,
	iCaptSize: Integer;

procedure TForm1.FormShow(Sender: TObject);
begin
    EmbeddedWB1.Go(edUrl.Text);
end;

procedure TForm1.EmbeddedWB1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
    var Cancel: WordBool);
var
    NewApp: TForm1;
begin
    Application.CreateForm(TForm1, NewApp);
	NewApp.m_bCreatedManually := m_bCreatedManually;
	m_bCreatedManually := False;
    ppdisp := NewApp.EmbeddedWB1.Application;
end;

procedure TForm1.EmbeddedWB1AddressBar(Sender: TObject;
    AddressBar: WordBool);
begin
    pnlAddressBar.Visible := AddressBar;
end;

procedure TForm1.edUrlKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #13) then
    begin
        EmbeddedWB1.Go(edUrl.Text);
        Key := #0;
    end;
end;

procedure TForm1.EmbeddedWB1NewWindow3(ASender: TObject;
    var ppDisp: IDispatch; var Cancel: WordBool; dwFlags: Cardinal;
    const bstrUrlContext, bstrUrl: WideString);
var
    NewApp: TForm1;
begin
    ShowMessage(bstrUrl);
    Application.CreateForm(TForm1, NewApp);
	NewApp.m_bCreatedManually := m_bCreatedManually;
	m_bCreatedManually := False;
    ppdisp := NewApp.EmbeddedWB1.Application;
end;

procedure TForm1.EmbeddedWB1Move(Sender: TObject; X, Y: Integer);
begin
	if (WindowState = wsNormal) then begin
		SetBounds(X, Y, Width, Height);
		OutputDebugString(PChar(Format('Move x:%d, y:%d', [X, Y])));
	end;
end;

procedure TForm1.EmbeddedWB1Resize(Sender: TObject; Width,
    Height: Integer);
begin
	if (WindowState = wsNormal) then begin
		OutputDebugString(PChar(Format('Resize Width:%d, Height:%d', [Width, Height])));
		SetBounds(Left, Top, Width, Height);
	end;
end;

procedure TForm1.btnGoClick(Sender: TObject);
begin
    EmbeddedWB1.Go(edUrl.Text);
end;

procedure TForm1.EmbeddedWB1MoveBy(Sender: TObject; cx, cy: Integer);
begin
	if (WindowState = wsNormal) then begin
		OutputDebugString(PChar(Format('MoveBy cx:%d, cy:%d', [cx, cy])));
		SetBounds(Left + cx, Top + cy, Width, Height);
	end;
end;

procedure TForm1.EmbeddedWB1ResizeBy(Sender: TObject; cx, cy: Integer);
begin
	if (WindowState = wsNormal) then begin
		OutputDebugString(PChar(Format('ResizeBy cx:%d, cy:%d', [cx, cy])));
		SetBounds(Left, Top, Width + cx, Height + cy);
	end;
end;

procedure TForm1.EmbeddedWB1WindowSetLeft(ASender: TObject; Left: Integer);
begin
	OutputDebugString(PChar(Format('SetLeft: %d', [Top])));
	m_Rect.Left := Left;
end;

procedure TForm1.EmbeddedWB1WindowSetTop(ASender: TObject; Top: Integer);
begin
	OutputDebugString(PChar(Format('SetTop: %d', [Top])));
	m_Rect.Top := Top;
end;

procedure TForm1.EmbeddedWB1WindowSetWidth(ASender: TObject;
    Width: Integer);
begin
	OutputDebugString(PChar(Format('SetWidth: %d', [Top])));
	m_Rect.Right := Width;
end;

procedure TForm1.EmbeddedWB1WindowSetHeight(ASender: TObject;
    Height: Integer);
begin
	OutputDebugString(PChar(Format('SetHeight: %d', [Top])));
	m_Rect.Bottom := Height;
end;

procedure TForm1.EmbeddedWB1WindowSetResizable(ASender: TObject;
    Resizable: WordBool);
begin
	OutputDebugString(PChar('SetResizable: ' + SZ_BOOL[Resizable]));
	m_bResizable := Resizable;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    m_Rect := Rect(0, 0, 0, 0);
	m_bResizable := True;
	m_bCreatedManually := False;
	m_bFullScreen := False;
end;

procedure TForm1.EmbeddedWB1Visible(Sender: TObject; Visible: WordBool);
var
	dwClHeight: Integer;
begin
	OutputDebugString(PChar('Visible: ' + SZ_BOOL[Visible]));
	if not m_bCreatedManually {and not m_bFullScreen} then begin
		if m_bResizable then begin
			BorderStyle := bsSizeable;
			BorderIcons := BorderIcons + [biMaximize];
		end
		else begin
			BorderStyle := bsSingle;
			BorderIcons := BorderIcons - [biMaximize];
		end;
	    HandleNeeded;
{
		pnlStatusBar.Visible := m_bStatusBar;
		CoolBar.Bands[0].Visible := m_bToolBar;
		if m_bAddressBar then
			CoolBar.Bands.FindBand(tbAddress).Break := m_bToolBar;
		CoolBar.Bands[2].Visible := m_bAddressBar;
		CoolBar.Visible := m_bToolBar or m_bAddressBar;
		pnlSep.Visible := CoolBar.Visible;
}
		if (m_Rect.Right > 0) and (m_Rect.Bottom > 0) then begin
			dwClHeight := 0;

			if pnlAddressBar.Visible then
				dwClHeight := pnlAddressBar.Height;

//			if m_bStatusBar then
//				dwClHeight := dwClHeight + pnlStatusBar.Height;

			m_Rect.Bottom := (iBorderSize + iBorderThick) * 2 + iCaptSize + dwClHeight + m_Rect.Bottom;
			m_Rect.Right := (iBorderSize + iBorderThick) * 2 +  m_Rect.Right;

			if m_bResizable then begin
				inc(m_Rect.Bottom, 2);
				inc(m_Rect.Right, 2);
			end;

			SetBounds(m_Rect.Left, m_Rect.Top, m_Rect.Right, m_Rect.Bottom);
		end;

		if m_bFullScreen then
			WindowState := wsMaximized;

	end
	else
		m_bCreatedManually := False;

	Self.Visible := Visible;
end;

initialization
	iCaptSize := GetSystemMetrics(SM_CYCAPTION);
	iBorderSize := GetSystemMetrics(SM_CXBORDER);
	iBorderThick := GetSystemMetrics(SM_CXSIZEFRAME);
end.
