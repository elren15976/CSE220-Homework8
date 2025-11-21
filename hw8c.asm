# Elijah Ren - 116253293

# If formatting is off, I have my tabs as
# 4 spaces, instead of the default 8 spaces

.data
	whitespace: .asciiz " "
	newline: .asciiz "\n"
	bf_sort: .asciiz "Before sorting: "
	af_sort: .asciiz "After sorting: "
	myArray: .word 40, 30, 10, 50, 20	# Array with 5 elements
	num: .word 5					# number of elements (integer)
	
.text
.globl main
main:
	
	
exit:
	#Exiting Program
	li $v0, 10				# Syscall code for exiting
	syscall
	
	
swap:
	jr $ra