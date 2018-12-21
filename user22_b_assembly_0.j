/* USER1_B_ASSEMBLY_0.J
 * show profile prices */


Count:=recent_count;
ColId:=recent_colid;                                            /*14 ������*/
CostSheet:=recent_cost_sheet;                                   /*sheet "COST"*/

CostSheet.Copy(CostSheet);                                      /*����sheet*/
cnt := Template.WorkSheets.Count-3;

template_cost:=Template.WorkSheets[cnt];
template_cost.Name := "Cost_"+trim("%ASSEMBLY_TEXT%");
template_cost.Activate();

CostSheet:=template_cost;

CostSheet.Range["RateRows"].Delete;
ColId:=ColId-8;


recent_rowid:=-1;                                               /*��¼С����ǰ���һ��λ��*/

glass_increase:=-1;
fix_increase:=0;

curr_assembly:=getcurrentproject().projectdata.currentassembly; /*��ȡEditor�д������*/
assembly_cnt:=getcurrentproject().projectdata.childcount;       /*�Ӷ�������*/
i_cnt:=0;
/*��ȡ��ǰ���㴰�����*/
while i_cnt<assembly_cnt do
{
    curr_assembly:=getcurrentproject().projectdata.children[i_cnt];
    if curr_assembly.code="%ASSEMBLY_TEXT%" then
        break;
    i_cnt:=i_cnt+1;
}

img_no:=i_cnt;

/*��������*/
/*curr_name:=curr_assembly.code;*/
costsheet.range["chuanghao"].value:=curr_assembly.code;

/*���*/
f_cnt:=0;
curr_frame:=curr_assembly.children[0];
frame_cnt:=curr_assembly.childcount;
a_mianji:=0;
/*����ͬһ�����Frame�ĳߴ磬���Ϊ�����*/
while f_cnt<frame_cnt do
{
    curr_frame:=curr_assembly.children[f_cnt];
    f_width:=curr_frame.width;
    f_height:=curr_frame.height;
    if f_cnt=0 then
    {
        helpsheet.cells[help_cnt][4].value:=f_width;            /*helpsheet����ߴ�_��*/
        helpsheet.cells[help_cnt][5].value:=f_height;           /*helpsheet����ߴ�_��*/
    }
    if f_cnt>0 then
    {
        helpsheet.cells[help_cnt][4].value:='';                  /*������*/
        helpsheet.cells[help_cnt][5].value:='';                  /*����д*/
    }
    f_mianji:=f_width*f_height;
    a_mianji:=a_mianji+f_mianji;
    f_cnt:=f_cnt+1;
}
curr_surface:=a_mianji/1000000;
/* modify mianji to FRAMEAREA2  --20180614*/
costsheet.range["mianji"].value:=getparam("FRAMEAREA2");
/*costsheet.range["mianji"].value:=curr_surface;*/
costsheet.range["mianji"].HorizontalAlignment:=-4131;
costsheet.range["mianji"].offset[0][-1].HorizontalAlignment:=-4152;

a_fee_row:=0;

/*used to calculate A*/
RowId_0:=0;
RowId_1:=0;
RowId_2:=0;
RowId_A:=0;

/*�������кţ����ڴ����޲�������С����*/
RowZZ:=-1;

/*��������������Լ��㹤�̼��۸��*/
total_area:=total_area+curr_surface*%ASSEMBLYCOUNT%;
cost_ori:=template.worksheets["cost"];
cost_ori.range["mianji"].value:=total_area;

/*���ͼ�����������XXX_E_PROJECT.J����*/
/*���ļ�����������������������ߴ�Ŀ��ֵ*/
helpsheet.cells[help_cnt][3].value:='';                           /*����*/
helpsheet.cells[help_cnt][6].value:="%ASSEMBLYCOUNT%";             /*����*/
help_cnt:=help_cnt+1;


P_PT:=strings.create();     /*��Ϳ�Ͳ�*/
P_PT.add("2");
P_PT.add("4");
P_PT.add("5");
P_PT.add("6");
P_PT.add("7");
P_PT.add("8");
P_PT.add("10");
P_PT.add("18");
P_PT.add("19");
P_PT.add("42");
P_J:="29";                  /*����Ͳ�*/
P_YH:="9";                 /*�����Ͳ�*/
P_K:="12";                  /*���ȿ��Ͳ�*/
P_SH:="14";                 /*�������Ͳ�*/
P_T:="13";                  /*�������Ͳ�*/
P_QT:="15";                 /*���������Ͳ�*/

; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)  b_assembly_0.j
; 

colid:=6;                                                   /*������*/
Count := Count + 1;
ColId := ColId + 1;                                         /*�����*/
Color := DataSheet.Range["CellFormat"].Interior.Color;

