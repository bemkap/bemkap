all: serv cli

serv: serv.o state.o util.o const.h
	gcc -g -o serv serv.o state.o util.o const.h -pthread

cli: cli.o state.o util.o const.h
	gcc -g -o cli cli.o state.o util.o const.h -pthread

serv.o: serv.c
	gcc -c -g serv.c

cli.o: cli.c
	gcc -c -g cli.c

state.o: state.c state.h
	gcc -c -g state.c

util.o: util.c util.h
	gcc -c -g util.c

clean:
	rm -f util.o state.o serv.o cli.o serv cli
