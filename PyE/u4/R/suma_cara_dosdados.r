# Experiencia: se tiran dos dados y se observan los números de la caras visibles
# Se define la Variable aleatoria X:suma de los núeros de la caras visibles

x<-c(1,2,3,4,5,6)
dado1<-sample(x,1000,replace=T)
dado2<-sample(x,1000,replace=T)
suma<-vector(mode="numeric",1000)


tirada<-cbind(dado1,dado2,suma)

for (i in 1:1000)
tirada[i,3]<-sum(tirada[i,1]+tirada[i,2])
frec_abs<-table( tirada[,3])
frec_rel<-prop.table(frec_abs)

plot (frec_rel, ylab="frecuencias relativas",xlab="suma de caras")


#OTra forma#suma cara de dados
t<-sapply(1:10000, function(x){sum(sample(1:6,2,rep=T))})
plot(prop.table(table(t)))
