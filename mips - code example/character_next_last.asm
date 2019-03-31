.data
	tb1:	.asciiz "Nhap ky tu: "
	tb2:	.asciiz "\nKy tu lien truoc: "
	tb3:	.asciiz "\nKy tu lien sau: "
.text
main:
	#Xuat thong bao nhap
	la	$a0, tb1
	li	$v0, 4
	syscall
	#Nhap ky tu cho vao $t0
	li	$v0, 12
	syscall
	move	$t0, $v0
	#Ky tu lien truoc
	addi	$t1, $t0, -1
	#Xuat thong bao ky tu lien truoc
	la	$a0, tb2
	li	$v0, 4
	syscall
	#Xuat ky tu
	move	$a0, $t1
	li	$v0, 11
	syscall
	#Ky tu lien sau
	addi	$t2, $t0, 1
	#Xuat thong bao ky tu lien sau
	la	$a0, tb3
	li	$v0, 4
	syscall
	#Xuat ky tu
	move	$a0, $t2
	li	$v0, 11
	syscall
	#thoat chuong trinh
	li	$v0, 10
	syscall
	
