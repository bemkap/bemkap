        .text
        .globl main
main:
        li   $a0, 6
        jal  fib
        move $a0, $v0
	li   $v0, 10
	syscall

fib:
	andi $t1, $a0, 0xfffffffe
	beq  $t1, 0, fib_base
        addi $sp, $sp, -12
        sw   $ra, 8($sp)
        sw   $a0, 4($sp)
        addi $a0, $a0, -1
        jal  fib
        sw   $v0, ($sp)
        lw   $a0, 4($sp)
        addi $a0, $a0, -2
        jal  fib
        lw   $t1, ($sp)
        add  $v0, $v0, $t1
        lw   $ra, 8($sp)
        addi $sp, $sp, 12
        j    fib_ret
fib_base:
        move $v0, $a0
fib_ret:
        jr   $ra
