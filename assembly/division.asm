add $a0, $zero, 2
add $a1, $zero, 5
add $t2, $zero, $zero
add $t0, $zero, $a0

LOOP_START:

    slt $t1, $t0, $a1
    bne $t1, 0, LOOP_END

    sub $t0, $t0, $a1
    add $t2, $t2, 1

j LOOP_START


LOOP_END:

add $v0, $t2, $zero
add $v1, $t0, $zero

