.include "ItoA.asm"

# print expression
.macro print_expression (%data, %isOp, %length, %filename)
.data
.text 
	la $t0, (%data) # get data
	la $t1, (%isOp)
	la $t2, (%length)
	li $t3, 0  # set i = 0
	j ex_check_loop
ex_body:
	sll $t4, $t3, 2 
	add $t4, $t4, $t0
	lw $t4, ($t4) # t4 = data[i]
	sll $t5, $t3, 2 
	add $t5, $t5, $t1
	lw $t5, ($t5) # t5 = isOp[i]
	addi $sp, $sp, -24 # store register
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	bne $t5, $zero, ex_go_print_operator
ex_go_print_int:
	print_int ($t4, %filename)
	j ex_end_body
ex_go_print_operator:
	print_operator($t4, %filename)
ex_end_body:
	print_space (%filename)
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	lw $t5, 20($sp)
	addi $sp, $sp, 24 # retrieve register
	addi $t3, $t3, 1 # i ++
ex_check_loop:
	bne $t3, $t2, ex_body # if i != n => loop
	print_new_line (%filename) 
.end_macro

# print operator
.macro print_operator (%x, %filename)
.data
newchar: .space 1
.text
	la $t0, (%x)
	la $t1, newchar
	slti $t3, $t0, 2 # if operator is + 
	bne $t3, $zero, op_plus
	slti $t3, $t0, 3 # if operator is - 
	bne $t3, $zero, op_minus
	slti $t3, $t0, 4 # if operator is * 
	bne $t3, $zero, op_mul
	slti $t3, $t0, 5 # if operator is / 
	bne $t3, $zero, op_div
	slti $t3, $t0, 6 # if operator is ( 
	bne $t3, $zero, op_open
	slti $t3, $t0, 7 # if operator is ) 
	bne $t3, $zero, op_close
	j op_print
op_plus:
	li $t3, '+'
	sb $t3, 0($t1) # save char to t1
	j op_print
op_minus:
	li $t3, '-'
	sb $t3, 0($t1) # save char to t1
	j op_print
op_mul:
	li $t3, '*'
	sb $t3, 0($t1) # save char to t1
	j op_print
op_div:
	li $t3, '/'
	sb $t3, 0($t1) # save char to t1
	j op_print
op_open:
	li $t3, '('
	sb $t3, 0($t1) # save char to t1
	j op_print
op_close:
	li $t3, ')'
	sb $t3, 0($t1) # save char to t1
	j op_print
op_print:
	li $t2, 1
	print_string_append ($t1, $t2, %filename)
.end_macro

# print int
.macro print_int (%x, %filename) 
.data
newInt: .space 20
.text
	la $t1, newInt
	la $t0, (%x)
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	i_to_a ($t0, $t1)
	lw $t1, 0($sp)
	addi $sp, $sp, 4
	add $t2, $zero, $v0  #length
	print_string_append ($t1, $t2, %filename)
.end_macro


# print new line
.macro print_new_line (%filename) 
.data
newline: .space 1
.text
	la $t1, newline
	li $t0, 10
	sb $t0, 0($t1) # save 1 to t1
	li $t2, 1 #length
	print_string_append ($t1, $t2, %filename)
.end_macro	

# print space
.macro print_space (%filename) 
.data
newline: .space 1
.text
	la $t1, newline
	li $t0, 32
	sb $t0, 0($t1) # save 1 to t1
	li $t2, 1 #length
	print_string_append ($t1, $t2, %filename)
.end_macro	

# print string in new file
.macro print_string_new_file(%address, %length, %filename)
.data
file: .asciiz %filename	# file = %filename

.text
file_open:
    li $v0, 13
    la $a0, file
    li $a1, 1
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
file_write:
    move $a0, $v0  # Syscall 15 requieres file descriptor in $a0
    li $v0, 15
    la $a1, (%address)
    la $a2, (%length)
    syscall
file_close:
    li $v0, 16  # $a0 already has the file descriptor
    syscall
.end_macro 

# print string append
.macro print_string_append(%address, %length, %filename)
.data
file: .asciiz %filename	# file = %filename

.text
file_open:
    li $v0, 13
    la $a0, file
    li $a1, 9 # append mode
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
file_write:
    move $a0, $v0  # Syscall 15 requieres file descriptor in $a0
    li $v0, 15
    la $a1, (%address)
    la $a2, (%length)
    syscall
file_close:
    li $v0, 16  # $a0 already has the file descriptor
    syscall
.end_macro 

# test write file
.macro test_write
.data
str_exit: .asciiz "test.txt"
str_data: .asciiz "This is a test!"
str_data_end:

.text

file_open:
    li $v0, 13
    la $a0, str_exit
    li $a1, 1
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
file_write:
    move $a0, $v0  # Syscall 15 requieres file descriptor in $a0
    li $v0, 15
    la $a1, str_data
    la $a2, str_data_end
    la $a3, str_data
    subu $a2, $a2, $a3  # computes the length of the string, this is really a constant
    subi $a2, $a2, 1
    syscall
file_close:
    li $v0, 16  # $a0 already has the file descriptor
    syscall
.end_macro 
