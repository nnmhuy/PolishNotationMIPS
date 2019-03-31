.data
	tb1:	.asciiz "Nhap so thu nhat: "
	tb2:	.asciiz "Nhap so thu hai: "
	tb3:	.asciiz "Tong hai so: "
.text
	#Xuat thong bao nhap so thu nhat
	la	$a0, tb1
	li	$v0, 4
	syscall
	#Nhap so nguyen thu nhat cho vao $t0
	li	$v0, 5
	syscall
	move	$t0, $v0
	#Xuat thong bao nhap so thu hai
	la	$a0, tb2
	li	$v0, 4
	syscall
	#Nhap so nguyen thu hai cho vao $t1
	li	$v0, 5
	syscall
	move	$t1, $v0
	#Cong hai so
	add	$t2,$t0,$t1
	#Xuat thong bao ket qua
	la	$a0, tb3
	li	$v0, 4
	syscall	
	#Xuat tong tren $t2
	move	$a0, $t2
	li	$v0, 1
	syscall
	#thoat chuong trinh
	li	$v0, 10
	syscall
	