.include "output.asm"

.data
	x: .word 32
.text
	la $t0, x
	print_int_file $t0 "abc.txt"