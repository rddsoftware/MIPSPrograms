.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tAsk user for input and use conditional loops\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t09/15/2021\n"
prompt:	.asciiz		"How many positive integers that are divisible by 6 do you want to add? "
entnum:	.asciiz		"Enter a number: "
suxes:	.asciiz		"==> "
sixyes:	.asciiz		" is dividisble by 6.\n"
error:	.asciiz		"==> **** ERROR: "
errbnd:	.asciiz		" is not in the range of 1 to 100. Enter another number.\n"
errsix:	.asciiz		" is not divisible by 6. Enter another number.\n"
sumstr:	.asciiz		"The sum of the positive integers between 1 and 100 that are divisible by 6 is: "

#=======start program===================================================================================

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
	
#=======begin prompt and main loop======================================================================

	li	$v0, 4
	la	$a0, prompt				#prompt user for input
	syscall
	
	li	$v0, 5				#grab user input
	syscall
	
	add	$s0, $v0, $0			#store user's preference in $s0
	
	add	$s1, $0, $0				#initialize the incrementing variable to $s1
	
	add	$s3, $s3, 100			#initialize upper bound to 100
	
	add	$s6, $s6, 6				#initialize divisor to 6
	
begin:	beq	$s1, $s0, end		#begin main loop

		li	$v0, 4
		la	$a0, entnum			#prompt user to enter a number
		syscall

		li	$v0, 5			#grab user input
		syscall
		
		add	$s4, $v0, $0		#store user input in $s4
		
		ble	$s4, $0, errpos		#check if user's input ($s4) is less than or equal to zero ($0)
				
		bgt	$s4, $s3, errgt		#check if user's input ($s4) is greater than or queal to 100 ($s3)
		
		div	$s4, $s6			#divide user's input ($s4) by 6 ($s6)
		
		mfhi	$t0				#move the remainder to $t0
		
		bne	$t0, $0, errdiv		#check if remainder ($to) is not equal to zero ($0)
		
		li	$v0, 4
		la	$a0, suxes			#output arrow
		syscall
		
		li	$v0, 1
		add	$a0, $s4, $0		#add user's input ($s4) to $a0 and output
		syscall
		
		li	$v0, 4
		la	$a0, sixyes			#success message
		syscall
		
		addi	$s1, $s1, 1			#increment $s1 by 1
		
		add	$s5, $s5, $s4		#add the user's input ($s4) to the sum ($s5)
		
		j	begin
		
#=======error handling=======================================================================================================

errpos:						#less than error
	li	$v0, 4
	la	$a0, error				#error message with arrow
	syscall
	
	li	$v0, 1
	add 	$a0, $s4, $0			#store user's input ($s4) to $a0 and outputs the number
	syscall
	
	li	$v0, 4
	la	$a0, errbnd				#error message for out of bounds
	syscall
	
	j	begin					#jump back to begin
	
errgt:						#greater than error
	li	$v0, 4
	la	$a0, error				#error message with arrow
	syscall
	
	li	$v0, 1
	add	$a0, $s4, $0			#store user's input ($s4) to $a0 and outputs the number
	syscall
	
	li	$v0, 4
	la	$a0, errbnd				#error message for out of bounds
	syscall
	
	j	begin					#jump back to begin
	
errdiv:	
	li	$v0, 4
	la	$a0, error				#error message with arrow
	syscall
	
	li	$v0, 1
	add	$a0, $t0, $0			#store user's input ($s4) to $a0 and outputs the number
	syscall
	
	li	$v0, 4
	la	$a0, errsix				#error message for not divisible by 6
	syscall
	
	j	begin					#jump back to begin
		
#=======end of program========================================================================================================
end:
	li	$v0, 4
	la	$a0, sumstr				#output message for the sum of the numbers that passed the tests
	syscall
	
	li	$v0, 1
	add	$a0, $s5, $0			#store the summation ($s5) to $a0 and output the number
	syscall
	
	li	$v0, 10				#exit program successfully
	syscall