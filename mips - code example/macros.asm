.macro print_int (%x)
	addi $sp, $sp, -8
  	sw   $a0, 0($sp)
  	sw   $v0, 4($sp)
	li $v0, 1
	lw $a0, %x
	#add $a0, $zero, %x
	syscall
  	lw   $a0, 0($sp)
  	lw   $v0, 4($sp)
  	addi $sp, $sp, 8
.end_macro
	
.macro print_str (%str)
	.data
myLabel: .asciiz %str
	.text
	li $v0, 4
	la $a0, myLabel
	syscall
.end_macro
	
# generic looping mechanism
.macro for (%regIterator, %from, %to, %bodyMacroName)
	add %regIterator, $zero, %from
	Loop:
	%bodyMacroName ()
	add %regIterator, %regIterator, 1
	ble %regIterator, %to, Loop
.end_macro
	
#print an integer
.macro body()
	print_int $t0
	print_str "\n"
.end_macro
			
#exit
.macro done
	li $v0,10
	syscall
.end_macro
