;nasm -f elf ques2.asm && ld -m elf_i386 -s -o ques2 ques2.o && ./ques2
section .bss
    
section .data
      msg1	db 'Amstrong number',0xa 
      len1	equ	$ - msg1
      msg2	db 'Not Amstrong number',0xa 
      len2	equ	$ - msg2
      num dd 54748
      originalnum dd 54748
      count dd 0
      sum dd 0
      rem dd 0

section .text
      global _start

_start:
      mov eax,[num]
      mov ecx,0
      xor edx,edx

convert_number:                      
      mov ebx,10                          
      div ebx                             
      add edx,'0'                         
      push edx                            
      xor edx,edx                         
      inc ecx                             
      cmp eax,0                           
      jne convert_number 
      mov [count],ecx

      mov eax,[num]
      mov ecx,0
      xor edx,edx

check:
      mov ebx,10
      div ebx
      mov [num],eax
      mov [rem],edx
      mov eax,[rem]
      mov ebx,[rem]
      mov ecx,[count]
      dec ecx
      .other:
            mul ebx
            DEC	ecx
            jnz	.other
      add [sum],eax
      mov eax,[num]
      cmp eax,0
      jg check
      mov eax,[originalnum]
      mov ebx,[sum]
      cmp eax,ebx
      jne isNotAmstrong

isAmstrong:
      mov edx,len1
      mov ecx,msg1
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80	   ;call kernel
      call exit

isNotAmstrong:
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