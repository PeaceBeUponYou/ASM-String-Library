.code
substrMain proc ;//substrMain(*string=rcx, start=rdx, stop=r8,*result=r9)
 enter 8,0
 ;[rbp-8] == charcount
 mov r12,rcx
 push rdx ;//start [rbp-10h]
 push r8 ;//stop    [rbp-18h]
 push rcx ;//*string [rbp-20h]

 lea rdx,[rbp-8];[charcount]
 xor r8,r8
 mov [rdx],r8
 call stringLength ;//;getString's total length

 pop rcx
 pop r8
 pop rdx

 push r8 ;//stopIndex
 push rdx ;//startIndex
 mov eax,[rbp-8];[charcount] ;//totalCharCount
 push rax
 call isfeasible
 mov [r9],eax
 test eax,eax
 jz cantdosub
 push rsi
 push rdi
 test rcx,rcx
 jz ssm1 ;//if start index was 0
 dec rcx
 ssm1:
 lea rsi,[r12] ;//*string
 add rsi,rcx ;//start index
 lea rdi,[r9]  ;//*result
 cmp edx,dword ptr [rbp-8] ;end index with max string length
 cmovg edx,dword ptr [rbp-8]
 xchg rcx,rdx ;//endindex
 sub rcx,rdx
 rep movsb
 xor rax,rax
 stosb 
 pop rdi
 pop rsi
cantdosub:
 leave
 ret
substrMain endp

isfeasible proc ;//isfeasible(charCount,startIndex,stopIndex) //all in stack
  enter 0,0
   cvtsi2ss xmm0,dword ptr [rbp+10h] ;//;total string size
   cvtsi2ss xmm1,dword ptr [rbp+18h] ;//;start index container
   cvtsi2ss xmm2,dword ptr [rbp+20h] ;//;end index container
   shufps xmm0,xmm0,0 ;//;populating first index over all register
   shufps xmm1,xmm1,0 ;//;populating first index over all register
   shufps xmm2,xmm2,0 ;//;populating first index over all register
   vaddsubps xmm1,xmm0,xmm1 ;//;sub,add,sub,add and store in destination
   vaddsubps xmm2,xmm0,xmm2 ;//;sub,add,sub,add and store in destination
   shufps xmm0,xmm1, 10h ;//; moving second single of xmm1->xmm0
   shufps xmm0,xmm0, 0AAh
   ;shufps xmm0,xmm0,0
   comiss xmm0,xmm1 ;//if same ie start index=0
   jz part1final
   cmpss xmm0,xmm1,6 ;//;if xmm1(subtracted) > xmm0(added)
   movmskps eax, xmm0
   test eax,1
   jnz part1final ;//if start point is +ve
   shufps xmm0,xmm0,1
   movss xmm1,xmm0 ;//;added was the value
   push 3f800000h ;(float)1
   addss xmm1,dword ptr [rsp]
   add rsp,8
   jmp part2
part1final:
   cvtsi2ss xmm1, dword ptr  [rbp+18h] ;//;otherwise this is the value
part2:
   shufps xmm0,xmm2, 10h ;//; moving second single of xmm2->xmm0
   shufps xmm0,xmm0,0AAh
   ;shufps xmm0,xmm0,0
   comiss xmm0,xmm2 ;//if same ie end index=0
   jz part2final
   cmpss xmm0,xmm2,6 ;//;if xmm1(subtracted) > xmm0(added)
   movmskps eax, xmm0
   test eax,1
   jnz part2final    ;//if end point is +ve
   shufps xmm0,xmm0,1
   movss xmm2,xmm0 ;//;added was the value
   push 3f800000h ;(float)1
   addss xmm2,dword ptr [rsp]
   add rsp,8
   jmp endingphase
part2final:
   cvtsi2ss xmm2,dword ptr [rbp+20h] ;//;otherwise this is the value
endingphase:
   xorps xmm0,xmm0
   comiss xmm2,xmm0 ;//;if ending part == 0
   jz cannotDoit
   comiss xmm2,xmm1 ;//;end > start
   jb cannotDoit
   cvtsi2ss xmm0,dword ptr [rbp+10h]
   comiss xmm1,xmm0 ;//;start > maxStringLength
   ja cannotDoit
   mov al,01
   movzx rax,al ;//;bool feasible = true;
   cvtss2si rcx, xmm1 ;//;start index
   cvtss2si rdx, xmm2 ;//;end index
   test ecx,ecx
   jns procend
   xor rcx,rcx
   cmp rcx,rdx
   jl procend 
cannotDoit:
   xor eax,eax ;//;bool feasible = false;
   xor rcx,rcx
   xor rdx,rdx
procend:
  leave
  ret 18h
 isfeasible endp
stringLength proc ;stringLength(*string=rcx, *counter=rdx, type=r8d)
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
