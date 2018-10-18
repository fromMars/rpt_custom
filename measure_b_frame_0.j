;<!--calculation_detail_b_frame_0-->
;<!--Calculatie detail: Algemeen------------------------------------------------>
; Next row index
if PictureDataRow > CurrentRow then { CurrentRow := PictureDataRow; }
if PictureTextRow > CurrentRow then { CurrentRow := PictureTextRow; }

CurrentRow := CurrentRow + 10;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,1451);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,200);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;
CurrentCellStr := "C" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := getlantext(-1,211);
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := True;
CurrentCellStr := "E" + IntToStr(CurrentRow);
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
TempValue := "%DSP_PART_NO%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "C" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_PART_DESC%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;
CurrentCellStr := "E" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_PART_PRICE%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := false;

<!--%% break header 1 -->

<!--%% break footer 1 -->
CurrentRow := CurrentRow + 1;
CurrentCellStr := "A" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_PART_NO_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "C" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;
CurrentCellStr := "E" + IntToStr(CurrentRow);
CurrentCell := CurrentSheet.Range[CurrentCellStr];
excel.Goto(CurrentCell);
TempValue := "%DSP_PART_PRICE_SUM%";
  CurrentCell.Value := TempValue;
  CurrentCell.Font.Bold := true;


<!--%% break header 2 -->

<!--%% break footer 2 -->

<!--%% detail footer ---------------------------------------------------------->

<!--%%------------------------------------------------------------------------->