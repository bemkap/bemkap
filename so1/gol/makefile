main: main.c board.o game.o barreras.o
	gcc -g -o main main.c game.o board.o barreras.o -pthread

board.o: board.c board.h
	gcc -g -o board.o -c board.c

game.o: game.c game.h
	gcc -g -o game.o -c game.c

barreras.o: barreras.c barreras.h
	gcc -g -o barreras.o -c barreras.c

clean:
	rm main game.o board.o barreras.o
