main:	
	read %r0
	cmp %r0,$0
	jmpl prnt
	mul $-1,%r0
prnt:
	print %r0
	hlt
