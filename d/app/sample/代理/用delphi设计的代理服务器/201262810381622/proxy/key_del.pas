unit key_del;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  Tkeydel = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
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
  keydel: Tkeydel;

implementation

uses main;

{$R *.DFM}

procedure Tkeydel.SpeedButton1Click(Sender: TObject);
begin
    if combobox1.text='' then showmessage('请输入站点的WEB地址')
     else
       if combobox1.Items.IndexOf(combobox1.text)=-1 then
           showmessage('请选择或输入已经存在的地址值！')
           else
              begin
                  combobox1.Items.Delete(combobox1.items.indexof(combobox1.text));
                  combobox1.Items.SaveToFile('nokey.txt');
              end;
    form1.refreshdata;          

end;

procedure Tkeydel.SpeedButton3Click(Sender: TObject);
begin
      close;
end;

procedure Tkeydel.FormShow(Sender: TObject);
begin
             combobox1.Items.LoadFromFile('nokey.txt');

end;

end.
