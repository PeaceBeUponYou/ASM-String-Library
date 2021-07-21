.code
thegsubfunction proc ;//thegsubfunction(*sourcestring=rcx, *matchstring = rdx, *replaceString = r8,  *finalStore =r9)
    enter 0,0
    sub rsp ,300h

    push rcx
    push r8
    push r9
    xor rax,rax

    lea r9,[rbp - 300h]
    xor r8,r8 
    mov [rbp-8],r8
    lea r8,[rbp-8]
    call stringFindMain 
    test eax,eax 
    jz nomatchSoSkipgsub

    pop r9
    pop r8

    push r8
    push rax

    lea rdx,[rbp-8h]
    lea rcx,[r8]
    xor r8,r8
    call stringLength
 
    pop rax
    pop r8
    pop rcx

    push rsi
    push rdi
    lea rsi,[rcx] 
    lea rdi,[r9] 
    lea rdx,[rbp-300h] 
    mov ecx,[rdx] 
    xor r13d,r13d
    mov [rdx+rax*8],r13
    gsubbing:
    inc r13d
    test ecx,ecx
    jz writeNormal
    cmp ecx,r13d 
    jg writeNormal
    test rcx,rcx 
    jz gsubending
    push rsi
    lea rsi,[r8] 
    mov ecx,[rdx+4] 
    sub ecx,[rdx] 
    add r13d,ecx 
    inc ecx
    add [rsp],ecx
    mov ecx,[rbp-8] 
    rep movsb
    add rdx,8
    mov ecx,[rdx] 
    pop rsi
    jmp gsubbing
    writeNormal:
    movsb
    cmp byte ptr [rsi],0
    jne gsubbing

    gsubending:
    xor eax,eax
    mov [rdi],eax
    pop rdi
    pop rsi
    nomatchSoSkipgsub:
    add rsp,300h
    leave
    ret
thegsubfunction endp
stringFindMain proc ;//stringFindMain(*sourceString=rcx,*toFindString=rdx,*startFrom(long int)=r8,*result[]=r9),
    enter 0,0
    sub rsp, 20h
    push rcx
    push rdx 
    push r9 
    mov qword ptr [rbp-8h],rax 
    mov qword ptr [rbp-10h],rax 
    mov qword ptr [rbp-18h],rax 
    mov qword ptr [rbp-20h],rax 

    push r8
 
    lea rdx,[rbp-8]
    mov rcx,[rbp-28h]
    xor r8,r8
    call stringLength

    lea rdx,[rbp-10h]
    mov rcx,[rbp-30h]
    xor r8,r8
    call stringLength

    pop r8

    mov eax, [rbp-8]
    cmp eax, [rbp-10h]
    jl endline 
    mov cx, [r8]
    movsx rcx,cx
    mov [r8+4],ecx

    push rcx 
    mov  ecx,[rbp-8]
    push rcx
    call getStartPoint
    mov [r8],eax
 
    loopagain: 
    lea rcx,[r9]
    add cx,[rbp-18h]
    push rcx 
    lea rcx,[rbp-18h]
    push rcx
    mov ecx,[rbp-10h]
    movzx rcx,cx
    push rcx 
    push 00 
    lea rcx,[rbp-20h]
    push rcx 
    mov ax,[r8]
    movzx rax,ax
    push rax 
    mov rcx,[rbp-30h]
    push rcx 
    mov rcx,[rbp-28h]
    push rcx 
    call matchChars
    mov ecx,[r8]
    add [rbp-20h],ecx
    mov ecx,[rbp-20h]
    mov [r8],rcx
    mov ecx,[rbp-8h]
    sub ecx,[r8]
    cmp ecx,[rbp-10h]
    jge loopagain
    lea rdx,[r9]
    mov eax, [rdx]
    test eax,eax
    je endline
    mov eax,dword ptr [rbp-18h]
    shr eax,3 
    mov r9,[rbp-38h] 
    xor rcx,rcx
    mov [r9+rax*8],rcx
    endline:
    mov cx, [r8+4]
    movzx rcx,cx
    mov [r8],ecx

    add rsp,38h
    leave
    ret
stringFindMain endp
clearDestination proc 
    push rax
    xor rax,rax
    lea rdi,[rcx]
    test edx,edx 
    jz cdhere
    mov ecx,edx
    rep stosb
    jmp cdend
    cdhere:
    stosb
    cmp byte ptr [rdi],00
    jne cdhere
    cdend:
    pop rax
    ret
clearDestination endp
matchChars proc
    enter 0,0 
    mov rcx,[rbp+40h] 
    add qword ptr [rcx],8
    mov rsi,[rbp+18h]
    mov rdx,[rbp+48h]
    mov rcx,[rbp+10h] 
    mov rax,[rbp+20h] 
    lea rdi,[rcx+rax]
    mov rcx,[rbp+28h] 
    xor eax,eax
    mov [rcx],eax
backhash:
    lodsb 
findloop:
    inc dword ptr [rcx]
    scasb 
    jne checkDest
    inc dword ptr [rbp+30h] 
    mov rdx,[rbp+48h]
    mov eax, [rbp+30h] 
    cmp eax,01 
    jne mcSkip1
    mov eax,[rcx]
    add eax,[rbp+20h]
    mov [rdx],eax
mcSkip1:
    mov eax, [rbp+30h] 
    cmp eax, [rbp+38h]
    jne mcSkip2
    mov eax,[rcx]
    add eax,[rbp+20h]
    mov rdx,[rbp+48h]
    jmp goodridince
mcSkip2:
    cmp byte ptr [rdi],00 
    jne backhash 
    jmp ending

checkDest:
    cmp dword ptr [rbp+30h],01 
    jl silk
    xor rcx,rcx
    mov rdx,[rbp+48h]
    mov [rdx],rcx
    mov ecx, dword ptr [rbp+30h] 
    sub rdi,rcx
    mov rcx,[rbp+28h]
    mov eax, dword ptr [rbp+30h] 
    sub [rcx], eax
    mov dword ptr [rbp+30h],00
    mov rsi,[rbp+18h]
    lodsb
silk:
    cmp byte ptr [rdi],00
    jne findloop
    mov rcx,[rbp+40h] 
    sub qword ptr [rcx],8 
ending: 
    mov al,0
    movzx eax,al
    mov rdx,[rbp+48h]
    mov [rdx],eax
goodridince:
    mov [rdx+4],eax
    leave 
    ret 40h 
matchChars endp
getStartPoint proc 
    enter 0,0
    cvtsi2ss xmm0,dword ptr [rbp+10h]
    cvtsi2ss xmm1,dword ptr [rbp+18h]
    shufps xmm0,xmm0,0
    xor eax,eax
    ptest xmm1,xmm1 
    jz getout
    shufps xmm1,xmm1,0 
    addsubps xmm0,xmm1 
    blendps xmm1,xmm0,2 
    shufps xmm1,xmm1,1 
    cmpss xmm0,xmm1,6 
    movmskps eax,xmm0
    test eax,01
    jz skip1 
    cvtss2si eax,xmm1
    test eax,eax
    jns getout 
    xor eax,eax 
    jmp getout
    skip1:
    mov eax,[rbp+18h]
    dec eax

    getout:
    leave 
    ret 10h
getStartPoint endp
stringLength proc ;stringLength(*string=rcx, *counter=rdx, type=r8d)
    enter 0,0
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
    leave
    ret
stringLength endp

end
