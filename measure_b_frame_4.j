;<!--calculation_detail_b_frame_4-->
;<!--Calculatie detail: Glas---------------------------------------------------->
; Next row index
if PictureDataRow > CurrentRow then { CurrentRow := PictureDataRow; }
if PictureTextRow > CurrentRow then { CurrentRow := PictureTextRow; }

CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,1456);
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
TempValue := "%DSP_GLASS_NO%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "B" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_GLASS_FILLING%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "D" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_GLASS_DESC%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "F" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_GLASS_CFPRICE%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;

<!--%% break header 1 -->

<!--%% break footer 1 -->
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_GLASS_NO_SUM%";
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
TempValue := "%DSP_GLASS_CFPRICE_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;


<!--%% break header 2 -->

<!--%% break footer 2 -->
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_GLASS_NO_SUM%";
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
TempValue := "PB:"+"%DSP_GLASS_ARTICLE_BR%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "F" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_GLASS_CFPRICE_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
<!--%% detail footer ---------------------------------------------------------->

<!--%%------------------------------------------------------------------------->