serv: serv.o state.o util.o const.h
	gcc -o serv serv.o state.o util.o const.h -pthread

serv.o: serv.c
	gcc -c serv.c

state.o: state.c state.h
	gcc -c state.c

util.o: util.c util.h
	gcc -c util.c

.clean:
	rm -f util.o state.o serv.o serv
