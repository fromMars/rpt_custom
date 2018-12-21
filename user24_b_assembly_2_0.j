/* USER1_B_ASSEMBLY_2_0.J
 * 材料费小计（型材、配件、材料） */

if glass_increase=-1 then                   /* with -1 followed list_no_formula will be incorrect */
    glass_increase:=0;

/* traversal for every unused blocks with price 0 */
traserval_cnt:=4;
while traserval_cnt<RowId+row_increase do
{
/*    msgbox(isnumber(costsheet.cells[traserval_cnt][1]),costsheet.cells[traserval_cnt][1]);*/
    if costsheet.cells[traserval_cnt][7].Font.Italic=True then
    {
        /*tcell_no:=costsheet.cells[traserval_cnt][1].value;*/
            {
                costsheet.cells[traserval_cnt][6].value:=0;
                costsheet.cells[traserval_cnt][5].value:=0;
            }
    }
    traserval_cnt:=traserval_cnt+1;
}




; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; user1_b_assembly_2_0.j
;


%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail   b_assembly_2_0.j
; 



; Item price

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


CostSheet.Rows[RowId+1+row_increase].select();
excel.Selection.EntireRow.Insert();


tmp_rowid_increase:=RowId+row_increase;

CostSheet.Cells[tmp_rowid_increase+1][1].Value:="A";
costsheet.cells[tmp_rowid_increase+1][1].VerticalAlignment:=-4108;
costsheet.cells[tmp_rowid_increase+1][1].HorizontalAlignment:=-4108;
CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+1][2]][CostSheet.Cells[tmp_rowid_increase+1][2]].merge();
CostSheet.Cells[tmp_rowid_increase+1][2].Value:="材料费小计";

CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+1][3]][CostSheet.Cells[tmp_rowid_increase+1][7]].merge();
CostSheet.Cells[tmp_rowid_increase+1][3].NumberFormat:=CellCostFormat;


s0:=RId+LBr+IntToStr(RowId_0-tmp_rowid_increase-1)+RBr+CId+LBr+"2"+RBr;
s1:=RId+LBr+IntToStr(RowId_1-tmp_rowid_increase-1)+RBr+CId+LBr+"2"+RBr;
s2:=RId+LBr+IntToStr(RowId_2-tmp_rowid_increase-1)+RBr+CId+LBr+"2"+RBr;
if RowId_0=0 then
	s0 := "0";
if RowId_1=0 then
	s1 := "0";
if RowId_2=0 then
	s2 := "0";


Formula0 := "="+SumFormulaText+"("+s0+","+s1+","+s2+")";
CostSheet.Cells[tmp_rowid_increase+1][3].FormulaR1C1:=Formula0;

CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+1][1]][CostSheet.Cells[tmp_rowid_increase+1][8]].Interior.Color:=16777215;

row_increase:=row_increase+1;

RowId_A:=tmp_rowid_increase+1;
/*if GLASSRUN=1 then				/*<most probably>处理增加的玻璃行*/
    /*row_increase:=row_increase+1;*/
