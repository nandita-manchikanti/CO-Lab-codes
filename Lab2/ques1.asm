;Addition of two 3-digit numbers
;nasm -f elf ques1.asm && ld -m elf_i386 -s -o ques1 ques1.o && ./ques1

section .bss
      print_num resb 1000
    
section .data
      num1 dd 231
      num2 dd 425

section .text
      global _start

_start:

print_first_num:
      mov eax,[num1]
      call print_number

print_sec_num:
      mov eax,[num2]
      call print_number

add_num:
      mov eax,[num1]
      mov ebx,[num2]
      add eax,ebx
      call print_number

exit:
      mov eax,1
      xor ebx,ebx
      int 0x80

print_number:                             ;fuction to print multiple digits
      xor edx,edx                         ;clearing the register edx
      xor ecx,ecx                         ;clearing the register ecx

convert_number:                       ;coverting number into ascii
      mov ebx,10                          ;ebx<-10
      div ebx                             ;eax(quotient) & edx(reminder)
      add edx,'0'                         ;decimal to ascii

      push edx                            ;push the reminder
      xor edx,edx                         ;clearing the register edx
      inc ecx                             ;find the length of number
      cmp eax,0                           ;cont. untill quotient is not 0
      jne convert_number                  ;jump if not equal
    
reverse_string:
      pop dword[print_num+eax]            ;dword is array of size 32 bits[]
      inc eax                             ;contains the size of the string to be printed             
      dec ecx                             ;exit when all digits are poped
      jne reverse_string                  ;jump if not equal to zero

      mov byte[print_num+eax],0xa         ;line feed (starts a new line)
      mov byte[print_num+eax+1],0xd       ;carraige return (brings the cursor to the start of the line)
      add eax,2                           ;adding two for \n and \r

      mov edx,eax                         ;set buffer size to be printed to eax
      mov ecx,print_num                   ;moving number into ecx
      mov ebx,1                           ;calling stdout
      mov eax,4                           ;system call number
      int 0x80                            ;call kernel     
      ret                                                        

