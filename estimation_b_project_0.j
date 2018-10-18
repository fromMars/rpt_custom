; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 

ErrMsg := "";
oleserver := "excel.application";
goto begin;

; General exception raiser
@generalerror:
  if !excel.visible then excel.visible := true;
  MsgErr(FormatStr(GetLanText(-9688), ErrMsg));
  Halt;

; Error in oleserver
@oleservererror:
  if !excel.visible then excel.visible := true;
  MsgErr(FormatStr(GetLanText(-9687), ErrMsg));
  Halt;

; Start processing
@begin:
excel := start(oleserver);
if !IsIDispatch(excel) then
{
  ErrMsg := oleserver;
  goto oleservererror;
}
else
{
  oleversion := StrToNum(GetParam("OFFICE"), 0);
  oleversion := StrToNum(excel.Version, oleversion);
  excel.visible := True;
};

; Open a temporary template file for calculations
TemplateFile := FileSearch("%ESTIMATION_TEMPLATE%.XLT", "%PATH_DATA%");
if templatefile = "" || !FileExists(templatefile) then
{
  ErrMsg := "Cannot find template <%ESTIMATION_TEMPLATE%.XLT> in <%PATH_DATA%>!";
  goto generalerror;
}
Template := excel.workbooks.add(TemplateFile);
if !IsIDispatch(Template) then
{
  ErrMsg := "Open <" + TemplateFile + "> failed!";
  goto generalerror;
}
Template.Author := "%DB_USERDESC%";
CostSheet := Template.WorkSheets["Cost"];
DataSheet := Template.WorkSheets["Data"];
HelpSheet := Template.WorkSheets["Help"];

; Translated formulas
TemplateFormulaCell := DataSheet.Range["Formula"];
TemplateFormula := TemplateFormulaCell.FormulaR1C1;
BracketPos := StrPos("(", TemplateFormula);
SumFormulaText := SubStr(TemplateFormula, 2, BracketPos - 2);
RId := SubStr(TemplateFormula, BracketPos + 1, 1);
CId := SubStr(TemplateFormula, BracketPos + 2, 1);
LBr := SubStr(TemplateFormula, BracketPos + 3, 1);
RBr := SubStr(TemplateFormula, BracketPos + 5, 1);

; Cell formats
CellSizeFormat    := "#" + "%THOUSANDSEP%" + "##0";
CellCostFormat    := "#" + "%THOUSANDSEP%" + "##0" + "%DECIMALSEP%" + "00";
CellAreaFormat    := "#" + "%THOUSANDSEP%" + "##0" + "%DECIMALSEP%" + "00";
CellPriceFormat   := "#" + "%THOUSANDSEP%" + "##0"; 
CellCountFormat   := "#" + "%THOUSANDSEP%" +"##0[$x]";
CellFactorFormat  := "#" + "%THOUSANDSEP%" + "##0" + "%DECIMALSEP%" + "00"; 
CellPercentFormat := "##0" + "%DECIMALSEP%" + "00%"; 
CellLineFormat    := "0";
CellTextFormat    := "@";

; Default template row & column indexes
Count := 0;
Range := 0;
RowCT := CostSheet.Range["CostTime"].Row;
RowC1 := CostSheet.Range["CostLoss"].Row;
RowC2 := CostSheet.Range["CostDiscount"].Row;
RowC7 := CostSheet.Range["CostSystem"].Row;
RowC3 := CostSheet.Range["CostFactor"].Row;
RowC6 := CostSheet.Range["CostCharge"].Row;
RowC4 := CostSheet.Range["CostProfit"].Row;
RowC5 := CostSheet.Range["CostRebate"].Row;
RowId := CostSheet.Range["PriceBlocks"].Row;
ColId := CostSheet.Range["PriceBlocks"].Column;
Color := DataSheet.Range["HeadFormat"].Interior.Color;
LossF := DataSheet.Range["Fixed"].Value;
LossA := DataSheet.Range["Absolute"].Value;
LossR := DataSheet.Range["Real"].Value;
bList := Strings.Create();
cList := Strings.Create();
pList := Strings.Create();
sList := Strings.Create();

