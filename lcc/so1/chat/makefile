CFLAGS= -Wall -g
CC= gcc

# all: servidor cliente

# servidor: servidor.o state.o util.o const.h
# 	gcc -o servidor servidor.o state.o util.o const.h -pthread

cliente: cliente.o state.o util.o const.h
	gcc -o cliente cliente.o state.o util.o const.h -pthread

# servidor.o: servidor.c
cliente.o: cliente.c
state.o: state.c state.h
util.o: util.c util.h

clean:
	rm -f servidor.o cliente.o state.o util.o servidor cliente
