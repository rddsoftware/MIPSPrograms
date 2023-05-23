.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tConvert integer input into a single-precision\n\t\t\tnumber or \"float\".\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t10/11/2021\n"
celpro:	.asciiz		"Please input a temperature in Celcius\n=> "
fahres:	.asciiz		"The temperature in Fahrenheit is\n=> "
cnvfac:	.float		1.8					#store a single-precision number at address cnvfac to be multiplication conversion factor
addfac:	.float		32					#store a single-precision number at address addfac to be addition conversion factor

.text

#=======Header=========================================================================================================
	li	$v0, 4
	la	$a0, border					#print border
	syscall
	
	li	$v0, 4
	la	$a0, descri					#print program description
	syscall
	
	li	$v0, 4
	la	$a0, auth					#print author information
	syscall
	
	li	$v0, 4
	la	$a0, date					#print date created
	syscall
	
	li	$v0, 4
	la	$a0, border					#print border
	syscall
	
#=======code===========================================================================================================
	#F = (C * 1.8)+ 32					conversion formula from Celcius to Fahrenheit

	li	$v0, 4						#string call
	la	$a0, celpro						#load string at address celpro into $a0
	syscall							#print: "Please input a temperature in Celcius\n=> " from $a0
	
	li	$v0, 5						#integer call
	syscall							#get integer from user 								(C)
	
	add	$s0, $v0, $0					#store the user's input into $s0
	
	mtc1	$s0, $f0						#move integer in $s0 into co-processor 1 $f0
	cvt.s.w	$f0, $f0					#convert integer precision to single precision
	
	l.s	$f1, cnvfac						#load the conversion factor with single precision into $f1
	l.s	$f2, addfac						#load the addition factor with single precision into $f2
	
	mul.s	$f3, $f1, $f0					#multiply with single precision $f1 and $f0 and store in $f3
	add.s	$f3, $f3, $f2					#add the value in $f3 with the addition factor and store in $f3 		(F)
	
	li	$v0, 4						#string call
	la	$a0, fahres						#load string at address fahres into $a0
	syscall							#print: "The temperature in Fahrenheit is\n=> " from $a0
	
	li	$v0, 2						#single precision call
	mov.s	$f12, $f3						#move the single precision number in $f3 to $f12 to print its value
	syscall							#print the single-precision value moved into $f12
	
#=======exit===========================================================================================================
	li	$v0, 10						#program exit call
	syscall							#exit program