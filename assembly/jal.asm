xori $t0, $zero, 4
xori $t1, $zero, 8

bne $t0, $t1, DONE

DONE:
jr $ra