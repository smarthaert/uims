unit HtmlHelper;

interface

uses
  MSHTML, sysUtils, SHDocVw;

implementation

function GetHtmlTableCell(aTable: IHTMLTable; aRow, aCol: Integer): IHTMLElement;
var
  Row: IHTMLTableRow;

begin
  Result := nil;
  if aTable = nil then Exit;
  if aTable.rows = nil then Exit;
  Row := aTable.rows.item(aRow, aRow) as IHTMLTableRow;
  if Row = nil then Exit;
  Result := Row.cells.item(aCol, aCol) as IHTMLElement;
end;

{按照位置获得表格}

function GetHtmlTable(aDoc: IHTMLDocument2; aIndex: Integer): IHTMLTable;
var
  list: IHTMLElementCollection;
begin
  Result := nil;
  if aDoc = nil then Exit;
  if aDoc.all = nil then Exit;
  list := aDoc.all.tags('table') as IHTMLElementCollection;
  if list = nil then Exit;
  Result := list.item(aIndex, aIndex) as IHTMLTable;
end;

{获取表格中单元格的内容}

function GetWebBrowserHtmlTableCellText(const AWebBrowser: TWebBrowser;
  const TableIndex, RowIndex, ColIndex: Integer;
  var ResValue: string): Boolean;
var
  Docintf: IHTMLDocument2;
  tblintf: IHTMLTable;
  node: IHTMLElement;
begin
  ResValue := '';
  docintf := AWebBrowser.Document as IHTMLDocument2;
  tblintf := GetHtmlTable(docintf, TableIndex);
  node := GetHtmlTableCell(tblintf, RowIndex, ColIndex);
  Result := node <> nil;
  if Result then
    ResValue := Trim(node.innerText);
end;

{获得表格的一行}

function GetHtmlTableRowHtml(aTable: IHTMLTable; aRow: Integer): IHTMLElement;
var
  Row: IHTMLTableRow;
begin
  Result := nil;
  if aTable = nil then Exit;
  if aTable.rows = nil then Exit;
  Row := aTable.rows.item(aRow, aRow) as IHTMLTableRow;
  if Row = nil then Exit;
  Result := Row as IHTMLElement;
end;

function GetWebBrowserHtmlTableCellHtml(const AWebBrowser: TWebBrowser;
  const TableIndex, RowIndex, ColIndex: Integer;
  var ResValue: string): Boolean;
var
  Docintf: IHTMLDocument2;
  tblintf: IHTMLTable;
  node: IHTMLElement;
begin
  ResValue := '';
  docintf := AWebBrowser.Document as IHTMLDocument2;
  tblintf := GetHtmlTable(docintf, TableIndex);
  node := GetHtmlTableCell(tblintf, RowIndex, ColIndex);
  Result := node <> nil;
  if Result then
    ResValue := Trim(node.innerHTML);
end;


function GeHtmlTableHtml(aTable: IHTMLTable; aRow: Integer): IHTMLElement;
var
  Row: IHTMLTableRow;
begin
  Result := nil;
  if aTable = nil then Exit;
  if aTable.rows = nil then Exit;
  Row := aTable.rows.item(aRow, aRow) as IHTMLTableRow;
  if Row = nil then Exit;
  Result := Row as IHTMLElement;
end;

function GetWebBrowserHtmlTableHtml(const AWebBrowser: TWebBrowser;
  const TableIndex, RowIndex: Integer;
  var ResValue: string): Boolean;
var
  Docintf: IHTMLDocument2;
  tblintf: IHTMLTable;
  node: IHTMLElement;
begin
  ResValue := '';
  docintf := AWebBrowser.Document as IHTMLDocument2;
  tblintf := GetHtmlTable(docintf, TableIndex);
  node := GeHtmlTableHtml(tblintf, RowIndex);
  Result := node <> nil;
  if Result then
    ResValue := node.innerHtml;
end;

end.
