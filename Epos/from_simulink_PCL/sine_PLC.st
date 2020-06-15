(*
 *
 * File: sine_PLC.st
 *
 * IEC 61131-3 Structured Text (ST) code generated for subsystem "sine_PLC/Subsystem"
 *
 * Model name                      : sine_PLC
 * Model version                   : 1.0
 * Model creator                   : imkis
 * Model last modified by          : imkis
 * Model last modified on          : Wed Jun 03 14:36:07 2020
 * Model sample time               : 0s
 * Subsystem name                  : sine_PLC/Subsystem
 * Subsystem sample time           : 0.01s
 * Simulink PLC Coder version      : 3.2 (R2020a) 18-Nov-2019
 * ST code generated on            : Wed Jun 03 16:22:54 2020
 *
 * Target IDE selection            : Generic
 * Test Bench included             : No
 *
 *)
FUNCTION_BLOCK Subsystem
VAR_INPUT
    ssMethodType: SINT;
END_VAR
VAR_OUTPUT
    Current_command: INT;
END_VAR
VAR
    b_counter: DINT;
END_VAR
VAR_TEMP
    rtb_SineWave: LREAL;
END_VAR
CASE ssMethodType OF
    0: 
        (* SystemInitialize for Atomic SubSystem: '<Root>/Subsystem' *)
        (* InitializeConditions for Sin: '<S1>/Sine Wave' *)
        b_counter := 0;
        (* End of SystemInitialize for SubSystem: '<Root>/Subsystem' *)
    1: 
        (* Outputs for Atomic SubSystem: '<Root>/Subsystem' *)
        (* Sin: '<S1>/Sine Wave' *)
        rtb_SineWave := SIN(((DINT_TO_LREAL(b_counter) * 2.0) * 3.1415926535897931) / 100.0) * 500.0;
        (* Update for Sin: '<S1>/Sine Wave' *)
        b_counter := b_counter + 1;
        IF b_counter = 100 THEN 
            b_counter := 0;
        END_IF;
        (* End of Update for Sin: '<S1>/Sine Wave' *)
        
        (* Outport: '<Root>/Current_command' incorporates:
         *  DataTypeConversion: '<S1>/Data Type Conversion' *)
        Current_command := DINT_TO_INT(TRUNC(rt_floord(u := rtb_SineWave)));
        (* End of Outputs for SubSystem: '<Root>/Subsystem' *)
END_CASE;
END_FUNCTION_BLOCK
FUNCTION rt_floord: LREAL
VAR_INPUT
    u: LREAL;
END_VAR
rt_floord := DINT_TO_LREAL(TRUNC(u));
IF u = rt_floord THEN 
    rt_floord := u;
ELSIF u < 0.0 THEN 
    rt_floord := rt_floord - 1.0;
END_IF;
END_FUNCTION
