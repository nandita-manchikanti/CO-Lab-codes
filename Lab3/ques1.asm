;nasm -f elf ques1.asm && ld -m elf_i386 -s -o ques1 ques1.o && ./ques1

section .bss
      print_num resb 1000
    
section .data
      num1 dd 345
      num2 dd 323
      num3 dd 1000
      num4 dd 567
      num5 dd 234

section .text
      global _start

_start:

print_first_num:
      mov eax,[num1]
      call print_number

print_sec_num:
      mov eax,[num2]
      call print_number

print_third_num:
      mov eax,[num3]
      call print_number

print_fourth_num:
      mov eax,[num4]
      call print_number

print_fifth_num:
      mov eax,[num5]
      call print_number

compare_function1:
      mov eax,[num1]
      cmp eax,[num2]
      jg check_3rd_num
      mov eax,[num2]

check_3rd_num:
      cmp eax,[num3]
      jg check_4th_num
      mov eax,[num3]

check_4th_num:
      cmp eax,[num4]
      jg check_5th_num
      mov eax,[num4]

check_5th_num:
      cmp eax,[num5]
      jg print_max
      mov eax,[num5]
      call print_number
      call exit
      
print_max:
      call print_number
      call exit

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