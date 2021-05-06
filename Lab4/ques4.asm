;nasm -f elf ques4.1.asm && ld -m elf_i386 -s -o ques4.1 ques4.1.o && ./ques4.1
section .bss
      print_num resb 1000

section .data
    global x
    string db 'Hello IIITDM Kancheepuram', 0 
    len equ $ - string 
    array TIMES len dd 0

    characters dd 0
    words dd 0
    vowels dd 0
    consonants dd 0

    msg1 db 'The number of characters are :',0xa
    len1 equ $ - msg1
    msg2 db 'The number of words are :',0xa
    len2 equ $ - msg2
    msg3 db 'The number of vowels are :',0xa
    len3 equ $ - msg3
    msg4 db 'The number of consonants are :',0xa
    len4 equ $ - msg4

section .text
    global _start     ;must be declared for linker (ld)

_start:            
      enter 0,0
      pusha
      xor ecx,ecx

count_char:
        cmp byte[string+ecx], 0x0       ; check for end of string
        je count_words

        mov eax, 0                      ; empty eax
        mov al, byte[string+ecx]        ; move string position into al
        mov byte[array+ecx], al         ; write into memory

        push eax
        mov eax, 0
        mov al, byte[array+ecx]
        pop eax

        inc ecx
        mov [characters],ecx
        jmp count_char
        
count_words:
        enter 0,0
        pusha
        mov esi, 0
        mov ecx, 0 

      wordsloop: 
      
            cmp byte[string+esi],0
            je count_vowels

            cmp  byte[string+esi], ' '   
            jne do_not_count_space   ; skip count if it's not a blank

      count_space:
            inc ecx
            mov [words],ecx             ; it is a blank, count it

      do_not_count_space:
            inc esi
            jmp wordsloop

count_vowels:
    enter 0,0
    pusha
    mov esi, 0
    mov ecx, 0 

vowelloop: 
    cmp byte[string+esi],0
    je count_consonants

    cmp  byte[string+esi],'a'
    je count 
    cmp  byte[string+esi],'e'
    je count 
    cmp  byte[string+esi],'i'
    je count 
    cmp  byte[string+esi],'o' 
    je count
    cmp  byte[string+esi],'u'
    je count 
    cmp  byte[string+esi],'A'
    je count 
    cmp  byte[string+esi],'E' 
    je count
    cmp  byte[string+esi],'I'
    je count 
    cmp  byte[string+esi],'O' 
    je count
    cmp  byte[string+esi],'U'
    je count
    inc esi
    jmp vowelloop

count:
    inc ecx
    mov [vowels],ecx 
    inc esi            
    jmp vowelloop
          
count_consonants:
      mov eax,[characters]
      mov ebx,[words]
      sub eax,ebx
      mov ebx,[vowels]
      sub eax,ebx
      mov [consonants],eax

printing:	
      mov edx,len2
      mov ecx,msg2
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80
      xor eax,eax
      mov eax,[words]
      inc eax
      call print_number 
      mov edx,len1
      mov ecx,msg1
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80                       
      mov eax,[characters]
      call print_number
      mov edx,len3
      mov ecx,msg3
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80
      mov eax,[vowels]
      call print_number
      mov edx,len4
      mov ecx,msg4
      mov ebx,1	   ;file descriptor (stdout)
      mov eax,4	   ;system call number (sys_write)
      int 0x80
      mov eax,[consonants]
      call print_number
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
