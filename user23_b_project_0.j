/* USER1_B_PROJECT_0.J
 */


; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; b_project_0

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

excel.DisplayAlerts:=False;

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
ColCT := CostSheet.Range["CostTime"].Column;
ColC1 := CostSheet.Range["CostLoss"].Column;
ColC2 := CostSheet.Range["CostDiscount"].Column;
ColC7 := CostSheet.Range["CostSystem"].Column;
ColC3 := CostSheet.Range["CostFactor"].Column;
ColC6 := CostSheet.Range["CostCharge"].Column;
ColC4 := CostSheet.Range["CostProfit"].Column;
ColC5 := CostSheet.Range["CostRebate"].Column;
ColId := CostSheet.Range["PriceBlocks"].Column;
RowId := CostSheet.Range["PriceBlocks"].Row;
Color := DataSheet.Range["HeadFormat"].Interior.Color;
LossF := DataSheet.Range["Fixed"].Value;
LossA := DataSheet.Range["Absolute"].Value;
LossR := DataSheet.Range["Real"].Value;
bList := Strings.Create();                                  /*artikel+verliestype*/
cList := Strings.Create();                                  /*rowid*/
pList := Strings.Create();                                  /*db_res_cost【price】*/
sList := Strings.Create();                                  /*rowid*/
/*用于记录E_PROJECT.J计算所用数据，当前记录顺序：窗号-类型-樘数*/
/*hList:=Strings.Create();*/
help_cnt:=4;


RowId := RowId + 1;                                         /*更改标题单元格线型格式*/
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColCT];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC1];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC2];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC7];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC3];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC6];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC4];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC5];
CurrentCell.Borders.linestyle:=0;

RowId := RowId + 1;
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColCT];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC1];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC2];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC7];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC3];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC6];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC4];
CurrentCell.Borders.linestyle:=0;
CurrentCell := CostSheet.Cells[RowId][ColC5];
CurrentCell.Borders.linestyle:=0;


RowId_G:=0;                                                 /*玻璃行号*/
/*RowId_S:=0;*/
glass_price:=0;                                             /*玻璃价格标志位，*/
                                                            /*1-表示已记录玻璃行号*/
z_pg_block:="@%DB_COST_BLOCK%";
img_no:=0;						/* assembly count */
                                             
%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail
; 

z_pg_block:="@%DB_COST_BLOCK%";

a_link:="";
z_pg:=pricegroups.create();
z_pg.code.group:=z_pg_block;
z_pg.code.block:=@%DB_COST_ARTICLE%;
if z_pg.find() then
{
	a_link:=z_pg.link;
}
else
{
	msgbox("no article block "+inttostr(z_pg.code.block)+" found!");
}
z_pg.free();

RowId := RowId + 1;
Range := Range + 1;

TempValue    := %IF{%EVAL{@%DB_RES_COST%>0},"@%DB_RES_COST%","0"};

if a_link<>"" then                                          /*记录价格块或跟随块*/
	bList.Add(a_link+"@%DB_COST_LOSSTYPE%");
else
	bList.Add("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%");
cList.Add(IntToStr(RowId));                                 /*记录行号*/
pList.Add(StrReplace("TempValue",".","%DECIMALSEP%"));      /*记录价格*/
sList.Add(inttostr(RowId));                                 /*记录行号*/

/* 记录玻璃行号并设置玻璃价格标志位1*/
if (@%DB_COST_ARTICLE%=100 || @%DB_COST_ARTICLE%=205) && RowId_G=0 then
{
    RowId_G:=RowId;
    glass_price:=1;
}
/*
if @%DB_COST_ARTICLE%=41 then
{
    RowId_S:=RowId;
    glass_price:=1;
}*/

CostSheet.Cells[RowId][1].value:=rowid-3;                   /*输出序号*/
CostSheet.Cells[RowId][1].Borders.linestyle:=0;

; Priceblock description
TempValue   := "@%DB_RES_DESC%";
CurrentCell := CostSheet.Cells[RowId][ColId];
CurrentCell.Value := TempValue;
CurrentCell.NumberFormat := CellTextFormat;
CurrentCell.Font.Bold := False;
CurrentCell.Borders.linestyle:=0;

; Priceblock cost
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},%IF{%EVAL{@%DB_RES_COST%>0},@%DB_RES_COST%,0},0};
CurrentCell := CostSheet.Cells[RowId][ColCT];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellCostFormat;
CurrentCell.Font.Italic := %IF{%EVAL{@%DB_RES_COST%>0},False,True};
CurrentCell.Borders.linestyle:=0;

; Priceblock loss
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},@%DB_RES_LOSS%/100,0};
CurrentCell := CostSheet.Cells[RowId][ColC1];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
/*CurrentCell.Interior.Color := Color;*/
CurrentCell.Borders.linestyle:=0;

; Priceblock discount
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},@%DB_RES_DISCOUNT%/100,0};
CurrentCell := CostSheet.Cells[RowId][ColC2];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
/*CurrentCell.Interior.Color := Color;*/
CurrentCell.Borders.linestyle:=0;

; Priceblock system
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},@%DB_COST_RATION%,1};
CurrentCell := CostSheet.Cells[RowId][ColC7];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellFactorFormat;
/*CurrentCell.Interior.Color := Color;*/
CurrentCell.Borders.linestyle:=0;

; Priceblock factor
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},@%DB_COST_FACTOR%,1};
CurrentCell := CostSheet.Cells[RowId][ColC3];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellFactorFormat;
/*CurrentCell.Interior.Color := Color;*/
CurrentCell.Borders.linestyle:=0;

; Priceblock charge
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},@%DB_RES_CHARGE%/100,0};
CurrentCell := CostSheet.Cells[RowId][ColC6];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
/*CurrentCell.Interior.Color := Color;*/
CurrentCell.Borders.linestyle:=0;

; Priceblock profit
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},@%DB_RES_PROFIT%/100,0};
CurrentCell := CostSheet.Cells[RowId][ColC4];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
/*CurrentCell.Interior.Color := Color;*/
CurrentCell.Borders.linestyle:=0;

; Priceblock rebate
TempValue   := %IF{%EVAL{%ALLOW_COST_RATES%=1},@%DB_RES_REFUND%/100,0};
CurrentCell := CostSheet.Cells[RowId][ColC5];
CurrentCell.Value := TempValue;
CurrentCell.HorizontalAlignment := 1;
CurrentCell.NumberFormat := CellPercentFormat;
/*CurrentCell.Interior.Color := Color;*/
CurrentCell.Borders.linestyle:=0;

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


