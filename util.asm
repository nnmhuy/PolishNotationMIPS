.macro print_int (%x)
	addi $sp, $sp, -8
  	sw   $a0, 0($sp)
  	sw   $v0, 4($sp)
	li $v0, 1
	la $a0, (%x)
	#add $a0, $zero, %x
	syscall
  	lw   $a0, 0($sp)
  	lw   $v0, 4($sp)
  	addi $sp, $sp, 8
.end_macro
	