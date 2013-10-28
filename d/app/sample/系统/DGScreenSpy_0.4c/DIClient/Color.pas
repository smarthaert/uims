{*******************************************}
{      DGScreenSpy - Client                 }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************}
unit Color;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmColor = class(TForm)
    rg1: TRadioGroup;
    btnOk: TButton;
    btnCancel: TButton;
  private
  public
  end;

var
  frmColor: TfrmColor;

implementation  
{$R *.dfm}

end.
