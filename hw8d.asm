# Elijah Ren - 116253293

# If formatting is off, I have my tabs as
# 4 spaces, instead of the default 8 spaces

.data
	whitespace: .asciiz " "
	newline: .asciiz "\n"
.align 2
	A:	.word 1, 2, 3, 4, 5	# Matrix 1
		.word 6, 7, 8, 9, 1
		.word 2, 3, 4, 5, 6
		.word 7, 8, 9, 1, 2
		.word 3, 4, 5, 6, 7
	B:	.word 10, 58, 32, 18, 39	# Matrix 2
		.word 98, 4, 37, 17, 48
		.word 29, 49, 28, 67, 26
		.word 6, 48, 78, 32, 86
		.word 91, 47, 79, 54, 28
	
	C: .space 100			# 25 integers * 4 bytes each = 100 bytes
	n: .word 5				# Matrix dimension (5x5)
	
.text
.globl main
main:
	la $a0, C				# Load matrix C into $a0
	la $a1, A				# Load matrix A into $a1
	la $a2, B				# Load matrix B into $a2
	lw $a3, n				# Load matrix dimension into $a3
	
	jal multiply			# Multiply the matrices and store in C
	
	la $a1, C				# Load matrix C into $a1
	lw $a2, n				# Load matrix dimension into $a2
	
	jal print_matrix		# Print the matrix
	
exit:
	#Exiting Program
	li $v0, 10				# Syscall code for exiting
	syscall
	
	
# void multiply(int C[][], int A[][], int B[][], int s)
multiply:
	li $t0, 0				# Loop variable (int i = 0)
mult_loop_one:
	li $t1, 0				# Loop variable (int j = 0)
mult_loop_two:
	mul $t3, $t0, $a3		# Getting offset for each row $t3 = i * s (currRow * rowSize)
	add $t3, $t3, $t1		# Add current row with current element within row
	mul $t3, $t3, 4			# Multiply size 1 word = 4 bytes
	add $t3, $a0, $t3		# Storing C[i][j] (C[i*s + j])
	
	li $t2, 0				# Loop variable (int k = 0)
mult_loop_three:
	# i*s + k
	mul $t4, $t0, $a3		# Getting offset for each row $t4 = i * s
	add $t4, $t4, $t2		# Add current column $t4 = (i*s) + k
	mul $t4, $t4, 4			# Multiply size 1 word = 4 bytes
	add $t4, $a1, $t4		# Storing address for A[i][k] (A[i*s + k])
	lw $t4, ($t4)			# Load the number stored in A[i][k]
	
	# k*s + j
	mul $t5, $t2, $a3		# Getting offset for each row $t5 = k * s
	add $t5, $t5, $t1		# Add current column $t5 = (k*s) + j
	mul $t5, $t5, 4			# Multiply size 1 word = 4 bytes
	add $t5, $a2, $t5		# Storing address for B[k][j] (B[k*s + j])
	lw $t5, ($t5)			# Load the number stored in B[k][j]
	
	# C[i][j] += A[i][k] * B[k][j]
	mul $t4, $t4, $t5		# Multiplying A[i][k] and B[k][j]
	lw $t5, ($t3)			# Load the number stored in C[i][j] (For previous sums)
	add $t5, $t5, $t4		# Adding to previous sum, the product of A[i][k] and B[k][j]
	sw $t5, ($t3)			# Storing the result back into C[i][j]
	
	addi $t2, $t2, 1		# Incrementing counter (k = k + 1)
	
	blt $t2, $a3, mult_loop_three # If k < s, loop
	
	addi $t1, $t1, 1		# Incrementing counter (j = j + 1)
	
	blt $t1, $a3, mult_loop_two # If j < s, loop
	
	addi $t0, $t0, 1		# Incrementing counter (i = i + 1)
	
	blt $t0, $a3, mult_loop_one # If i < s, loop
	
	jr $ra					# Return to Caller
	
	
# void print_matrix(int v[], int s)		s = matrix dimension
print_matrix:
	li $t0, 0				# Loop variable (int i = 0)
print_loop_one:
	li $t1, 0				# Loop variable (int j = 0)
print_loop_two:
	mul $t2, $t0, $a2		# Getting offset for each row $t2 = i * s (currRow * rowSize)
	add $t2, $t2, $t1		# Add current row with current element within row
	mul $t2, $t2, 4			# Multiply size 1 word = 4 bytes
	add $t2, $a1, $t2		# Storing v[i][j] (v[i*s + j])
	
	lw $a0, ($t2)			# Load value at v[i] into $a0
	li $v0, 1				# Syscall code for printing integer
	syscall
	
	la $a0, whitespace		# Load whitespace into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t1, $t1, 1		# Incrementing counter (j = j + 1)
	
	blt $t1, $a2, print_loop_two # If j < s, loop
	
	la $a0, newline			# Load newline into $a0
	li $v0, 4				# Syscall code for printing ascii
	syscall
	
	addi $t0, $t0, 1		# Incrementing counter (i = i + 1)
	
	blt $t0, $a2, print_loop_one # If i < s, loop
	
	jr $ra					# Return to Caller
	
