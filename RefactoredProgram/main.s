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
	mov	eax, DWORD PTR -4[rbp]			# eax = i
	lea	rdx, 0[0+rax*4]				# movement for A array
	lea	rax, A[rip]				# rax = A
	add	rdx, rax				# rdx = A + i*4
	mov	rdi, QWORD PTR -16[rbp]			# rdi = input
	lea	rsi, .LC1[rip]				# rcx = "%d"
	mov	eax, 0
	call	__isoc99_fscanf@PLT			# get A[i] from file
	add	DWORD PTR -4[rbp], 1			# ++i
.L14:
	mov	eax, DWORD PTR -52[rbp]			# eax = length
	cmp	DWORD PTR -4[rbp], eax			# compare i and length
	jl	.L15					# i<length
	jmp	.L9					# else
.L10:							# random input
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8					# rdi = &argv[1]
	mov	rdi, QWORD PTR [rax]			# rdi = argv[1]
	call	atoi@PLT
	cmp	eax, 2					# compare atoi(argv[1]] and 2)
	jne	.L9
	mov	edi, 0					# edi = 0
	call	time@PLT				# time(NULL)
	mov	edi, eax				# rdi = seed for rand()
	call	srand@PLT				
	call	rand@PLT
	mov	DWORD PTR -52[rbp], eax			# length = random number that rand give to us
	mov	ecx, DWORD PTR -52[rbp]			# rcx = length
	imul	rax, rax, 1717986919
	shr	rax, 32
	sar	eax, 2
	mov	esi, ecx
	sar	esi, 31
	sub	eax, esi
	mov	edx, eax				# making lenght = lenght%10 +1
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	sub	ecx, eax
	mov	edx, ecx
	lea	eax, 1[rdx]
	mov	DWORD PTR -52[rbp], eax			# lenght now [1,10]
	mov	DWORD PTR -4[rbp], 0			# i = 0
	jmp	.L16					# start circle
.L17:
	call	rand@PLT				# rax = rand()
	mov	edx, DWORD PTR -4[rbp]			# rdx = i			
	lea	rcx, 0[0+rdx*4]				# movement
	lea	rdx, A[rip]				# rdx = A
	mov	DWORD PTR [rcx+rdx], eax		# A[i] = random data from eax
	add	DWORD PTR -4[rbp], 1			#++i
.L16:
	mov	eax, DWORD PTR -52[rbp]			# eax = length 
	cmp	DWORD PTR -4[rbp], eax			# compare i and length
	jl	.L17
.L9:
	call	clock@PLT				# start time
	mov	QWORD PTR -24[rbp], rax			# start = rax 
	mov	DWORD PTR -4[rbp], 0			# i = 0
	mov 	r14d, DWORD PTR -52[rbp]	        # r14d = length
	mov 	r15d, DWORD PTR -4[rbp]			# r15d = i
	jmp	.L18
.L19:
	mov	eax, r14d				# rax = lenght
	mov	edi, eax
	call	countArrayB@PLT
	add	r15d, 1	
.L18:
	cmp	r15d, 199999999				# compare i and length of circle
	jle	.L19		
	call	clock@PLT				# end of time
	mov	QWORD PTR -32[rbp], rax			# end = rax
	sub	rax, QWORD PTR -24[rbp]			# begin of calculation time_spent
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movsd	xmm1, QWORD PTR .LC6[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -40[rbp], xmm0		# end of calcualtion time_spent
	cmp	DWORD PTR -68[rbp], 1			# argc vs 1 
	jle	.L20					# if argc<=1 go cout to console
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]			# check second condition 
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	jne	.L20					# if argv[1] != 1 then go to output to console
	lea	rsi, .LC7[rip]				# rsi = "w"
	lea	rdi, .LC8[rip]				# rdi = "output.txt"
	call	fopen@PLT
	mov	QWORD PTR -48[rbp], rax			# ouput = rax
	movq	xmm0, QWORD PTR -40[rbp]		# xmm0 = time_spent				
	lea	rsi, .LC9[rip]			 	# rsi = & .time_spent
	mov	rdi, rax
	mov	eax, 1					# eax = 1 show that there's double
	call	fprintf@PLT
	mov	DWORD PTR -4[rbp], 0			# i = 0
	jmp	.L21
.L22:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, B[rip]
	movq	xmm0, QWORD PTR [rdx+rax]
	mov	rax, QWORD PTR -48[rbp]
	lea	rdx, .LC10[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	add	DWORD PTR -4[rbp], 1
.L21:
	mov	eax, DWORD PTR -52[rbp]			# upper just circle of ouput to output.txt
	cmp	DWORD PTR -4[rbp], eax
	jl	.L22
	mov	eax, 0
	jmp	.L25
.L20:							# output to console
	movq	xmm0, QWORD PTR -40[rbp]
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT				# just output info about time_spent
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
	cmp	DWORD PTR -4[rbp], eax			# just output to console array B
	jl	.L24
	mov	eax, 0
.L25:
	leave						# end of program
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
