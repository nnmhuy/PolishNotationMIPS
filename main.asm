.include "output.asm"

.data
	x: .word 32
	stringtest: .space 10
	data: .word 0:40
	isOp: .word 0:40
.text
	la $t0, data
	la $t1, isOp
	li $t3, 52
	sw $t3, 0($t0)
	li $t3, 0
	sw $t3, 0($t1) 
	li $t3, 2
	sw $t3, 4($t0)
	li $t3, 1
	sw $t3, 4($t1)
	li $t3, 112
	sw $t3, 8($t0)
	li $t3, 0
	sw $t3, 8($t1)  
	li $t2, 3 #length
	print_expression ($t0, $t1, $t2, "testwrite.txt")
	#print_string_new_file ($t3, $t2, "testwrite.txt")
	#print_string_append ($t3, $t2, "testwrite.txt")
	#print_int ($t0, "testwrite.txt")
	
