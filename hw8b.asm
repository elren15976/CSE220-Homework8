# Elijah Ren - 116253293

# If formatting is off, I have my tabs as
# 4 spaces, instead of the default 8 spaces

.data
	whitespace: .asciiz " "
	newline: .asciiz "\n"
	separator: .asciiz "|"
.align 2
	A: .space 40	# memory space for Array A
	B: .space 40	# memory space for Array B
	num: .word 10	# number of elements (integer)
	
.text
.globl main
main:

exit:
	#Exiting Program
	li $v0, 10				# Syscall code for exiting
	syscall