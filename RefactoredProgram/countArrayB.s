	.file	"countArrayB.c"
	.intel_syntax noprefix
	.text
	.globl	countArrayB
	.type	countArrayB, @function
countArrayB:
	endbr64
	push	rbp
	mov	rbp, rsp		
	mov	r13d, edi			# r13d = length
	mov	rbx, 0				# rbx = j	
	jmp	.L2
.L3:						# cycle
	lea	rdx, 0[0+rbx*4]			#rdx = movement
	lea	rax, A[rip]			# rax = A
	mov	eax, DWORD PTR [rdx+rax]	# eax = A[j]
	pxor	xmm1, xmm1			#xmm1 = 0
	cvtsi2sd	xmm1, eax		# xmm1 = eax = A[j]
	movsd	xmm0, QWORD PTR .LC0[rip]	# xmm0 = 9.82 from stack
	mulsd	xmm1, xmm0			# xmm1 = xmm1*9.82
	cvtsi2sd	xmm0, eax		# xmm0 = eax = A[j]
	mulsd	xmm1, xmm0			# xmm1 = 9.82 *A[j] * A[j]
	movsd	xmm0, QWORD PTR .LC1[rip]	# xmm0 = 2 from stack
	divsd	xmm1, xmm0			# xmm1 = xmm1/2
	lea	rdx, 0[0+rbx*8]
	lea	rax, B[rip]
	movsd	QWORD PTR [rdx+rax], xmm1	# B[j] = xmm1
	add	ebx, 1				# ++j
.L2:
	cmp	ebx, r13d			# compare j and length
	jl	.L3
	nop
	nop
	pop	rbp
	ret
	.size	countArrayB, .-countArrayB
	.section	.rodata
	.align 8
.LC0:
	.long	171798692
	.long	1076077527
	.align 8
.LC1:
	.long	0
	.long	1073741824
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
