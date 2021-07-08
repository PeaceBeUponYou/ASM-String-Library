;//Author : PeaceBeUponYou
.code
normalToUnicode proc ;normalToUnicode(char*, wchar_t*)
    enter 0,0
    sub rsp,8 ;[rbp-8]->counter

	push rsi
	push rdi
	lea rsi, [rcx] ;source (normal) string
	lea rdi, [rdx] ;destination (unicode) container
    
    lea rdx,[rbp-8]
    xor r8,r8  ;normal
    call stringLength
    mov ecx,dword ptr [rbp-8] ;getting char length in counter register
    test ecx,ecx
    jz nTuEnding
nTULoop:
    lodsb
    stosw
    loop nTULoop
    mov dword ptr [rdi],00
nTuEnding:
	pop rdi
	pop rsi

    add rsp,8
	leave
	ret
normalToUnicode endp
;........................
unicodeToNormal proc
    enter 0,0
    sub rsp,8 ;[rbp-8]->counter

	push rsi
	push rdi
	lea rsi, [rcx] ;source (normal) string
	lea rdi, [rdx] ;destination (unicode) container
    
    lea rdx,[rbp-8]
    xor r8,r8 
    mov r8d,01   ;unicode
    call stringLength
    mov ecx,[rbp-8] ;getting char length in counter register
    test ecx,ecx
    jz nTuEnding
nTULoop:
    lodsw
    stosb
    loop nTULoop
    mov word ptr [rdi],00
nTuEnding:
	pop rdi
	pop rsi

    add rsp,8
	leave
	ret
unicodeToNormal endp
;////////////////////////////
stringLength proc ;stringLength(*string=rcx, *counter=rdx, type=rax)
 enter 0,0
 push rdi
 mov eax,r8d
 mov rdi,rcx
 test eax,eax ;0:UTF-8, 1:Unicode
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
