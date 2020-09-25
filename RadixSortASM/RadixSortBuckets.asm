.data
passNum db 0
posNum dd 0

.code
radixSortBuckets proc
; Subrutine Prologue
	push rbp ; Push base pointer to stack
	mov rbp, rsp ; Make stack pointer new base pointer
	shl rcx, 2; multiply radix argument by 4 to get a number of bytes it represents
	shl rdx, 2; multiply number of numbers by 4 to get number of bytes in array
	push rbx ; Clear callee saved registers
	push r12;
	sub rsp, rcx; Allocate Local memeory to the stack, equal to the size of the radix
	mov r10, rsp;
	

; Subrutine Body
	mov r12, 0
clearMem:
	mov DWORD PTR [r10], 0
	add r10, 4
	inc r12
	cmp r12, 256
	jb clearMem

sortPass:

countStep:
	mov r10d, posNum
	add r10, r8
	mov r11d, DWORD PTR [r10]
	and r11, 255
	shl r11, 2;
	mov r10, rsp;
	add r10, r11;
	mov r11d, DWORD PTR [r10]
	inc r11
	mov DWORD PTR [r10], r11d
	mov r10d, posNum
	add r10d, 4
	mov posNum, r10d
	cmp r10, rdx
	jb CountStep

; Subrutine Epilogue
	pop r12
	pop rbx
	mov rsp, rbp
	pop rbp
	ret
radixSortBuckets endp
end