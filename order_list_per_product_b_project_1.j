; order_list_per_product_b_project_1
; Bestellijst/produkt: Profielen
%% detail
range := template.Range["RANGE_DETAIL_PROFILE"];
if !IsIDispatch(range) then
{
  errmsg := "Range RANGE_DETAIL_PROFILE not found!";
  goto error;
};
excel.Goto(range);
row := row + 1;
range := range.Offset[row];
excel.Goto(range);
excel.Selection.EntireRow.Insert();
template.Range["RANGE_DETAIL_PROFILE"].Copy();
template.Paste;
excel.CutCopyMode := False;
range := range.Offset[-1];
cell := range.Cells[1][1];
if IsIDispatch(cell) then cell.Value := @%DB_ATTRIB_NO%;
cell := range.Cells[1][2];
if IsIDispatch(cell) then cell.Value := iif(trim("%DSP_ATTRIB_ARTICLECODE%")="",trim("%DSP_ATTRIB_ACC%")+"."+trim(%IF{%ORDER_LIST_PER_PRODUCT_VARIANT%=0,"%DSP_ATTRIB_SERIE%","%DSP_ATTRIB_VARIETY%"}),trim("%DSP_ATTRIB_ARTICLECODE%"));
cell := range.Cells[1][3];
if IsIDispatch(cell) then cell.Value := HtmlToNormalStr(trim("%DSP_ATTRIB_VARIETYDESC%"));
cell := range.Cells[1][4];
if IsIDispatch(cell) then cell.Value := HtmlToNormalStr(trim("%DSP_ATTRIB_ACCDESC%"));
cell := range.Cells[1][5];
if IsIDispatch(cell) then cell.Value := iif(%GLOBAL_PRICE_PROFILE%=%C_PROFPRICE_PACK%,@%DB_ATTRIB_PACKVOLUME%,1);
cell := range.Cells[1][6];
if IsIDispatch(cell) then cell.Value := @%DB_ATTRIB_LENGTH%;
cell := range.Cells[1][7];
if IsIDispatch(cell) then cell.Value := iif(%GLOBAL_PRICE_PROFILE%=%C_PROFPRICE_PACK%,@%DB_ATTRIB_PACKCOUNT%,@%DB_ATTRIB_NO%);
cell := range.Cells[1][8];
if IsIDispatch(cell) then cell.Value := @%DB_ATTRIB_PRICE%;

/* add price/kg  --zmb 08/16/2018*/
cell := range.Cells[1][20];
if IsIDispatch(cell) then cell.FormulaR1C1 := "=RC[-4]/RC[1]";
/* add weight and surface1  --zmb 08/07/2018*/
cell := range.Cells[1][21];
if IsIDispatch(cell) then cell.Value := @%DB_ATTRIB_WEIGHT%;
cell := range.Cells[1][22];
if IsIDispatch(cell) then cell.Value := @%DB_ATTRIB_SURFACE1%;

%% break header
; Translation of header price labels.
cell := template.Range["PURCHASE_PRICE_LABEL1"];
if IsIDispatch(cell) then cell.Value := GetLanText(-312) + " (" + "%CURRENCY%" +")";
cell := template.Range["PRICE_METER_LABEL1"];
if IsIDispatch(cell) then cell.Value := GetLanText(-26003) + " (" + "%CURRENCY%" +")";

row := 0;
start := template.Range["RANGE_DETAIL_PROFILE"].Row;
%% break footer
range := template.Range["RANGE_DETAIL_PROFILE"];
excel.Goto(range);
excel.Selection.EntireRow.Delete();
%% detail footer
;
