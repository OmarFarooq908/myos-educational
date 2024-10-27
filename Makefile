# Variables
CC = gcc
LD = ld
AS = nasm

CFLAGS = -m32 -Wall
LDFLAGS = -m elf_i386  # Use this instead of -T linker.ld for 32-bit output

# Files
BOOT_OBJ = build/boot.o
KERNEL_OBJ = build/kernel.o
KERNEL_BIN = build/kernel.bin

# Targets
all: $(KERNEL_BIN)

$(KERNEL_BIN): $(KERNEL_OBJ) $(BOOT_OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

build/%.o: src/boot/%.asm
	$(AS) -f elf32 $< -o $@

build/%.o: src/kernel/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f build/*.o build/*.bin

