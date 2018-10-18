; offer_b_project_1
;
; START MS WORD
;
errmsg    := "";
oleserver := "word.application";
;
goto begin;
; script error handler ------------------------------------------
@error:
MsgErr(FormatStr(GetLanText(-9688),errmsg));
Halt;
; ---------------------------------------------------------------
;
@begin:
word := start(oleserver);
if !IsIDispatch(word) then
{
  MsgErr(FormatStr(GetLanText(-9687),oleserver));
  Halt;
}
else
{
  oleversion := StrToNum(GetParam("OFFICE"), 0);
  oleversion := StrToNum(word.Version, oleversion);  
  word.Visible := True;
};
;
; CREATE MAILMERGE DATASOURCE
;
data := word.Documents.Add();
if !IsIDispatch(data) then
{
  errmsg := "Cannot create document";
  goto error;
};
range := data.Content;
table := data.Tables.Add(range,1,63); ;;maximum number of columns!!!
if !IsIDispatch(table) then
{
  errmsg := "Cannot create table";
  goto error;
};
sel := word.ActiveDocument.ActiveWindow.Selection;
row := table.Rows.Item(1);
if !IsIDispatch(row) then
{
  errmsg := "Row not found";
  goto error;
};
  row.Select();
  sel.TypeText("COMPANY");
  sel.MoveRight();
  sel.TypeText("STREET");
  sel.MoveRight();
  sel.TypeText("PLACE");
  sel.MoveRight();
  sel.TypeText("ZIP");
  sel.MoveRight();
  sel.TypeText("PHONE");
  sel.MoveRight();
  sel.TypeText("FAX");
  sel.MoveRight();
  sel.TypeText("EMAIL");
  sel.MoveRight();
  sel.TypeText("SMALLLOGO");
  sel.MoveRight();
  sel.TypeText("TAXNUMBER");
  sel.MoveRight();
  sel.TypeText("TRADEREGISTER");
  sel.MoveRight();
  sel.TypeText("REGISTRATION");
  sel.MoveRight();
  sel.TypeText("ACCOUNT");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_CODE");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_NAME");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_ADDRESS1");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_ADDRESS2");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_ADDRESS3");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_BEGIN");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_PERIOD");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_COST1");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_COST2");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_CLIENT");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_CONTACT");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_STREET");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_ZIP");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_PLACE");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_COUNTRY");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_PHONE");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_GSM");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_TELEFAX");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_EMAIL");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_TAXNUMBER");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_ACCOUNT");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FUNCTION");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_ARCHITECT");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_SELLER");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_SYSTEM");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FILL");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_PROFILE");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_GLAZBEAD");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_STIFF");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_ACC");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_GLAS");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_XTR");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FRAMEPROFILE");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FRAMEGLAZBEAD");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FRAMESTIFF");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FRAMEACC");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FRAMEGLAS");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_FRAMEXTR");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_VENTPROFILE");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_VENTGLAZBEAD");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_VENTSTIFF");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_VENTACC");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_VENTGLAS");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_VENTXTR");
  sel.MoveRight();
  sel.TypeText("DSP_TEXT_CONDITIONS");
  sel.MoveRight();
  sel.TypeText("PROJECT_EMAIL");
  sel.MoveRight();
  sel.TypeText("PROJECT_PHONE");
  sel.MoveRight();
  sel.TypeText("PROJECT_FAX");
  sel.MoveRight();
  sel.TypeText("PROJECT_REFERENCE");
