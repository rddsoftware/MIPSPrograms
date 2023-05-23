.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tEnter chars into an array to be encrypted\n\t\t\tand then decrypted.\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t10/21/2021\n"
prompt:	.asciiz		"Please enter a 9 character message to be sent:\n"
encryp:	.asciiz		"Your encrypted message is:\n"
decryp:	.asciiz		"Your decrypted message is:\n"
nline:	.asciiz		"\n"
input:	.byte			'-','-','-','-','-','-','-','-','-','-'
en:		.byte			'-','-','-','-','-','-','-','-','-','-'
de:		.byte			'-','-','-','-','-','-','-','-','-','-'

.text

main:

#=======Header=========================================================================================================
	li	$v0, 4
	la	$a0, border					#print border
	syscall
	
	li	$v0, 4
	la	$a0, descri					#print program description
	syscall
	
	li	$v0, 4
	la	$a0, auth					#print author information
	syscall
	
	li	$v0, 4
	la	$a0, date					#print date created
	syscall
	
	li	$v0, 4
	la	$a0, border					#print border
	syscall
	
#=======code===========================================================================================================
	la	$s0, input
	la	$s1, en
	li	$t0, 11
	li	$t2, 10
	
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 8
	la	$a0, input
	li	$a1, 10
	syscall
	
	loop1:
		beq	$t0, $0, done
		
		lb	$t1, 0($s0)
		xor	$t3, $t2, $t1
		sb	$t3, 0($s1)
		
		li	$t1, 0
		
		addi	$s0, $s0, 1
		addi	$s1, $s1, 1
		addi	$t0, $t0, -1
		
		j	loop1
		
	done:
		la	$s3, de
		la	$s2, en
		li	$t0, 11
		
	loop2:
		beq	$t0, $0, fin
		lb	$t1, 0($s2)
		xor	$t3, $t2, $t1
		sb	$t3, 0($s3)
		
		addi	$s2, $s2, 1
		addi	$s3, $s3, 1
		addi	$t0, $t0, -1
		
		j	loop2
	
	fin:
		li	$v0, 4
		la	$a0, nline
		syscall
		
		li	$v0, 4
		la	$a0, encryp
		syscall
	
		la	$a0, en
		li	$v0, 4
		syscall
	
		li	$v0, 4
		la	$a0, nline
		syscall
	
		li	$v0, 4
		la	$a0, decryp
		syscall
	
		la	$a0, de
		li	$v0, 4
		syscall
	
		li	$v0, 10
		syscall