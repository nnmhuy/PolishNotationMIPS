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