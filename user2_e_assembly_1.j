/* USER1_E_ASSEMBLY_1.J
 * delete lines with price=0 & style=italic
 *                      */


row_check:=3;
row_end:=costsheet.usedrange.rows.count;
while row_check<row_end do
{
    row_check:=row_check+1;
    item_name:=trim(costsheet.cells[row_check][2].text);
    if costsheet.cells[row_check][6].font.italic=True && item_name<>"现场管理费" && item_name<>"企业管理费" then
        if costsheet.cells[row_check][6].value=0 then
        {
            costsheet.rows[row_check].delete();
            row_check:=row_check-1;
        }
}

