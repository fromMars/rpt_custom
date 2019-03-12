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

rowid:=7;

costsheet.range["$A$2"].select();
excel.selection.value:="订货单位:";
costsheet.range["$A$3"].select();
excel.selection.value:="工程名称:%PROJECT%";


%% detail
/**********************************************************/
costsheet.cells[rowid][1].RowHeight:="50";

current_cell := costsheet.Columns["A"].rows[rowid];
current_cell.value:="=row()-6";

;costsheet.Columns["B"].rows[rowid].select();
costsheet.Columns["B"].rows[rowid].value:="@%DB_ATTRIB_ACCDESC%";
;costsheet.Columns["C"].rows[rowid].select();
costsheet.Columns["C"].rows[rowid].value:="%IF{@%Db_ATTRIB_ARTICLECODE%="",'@%DB_ATTRIB_ACC% @%DB_ATTRIB_SERIE%,'@%DB_ATTRIB_ARTICLECODE%}";
;costsheet.Columns["D"].rows[rowid].select();
costsheet.Columns["D"].rows[rowid].value:="@%DB_ATTRIB_VARIETYDESC%";
;costsheet.Columns["E"].rows[rowid].select();
costsheet.Columns["E"].rows[rowid].value:="%IF{@%DB_ATTRIB_TYPE%=-2,件,m}";
;costsheet.Columns["F"].rows[rowid].select();

costsheet.Columns["F"].rows[rowid].value:="%IF{@%DB_ATTRIB_TYPE%=-1,=@%DB_ATTRIB_ITMPRICE%/@%DB_ATTRIB_LENGTH%*(1-@%DB_ATTRIB_REBATE%/100),=@%DB_ATTRIB_ITMPRICE%*(1-@%DB_ATTRIB_REBATE%/100)}";
/*current_cell.value:="=@%DB_ATTRIB_ITMPRICE%*(1-@%DB_ATTRIB_REBATE%/100)";*/
;costsheet.Columns["G"].rows[rowid].select();
costsheet.Columns["G"].rows[rowid].value:="%IF{@%DB_ATTRIB_TYPE%=-2,%DSP_ATTRIB_NO01%,%IF{@%DB_ATTRIB_SEQNO%=0,%DSP_ATTRIB_LENGTH01%,=@%DB_ATTRIB_NO%*@%DB_ATTRIB_LENGTH%}}";
;costsheet.Columns["H"].rows[rowid].select();
costsheet.Columns["H"].rows[rowid].value:="=Ceiling(%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_NO%,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_NO%,@%DB_ATTRIB_LENGTH%}}/%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%,%IF{@%DB_ATTRIB_TYPE%=-1,1,@%DB_ATTRIB_PACKSIZE%}},1)*%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_LENGTH%,@%DB_ATTRIB_PACKSIZE%}}";


;costsheet.Columns["I"].rows[rowid].select();
costsheet.Columns["I"].rows[rowid].value:="%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%p,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_LENGTH%m,@%DB_ATTRIB_PACKSIZE%m}}";

;costsheet.Columns["J"].rows[rowid].select();
acc:=trim("%DSP_ATTRIB_ACC%");
costsheet.Columns["J"].rows[rowid].value:="       ";

pos1:=costsheet.Columns["J"].rows[rowid].left+2;
pos2:=costsheet.Columns["J"].rows[rowid].top+2;
/*pos2:=costsheet.Columns["J"].rows[rowid].right;
pos_h:=(pos1+pos2)/2;
pos1:=costsheet.Columns["J"].rows[rowid].top;
pos2:=costsheet.Columns["J"].rows[rowid].bottom;
pos_v:=(pos1+pos2)/2;*/
CurPro := GetCurrentProject();
IF CurPro = Nil THEN halt; /* no project loaded */
fn1 := ChangeFileExt(ExtractFilename(CurPro.Filename),''); 
fn0 := InterpreteString('%PATH_RESULT%')+'\';
fn := fn0 + fn1 + " 配件清单(图)" + '_' + inttostr(slot_user9) +'_' + acc + '.bmp';
costsheet.shapes.addpicture(fn,0,1,pos1,pos2,-1,-1);
/*costsheet.shapes.addpicture(fn,0,1,costsheet.cells[3][9].left,costsheet.cells[3][9].top,-1,-1);*/


rowid:=rowid+1;

%% break header

%% break footer

%% detail footer


costsheet.range[costsheet.cells[rowid][1]][costsheet.cells[rowid][10]].merge();
costsheet.cells[rowid][1].value:="      设计：                     审核：                    批准：";
costsheet.cells[rowid][1].horizontalAlignment:=-4108;
costsheet.cells[rowid][1].RowHeight:="25";

costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][10]].Columns.AutoFit;
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid][10]].Borders.LineStyle:=1;

costsheet.cells[1][1].select();


/*

costsheet.Columns["E"].rows[rowid].select();
excel.selection.value:="%IF{@%DB_ATTRIB_TYPE%=-2,件,m}";

costsheet.rows[rowid].select();
excel.selection.entirerow.insert();插入行

excel.selection.NumberFormatLocal:="0";修改单元格属性，0代表常规，0.00带表小数点后两位数字
costsheet.range[costsheet.cells[6][8]][costsheet.cells[rowid][8]].NumberFormatLocal:="0";
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][7]].rowheight:=15;指定行高

*/
