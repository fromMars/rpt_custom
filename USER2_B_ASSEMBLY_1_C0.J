/* USER1_B_ASSEMBLY_1_C0.J
 * get handling tab values from 
 * charge table correct quantity 
 * per assembly */



; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 


%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail   b_assembly_1_C0.j
; 



if @%DB_CHARGE_QUANTITY%<>0 then
{
    /*currentcell.formulaR1C1:="=@%DB_CHARGE_QUANTITY%/%ASSEMBLYCOUNT%";*/
    /*currentcell0.value:="处";*/
    
    total_area:=total_area-curr_surface*%ASSEMBLYCOUNT%;
    curr_surface:=@%DB_CHARGE_QUANTITY%/%ASSEMBLYCOUNT%;
    /*工程总面积，用以计算工程级价格块*/
    total_area:=total_area+curr_surface*%ASSEMBLYCOUNT%;
    cost_ori:=template.worksheets["cost"];
    cost_ori.range["mianji"].value:=total_area;
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


