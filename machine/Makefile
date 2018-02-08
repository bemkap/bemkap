machine: lex.yy.c parser.tab.c parser.tab.h machine.c machine.h	
	gcc *.c -g -ggdb -o machine

lex.yy.c: parser.lex
	flex parser.lex

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

.PHONY: clean
clean:
	rm -f machine lex.yy.c parser.tab.c parser.tab.h
