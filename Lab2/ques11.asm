;Shift right of a 3-digit number
;nasm -f elf ques11.asm && ld -m elf_i386 -s -o ques11 ques11.o && ./ques11
section .bss
   print_num resb 1000
    
section .data
   num1 dd 231

section .text
   global _start

_start:
    mov eax,[num1]
    call print_number

    mov eax,[num1]
    shr eax,2
    call print_number

   exit:
    mov eax,1
    xor ebx,ebx
    int 0x80

print_number:
      xor edx,edx
      xor ecx,ecx

    convert_number:
          mov ebx,10
          div ebx
          add edx,'0'
    
          push edx
          xor edx,edx
          inc ecx
          cmp eax,0
          jne convert_number
    

    
    reverse_string:
        pop dword[print_num+eax]
        inc eax
        dec ecx
        jne reverse_string
    
        mov byte[print_num+eax],0xa
        mov byte[print_num+eax+1],0xd
        add eax,2
    
        mov edx,eax
        mov ecx,print_num
        mov ebx,1
        mov eax,4
        int 0x80
        ret 
