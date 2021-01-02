.data
posNum dd 0
endPtr dq 0
shift db 0

.code
radixSortBuckets proc
; Subrutine Prologue
	push rbp ; Push base pointer to stack
	mov rbp, rsp ; Make stack pointer new base pointer
	shl rcx, 2 ; multiply radix argument by 4 to get a number of bytes it represents
	shl rdx, 2 ; multiply number of numbers by 4 to get number of bytes in array
	push rbx ; Clear callee saved registers
	push r12 ;
	push r13 ; 
	sub rsp, rcx; Allocate Local memeory to the stack, equal to the size of the radix

	

; Subrutine Body

sortPass: ; start a sorting pass
	mov r10, rsp;
	mov r12, 0; clear register storing number of positions cleared
clearMem: ; clear area for counters in stack
	mov DWORD PTR [r10], 0; put 0 in position to clear
	add r10, 4; jump to next clearing position
	inc r12; increment number of positions cleared
	cmp r12, 256; check if all positions cleared
	jb clearMem; jump to clearMem if postions cleard is below radix

countStep:
	mov r10d, posNum ; position to start counting from
	add r10, r8 ; add position of start of array
	mov r11d, DWORD PTR [r10] ; put value at address in r10 into r11 dword
	mov r12, rcx ; move radix to r12
	mov cl, shift
	shr r11, cl
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

PrefixSumPass:
	mov r10, rcx
	add r10, rsp
	mov endPtr, r10
	mov r10, rsp
	mov r11, 0

PrefixSumStep:
	mov r12d, DWORD PTR [r10]
	add r11, r12
	mov DWORD PTR [r10], r11d
	add r10, 4
	mov r12, endPtr
	cmp r10, r12
	jb PrefixSumStep

SortRun:
	mov r10, rdx
	add r10, r8

SortStep:
	sub r10, 4
	mov r11d, DWORD PTR [r10]
	mov cl, shift
	shr r11, cl
	and r11, 255
	shl r11, 2
	mov r12, rsp
	add r12, r11
	mov r11d, DWORD PTR [r12]
	dec r11
	mov DWORD PTR [r12], r11d
	shl r11, 2
	add r11, r9
	mov r12d, DWORD PTR [r10]
	mov DWORD PTR [r11], r12d
	cmp r10, r8
	ja SortStep

PassEpilouge:
	mov r10b, shift
	add r10, 8
	mov shift, r10b
	cmp r10b, 32
	jb IfLoopingRunSetup
	jmp SubEnd

IfLoopingRunSetup:
	mov posNum, 0;
	mov endPtr, 0;
	mov r10, r8;
	mov r8, r9;
	mov r9, r10;
	jmp sortPass

SubEnd: ; Subrutine Epilogue
	add rsp, rcx;
	pop r13
	pop r12
	pop rbx
	mov rsp, rbp
	pop rbp
	ret
radixSortBuckets endp
end