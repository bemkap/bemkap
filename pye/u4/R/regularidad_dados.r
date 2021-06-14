#Ejemplo 2
#Tirada de un dado regular  y observar la frecuencia relativa de aparición de
# cada cara

#Vector con posibles valores del dado
cara_dado<-c(1,2,3,4,5,6)
#Preparar el vector con la cantidad de lanzamientos
x<-seq(10,90,10)
lanzamientos<-c(10*x,100*x,10000)
frec1<-vector(mode="numeric",length(lanzamientos))
frec2<-vector(mode="numeric",length(lanzamientos))
frec3<-vector(mode="numeric",length(lanzamientos))
frec4<-vector(mode="numeric",length(lanzamientos))
frec5<-vector(mode="numeric",length(lanzamientos))
frec6<-vector(mode="numeric",length(lanzamientos))
puntos<-cbind(lanzamientos,frec1,frec2,frec3,frec4,frec5,frec6)

#Lanzar el dado y calcular la frecuencia absoluta en cada caso
for(i in 1:length(lanzamientos))
  puntos[i,2:7]<-table(sample(cara_dado,puntos[i,1],replace=T))

puntos

#Calcular la frecuencia relativa, dividiendo por la cantidad de lanzamientos hechos en cada caso
for(i in 1:length(lanzamientos))
  puntos[i,2:7]<-puntos[i,2:7]/puntos[i,1]

puntos

par(mfrow=c(2,3))

#Graficar las frecuencias relativas para cada cara del dado, según la cantidad de lanzamientos hechos
for(i in 2:7){
  pdf(file=paste("regDados",i-1,".pdf"),width=6,height=6)#Avisa que quiero generar un gráfico en formato pdf
  plot(puntos[,1],puntos[,i],xlab="lanzamientos",ylab="frecuencias relativas")
  abline(0.16666,0)
  dev.off() #Guarda el gráfico en el directorio que retorna getwd()
  }


