.section .rodata,"a"

TEXT_TO_READ: .asciz "TEST WORD"

A: .asciz "*-"
B: .asciz "-***"
C: .asciz "-*-*"
D: .asciz "-**"
E: .asciz "*"
F: .asciz "**-*"
G: .asciz "--*"
H: .asciz "****"
I: .asciz "**"
J: .asciz "*---"
K: .asciz "-*-"
L: .asciz "*-**"
M: .asciz "--"
N: .asciz "-*"
O: .asciz "---"
P: .asciz "*--*"
Q: .asciz "--*-"
R: .asciz "*-*"
S: .asciz "***"
T: .asciz "-"
U: .asciz "**-"
V: .asciz "***-"
W: .asciz "*--"
X: .asciz "-**-"
Y: .asciz "-*--"
Z: .asciz "--**"

.equ RCC,0x40021000
.equ RCC_APB2ENR,RCC+0x18
.equ GPIOA,0x40010800
.equ GPIOA_CRL,GPIOA
.equ GPIOA_CRH,GPIOA+0x4
.equ GPIOA_BSRR,GPIOA+0x10
.equ STK,0xE000E010
.equ STK_CTRL,STK
.equ STK_LOAD,STK+0x4
.equ STK_VAL,STK+0x8
.equ STK_CALIB,STK+0xC
.equ CONTROL_DELAY,0xFFFFFF
.equ DOT_DELAY,0x200000
.equ DASH_DELAY,0x600000
.equ WORD_DELAY,0xA00000

.global vtable
.global resetHandler
.global sysTick_IRQHandler

.section .vector_table,"a"
.type vtable, %object
vtable:
  .word 0
  .word resetHandler
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word sysTick_IRQHandler
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
.size vtable, .-vtable

.section .bss
LETTER_ADDRESSES: 
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0

ledOn: .word 0
readCharFlag: .word 0
endOfCharFlag: .word 0
charPtr: .word 0
elemPtr: .word 0
