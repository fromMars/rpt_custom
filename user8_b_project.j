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
CostSheet := Template.WorkSheets["配件清单"];

base_rowid:=7;
rowid:=base_rowid;

costsheet.range["$A$2"].select();
excel.selection.value:="订货单位:";
costsheet.range["$A$3"].select();
excel.selection.value:="工程名称:%PROJECT%";

full_list:=array.create();


%% detail
/**********************************************************/
costsheet.cells[rowid][1].select();
excel.selection.entirerow.insert(-4121, 1);

row_list:=array.create();
tmp_value:="=row()-6";
row_list.add(tmp_value);
tmp_value:="@%DB_ATTRIB_ACCDESC%";
row_list.add(tmp_value);
tmp_value:="%IF{@%Db_ATTRIB_ARTICLECODE%="",'@%DB_ATTRIB_ACC% @%DB_ATTRIB_SERIE%,'@%DB_ATTRIB_ARTICLECODE%}";
row_list.add(tmp_value);
tmp_value:="@%DB_ATTRIB_VARIETYDESC%";
row_list.add(tmp_value);
tmp_value:="%IF{@%DB_ATTRIB_TYPE%=-2,件,m}";
row_list.add(tmp_value);
tmp_value:="%IF{@%DB_ATTRIB_TYPE%=-1,=@%DB_ATTRIB_ITMPRICE%/@%DB_ATTRIB_LENGTH%*(1-@%DB_ATTRIB_REBATE%/100),=@%DB_ATTRIB_ITMPRICE%*(1-@%DB_ATTRIB_REBATE%/100)}";
row_list.add(tmp_value);
tmp_value:="%IF{@%DB_ATTRIB_TYPE%=-2,%DSP_ATTRIB_NO01%,%IF{@%DB_ATTRIB_SEQNO%=0,%DSP_ATTRIB_LENGTH01%,=@%DB_ATTRIB_NO%*@%DB_ATTRIB_LENGTH%}}";
row_list.add(tmp_value);
tmp_value:="=Ceiling(%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_NO%,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_NO%,@%DB_ATTRIB_LENGTH%}}/%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%,%IF{@%DB_ATTRIB_TYPE%=-1,1,@%DB_ATTRIB_PACKSIZE%}},1)*%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_LENGTH%,@%DB_ATTRIB_PACKSIZE%}}";
row_list.add(tmp_value);
tmp_value:="%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%p,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_LENGTH%m,@%DB_ATTRIB_PACKSIZE%m}}";
row_list.add(tmp_value);


cnt:=0;
while cnt<row_list.length-0 do
{
    costsheet.cells[rowid][cnt+1].value:=row_list[cnt];
    cnt:=cnt+1;
}
;costsheet.range[costsheet.cells[rowid][1]][costsheet.cells[rowid][9]]:=;


full_list.add(row_list);
row_list.free();
rowid:=rowid+1;

%% break header

%% break footer

%% detail footer

;costsheet.range[costsheet.cells[base_rowid][1]][costsheet.cells[rowid-1][9]]:=full_list;

full_list.free();
costsheet.range[costsheet.cells[rowid][1]][costsheet.cells[rowid][10]].merge();
costsheet.cells[rowid][1].value:="      设计：                     审核：                    批准：";
costsheet.cells[rowid][1].horizontalAlignment:=-4108;
costsheet.cells[rowid][1].RowHeight:="25";

costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][10]].Columns.AutoFit;
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid][10]].Borders.LineStyle:=1;




/*

costsheet.Columns["E"].rows[rowid].select();
excel.selection.value:="%IF{@%DB_ATTRIB_TYPE%=-2,件,m}";

costsheet.rows[rowid].select();
excel.selection.entirerow.insert();插入行

excel.selection.NumberFormatLocal:="0";修改单元格属性，0代表常规，0.00带表小数点后两位数字
costsheet.range[costsheet.cells[6][8]][costsheet.cells[rowid][8]].NumberFormatLocal:="0";
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][7]].rowheight:=15;指定行高

*/
