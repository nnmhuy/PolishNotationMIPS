# upperToLower.asm
# input a lower character, output uppercase format

	.data
inStr:	.asciiz "\nNhap mot ky tu: "
outStr:	.asciiz "\nKy tu thuong: "
	
	.text
main:
	la	$a0, inStr
	addi	$v0, $zero, 4
	syscall

	# nhap ky tu
	addi	$v0, $zero, 12
	syscall
	addu	$t0, $zero, $v0

	la	$a0, outStr
	addi	$v0, $zero, 4
	syscall

	# chuyen sang thuong
	addi	$a0, $t0, 32
	addi	$v0, $zero, 11
	syscall

	addi	$v0, $zero, 10
	syscall