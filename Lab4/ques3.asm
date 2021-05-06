;nasm -f elf ques3.asm && ld -m elf_i386 -s -o ques3 ques3.o && ./ques3
section .bss

section .data
      msg1	db 'Palindrome number',0xa 
      len1	equ	$ - msg1
      msg2	db 'Not Palindrome number',0xa 
      len2	equ	$ - msg2
      originalnum dd 1661
      num dd 1661
      reversenum dd 0
      rem dd 0

section .text
      global _start

_start:
      mov eax,[num]
      xor edx,edx

reverseingnum:
      mov eax,[num]
      mov ebx,10
      div ebx
      mov [num],eax
      mov [rem],edx
      mov eax,[reversenum]
      mul ebx
      add eax,[rem]
      mov [reversenum],eax
      mov eax,0
      cmp eax,[num]
      jne reverseingnum

printing:
      mov eax,[originalnum]
      mov ebx,[reversenum]
      cmp eax,ebx
      jne notequal

equal:
      mov edx,len1
      mov ecx,msg1
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80	   ;call kernel
      call exit

notequal:
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