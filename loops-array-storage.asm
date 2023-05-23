.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tAsk user for input and use functions to store\n\t\t\tthe input into an array.\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t10/04/2021\n"
arrpro:	.asciiz		"Input the number of elements for your array \"n\" (2 < n <10): "
numpro:	.asciiz		"Enter array element "
colon:	.asciiz		": "
erroob:	.asciiz		"==> ERROR!!! The number you entered was out of bounds.\n"
display:	.asciiz		"The summ of the elements added together is "
array:	.word			0, 0, 0, 0, 0, 0, 0

.text
#=======Header=========================================================================================================
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
	
#=======code===========================================================================================================
main:
	li	$v0, 4
	la	$a0, arrpro				#prompt user for input between 2 and 10
	syscall
	
	li	$v0, 5				#take user input
	syscall
	
	add	$s0, $v0, $0			#
	
	blt	$s0, 3, errlt
	bgt	$s0, 10, errgt
	
	la	$s1, array				#point to the array address
	
	add	$a1, $s0, $0			#array size = $a1
	add	$a2, $s1, $0			#array pointer = $a2
	
	jal	FillArray				#jump and link to the FillArray funciton
	
	add	$s1, $v1, $0
	
	add	$a1, $s0, $0			#array size = $a1
	add	$a2, $s1, $0			#array pointer = $a2
	
	jal	AddElements				#jump and link to the AddElements function
	
	add	$s2, $v1, $0			#return value from AddElements
	
#=======end of program=================================================================================================
	li	$v0, 4
	la	$a0, display			#print display string
	syscall
		
	li	$v0, 1
	add	$a0, $s2, $0			#print sum
	syscall
	
	li	$v0, 10				#exit program
	syscall
	
errlt:
	li	$v0, 4
	la	$a0, erroob				#print out of bounds error
	syscall
	
	j	main					#jump to main

errgt:
	li	$v0, 4
	la	$a0, erroob				#print out of bounds error
	syscall
	
	j	main					#jump to main
	
FillArray:
	add	$t0, $0, $a2			#array pointer
	add	$t1, $0, $a1			#array size
	li	$t3, 0				#counter
	
	loopFill:
		beq	$t3, $t1, doneFill	#array filling loop
		
		addi	$t3, $t3, 1			#counter++
		
		li	$v0, 4
		la	$a0, numpro			#print array element prompt
		syscall
		
		li	$v0, 1
		add	$a0, $t3, $0		#print counter
		syscall
	
		li	$v0, 4
		la	$a0, colon			#print colon
		syscall
	
		li	$v0, 5			#take user input
		syscall
	
		sw	$v0, 0($t0)			#store user input in array at current $t0
		
		addi	$t0, $t0, 4			#update $t0
	
		j	loopFill			#jump back to loopFill

	doneFill:
		add	$v1, $t0, $0		#add array pointer to $v1 to return to main
		jr	$ra				#jump back to next line after FillArray is called
	
AddElements:
	add	$t1, $0, $a1			#array size
	add	$t2, $0, $a2			#array pointer
	li	$t3, 0				#sum
	
	loopAdd:
		beq	$t1, $0, doneAdd
	
		addi	$t2, $t2, -4
		addi	$t1, $t1, -1
		
		lw	$t4, 0($t2)
		add	$t3, $t3, $t4
		
		j	loopAdd

doneAdd:
	add	$v1, $t3, $0
	jr	$ra
