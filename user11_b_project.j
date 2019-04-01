; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%)
; 

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
TemplateFile := FileSearch("%XLT_TEMPLATE%.XLT", "%PATH_DATA%");
if templatefile = "" || !FileExists(templatefile) then
{
  ErrMsg := "Cannot find template <%XLT_TEMPLATE%.XLT> in <%PATH_DATA%>!";
  goto generalerror;
}
Template := excel.workbooks.add(TemplateFile);
if !IsIDispatch(Template) then
{
  ErrMsg := "Open <" + TemplateFile + "> failed!";
  goto generalerror;
}
Template.Author := "%DB_USERDESC%";

if excel.worksheets.count>0 then
{
	curr_sheet:=template.worksheets["¶©»õÃ÷Ï¸µ¥"];
}
else
{
	ErrMsg:="no sheet found in "+TemplateFile+" file!";
	goto generalerror;
}

_rowid := 4;
rowid := _rowid;

;------------------------------------------------------------------------
%%detail
;------------------------------------------------------------------------

curr_cell := curr_sheet.cells[_rowid][1];
curr_cell.formula := "=row()-3";

curr_cell := curr_sheet.cells[_rowid][2];
curr_cell.value := "%DSP_ATTRIB_ACC%";

curr_cell := curr_sheet.cells[_rowid][3];
curr_cell.value := "%DSP_ATTRIB_ACCDESC%";

curr_cell := curr_sheet.cells[_rowid][4];
curr_cell.value := "%DSP_ATTRIB_NO%";

curr_cell := curr_sheet.cells[_rowid][5];
curr_cell.value := "%DSP_ATTRIB_LENGTH%";

curr_cell := curr_sheet.cells[_rowid][6];
curr_cell.value := "";

curr_sheet.rows[_rowid].entirerow.select();
excel.selection.insert();

rowid := rowid + 1;

;------------------------------------------------------------------------
%% detail footer
;------------------------------------------------------------------------

curr_sheet.rows[_rowid].entirerow.delete();
curr_sheet.range[curr_sheet.cells[_rowid][7]][curr_sheet.cells[rowid-1][7]].merge();
curr_sheet.cells[2][1].select();
