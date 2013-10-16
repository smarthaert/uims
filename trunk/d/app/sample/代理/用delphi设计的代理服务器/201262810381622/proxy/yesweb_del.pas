unit yesweb_del;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  Tyeswebdel = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  yeswebdel: Tyeswebdel;

implementation

uses main;

{$R *.DFM}

procedure Tyeswebdel.SpeedButton1Click(Sender: TObject);
begin
    if combobox1.text='' then showmessage('请输入允许站点的WEB地址')
     else
       if combobox1.Items.IndexOf(combobox1.text)=-1 then
           showmessage('请选择或输入已经存在的地址值！')
           else
              begin
                  combobox1.Items.Delete(combobox1.items.indexof(combobox1.text));
                  combobox1.Items.SaveToFile('yesweb.txt');
              end;
    form1.refreshdata;

end;

procedure Tyeswebdel.SpeedButton3Click(Sender: TObject);
begin
      close;
end;

procedure Tyeswebdel.FormShow(Sender: TObject);
begin
           combobox1.Items.LoadFromFile('yesweb.txt');

end;

end.
