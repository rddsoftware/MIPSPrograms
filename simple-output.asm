.data

str1:	.asciiz		"=====================================================================================\n\n"
str2:	.asciiz		"Program Description:\t\t\tA simple program to output string and integer\n\n"
str3:	.asciiz		"Author:\t\t\t\t\tRusty Dillard\n\n"
str4:	.asciiz		"Creation Date:\t\t\t\t09/08/2021\n\n"
str5:	.asciiz		"The Course number\t\t\t"
str6:	.asciiz		"\n\nThe year in the program\t\t\t"

.text


main:

	li		$v0, 4
	la		$a0, str1
	syscall

	li		$v0, 4
	la		$a0, str2
	syscall
	
	li		$v0, 4
	la		$a0, str3
	syscall
	
	li		$v0, 4
	la		$a0, str4
	syscall
	
	li		$v0, 4
	la		$a0, str5
	syscall
	
	li		$v0, 1
	li		$a0, 231
	syscall
	
	li		$v0, 4
	la		$a0, str6
	syscall
	
	li		$v0, 1
	li		$a0, 3
	syscall
	
	li		$v0, 10
	syscall