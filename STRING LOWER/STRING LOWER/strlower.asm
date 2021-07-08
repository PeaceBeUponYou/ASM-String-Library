
.code
lowermainFun proc ;uppermain(*sourceString,*destinationString, sizeOfDestination)
 push rsi
 push rdi
 push rax

 push rdx
 push rcx
 lea rcx,[rdx] ;destination string clear
 mov edx,r8d
 call clearDestination
 pop rcx
 pop rdx

 xor rax,rax
 lea rsi,[rcx]  ;sourceString
 lea rdi,[rdx] ;destinationString
 here:
 lodsb
 cmp al, 41h
 jl forv
 cmp al, 5Ah
 jg forv
 add al, 20h
 jmp forv
forv:
 stosb
 cmp byte ptr [rsi],00
 jne here
 pop rax
 pop rdi
 pop rsi
 ret
lowermainFun endp

clearDestination proc ;//clearDestination(*destination=rcx,size = edx (optional))
 push rax
 xor rax,rax
 lea rdi,[rcx]
 test edx,edx ;//if size is==0
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
clearDestination endp ;//clearDestination(*destination=rcxl,size = edx (optional))

end
