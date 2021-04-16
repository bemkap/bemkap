main: main.c board.o game.o
	gcc -g -o main main.c game.o board.o

board.o: board.c board.h
	gcc -g -o board.o -c board.c

game.o: game.c game.h
	gcc -g -o game.o -c game.c

clean:
	rm main game.o board.o
