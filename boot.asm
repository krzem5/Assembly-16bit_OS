[bits 16]
[org 0x7c00]



start:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov bx, 0x8000
	mov dx, [VGA_MEM]
	mov es, dx
	call clear_screen
	mov si,PRINT_STRING
	call print_str
	ret



print_str:
	._next_char:
		lodsb
		cmp al, 0
		je ._done
		mov di, word[VGA_INDEX]
		mov [es:di], al
		add word[VGA_INDEX], 2
		jmp ._next_char



	._done:
		ret



clear_screen:
	mov di, 0



	._clr_loop:
		cmp di, word[MAX_VGA_INDEX]
		je ._done
		mov al, 0
		mov [es:di], al
		add di, 2
		jmp ._clr_loop



	._done:
		ret



VGA_MEM dw 0xB800
MAX_VGA_INDEX dw 0xF9E
VGA_INDEX dw 0x00
PRINT_STRING db "Hello World!", 0
times (510-($-$$)) db 0x00
dw 0xAA55
