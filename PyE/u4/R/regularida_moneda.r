#Ejemplo 1
# qué es la regularidad estadística?

#Vector con posibles valores de la moneda
cara<-c(0,1)
#Preparar el vector con la cantidad de lanzamientos
x <- seq(10,90,10)
lanzamientos <- c(x,10*x,100*x,10000)
frec_relativa<-vector(mode="numeric", length(lanzamientos))
puntos <- cbind(lanzamientos,frec_relativa)

#Lanzar la moneda y calcular la media para cada caso
for (i in 1:length(lanzamientos))
  puntos [i,2] <-(mean (sample(cara,puntos[i,1], replace=T)))

puntos
pdf(file="regMoneda.pdf",width=6,height=6) #Avisa que quiero generar un gráfico en formato pdf
#Graficar las frecuencias relativas
plot(puntos,ylab="frecuencias relativas")
#Agregar recta horizonal en 0.5
abline(0.5,0)
dev.off() #Guarda el gráfico en el directorio que retorna getwd()



