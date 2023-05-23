.data

border:	.asciiz		"===========================================================================\n"
descri:	.asciiz		"Program Description:\tPrint Output\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t09/13/2021\n"
prompt:	.asciiz		"How many numbers would you like to add together?\t"
sumev:	.asciiz		"The sum of the even numbers is:\t\t"

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
	
#======================================================================================================================================

	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 5				#integer user input for the amount of integers they want to input
	syscall
	
	add 	$s0, $v0, $0			#add the user input to $s0 to use as a loop condition
	
	add	$s1, $s1, $0			#store 0 into $s1 to use a a loop condition
	
#=======input loop=====================================================================================================================
	
	begin:	beq	$s1, $s0, stop
		
		li	$v0, 5			#integer user input, will keep taking input until $s1 is equal to $s0
		syscall
		
		add	$t0, $v0, $0		#add the user input to $t0 for use 
		
		andi	$t1, $t0, 0x01		#stores 1 in $t1 if odd and 0 inn $t1 if even
		
		addi	$s1, $s1, 1			#increment $s1 to push the loop closer to the end
		
		beq	$t1, $0, sum		#if $t1 is 0, the number is even and moves into sum
		
		j	begin				#loops back to the beginning of the input loop
		
#=======sum condition loops============================================================================================================
		
	sum:	add	$s3, $s3, $t0		#adds updates the value of $s3 to be the sum of $s3 with $t0
	
		j	begin				#loops back to the beginning of the input loop
		
#=======end condition of the input loop================================================================================================

	stop:	li	$v0, 4
		la	$a0, sumev			#output to console the sumev string
		syscall
		
		li	$v0, 1
		add	$a0, $s3, $0		#output to console the sum of all the even numbers input by the user
		syscall
		
		li	$v0, 10			#exit the program
		syscall