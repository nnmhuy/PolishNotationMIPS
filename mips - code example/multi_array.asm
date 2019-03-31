# multi_array.asm
# tinh tich cua cac so nguyen trong mang
# for(int i = 0; i <= n; i++)
# 	result=result*a[i]
#
#	$a1=address array; $t1=n; $t2=i; $t3=result 
.data 
	array: .word 1,2,9,4,5,6
	n: .word 6
	
.text main:
	la $a1, array
	lw $t1, n
	li $t2, 0
	li $t3, 1
Loop:
	ble $t1, $t2, PrintResult
	
	lw $t0, ($a1)
	mult $t3, $t0
	mflo $t3
	
	addi $t2, $t2, 1
	addi $a1, $a1, 4
	
	j Loop
	
PrintResult:
	move $a0, $t3
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall