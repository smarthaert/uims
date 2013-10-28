{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


Unit:         Remote Access Service Dialer (RAS-DIALER)
Creation:     Feb 18, 1997.
EMail:        francois.piette@pophost.eunet.be    francois.piette@rtfm.be
              http://www.rtfm.be/fpiette
Legal issues: Copyright (C) 1996, 1997, 1998 by François PIETTE
              Rue de Grady 24, 4053 Embourg, Belgium. Fax: +32-4-365.74.56
              <francois.piette@pophost.eunet.be>

              This software is provided 'as-is', without any express or
              implied warranty.  In no event will the author be held liable
              for any  damages arising from the use of this software.

              Permission is granted to anyone to use this software for any
              purpose, including commercial applications, and to alter it
              and redistribute it freely, subject to the following
              restrictions:

              1. The origin of this software must not be misrepresented,
                 you must not claim that you wrote the original software.
                 If you use this software in a product, an acknowledgment
                 in the product documentation would be appreciated but is
                 not required.

              2. Altered source versions must be plainly marked as such, and
                 must not be misrepresented as being the original software.

              3. This notice may not be removed or altered from any source
                 distribution.
Updates:
Sep 25, 1998  V1.10  Corrected a problem remated to the way Delphi can
              handle unsigned numbers.


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Formauto, StdCtrls, ExtCtrls;

type
  TAboutForm = class(TAutoForm)
    Image1: TImage;
    ProgNameLabel: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Image2: TImage;
    Label1: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.DFM}

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TAboutForm.Button1Click(Sender: TObject);
begin
    Close;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TAboutForm.Image1DblClick(Sender: TObject);
var
    State : DWORD;
begin
    State := DWORD(GetKeyState(VK_MENU));

    if (State and $8000) = 0 then
        Exit;

    ProgNameLabel.Visible := FALSE;
    Label1.Visible        := FALSE;
    Label2.Visible        := FALSE;
    Label3.Visible        := FALSE;
    Label4.Visible        := FALSE;
    Image2.Width          := 75;
    Image2.Height         := 100;
    Image2.Left           := (ClientWidth - Image2.Width) div 2;
    Image2.Top            := Image1.Top;
    Image2.Visible        := TRUE;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TAboutForm.FormShow(Sender: TObject);
begin
    inherited;
    ProgNameLabel.Visible := TRUE;
    Label1.Visible        := TRUE;
    Label2.Visible        := TRUE;
    Label3.Visible        := TRUE;
    Label4.Visible        := TRUE;
    Image2.Visible        := FALSE;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
