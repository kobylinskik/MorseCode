.include "morseCharacters.S"

.syntax unified
.section .text
.type sysTick_IRQHandler,%function
sysTick_IRQHandler:
  PUSH {lr}
  LDR r0,=ledOn
  LDR r1,[r0]
  CMP r1,#0
  IT NE
  BNE afterSwitchOnLed
  MOV r1,#1
  STR r1,[r0]
  LDR r1,=STK_LOAD
  LDR r0,=DOT_DELAY
  STR r0,[r1]
  LDR r2,=endOfCharFlag
  LDR r1,[r2]
  CMP r1,#0
  IT EQ
  BLEQ switchOnLed
  LDR r2,=endOfCharFlag
  MOV r1,#0
  STR r1,[r2]
  POP {pc}
afterSwitchOnLed:
  MOV r1,#0
  STR r1,[r0]  
  BL processCharacter
  BL switchOffLed
  POP {pc}

.type resetHandler, %function
resetHandler:
  LDR  r0,=_estack
  MOV  sp,r0
  LDR r0,=ledOn
  MOV r1,#1
  STR r1,[r0]
  BL setReadCharFlag
  BL initCharPtr
  BL createMorseArray
  BL enableApb2BusClock
  BL setupPa5Pin
  BL setupSysTick
  //BL processCharacter

loop1:
  ADD r5,r5,#1
  B loop1

enableApb2BusClock:
  LDR r1,=RCC_APB2ENR
  LDR r2,[r1]
  MOV r0,#1
  LSL r0,#2
  ORR r0,r0,r2
  STR r0,[r1]
  BX lr

setReadCharFlag:
  LDR r0,=readCharFlag
  MOV r1,#1
  STR r1,[r0]
  BX lr

initCharPtr:
  LDR r0,=charPtr
  LDR r1,=TEXT_TO_READ
  STR r1,[r0]
  BX lr

setupPa5Pin:
  LDR r1,=GPIOA_CRL
  LDR r2,[r1]
  MOV r0,#1
  LSL r0,#20
  ORR r0,r0,r2
  MOV r2,#1
  LSL r2,#22
  EOR r0,r0,r2
  STR r0,[r1]
  BX lr

setupSysTick:
  LDR r1,=STK_CTRL
  EOR r2,r2
  STR r2,[r1]
  LDR r1,=STK_LOAD
  LDR r0,=DOT_DELAY
  STR r0,[r1]
  LDR r1,=STK_VAL
  EOR r2,r2
  STR r2,[r1]
  LDR r1,=STK_CTRL
  MOV r2,#7
  STR r2,[r1]
  BX lr

processCharacter:
  PUSH {lr}
  LDR r0,=readCharFlag
  LDR r0,[r0]
  CMP r0,#0  
  IT NE
  BLNE setElemPtr
  BL processElem
  POP {pc}

processElem:
  PUSH {lr}
  getElem:
  LDR r1,=elemPtr
  LDR r0,[r1]
  LDRB r3,[r0]
  CBNZ r3,blinkElem
  LDR r0,=endOfCharFlag  
  MOV r1,#1
  STR r1,[r0]
  BL incrementCharPtr
  LDR r0,=readCharFlag
  MOV r1,#1
  STR r1,[r0]
  LDR r0,=DOT_DELAY
  LDR r1,=STK_LOAD
  STR r0,[r1]
  POP {pc}
  blinkElem:
  CMP r3,#0x2D
  ITE EQ
  LDREQ r0,=DASH_DELAY
  LDRNE r0,=DOT_DELAY
  LDR r1,=STK_LOAD
  STR r0,[r1]
  BL incrementElemPtr
  POP {pc}

setElemPtr:
  PUSH {lr}
  LDR r0,=readCharFlag
  MOV r1,#0
  STR r1,[r0]  
  LDR r0,=charPtr
  LDR r0,[r0]
  LDRB r0,[r0]
  CMP r0,#0
  IT NE
  BNE getChar
  BL switchOffLed
  B loop1
  getChar:
  CMP r0,0x20
  BNE getLetter
  LDR r0,=endOfCharFlag
  MOV r1,#1
  STR r1,[r0]
  LDR r0,=readCharFlag
  MOV r1,#1
  STR r1,[r0]
  LDR r0,=WORD_DELAY
  LDR r1,=STK_LOAD
  STR r0,[r1]
  POP {pc}
  getLetter:
  SUB r0,#0x41
  MOV r2,#4
  MUL r0,r2
  LDR r1,=LETTER_ADDRESSES
  ADD r1,r1,r0
  LDR r1,[r1]
  LDR r2,=elemPtr  
  STR r1,[r2]
  POP {pc}

incrementCharPtr:
  LDR r0,=charPtr
  LDR r1,[r0]
  ADD r1,#1
  STR r1,[r0]
  LDR r0,=readCharFlag
  MOV r1,#1
  STR r1,[r0]
  BX lr

incrementElemPtr:
  LDR r0,=elemPtr
  LDR r1,[r0]
  ADD r1,#1
  STR r1,[r0]
  BX lr

switchOnLed:
  LDR r1,=GPIOA_BSRR
  LDR r2,[r1]
  MOV r0,#1
  LSL r0,r0,#5
  ORR r0,r0,r2
  STR r0,[r1]
  BX lr

switchOffLed:
  LDR r1,=GPIOA_BSRR
  LDR r2,[r1]
  MOV r0,#1
  LSL r0,r0,#21
  ORR r0,r0,r2
  STR r0,[r1]
  BX lr
  
createMorseArray:
  LDR r0,=LETTER_ADDRESSES  
  LDR r1,=A
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=B
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=C
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=D
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=E
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=F
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=G
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=H
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=I
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=J
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=K
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=L
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=M
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=N
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=O
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=P
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=Q
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=R
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=S
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=T
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=U
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=V
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=W
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=X
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=Y
  STR r1,[r0]
  ADD r0,#4
  LDR r1,=Z
  STR r1,[r0]
  ADD r0,#4
  BX lr
