.data

str1:		.asciiz		"Hello\n"
str2:		.asciiz		"This is the first program in \tCS "
#var1:	.word		 	231

.text


main:

	li 		$v0, 4
	la		$a0, str1
	syscall
	
	
	li		$v0, 4
	la		$a0, str2
	syscall
	
	
	li		$v0, 1
	li		$a0, 231
	syscall