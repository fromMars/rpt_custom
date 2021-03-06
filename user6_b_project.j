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
CostSheet := Template.WorkSheets["玻璃单"];

rowid:=7;

costsheet.range["$A$2"].select();
excel.selection.value:="订货单位:";
costsheet.range["$A$3"].select();
excel.selection.value:="工程名称:%PROJECT%";


%% detail
/**********************************************************/
current_cell := costsheet.Columns["A"].rows[rowid];
current_cell.value := "=row()-6";

current_cell := costsheet.Columns["B"].rows[rowid];
current_cell.value := "@%DB_ATTRIB_ACCDESC%";
current_cell := costsheet.Columns["C"].rows[rowid];
current_cell.value := "%IF{@%Db_ATTRIB_ARTICLECODE%="",'@%DB_ATTRIB_ACC% @%DB_ATTRIB_SERIE%,'@%DB_ATTRIB_ARTICLECODE%}";
current_cell := costsheet.Columns["D"].rows[rowid];
current_cell.value := %Z_PACK_QTY%;
current_cell := costsheet.Columns["E"].rows[rowid];
current_cell.value := "%IF{@%DB_ATTRIB_TYPE%=-2,件,%IF{@%DB_ATTRIB_ARTICLE%=35,m,支}}";
current_cell := costsheet.Columns["F"].rows[rowid];
current_cell.value := %Z_PACK_PRICE%;

rowid:=rowid+1;

%% break header

%% break footer

%% detail footer


costsheet.range[costsheet.cells[rowid][1]][costsheet.cells[rowid][7]].merge();
costsheet.cells[rowid][1].value:="      设计：                     审核：                    批准：";
costsheet.cells[rowid][1].horizontalAlignment:=-4131;
costsheet.cells[rowid][1].RowHeight:="25";

costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][7]].Columns.AutoFit;
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid][7]].Borders.LineStyle:=1;


/*
costsheet.rows[rowid].select();
excel.selection.entirerow.insert();插入行

excel.selection.NumberFormatLocal:="0";修改单元格属性，0代表常规，0.00带表小数点后两位数字

costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][7]].rowheight:=15;指定行高

*/
