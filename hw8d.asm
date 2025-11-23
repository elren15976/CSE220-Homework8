# Elijah Ren - 116253293

# If formatting is off, I have my tabs as
# 4 spaces, instead of the default 8 spaces

.data
	whitespace: .asciiz " "
	newline: .asciiz "\n"
.align 2
	A:	.word 1, 2, 3, 4	# Matrix
		.word 5, 6, 7, 8
		.word 9, 10, 11, 12
		.word 13, 14, 15, 16
	B:	.word 1, 0, 0, 0	# Unit Matrix
		.word 0, 1, 0, 0
		.word 0, 0, 1, 0
		.word 0, 0, 0, 1
	
	C: .space 64			# 16 integers * 4 bytes each = 64 bytes
	n: .word 4				# Matrix dimension (4x4)
	
.text
.globl main
main:
	la $a1, A				# Load matrix A intro $a1
	lw $a2, n				# Load matrix dimension into $a2
	
	jal print_matrix
	
exit:
	#Exiting Program
	li $v0, 10				# Syscall code for exiting
	syscall
	
	
# void print_matrix(int v[], int s)		s = matrix dimension
print_matrix:
	li $t0, 0				# Loop variable (int i = 0)
print_loop_one:
	li $t1, 0				# Loop variable (int j = 0)
print_loop_two:
	mul $t2, $a2, 4			# Getting each row in bytes ( $t2 = s * 4 )
	mul $t2, $t0, $t2		# Getting offset for each row $t2 = i * $t2
	mul $t3, $t1, 4			# Getting current element within row in bytes ( $t3 = j * 4 )
	add $t2, $t2, $t3		# Add current row with current element within row
	add $t2, $a1, $t2		# Storing v[i][j] (v[i*s + j])
	
	lw $a0, ($t2)			# Load value at v[i] into $a0
	li $v0, 1				# Syscall code for printing integer
	syscall
	
	la $a0, whitespace		# Load whitespace into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t1, $t1, 1		# Incrementing counter (j = j + 1)
	
	blt $t1, $a2, print_loop_two # If j < n, loop
	
	la $a0, newline			# Load newline into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t0, $t0, 1		# Incrementing counter (i = i + 1)
	
	blt $t0, $a2, print_loop_one # If i < n, loop
	
	jr $ra					# Return to Caller
	