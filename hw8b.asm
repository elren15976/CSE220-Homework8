# Elijah Ren - 116253293

# If formatting is off, I have my tabs as
# 4 spaces, instead of the default 8 spaces

.data
	whitespace: .asciiz " "
	newline: .asciiz "\n"
	separator: .asciiz "|"
	a_prompt: .asciiz "A["
	b_prompt: .asciiz "B["
	closing: .asciiz "]="
.align 2
	A: .space 40			# memory space for Array A
	B: .space 40			# memory space for Array B
	num: .word 10			# number of elements (integer)
	
.text
.globl main
main:
	la $s0, A				# Loads reference to array A into $s0
	la $s1, B				# Loads reference to array B into $s1
	lw $s2, num				# Load number of elements into $s0
	
	beq $s2, 0, exit		# Immediately exit if there are no elements
	
	
	li $t0, 0				# Loop variable (int i = 0)
user_input:
	mul $t1, $t0, 4			# Getting offset for arrays $t1 = $t0 * 4
	add $t2, $s0, $t1		# Storing address + index for array A
	add $t3, $s1, $t1		# Storing address + index for array B
	
	addi $t0, $t0, 1		# Incrementing counter (i = i + 1)
	
	la $a0, a_prompt		# Load prompt for A array into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	move $a0, $t0			# Copy current index (i) into $a0
	li $v0, 1				# Syscall code for printing integer
	syscall
	
	la $a0, closing			# Load closing into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	li $v0, 5				# Syscall code for reading int
	syscall
	
	sw $v0, ($t2)			# Store the user result into array A,
							# in the proper address (including offset)
	
	la $a0, b_prompt		# Load prompt for B array into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	move $a0, $t0			# Copy current index (i) into $a0
	li $v0, 1				# Syscall code for printing integer
	syscall
	
	la $a0, closing			# Load closing into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	li $v0, 5				# Syscall code for reading int
	syscall
	
	sw $v0, ($t3)			# Store the user result into array B,
							# in the proper address (including offset)
	
	blt $t0, $s2, user_input# If current index is less than $s2, loop
	
	
	li $t0, 0				# Loop variable (int i = 0)
swap_loop:
	mul $t1, $t0, 4			# Getting offset for arrays $t1 = $t0 * 4
	
	add $a1, $s0, $t1		# Storing address + index for array A in $a1
	add $a2, $s1, $t1		# Storing address + index for array B in $a2
	jal swap				# Jump to swap, and swap the 2 numbers
							# stored in $a1 and $a2
	
	addi $t0, $t0, 1		# Incrementing counter (i = i + 1)
	
	blt $t0, $s2, swap_loop # If current index is less than $s2, loop
	
	
	li $t0, 0				# Loop variable (int i = 0)
print_loop:
	mul $t1, $t0, 4			# Getting offset for arrays $t1 = $t0 * 4
	add $t2, $s0, $t1		# Storing address + index for array A
	add $t3, $s1, $t1		# Storing address + index for array B
	
	lw $a0, ($t2)			# Load integer stored in current index of array A
	li $v0, 1				# Syscall code for printing integer
	syscall
	
	la $a0, whitespace		# Load whitespace into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	lw $a0, ($t3)			# Load integer stored in current index of array B
	li $v0, 1				# Syscall code for printing integer
	syscall
	
	la $a0, separator		# Load separator character into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t0, $t0, 1		# Incrementing counter (i = i + 1)
	
	blt $t0, $s2, print_loop# If current index is less than $s2, loop
	
	
exit:
	#Exiting Program
	li $v0, 10				# Syscall code for exiting
	syscall


# swap(int *a1, int *a2)
swap:
	# Using matching a1 t1, and a2 t2
	lw $t1, ($a1)			# Load contents in memory address $a1 into $t1
	lw $t2, ($a2)			# Load contents in memory address $a2 into $t2
	
	sw $t1, ($a2)			# Store $t1 into memory address $a2
	sw $t2, ($a1)			# Store $t2 into memory address $a1
	jr $ra					# Return to Caller
	
