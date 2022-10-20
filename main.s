	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	A
	.bss
	.align 32
	.type	A, @object
	.size	A, 40
A:
	.zero	40
	.globl	B
	.align 32
	.type	B, @object
	.size	B, 80
B:
	.zero	80
	.section	.rodata
	.align 8
.LC0:
	.string	"Input length of array A (0 < length <= %d): \n "
.LC1:
	.string	"%d"
.LC2:
	.string	"Incorrect length = %d\n"
.LC3:
	.string	"enter %d : \n"
.LC4:
	.string	"r"
.LC5:
	.string	"input.txt"
.LC7:
	.string	"w"
.LC8:
	.string	"output.txt"
.LC9:
	.string	"time spent: %f sec\n"
.LC10:
	.string	"%f \n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi			# argc
	mov	QWORD PTR -80[rbp], rsi			# argv[0]
	cmp	DWORD PTR -68[rbp], 1
	jle	.L6
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rdi, QWORD PTR [rax]
	call	atoi@PLT
	test	eax, eax
	jne	.L3
.L6:							# input from console
	mov	esi, 10
	lea	rdi, .LC0[rip]				# save reference to line .LC0 in the rax
	mov	eax, 0
	call	printf@PLT				# print information about inpute 
	lea	rsi, -52[rbp]				# put length in rsi
	lea	rdi, .LC1[rip]				# put .LC1 in rdi
	mov	eax, 0					# make eax = 0
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR -52[rbp]			# eax = length
	test	eax, eax				# check eax = 0 or not
	jle	.L4					# if length <= 0 then go to inside if area
	mov	eax, DWORD PTR -52[rbp]			# eax = length
	cmp	eax, 10					# if eax<=10 not go to if area
	jle	.L5
.L4:
	mov	esi, DWORD PTR -52[rbp]			# esi = length						
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT				# print about incorrect length
.L5:
	mov	eax, DWORD PTR -52[rbp]			# eax = length
	test	eax, eax
	jle	.L6					# if length <= 0  go while again
	mov	eax, DWORD PTR -52[rbp]			# eax = length 
	cmp	eax, 10					
	jg	.L6					# if length >10 go while again
	mov	DWORD PTR -4[rbp], 0			# put i = 0
	jmp	.L7
.L8:
	mov	esi, DWORD PTR -4[rbp]			# esi = i
	lea	rdi, .LC3[rip]				# rdi = &"input i :"			
	mov	eax, 0
	call	printf@PLT				# print "input i  :"
	mov	eax, DWORD PTR -4[rbp]			# eax = i
	lea	rdx, 0[0+rax*4]				# get movement for A
	lea	rsi, A[rip]				# rsi = A
	add	rsi, rdx				# rsi = A + i*4
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT			# scan A[i]
	add	DWORD PTR -4[rbp], 1			# ++i
.L7:
	mov	eax, DWORD PTR -52[rbp]			# eax = length 
	cmp	DWORD PTR -4[rbp], eax			# compare lenght and i
	jl	.L8					# if i<length then go to circle
	jmp	.L9					# if i>=lenght don't go to circle
.L3:							# input from input.txt
	mov	rax, QWORD PTR -80[rbp]			
	add	rax, 8					# rax = &argv[1]
	mov	rdi, QWORD PTR [rax]			# rax = argv[1]
	call	atoi@PLT
	cmp	eax, 1					# if rax != 1 then we go to input random to .L10
	jne	.L10
	lea	rsi, .LC4[rip]				# start input from file
	lea	rdi, .LC5[rip]
	call	fopen@PLT				# open file
	mov	QWORD PTR -16[rbp], rax			# input = rax
	lea	rdx, -52[rbp]				# rdx = length
	lea	rsi, .LC1[rip]				# rsi = .LC1 ("%d")
	mov	rdi, rax				# rdi = input
	mov	eax, 0					# make eax = 0 before the function
	call	__isoc99_fscanf@PLT			# get length to -52[rbp]
	mov	eax, DWORD PTR -52[rbp]			# eax = length
	test	eax, eax				# check value in length
	jle	.L11					# if length <=0
	mov	eax, DWORD PTR -52[rbp]			# eax = length
	cmp	eax, 10					# compare eax and 10
	jle	.L12					# if 1<=eax<=10 then go to .L12
.L11:							# so length incorrect and we return 1 
	mov	esi, DWORD PTR -52[rbp]			# esi = length
	lea	rdi, .LC2[rip]				# rdi = &"incorrect length..."
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L25					# return from programm
.L12:
	mov	DWORD PTR -4[rbp], 0			# i = 0
	jmp	.L14					# start circle
.L15:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]
	add	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add	DWORD PTR -4[rbp], 1
.L14:
	mov	eax, DWORD PTR -52[rbp]			# eax = length
	cmp	DWORD PTR -4[rbp], eax
	jl	.L15
	jmp	.L9
.L10:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 2
	jne	.L9
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	mov	DWORD PTR -52[rbp], eax
	mov	ecx, DWORD PTR -52[rbp]
	movsx	rax, ecx
	imul	rax, rax, 1717986919
	shr	rax, 32
	sar	eax, 2
	mov	esi, ecx
	sar	esi, 31
	sub	eax, esi
	mov	edx, eax
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	sub	ecx, eax
	mov	edx, ecx
	lea	eax, 1[rdx]
	mov	DWORD PTR -52[rbp], eax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L16
.L17:
	call	rand@PLT
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, A[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -4[rbp], 1
.L16:
	mov	eax, DWORD PTR -52[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L17
.L9:
	call	clock@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L18
.L19:
	mov	eax, DWORD PTR -52[rbp]
	mov	edi, eax
	call	countArrayB@PLT
	add	DWORD PTR -4[rbp], 1
.L18:
	cmp	DWORD PTR -4[rbp], 199999999
	jle	.L19
	call	clock@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	sub	rax, QWORD PTR -24[rbp]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movsd	xmm1, QWORD PTR .LC6[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -40[rbp], xmm0
	cmp	DWORD PTR -68[rbp], 1
	jle	.L20
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	jne	.L20
	lea	rax, .LC7[rip]
	mov	rsi, rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -48[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC9[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	DWORD PTR -4[rbp], 0
	jmp	.L21
.L22:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, B[rip]
	mov	rdx, QWORD PTR [rdx+rax]
	mov	rax, QWORD PTR -48[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC10[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	add	DWORD PTR -4[rbp], 1
.L21:
	mov	eax, DWORD PTR -52[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L22
	mov	eax, 0
	jmp	.L25
.L20:
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	DWORD PTR -4[rbp], 0
	jmp	.L23
.L24:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, B[rip]
	mov	rax, QWORD PTR [rdx+rax]
	movq	xmm0, rax
	lea	rax, .LC10[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L23:
	mov	eax, DWORD PTR -52[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L24
	mov	eax, 0
.L25:
	leave
	ret
	.size	main, .-main 				# programm part that's not interesting for us and i
	.section	.rodata				# i tried to delete but it create problems
	.align 8
.LC6:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
