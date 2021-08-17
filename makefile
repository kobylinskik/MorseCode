main:
	arm-none-eabi-gcc -mcpu=cortex-m3 -nostdlib morse.S -T./linkerScript.ld -g -o morse.elf
