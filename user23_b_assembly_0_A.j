/* USER1_B_ASSEMBLY_0_A.J
 * show profile prices with artikel (16,17), EOSS2018 (80,85)*/

; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)  b_assembly_0_A.j
; 


%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail
; 

a_link:="";
z_pg.code.group:="";
z_pg.code.block:=0;

z_pg.code.group:=z_pg_block;
z_pg.code.block:=@%DB_COST_ARTICLE%;
if z_pg.find() then
{
	a_link:=z_pg.link;
    if a_link<>"" && a_linked.indexof(a_link)=-1 then       /*跟随价格块存在且未记录*/
        a_linked.add(a_link);                               /*则记录该价格块*/
}
else
{
	msgbox("no article block "+inttostr(z_pg.code.block)+" found!");
}


/*获取行号*/
if a_link<>"" then
{
	RowId  := StrToNum(cList.Strings[bList.IndexOf(a_link+"@%DB_PIECE_LOSSTYPE%")]);
}
else
{
	RowId  := StrToNum(cList.Strings[bList.IndexOf("@%DB_PIECE_ARTICLE%"+"@%DB_PIECE_LOSSTYPE%")]);
}


if recent_rowid=-1 || recent_rowid>rowid then
	recent_rowid:=rowid;

CellCT := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColCT)+"))/"+pList.Strings[cList.IndexOf(IntToStr(RowId))];
CellC1 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC1)+"))";
CellC2 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC2)+"))";
CellC7 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC7)+"))";
CellC3 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC3)+"))";
CellC4 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC4)+"))";
CellC5 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC5)+"))";
CellC6 := 'Indirect("Cost!"&address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+","+IntToStr(ColC6)+"))";


rowid:=rowid+row_increase;

if (StrToNum(StrReplace(pList.Strings[cList.IndexOf(IntToStr(RowId))],"%DECIMALSEP%","."),0) > 0) then
{
  CurrentCell := CostSheet.Cells[RowId][ColId];
  TempValue   := StrReplace("@%DB_PIECE_PRICE%/%ASSEMBLYCOUNT%",".","%DECIMALSEP%");
  /*当前价格块跟随或当前价格块被跟随-true，否则-false*/
  if a_link<>"" || a_linked.indexof("@%DB_COST_ARTICLE%")<>-1 then
  {
    /*为current_profile_value保存当前tempvalue(recent_profile_value)*/
	tmp_tmp_value:=tempvalue;
	curr_profile_value:="((((((((("+recent_profile_value+")*("+CellCT+"))*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
	tx:=currentcell.formula;
    ty:=currentcell.value;
    if tx<>"0" then
        TempFormula := currentcell.formula+"+(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
    else
        TempFormula := "=(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))"; /*删除curr_profile_value, "...))+"+current_profile_value;*/
    /*TempFormula := "=((((((((("+TempValue+")*("+CellCT+"))*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))+"+current_profile_value;*/       /*添加curr_profile_value, "...))+"+current_profile_value;*/
  }
  else
  {
	TempFormula := "=((((((((("+TempValue+")*("+CellCT+"))*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
  }
  CurrentCell.Formula := TempFormula;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
}
else
{
  CurrentCell := CostSheet.Cells[RowId][ColId];
  TempValue   := StrReplace("@%DB_PIECE_PRICE%/%ASSEMBLYCOUNT%",".","%DECIMALSEP%");
  if a_link<>"" || a_linked.indexof("@%DB_COST_ARTICLE%")<>-1 then
  {
	tmp_tmp_value:=tempvalue;
	curr_profile_value:="(((((((("+recent_profile_value+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
        /* values temporary parameters tx and ty for comparation,
           ty would sometimes be integer 0 or string "0" or the formula. */
        tx:=currentcell.formula;
        ty:=currentcell.value;
        if tx<>"0" then
            TempFormula := currentcell.formula+"+(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
        else
            TempFormula := "=(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))"; /*删除curr_profile_value, "...))+"+current_profile_value;*/
  }
  else
  {
	TempFormula := "=(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
  }
  CurrentCell.Formula := TempFormula;
  CurrentCell.Font.Italic := False;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
}


