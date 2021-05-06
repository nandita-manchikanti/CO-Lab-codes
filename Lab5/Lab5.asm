;ALP for addition of 2 3-digit numbers
;nasm -f elf Lab5.asm && ld -m elf_i386 -s -o Lab5 Lab5.o && ./Lab5

%include "utils_fun.asm"
section .data
   num1 dd 745 
   num2 dd 326
   
   array:
        dd 745,326
   
    msg db "The sum is : "
    len equ $- msg
   
    msg1 db "1.By Direct Addressing mode "
    len1 equ $- msg1

    msg2 db "2.By Indirect Addressing mode: "
    len2 equ $- msg2

    msg3 db "3.By Immediate Addressing mode: "
    len3 equ $- msg3
    
    msg4 db "4.By direct offset Addressing mode: "
    len4 equ $- msg4
    
    msg5 db "5.By Relative Addressing mode: "
    len5 equ $- msg5
    
    msg6 db "6.By Indexed Addressing mode: "
    len6 equ $- msg6

    msg7 db "7.By Register Direct Addressing mode: "
    len7 equ $- msg7

    msg8 db "8.By Register Indirect Addressing mode: "
    len8 equ $- msg8
    
    msg9 db "9.By Auto increment Addressing mode: "
    len9 equ $- msg9
    
    msg10 db "10.By Auto decrement Addressing mode: "
    len10 equ $- msg10
   
section .text
   global _start

_start:

;1.Direct Addressing mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80
    
    mov	edx,len	        
    mov	ecx,msg	        
    mov	ebx,1	        
    mov	eax,4	        
    int	0x80
    
    mov eax, [num1]       ;Directly                
    mov ebx, [num2]
    add eax,ebx
    call print_number
    
;2.InDirect Addressing Mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80
    
    mov	edx,len	        
    mov	ecx,msg	        
    mov	ebx,1	        
    mov	eax,4	        
    int	0x80
    
    mov eax, [num1]
    mov ebx ,[num2]
    add eax,ebx
    call print_number
    
;3.Immediate Addressing Mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 0x80
    
    mov	edx,len	        
    mov	ecx,msg	        
    mov	ebx,1	        
    mov	eax,4	        
    int	0x80
    
    mov eax, 745                          
    add eax, 326
    call print_number
    
;4. Direct-Offset Addressing Mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, len4
    int 0x80
    
    mov eax, [array+0]  ;using offset
    add eax, [array+1*4]            
    call print_number
   
;5. Relative Addressing Mode
   mov eax, 4
   mov ebx, 1
   mov ecx, msg5
   mov edx, len5
   int 0x80
   
   mov eax, [array+0]
   call print_number
    
;6. Indexed Addressing Mode
   mov eax, 4
   mov ebx, 1
   mov ecx, msg6
   mov edx, len6
   int 0x80
   
   mov esi,0
   mov eax,[array+esi*4] 
   inc esi
   call print_number
    
;7. Register Direct Addressing Mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg7
    mov edx, len7
    int 0x80
    
    mov	edx,len	        
    mov	ecx,msg	        
    mov	ebx,1	        
    mov	eax,4	        
    int	0x80
    
    mov eax, [num1]
    mov ebx, [num2]                         
    add eax, ebx
    call print_number
    
;8. Register Indirect Addressing Mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg8
    mov edx, len8
    int 0x80
    
    mov	edx,len	        
    mov	ecx,msg	        
    mov	ebx,1	        
    mov	eax,4	        
    int	0x80
    
    mov eax, num1                           
    mov ebx, [eax]
    mov eax, num2
    mov ecx, [eax]
    add ebx,ecx
    mov eax,ebx
    call print_number
    
;9. Auto-Increment Addressing Mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg9
    mov edx, len9
    int 0x80
    
    mov eax,49
    inc eax
    call print_number
    
;10. Auto-Decrement Addressing Mode
    mov eax, 4
    mov ebx, 1
    mov ecx, msg10
    mov edx, len10
    int 0x80
    
    mov eax,49
    dec eax
    call print_number
    
exit:
      mov eax,1
      xor ebx,ebx
      int 0x80

