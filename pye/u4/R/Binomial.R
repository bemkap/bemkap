#Binomial
n=100
p=0.01
dbinom(0,n,p) # Es la probabilidad de tener 0 bits erroneos
dbinom(1,n,p) # Es la probabilidad de tener 1 bits erroneos

#Podemos escribir todas las probabilidades obtenidas a partir de la funcion dbinom:
for (i in 0:100) 
  cat(i,"\t",dbinom(i,n,p),"\n")

# Gráfico de la función de probabilidad mediante:
par(mfrow=c(1,2))
x<-c(0:100)
plot(x,dbinom(x,n,p),xlab="Bits erroneos",ylab="probabilidad",type="h",xlim=c(0,20))


# Funcion de distribución de probabilidad de una B(100,0.01)
for (i in 0:100) 
  cat(i,"\t",pbinom(i,n,p),"\n")

plot(pbinom(0:100,n,p),xlab="Bits erroneos",type="S")

#Generar aleatoriamente valores de una binomial
num.paq=100
bits.err=rbinom(num.paq,n,p)
frec.abs=table(bits.err) # Corresponde a las frecuencias absolutas
frec.rel=frec.abs/num.paq # Corresponde a las frecuencias relativas

par(mfrow=c(2,2))

plot(frec.rel,col="lightblue",ylab="Frecuencias relativas",
        main="numero de bits erroneos n.paq=100",cex.main=0.8,ylim=c(0,0.4))

#Vemos que ocurre cuando el numero de intentos va creciendo:
num.paq=1000
bits.err=rbinom(num.paq,n,p)
frec.abs=table(bits.err) # Corresponde a las frecuencias absolutas
frec.rel=frec.abs/num.paq # Corresponde a las frecuencias relativas
plot(frec.rel,col="lightblue",ylab="Frecuencias relativas",
     main="numero de bits erroneos n.paq=1000",cex.main=0.8,xlim=c(0,5),ylim=c(0,0.4))
num.paq=10000
bits.err=rbinom(num.paq,n,p)
frec.abs=table(bits.err) # Corresponde a las frecuencias absolutas
frec.rel=frec.abs/num.paq # Corresponde a las frecuencias relativas
plot(frec.rel,col="lightblue",ylab="Frecuencias relativas",
     main="numero de bits erroneos n.paq=10000",cex.main=0.8,xlim=c(0,5),ylim=c(0,0.4))
num.paq=100000
bits.err=rbinom(num.paq,n,p)
frec.abs=table(bits.err) # Corresponde a las frecuencias absolutas
frec.rel=frec.abs/num.paq # Corresponde a las frecuencias relativas
plot(frec.rel,col="lightblue",ylab="Frecuencias relativas",
          main="numero de bits erroneos n.paq=100000",cex.main=0.8,xlim=c(0,5),ylim=c(0,0.4))


#Podemos comparar las frecuencias relativas con los valores teoricos
x<-c(0:10)
plot(x,dbinom(0:10,n,p),type="h",col="blue",xlab="Bits erróneos",cex.main=0.8,xlim=c(0,5),
     ylab="Probabilidad",ylim=c(0,0.4),main="Valores teóricos")


