/* USER1_E_ASSEMBLY_0.J
 * 
 *                      */


costsheet.columns[4].delete();
costsheet.range[costsheet.columns[8]][costsheet.columns[16]].delete();

s_index := bList.IndexOf("-3");

CostSheet.Range[costsheet.cells[3][1]][costsheet.cells[rowid+2][7]].Borders.LineStyle:=1;

/* if glass price is not 0, the artikel will appera in the cost sheet, so
 * we need to remove the empty artikel 20 line above the custom glass lines.*/
if glass_price=1 then
    CostSheet.rows[RowId_0+cnt_16_17+1].entirerow.delete();

if s_index <> -1 then
{
    CostSheet.Columns.Autofit;
}

z_pg.free();




/* assembly image */
CurPro := GetCurrentProject();
IF CurPro = Nil THEN halt; /* no project loaded */
fn1 := ChangeFileExt(ExtractFilename(CurPro.Filename),''); 
fn0 := InterpreteString('%PATH_OUTPUT%')+'\';
ndx:=img_no;

fn := fn0 + fn1 + '_' + CurPro.ProjectData.Children[ndx].Code + '.bmp';
IF CreateBitmapFile(CurPro.ProjectData.Children[ndx],fn, 100, 100, True,True, 1.0, 3,-1, 120,-1,-1) THEN
    outputmsg('<'+fn+'> created !');
ELSE
    MsgErr('Failed creating bitmap !');

img_no:=img_no+1;

/*img:=costsheet.pictures.insert(fn);
img.top:=costsheet.cells[3][9].top;
img.left:=costsheet.cells[3][9].left;*/

costsheet.shapes.addpicture(fn,0,1,costsheet.cells[3][9].left,costsheet.cells[3][9].top,-1,-1);
costsheet.cells[1][1].select();


%% detail
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail
; 

%% break header
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Break header
; 

%% break footer
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) _ Break footer
; 

%% detail footer
; ******************************Estim Excel************************************
; *****************************************************************************
; %NAME% (%BATCH%) - Detail footer
; 

