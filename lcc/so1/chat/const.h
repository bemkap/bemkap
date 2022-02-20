#ifndef CONST_H
#define CONST_H

//constantes de cantidades maximas
const int CLIMAX=100; //de clientes
const int MSGMAX=1024; //de longitud de mensaje
const int NAMMAX=32; //de longitud de nickname
const int CMDMAX=10; //de comando
const int BUFMAX=MSGMAX+NAMMAX+CMDMAX+2; //de buffer(todas las anteriores mas 2 espacios)
//mensajes de servidor
const char MSGOK []="srv:ok";
const char MSGERR[]="srv:err";
const char MSGBYE[]="srv:bye";
//prompt
const char PROMPT[]="   ";

#endif
