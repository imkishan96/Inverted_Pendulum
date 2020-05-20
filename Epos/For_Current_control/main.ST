PROGRAM main
VAR_EXTERNAL
qdProcessOutputINT32_1        			: DINT;
iwProcessInputINT16_1         			: INT;
Axis0_qwCurrentModeSettingValue        	: INT;
Axis0_idPositionActualValue            	: DINT;

END_VAR

VAR_GLOBAL

END_VAR

VAR

END_VAR
Axis0_qwCurrentModeSettingValue 	:= iwProcessInputINT16_1;
qdProcessOutputINT32_1 				:= Axis0_idPositionActualValue;


END_PROGRAM