/*��ʼ������۸�*/
i := 0;
while (i < cList.Count-3) do
{
  RowId       := StrToNum(cList.Strings[i]);
  TempValue   := 0.0;
  CurrentCell := CostSheet.Cells[RowId][ColId];             /*�����*/
  CurrentCell.Value := TempValue;
  currentcell.NumberFormat:=CellCostFormat;
  CurrentCell1 := CostSheet.Cells[RowId][ColId-1];          /*������*/
  if CurrentCell1.Value=0 then
    CurrentCell1.Value := TempValue;
  currentcell1.NumberFormat:=CellCostFormat;
  CurrentCell0 := CostSheet.Cells[RowId][ColId-2];          /*����������*/
  if CurrentCell0.value=0 then
    CurrentCell0.Value := TempValue;
  CurrentCell.Font.Italic := True;
  CurrentCell.Interior.Color := Color;
  CurrentCell.Borders.LineStyle := 1;
  i := i + 1;
};

/*calculate follow artikels, recent_profile_value-recent TempValue[string],tmp_tmp_value-current TempValue[string]*/
/*�������۸��*/
recent_profile_value:="0";
tmp_tmp_value:="0";

a_linked:=strings.create();                                 /*��¼����۸��*/
z_pg:=pricegroups.create();

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
    if a_link<>"" && a_linked.indexof(a_link)=-1 then       /*����۸�������δ��¼*/
        a_linked.add(a_link);                               /*���¼�ü۸��*/
}
else
{
	msgbox("no article block "+inttostr(z_pg.code.block)+" found!");
}


/*��ȡ�к�*/
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

tmp_atk:="@%DB_COST_ARTICLE%";
if P_PT.indexof(tmp_atk)<>-1 
    || P_J=tmp_atk 
    || P_YH=tmp_atk 
    || P_K=tmp_atk 
    || P_SH=tmp_atk 
    || P_T=tmp_atk 
    || P_QT=tmp_atk then
{    
    if (StrToNum(StrReplace(pList.Strings[cList.IndexOf(IntToStr(RowId))],"%DECIMALSEP%","."),0) > 0) then
    {
    CurrentCell := CostSheet.Cells[RowId][ColId];
    TempFormula := "=RC[-2]*RC[-1]";
    
    CurrentCell.FormulaR1C1 := TempFormula;
    CurrentCell.Interior.Color := Color;
    CurrentCell.Borders.LineStyle := 1;
    }
    else
    {
    CurrentCell := CostSheet.Cells[RowId][ColId];
    TempFormula :="=RC[-2]*RC[-1]";
    
    CurrentCell.Formula := TempFormula;
    CurrentCell.Font.Italic := False;
    CurrentCell.Interior.Color := Color;
    CurrentCell.Borders.LineStyle := 1;
    }
}
else
{
    if (StrToNum(StrReplace(pList.Strings[cList.IndexOf(IntToStr(RowId))],"%DECIMALSEP%","."),0) > 0) then
    {
    CurrentCell := CostSheet.Cells[RowId][ColId];
    TempValue   := StrReplace("@%DB_PIECE_PRICE%/%ASSEMBLYCOUNT%",".","%DECIMALSEP%");
    /*��ǰ�۸������ǰ�۸�鱻����-true������-false*/
    if a_link<>"" || a_linked.indexof("@%DB_COST_ARTICLE%")<>-1 then
    {
        /*Ϊcurrent_profile_value���浱ǰtempvalue(recent_profile_value)*/
        tmp_tmp_value:=tempvalue;
        curr_profile_value:="((((((((("+recent_profile_value+")*("+CellCT+"))*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
        tx:=currentcell.formula;
        ty:=currentcell.value;
        if tx<>"0" then
            TempFormula := currentcell.formula+"+(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))";
        else
            TempFormula := "=(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))"; /*ɾ��curr_profile_value, "...))+"+current_profile_value;*/
        /*TempFormula := "=((((((((("+TempValue+")*("+CellCT+"))*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))+"+current_profile_value;*/       /*���curr_profile_value, "...))+"+current_profile_value;*/
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
                TempFormula := "=(((((((("+TempValue+")*(1+"+CellC1+"))*(1-"+CellC2+"))*"+CellC7+")*"+CellC3+")*(1+"+CellC6+"))*(1+"+CellC4+"))*(1-"+CellC5+"))"; /*ɾ��curr_profile_value, "...))+"+current_profile_value;*/
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
}

; Item formula
/*
TempFormula := '=Indirect(address('+sList.Strings[cList.IndexOf(IntToStr(RowId))]+','+IntToStr(ColId)+',,,"Cost"))*Indirect(address('+sList.Strings[bList.IndexOf("-2")]+','+IntToStr(ColId)+',,,"Cost"))';
CurrentCell := HelpSheet.Cells[RowId][ColId];
CurrentCell.Formula := TempFormula;
CurrentCell.Font.Italic := %IF{@%DB_RES_PRICE%,False,True};
CurrentCell.Interior.Color := Color;
CurrentCell.Borders.LineStyle := 1;*/



;�Ͳĵ�λ
un_colid:=3;
currentcell:=costsheet.cells[rowid][un_colid];
currentcell.value:="kg";
currentcell.HorizontalAlignment:=-4108;
if @%DB_COST_ARTICLE%=16 || @%DB_COST_ARTICLE%=17 then
{
    currentcell.value:="";
}


;��Ӧ��
s_colid:=colid+1;
currentcell:=costsheet.cells[rowid][s_colid];
currentcell.value:="%DSP_PIECE_SUPPLIER%";
if trim(currentcell.value)="EOSS" || trim(currentcell.value)="EOSSPROF" then
    currentcell.value:="������ŷ˼"+trim("%DSP_PIECE_SYSTEM%")+"ϵ���Ͳ�";
currentcell.borders.linestyle:=1;


;��λ�������
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
if @%DB_COST_ARTICLE%=16 || @%DB_COST_ARTICLE%=17 then
{
    currentcell.value:="";
}



;����
u_colid:=colid-1;
currentcell:=costsheet.cells[rowid][u_colid];
u_recent_value:=currentcell.value;
;tmp_atk:="@%DB_COST_ARTICLE%";
if P_PT.indexof(tmp_atk)<>-1 then
    currentcell.formula:="=Data!PRICE_PT";
else if P_J=tmp_atk then
    currentcell.formula:="=Data!PRICE_J";
else if P_YH=tmp_atk then
    currentcell.formula:="=Data!PRICE_YH";
else if P_K=tmp_atk then
    currentcell.formula:="=Data!PRICE_K";
else if P_SH=tmp_atk then
    currentcell.formula:="=Data!PRICE_SH";
else if P_T=tmp_atk then
    currentcell.formula:="=Data!PRICE_T";
else if P_QT=tmp_atk then
    currentcell.formula:="=Data!PRICE_QT";
else
{
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
}


if @%DB_COST_ARTICLE%=16 || @%DB_COST_ARTICLE%=17 then
{
    currentcell.value:="";
}
currentcell.borders.linestyle:=1;

/*����۸������ã�����tempvalue������recent_profile_value�У��´μ�����*/
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


/*����С���У�rowid��Ϊ���һ�������У�row_increaseΪ��������*/
CostSheet.Rows[RowId+1].select();
excel.Selection.EntireRow.Insert();
excel.Selection.EntireRow.Insert();
row_increase:=2;

CostSheet.Range[CostSheet.Cells[RowId+1][1]][CostSheet.Cells[RowId+2][1]].merge();
CostSheet.Cells[RowId+1][1].Value:="С��";
costsheet.cells[rowid+1][1].VerticalAlignment:=-4108;
costsheet.cells[rowid+1][1].HorizontalAlignment:=-4108;
CostSheet.Range[CostSheet.Cells[RowId+1][2]][CostSheet.Cells[RowId+1][3]].merge();

FJ_Row:=RowId+1;
CostSheet.Rows[FJ_Row].hidden:=True;
CostSheet.Cells[RowId+1][2].Value:="�Ͳ����";
CostSheet.Range[CostSheet.Cells[RowId+2][2]][CostSheet.Cells[RowId+2][3]].merge();
CostSheet.Cells[RowId+2][2].Value:="�Ͳ�С��";
CostSheet.Range[CostSheet.Cells[RowId+1][5]][CostSheet.Cells[RowId+1][7]].merge();

/*�Ͳ����*/
CostSheet.Cells[RowId+1][5].value:=0;
CostSheet.Cells[RowId+1][5].NumberFormatLocal:="0.0%";
CostSheet.Range[CostSheet.Cells[RowId+2][5]][CostSheet.Cells[RowId+2][7]].merge();
costsheet.cells[rowid+2][5].NumberFormat:=CellCostFormat;

/*�Ͳ�С��*/
Formula1 := "="+SumFormulaText+"("+RId+LBr+IntToStr(recent_rowid-rowid-2)+RBr+CId+LBr+"2"+RBr+":"+RId+LBr+"-2"+RBr+CId+Lbr+"2"+RBr+")*(1+"+RId+LBr+"-1"+RBr+CId+")";
CostSheet.Cells[RowId+2][5].FormulaR1C1:=Formula1;

/*����ɫ*/
CostSheet.Range[CostSheet.Cells[RowId+1][1]][CostSheet.Cells[RowId+1][8]].Interior.Color:=14935011;
CostSheet.Range[CostSheet.Cells[RowId+2][1]][CostSheet.Cells[RowId+2][8]].Interior.Color:=14935011;

Rowid_0:=RowId+2;


