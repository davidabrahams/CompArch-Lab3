xori $t0, $zero, 4
xori $t1, $zero, 8

jal DONE

xori $t0, $zero, 34
xori $t1, $zero, 23

DONE:
jr $ra