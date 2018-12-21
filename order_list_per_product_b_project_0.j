;
; START MS EXCEL
;
errmsg    := "";
oleserver := "excel.application";
;
goto begin;
; script error handler ------------------------------------------
@error:
MsgErr(FormatStr(GetLanText(-9688),errmsg));
Halt;
; ---------------------------------------------------------------
;
@begin:
excel := start(oleserver);
if !IsIDispatch(excel) then
{
  MsgErr(FormatStr(GetLanText(-9687),oleserver));
  Halt;
}
else
{
  oleversion := StrToNum(GetParam("OFFICE"), 0);
  oleversion := StrToNum(excel.Version, oleversion);  
  excel.Visible := True;
};
tmpfile := FileSearch("%ORDERPRO_TEMPLATE%.XLT", "%PATH_DATA%");
if tmpfile = "" || !FileExists(tmpfile) then
{
  errmsg := "Cannot find template <%ORDERPRO_TEMPLATE%.XLT> in <%PATH_DATA%>!";
  goto error;
};
excel.WorkBooks.Add(tmpfile);
book := excel.ActiveWorkBook;
if !IsIDispatch(book) then
{
  errmsg := "Open <"+tmpfile+"> failed!";
  goto error;
};
book.Author := "%DB_USERDESC%";
tmpfile := "%SYSTEM_TMP%\orderpro.xls";
if FileExists(tmpfile) then DeleteFile(tmpfile);
book.SaveAs(tmpfile);
Kill("tmpfile");
template := book.WorkSheets["template"];
template.Activate;
template.Columns["Q"].Hidden := !%ORDER_LIST_PER_PRODUCT_PRICE%;

cell := template.Range["CELL_DATE"];
if IsIDispatch(cell) then cell.Value := "%DATE%";
cell := template.Range["CELL_BATCH"];
if IsIDispatch(cell) then cell.Value := "%BATCH%";
cell := template.Range["CELL_PROJECT"];
if IsIDispatch(cell) then cell.Value := "%PROJECT%";
cell := template.Range["CELL_COMPANY"];
if IsIDispatch(cell) then cell.Value := "%COMPANY%";
cell := template.Range["CELL_STREET"];
if IsIDispatch(cell) then cell.Value := "%STREET%";
cell := template.Range["CELL_PLACE"];
if IsIDispatch(cell) then cell.Value := "%PLACE%";
cell := template.Range["CELL_ZIP"];
if IsIDispatch(cell) then cell.Value := "%ZIP%";
cell := template.Range["CELL_PHONE"];
if IsIDispatch(cell) then cell.Value := "%PHONE%";
cell := template.Range["CELL_FAX"];
if IsIDispatch(cell) then cell.Value := "%FAX%";
cell := template.Range["CELL_EMAIL"];
if IsIDispatch(cell) then cell.Value := "%EMAIL%";
cell := template.Range["CELL_SMALLLOGO"];
if IsIDispatch(cell) then cell.Value := "%SMALLLOGO%";
cell := template.Range["CELL_TAXNUMBER"];
if IsIDispatch(cell) then cell.Value := "%TAXNUMBER%";
cell := template.Range["CELL_TRADEREGISTER"];
if IsIDispatch(cell) then cell.Value := "%TRADEREGISTER%";
cell := template.Range["CELL_REGISTRATION"];
if IsIDispatch(cell) then cell.Value := "%REGISTRATION%";
cell := template.Range["CELL_ACCOUNT"];
if IsIDispatch(cell) then cell.Value := "%ACCOUNT%";
cell := template.Range["CELL_CLIENT"];
if IsIDispatch(cell) then cell.Value := "%CLIENT%";
cell := template.Range["CELL_CLIENTNAME"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_NAME%";
cell := template.Range["CELL_CLIENTCONTACT"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_CONTACT%";
cell := template.Range["CELL_CLIENTADDRESS"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_ADDRESS%";
cell := template.Range["CELL_CLIENTZIP"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_ZIP%";
cell := template.Range["CELL_CLIENTCITY"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_CITY%";
cell := template.Range["CELL_CLIENTPHONE"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_PHONE%";
cell := template.Range["CELL_CLIENTFAX"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_FAX%";
cell := template.Range["CELL_CLIENTEMAIL"];
if IsIDispatch(cell) then cell.Value := "%CLIENT_EMAIL%";
cell := template.Range["CELL_PROJECTADDRESS1"];
if IsIDispatch(cell) then cell.Value := "%PROJECTADDRESS1%";
cell := template.Range["CELL_PROJECTADDRESS2"];
if IsIDispatch(cell) then cell.Value := "%PROJECTADDRESS2%";
cell := template.Range["CELL_PROJECTADDRESS3"];
if IsIDispatch(cell) then cell.Value := "%PROJECTADDRESS3%";
cell := template.Range["CELL_PROJECTPHONE"];
if IsIDispatch(cell) then cell.Value := "%PROJECTPHONE%";
cell := template.Range["CELL_PROJECTFAX"];
if IsIDispatch(cell) then cell.Value := "%PROJECTFAX%";
cell := template.Range["CELL_PROJECTEMAIL"];
if IsIDispatch(cell) then cell.Value := "%PROJECTEMAIL%";
cell := template.Range["CELL_PROJECTSERIES"];
if IsIDispatch(cell) then cell.Value := "%PROJECTSERIES%";
cell := template.Range["CELL_PROJECTPROFILE"];
if IsIDispatch(cell) then cell.Value := "%PROJECTPROFILE%";
cell := template.Range["CELL_PROJECTFRAMEPROFILE"];
if IsIDispatch(cell) then cell.Value := "%PROJECTFRAMEPROFILE%";
cell := template.Range["CELL_PROJECTVENTPROFILE"];
if IsIDispatch(cell) then cell.Value := "%PROJECTVENTPROFILE%";
cell := template.Range["CELL_PROJECTBEAD"];
if IsIDispatch(cell) then cell.Value := "%PROJECTBEAD%";
cell := template.Range["CELL_PROJECTFRAMEBEAD"];
if IsIDispatch(cell) then cell.Value := "%PROJECTFRAMEBEAD%";
cell := template.Range["CELL_PROJECTVENTBEAD"];
if IsIDispatch(cell) then cell.Value := "%PROJECTVENTBEAD%";
cell := template.Range["CELL_PROJECTFILLING"];
if IsIDispatch(cell) then cell.Value := "%PROJECTFILLING%";
cell := template.Range["CELL_PROJECTDESC"];
if IsIDispatch(cell) then cell.Value := "%PROJECTDESC%";
cell := template.Range["CELL_PROJECTSYSTEM"];
if IsIDispatch(cell) then cell.Value := "%PROJECTSYSTEM%";



