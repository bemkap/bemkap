        .text
_main:
        la      $a0, string_space
        li      $a1, 1024
        li      $v0, 8
        syscall
        la      $t1, string_space
        la      $t2, string_space
length:
        lb      $t3, ($t2)
        beqz    $t3, end_length
        addu    $t2, $t2, 1
        b       length
end_length:
        subu    $t2, $t2, 2
test:
        bge     $t1, $t2, ispal
        lb      $t3, ($t1)
        lb      $t4, ($t2)
        bne     $t3, $t4, isntpal
        addu    $t1, $t1, 1
        subu    $t2, $t2, 1
        b       test
ispal:
isntpal:
        li      $v0, 10
        syscall

        .data
string_space:   .space 1024
