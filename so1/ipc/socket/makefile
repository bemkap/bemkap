dgram: cli_echo_dgram.c srv_echo_dgram.c crear_socket_nombrado.o
	gcc -o cliente cli_echo_dgram.c crear_socket_nombrado.o -pthread
	gcc -o servidor srv_echo_dgram.c crear_socket_nombrado.o -pthread

stream: cli_echo_stream.c srv_echo_stream.c crear_socket_nombrado.o
	gcc -o cliente cli_echo_stream.c crear_socket_nombrado.o -pthread
	gcc -o servidor srv_echo_stream.c crear_socket_nombrado.o -pthread

crear_socket_nombrado.o: crear_socket_nombrado.c
	gcc -c crear_socket_nombrado.c
	
clean:
	rm -f crear_socket_nombrado.o cliente servidor
