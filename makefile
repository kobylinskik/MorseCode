TARGET = morse

CC = arm-none-eabi-gcc

CCFLAGS += -mcpu=cortex-m3
CCFLAGS += -mthumb
CCFLAGS += -nostdlib
CCFLAGS += -g

INPUT = morse.S
LD = -T./linkerScript.ld
OUTPUT = -o morse.elf

$(TARGET).elf:
	$(CC) $(CCFLAGS) $(INPUT) $(LD) $(OUTPUT)

clean:
	rm morse.elf