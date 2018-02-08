main:
	mov $0,%r0
	read %r1
loop:
	mov %r1,%r2
	sub $1,%r2
	and %r2,%r1
	add $1,%r0
	cmp %r1,$0
	jmpl loop
	print %r0
	hlt
