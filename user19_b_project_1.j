; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 
; Retrive profiles
;


;-------------------------------------------------------------------------------
%%detail
;-------------------------------------------------------------------------------

first_row.select();
excel.selection.entirerow.insert();
rowid:=first_row.row-1;
first_row.entirerow.copy();
curr_sheet.rows[rowid].entirerow.select();
curr_sheet.paste;


/*curr_cell:=curr_sheet.cells[rowid][1];
curr_cell.value:=(rowid-init_rowid+2)/2;*/

curr_cell:=curr_sheet.cells[rowid][1];
curr_cell.value:=@%DB_ATTRIB_TYPE%;
curr_cell:=curr_sheet.cells[rowid][2];
curr_cell.value:=%GLOBAL_PRICE_PROFILE%;
curr_cell:=curr_sheet.cells[rowid][3];
curr_cell.value:=@%DB_ATTRIB_NO%;
curr_cell:=curr_sheet.cells[rowid][4];
curr_cell.value:="@%DB_ATTRIB_ACC%";
curr_cell:=curr_sheet.cells[rowid][5];
curr_cell.value:="@%DB_ATTRIB_SERIE%";
curr_cell:=curr_sheet.cells[rowid][6];
curr_cell.value:="@%DB_ATTRIB_VARIETY%";
curr_cell:=curr_sheet.cells[rowid][7];
curr_cell.value:="@%DB_ATTRIB_VARIETYDESC%";
curr_cell:=curr_sheet.cells[rowid][8];
curr_cell.value:="@%DB_ATTRIB_ACCDESC%";
curr_cell:=curr_sheet.cells[rowid][9];
curr_cell.value:="@%DB_ATTRIB_ARTICLECODE%";
curr_cell:=curr_sheet.cells[rowid][10];
curr_cell.value:=@%DB_ATTRIB_RATE%;
curr_cell:=curr_sheet.cells[rowid][11];
curr_cell.value:=@%DB_ATTRIB_PACKSIZE%;
curr_cell:=curr_sheet.cells[rowid][12];
curr_cell.value:=@%DB_ATTRIB_LENGTH%;
curr_cell:=curr_sheet.cells[rowid][13];
curr_cell.value:=@%DB_ATTRIB_ERROR%;
curr_cell:=curr_sheet.cells[rowid][14];
curr_cell.value:=@%DB_ATTRIB_PRICE%;


;-------------------------------------------------------------------------------
%% break header
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
%% break footer
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
%% detail footer
;-------------------------------------------------------------------------------
