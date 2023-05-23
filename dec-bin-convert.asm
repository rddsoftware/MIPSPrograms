.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tAsk user for input and use functions to convert\n\t\t\ta decimal number to binary.\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t09/29/2021\n"
prompt:	.asciiz		"Input a number in decimal form:\t"
thenum:	.asciiz		"The number "
inbin:	.asciiz		" in binary form:\t"
errneg:	.asciiz		"==> ERROR: We are working with the unsigned system of integers.\nYou'll now be redirected to enter another integer.\n\n"

.text
	li	$v0, 4
	la	$a0, border
	syscall
	
	li	$v0, 4
	la	$a0, descri
	syscall
	
	li	$v0, 4
	la	$a0, auth
	syscall
	
	li	$v0, 4
	la	$a0, date
	syscall
	
	li	$v0, 4
	la	$a0, border
	syscall
	
#=======code========================================================================================================
userinput:
	li	$v0, 4
	la	$a0, prompt				#prompt user for input
	syscall
	
	li	$v0, 5				#get user input
	syscall
	
	add	$a1, $v0, $0			#add input to $a1 for use in BaseChange
	
	blt	$a1, $0, errlt0			#error call if less than 0
	
	li	$v0, 4
	la	$a0, border				#display border
	syscall
	
	add	$s2, $s2, $0			#set 
	addi	$s3, $s3, 31			#set 32 bit size for display
	add	$s4, $sp, $0			#pointer to the bottom of the stack.
	
	jal	BaseChange				#jump and link to BaseChange
	
#=======end=========================================================================================================
	li	$v0, 10				#exit program
	syscall

#=======Functions===================================================================================================
	
errlt0:
	li	$v0, 4
	la	$a0, errneg				#display error message for less than 0
	syscall
	
	j	userinput				#jump back to userinput
	
BaseChange:
	addi	$s0, $s0, 2				#set $s0 equal to 2
	
loop:
	beq	$a1, $0, done			#if $a1 equals zero, go to done.
	
	div	$a1, $s0				#divide $a1 by $s0 (2)
	
	mfhi	$s1					#move remainder to $s1
	mflo	$a1					#move quotient to $a1 for updating purposes
	
	addi	$sp, $sp, -4			#push back stack
	sw	$s1, 0($sp)				#store $s1 to the stack
	
	j	loop					#jump back to loop
	
done:	
	add	$sp, $s4, $0			#point back to the bottom of the stack
	
addto32:						#makes sure the output will be in 32 bits
	bgt	$s2, $s3, display			#if $s2 is greater than $s3
	
	addi	$s2, $s2, 1				#add to the loop counter
	addi	$sp, $sp, -4			#move the stack address pointer up
	
	j	addto32				#jump back to addto32
	
display:
	beq	$s2, $0, return			#check if $s3 = $0, if so, go to exit
	
	lw	$s1, 0($sp)				#load word from current arr index
	li	$v0, 1
	add	$a0, $s1, $0			#add $t0 to $a0 for display
	syscall
	
	addi	$s2, $s2, -1			#decrement $s3 for looping condition update
	addi	$sp, $sp, 4				#decrement the arr index by 4 bytes
	
	j	display				#jump back to display

return:
	jr	$ra					#return to address