%% detail
row := table.Rows.Add();
if !IsIDispatch(row) then
{
  errmsg := "Cannot add row";
  goto error;
};
  row.Select();
  sel.TypeText(HTMLToNormalStr("%COMPANY%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%STREET%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%PLACE%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%ZIP%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%PHONE%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%FAX%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%EMAIL%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%SMALLLOGO%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%TAXNUMBER%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%TRADEREGISTER%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%REGISTRATION%"));
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%ACCOUNT%"));
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_CODE%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_NAME%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_ADDRESS1%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_ADDRESS2%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_ADDRESS3%");
  sel.MoveRight();
  sel.TypeText(HTMLToNormalStr("%DSP_TEXT_BEGIN%"));
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_PERIOD%");
  sel.MoveRight();
  if getparam("DB_USER")="USER83" || getparam("DB_USER")="USER84" then
  {
  sel.TypeText("@%DB_TEXT_COST1%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_COST2%");
  sel.MoveRight();
  sel.TypeText("ANPU安普门窗");
  sel.MoveRight();
  sel.TypeText("ANPU安普门窗");
  sel.MoveRight();
  sel.TypeText("兴谷路2号");
  sel.MoveRight();
  sel.TypeText("南京市江宁区谷里镇");
  sel.MoveRight();
  sel.TypeText("");
  sel.MoveRight();
  sel.TypeText("China");
  sel.MoveRight();
  sel.TypeText("025-58303661");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_GSM%");
  sel.MoveRight();
  sel.TypeText("025-58303662");
  sel.MoveRight();
  sel.TypeText("");
  sel.MoveRight();
  }
  else if getparam("DB_USER")="USER30" then
  {
  sel.TypeText("@%DB_TEXT_COST1%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_COST2%");
  sel.MoveRight();
  sel.TypeText("万享门窗");
  sel.MoveRight();
  sel.TypeText("万享门窗");
  sel.MoveRight();
  sel.TypeText("");
  sel.MoveRight();
  sel.TypeText("中国 北京");
  sel.MoveRight();
  sel.TypeText("");
  sel.MoveRight();
  sel.TypeText("China");
  sel.MoveRight();
  sel.TypeText("400-000-3380");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_GSM%");
  sel.MoveRight();
  sel.TypeText("");
  sel.MoveRight();
  sel.TypeText("");
  sel.MoveRight();
  }
  else
  {
  sel.TypeText("@%DB_TEXT_COST1%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_COST2%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_CLIENT%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_CONTACT%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_STREET%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_ZIP%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_PLACE%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_COUNTRY%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_PHONE%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_GSM%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_TELEFAX%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_EMAIL%");
  sel.MoveRight();
  }
  sel.TypeText("@%DB_TEXT_TAXNUMBER%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_ACCOUNT%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FUNCTION%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_ARCHITECT%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_SELLER%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_SYSTEM%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FILL%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_PROFILE%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_GLAZBEAD%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_STIFF%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_ACC%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_GLAS%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_XTR%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FRAMEPROFILE%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FRAMEGLAZBEAD%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FRAMESTIFF%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FRAMEACC%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FRAMEGLAS%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_FRAMEXTR%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_VENTPROFILE%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_VENTGLAZBEAD%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_VENTSTIFF%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_VENTACC%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_VENTGLAS%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_VENTXTR%");
  sel.MoveRight();
  sel.TypeText("@%DB_TEXT_CONDITIONS%");
  sel.MoveRight();
  sel.TypeText("%PROJECTEMAIL%");
  sel.MoveRight();
  sel.TypeText("%PROJECTPHONE%");
  sel.MoveRight();
  sel.TypeText("%PROJECTFAX%");
  sel.MoveRight();
  if "%PROJECTREFERENCE%" != "" then
    sel.TypeText("%PROJECTREFERENCE%");
  else
    sel.TypeText("%DB_USERDESC%");
  if "@%DB_TEXT_CONDITIONS%" != "" then
    COND := 1;
  else
    COND := 0;
