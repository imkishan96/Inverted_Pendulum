PROGRAM blah
VAR_EXTERNAL
idProcessInputINT32_1          			: DINT; 
Axis0_qdTargetVelocity       			: DINT;
Axis0_idIncrementalEncoder1Counter		: UDINT;
qdProcessOutputUINT32_1        			: UDINT;
END_VAR

VAR_GLOBAL

END_VAR

VAR

END_VAR
Axis0_qdTargetVelocity := idProcessInputINT32_1;
qdProcessOutputUINT32_1 := Axis0_idIncrementalEncoder1Counter;

END_PROGRAM