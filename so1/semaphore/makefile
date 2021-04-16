main: main.c semaphore.o
	gcc -o main main.c semaphore.o -pthread

semaphore.o:
	gcc -o semaphore.o -c semaphore.c

clean:
	rm semaphore.o main
