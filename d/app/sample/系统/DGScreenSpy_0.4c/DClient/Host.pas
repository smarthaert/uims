{*******************************************}
{      DGScreenSpy - Client                 }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************}
unit Host;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmHost = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    edtHost: TEdit;
    edtPort: TEdit;
    rg1: TRadioGroup;
    btnOk: TButton;
    btnCancel: TButton;
  private
  public
  end;

var
  frmHost: TfrmHost;

implementation 
{$R *.dfm}

end.
