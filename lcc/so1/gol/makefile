OBJ= obj/board.o obj/game.o obj/barreras.o

simulador: src/main.c $(OBJ)
	gcc -g -o simulador src/main.c $(OBJ) -pthread

obj/board.o: src/board.c src/board.h
	gcc -g -o obj/board.o -c src/board.c

obj/game.o: src/game.c src/game.h
	gcc -g -o obj/game.o -c src/game.c

obj/barreras.o: src/barreras.c src/barreras.h
	gcc -g -o obj/barreras.o -c src/barreras.c

clean:
	rm simulador $(OBJ)
