unit Query;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, AdvGrid, StdCtrls, EditNew, Buttons, Db, DBTables,
  DrLabel, Menus, ComCtrls, AdvProgr, Gauges;

type
  TFrmQuery = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    sgFPJB: TAdvStringGrid;
    cbQYBM: TCheckBox;
    cbFPDM: TCheckBox;
    cbFPHM: TCheckBox;
    cbSWDM: TCheckBox;
    cbJX: TCheckBox;
    cbSSSQ: TCheckBox;
    EdtQYBM: TEditN;
    EdtFPDM: TEditN;
    EdtFPHM: TEditN;
    EdtSWDM: TEditN;
    EdtSSSQ: TEditN;
    CmbJX: TComboBox;
    BBtnQuery: TBitBtn;
    BBtnPrint: TBitBtn;
    BBtnBack: TBitBtn;
    Panel3: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    EdtTitle: TEditN;
    cbTitle: TCheckBox;
    BBtnSave: TBitBtn;
    cbSaveToFile: TCheckBox;
    CmbFileType: TComboBox;
    EdtFPHM2: TEditN;
    DRLabel1: TDRLabel;
    BBtnAppend: TBitBtn;
    OpenDialog1: TOpenDialog;
    Gauge1: TGauge;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure cbQYBMClick(Sender: TObject);
    procedure cbFPDMClick(Sender: TObject);
    procedure cbFPHMClick(Sender: TObject);
    procedure cbSWDMClick(Sender: TObject);
    procedure cbJXClick(Sender: TObject);
    procedure cbSSSQClick(Sender: TObject);
    procedure BBtnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BBtnQueryClick(Sender: TObject);
    procedure EdtQYBMKeyPress(Sender: TObject; var Key: Char);
    procedure sgFPJBGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure sgFPJBGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var AAlignment: TAlignment);
    procedure CheckBox1Click(Sender: TObject);
    procedure cbTitleClick(Sender: TObject);
    procedure BBtnPrintClick(Sender: TObject);
    procedure sgFPJBRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure BBtnSaveClick(Sender: TObject);
    procedure cbSaveToFileClick(Sender: TObject);
    procedure BBtnAppendClick(Sender: TObject);
  private
    TmpQuery: TQuery;
    procedure SwitchEdit;
    procedure DateQuery;
    function IIF(bCondition: Boolean; sValue1, sValue2: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQuery: TFrmQuery;

implementation

uses ClassJX, GlbVar;

{$R *.DFM}

function TFrmQuery.IIF(bCondition: Boolean; sValue1, sValue2: string): string;
begin
  if bCondition then
    Result := sValue1
  else
    Result := sValue2;
end;

procedure TFrmQuery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmQuery.SwitchEdit;
begin
  EdtQYBM.Enabled := cbQYBM.Checked;

  EdtFPDM.Enabled := cbFPDM.Checked;

  EdtFPHM.Enabled := cbFPHM.Checked;
  EdtFPHM2.Enabled := cbFPHM.Checked;

  EdtSWDM.Enabled := cbSWDM.Checked;

  CmbJX.Enabled := cbJX.Checked;

  EdtSSSQ.Enabled := cbSSSQ.Checked;

  EdtTitle.Enabled := cbTitle.Checked;
  BBtnPrint.Enabled := cbTitle.Checked;

  CmbFileType.Enabled := cbSaveToFile.Checked;
  BBtnSave.Enabled := cbSaveToFile.Checked;
end;

procedure TFrmQuery.FormActivate(Sender: TObject);
begin
  SwitchEdit;
end;

procedure TFrmQuery.cbQYBMClick(Sender: TObject);
begin
  SwitchEdit;
  if EdtQYBM.Enabled then
    EdtQYBM.SetFocus;
end;

procedure TFrmQuery.cbFPDMClick(Sender: TObject);
begin
  SwitchEdit;
  if EdtFPDM.Enabled then
    EdtFPDM.SetFocus;
end;

procedure TFrmQuery.cbFPHMClick(Sender: TObject);
begin
  SwitchEdit;
  if EdtFPHM.Enabled then
    EdtFPHM.SetFocus;
end;

procedure TFrmQuery.cbSWDMClick(Sender: TObject);
begin
  SwitchEdit;
  if EdtSWDM.Enabled then
    EdtSWDM.SetFocus;
end;

procedure TFrmQuery.cbJXClick(Sender: TObject);
begin
  SwitchEdit;
  if CmbJX.Enabled then
    CmbJX.SetFocus;
end;

procedure TFrmQuery.cbSSSQClick(Sender: TObject);
begin
  SwitchEdit;
  if EdtSSSQ.Enabled then
    EdtSSSQ.SetFocus;
end;

procedure TFrmQuery.BBtnBackClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmQuery.DateQuery;
var
  I: Integer;
  sQYBM: string;
  SubTotalXSE, SubTotalSE, TotalXSE, TotalSE: Currency;
begin
  SubTotalXSE := 0;
  SubTotalSE := 0;
  TotalXSE := 0;
  TotalSE := 0;
  try
    try
      I := 1;
      sgFPJB.ClearNormalCells;
      sgFPJB.RowCount := 2;

      TmpQuery.Close;
      TmpQuery.SQL.Clear;
      TmpQuery.SQL.Add('SELECT * FROM FPJB8.DBF WHERE 1=1');
      if cbQYBM.Checked then
        TmpQuery.SQL.Add('AND QYBM="' + EdtQYBM.Text + '"');
      if cbFPDM.Checked then
        TmpQuery.SQL.Add('AND FPDM="' + EdtFPDM.Text + '"');
      if cbFPHM.Checked then
        TmpQuery.SQL.Add('AND (FPHM BETWEEN "' + EdtFPHM.Text + '" AND "' + EdtFPHM2.Text + '")');
      if cbSWDM.Checked then
        TmpQuery.SQL.Add('AND SWDM="' + EdtSWDM.Text + '"');
      if cbJX.Checked then
        TmpQuery.SQL.Add('AND J_X="' + IIF(CmbJX.ItemIndex = 0, 'J', 'X') + '"');
      if cbSSSQ.Checked then
        TmpQuery.SQL.Add('AND SSSQ="' + FormatDateTime('YYYYMM', EdtSSSQ.ValueDate) + '"');
      TmpQuery.SQL.Add('ORDER BY QYBM');
      TmpQuery.Open;
      TmpQuery.First;
      sQYBM := TmpQuery.FieldByName('QYBM').AsString;
      Gauge1.Visible := True;
      Gauge1.MaxValue := TmpQuery.RecordCount;
      Screen.Cursor := crHourGlass;
      while not TmpQuery.Eof do
      begin
        Gauge1.Progress := Gauge1.Progress + 1;
        sgFPJB.RowCount := sgFPJB.RowCount + 1;
        sgFPJB.Cells[0, I] := TmpQuery.FieldByName('QYBM').AsString;
        sgFPJB.Cells[1, I] := TmpQuery.FieldByName('FPZL').AsString;
        sgFPJB.Cells[2, I] := TmpQuery.FieldByName('FPDM').AsString;
        sgFPJB.Cells[3, I] := TmpQuery.FieldByName('FPHM').AsString;
        sgFPJB.Cells[4, I] := TmpQuery.FieldByName('SWDM').AsString;
        sgFPJB.Cells[5, I] := TmpQuery.FieldByName('J_X').AsString;
        sgFPJB.Cells[6, I] := TmpQuery.FieldByName('SSSQ').AsString;
        sgFPJB.Cells[7, I] := FormatFloat('#,##0.00', TmpQuery.FieldByName('XSE').AsCurrency);
        sgFPJB.Cells[8, I] := TmpQuery.FieldByName('SL').AsString;
        sgFPJB.Cells[9, I] := FormatFloat('#,##0.00', TmpQuery.FieldByName('SE').AsCurrency);
        sgFPJB.Cells[10, I] := FormatDateTime('YYYY-MM-DD', TmpQuery.FieldByName('KPRQ').AsDateTime);
        sgFPJB.Cells[11, I] := FormatDateTime('YYYY-MM-DD', TmpQuery.FieldByName('RQ').AsDateTime);
        sgFPJB.Cells[12, I] := TmpQuery.FieldByName('XM').AsString;
        TotalXSE := TotalXSE + TmpQuery.FieldByName('XSE').AsCurrency;
        TotalSE := TotalSE + TmpQuery.FieldByName('SE').AsCurrency;
        SubTotalXSE := SubTotalXSE + TmpQuery.FieldByName('XSE').AsCurrency;
        SubTotalSE := SubTotalSE + TmpQuery.FieldByName('SE').AsCurrency;
        Inc(I);
        TmpQuery.Next;
        if Trim(sQYBM) <> Trim(TmpQuery.FieldByName('QYBM').AsString) then
        begin
          sQYBM := TmpQuery.FieldByName('QYBM').AsString;
          sgFPJB.RowCount := sgFPJB.RowCount + 1;
          sgFPJB.Cells[0, I] := '小计';
          sgFPJB.Cells[7, I] := FormatFloat('#,##0.00', SubTotalXSE);
          sgFPJB.Cells[9, I] := FormatFloat('#,##0.00', SubTotalSE);
          SubTotalXSE := 0.00;
          SubTotalSE := 0.00;
          Inc(I);
        end;
      end;

      sgFPJB.RowCount := sgFPJB.RowCount + 1;

      sgFPJB.Cells[0, sgFPJB.RowCount - 2] := '小计';
      sgFPJB.Cells[7, sgFPJB.RowCount - 2] := FormatFloat('#,##0.00', SubTotalXSE);
      sgFPJB.Cells[9, sgFPJB.RowCount - 2] := FormatFloat('#,##0.00', SubTotalSE);

      sgFPJB.Cells[0, sgFPJB.RowCount - 1] := '合计';
      sgFPJB.Cells[7, sgFPJB.RowCount - 1] := FormatFloat('#,##0.00', TotalXSE);
      sgFPJB.Cells[9, sgFPJB.RowCount - 1] := FormatFloat('#,##0.00', TotalSE);

      sgFPJB.AutoSizeCol(0);
      sgFPJB.AutoSizeCol(1);
      sgFPJB.AutoSizeCol(2);
      sgFPJB.AutoSizeCol(3);
      sgFPJB.AutoSizeCol(4);
      sgFPJB.AutoSizeCol(5);
      sgFPJB.AutoSizeCol(6);
      sgFPJB.AutoSizeCol(7);
      sgFPJB.AutoSizeCol(8);
      sgFPJB.AutoSizeCol(9);
      sgFPJB.AutoSizeCol(10);
      sgFPJB.AutoSizeCol(11);
      sgFPJB.AutoSizeCol(12);


      FrmQuery.Caption := '当前总共记录:' + IntToStr(TmpQuery.RecordCount);
      FrmQuery.Hint := '当前记录:' + IntToStr(sgFPJB.Row);
    finally
      Gauge1.Visible := False;
      Screen.Cursor := crDefault;
    end;
  except
    on E: Exception do
      Application.MessageBox('数据查询时发生了错误!', '错误框', MB_ICONERROR + MB_OK);
  end;
end;

procedure TFrmQuery.FormCreate(Sender: TObject);
begin
  try
    TmpQuery := TQuery.Create(Application);
    TmpQuery.DatabaseName := CurrEnvironment.ReadDBFPath;
    EdtTitle.ImeName := CurrEnvironment.ReadIMEName;
  except
    on E: Exception do
    begin
      Application.MessageBox('无法连接至数据库,按"确定"将关闭程序!', '错误框', MB_ICONERROR + MB_OK);
      Application.Terminate;
    end;
  end;
end;

procedure TFrmQuery.FormDestroy(Sender: TObject);
begin
  TmpQuery.Close;
  TmpQuery.Free;
end;

procedure TFrmQuery.BBtnQueryClick(Sender: TObject);
begin
  DateQuery;
end;

procedure TFrmQuery.EdtQYBMKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, #35, #36, #37, #39]) then
    Key := #0;
end;

procedure TFrmQuery.sgFPJBGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ARow > 0) and (ARow mod 2 = 0) then
    ABrush.Color := Rgb(166, 202, 240);
