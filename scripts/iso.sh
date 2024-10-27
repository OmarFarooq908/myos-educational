pwd
cp build/kernel.bin iso/boot/kernel.bin
cp iso/boot/grub/grub.cfg iso/boot/grub/grub.cfg
grub-mkrescue -o build/myos.iso iso
qemu-system-i386 -cdrom build/myos.iso
