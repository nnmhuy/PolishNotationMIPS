# larger.asm
# print the larger number of 2 numbers
# $t0	- the first number
# $t1	- the second number

	.data
str1:	.asciiz "\nNhap so thu nhat: "
str2:	.asciiz "\nNhap so thu hai: "
str3:	.asciiz "\nSo lon hon la: "
str4:	.asciiz "\nHai so bang nhau: "

	.text
main:
	# nhap so thu nhat
	la		$a0, str1
	addi	$v0, $zero, 4
	syscall

	addi	$v0, $zero, 5
	syscall
	add		$t0, $zero, $v0
	
	# nhap so thu hai
	la		$a0, str2
	addi	$v0, $zero, 4
	syscall

	addi	$v0, $zero, 5
	syscall
	add		$t1, $zero, $v0

	# so sanh hai so
	beq		$t0, $t1, Equal	# t1 = t2
	sub		$t2, $t0, $t1
	bgtz	$t2, Larger		# if $t0 > $t1
	add		$t3, $zero, $t1	# else $t3 = $t1
	j		PrintResult

Equal:
	la		$a0, str4
	addi	$v0, $zero, 4
	syscall
	j		Exit

Larger:
	add		$t3, $zero, $t0	# $t3 = $t0

PrintResult:
	la		$a0, str3
	addi	$v0, $zero, 4
	syscall

	add		$a0, $t3, $zero
	addi	$v0, $zero, 1
	syscall

Exit:
	addi	$v0, $zero, 10
	syscall
