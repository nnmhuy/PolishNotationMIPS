
# convert inter to ascii array
.macro i_to_a (%x, %address)
.text
	la $a0, (%x)
	la $a1, (%address)

iToA:
	bnez $a0, iToA.non_zero  # first, handle the special case of a value of zero
  	li   $t0, '0'
  	sb   $t0, 0($a1)
  	sb   $zero, 1($a1)
  	li   $v0, 1
  	j exit
iToA.non_zero:
	addi $sp, $sp, -16
  	sw   $a0, 0($sp)
  	sw   $a1, 4($sp)
  	sw   $s0, 8($sp)
  	sw   $s1, 12($sp)
  	
  	addi $t0, $zero, 10    
  	li $v0, 0
  	bgtz $a0, iToA.goToRecurse  # now check for a negative value
  	li   $t1, '-'
  	sb   $t1, 0($a1)
  	addi $v0, $v0, 1
  	neg  $a0, $a0
iToA.goToRecurse:
	jal iToA.recurse
	j iToA.exit
iToA.recurse:
	
	addi $sp, $sp, -8 
	sw $ra, 0($sp) 
  	div  $a0, $t0       # $a0/10
  	mflo $s0            # $s0 = quotient
  	mfhi $s1            # s1 = remainder  
  	sw $s1, 4($sp) # store remainder
iToA.write:
	
	bnez $s0, recursion
get_result:
	lw $ra, 0($sp) 
	lw $s1, 4($sp) # get remainder
	addi $sp, $sp, 8 
  	add  $t1, $a1, $v0
  	addi $v0, $v0, 1    
  	addi $t2, $s1, 0x30 # convert to ASCII
  	sb   $t2, 0($t1)    # store in the buffer
  	jr $ra
recursion:
	move $a0, $s0
	jal iToA.recurse
	j get_result
  
iToA.exit:
  	lw   $a0, 0($sp)
  	lw   $a1, 4($sp)
  	lw   $s0, 8($sp)
  	lw   $s1, 12($sp)  
  	addi $sp, $sp, 16
exit:
.end_macro
