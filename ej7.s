        .text
        .globl main
main:
        li   $a0, 8
        li   $a1, 0
        li   $a2, 1
        jal  fib
        move $a0, $v0
	li   $v0, 10
	syscall

fib:
	beq  $a0, 0, fib_base_0
	beq  $a0, 1, fib_base_1
	addi $a0, $a0, -1
	move $t1, $a1
	move $a1, $a2
	add  $a2, $a2, $t1
        j    fib
fib_base_0:
	move $v0, $a1
	j    fib_ret
fib_base_1:
        move $v0, $a2
fib_ret:
        jr   $ra
