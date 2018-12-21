; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 

RowId := RowId + 1;
Color := DataSheet.Range["HeadFormat"].Interior.Color;

ColId       := 1;
TempValue   := "";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
ColumnMerge := CostSheet.Range["B"+IntToStr(RowId)+":"+"E"+IntToStr(RowId)];
ColumnMerge.MergeCells := True;
ColumnMerge.Value := DataSheet.Range["ProjectPrice"].Value;
ColumnMerge.NumberFormat := CellTextFormat;
ColumnMerge.Font.Bold := True;
ColumnMerge.Interior.Color := Color;
ColumnMerge.Borders.LineStyle := 1;

%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail
; 

; Total item price
search_index := bList.IndexOf("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%"+"@%DB_COST_RATION%"+"@%DB_COST_FACTOR%"+"@%DB_COST_RATIO%");
if search_index >=0 then
{
ColId       := StrToNum(cList.Strings[bList.IndexOf("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%"+"@%DB_COST_RATION%"+"@%DB_COST_FACTOR%"+"@%DB_COST_RATIO%")]);
TempFormula := "="+SumFormulaText+"(Help!"+RId+LBr+IntToStr(-Count)+RBr+CId+":Help!"+RId+LBr+"-1"+RBr+CId+")";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Formula := TempFormula;
CurrentCell.NumberFormat := CellPriceFormat;
CurrentCell.Font.Bold := True;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
};

%% break header
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Break header
; 

%% break footer
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) _ Break footer
; 

%% detail footer
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail footer
; 

; Total batch/project price
s_index := bList.IndexOf("-3");
if s_index <> -1 then
{
ColId       := StrToNum(cList.Strings[bList.IndexOf("-3")]);
TempFormula := "="+SumFormulaText+"("+RId+LBr+IntToStr(-Count)+RBr+CId+":"+RId+LBr+"-1"+RBr+CId+")";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.FormulaR1C1 := TempFormula;
CurrentCell.NumberFormat := CellPriceFormat;
CurrentCell.Font.Bold := True;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
ColumnStart := sList.Strings[cList.IndexOf(IntToStr(ColId-2))];
ColumnEinde := sList.Strings[cList.IndexOf(IntToStr(ColId-1))];
ColumnMerge := CostSheet.Range[ColumnStart+IntToStr(RowId)+":"+ColumnEinde+IntToStr(RowId)];
ColumnMerge.MergeCells := True;
ColumnMerge.Value := "";
ColumnMerge.NumberFormat := CellTextFormat;
ColumnMerge.Font.Bold := True;
ColumnMerge.Interior.Color := Color;
ColumnMerge.Borders.LineStyle := 1;

; Focus the first worksheet
excel.DisplayAlerts := False;
CostSheet.Columns.Autofit;
Template.WorkSheets["Cost"].Activate;
Template.WorkSheets["Data"].Delete;
Template.WorkSheets["Help"].Visible := False;
HelpSheet.Columns.Autofit;
excel.DisplayAlerts := True;
};
; Save the excel workbook
if oleversion < 12 then
{
  outfn := ChangeFileExt(GetParam("REPORTDOC"),".xls");
}
else
{
  outfn := ChangeFileExt(GetParam("REPORTDOC"),".xlsx");
};
if FileExists(outfn) then DeleteFile(outfn);
Template.SaveAs(outfn);

bList.Free();
cList.Free();
pList.Free();
sList.Free();

Kill("Template");
Kill("excel");

