	.data
str:	.asciiz	"hello word"
	.text
	.globl main
main:
	la	$a0, str
	addi	$v0, $zero, 4
syscall
	addi	$v0, $zero, 10
syscall