# upperToLower.asm
# input a lower character, output uppercase format

	.data
inStr:	.asciiz "\nNhap chuoi: "
outStr:	.asciiz "\nKy chuoi in hoa: "
in_String: .space 100
	
	.text
main:
	la	$a0, inStr
	addi	$v0, $zero, 4
	syscall

	# nhap chuoi va luu vao in_String
	la	$a0, in_String
	addi	$a1, $zero, 100
	addi	$v0, $zero, 8
	syscall

	la $t0, in_String
	li $t1, 100
	li $t2, 0
Loop:
	# chuyen sang in hoa
	ble $t1, $t2, Out_Loop
	
	lb $t3, ($t0)
	subi	$a0, $t3, 32	
	addi	$v0, $zero, 11
	syscall
	
	addi $t2, $t2, 1
	addi $t0, $t0, 1
	j Loop

Out_Loop:
	addi	$v0, $zero, 10
	syscall