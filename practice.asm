.data

prompt:	.asciiz		"Enter two numbers:\n"

.text

	li $v0, 4
	la $a0, prompt
	syscall

	li $v0, 5
	syscall
	
	add $s0, $v0, $0
	
	li $v0, 5
	syscall
	
	add $s1, $v0, $0
	
	beq $s0, $s1, done
	
	else: 	li 	$v0, 1
		sub 	$t4, $t5, $t6
		syscall
	
	j exit
	
	done: 	li 	$v0, 1
		add 	$t0, $t1, $t2
		syscall
	
	exit: li $v0, 10
	syscall