# array.asm
# nhap va xuat mang mot chieu cac so nguyen
# cac thanh ghi su dung:
#	$t0:	so luong phan tu n
#	$t1:	chi so mang
#	$a1:	dia chi co so (base address) cua mang

	.data
input1:	.asciiz	"Nhap n: "
input2:	.asciiz	"[ "
input3:	.asciiz	" ] = "
output:	.asciiz	"\nMang da nhap: "
array:	.word	0:100		# int array[100]

	.text
main:
	# nhap n
	la		$a0, input1
	addi	$v0, $zero, 4
	syscall

	addi	$v0, $zero, 5
	syscall
	addi	$t0, $v0, 0

	# khoi tao
	addi	$t1, $zero, 0
	la		$a1, array

NhapMang:
	# kiem tra so lan lap
	subu	$t2, $t1, $t0
	bgez	$t2, KetThucNhap

	# xuat dau nhac nhap
	la		$a0, input2
	addi	$v0, $zero, 4
	syscall

	addi	$a0, $t1, 0
	addi	$v0, $zero, 1
	syscall

	la		$a0, input3
	addi	$v0, $zero, 4
	syscall

	# nhap so nguyen va luu vao array[i]
	addi	$v0, $zero, 5
	syscall
	sw		$v0, ($a1)

	# tang chi so
	addi	$t1, $t1, 1
	addi	$a1, $a1, 4

	j		NhapMang

KetThucNhap:
	la		$a0, output
	addi	$v0, $zero, 4
	syscall

	# khoi tao
	la		$a1, array
	addi	$t1, $zero, 0

XuatMang:
	# kiem tra so lan lap
	subu	$t2, $t1, $t0
	bgez	$t2, KetThucXuat

	# xuat phan tu array[i]
	lw		$a0, ($a1)
	addi	$v0, $zero, 1
	syscall

	# xuat khoang trang
	addi	$a0, $zero, 0x20
	addi	$v0, $zero, 11
	syscall

	# tang chi so
	addi	$t1, $t1, 1
	addi	$a1, $a1, 4

	j		XuatMang

KetThucXuat:
	addi	$v0, $zero, 10
	syscall
