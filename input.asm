.include "util.asm"

# parse 1 string to 2 array
.macro parse_line (%address, %length)
.text
	store_all_t
	la $t3, (%length)
	la $t2, (%address)
	li $t0, 0  # is negative = false
	li $t1, 0  # should be operator = false
	li $t4, 0 # current = 0
	li $t5, 0 # i = 0
	li $s2, 0
	
	j parse_condition
parse_loop:
	add $t6, $t2, $t5
	lb $t6, ($t6)
	move $t7, $t6
	sub $t6, $t6, 48 # if <0 or >9 => operator
	bltz $t6, parse_operator
	sub $t6, $t6, 9
	bgtz $t6, parse_operator
	add $t6, $t6, 9
parse_num:
	li $t7, 10
	mult $t4, $t7	
	mflo $t4
	add $t4, $t4, $t6 # current = current * 10 + a
	move $t6, $t4
	beqz $t0, parse_save_num 
	neg $t6, $t6 # negation if isNegative is true
parse_save_num:
	sll $t7, $s2, 2
	add $t7, $t7, $s0
	sw $t6, ($t7) 	# store data[s2]
	sll $t7, $s2, 2
	add $t7, $t7, $s1
	li $t6, 0 	# store isOp[s2] = false
	sw $t6, ($t7)
	li $t1, 1  # should be operator = true
	j parse_increase
parse_operator:
	# t7 is op
	li $t6, '+'
	beq $t6, $t7, parse_plus
	li $t6, '-'
	beq $t6, $t7, parse_minus
	li $t6, '*'
	beq $t6, $t7, parse_mul
	li $t6, '/'
	beq $t6, $t7, parse_div
	li $t6, '('
	beq $t6, $t7, parse_open
	li $t6, ')'
	beq $t6, $t7, parse_close
	j parse_increase
parse_plus:
	jal parse_skip_if_current
	li $t6, 1
	j parse_save_operator
parse_minus:
	beqz $t1, parse_minus_operand
parse_minus_operator:
	jal parse_skip_if_current
	li $t6, 2
	j parse_save_operator
parse_minus_operand:
	xori $t0, $t0, 1
	j parse_increase
parse_mul:
	jal parse_skip_if_current
	li $t6, 3
	j parse_save_operator
parse_div:
	jal parse_skip_if_current
	li $t6, 4
	j parse_save_operator
parse_open:
	jal parse_skip_if_current
	li $t6, 5
	j parse_save_operator
parse_close:
	jal parse_skip_if_current
	li $t6, 6
	j parse_save_operator
parse_save_operator:
	sll $t7, $s2, 2
	add $t7, $t7, $s0
	sw $t6, ($t7) 	# store data[s2]
	sll $t7, $s2, 2
	add $t7, $t7, $s1
	li $t6, 1 	# store isOp[s2] = true
	sw $t6, ($t7)
	addi $s2, $s2, 1 # increase s2
	li $t0, 0  # is negative = false
	li $t1, 0  # should be operator = false
	j parse_increase
parse_increase:
	addi $t5, $t5, 1
parse_condition:
	bne $t5, $t3, parse_loop
	jal parse_skip_if_current
	load_all_t
	j exit
parse_skip_if_current:
	beqz $t4, parse_skip_return
	addi $s2, $s2, 1
	li $t4, 0 # current = 0
	li $t0, 0  # is negative = false
parse_skip_return:
	jr $ra
exit:
.end_macro


# get_one_line, length in v0
.macro get_one_line(%data, %newline, %length)
.text
	store_all_s
	store_all_t 
	la $s0, (%data)
	la $s1, (%newline)
	la $s2, (%length)
	li $t7, 10  # new line ascii
	li $v0, 0 
	j gol_condition
gol_loop:
	add $t2, $s1, $v0
	sb $t1, 0($t2)
	addi $v0, $v0, 1
gol_condition:
	beq $v0, $s2, gol_end_file
	add $t1, $v0, $s0
	lb $t1, 0($t1) 
	bne $t1, $t7, gol_loop
	load_all_t
	load_all_s
	j gol_exit
gol_end_file:
	li $v0, -1
gol_exit:
.end_macro


# read file, length in V0
.macro read_file (%address, %filename)
.data 
file: .asciiz %filename	# file = %filename
.text
# open file
	li $v0, 13
	la $a0, file
	li $a1, 0
	li $a2, 0
	syscall
	move $s0, $v0  
# read file
	li $v0, 14     
	move $a0, $s0        
	la $a1, (%address)       
	li $a2, 1024         
	syscall    
	addi $sp, $sp, -4 # store v0 for return length
	sw $v0, 0($sp)        
# close file
	li   $v0, 16       
	move $a0, $s0      
	syscall
	lw $v0, 0($sp)
	addi $sp, $sp, 4
.end_macro

# test read
.macro test_read
.data
	file_loc: .asciiz "testread.txt" 
	buffer: .space 1024 #buffer of 1024

.text
main:
	jal openFile

openFile:
	#Open file for for reading purposes
	li $v0, 13          #syscall 13 - open file
	la $a0, file_loc    #passing in file name
	li $a1, 0               #set to read mode
	li $a2, 0               #mode is ignored
	syscall
	move $s0, $v0           #else save the file descriptor

	#Read input from file
	li $v0, 14          #syscall 14 - read filea
	move $a0, $s0           #sets $a0 to file descriptor
	la $a1, buffer          #stores read info into buffer
	li $a2, 1024            #hardcoded size of buffer
	syscall             
	
	move $a0, $v0
	li $v0, 1
	syscall 
	li $v0, 4
	la $a0, buffer
	syscall

	#Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file


.end_macro
