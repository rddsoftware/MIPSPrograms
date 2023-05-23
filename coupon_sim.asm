.data

border:	.asciiz		"=======================================================================\n"
descri:	.asciiz		"Program Description:\tGrocery Shopping with coupons.\n"
auth:		.asciiz		"Author:\t\t\tRusty Dillard\n"
date:		.asciiz		"Creation Date:\t\t10/06/2021\n"
itmtot:	.asciiz		"Please enter the nubmer of items you are purchasing:\n"
erioob:	.asciiz		"Sorry, that's too many items to purchase!\n"
itmnum:	.asciiz		"Please enter the price of item "
colon:	.asciiz		":\t"
coutot:	.asciiz		"Please enter the number of coupons that you want to use:\n"
errcob:	.asciiz		"Sorry, the number of coupons must match the number of items.\n"
counum:	.asciiz		"Please enter the amount of coupon "
errctm:	.asciiz		"This coupon is not acceptable.\n"
total:	.asciiz		"Your total charge is:\t"
thanks:	.asciiz		"\nThank you for shopping with us!\n"
itmarr:	.word			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
couarr:	.word			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

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
	li	$s7, 20						#store upper boundary to $s7 as 20
	
inputItem:
	li	$v0, 4
	la	$a0, itmtot					#print item total prompt string
	syscall
	
	li	$v0, 5						#take user's input
	syscall
	
	add	$s0, $v0, $0					#store user's input to $s0
	
	bgt	$s0, $s7, itemError				#if $s0 > $s7, go to itemError
	
	li	$v0, 4
	la	$a0, border					#output border
	syscall
	
	la	$a1, itmarr					#pass address to FillPriceArray by $a1
	add	$a2, $s0, $0					#pass array size to FillPriceArray by $a2
	
	add	$s5, $a1, $0					#store array pointer for later use
	
	jal	FillPriceArray					#jump and link FillPriceArray
	
	li	$v0, 4
	la	$a0, border					#print border
	syscall
	
	add	$s1, $v1, $0					#store the sum returned from the FillPriceArray function

#=======function return test===========================================================================================
	#li	$v0, 1
	#add	$a0, $s1, $0
	#syscall
#=======function return test===========================================================================================
	
inputCoupon:
	li	$v0, 4
	la	$a0, coutot					#print coupon array size prompt
	syscall
	
	li	$v0, 5						#take user's input
	syscall
	
	add	$s2, $v0, $0					#store user's input into $s2
	
	bne	$s2, $s0, couponError				#check if the number of coupons does not equal the number of items and go to couponError if true
	
	la	$a1, couarr					#pass address pointer of coupon array by $a1
	add	$a2, $s2, $0					#pass array size to FillCouponArray by $a2
	add	$a3, $s5, $0					#pass address pointer of item array by $a3
	
	jal	FillCouponArray					#jump and link FillCouponArray function
	
	add	$s3, $v1, $0					#store the return value of FillCouponArray into $s3
	
	sub	$s4, $s1, $s3					#subtract the sum of the item array by the sum of the coupon array
	
	li	$v0, 4
	la	$a0, border					#print a border
	syscall
	
	li	$v0, 4
	la	$a0, total					#print the total string
	syscall
	
	li	$v0, 1
	add	$a0, $s4, $0					#print the total integer
	syscall
	
	li	$v0, 4
	la	$a0, thanks					#print thank you message
	syscall
	
	li	$v0, 10						#exit program
	syscall

#=======main errors====================================================================================================
itemError:
	li	$v0, 4
	la	$a0, erioob					#print error message concerning too many items.
	syscall
	
	j	inputItem					#jump back to inputItem
	
couponError:
	li	$v0, 4
	la	$a0, errcob					#print error message concerning an incorrect number of coupons.
	syscall
	
	j	inputCoupon					#jump back to inputCoupon

#=======Functions======================================================================================================
FillPriceArray:
	add	$t0, $a1, $0					#store array pointer in $t0 by $a1
	add	$t1, $a2, $0					#store array size in $t1 by $a2
	li	$t2, 0						#counter register
	li	$t3, 0						#sum register

	fillPrice:
		beq	$t2, $t1, fillPriceDone				#check if the counter is equal to the array size and go to fillPriceDone if true
	
		li	$t4, 0						#set $t4 to zero for every iteration of the loop so as not to accumulate a sum.

		li	$v0, 4
		la	$a0, itmnum					#print the item number prompt
		syscall
	
		addi	$t2, $t2, 1					#update counter 
	
		li	$v0, 1
		add	$a0, $t2, $0					#print the item number
		syscall
	
		li	$v0, 4
		la	$a0, colon					#print a colon
		syscall
	
		li	$v0, 5						#take user's input
		syscall
	
		add	$t4, $v0, $0					#add user's input to $t4
		add	$t3, $t3, $t4					#accumulate the sum of prices
	
		sw	$t4, 0($t0)					#store user's input in the array
	
		addi	$t0, $t0, 4					#increment the array
	
		j	fillPrice					#jump back to fillPrice
	
	fillPriceDone:
	#=======accumulation test==============================================================================================
		#li	$v0, 1
		#add	$a0, $t3, $0
		#syscall
	#=======accumulation test==============================================================================================
		add	$v1, $t3, $0					#return the subtotal to the 
		jr	$ra
	
FillCouponArray:
	add	$t0, $a1, $0					#coupon array address pointer
	add	$t1, $a2, $0					#coupon array size
	add	$t2, $a3, $0					#item array pointer
	li	$t3, 0						#counter
	li	$t4, 0						#sum
	li	$t5, 10						#upper boundary for coupon amount
	
	fillCoupon:
		beq	$t3, $t1, fillCouponDone			#check if counter is equal to the array size and go to fillCouponDone if true
	
		li	$t6, 0						#set $t6 to 0 for every iteration of the loop so as not to accumulate a sum
	
		addi	$t3, $t3, 1					#update counter
	
		li	$v0, 4
		la	$a0, counum					#print the coupon fill prompt
		syscall
	
		li	$v0, 1
		add	$a0, $t3, $0					#print the coupon number
		syscall
	
		li	$v0, 4
		la	$a0, colon					#print a colon
		syscall
	
		li	$v0, 5						#take user's input
		syscall
	
		add	$t6, $v0, $0					#add user input to $t6
		lw	$t7, 0($t2)					#load item price into $t7 for comparison
		
		bgt	$t6, $t5, unnacceptableCoupon			#check if coupon is greater than 10
		bge	$t6, $t7, unnacceptableCoupon			#check if coupon is greater than item price

	store:
		sw	$t6, 0($t0)					#store the value of $t6 at the end of the coupon array
		
		add	$t4, $t4, $t6					#accumulate sum of coupons	
		addi	$t0, $t0, 4					#increment coupon array pointer
		addi	$t2, $t2, 4					#increment item array pointer
	
		j	fillCoupon
	
	unnacceptableCoupon:
		li	$v0, 4
		la	$a0, errctm					#print error concerning the value of the coupon being too large
		syscall
	
		li	$t6, 0						#immediately store 0 into the value of that coupon
	
		j	store
	
	fillCouponDone:
		add	$v1, $t4, $0					#return the sum of the coupon array
		jr	$ra