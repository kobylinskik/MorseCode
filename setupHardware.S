.syntax unified
.section .text

setupHardware:
  PUSH {lr}
  BL setupClocks
  BL setupPins
  BL setupUart2
  POP {pc}

setupClocks:
  //Enable USART2
  LDR r5,=RCC_APB1ENR
  LDR r6,[r5]
  MOV r7,#1
  LSL r7,#17
  ORR r6,r7
  STR r6,[r5]
  //Enable GPIOA
  LDR r5,=RCC_APB2ENR
  LDR r6,[r5]
  MOV r7,#1
  LSL r7,#2
  ORR r6,r7
  STR r6,[r5]
  //Configure system clock to PLL, PLL source -> HSI/2, multiplied x9 ((8MHz/2) * 9 = 36 MHz). 
  //HSI is the default PLL source
  LDR r5,=RCC_CFGR
  LDR r6,[r5]
  //Set PLL as the system clock
  MOV r7,#1
  LSL r7,#1
  ORR r6,r7
  //Set PLL multiplier
  LSL r7,#17
  ORR r6,r7
  LSL r7,#1
  ORR r6,r7
  LSL r7,#1
  ORR r6,r7
  STR r6,[r5]
  //Enable HSI and PLL
  LDR r5,=RCC
  LDR r6,[r5]
  MOV r7,#1
  ORR r6,r7
  LSL r7,#24
  ORR r6,r7
  STR r6,[r5]
  //Set r7 to 1<<1, to check HSI status
  MOV r7,#1
  LSL r7,#1
checkHsiClockStatus:
  LDR r5,=RCC
  LDR r6,[r5]
  ANDS r6,r7
  //If HSI isn't ready, wait
  IT EQ
  BEQ checkHsiClockStatus
  //Set r7 to 1<<25, to check PLL status
  LSL r7,#24
checkPllClockStatus:
  LDR r5,=RCC
  LDR r6,[r5]
  ANDS r6,r7
  //If PLL isn't ready, wait
  IT EQ
  BEQ checkPllClockStatus
  BX lr

setupPins:
//Set PA5 pin to Output mode
  LDR r5,=GPIOA_CRL
  LDR r6,[r5]
  MOV r7,#1
  LSL r7,#20
  ORR r7,r7,r6
  MOV r6,#1
  LSL r6,#22
  EOR r7,r7,r6
  STR r7,[r5]
  //Set PA3 pin to input with pull-up
  LDR r5,=GPIOA_CRL
  LDR r6,[r5]
  MOV r7,#1
  LSL r7,#15
  ORR r6,r7
  BFC r6,#14,#1
  STR r6,[r5]
  BX lr

setupUart2:
  //Set baud rate to 9600
  LDR r5,=USART2_BRR
  LDR r6,=BAUD_RATE_SETUP
  STR r6,[r5]
  //Set the prescaler to 1
  LDR r5,=USART2_GTPR
  MOV r6,#4
  STR r6,[r5]
  //Enable receiver and the UART itself
  LDR r5,=USART2_CR1
  LDR r6,[r5]
  MOV r7,#1
  LSL r7,#2
  ORR r6,r7
  LSL r7,#11
  ORR r6,r7
  STR r6,[r5]
  BX lr

setupSysTick:
  LDR r5,=STK_CTRL
  EOR r6,r6
  STR r6,[r5]
  LDR r5,=STK_LOAD
  LDR r7,=DOT_DELAY
  STR r7,[r5]
  LDR r5,=STK_VAL
  EOR r6,r6
  STR r6,[r5]
  LDR r5,=STK_CTRL
  MOV r6,#3
  STR r6,[r5]
  BX lr
