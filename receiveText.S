receiveText:
  BL initCharPtr

receiverLoop:
  MOV r1, #0  
  checkUartStatus:
  MOV r6,#1
  LSL r6,#5
  LDR r5,=USART2
  LDR r5,[r5]
  ANDS r6,r5
  IT EQ
  BEQ checkUartStatus
  test:
  LDR r6,=USART2_DR
  LDR r6,[r6]
  CMP r6,#0xD
  IT EQ
  BEQ terminateString
  LDR r5,=charPtr
  LDR r5,[r5]  
  STR r6,[r5]
  BL incrementCharPtr
  B receiverLoop

//Null-terminate the String
terminateString:
  LDR r5,=charPtr
  LDR r5,[r5]  
  EOR r6,r6
  STR r6,[r5]
  B blinkText
