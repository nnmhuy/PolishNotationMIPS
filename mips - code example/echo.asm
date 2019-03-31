# echo.asm - print out monitor what you write
# mips code

	.data
string:		.space	100
inputStr:	.asciiz	"Nhap vao mot chuoi: "
outputStr:	.asciiz "\nChuoi da nhap: "

	.text
main:
	la	$a0, inputStr
	addi	$v0, $zero, 4
	syscall

	la	$a0, string
	addi	$a1, $zero, 100
	addi	$v0, $zero, 8
	syscall

	la	$a0, outputStr
	addi	$v0, $zero, 4
	syscall

	la	$a0, string
	addi	$v0, $zero, 4
	syscall

	addi	$v0, $zero, 10
	syscall
	