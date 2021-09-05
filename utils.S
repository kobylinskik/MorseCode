//Initialize pointer to the first character of the text to blink. r0 -> returns charPtr
initCharPtr:
  LDR r0,=charPtr
  LDR r6,=text
  STR r6,[r0]
  BX lr

//r0 -> returns charPtr
incrementCharPtr:
  LDR r0,=charPtr
  LDR r6,[r0]
  ADD r6,#1
  STR r6,[r0]
  BX lr

incrementElemPtr:
  LDR r5,=elemPtr
  LDR r6,[r5]
  ADD r6,#1
  STR r6,[r5]
  BX lr

initTextWithZeroes:
  PUSH {lr}
  LDR r7,=charPtr
  MOV r6,#0
  LDR r5,=text
  loopThroughText:  
  STR r6,[r5]
  ADD r5,#4
  CMP r5,r7
  IT NE
  BNE loopThroughText
  POP {pc}  

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
