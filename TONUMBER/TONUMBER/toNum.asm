.code
tonumbermain proc ;tonumbermain(*string=rcx,*number=rdx)
    push rbp
    mov rbp,rsp
    sub rsp,18h
    mov [rbp-10h],rcx
    mov [rbp-18h],rdx 
    push rax
    push rsi

    lea rdx,[rbp-8]
    xor rax,rax
    mov [rbp-8],rax
    call stringLength 

    xor rax,rax
    mov rdx,[rbp-18h] 
    mov [rdx],rax   
    mov rsi, [rbp-10h]
backhere:
    lodsb 
    xor al,30h 
    cmp al,9
    jg errorNotANumber
    mov bl,al 
    movzx rbx,bl

    mov dl,0Ah 
    movzx rdx,dl 
    mov ecx,[rbp-8]
    call power

    imul rax,rbx 
    dec dword ptr [rbp-8]
    mov rdx,[rbp-18h]
    add [rdx],rax

    cmp byte ptr [rsi],00 
    jne backhere

    jmp pops
errorNotANumber:
    xor rax,rax
    mov rdx,[rbp-18h]
    mov [rdx],rax
pops:
    pop rsi
    pop rax

    add rsp,18h
    mov rsp,rbp
    pop rbp
    ret
tonumbermain endp

power proc 
 mov rax,rdx
 dec ecx  
 test rcx,rcx 
 jnz pcheck
 mov rdx,1
 pcheck:
 cmp ecx,1 
 jng endfinal
phere:
 imul rdx,rax
 dec ecx
 cmp ecx,01
 jg phere
endfinal:
 mov rax,rdx
 ret
power endp

stringLength proc 
 push rbp
 mov rbp,rsp
 push rdi
 mov eax,r8d
 mov rdi,rcx
 test eax,eax 
 jne asUni
skipdah:
 xor rax,rax
 mov dword ptr [rdx],eax
steloop:
 inc dword ptr [rdx]
 scasb
 jne steloop
 dec dword ptr [rdx]
 jmp returning
asUni:
 xor rax,rax
 mov dword ptr [rdx],eax
steloop2:
 inc dword ptr [rdx]
 scasw
 jne steloop2
 dec dword ptr [rdx]
returning:
 mov eax,[rdx]
 pop rdi
 mov rsp,rbp
 pop rbp
 ret
stringLength endp

end

