.section .rodata,"a"

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
.equ RCC_CFGR,RCC+0x4
.equ RCC_APB2ENR,RCC+0x18
.equ RCC_APB1ENR,RCC+0x1C

.equ GPIOA,0x40010800
.equ GPIOA_CRL,GPIOA
.equ GPIOA_CRH,GPIOA+0x4
.equ GPIOA_BSRR,GPIOA+0x10

.equ USART2,0x40004400
.equ USART2_DR,USART2+0x4
.equ USART2_BRR,USART2+0x8
.equ USART2_CR1,USART2+0xC
.equ USART2_CR2,USART2+0x10
.equ USART2_CR3,USART2+0x14
.equ USART2_GTPR,USART2+0x18
.equ BAUD_RATE_SETUP,0xEA6

.equ STK,0xE000E010
.equ STK_CTRL,STK
.equ STK_LOAD,STK+0x4
.equ STK_VAL,STK+0x8
.equ STK_CALIB,STK+0xC

.equ DOT_DELAY,0x100000
.equ DASH_DELAY,0x300000
.equ WORD_DELAY,0x500000

