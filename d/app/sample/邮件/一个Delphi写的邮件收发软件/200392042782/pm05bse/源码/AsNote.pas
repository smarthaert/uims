{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}
unit AsNote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, Buttons, DB, ADODB, Menus;

type
  TfmAsN = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ToolButton2: TToolButton;
    SpeedButton5: TSpeedButton;
    GroupBox1: TGroupBox;
    lvAddress: TListView;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    labFromName: TLabel;
    labFormAddress: TLabel;
    adoqAsN: TADOQuery;
    btnInsertTo: TButton;
    btnInserCTo: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure lvAddressClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure btnInsertToClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btnInserCToClick(Sender: TObject);
    procedure UpdatelvAddress(Sender:TObject);
    procedure adoqAsNQuery(target:string);
    procedure isAddressSelected(Selected:boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAsN: TfmAsN;

implementation

uses main, addNewAs, asSet, Send, chUser;

{$R *.dfm}

procedure TfmAsN.FormCreate(Sender: TObject);
{var
        itm:TlistItem;
        i:integer;}
begin
        adoqAsN.Connection:=fmMain.adocPm;

        fmAsN.UpdatelvAddress(Sender);

        isAddressSelected(false);
        SpeedButton5.Enabled:=true;
        N1.Enabled:=true;

        {adoqAsN.Close;
        adoqAsN.SQL.Clear;
        adoqAsN.SQL.Text:='select * from AddressNote';
        adoqAsN.Open;

        if adoqAsN.RecordCount>0 then
        begin
                lvAddress.Clear;
                for  i:=0 to adoqAsN.RecordCount-1 do
                begin
                        itm:=lvAddress.Items.Add;
                        itm.ImageIndex:=2;
                        itm.Caption:=adoqAsN.Fields.Fields[0].AsString;
                        itm.SubItems.Add(adoqAsN.Fields.Fields[1].AsString);
                        //itm.SubItems.Add(fmMain.adoqAsN.Fields.Fields[1].AsString);
                        //itm.SubItems.Add(fmMain.adoqAsN.Fields[4].AsString);

                        adoqAsN.Next;
                end;
        end;
        adoqAsN.Close;}

end;

procedure TfmAsN.lvAddressClick(Sender: TObject);
begin
        if lvAddress.Selected<>nil  then
        begin
                isAddressSelected(true);
                labFromName.Caption:='';
                labFormAddress.Caption:='';
                labFromName.Caption:=lvAddress.Selected.Caption;
                labFormAddress.Caption:=lvAddress.Selected.SubItems.Strings[0];
        end
        else
        begin
             isAddressSelected(false);
        end;

end;

procedure TfmAsN.SpeedButton5Click(Sender: TObject);
begin
        Application.CreateForm(TfmAddNewAs,fmAddNewAs);
        fmAddNewAs.ShowModal;
end;

procedure TfmAsN.SpeedButton1Click(Sender: TObject);
begin
        Application.CreateForm(TfmAsSet,fmAsSet);
        fmAsSet.ShowModal;
end;

procedure TfmAsN.SpeedButton2Click(Sender: TObject);
{var
        temp:string; }
begin
        if lvAddress.Selected<>nil then
        begin
                //temp:=lvAddress.Selected.SubItems.Text;

                with adoqAsN do
                begin
                        Close;
                        SQL.Clear;
                        sql.Add('Delete from AddressNote where FromAddress='''+trim(lvAddress.Selected.SubItems.Strings[0])+'''');            //一定要用trim(lvAddress.Selected.SubItems.Text)将其中的空格,控制符去掉，因为lvAddress.Selected.SubItems.Text已经被我指定的宽度,有空格再所难免!否则删除不了记录是肯定的，因为根本就找不到。
                        //Parameters.ParamByName('FromAddress').Value:=temp;
                        //Prepared;
                        ExecSQL;
                        {Edit;
                        Delete;
                        Post;}
                        Close;
                end;

                {adoqAsN.Close;
                adoqAsN.SQL.Clear;
                adoqAsN.SQL.Text:='Delete from AddressNote where FromAddress='''+temp+'''';
                adoqAsN.ExecSQL;
                //adoqAsN.Active:=true;
               //adoqAsN.Edit;
               //adoqAsN.Delete;
               //adoqAsN.Post;
               adoqAsN.Close;}

                lvAddress.DeleteSelected;
                lvAddress.Update;

                {lvAddress.Clear;
                fmAsN.UpdatelvAddress(Sender);}

                labFromName.Caption:='';
                labFormAddress.Caption:='';

        end;
end;

procedure TfmAsN.SpeedButton4Click(Sender: TObject);
begin
        close;
end;

procedure TfmAsN.btnInsertToClick(Sender: TObject);
begin
        if lvAddress.Selected<>nil then
        begin
                fmSend.edtToAddress.Text:=trim(lvAddress.Selected.SubItems.Strings[0]);

                btnInsertTo.Visible:=false;
                fmAsN.Close;

        end;

end;

procedure TfmAsN.SpeedButton3Click(Sender: TObject);
begin
        if lvAddress.Selected <> nil then
        begin
                Application.CreateForm(TfmChangeUser,fmChangeUser);

                fmChangeUser.ShowModal;
        end;
end;

procedure TfmAsN.btnInserCToClick(Sender: TObject);
begin
      if lvAddress.Selected<>nil then
        begin
                fmSend.edtCToAddress.Text:=trim(lvAddress.Selected.SubItems.Strings[0]);

                btnInsertTo.Visible:=false;
                fmAsN.Close;

        end;
end;

procedure TfmAsN.UpdatelvAddress(Sender:TObject);
var
        itm:TlistItem;
        i:integer;
begin
        fmAsN.adoqAsN.Close;
        fmAsN.adoqAsN.SQL.Clear;
        fmAsN.adoqAsN.SQL.Text:='select * from AddressNote ';
        fmAsN.adoqAsN.Open;
        if fmAsN.adoqAsN.RecordCount>0 then
        begin
                for i:=0 to fmAsN.adoqAsN.RecordCount-1 do
                begin
                        itm:= fmAsN.lvAddress.Items.Add;
                        itm.ImageIndex:=2;
                        itm.Caption:=fmAsN.adoqAsN.Fields.Fields[0].AsString;
                        itm.SubItems.Add( fmAsN.adoqAsN.Fields.Fields[1].AsString);
                        //itm.SubItems.Add(fmMain.adoqAsN.Fields.Fields[1].AsString);
                        //itm.SubItems.Add(fmMain.adoqAsN.Fields[4].AsString);

                         fmAsN.adoqAsN.Next;
                end;
                 fmAsN.adoqAsN.Close;
        end;

       fmAsN.adoqAsN.Close;
end;


procedure TfmAsN.adoqAsNQuery(target:string);
begin
        fmAsN.adoqAsN.Close;
        fmAsN.adoqAsN.SQL.Clear;
        fmAsN.adoqAsN.SQL.Text:='select * from AddressNote where FromAddress='''+trim(target)+'''';
        fmAsN.adoqAsN.Open;
end;

procedure TfmAsN.isAddressSelected(Selected:boolean);
begin
        SpeedButton1.Enabled:=Selected;
        SpeedButton2.Enabled:=Selected;
        SpeedButton3.Enabled:=Selected;
        //SpeedButton4.Enabled:=Selected;
        SpeedButton5.Enabled:=Selected;
        N1.Enabled:=Selected;
        N2.Enabled:=Selected;
        N3.Enabled:=Selected;

        N5.Enabled:=Selected;

end;

end.
