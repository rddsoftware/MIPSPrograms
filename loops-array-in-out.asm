.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tAsk user for input and use conditional loops\n\t\t\tto store and output array data.\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t09/22/2021\n"
promp1:	.asciiz		"Enter the number of elements: "
promp2:	.asciiz		"Enter number "
procol:	.asciiz		": \t"
conten:	.asciiz		"The content of the array in reverse order is:\n"
errgt:	.asciiz		"==> ERROR!! Array can't have more than 10 elements.\nPlease enter a new choice for the number of elements: "
errlt:	.asciiz		"The number of elements must be positive for an array.\nPlease enter a new choice for the number of elements: "
newlin:	.asciiz		"\n"
arr:		.word			0, 0, 0, 0, 0, 0, 0, 0, 0, 0

#=======begin program=============================================================================================================================

.text

	li	$v0, 4
	la	$a0, border
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
	
#=======begin prompt and loops====================================================================================================================
	li	$s7, 10				#load 10 into $s7 immediately - loop parameter
	li	$s2, 1				#load 1 into $s2 immediately - input counter
	la	$s1, arr				#load arr index 0 into $s1 - 

	li	$v0, 4
	la	$a0, promp1				#prompt user to enter the length of the array
	syscall

insize:
	li	$v0, 5				#store user input in $v0
	syscall
	
	add	$s0, $v0, $0			#move user's input to $s0 for later use
	add	$s3, $0, $s0			#add $s0 to $s3 for use in the output
	
	ble	$s0, $0, errneg			#check if the user's choice was negative
	bgt	$s0, $s7, errbig			#check if the user's choise was too big
	
	j	inarr					#jump to the inarr loop
	
inarr:
	beqz	$s0, done				#if $s0 = 0, go to done
	
	li	$v0, 4
	la	$a0, promp2				#prompt use for indicated number
	syscall
	
	li	$v0, 1
	add	$a0, $s2, $0			#indicate which number the user is on
	syscall
	
	li	$v0, 4
	la	$a0, procol				#output a colon
	syscall
	
	li	$v0, 5				#accept user's input
	syscall
	
	sw	$v0, 0($s1)				#store user's input in the current index of arr
	
	addi	$s0, $s0, -1			#decrement $s0
	addi	$s2, $s2, 1				#increment the index indicator
	addi	$s1, $s1, 4				#increment the arr index by 1 by moving 4 bytes
	
	j	inarr					#jump back to the beginning of inarr loop
	
#=======error handling============================================================================================================================
	
errneg:
	li	$v0, 4
	la	$a0, errlt				#less than zero error
	syscall
	
	j	insize				#jump back to insize
	
errbig:
	li	$v0, 4
	la	$a0, errgt				#greater than ten error
	syscall
	
	j	insize				#jump back to insize
#=======end program===============================================================================================================================
done:
	li	$v0, 4
	la	$a0, border				#output border
	syscall
	
	li	$v0, 4
	la	$a0, conten				#output conten string
	syscall
	
	li	$v0, 4
	la	$a0, border				#output border
	syscall
	
	addi	$s1, $s1, -4			#decrement the arr index by 4 bytes
	
	j	display
	
display:
	beq	$s3, $0, exit			#check if $s3 = $0, if so, go to exit
	
	lw	$s6, 0($s1)				#load word from current arr index
	li	$v0, 1
	add	$a0, $s6, $0			#add $t0 to $a0 for display
	syscall
	
	li	$v0, 4
	la	$a0, newlin
	syscall
	
	addi	$s3, $s3, -1			#decrement $s3 for looping condition update
	addi	$s1, $s1, -4			#decrement the arr index by 4 bytes
	
	j	display				#jump back to display
	
exit:
	li	$v0, 4
	la	$a0, border
	syscall
	
	li	$v0, 10				#exit program
	syscall