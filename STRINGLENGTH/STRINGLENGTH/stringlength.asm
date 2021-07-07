;//Author: PeaceBeUponYou
.code
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