; Item formula
/*
TempFormula := '=Indirect(address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+','+IntToStr(ColId)+',,,"Cost"))*Indirect(address('+sList.Strings[bList.IndexOf("-2")]+','+IntToStr(ColId)+',,,"Cost"))';
CurrentCell := HelpSheet.Cells[RowId][ColId];
CurrentCell.Formula := TempFormula;
CurrentCell.Font.Italic := %IF{@%DB_RES_PRICE%,False,True};
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;*/



;型材单位
un_colid:=3;
currentcell:=costsheet.cells[rowid][un_colid];
currentcell.value:="kg";
currentcell.HorizontalAlignment:=-4108;
if @%DB_COST_ARTICLE%=80 || @%DB_COST_ARTICLE%=85 then
{
    currentcell.value:="";
}


;供应商
s_colid:=colid+1;
currentcell:=costsheet.cells[rowid][s_colid];
currentcell.value:="%DSP_PIECE_SUPPLIER%";
if trim(currentcell.value)="EOSS" || trim(currentcell.value)="EOSSPROF" then
    currentcell.value:="华建易欧思"+trim("%DSP_PIECE_SYSTEM%")+"系列型材";
currentcell.borders.linestyle:=1;


;单位面积重量
wps_colid:=colid-2;
currentcell:=costsheet.cells[rowid][wps_colid];
if a_link<>"" || a_linked.indexof("@%DB_COST_ARTICLE%")<>-1 then
{
	curr_profile_value:=currentcell.formula;
    if substr(curr_profile_value,1,1)="=" then
        curr_profile_value:=substr(curr_profile_value,2,strlen(curr_profile_value)-1);
    currentcell.formulaR1C1:="=(1+Data!AWRate)*@%DB_PIECE_WEIGHT%/%ASSEMBLYCOUNT%+"+curr_profile_value;
	currentcell.borders.linestyle:=1;
}
else
{
    currentcell.formulaR1C1:="=(1+Data!AWRate)*@%DB_PIECE_WEIGHT%/%ASSEMBLYCOUNT%";
	currentcell.borders.linestyle:=1;
}
if @%DB_COST_ARTICLE%=80 || @%DB_COST_ARTICLE%=85 then
{
    currentcell.value:="";
}



;单价
u_colid:=colid-1;
currentcell:=costsheet.cells[rowid][u_colid];
u_recent_value:=currentcell.value;
if u_recent_value<>0 && a_link="" && a_linked.indexof("@%DB_COST_ARTICLE%")=-1 then
{
	costsheet.cells[rowid][u_colid+1].value:=u_recent_value;
	currentcell.value:="";
}
else
{
	if a_link<>"" || a_linked.indexof("@%DB_COST_ARTICLE%")<>-1 then
	{
		curr_profile_value:=currentcell.value;
        tot_formula:="="+RId+CId+LBr+"1"+RBr+"/"+RId+CId+LBr+"-1"+RBr;
		currentcell.formulaR1C1:=tot_formula;
	}
	else
	{
		tot_formula:="="+RId+CId+Lbr+"1"+RBr+"/((1+Data!AWRate)*@%DB_PIECE_WEIGHT%/%ASSEMBLYCOUNT%)";
		currentcell.formulaR1C1:=tot_formula;
	}
}
if @%DB_COST_ARTICLE%=80 || @%DB_COST_ARTICLE%=85 then
{
    currentcell.value:="";
}
currentcell.borders.linestyle:=1;

/*跟随价格块计算用，本次tempvalue保存在recent_profile_value中，下次计算用*/
recent_profile_value:=tmp_tmp_value;
tmp_tmp_value:="0";

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
