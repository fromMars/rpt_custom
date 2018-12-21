/* USER1_B_ASSEMBLY_1_END.J
 * add summary rows for accessories*/

if GLASSRUN=0 then
{
    if RowZZ=-1 then
        RowZZ:=rowid+row_increase-1;                    /* adjust rowzz to real row position */
    /*CostSheet.Rows[RowZZ+1+cnt_16_17].select();*/
    CostSheet.Rows[RowZZ+2].select();
    excel.Selection.EntireRow.Insert();
    excel.Selection.EntireRow.Insert();

    /*tmp_rowid_increase:=RowZZ+cnt_16_17;*/
    tmp_rowid_increase:=RowZZ+1;


    CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+1][1]][CostSheet.Cells[tmp_rowid_increase+2][1]].merge();
    CostSheet.Cells[tmp_rowid_increase+1][1].Value:="小计";
    costsheet.cells[tmp_rowid_increase+1][1].VerticalAlignment:=-4108;
    costsheet.cells[tmp_rowid_increase+1][1].HorizontalAlignment:=-4108;

    CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+1][2]][CostSheet.Cells[tmp_rowid_increase+1][3]].merge();

    FJ_Row:=tmp_rowid_increase+1;
    CostSheet.Rows[FJ_Row].hidden:=True;
    CostSheet.Cells[tmp_rowid_increase+1][2].Value:="附件损耗";
    CostSheet.Cells[tmp_rowid_increase+2][2].Value:="附件小计";
    CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+2][2]][CostSheet.Cells[tmp_rowid_increase+2][3]].merge();
    CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+1][5]][CostSheet.Cells[tmp_rowid_increase+1][7]].merge();
    CostSheet.Cells[tmp_rowid_increase+1][5].value:=0;
    CostSheet.Cells[tmp_rowid_increase+1][5].NumberFormatLocal:="0.0%";
    CostSheet.Range[CostSheet.Cells[tmp_rowid_increase+2][5]][CostSheet.Cells[tmp_rowid_increase+2][7]].merge();
    costsheet.cells[tmp_rowid_increase+2][5].NumberFormat:=CellCostFormat;

    /*Formula1 := "="+SumFormulaText+"("+RId+LBr+IntToStr(recent_rowid-tmp_rowid_increase-2-cnt_16_17)+RBr+CId+LBr+"2"+RBr+":"+RId+LBr+"-2"+RBr+CId+Lbr+"2"+RBr+")*(1+"+RId+LBr+"-1"+RBr+CId+")";*/
    Formula1 := "="+SumFormulaText+"("+RId+LBr+IntToStr(recent_rowid-tmp_rowid_increase-2-cnt_16_17)+RBr+CId+LBr+"2"+RBr+":"+RId+LBr+"-2"+RBr+CId+Lbr+"2"+RBr+")*(1+"+RId+LBr+"-1"+RBr+CId+")";
    CostSheet.Cells[tmp_rowid_increase+2][5].FormulaR1C1:=Formula1;

    /*CostSheet.Range[CostSheet.Cells[RowZZ+cnt_16_17+1][1]][CostSheet.Cells[RowZZ+cnt_16_17+1][8]].Interior.Color:=14935011;
    CostSheet.Range[CostSheet.Cells[RowZZ+cnt_16_17+2][1]][CostSheet.Cells[RowZZ+cnt_16_17+2][8]].Interior.Color:=14935011;*/
    CostSheet.Range[CostSheet.Cells[RowZZ+2][1]][CostSheet.Cells[RowZZ+2][8]].Interior.Color:=14935011;
    CostSheet.Range[CostSheet.Cells[RowZZ+3][1]][CostSheet.Cells[RowZZ+3][8]].Interior.Color:=14935011;

    
    rowid:=rowzz;
    rowid:=rowid-row_increase;  /*seems useless, will cause below summary rows wrong override current summary rows*/

    /*row_increase:=row_increase+2+cnt_16_17;*/
    row_increase:=row_increase+3;
    RowId_1:=tmp_rowid_increase+2;
    list_no_formula:="=row()-"+inttostr(row_increase+3);

    /*rowid:=rowzz;*/
}
