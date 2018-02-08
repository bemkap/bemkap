sum:
	mov $0,%r0
	add $4,%sp
	lw %sp,%r2
	add $4,%sp
	lw %sp,%r1
	sub $8,%sp
loop:	
	lw %r1,%r3
	add %r3,%r0
	add $4,%r1
	sub $1,%r2
	cmp %r2,$0
	jmpl loop
	print %r0
	ret
main:
	sw $4,$0
	sw $5,$4
	sw $6,$8
	sw $7,$12
	push $0
	push $4
	call sum
	hlt
