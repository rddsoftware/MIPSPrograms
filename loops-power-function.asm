.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tAsk user for input and use conditional loops\n\t\t\tto perform a power function calculation.\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t09/20/2021\n"
prompx:	.asciiz		"Please enter an integer between 1 and 12 for x: \n"
prompy:	.asciiz		"Please enter an integer between 1 and 12 for y: \n"
errhi:	.asciiz		"==> ERROR: Your input is too high.\n"
errlo:	.asciiz		"==> ERROR: Your input is too low.\n"
ttpow:	.asciiz		" to the power of "
is:		.asciiz		" is "
period:	.asciiz		"."

#=======begin program====================================================================================
.text

	li	$v0, 4
	la	$a0, border				#output border
	syscall
	
	li	$v0, 4
	la	$a0, descri				#output program description
	syscall
	
	li	$v0, 4
	la	$a0, auth				#output author info
	syscall
	
	li	$v0, 4
	la	$a0, date				#output creation date info
	syscall
	
	li	$v0, 4
	la	$a0, border				#output border
	syscall
	
#=======begin prompt and loop==================================================================================

	add	$s5, $s5, 1				#low-end error buffer
	add	$s6, $s6, 12			#high-end error buffer
	add	$t0, $t0, 1				#first number to be multiplied by x
	add	$s2, $s2, $0
	
#==============================================================================================================

readx:
	li	$v0, 4
	la	$a0, prompx				#prompt user for x input
	syscall
	
	li	$v0, 5				#user input for x
	syscall
	
	add	$s0, $v0, $0			#add user's input for x with zero and store it in $s0
	
	blt	$s0, $s5, errorlowx		#if x in negative, go to error condition
	bgt	$s0, $s6, errorhighx		#if x is greater than 12, go to error condition
	
#==============================================================================================================
	
ready:	
	li	$v0, 4
	la	$a0, prompy				#prompt user for y input
	syscall
	
	li	$v0, 5				#user input for y
	syscall
	
	add	$s1, $v0, $0			#store y in $s1
	
	blt	$s1, $s5, errorlowy		#if y in negative, go to error condition
	bgt	$s1, $s6, errorhighy		#if y is greater than 12, go to error condition
	
#==============================================================================================================
	
powerfunction:
	beq	$s2, $s1, exit			#if the loop counter equals $s1, go to exit condition
	
	mult	$t0, $s0				#multiply $t0 and $s0
	
	mflo	$t0					#move the value from the lo register into $t0
	
	addi	$s2, $s2, 1				#increment $s2 by 1
	
	j	powerfunction			#jump back to the beginning of powerfunction

#=======error handling=========================================================================================

errorlowx:	
	li	$v0, 4
	la	$a0, errlo				#call negative number error
	syscall
	
	j	readx					#jump back to readx
	
errorhighx:
	li	$v0, 4
	la	$a0, errhi				#call number too high error
	syscall
	
	j	readx					#jump back to readx
	
errorlowy:
	li	$v0, 4
	la	$a0, errlo				#call negative number error
	syscall
	
	j	ready					#jump back to ready
	
errorhighy:
	li	$v0, 4
	la	$a0, errhi				#call number too high error
	syscall
	
	j	ready					#jump back to ready

exit:
	li	$v0, 1
	add	$a0, $s0, $0			#display the value for x
	syscall
	
	li	$v0, 4
	la	$a0, ttpow				#display " to the power of "
	syscall
	
	li	$v0, 1
	add	$a0, $s1, $0			#display the value for y
	syscall
	
	li	$v0, 4
	la	$a0, is				#display " is "
	syscall
	
	li	$v0, 1
	add	$a0, $t0, $0			#display result
	syscall
	
	li	$v0, 4
	la	$a0, period				#display "."
	syscall
	
	li	$v0, 10				#exit program
	syscall