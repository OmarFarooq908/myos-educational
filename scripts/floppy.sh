dd if=/dev/zero of=build/floppy.img bs=512 count=2880
dd if=build/boot.o of=build/floppy.img bs=512 count=1 conv=notrunc
dd if=build/kernel.bin of=build/floppy.img bs=512 seek=1 conv=notrunc
qemu-system-i386 -fda build/floppy.img
