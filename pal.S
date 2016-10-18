        .text
main:
        la      $t1, string_space
        la      $t2, string_space
length:
        lb      $t3, ($t2)
        beqz    $t3, end_length
        addu    $t2, $t2, 1
        b       length
end_length:
        subu    $t2, $t2, 1
	lb	$t3, ($t2)
	bne	$t3, '\n', test
	subu	$t2, $t2, 1
test:
        bge     $t1, $t2, ispal
        lb      $t3, ($t1)
        lb      $t4, ($t2)
        bne     $t3, $t4, isntpal
inca:	
        addu    $t1, $t1, 1
	lb	$t3, ($t1)
	slti	$t4, $t3, 48
	li      $t5, 31
	slt	$t5, $t5, $t3
	and	$t4, $t4, $t5
	bnez	$t4, inca
decb:	
        subu    $t2, $t2, 1
	lb	$t3, ($t2)
	slti	$t4, $t3, 48
	li      $t5, 31
	slt	$t5, $t5, $t3
	and	$t4, $t4, $t5
	bnez	$t4, decb
        b       test
ispal:
	la	$a0, string_ispal
	li	$v0, 4
	syscall
isntpal:
        li      $v0, 10
        syscall

        .data
string_space:	.asciiz "pallap"
string_ispal:	.asciiz "ispal"
