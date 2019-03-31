# Code C++
# void main(){
#	int x=9;
#	int y=3;
#	cout << "x^2 + y =" << SumQuare(x,y); // ket qua thu duoc la 84
# }
# int SumQuare(int x, int y){
#	return (mult(x,x) + y);
#}
# int multi(int n, int m){
#	int result = 0;
# 	for(int i = 0; i < m; i++){
#		kq = kq + n;
#	}
#	return kq;
#}

.data
	x: .word 9
	y: .word 3
	tb1: .asciiz "x^2 + y ="
.text 
main:
	la $a0, tb1
	addi $v0, $0, 4
	syscall 
	
	lw $a0, x # truyen vao ham SumQuare 2 tham so x, y
	lw $a1, y
	jal SumQuare # SumQuare(x,y)

	add $a0, $v0, $0 # luu ket qua SumQuare(x,y) vao $a0

	addi $v0, $0, 1
	syscall 
	
	addi $v0, $0, 10
	syscall 

SumQuare: # ket qua tra ve trong $v0
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $a0, 4($sp) # dua x vao stack
	sw $a1, 0($sp) # dua y vao stack
	
	add $a1, $a0, $0 # truyen vao ham multi 2 tham so x, x
	jal multi # mult(x,x)
	
	lw $t1, 0($sp) # lay gia tri y ra
	add $v0, $v0, $t1 # $v0=mult(x,x)+y

	lw $ra, 8($sp)
	addi $sp, $sp, 12 
	jr $ra
multi: # ket qua tra ve trong $v0
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	addi $t0, $0, 0
	add $v0, $0, $0
	
	loop:
		add $v0, $v0, $a0
		addi $t0, $t0, 1
		beq $t0, $a1, exitloop
		j loop
		
	exitloop:	
		lw $ra, 8($sp)
		addi $sp, $sp, 12 
		jr $ra