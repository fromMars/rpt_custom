/* USER1_B_ASSEMBLY_3.J
 * artikel between 100 and 900 items */


if glass_increase=-1 then                   /* with -1 followed list_no_formula will be incorrect */
    glass_increase:=0;

fix_increase:=0;
if rowzz<>-1 && glassrun=0 then
{
    fix_increase:=fix_increase+1;
    row_increase:=row_increase-1;
}
    
recent_rowid:=-1;

; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 


%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail   b_assembly_3.j
; 


; Item price
RowId  := StrToNum(cList.Strings[bList.IndexOf("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%")]);
if recent_rowid=-1 || recent_rowid>(rowid+row_increase) then
	recent_rowid:=rowid+row_increase;

CellCT := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColCT)+"))/"+pList.Strings[cList.IndexOf(IntToStr(RowId))];
CellC1 := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColC1)+"))";
CellC2 := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColC2)+"))";
CellC7 := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColC7)+"))";
CellC3 := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColC3)+"))";
CellC4 := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColC4)+"))";
CellC5 := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColC5)+"))";
CellC6 := 'Indirect("Cost!"&address('+numtostr(strtonum(sList.Strings[cList.IndexOf(IntToStr(RowId))]))+","+IntToStr(ColC6)+"))";


if (StrToNum(StrReplace(pList.Strings[cList.IndexOf(IntToStr(RowId))],"%DECIMALSEP%","."),0) > 0) then
{
  TempValue   := StrReplace("@%DB_RES_PRICE%/%ASSEMBLYCOUNT%",".","%DECIMALSEP%");
  /*set charge time items price to 0*/
  TempValue := "RC[-2]*RC[-1]";
  TempFormula := "=((((((((("+TempValue+")*("+CellCT+"))*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
  CurrentCell := CostSheet.Cells[RowId+row_increase][ColId];
  CurrentCell.Formula := TempFormula;
  CurrentCell.Font.Italic := False;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
}
else
{
  TempValue   := StrReplace("@%DB_RES_PRICE%/%ASSEMBLYCOUNT%",".","%DECIMALSEP%");
  /*set charge time items price to 0*/
  TempValue := "RC[-2]*RC[-1]";
  TempFormula := "=(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
  CurrentCell := CostSheet.Cells[RowId+row_increase][ColId];
  CurrentCell.Formula := TempFormula;
  CurrentCell.Font.Italic := False;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
}

/*set charge time items price to 0*/
/*CurrentCell.Formula := "=RC[-2]*RC[-1]";*/
  

/*
TempFormula := '=Indirect(address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+','+IntToStr(ColId)+',,,"Cost"))*Indirect(address('+sList.Strings[bList.IndexOf("-2")]+','+IntToStr(ColId)+',,,"Cost"))';
CurrentCell := HelpSheet.Cells[RowId][ColId];
CurrentCell.Formula := TempFormula;
CurrentCell.Font.Italic := %IF{@%DB_RES_PRICE%,False,True};
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;*/

/*add list no*/
list_no_formula:="=row()-"+inttostr(row_increase+2-glass_increase+fix_increase);    /* 3->2 ? */
costsheet.cells[rowid+row_increase][1].formula:=list_no_formula;

;supplier
s_colid:=colid+1;
currentcell:=costsheet.cells[rowid+row_increase][s_colid];
currentcell.value:="%DSP_COST_SUPPLIER%";
currentcell.borders.linestyle:=1;
if trim("%DSP_COST_DESC%")="胶条焊合" then
    currentcell.value:="";


