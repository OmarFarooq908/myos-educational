// kernel.c - Simple Kernel for MicrokernelOS

void kernel_main(void) {
    const char *str = "Hello from the Kernel!";
    char *vidmem = (char *)0xb8000; // Video memory for text mode

    for (int i = 0; str[i] != '\0'; i++) {
        vidmem[i * 2] = str[i];       // Character
        vidmem[i * 2 + 1] = 0x07;     // Attribute byte (light grey on black)
    }

    while (1); // Loop forever
}

