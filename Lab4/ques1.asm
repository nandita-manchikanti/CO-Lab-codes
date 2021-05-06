;nasm -f elf ques1.asm && ld -m elf_i386 -s -o ques1 ques1.o && ./ques1

section .bss

section .data
      msg1	db 'Prime number',0xa 
      len1	equ	$ - msg1
      msg2	db 'Not Prime number',0xa 
      len2	equ	$ - msg2

      num dd 11
      i dd 2

section .text
      global _start

_start:
      mov ebx,2   	;initial value to be used
      mov eax,[num]
      cmp eax,1 
      jle isNotPrime
      cmp eax,[i]
      je isPrime

      loopPrime:
            xor edx,edx
            mov eax,[num]
            div ebx
            cmp edx,0
            je isNotPrime
            inc ebx
            cmp ebx,[num]
            je isPrime
            jmp loopPrime

isPrime:
      mov edx,len1
      mov ecx,msg1
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80	   ;call kernel
      call exit

isNotPrime:
      mov edx,len2
      mov ecx,msg2
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80	   ;call kernel
      call exit

exit:
      mov eax,1
      xor ebx,ebx
      int 0x80 