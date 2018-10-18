;<!--calculation_detail_b_frame_5-->
;<!--Calculatie detail: Afwerkingen--------------------------------------------->
; Next row index
if PictureDataRow > CurrentRow then { CurrentRow := PictureDataRow; }
if PictureTextRow > CurrentRow then { CurrentRow := PictureTextRow; }

CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,1458);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,200);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;
CurrentCellStr := "B" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,30410);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;
CurrentCellStr := "D" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,211);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;
CurrentCellStr := "F" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,2214);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;


<!--%% detail ----------------------------------------------------------------->
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_NO%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "B" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_FINISH%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "D" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_DESC%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "F" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_CFPRICE%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;

<!--%% break header 1 -->

<!--%% break footer 1 -->
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_NO_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "B" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "D" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "F" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_CFPRICE_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;


<!--%% break header 2 -->

<!--%% break footer 2 -->
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_NO_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "B" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "D" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "PB:"+"%DSP_EXTRA_ARTICLE_BR%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "F" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_EXTRA_CFPRICE_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
<!--%% detail footer ---------------------------------------------------------->

<!--%%------------------------------------------------------------------------->