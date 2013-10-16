unit key_add;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  Tkeyadd = class(TForm)
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
  keyadd: Tkeyadd;

implementation

uses main;

{$R *.DFM}

procedure Tkeyadd.SpeedButton1Click(Sender: TObject);
begin
     if combobox1.text='' then showmessage('请输入拒绝站点的WEB地址')
     else
       if combobox1.Items.IndexOf(combobox1.text)=-1 then
           begin
              combobox1.Items.Add(combobox1.text);
              combobox1.Items.SaveToFile('nokey.txt');
              combobox1.Items.LoadFromFile('nokey.txt');
           end;
    form1.refreshdata;

end;

procedure Tkeyadd.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

procedure Tkeyadd.FormShow(Sender: TObject);
begin
          combobox1.Items.LoadFromFile('nokey.txt');

end;

end.
