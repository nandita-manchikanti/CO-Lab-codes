;nasm -f elf ques4.asm && ld -m elf_i386 -s -o ques4 ques4.o && ./ques4
extern rand

section .bss
      print_num resb 1000

section .data
      array dd 0,0,0,0,0,0,0,0
      num dd 8
      num1 dd 0
      sum dd 0

section .text
      global _start

_start:
      mov ecx,[num]
      xor edx,edx

fill_array:
      rdtsc
      xor edx,edx
      mov ebx,100
      div ebx
      mov [array+(ecx-1)*4],edx
      mov [num1],edx
      xor edx,edx
      dec ecx
      mov [num],ecx
      mov eax,[num1]
      call print_number
      mov ecx,[num]
      cmp ecx,0
      jne fill_array

clearing:
      xor ecx,ecx
      xor eax,eax
      xor edx,edx
      mov ecx,8

sumofarray:
      mov eax,[array+(ecx-1)*4]
      add [sum],eax
      dec ecx
      cmp ecx,0
      jne sumofarray

printnum:
      mov eax,[sum]
      call print_number
      
exit:
      mov eax,1
      xor ebx,ebx
      int 0x80

print_number:                             ;fuction to print multiple digits
      xor edx,edx                         ;clearing the register edx
      xor ecx,ecx                         ;clearing the register ecx

convert_number:                           ;coverting number into ascii
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

