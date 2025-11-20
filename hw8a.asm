# Elijah Ren - 116253293

.data
	select_prompt: .asciiz "Triangle(0) or Square(1) or Pyramid (2)?"
	size_prompt: .asciiz "Required size?"
	star: .asciiz "* "
	newline: .asciiz "\n"

.text
.globl main
main:
	la $a0, select_prompt	# Load prompt for shape type into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	li $v0, 5				# Syscall code for reading int
	syscall
	
	move $t0, $v0			# Store the user result (Type of Shape) into $t0
	
	la $a0, size_prompt		# Load prompt for shape size into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	li $v0, 5				# Syscall code for reading int
	syscall
	
	move $a1, $v0			# Store the user result (Size of shape) into $a1
	
	# Using the stored input, determine which shape to draw
	beq $t0, 0, triangle_start		# 0 - Triangle
	beq $t0, 1, square_start		# 1 - Square
	beq $t0, 2, pyramid_start		# 2 - Pyramid
	
	#If none are equal, fall through to exit
	
exit:
	#Exiting Program
	li $v0, 10				# Syscall code for exiting
	syscall


triangle_start:
	jal triangle			# After branching, use jal so the
							# final return statement has somewhere to go
	j exit					# After returning from main function, go to exit
triangle:
	addi $sp, $sp, -8		# Allocate space in stack to store 2 integers
	sw $ra, 4($sp)			# Store return address into stack
	sw $a1, 0($sp)			# Store current size into stack
	
	ble $a1, 0, base_triangle	# If $a1 is less than or equal to 0, go to base case
							# Does not overwrite $ra
	
	add $a1, $a1, -1		# Decrementing counter (n = n - 1)
	
	jal triangle			# If not base case, recursively call
							# Once base case reached, jr will return here
	
	li $t0, 0				# Loop variable (int i = 0)
star_loop_t:
	la $a0, star			# Load star into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t0, $t0, 1		# After iteration, add 1 (i = i + 1)
	
	ble $t0, $a1, star_loop_t	# Loop condition (if i <= n, then loop)
	
	la $a0, newline			# Load newline character into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
base_triangle:
	lw $ra, 4($sp)			# Load/Recall return address into stack
	lw $a1, 0($sp)			# Load/Recall current size from stack
	addi $sp, $sp, 8		# Deallocate space in stack
	
	jr $ra					# Return to Caller


square_start:
	move $a2, $a1			# Copy shape size to $a2, so loop operations
							# don't affect it
	jal square				# After branching, use jal so the
							# final return statement has somewhere to go
	j exit					# After returning from main function, go to exit
square:
	addi $sp, $sp, -8		# Allocate space in stack to store 2 integers
	sw $ra, 4($sp)			# Store return address into stack
	sw $a1, 0($sp)			# Store current size into stack
	
	ble $a1, 0, base_square	# If $a1 is less than or equal to 0, go to base case
							# Does not overwrite $ra
	
	add $a1, $a1, -1		# Decrementing counter (n = n - 1)
	
	jal square				# If not base case, recursively call
							# Once base case reached, jr will return here
	
	li $t0, 0				# Loop variable (int i = 0)
star_loop_s:
	la $a0, star			# Load star into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t0, $t0, 1		# After iteration, add 1 (i = i + 1)
	
	blt $t0, $a2, star_loop_s	# Loop condition (if i < n, then loop)
	
	la $a0, newline			# Load newline character into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
base_square:
	lw $ra, 4($sp)			# Load/Recall return address into stack
	lw $a1, 0($sp)			# Load/Recall current size from stack
	addi $sp, $sp, 8		# Deallocate space in stack
	
	jr $ra					# Return to Caller


pyramid_start:
	jal pyramid				# After branching, use jal so the
							# final return statement has somewhere to go
	j exit					# After returning from main function, go to exit
pyramid:
	
	jr $ra					# Return to Caller
