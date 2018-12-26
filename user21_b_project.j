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
CostSheet := Template.WorkSheets["����嵥"];

rowid:=7;

costsheet.range["$A$2"].select();
excel.selection.value:="������λ:";
costsheet.range["$A$3"].select();
excel.selection.value:="��������:%PROJECT%";


%% detail
/**********************************************************/
costsheet.Columns["A"].rows[rowid].select();
excel.selection.value:="=row()-6";

costsheet.Columns["B"].rows[rowid].select();
excel.selection.value:="@%DB_ATTRIB_ACCDESC%";
costsheet.Columns["C"].rows[rowid].select();
excel.selection.value:="%IF{@%Db_ATTRIB_ARTICLECODE%="",'@%DB_ATTRIB_ACC% @%DB_ATTRIB_SERIE%,'@%DB_ATTRIB_ARTICLECODE%}";
costsheet.Columns["D"].rows[rowid].select();
excel.selection.value:="@%DB_ATTRIB_VARIETYDESC%";
costsheet.Columns["E"].rows[rowid].select();
excel.selection.value:="%IF{@%DB_ATTRIB_TYPE%=-2,��,m}";
costsheet.Columns["F"].rows[rowid].select();

excel.selection.value:="%IF{@%DB_ATTRIB_TYPE%=-1,=@%DB_ATTRIB_ITMPRICE%/@%DB_ATTRIB_LENGTH%*(1-@%DB_ATTRIB_REBATE%/100),=@%DB_ATTRIB_ITMPRICE%*(1-@%DB_ATTRIB_REBATE%/100)}";
/*excel.selection.value:="=@%DB_ATTRIB_ITMPRICE%*(1-@%DB_ATTRIB_REBATE%/100)";*/
costsheet.Columns["G"].rows[rowid].select();
excel.selection.value:="%IF{@%DB_ATTRIB_TYPE%=-2,%DSP_ATTRIB_NO01%,%IF{@%DB_ATTRIB_SEQNO%=0,%DSP_ATTRIB_LENGTH01%,=@%DB_ATTRIB_NO%*@%DB_ATTRIB_LENGTH%}}";
costsheet.Columns["H"].rows[rowid].select();
excel.selection.value:="=Ceiling(%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_NO%,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_NO%,@%DB_ATTRIB_LENGTH%}}/%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%,%IF{@%DB_ATTRIB_TYPE%=-1,1,@%DB_ATTRIB_PACKSIZE%}},1)*%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_LENGTH%,@%DB_ATTRIB_PACKSIZE%}}";


costsheet.Columns["I"].rows[rowid].select();
excel.selection.value:="%IF{@%DB_ATTRIB_TYPE%=-2,@%DB_ATTRIB_PACKSIZE%p,%IF{@%DB_ATTRIB_TYPE%=-1,@%DB_ATTRIB_LENGTH%m,@%DB_ATTRIB_PACKSIZE%m}}";

costsheet.Columns["J"].rows[rowid].select();
excel.selection.value:="%DSP_ATTRIB_ATOM%";

if excel.selection.value<>0 then
{
    msgbox(excel.selection.text);
    CurPro := GetCurrentProject();
    IF CurPro = Nil THEN halt; /* no project loaded */
    fn1 := ChangeFileExt(ExtractFilename(CurPro.Filename),''); 
    fn0 := InterpreteString('%PATH_OUTPUT%')+'\';
    fn := fn0 + fn1 + '_' + excel.selection.text + '.bmp';
    IF CreateBitmapFile(atomtoobj(excel.selection.value),fn, 100, 100, True,True, 1.0, 0,-1, 120,-1,-1) THEN
        outputmsg('<'+fn+'> created !');
    ELSE
        MsgErr('Failed creating bitmap !');
}




rowid:=rowid+1;

%% break header

%% break footer

%% detail footer


costsheet.range[costsheet.cells[rowid][1]][costsheet.cells[rowid][10]].merge();
costsheet.cells[rowid][1].value:="      ��ƣ�                     ��ˣ�                    ��׼��";
costsheet.cells[rowid][1].horizontalAlignment:=-4108;
costsheet.cells[rowid][1].RowHeight:="25";

costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][10]].Columns.AutoFit;
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid][10]].Borders.LineStyle:=1;




/*

costsheet.Columns["E"].rows[rowid].select();
excel.selection.value:="%IF{@%DB_ATTRIB_TYPE%=-2,��,m}";

costsheet.rows[rowid].select();
excel.selection.entirerow.insert();������

excel.selection.NumberFormatLocal:="0";�޸ĵ�Ԫ�����ԣ�0�������棬0.00����С�������λ����
costsheet.range[costsheet.cells[6][8]][costsheet.cells[rowid][8]].NumberFormatLocal:="0";
costsheet.range[costsheet.cells[6][1]][costsheet.cells[rowid-1][7]].rowheight:=15;ָ���и�

*/