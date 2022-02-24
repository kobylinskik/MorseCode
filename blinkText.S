.type sysTick_IRQHandler,%function
sysTick_IRQHandler:  
  PUSH {lr}
  MOV r4,#1
  POP {pc}

blinkText:
  BL initCharPtr
  BL setElemPtr
  BL setupSysTick
  EOR r3,r3 //We'll use r3 as a flag that we are in an inter-element break

setLedStatusAndNextDelay:
  EOR r4,r4 //We'll use r4 as a flag that the SysTick interrupt has happened
  CMP r3,#0 //if r3 is 0,we'll switch off LED and set next character length
  IT EQ
  BLEQ handleBreak
  CMP r1,#0
  IT NE
  BLNE switchOnLed
  LDR r0,=DOT_DELAY
  BL setNextElemLength
  EOR r3,r3
  B waitForSysTick
  handleBreak:
  BL switchOffLed
  BL processElem
  CMP r1,#0
  IT EQ
  BLEQ processCharacter
  BL setNextElemLength
  MOV r3,#1
  B waitForSysTick

waitForSysTick:
  CMP r4,#0 
  IT NE
  BLNE setLedStatusAndNextDelay //If the interrupt has occured, we'll handle LED status change and process characters
  B waitForSysTick

processCharacter:
  PUSH {lr}
  LDR r5,=charPtr
  LDR r6,[r5]
  LDRB r6,[r6]
  CMP r6,#0x20//Space - word break
  IT EQ
  BEQ handleSpace  
  CMP r6,#0
  IT EQ
  BEQ receiveText
  POP {pc}
  handleSpace:
  BL incrementCharPtr
  BL setElemPtr
  LDR r0,=WORD_DELAY
  POP {pc}

//r0 -> returns elem length, r1 -> if 0, it's the end of the character
processElem:
  PUSH {lr}
  LDR r5,=elemPtr
  LDR r6,[r5]
  LDRB r7,[r6]
  CBNZ r7,setElemData
  LDR r0,=DOT_DELAY
  MOV r1,#0 //r1 -> switch on LED flag
  PUSH {r0}
  BL incrementCharPtr //end of String -> get another character
  BL setElemPtr //set element pointer to the beginning of the character
  POP {r0}
  POP {pc}
setElemData:
  CMP r7,#0x2D
  ITE EQ
  LDREQ r0,=DASH_DELAY //r0 -> element length
  LDRNE r0,=DOT_DELAY
  MOV r1,#1 //r1 -> switch on LED flag
  BL incrementElemPtr
  POP {pc}

//r0 -> returns elem length
setNextElemLength:
  LDR r5,=STK_LOAD
  STR r0,[r5]
  BX lr

setElemPtr:  
  LDR r8,[r0]
  LDRB r8,[r8]
  CMP r8,0x20 //If the character under charPtr is space, we don't want to set elemPtr, as space has none
  IT EQ
  BXEQ lr
  SUB r8,#0x41 //Subtract 0x41 to get the letter index
  MOV r5,#4
  MUL r6,r5,r8  //Multiply the index by 4 to get the offset
  LDR r7,=LETTER_ADDRESSES
  LDR r7,[r7,r6]
  LDR r5,=elemPtr  
  STR r7,[r5]
  BX lr

switchOnLed:
  LDR r5,=GPIOA_BSRR
  LDR r6,[r5]
  MOV r7,#1
  LSL r7,r7,#5
  ORR r7,r7,r6
  STR r7,[r5]
  BX lr

switchOffLed:
  LDR r5,=GPIOA_BSRR
  LDR r6,[r5]
  MOV r7,#1
  LSL r7,r7,#21
  ORR r7,r7,r6
  STR r7,[r5]
  BX lr
  