# chuong trinh C++
# void main(){
#	int a, b;
#	cin >> a;
#	cin >> b;
#	cout << TinhTong(a,b);
#}
# int TinhTong(int a, int b){
#	return a+b;
#}
.data
	tb1: .asciiz "Nhap a: "
	tb2: .asciiz "Nhap b: "
	tb3: .asciiz "Tong a+b: "
.text
main:
	la $a0, tb1
	addi $v0, $0, 4
	syscall
	
	addi $v0, $0, 5
	syscall
	add $t0, $0, $v0

	la $a0, tb2
	addi $v0, $0, 4
	syscall
	
	addi $v0, $0, 5
	syscall
	add $t1, $0, $v0
	
	add $a0, $0, $t0
	add $a1, $0, $t1

	# goi thu tuc TinhTong	
	jal TinhTong

	# Xuat ket qua ra man hinh
	add $t3, $0, $v0 # luu ket qua thu tuc vao #t3
	
	la $a0, tb3
	addi $v0, $0, 4
	syscall

	add $a0, $0, $t3
	addi $v0, $0, 1	
	syscall

	addi $v0, $0, 10
	syscall	

# Khai bao thu tuc TinhTong	
TinhTong:
	# Dau thu tuc TinhTong
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t1, 4($sp)
	sw $t0, 0($sp)

	add $a0, $0, $t0
	addi $v0, $0, 1	
	syscall
	
	add $a0, $0, $t1
	addi $v0, $0, 1	
	syscall
	
	# Than thu tuc TinhTong
	# Tinh tong a+b va tra ket qua ve
	add $v0, $t0, $t1

	# Cuoi thu tuc TinhTong
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
