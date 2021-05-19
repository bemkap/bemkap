main: main.c barreras.o
	gcc -o main main.c barreras.o -pthread

barreras.o: barreras.c barreras.h
	gcc -o barreras.o -c barreras.c

clean:
	rm main barreras.o
