@echo off
cls
if exist build rmdir /s /q build
mkdir build
nasm -f bin src/boot.asm -o build/boot.bin&&cls&&qemu-system-x86_64 -drive file=build/boot.bin,format=raw,index=0,media=disk
