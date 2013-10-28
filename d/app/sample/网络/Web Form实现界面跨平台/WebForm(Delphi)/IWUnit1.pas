unit IWUnit1;
{PUBDIST}

interface

uses
  IWAppForm, IWApplication, IWTypes, IWCompLabel, DB, DBClient,
  IWCompListbox, IWDBStdCtrls, IWCompButton, IWCompEdit, Classes, Controls,
  IWControl, IWGrids,Variants, IWDBGrids;

type
  TformMain = class(TIWAppForm)
    IWDBGrid1: TIWDBGrid;
    edtQryByName: TIWEdit;
    btnQryByName: TIWButton;
    IWDBEdit1: TIWDBEdit;
    IWDBEdit2: TIWDBEdit;
    IWDBComboBox1: TIWDBComboBox;
    IWDBEdit3: TIWDBEdit;
    IWDBEdit4: TIWDBEdit;
    dbcbDep: TIWDBComboBox;
    btnUpdate: TIWButton;
    btnExit: TIWButton;
    DataSource1: TDataSource;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    IWLabel5: TIWLabel;
    IWLabel6: TIWLabel;
    cdsUserMaint: TClientDataSet;
    procedure btnQryByNameClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWDBGrid1Columns0Click(ASender: TObject;
      const AValue: String);
    procedure btnExitClick(Sender: TObject);
  public

  end;

implementation
{$R *.dfm}

uses
  ServerController, udmUser, uUserMaint;

procedure TformMain.btnQryByNameClick(Sender: TObject);
var
  objUsers:TUserMaint;
begin
  objUsers:=TUserMaint.create;
  cdsUserMaint.Data:=objUsers.GetUserList(edtQryByName.Text);
  cdsUserMaint.Active:=true;
  btnUpdate.Enabled:=true;
  objUsers.Free ;
end;

procedure TformMain.btnUpdateClick(Sender: TObject);
var
  objUsers:TUserMaint;
  nErr:Integer;
begin
  objUsers:=TUserMaint.create;
  try
    if cdsUserMaint.State=dsEdit then cdsUserMaint.Post;
    if (cdsUserMaint.ChangeCount > 0) then
    begin
      objUsers.UpdateUserData(cdsUserMaint.Delta,nErr);
      if nErr>0 then
        WebApplication.ShowMessage('更新失败！',smAlert,'操作提示')
      else
      begin
        WebApplication.ShowMessage('更新成功！',smAlert,'操作提示');
        btnQryByNameClick(nil);
      end;
    end;
  finally
    objUsers.Free ;
  end;
end;

procedure TformMain.IWAppFormCreate(Sender: TObject);
var
  objUsers:TUserMaint;
begin
  objUsers:=TUserMaint.create;
  dbcbDep.Items.Assign(objUsers.GetDepList);
  btnUpdate.Enabled:=true;
  objUsers.Free ;
end;

procedure TformMain.IWDBGrid1Columns0Click(ASender: TObject;
  const AValue: String);
begin
  DataSource1.DataSet.Locate('ID',AValue,[]);
end;

procedure TformMain.btnExitClick(Sender: TObject);
begin
  WebApplication.Terminate('感谢使用，再见！');
end;

end.