;unit
u_colid:=colid-1;
currentcell:=costsheet.cells[rowid+row_increase][u_colid];
u_recent_value:=currentcell.formula;
if "@%DB_COST_ASSEMBLY%"="" then
{
    /*project level artikels*/
    if trim("%DSP_COST_ARTICLE%")="970" then
    {
        currentcell.formula:="=Data!HNDRateJC";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_ARTICLE%")="975" then
    {
        currentcell.formula:="=Data!HNDRateZB";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_ARTICLE%")="980" then
    {
        currentcell.formula:="=Data!HNDRateJS";		/*manual input value default 0*/
    }
}
else
{
	tot_formula:="="+RId+LBr+inttostr(0)+RBr+CId+Lbr+"1"+RBr+"/"+numtostr(curr_surface);
	currentcell.formulaR1C1:=tot_formula;
    /*set charge time items price to 0*/
    if trim("%DSP_COST_DESC%")="密封胶" then
    {
        currentcell.formula:="=Data!HNDRateA";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_DESC%")="断面胶" then
    {
        currentcell.formula:="=Data!HNDRateB";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_DESC%")="组角胶" then
    {
        currentcell.formula:="=Data!HNDRateC";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_DESC%")="制作费" then
    {
        currentcell.formula:="=Data!HNDRateD";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_DESC%")="运输费" then
    {
        currentcell.formula:="=Data!HNDRateE";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_DESC%")="安装费" then
    {
        currentcell.formula:="=Data!HNDRateF";		/*manual input value default 0*/
    }
    else if trim("%DSP_COST_DESC%")="胶条焊合" then
    {
        currentcell.formula:="=Data!HNDRateG";		/*manual input value default 0*/
    }
}
currentcell.borders.linestyle:=1;



;quantity per surface
wps_colid:=colid-2;
currentcell:=costsheet.cells[rowid+row_increase][wps_colid];
if "@%DB_COST_ASSEMBLY%"<>"" then
{
    currentcell.formulaR1C1:="="+numtostr(curr_surface);
    if trim("%DSP_COST_DESC%")="胶条焊合" then
        currentcell.value:=inttostr(@COST_QUANTITY);
    currentcell:=costsheet.cells[rowid+row_increase][u_colid-3];
    currentcell.value:="㎡";
    currentcell.HorizontalAlignment:=-4108;
}
else
{
    pla_formula:="="+numtostr(currentcell.value)+"*"+numtostr(curr_surface)+"/Cost!mianji";
	currentcell.formula:=pla_formula;
    currentcell_tmp:=costsheet.cells[rowid+row_increase][wps_colid+1];
    /*datasheet.range["HNDRate"].formula:='=Indirect("Cost!"&address('+inttostr(rowid)+","+inttostr(colid+7)+"))"+"/Cost!mianji";*/
    if trim("%DSP_COST_ARTICLE%")="970" then
    {
        datasheet.range["HNDRate"].value:=0;		/*manual input value default 0*/
        currentcell_tmp.formula:="=Data!HNDRateJC";
    }
    else if trim("%DSP_COST_ARTICLE%")="975" then
    {
        datasheet.range["HNDRate"].value:=0;		/*manual input value default 0*/
        currentcell_tmp.formula:="=Data!HNDRateZB";
    }
    else if trim("%DSP_COST_ARTICLE%")="980" then
    {
        datasheet.range["HNDRate"].value:=0;		/*manual input value default 0*/
        currentcell_tmp.formula:="=Data!HNDRateJS";
    }
    else if trim("%DSP_COST_ARTICLE%")="445" then
    {
        datasheet.range["HNDRate"].value:=0;		/*manual input value default 0*/
        currentcell_tmp.formula:="=Data!HNDRate";
    }
    currentcell_tmp:=costsheet.cells[rowid+row_increase][wps_colid+2];
    currentcell_tmp.formulaR1C1:="="+RId+CId+LBr+"-2"+RBr+"*"+RId+CId+LBr+"-1"+RBr;
    currentcell_tmp:=costsheet.cells[rowid+row_increase][wps_colid-2];
    currentcell_tmp.value:="㎡";
    currentcell_tmp.HorizontalAlignment:=-4108;
    
}
currentcell.borders.linestyle:=1;
/*list_no_formula:="=row()-"+inttostr(row_increase+3);*/

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
; %[3].FormulaR1C1:=Formula1;