end;

procedure TFrmQuery.sgFPJBGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var AAlignment: TAlignment);
begin
  if ARow = 0 then
    AAlignment := taCenter;

  if ACol in [0, 1, 2, 3, 4, 5, 6, 10, 11, 12] then
    AAlignment := taCenter;
end;

procedure TFrmQuery.CheckBox1Click(Sender: TObject);
begin
  if (Sender is TCheckBox) then
    if TCheckBox(Sender).Checked then
      sgFPJB.UnhideColumn(TCheckBox(Sender).Tag)
    else
      sgFPJB.HideColumn(TCheckBox(Sender).Tag);
end;

procedure TFrmQuery.cbTitleClick(Sender: TObject);
begin
  SwitchEdit;
  if EdtTitle.Enabled then
    EdtTitle.SetFocus;
end;

procedure TFrmQuery.BBtnPrintClick(Sender: TObject);
begin
  if cbTitle.Checked then
  begin
    sgFPJB.PrintSettings.TitleText := EdtTitle.Text;
    sgFPJB.Print;
  end
  else
  begin
    sgFPJB.PrintSettings.TitleText := '';
    sgFPJB.Print;
  end;
end;

procedure TFrmQuery.sgFPJBRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  FrmQuery.Hint := '当前记录:' + IntToStr(sgFPJB.Row);
end;

