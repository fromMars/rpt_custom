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
CostSheet := Template.WorkSheets["������"];

rowid:=7;

costsheet.range["$A$2"].select();
excel.selection.value:="������λ:";
costsheet.range["$A$3"].select();
excel.selection.value:="��������:%PROJECT%";


%% detail
/**********************************************************/
current_cell := costsheet.Columns["A"].rows[rowid];
current_cell.value := "=row()-6";

current_cell := costsheet.Columns["B"].rows[rowid];
current_cell.value := "@%DB_ATTRIB_ACCDESC%";
current_cell := costsheet.Columns["C"].rows[rowid];
current_cell.value := "%IF{@%Db_ATTRIB_ARTICLECODE%="",'@%DB_ATTRIB_ACC% @%DB_ATTRIB_SERIE%,'@%DB_ATTRIB_ARTICLECODE%}";
current_cell := costsheet.Columns["D"].rows[rowid];
current_cell.value := "%IF{@%DB_ATTRIB_TYPE%=-2,%DSP_ATTRIB_NO01%,%IF{@%DB_ATTRIB_SEQNO%=0,%DSP_ATTRIB_LENGTH01%,=@%DB_ATTRIB_NO%*@%DB_ATTRIB_LENGTH%}}";
current_cell := costsheet.Columns["E"].rows[rowid];
current_cell.value := "%IF{@%DB_ATTRIB_TYPE%=-2,��,m}";
current_cell := costsheet.Columns["F"].rows[rowid];
current_cell.value := "=%IF{@%DB_ATTRIB_TYPE%=-3,@%DB_ATTRIB_LENGTH%,@%DB_ATTRIB_NO%}*@%DB_ATTRIB_ITMPRICE%*(1-@%DB_ATTRIB_REBATE%/100)";

rowid:=rowid+1;

%% break header

%% break footer

%% detail footer


costsheet.range[costsheet.cells[rowid][1]][costsheet.cells[rowid][7]].merge();
costsheet.cells[rowid][1].value:="      ��ƣ�                     ��ˣ�                    ��׼��";
costsheet.cells[rowid][1].horizontalAlignment:=-4131;
costsheet.cells[rowid][1].RowHeight:="25";

costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][7]].Columns.AutoFit;
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid][7]].Borders.LineStyle:=1;


/*
costsheet.rows[rowid].select();
excel.selection.entirerow.insert();������

excel.selection.NumberFormatLocal:="0";�޸ĵ�Ԫ�����ԣ�0�����棬0.00����С�������λ����

costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][7]].rowheight:=15;ָ���и�

*/
