;nasm -f elf ques1.asm && ld -m elf_i386 -s -o ques1 ques1.o && ./ques1

section	.text
   global _start                 ;must be declared for linker (ld)
    
_start:	                         ;tells linker entry point
   mov	edx,len                  ;message length
   mov	ecx,msg                  ;message to write
   mov	ebx,1                    ;file descriptor (stdout)
   mov	eax,4                    ;system call number (sys_write)
   int	0x80                     ;call kernel
    
   mov	eax,1                    ;system call number (sys_exit)
   int	0x80                     ;call kernel

section	.data
    msg db 'Hello world!', 0xa    ;string to be printed
    len equ $ - msg               ;length of the string 
    
    ;In this case, the $ means the current address according to the assembler.
    ; $ - msg is the current address of the assembler minus the address of msg,
    ; which would be the length of the string.