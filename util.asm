.macro print_int_test (%x)
.data
newline: .asciiz "\n"
.text
	addi $sp, $sp, -8
  	sw   $a0, 0($sp)
  	sw   $v0, 4($sp)
	li $v0, 1
	la $a0, (%x)
	syscall
	li $v0, 4
	la $a0, newline
	syscall
  	lw   $a0, 0($sp)
  	lw   $v0, 4($sp)
  	addi $sp, $sp, 8
.end_macro

.macro reverse_for_prefix (%data, %isOp, %length)
.text
	store_all_t
	la $t0, (%data)
	la $t1, (%isOp)
	la $t2, (%length)
	sll $t2, $t2, 2
	subi $t2, $t2, 4
	add $t3, $t0, $t2 # end of data
	add $t4, $t1, $t2 # end of isOp
	j reverse_condition
reverse_loop:
	reverse_bracket($t0, $t1)
	reverse_bracket($t3, $t4)
	lw $t5, ($t0)
	lw $t6, ($t3)
	sw $t5, ($t3)
	sw $t6, ($t0)
	addi $t0, $t0, 4
	addi $t3, $t3, -4 
	lw $t5, ($t1)
	lw $t6, ($t4)
	sw $t5, ($t4)
	sw $t6, ($t1)
	addi $t1, $t1, 4
	addi $t4, $t4, -4 
reverse_condition:
	sub $t5, $t3, $t0 # t5 = end - begin
	bgtz $t5, reverse_loop
	beqz $t5, reverse_self
	j exit
reverse_self:
	reverse_bracket ($t3, $t4)
	j exit
exit:
	load_all_t
.end_macro

.macro reverse_bracket (%positionData, %positionOp)
.text
	store_all_t
	la $t0, (%positionData)
	la $t5, (%positionOp)
	lw $t6, ($t5)
	beqz $t6, exit # if not operator => exit
	lw $t1, ($t0)
	li $t2, 5 	# (
	li $t3, 6	# )
	beq $t1, $t2, save_close 
	beq $t1, $t3, save_open
	j exit
save_close:
	sw $t3, ($t0)
	j exit
save_open:
	sw $t2, ($t0)
	j exit
exit:
	load_all_t
.end_macro

.macro store_all_s
.text
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp) 
.end_macro

.macro store_all_t
.text
	addi $sp, $sp, -32
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	sw $t6, 24($sp)
	sw $t7, 28($sp) 
.end_macro

.macro load_all_s
.text
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp) 
	addi $sp, $sp, 32
.end_macro

.macro load_all_t
.text
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	lw $t5, 20($sp)
	lw $t6, 24($sp)
	lw $t7, 28($sp) 
	addi $sp, $sp, 32
.end_macro
