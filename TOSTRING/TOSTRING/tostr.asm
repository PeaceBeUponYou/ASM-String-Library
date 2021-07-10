.code
tostringMain proc ;//tostringMain(*number=rcx,*string = rdx,sizeOfString=r8d)
push rbp
mov rbp,rsp
sub rsp, 18h
mov [rbp-8],rcx
mov [rbp-10h],rdx

 test r8d,r8d
 jnz yesPresent
 mov r8d, 21
 yesPresent:
 mov rcx,rdx ;//*string
 mov edx,r8d
 call clearDestination 

 xor rax,rax
 mov [rbp-18h],rax 

 mov rcx,[rbp-8] 
 mov rcx,[rcx] 
 lea rdx,[rbp-18h] 
 call getCharCount

 std 
 mov eax,dword ptr [rbp-18h]
 dec eax 
 mov rdi,[rbp-10h] 
 lea rdi,[rdi+rax] 

 mov bl,30h
 movzx rbx,bl

 mov rax,[rbp-8]
 mov rax,[rax]
 mov cl,0Ah 
 movzx rcx,cl
 bhere2:
 xor rdx,rdx 
 div rcx
 or rdx,rbx 

 xchg rax,rdx 
 stosb
 xchg rdx,rax 

 test rax,rax
 jne bhere2
 cld 

 add rsp, 18h
 mov rsp,rbp
 pop rbp
 ret
 tostringMain endp

getCharCount proc ;//getCharCount(number=rcx, int counter=rdx)
 push rbx
 mov rax,rcx
 mov cl,0Ah
 movzx rcx,cl
 mov rbx,rdx
 mov dword ptr [rbx],01
 bhere:
 xor rdx,rdx
 div rcx
 inc dword ptr [rbx]
 test rax,rax
 jne bhere
 dec dword ptr [rbx]
 mov eax,dword ptr [rbx]
 pop rbx
 ret
 getCharCount endp

 clearDestination proc ;//clearDestination(*destination=rcx,size = edx (optional))
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
end