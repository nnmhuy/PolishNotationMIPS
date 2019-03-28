# [BUG]
# pass in x and filename, print x to file
.macro print_int_file(%x, %filename)	
.data
	file: .asciiz %filename	# file = %filename
	value: .word x	# value = passed x
.text 
	fileopen:
		li $v0, 13	# $v0 = 13
		la $a0, file	# $a0 = file
		li $a1, 1	# $a1 = 1
		li $a2, 0	# $a2 = 0
		syscall		# call open file
	filewrite:
		move $a0, $v0	# load file description $a0
		li $v0, 15	# $v0 = 15
		la $a1, value	# load address of value to $a1
		li $a2, 4	# buffer length of int (4)
		syscall
	fileclose:
		move $a0, $v0	# load file description $a0
		li $v0, 16	# $0 = 16
		syscall		# call close file
.end_macro 


.macro test_write
.data
str_exit: .asciiz "test.txt"
str_data: .asciiz "This is a test!"
str_data_end:

.text

file_open:
    li $v0, 13
    la $a0, str_exit
    li $a1, 1
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
file_write:
    move $a0, $v0  # Syscall 15 requieres file descriptor in $a0
    li $v0, 15
    la $a1, str_data
    la $a2, str_data_end
    la $a3, str_data
    subu $a2, $a2, $a3  # computes the length of the string, this is really a constant
    syscall
file_close:
    li $v0, 16  # $a0 already has the file descriptor
    syscall
.end_macro 
