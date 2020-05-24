PROGRAM delay
VAR_EXTERNAL
qwProcessOutputINT16_1        			: INT;
qwProcessOutputINT16_2        			: INT;
qwProcessOutputINT16_3        			: INT;
Axis0_iwCurrentActualValue             	: INT;
Axis0_iwCurrentActualValueAveraged     	: INT;
Axis0_iwCurrentDemandValue             	: INT;

iwProcessInputINT16_1         			: INT;
Axis0_qwCurrentModeSettingValue       	: INT;
END_VAR

VAR_GLOBAL

END_VAR

VAR

END_VAR
Axis0_qwCurrentModeSettingValue := iwProcessInputINT16_1;
qwProcessOutputINT16_1 := Axis0_iwCurrentActualValue;
qwProcessOutputINT16_2 := Axis0_iwCurrentActualValueAveraged;
qwProcessOutputINT16_3 := Axis0_iwCurrentDemandValue;



END_PROGRAM