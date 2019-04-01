.include "output.asm"
.include "input.asm"
.include "calculate_postfix.asm"
.include "infix_to_postfix.asm"
.include "util.asm"

# t0 buffer
# t1 oneline
# t2 length buffer
# t3 length oneline
# t4 is prefix
.data
	trash: .space 10
	buffer: .space 1024
	line: .space 1024
	data: .word 0:100
	isOp: .word 0:100
	postfixdata: .word 0:100
	postfixisOp: .word 0:100
.text
	la $t0, buffer
	la $t1, line
	la $s0, data
	la $s1, isOp
	la $s3, postfixdata
	la $s4, postfixisOp
	store_all_s
	read_file ($t0, "input.txt")
	load_all_s	
	move $t2, $v0
	get_one_line ($t0, $t1, $t2) # get line prefix, postfix
	move $t3, $v0	
	jal skip_line
	jal check_prefix
	# create new file output
	li $t5, 0
	la $t7, trash
	print_string_new_file($t7, $t5, "result.txt")
	
	j loop_increase
loop_body:
	parse_line ($t1, $t3)
	
	
	store_all_t
	infix_to_postfix
	calculate_postfix
	load_all_t
	
	
	# print result common
	store_all_t
	print_int ($s7, "result.txt") 
	print_new_line ("result.txt")
	load_all_t
	beqz $t4, solve_post
solve_pre:
	reverse_for_prefix ($s0, $s1, $s2)
	store_all_t
	infix_to_postfix
	load_all_t
	reverse_for_prefix ($s3, $s4, $s5)
	store_all_t
	print_expression ($s3, $s4, $s5, "prefix.txt") 
	load_all_t
	j loop_increase
solve_post:
	store_all_t
	print_expression ($s3, $s4, $s5, "postfix.txt")
	load_all_t
	j loop_increase
loop_increase:
	get_one_line ($t0, $t1, $t2) # get line 
	move $t3, $v0
	jal skip_line
	
loop_condition:
	
	bgez $t3, loop_body # if not end of file => loop
	j exit
skip_line:
# skip oneline in address buffer and length
	add $t0, $t0, $t3
	addi $t0, $t0, 1
	sub $t2, $t2, $t3
	subi $t2, $t2, 1
	jr $ra 
check_prefix:
	lb $t4, 2($t1)
	li $t7, 'e'
	beq $t4, $t7, setIsPre
	li $t4, 0
	li $t5, 0
	la $t7, trash
	print_string_new_file($t7, $t5, "postfix.txt")
	jr $ra
setIsPre:
	li $t4, 1
	li $t5, 0
	la $t7, trash
	print_string_new_file($t7, $t5, "prefix.txt")
	jr $ra
exit:
	
