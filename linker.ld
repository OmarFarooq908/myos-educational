/* linker.ld */
OUTPUT_FORMAT("elf32-x86")
OUTPUT_ARCH(i386)

SECTIONS
{
    . = 0x1000; /* Start of the kernel code */
    .text : { *(.text) }
    .data : { *(.data) }
    .bss : { *(.bss) }
    /DISCARD : { *(.comment) *(.note) }
}

