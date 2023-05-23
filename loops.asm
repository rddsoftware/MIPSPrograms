.data

p1:	.asciiz		"Hi there!\n"

.text

	li	$s0, 10
	li	$s1, 0
	
begin:	beq	$s1, $s0, stop			#beginning of loop
	
		li	$v0, 4
		la	$a0, p1
		syscall				#print Hi there! to the console
		
		addi $s1, $s1, 1
		
		j begin				#jump back to begin
	
	stop:	li, $v0, 10			#stop and exit
		syscall