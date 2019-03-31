# arithmetic.asm
# register used:
#	$t0	- hold the first number
#	$t1	- hold the second number
#	%v0	- syscall parameter

	.data
str1:	.asciiz	"\nNhap so thu nhat: "
str2:	.asciiz	"\nNhap so thu hai: "
str3:	.asciiz	"\nTong: "
str4:	.asciiz	"\nHieu: "
str5:	.asciiz	"\nTich: "
str6:	.asciiz	"\nThuong: "
str7:	.asciiz	" du "

	.text
main:
	# get number 1, put into $t0
	la		$a0, str1
	addi	$v0, $zero, 4
	syscall
	addi	$v0, $zero, 5
	syscall
	move $t0, $v0

	# get number 2, put into $t1
	la		$a0, str2
	addi	$v0, $zero, 4
	syscall
	addi	$v0, $zero, 5
	syscall
	move $t1, $v0

	# tinh tong
	la		$a0, str3
	addi	$v0, $zero, 4
	syscall

	add		$a0, $t0, $t1
	addi	$v0, $zero, 1
	syscall

	# tinh hieu
	la		$a0, str4
	addi	$v0, $zero, 4
	syscall

	sub		$a0, $t0, $t1
	addi	$v0, $zero, 1
	syscall

	# tinh tich
	la		$a0, str5
	addi	$v0, $zero, 4
	syscall

	mult	$t0, $t1
	mflo	$a0
	addi	$v0, $zero, 1
	syscall

	# tinh thuong
	la		$a0, str6
	addi	$v0, $zero, 4
	syscall

	div		$t0, $t1
	# xuat phan thuong
	mflo	$a0
	addi	$v0, $zero, 1
	syscall

	la		$a0, str7
	addi	$v0, $zero, 4
	syscall
	# xuat phan du
	mfhi	$a0		# xuat phan du
	addi	$v0, $zero, 1
	syscall

	addi	$v0, $zero, 10
	syscall

# end of add.asm
