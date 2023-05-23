.data															#start of the data

border:	.asciiz		"================================================================================\n"
desc:		.asciiz		"Program Description:\tThis program is written to mimic a very basic calculator\n"
author:	.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t09/05/21\n"
ask:		.asciiz		"Please input two numbers:\n\n"
sumis:	.asciiz		"Sum is:\t\t"
subis:	.asciiz		"\nDifference is:\t"
prois:	.asciiz		"\nProduct is:\t"
quois:	.asciiz		"\nQuotient is:\t"
remis:	.asciiz		"\nRemainder is:\t"

.text															#start of the code

main:

	li	$v0, 4
	la	$a0, border
	syscall
	
	li	$v0, 4
	la	$a0, desc
	syscall
	
	li	$v0, 4
	la	$a0, author
	syscall
	
	li	$v0, 4
	la	$a0, date
	syscall
	
	li	$v0, 4
	la	$a0, border			#border before asking for input
	syscall
	
	li	$v0, 4
	la	$a0, ask			#ask for two operands
	syscall
	
	li	$v0, 5			#user input
	syscall
	
	add	$s0, $v0, $0		#first operand
	
	li	$v0, 5			#user input
	syscall
	
	add	$s1, $v0, $0		#second operand
	
#=======addition=================================================================
	
	add	$t0, $s0, $s1		#perform addition and store in $t0
	
	li	$v0, 4
	la	$a0, sumis			#display sum is string
	syscall
	
	li	$v0, 1
	add 	$a0, $t0, $0		#display calculated sum
	syscall
	
#=======subtraction==============================================================
	
	sub	$t0, $s0, $s1		#perform subtraction and store in $t0
	
	li	$v0, 4
	la	$a0, subis			#display difference is string
	syscall
	
	li	$v0, 1
	add	$a0, $t0, $0		#display difference
	syscall
	
#=======multipication============================================================

	mult	$s0, $s1			#perform multiplication
	
	li	$v0, 4
	la	$a0, prois			#display product is string
	syscall
	
	mflo	$t0				#move product from the lo register to $t0
	
	li	$v0, 1
	add	$a0, $t0, $0		#move product from $t0 to $a0
	syscall

#=======quotient=================================================================

	div	$s0, $s1			#perform division
	
	li	$v0, 4
	la	$a0, quois			#display quotient is string
	syscall
	
	mflo	$t0
	li	$v0, 1
	add	$a0, $t0, $0
	syscall
	
	li	$v0, 4
	la	$a0, remis
	syscall
	
	mfhi	$t0
	li	$v0, 1
	add	$a0, $t0, $0
	syscall

#=======end======================================================================
	li	$v0, 10
	syscall