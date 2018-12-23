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
TemplateFile := FileSearch("articles_zl.XLT", "%PATH_DATA%");
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
	curr_sheet:=template.worksheets["articles"];
}
else
{
	ErrMsg:="no sheet found in "+TemplateFile+" file!";
	goto generalerror;
}

curr_sheet.range["ProjectName"].value:="¹¤³ÌÃû³Æ¡ª¡ª%PROJECT%";

first_row:=curr_sheet.range["ArticleList"];
rowid:=first_row.row;
init_rowid:=rowid;
