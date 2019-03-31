# char.asm
# input a character, print out the next char and the previous char

	.data
inStr:		.asciiz "\nNhap mot ky tu: "
outStr1:	.asciiz "\nKy tu lien truoc: "
outStr2:	.asciiz "\nKy tu lien sau: "
	
	.text
main:
	la		$a0, inStr
	addi	$v0, $zero, 4
	syscall

	# nhap ky tu
	addi	$v0, $zero, 12
	syscall
	addu $t0, $zero, $v0	#move	$t0, $v0
	
	la		$a0, outStr1
	addi	$v0, $zero, 4
	syscall

	# tinh ky tu lien truoc va xuat
	addi	$a0, $t0, -1
	addi	$v0, $zero, 11
	syscall

	la		$a0, outStr2
	addi	$v0, $zero, 4
	syscall

	# tinh ky tu lien truoc va xuat
	addi	$a0, $t0, 1
	addi	$v0, $zero, 11
	syscall
	
	addi	$v0, $zero, 10
	syscall
