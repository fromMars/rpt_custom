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
	curr_sheet:=template.worksheets[" 订货明细单"];
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
p_profiles:=profiles.create();
p_products:=products.create();

blok_name:="";

;-------------------------------------------------------------------------------
%%detail
;-------------------------------------------------------------------------------

if blok_name="" then
    blok_name:="@Z_BLK";

first_row.select();
excel.selection.entirerow.insert();
rowid:=first_row.row-2;
first_row.entirerow.copy();
curr_sheet.rows[rowid].entirerow.select();
curr_sheet.paste;

/*长度、数量用于求线重，由于字段“gewicht”在EOSS2016和EOSS2018数据库中含义不同，
    EOSS2016 ->型材特性线重值
    EOSS2018 ->型材总用量重量
    并且“理论重量=线重*长度*数量”，此处可使“理论重量=gewicht”反推线重。
  为不改变模板文件公式，此处方法为“线重=gewicht/数量/长度”。
 */
p_lth:=@%DB_PIECE_LOPT%/1000;
p_cnt:=%DSP_PIECE_FACTOR%;

curr_cell:=curr_sheet.cells[rowid][1];
curr_cell.value:=(rowid-init_rowid+2)/2;

curr_cell:=curr_sheet.cells[rowid][2];
curr_cell.value:=trim("%DSP_PIECE_PRODUCTDESC%");

curr_cell:=curr_sheet.cells[rowid][3];
if "@%DB_PIECE_ARTICLECODE%"<>"" then
    if substr("@%DB_PIECE_ARTICLECODE%",0,3)="002" then
	curr_cell.value:="%DSP_PIECE_PRODUCT%";
        /*curr_cell.value:=substr("@%DB_PIECE_ARTICLECODE%",0,7);*/
    else
        curr_cell.value:="@%DB_PIECE_ARTICLECODE%";
else
    curr_cell.value:="%DSP_PIECE_PRODUCT%";

curr_cell:=curr_sheet.cells[rowid][5];
curr_cell.value:=@%DB_PIECE_CFLENGTH%;

curr_cell:=curr_sheet.cells[rowid][6];
curr_cell.value:=p_lth;

curr_cell:=curr_sheet.cells[rowid][7];
curr_cell.value:=p_cnt;

curr_cell:=curr_sheet.cells[rowid][9];
curr_cell.value:="6063-T5";
if trim("%DSP_PIECE_PRODUCT%")="0092730" then
{
    curr_sheet.cells[rowid][8].value:="6063-T4"+chr(10)+"(不时效)";
}

p_profiles.code.system:="@%DB_PIECE_SYSTEM%";
p_profiles.code.profile:="@%DB_PIECE_PROFILE%";

inside_profile:="";
outside_profile:="";

if !p_profiles.find() then
	msgbox("profile not found in profile.db!");
else
{
    p_code:=p_profiles.product;
    p_products.code.product:=p_code;
    if !p_products.find() then
        msgbox("profile product not found in products.db!");
    else
    {
        seperated_cnt:=0;
        while seperated_cnt<5 do
        {
            if p_products.items[seperated_cnt].colour=2 then
                inside_profile:=trim(p_products.items[seperated_cnt].product);
            else if p_products.items[seperated_cnt].colour=1 then
                outside_profile:=trim(p_products.items[seperated_cnt].product);
            seperated_cnt:=seperated_cnt+1;
        }
    }
}

inside_color:="@%DB_PIECE_INSIDE%";
outside_color:="@%DB_PIECE_OUTSIDE%";
/*  EOSS2018 no need to reverse, for JoPPS already done internally.
    20190409 Update:
        Still need to reverse for fixed titles. 
        And this time reverses both colors and profiles.*/
if p_profiles.colour=0 then
else if p_profiles.colour=1 then
	inside_color:=outside_color;
else if p_profiles.colour=2 then
	outside_color:=inside_color;
else if p_profiles.colour=3 then
{
	tmp_color:=inside_color;
	inside_color:=outside_color;
	outside_color:=tmp_color;
	
	tmp_profile:=inside_profile;
	inside_profile:=outside_profile;
	outside_profile:=tmp_profile;
}

m_weight:=p_profiles.weight;
if m_weight=0 then
	m_weight:=@%DB_PIECE_WEIGHT%;
curr_cell:=curr_sheet.cells[rowid][8];
/*curr_cell.value:=m_weight/p_cnt/p_lth;*/
curr_cell.value:=m_weight;

if "@%DB_PIECE_INSIDE%"<>"" && "@%DB_PIECE_OUTSIDE%"<>"" then
{
    if strpos("_",inside_profile)=1 then
        inside_profile:=strdeletel(inside_profile,1);
    if strpos("_",outside_profile)=1 then
        outside_profile:=strdeletel(outside_profile,1);
    
	curr_cell:=curr_sheet.cells[rowid][10];
	curr_cell.value:=inside_profile;
	curr_cell:=curr_sheet.cells[rowid+1][10];
	curr_cell.value:=inside_color;
	
	curr_cell:=curr_sheet.cells[rowid][11];
	curr_cell.value:=outside_profile;
	curr_cell:=curr_sheet.cells[rowid+1][11];
	curr_cell.value:=outside_color;
}
else
{
	curr_sheet.range[curr_sheet.cells[rowid][10]][curr_sheet.cells[rowid+1][11]].merge();
	if %DSP_PIECE_SERIE% = 17 then
		curr_cell:=curr_sheet.cells[rowid][10].value:="银白色氧化";
	else
		curr_cell:=curr_sheet.cells[rowid][10].value:="%DSP_PIECE_SERIE%";
}

;-------------------------------------------------------------------------------
%% detail footer
;-------------------------------------------------------------------------------

outputmsg(blok_name);
if blok_name="A" then
	curr_sheet.cells[init_rowid][12].value:="泰诺风隔热条"+chr(10)+"超高精级";
else if blok_name="B" then
	curr_sheet.cells[init_rowid][12].value:="易菲特隔热条"+chr(10)+"超高精级";
else if blok_name="C" then
	curr_sheet.cells[init_rowid][12].value:="优泰隔热条"+chr(10)+"超高精级";
else if blok_name="T" then
	curr_sheet.cells[init_rowid][12].value:="隔热条"+chr(10)+"超高精级";

curr_sheet.range[curr_sheet.cells[init_rowid][12]][curr_sheet.cells[rowid][12]].merge();
curr_sheet.usedrange.rows[""+inttostr(init_rowid)+":"+inttostr(rowid+1)].borders.linestyle:=1;
first_row.columns[4].formula:="=sum(D"+inttostr(init_rowid)+":D"+inttostr(rowid)+")";

p_profiles.free();
p_products.free();

