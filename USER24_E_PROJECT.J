/* USER1_E_PROJECT.J
 * Summary Table
 *                      */

helpsheet:=template.worksheets['Help'];
helpsheet.activate();
sheet_count:=template.worksheets.count-3;
helpsheet.cells[1][1].value:="%PROJECT_TEXT%";

c_cnt:=1;
c_name:=2;
c_type:=3;
c_size_w:=4;
c_size_h:=5;
c_qty:=6;
c_weight0:=7;
c_weight1:=8;
c_area:=9;
c_price_per_assembly:=10;
c_price_per_area:=11;
c_price_summary:=12;

p_start:=4;
s0:=1;
while s0<=sheet_count do
{
    tmp:=template.worksheets[s0];
    s:=s0+3;
    
    p_end:=excel.worksheetfunction.match("型材小计",tmp.range[tmp.cells[1][2]][tmp.cells[100][2]],0);
    p_end:=p_end-2;                     /* move up 2 row to skip the profile summary lines*/
                         
    v_cnt:='=row()-3';
    v_name:=tmp.name;
    v_type:='';
    v_size_w:=0;
    v_size_h:=0;
    v_qty:=0;
    v_area:="='"+v_name+"'!mianji";
    v_price_per_area:="='"+v_name+"'!danjia";
    v_price_per_assembly:="='"+v_name+"'!danjia*'"+v_name+"'!mianji";
    v_price_summary:='=RC[-2]*RC[-6]';
    
    formula_kg0:="=SUMIF('"+v_name+"'!B"+inttostr(p_start)+":B"+inttostr(p_end)+',"<>*隔热*",'+"'"+v_name+"'!D"+inttostr(p_start)+":D"+inttostr(p_end)+")";
    formula_kg1:="=SUMIF('"+v_name+"'!B"+inttostr(p_start)+":B"+inttostr(p_end)+',"*隔热*",'+"'"+v_name+"'!D"+inttostr(p_start)+":D"+inttostr(p_end)+")";
    
    helpsheet.cells[s][c_cnt].formula:=v_cnt;
    helpsheet.cells[s][c_name].value:=substr(v_name,6,strlen(v_name));
    helpsheet.cells[s][c_type].value:=v_type;
    /*helpsheet.cells[s][c_size_w].value:=v_size_w;
    helpsheet.cells[s][c_size_h].value:=v_size_h;
    helpsheet.cells[s][c_qty].value:=v_qty;*/
    
    helpsheet.cells[s][c_weight0].formula:=formula_kg0;
    helpsheet.cells[s][c_weight1].formula:=formula_kg1;
    helpsheet.cells[s][c_weight0].formular1c1:=helpsheet.cells[s][c_weight0].formular1c1+"*RC[-1]";
    helpsheet.cells[s][c_weight1].formular1c1:=helpsheet.cells[s][c_weight1].formular1c1+"*RC[-2]";
    
    
    helpsheet.cells[s][c_area].formulaR1C1:=v_area+"*RC[-3]";
    helpsheet.cells[s][c_price_per_assembly].formula:=v_price_per_assembly;
    helpsheet.cells[s][c_price_per_area].formula:=v_price_per_area;
    helpsheet.cells[s][c_price_summary].formular1c1:=v_price_summary;
    
    s0:=s0+1;
    
}

s:=s0+3;
helpsheet.range[helpsheet.cells[s][1]][helpsheet.cells[s][2]].merge();
helpsheet.cells[s][1].value:='小计';
helpsheet.cells[s][1].horizontalalignment:=-4108;
helpsheet.cells[s][6].select();
helpsheet.cells[s][6].formular1c1:='=sum(R[-'+inttostr(s0-1)+']C:R[-1]C)';
helpsheet.cells[s][9].select();
helpsheet.cells[s][9].formular1c1:='=sum(R[-'+inttostr(s0-1)+']C:R[-1]C)';

helpsheet.range[helpsheet.cells[s+1][1]][helpsheet.cells[s+1][2]].merge();
helpsheet.cells[s+1][1].value:='合计';
helpsheet.cells[s+1][1].horizontalalignment:=-4108;
helpsheet.cells[s+1][12].select();
helpsheet.cells[s+1][7].formular1c1:='=sum(R[-'+inttostr(s0)+']C:R[-2]C)';
helpsheet.cells[s+1][8].formular1c1:='=sum(R[-'+inttostr(s0)+']C:R[-2]C)';
helpsheet.cells[s+1][12].formular1c1:='=sum(R[-'+inttostr(s0)+']C:R[-2]C)';

helpsheet.usedrange.borders.linestyle:=1;


/*set additional weight to 0%*/
DataSheet.Range["AWRate"].value:=0;
/* add remarks for profile weight */
helpsheet.range[helpsheet.cells[s+3][1]][helpsheet.cells[s+3][12]].merge();
helpsheet.cells[s+3][1].formula:='="备注：型材用量(kg)包含"&Text(Data!AWRate,"0.00%")&"附加重量。"';
helpsheet.cells[s+3][1].font.colorindex:=32;
helpsheet.cells[s+3][1].font.bold:=False;
helpsheet.cells[s+3][1].font.size:=10;
helpsheet.cells[s+3][1].verticalalignment:=-4107;	/* L:-4131 C:-4108 R:-4152 */
helpsheet.cells[s+3][1].interior.color:=65535;

/* add warning for excel use only */
helpsheet.range[helpsheet.cells[s+4][1]][helpsheet.cells[s+5][12]].merge();
helpsheet.cells[s+4][1].value:="（为保证公式的一致性，请使用微软Office Excel打开本文档！）";
helpsheet.cells[s+4][1].font.color:=255;
helpsheet.cells[s+4][1].font.bold:=False;
helpsheet.cells[s+4][1].font.size:=9;
helpsheet.cells[s+4][1].verticalalignment:=-4108;	/* L:-4131 C:-4108 R:-4152 */
helpsheet.cells[s+4][1].interior.color:=65535;

helpsheet.columns.Autofit;


helpsheet.move(template.worksheets[1]);
helpsheet.name:="汇总";

excel.DisplayAlerts:=True;