procedure TFrmQuery.BBtnSaveClick(Sender: TObject);
begin
  if CmbFileType.Text <> '' then
    case CmbFileType.ItemIndex of
      3: sgFPJB.SaveToHTML('C:\My Documents\FPJB' + FormatDateTime('HHMMSS', Now) + '.HTM');
      0: sgFPJB.SaveToASCII('C:\My Documents\FPJB' + FormatDateTime('HHMMSS', Now) + '.TXT');
      1: sgFPJB.SaveToCSV('C:\My Documents\FPJB' + FormatDateTime('HHMMSS', Now) + '.CSV');
      2: sgFPJB.SaveToDOC('C:\My Documents\FPJB' + FormatDateTime('HHMMSS', Now) + '.DOC');
      4: sgFPJB.SaveToXLS('C:\My Documents\FPJB' + FormatDateTime('HHMMSS', Now) + '.XLS');
    end;
end;

procedure TFrmQuery.cbSaveToFileClick(Sender: TObject);
begin
  SwitchEdit;
  if CmbFileType.Enabled then
    CmbFileType.SetFocus;
end;

procedure TFrmQuery.BBtnAppendClick(Sender: TObject);
var
  DBFImport: TBatchMove;
  SDBFTable, DDBFTable: TTable;
begin
  try
    try
      if OpenDialog1.Execute then
        if FileExists(OpenDialog1.FileName) then
        begin
          DDBFTable := TTable.Create(Application);
          DDBFTable.DatabaseName := CurrEnvironment.ReadDBFPath;
          DDBFTable.TableName := 'FPJB8.DBF';
          DDBFTable.Open;
//          ShowMessage('源表:'+IntToStr(DDBFTable.RecordCount));

          SDBFTable := TTable.Create(Application);
          SDBFTable.DatabaseName := ExtractFilePath(OpenDialog1.FileName);
          SDBFTable.TableName := ExtractFileName(OpenDialog1.FileName);
          SDBFTable.Open;
//          ShowMessage('目的表:'+IntToStr(SDBFTable.RecordCount));

          DBFImport := TBatchMove.Create(Application);
          DBFImport.Transliterate := True;
          DBFImport.AbortOnKeyViol := True;
          DBFImport.AbortOnProblem := True;
          DBFImport.Mode := batAppend;
          DBFImport.Destination := DDBFTable;
          DBFImport.Source := SDBFTable;
//          ShowMessage('处理:'+IntToStr(DBFImport.CommitCount));
          DBFImport.Execute;
          Application.MessageBox(PChar('添加' + IntToStr(DBFImport.MovedCount) + '条记录;'),
            '提示框', MB_ICONINFORMATION + MB_OK);
        end;
    finally
      DDBFTable.Free;
      SDBFTable.Free;
      DBFImport.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox('数据导入时发生了错误!', '错误框', MB_ICONERROR + MB_OK);
  end;
end;

end.

