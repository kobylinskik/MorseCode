.include "vtable.S"
.include "constants.S"
.include "variables.S"
.include "setupHardware.S"
.include "receiveText.S"
.include "blinkText.S"
.include "utils.S"

.type resetHandler, %function
resetHandler:
  LDR  r0,=_estack
  MOV  sp,r0  
  BL createMorseArray
  BL initTextWithZeroes
  BL setupHardware
  BL receiveText