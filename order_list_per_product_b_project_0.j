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

curr_sheet.range["ProjectName"].value:=" 工程名称：%DSP_PIECE_PROJECT%";

first_row:=curr_sheet.range["ProfList"];
rowid:=first_row.row;
init_rowid:=rowid;
seperated_profile:=profiles.create();

;-------------------------------------------------------------------------------
%%detail
;-------------------------------------------------------------------------------

first_row.select();
excel.selection.entirerow.insert();
rowid:=first_row.row-2;
first_row.entirerow.copy();
curr_sheet.rows[rowid].entirerow.select();
curr_sheet.paste;


curr_cell:=curr_sheet.cells[rowid][1];
curr_cell.value:=(rowid-init_rowid+2)/2;

curr_cell:=curr_sheet.cells[rowid][2];
curr_cell.value:="%DSP_PIECE_PROFILEDESC%";

curr_cell:=curr_sheet.cells[rowid][3];
curr_cell.value:="%DSP_PIECE_PRODUCT%";

curr_cell:=curr_sheet.cells[rowid][5];
curr_cell.value:="=@%DB_PIECE_LOPT%/1000";

curr_cell:=curr_sheet.cells[rowid][6];
curr_cell.value:=%DSP_PIECE_FACTOR%;

curr_cell:=curr_sheet.cells[rowid][8];
curr_cell.value:="6063-T5";

seperated_profile.code.system:="@%DB_PIECE_SYSTEM%";
seperated_profile.code.profile:="@%DB_PIECE_PROFILE%";
inside_profile:="";
outside_profile:="";

if !seperated_profile.find() then
	msgbox("profile not found in profile.db!");
else
{
	seperated_cnt:=0;
	while seperated_cnt<5 do
	{
		if seperated_profile.accessories[seperated_cnt].colour=2 then
			inside_profile:=trim(seperated_profile.accessories[seperated_cnt].code.code);
		else if seperated_profile.accessories[seperated_cnt].colour=1 then
			outside_profile:=trim(seperated_profile.accessories[seperated_cnt].code.code);
		seperated_cnt:=seperated_cnt+1;
	}
}

inside_color:="@%DB_PIECE_INSIDE%";
outside_color:="@%DB_PIECE_OUTSIDE%";
if seperated_profile.colour=0 then
else if seperated_profile.colour=1 then
	inside_color:=outside_color;
else if seperated_profile.colour=2 then
	outside_color:=inside_color;
else if seperated_profile.colour=3 then
{
	tmp_color:=inside_color;
	inside_color:=outside_color;
	outside_color:=tmp_color;
}

m_weight:=seperated_profile.weight;
curr_cell:=curr_sheet.cells[rowid][7];
curr_cell.value:=m_weight;

if "@%DB_PIECE_INSIDE%"<>"" && "@%DB_PIECE_OUTSIDE%"<>"" then
{
    if strpos("_",inside_profile)=1 then
        inside_profile:=strdeletel(inside_profile,1);
    if strpos("_",outside_profile)=1 then
        outside_profile:=strdeletel(outside_profile,1);
    
	curr_cell:=curr_sheet.cells[rowid][9];
	curr_cell.value:=inside_profile;
	curr_cell:=curr_sheet.cells[rowid+1][9];
	curr_cell.value:=inside_color;
	
	curr_cell:=curr_sheet.cells[rowid][10];
	curr_cell.value:=outside_profile;
	curr_cell:=curr_sheet.cells[rowid+1][10];
	curr_cell.value:=outside_color;
}
else
{
	curr_sheet.range[curr_sheet.cells[rowid][9]][curr_sheet.cells[rowid+1][10]].merge();
	curr_cell:=curr_sheet.cells[rowid][9].value:="%DSP_PIECE_SERIE%";
}

;-------------------------------------------------------------------------------
%% detail footer
;-------------------------------------------------------------------------------

if %GLOBAL_PRICE_PROFILE%=1 then
	curr_sheet.cells[init_rowid][11].value:="易菲特隔热条"+chr(10)+"超高精级";
else
	curr_sheet.cells[init_rowid][11].value:="泰诺风隔热条"+chr(10)+"超高精级";
curr_sheet.range[curr_sheet.cells[init_rowid][11]][curr_sheet.cells[rowid][11]].merge();
curr_sheet.usedrange.rows[""+inttostr(init_rowid)+":"+inttostr(rowid+1)].borders.linestyle:=1;
first_row.columns[4].formula:="=sum(D"+inttostr(init_rowid)+":D"+inttostr(rowid)+")";

