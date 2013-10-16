unit noweb_add;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tweb_add = class(TForm)
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
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
  web_add: Tweb_add;

implementation

uses main;

{$R *.DFM}

procedure Tweb_add.SpeedButton1Click(Sender: TObject);
begin
     if combobox1.text='' then showmessage('请输入拒绝站点的WEB地址')
     else
       if combobox1.Items.IndexOf(combobox1.text)=-1 then
           begin
              combobox1.Items.Add(combobox1.text);
              combobox1.Items.SaveToFile('noweb.txt');
              combobox1.Items.LoadFromFile('noweb.txt');
           end;
    form1.refreshdata;       
end;

procedure Tweb_add.SpeedButton3Click(Sender: TObject);
begin
      web_add.Close;
end;

procedure Tweb_add.FormShow(Sender: TObject);
begin
          combobox1.Items.LoadFromFile('noweb.txt');

end;

end.
