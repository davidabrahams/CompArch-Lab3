xori $t0, $zero, 4
xori $t1, $zero, 8

lw $t0, one

DONE:
j DONE

.data
	one: .word 1