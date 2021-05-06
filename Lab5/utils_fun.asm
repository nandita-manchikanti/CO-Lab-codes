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

section .bss
    print_num resb 100
    num resb 100