; Default project information
CurrentCell := CostSheet.Range["Project"];
CurrentCell.Value := "%BATCH%";
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell := CostSheet.Range["System"];
CurrentCell.Value := "%PROJECTSYSTEM%";
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell := CostSheet.Range["Color"];
CurrentCell.Value := "%PROJECTPROFILE%";
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell := CostSheet.Range["Filling"];
CurrentCell.Value := "%PROJECTGLAZING%";
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell := CostSheet.Range["Loss"];
CurrentCell.Value := %IF{%GLOBAL_LOSS%=%C_FIXED_LOSS%,LossF,%IF{%GLOBAL_LOSS%=%C_ABSOLUTE_LOSS%,LossA,LossR}};
CurrentCell.NumberFormat := CellTextFormat;

; Header information table
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
ColId := ColId + 1;
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
ColId := ColId + 1;
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
ColId := ColId + 1;
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
ColId := ColId + 1;
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail
; 

ColId := ColId + 1;
Range := Range + 1;
TempValue    := %IF{%EVAL{@%DB_RES_COST%>0},"@%DB_RES_COST%","0"};
ColumnLetter := SubStr(CostSheet.Cells[RowId][ColId].Address, 2, 3);
ColumnLetter := SubStr(ColumnLetter, 1, StrPos("$", ColumnLetter) - 1);
bList.Add("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%"+"@%DB_COST_RATION%"+"@%DB_COST_FACTOR%"+"@%DB_COST_RATIO%");
cList.Add(IntToStr(ColId));
pList.Add(StrReplace("TempValue",".","%DECIMALSEP%"));
sList.Add(ColumnLetter);

; Priceblock description
TempValue   := "@%DB_RES_DESC%";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Orientation := 90;
CurrentCell.Font.Bold := True;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock cost
TempValue   := %IF{%EVAL{@%DB_RES_COST%>0},@%DB_RES_COST%,0};
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellCostFormat;
CurrentCell.Font.Italic := %IF{%EVAL{@%DB_RES_COST%>0},False,True};
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock loss
TempValue   := @%DB_RES_LOSS%/100;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock discount
TempValue   := @%DB_RES_DISCOUNT%/100;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock system
TempValue   := @%DB_COST_RATION%;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellFactorFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock factor
TempValue   := @%DB_COST_FACTOR%;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellFactorFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock charge
TempValue   := @%DB_RES_CHARGE%/100;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock profit
TempValue   := @%DB_RES_PROFIT%/100;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Priceblock rebate
TempValue   := @%DB_RES_REFUND%/100;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

%% break header
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Break header
; 

%% break footer
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Break footer
; 

%% detail footer
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail footer
; 

; Column unit price item
ColId := ColId + 1;
ColumnLetter := SubStr(CostSheet.Cells[RowId][ColId].Address, 2, 3);
ColumnLetter := SubStr(ColumnLetter, 1, StrPos("$", ColumnLetter) - 1);
bList.Add("-1");
cList.Add(IntToStr(ColId));
sList.Add(ColumnLetter);
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := DataSheet.Range["ItemPrice"].Value;
CurrentCell.Orientation := 90;
CurrentCell.Font.Bold := True;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Column number of items
ColId := ColId + 1;
ColumnLetter := SubStr(CostSheet.Cells[RowId][ColId].Address, 2, 3);
ColumnLetter := SubStr(ColumnLetter, 1, StrPos("$", ColumnLetter) - 1);
bList.Add("-2");
cList.Add(IntToStr(ColId));
sList.Add(ColumnLetter);
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := DataSheet.Range["ItemCount"].Value;
CurrentCell.Orientation := 90;
CurrentCell.Font.Bold := True;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Column total price item
ColId := ColId + 1;
ColumnLetter := SubStr(CostSheet.Cells[RowId][ColId].Address, 2, 3);
ColumnLetter := SubStr(ColumnLetter, 1, StrPos("$", ColumnLetter) - 1);
bList.Add("-3");
cList.Add(IntToStr(ColId));
sList.Add(ColumnLetter);
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := DataSheet.Range["TotalPrice"].Value;
CurrentCell.Orientation := 90;
CurrentCell.Font.Bold := True;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowCT][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC1][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC2][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC7][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC3][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC6][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC4][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;
CurrentCell := CostSheet.Cells[RowC5][ColId];
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

