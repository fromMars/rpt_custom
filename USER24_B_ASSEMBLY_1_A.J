/* USER1_B_ASSEMBLY_1_A.J
 * correct quantity per assembly 
 * add to profile price from acc db */



; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 


%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail   b_assembly_1_A.j
; 

/*calculate followed articles, use ?_ATTRIB_ARTICLE*/
a_link:="";
z_pg.code.group:="";
z_pg.code.block:=0;

z_pg.code.group:=z_pg_block;
z_pg.code.block:=@%DB_ATTRIB_ARTICLE%;
if z_pg.find() then
{
	a_link:=z_pg.link;
    if a_link<>"" && a_linked.indexof(a_link)=-1 then       /*no use here*/
        a_linked.add(a_link);                               /*           */
}
else
{
	msgbox("no article block "+inttostr(z_pg.code.block)+" found!");
}

/*获取行号*/
if a_link<>"" then
{
	RowId  := StrToNum(cList.Strings[bList.IndexOf(a_link+"@%DB_COST_LOSSTYPE%")]);
    
    CellCT := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColCT)+"))";/*/"+pList.Strings[cList.IndexOf(IntToStr(RowId))];*/
    CellC1 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC1)+"))";
    CellC2 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC2)+"))";
    CellC7 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC7)+"))";
    CellC3 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC3)+"))";
    CellC4 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC4)+"))";
    CellC5 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC5)+"))";
    CellC6 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC6)+"))";
        
    TempValue   := StrReplace("@%DB_ATTRIB_PRICE%/%ASSEMBLYCOUNT%",".","%DECIMALSEP%");
    TempFormula := "(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
    
    if strpos("=",costsheet.cells[rowid][7].formula)<>1 then
        costsheet.cells[rowid][7].formula:="="+TempFormula;
    else
        costsheet.cells[rowid][7].formula:=costsheet.cells[rowid][7].formula+"+"+TempFormula;
    /*costsheet.cells[rowid][8].value:=costsheet.cells[rowid][8].value+" 配件中存在@%DB_ATTRIB_ACCDESC%，其价格添加在其他型材金额中，但是未算入其他型材单价及单樘用量中";
    costsheet.cells[rowid][8].Interior.ColorIndex:="22";
    costsheet.cells[rowid][6].Interior.ColorIndex:="22";
    costsheet.cells[rowid][5].Interior.ColorIndex:="22";*/
}
else if @%DB_ATTRIB_ARTICLE%<%EOSS2016_TO_2018_20% then
{
	RowId  := StrToNum(cList.Strings[bList.IndexOf("@%DB_ATTRIB_ARTICLE%"+"@%DB_COST_LOSSTYPE%")]);
    
    if @%DB_COST_ARTICLE%<%EOSS2016_TO_2018_20% then
    {
        CellCT := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColCT)+"))";/*/"+pList.Strings[cList.IndexOf(IntToStr(RowId))];*/
        CellC1 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC1)+"))";
        CellC2 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC2)+"))";
        CellC7 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC7)+"))";
        CellC3 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC3)+"))";
        CellC4 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC4)+"))";
        CellC5 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC5)+"))";
        CellC6 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC6)+"))";
        
        TempValue   := StrReplace("@%DB_ATTRIB_PRICE%/%ASSEMBLYCOUNT%",".","%DECIMALSEP%");
        TempFormula := "(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
        CurrentCell := CostSheet.Cells[RowId+row_increase][7];
        if strpos("=",CurrentCell.formula)<>1 then
            CurrentCell.Formula := "="+TempFormula;
        else
            CurrentCell.Formula := CurrentCell.Formula+"+"+TempFormula;
        CurrentCell.Font.Italic := False;
        CurrentCell.Borders.LineStyle := 1;
        
        /*costsheet.cells[rowid][8].value:="配件中存在@%DB_ATTRIB_ACCDESC%，在此添加";
        costsheet.cells[rowid][8].Interior.ColorIndex:="22";*/
    }
    
    if @%DB_COST_ARTICLE%=%EOSS2016_TO_2018_16% || @%DB_COST_ARTICLE%=%EOSS2016_TO_2018_17% then
    {
	currentcelltmp:=costsheet.cells[rowid+row_increase][5];
	currentcelltmp.value:="";
        currentcelltmp:=costsheet.cells[rowid+row_increase][6];
	currentcelltmp.value:="";
    }
}

else
{
    ; Item price
    RowId  := StrToNum(cList.Strings[bList.IndexOf("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%")]);
    if recent_rowid=-1 || recent_rowid>(rowid+row_increase) then
        recent_rowid:=rowid+row_increase;

    /*单樘用量*/
    wps_colid:=colid-2;
    currentcell:=costsheet.cells[rowid+row_increase][wps_colid];
    currentcell0:=costsheet.cells[rowid+row_increase][wps_colid-2];
    currentcell0.HorizontalAlignment:=-4108;
    if @%DB_ATTRIB_NO%<>0 || @%DB_ATTRIB_CFLENGTH%<>0 then
    {
        currentcell.formulaR1C1:="=@%DB_ATTRIB_NO%/%ASSEMBLYCOUNT%";
        /*clear unused items*/
        if 1 then
            currentcell.value:="";
        if @%DB_ATTRIB_ARTICLE%=%EOSS2016_TO_2018_32% then
            currentcell0.value:="套";        /*currentcell0.value:="件";*/
        /*价格块35-胶条*/
        if @%DB_ATTRIB_ARTICLE%=%EOSS2016_TO_2018_35% then
        {
            /*currentcell.formulaR1C1:="=@%DB_ATTRIB_CFLENGTH%/%ASSEMBLYCOUNT%";*/
            /*currentcell0.value:="m";*/
        }   
    }
    else
        currentcell.value:="";

    currentcell.borders.linestyle:=1;

    if @%DB_COST_ARTICLE%=%EOSS2016_TO_2018_16% || @%DB_COST_ARTICLE%=%EOSS2016_TO_2018_17% then
    {
	currentcelltmp:=costsheet.cells[rowid+row_increase][5];
	currentcelltmp.value:="";
        currentcelltmp:=costsheet.cells[rowid+row_increase][6];
	currentcelltmp.value:="";
    }
}






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


