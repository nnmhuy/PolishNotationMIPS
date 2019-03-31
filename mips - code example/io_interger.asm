.data
	n: .word 0
.text
main:
	addi $v0, $0, 5
	syscall
	sw $v0, n

	lw $a0, n
	addi $v0, $0, 1
	sycall

	addi $v0, $0, 10
	syscall