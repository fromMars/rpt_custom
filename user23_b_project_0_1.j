/* USER1_B_PROJECT_0_1.J
 * profile articles 16 17 42 positioning together, EOSS2018 changed to 80,85,42
 */


; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; b_project_0_1


cnt_16_17:=0;

%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail
; 

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

if a_link<>"" then                                          /*��¼�۸�������*/
	bList.Add(a_link+"@%DB_COST_LOSSTYPE%");
else
{
	bList.Add("@%DB_COST_ARTICLE%"+"@%DB_COST_LOSSTYPE%");
    if @%DB_COST_ARTICLE%=80 || @%DB_COST_ARTICLE%=85 then
        cnt_16_17:=cnt_16_17+1;                             /*���ͳ�������Ͳ��У���ʼ�иı�*/
}
cList.Add(IntToStr(RowId));                                 /*��¼�к�*/
pList.Add(StrReplace("TempValue",".","%DECIMALSEP%"));      /*��¼�۸�*/
sList.Add(inttostr(RowId));                                 /*��¼�к�*/

/* ��¼�����кŲ����ò����۸��־λ1*/
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
glass_increase:=-1;                                          /*��¼�������������ڱ�ż���*/

CostSheet.Cells[RowId][1].value:=rowid-3;                   /*������*/
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

; Column unit price item
RowId := RowId + 1;
bList.Add("-1");
cList.Add(IntToStr(RowId));
sList.Add(inttostr(RowId));

; Column number of items
RowId := RowId + 1;
bList.Add("-2");
cList.Add(IntToStr(RowId));
sList.Add(inttostr(RowId));

; Column total price item
RowId := RowId + 1;
bList.Add("-3");
cList.Add(IntToStr(RowId));
sList.Add(inttostr(RowId));



recent_count:=count;                                        /*��¼��ǰ״̬*/
recent_colid:=colid;
recent_cost_sheet:=CostSheet;


ColId := ColId + 12;                                        /*��ColId=2����12����λ��������*/
Color := DataSheet.Range["CellFormat"].Interior.Color;

; Initialize prices project level
i := 0;
while (i < cList.Count-3) do                                /*cList�������Ϊ�ܼ�ͳ�ƣ�����*/
{
  RowId       := StrToNum(cList.Strings[i]);                /*��cList�л�ȡ�к�*/
  TempValue   := 0.0;                                       /*��ʱ����*/
  CurrentCell := CostSheet.Cells[RowId][ColId];             /*��λ����ǰ��Ԫ�񣬵�����*/
  CurrentCell0 := CostSheet.Cells[RowId][ColId-1];          /*��λ��������൥Ԫ�񣬵���������*/
  CurrentCell.Value := TempValue;
  CurrentCell0.Value := TempValue;
  CurrentCell.Borders.linestyle := 0;
  i := i + 1;
};


recent_count:=count;                                        /*��¼��ǰ״̬*/
recent_colid:=colid;
recent_cost_sheet:=CostSheet;

total_area:=0;                                              /*��������������ڼ��㹤�̼��۸��*/


