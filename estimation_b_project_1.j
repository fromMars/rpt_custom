; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 

Count := Count + 1;
RowId := RowId + 1;
Color := DataSheet.Range["CellFormat"].Interior.Color;

; Initialize prices project level
i := 0;
while (i < cList.Count) do
{
  ColId       := StrToNum(cList.Strings[i]);
  TempValue   := 0.0;
  CurrentCell := CostSheet.Cells[RowId][ColId];
  CurrentCell.Value := TempValue;
  CurrentCell.NumberFormat := CellPriceFormat;
  CurrentCell.Font.Italic := True;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
  i := i + 1;
};

%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail
; 

; Item counter
ColId       := 1;
TempValue   := Count;
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellLineFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Item description
ColId       := 2;
TempValue   := "@%DB_COST_ID%";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Item width
ColId       := 3;
TempValue   := "";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Item height
ColId       := 4;
TempValue   := "";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Item surface
ColId       := 5;
TempValue   := "";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Item price
ColId  := StrToNum(cList.Strings[bList.IndexOf("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%"+"@%DB_COST_RATION%"+"@%DB_COST_FACTOR%"+"@%DB_COST_RATIO%")]);
CellCT := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowCT)+"/"+pList.Strings[cList.IndexOf(IntToStr(ColId))];
CellC1 := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowC1);
CellC2 := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowC2);
CellC7 := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowC7);
CellC3 := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowC3);
CellC4 := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowC4);
CellC5 := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowC5);
CellC6 := sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowC6);
if (StrToNum(StrReplace(pList.Strings[cList.IndexOf(IntToStr(ColId))],"%DECIMALSEP%","."),0) > 0) then
{
  TempValue   := StrReplace("@%DB_RES_PRICE%",".","%DECIMALSEP%");
  TempFormula := "=((((((((("+TempValue+")*("+CellCT+"))*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
  CurrentCell := CostSheet.Cells[RowId][ColId];
  CurrentCell.Formula := TempFormula;
  CurrentCell.NumberFormat := CellPriceFormat;
  CurrentCell.Font.Italic := False;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
}
else
{
  TempValue   := StrReplace("@%DB_RES_PRICE%",".","%DECIMALSEP%");
  TempFormula := "=(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
  CurrentCell := CostSheet.Cells[RowId][ColId];
  CurrentCell.Formula := TempFormula;
  CurrentCell.NumberFormat := CellPriceFormat;
  CurrentCell.Font.Italic := False;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
};

; Item formula
TempFormula := "=Cost!"+sList.Strings[cList.IndexOf(IntToStr(ColId))]+IntToStr(RowId);
CurrentCell := HelpSheet.Cells[RowId][ColId];
CurrentCell.Formula := TempFormula;
CurrentCell.NumberFormat := CellPriceFormat;
CurrentCell.Font.Italic := %IF{@%DB_RES_PRICE%,False,True};
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

; Unit price item
ColId       := StrToNum(cList.Strings[bList.IndexOf("-1")]);
TempFormula := "="+SumFormulaText+"("+RId+CId+LBr+IntToStr(-Range)+RBr+":"+RId+CId+LBr+"-1"+RBr+")";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.FormulaR1C1 := TempFormula;
CurrentCell.NumberFormat := CellPriceFormat;
CurrentCell.Font.Italic := False;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Number of items
ColId       := StrToNum(cList.Strings[bList.IndexOf("-2")]);
TempValue   := "";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Font.Italic := False;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

; Total price item
ColId       := StrToNum(cList.Strings[bList.IndexOf("-3")]);
TempFormula := "="+SumFormulaText+"("+RId+CId+LBr+"-2"+RBr+":"+RId+CId+LBr+"-2"+RBr+")";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.FormulaR1C1 := TempFormula;
CurrentCell.NumberFormat := CellPriceFormat;
CurrentCell.Font.Italic := False;
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;