%% detail footer
tmpfile := "%SYSTEM_TMP%\data.doc";
if FileExists(tmpfile) then DeleteFile(tmpfile);
data.SaveAs(tmpfile);
data.Close(-1);
Kill("tmpfile");
;
Kill("range");
Kill("table");
Kill("sel");
Kill("row");
Kill("data");
;
; OPEN MAIN DOCUMENT
;
tmpfile := FileSearch("%OFFER_TEMPLATE%_%PROJECTKIND%.DOT", "%PATH_DATA%");
if tmpfile = "" || !FileExists(tmpfile) then
{
  errmsg := "Cannot find template <%OFFER_TEMPLATE%_%PROJECTKIND%.DOT> in <%PATH_DATA%>!";
  goto error;
};
result := word.Documents.Add(tmpfile);
if !IsIDispatch(result) then
{
  errmsg := "Creation of main document failed!";
  goto error;
};
Kill("tmpfile");
;
result := word.ActiveDocument;
if oleversion < 12 then
{
  outfn := ChangeFileExt(GetParam("REPORTDOC"),".doc");
}
else
{
  outfn := ChangeFileExt(GetParam("REPORTDOC"),".docx");
};
if FileExists(outfn) then DeleteFile(outfn);
result.SaveAs(outfn);
;
bm := result.Bookmarks.Item("BODY");
if !IsIDispatch(bm) then
{
  errmsg := "Bookmark BODY not found!";
  goto error;
};
;
bm_name := "";
if %SH_PROJECTADDRESS% then bm_name := bm_name + "_ADDRESS";
if %SH_ARCHITECT%      then bm_name := bm_name + "_ARCHITECT";
if %SH_SELLER%         then bm_name := bm_name + "_SELLER";
if bm_name = "" then bm_name := "_NORMAL";
bm_name := "HEADER" + bm_name;
bm := result.Bookmarks.Item(bm_name);
if IsIDispatch(bm) then
{
  bm.Range.Copy();
  bm := result.Bookmarks.Item("HEADER_ALLTEXTS");
  if IsIDispatch(bm) then
    {
    bm.Select();
    bm.Range.Delete();
    word.Selection.Paste();
    }
}
;
bm := result.Bookmarks.Item("FINISH_PROFILE");
if IsIDispatch(bm) && !%SHOW_PROJECTPROFILEFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_GLAZBEAD");
if IsIDispatch(bm) && !%SHOW_PROJECTGLAZINGBEADFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_STIFF");
if IsIDispatch(bm) && !%SHOW_PROJECTSTIFFNERFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_ACC");
if IsIDispatch(bm) && !%SHOW_PROJECTACCESSORIESFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_GLAS");
if IsIDispatch(bm) && !%SHOW_PROJECTFILLINGFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_XTR");
if IsIDispatch(bm) && !%SHOW_PROJECTWINDOWFINISHINGFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_FRAMEPROFILE");
if IsIDispatch(bm) && !%SHOW_FRAMEPROFILEFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_FRAMEGLAZBEAD");
if IsIDispatch(bm) && !%SHOW_FRAMEGLAZINGBEADFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_FRAMESTIFF");
if IsIDispatch(bm) && !%SHOW_FRAMESTIFFNERFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_FRAMEACC");
if IsIDispatch(bm) && !%SHOW_FRAMEACCESSORIESFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_FRAMEGLAS");
if IsIDispatch(bm) && !%SHOW_FRAMEFILLINGFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_FRAMEXTR");
if IsIDispatch(bm) && !%SHOW_FRAMEWINDOWFINISHINGFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_VENTPROFILE");
if IsIDispatch(bm) && !%SHOW_VENTPROFILEFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_VENTGLAZBEAD");
if IsIDispatch(bm) && !%SHOW_VENTGLAZINGBEADFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_VENTSTIFF");
if IsIDispatch(bm) && !%SHOW_VENTSTIFFNERFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_VENTACC");
if IsIDispatch(bm) && !%SHOW_VENTACCESSORIESFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_VENTGLAS");
if IsIDispatch(bm) && !%SHOW_VENTFILLINGFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("FINISH_VENTXTR");
if IsIDispatch(bm) && !%SHOW_VENTWINDOWFINISHINGFINISH% then bm.Range.Delete();
bm := result.Bookmarks.Item("CONDITIONS");
if IsIDispatch(bm) && (COND = 0) then bm.Range.Delete();
;
bm := result.Bookmarks.Item("FILLING");
if IsIDispatch(bm) && !%SHOW_FILLING% then bm.Range.Delete();
;
bm := result.Bookmarks.Item("BODY");
bm.Select();
;
Kill("bm_name");
Kill("bm");
