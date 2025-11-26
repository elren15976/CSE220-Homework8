# Elijah Ren - 116253293

# If formatting is off, I have my tabs as
# 4 spaces, instead of the default 8 spaces

.data
	whitespace: .asciiz " "
	newline: .asciiz "\n"
	bf_sort: .asciiz "Before sorting: "
	af_sort: .asciiz "After sorting: "
	myArray: .word 100, 95, 35, 30, 1450, 450, 20, 8, 765, 720	# Array
	num: .word 10					# number of elements (integer)
	
.text
.globl main
main:
	la $a0, bf_sort			# Load "Before sorting: " into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	la $a1, myArray			# Load myArray into $a1
	lw $a2, num				# Load array size into $a2
	li $a3, 0				# Loop variable into $a3 (int i = 0)
	jal print_array			# Jump to print_array
	
	jal sort				# Sort the array
	
	la $a0, af_sort			# Load "After sorting: " into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	la $a1, myArray			# Load myArray into $a1
	lw $a2, num				# Load array size into $a2
	jal print_array			# Jump to print_array
	
exit:
	#Exiting Program
	li $v0, 10				# Syscall code for exiting
	syscall
	
	
# void sort(int v[], int n)
sort:
	li $t0, 0				# Loop variable 1 (int i = 0)
	addi $a2, $a2, -1		# Will loop to 1 less than the size (n-1)
sort_loop_one:
	li $t1, 0				# Loop variable 2 (int j = 0)
	sub $t2, $a2, $t0		# Inner loop bound (n-1-i)
	
	ble $a2, 1, skip_loop	# If array size less than or equal to 1, skip sorting altogether
							# Must be done after loop variables initialized
sort_loop_two:
	mul $t3, $t1, 4			# Getting offset for arrays $t3 = j * 4
	add $t3, $a1, $t3		# Storing v[j] into $t3
	add $t4, $t3, 4			# Store pointer by 1 word (4 bytes) into
							# $t4 ( v[k+1] )
	
	lw $t3, ($t3)			# Load contents of v[j] into $t3
	lw $t4, ($t4)			# Load contents of v[j+1] into $t4
	
	ble $t3, $t4, skip_loop	# If v[j] <= v[j+1], skip the swap(v, j) routine
							# (If v[j] > v[j+1], swap)
	
	addi $sp, $sp, -20		# Allocate space in stack
	sw $ra, 16($sp)			# Store return address into stack
	sw $t2, 12($sp)			# Store inner loop bound into stack
	sw $t1, 8($sp)			# Store inner loop variable into stack
	sw $a2, 4($sp)			# Store array size into stack
	sw $a1, 0($sp)			# Store array address into stack
	
							# Array v is already in $a1
	move $a2, $t1			# Store current index into $a2
	
	jal swap				# Jump to sort
	
	lw $ra, 16($sp)			# Load/Recall return address from stack
	lw $t2, 12($sp)			# Load/Recall inner loop bound from stack
	lw $t1, 8($sp)			# Load/Recall inner loop variable from stack
	lw $a2, 4($sp)			# Load/Recall array size from stack
	lw $a1, 0($sp)			# Load/Recall original array address from stack
	addi $sp, $sp, 20		# Deallocate space from stack
skip_loop:
	addi $t1, $t1, 1		# Incrementing counter 2 (j = j + 1)
	
	blt $t1, $t2, sort_loop_two # If j < n - 1 - i, then loop
	
	addi $t0, $t0, 1		# Incrementing counter 1 (i = i + 1)
	
	blt $t0, $a2, sort_loop_one # If i < n - 1, then loop
	
	jr $ra					# Return to Caller
	
	
# void swap(int v[], int k)
swap:
	mul $a2, $a2, 4			# Getting offset for arrays $a2 = k * 4
	add $a1, $a1, $a2		# Set $a1 to v[k]
	move $a2, $a1			# Copy $a1 to $a2 ( v[k] )
	addi $a2, $a2, 4		# Move pointer by 1 word (4 bytes) ( v[k+1] )
	
	# Matching the numbers for $t and $a registers
	lw $t1, ($a1)			# Load contents in v[k] into $t1
	lw $t2, ($a2)			# Load contents in v[k+1] into $t2
	
	sw $t1, ($a2)			# Store $t1 into v[k+1]
	sw $t2, ($a1)			# Store $t2 into v[k]
	
	jr $ra					# Return to Caller
	
	
# void print_array(int v[], int size)
print_array:
	li $t0, 0				# Loop variable (int i = 0)
print_loop:
	mul $t1, $t0, 4			# Getting offset for arrays $t1 = i * 4
	add $t2, $a1, $t1		# Storing v[i]
	
	lw $a0, ($t2)			# Load value at v[i] into $a0
	li $v0, 1				# Syscall code for printing integer
	syscall
	
	la $a0, whitespace		# Load whitespace into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t0, $t0, 1		# Incrementing counter (i = i + 1)
	
	blt $t0, $a2, print_loop # If i < size, loop
	
	# After array is printed
	la $a0, newline			# Load newline into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	jr $ra					# Return to Caller
	
