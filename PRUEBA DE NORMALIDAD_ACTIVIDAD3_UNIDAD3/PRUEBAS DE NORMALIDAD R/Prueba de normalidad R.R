luz = read.table("./light.txt", header=T)
luz
names(luz) = "velocidad"
luz

#Comprobar la normalidad de los datos con pruebas estad�sticas:

shapiro.test(luz$velocidad)

#Kolmogorov-Smirnov ... no hay que usarla por ser poco confiable (Steinskog et al., 2007; Pedrosa et al., 2015)
ks.test(luz$velocidad,"pnorm",mean(luz$velocidad),sd(luz$velocidad))
#Crawley (2013)

##Usar K-S con correcci�n de Lilliefors en lugar de K-S (Razali & Wah, 2011; Pedrosa et al., 2015):
install.packages("nortest")
library("nortest")
lillie.test(luz$velocidad)

#Otras pruebas de normalidad (ver Yap & Sim, 2011 y librer�a "nortest"):
#Anderson-Darling
ad.test(luz$velocidad)
#Cramer-von Mises
cvm.test(luz$velocidad)
#Chi cuadrada de Pearson
pearson.test(luz$velocidad)
#Shapiro-Francia
sf.test(luz$velocidad)

#Comprobar normalidad con gr�ficas:

#Histograma:
hist(luz$velocidad)

#Gr�fico cuantil-cuantil (Crawley, 2014):
qqnorm(luz$velocidad)
qqline(luz$velocidad)
#Si nuestros datos de inter�s (puntos) est�n alineados con la l�nea graficada, quiere decir que tienen una distribuci�n normal. Si por el contrario, observamos que se acomodan en forma de "S" o de pl�tano (curva o en "U"), no son normales. Para m�s informaci�n consulta Crawley (2013,2014). 

#Gr�fico para probar normalidad de Crawley (2013):
crawley.plot <- function(y) {
  s <- sd(y)
  plot(c(0,3),
       c(min(y,mean(y)-s*4*qnorm(0.75)),max(y,mean(y)+s*4*qnorm(0.75))),
       xaxt="n",
       xlab="",
       type="n",
       ylab="")
  # for your data's boxes and whiskers, centred at x = 1
  top <- quantile(y,0.75)
  bottom <- quantile(y,0.25)
  w1u <- quantile(y,0.91)
  w2u <- quantile(y,0.98)
  w1d <- quantile(y,0.09)
  w2d <- quantile(y,0.02)
  rect(0.8,bottom,1.2,top)
  lines(c(0.8,1.2),c(mean(y),mean(y)),lty=3)
  lines(c(0.8,1.2),c(median(y),median(y)))
  lines(c(1,1),c(top,w1u))
  lines(c(0.9,1.1),c(w1u,w1u))
  lines(c(1,1),c(w2u,w1u),lty=3)
  lines(c(0.9,1.1),c(w2u,w2u),lty=3)
  nou <- length(y[y>w2u])
  points(rep(1,nou),jitter(y[y>w2u]))
  lines(c(1,1),c(bottom,w1d))
  lines(c(0.9,1.1),c(w1d,w1d))
  lines(c(1,1),c(w2d,w1d),lty=3)
  lines(c(0.9,1.1),c(w2d,w2d),lty=3)
  nod <- length(y[y<w2d])
  points(rep(1,nod),jitter(y[y<w2d]))
  #for the normal box and whiskers, centred at x = 2
  n75 <- mean(y)+ s * qnorm(0.75)
  n25 <- mean(y)- s * qnorm(0.75)
  n91 <- mean(y)+ s * 2* qnorm(0.75)
  n98 <- mean(y)+ s * 3* qnorm(0.75)
  n9 <- mean(y)- s * 2* qnorm(0.75)
  n2 <- mean(y)- s * 3* qnorm(0.75)
  rect(1.8,n25,2.2,n75)
  lines(c(1.8,2.2),c(mean(y),mean(y)),lty=3)
  lines(c(2,2),c(n75,n91))
  lines(c(1.9,2.1),c(n91,n91))
  lines(c(2,2),c(n98,n91),lty=3)
  lines(c(1.9,2.1),c(n98,n98),lty=3)
  lines(c(2,2),c(n25,n9))
  lines(c(1.9,2.1),c(n9,n9))
  lines(c(2,2),c(n9,n2),lty=3)
  lines(c(1.9,2.1),c(n2,n2),lty=3)
  lines(c(1.2,1.8),c(top,n75),lty=3,col="gray")
  lines(c(1.1,1.9),c(w1u,n91),lty=3,col="gray")
  lines(c(1.1,1.9),c(w2u,n98),lty=3,col="gray")
  lines(c(1.2,1.8),c(bottom,n25),lty=3,col="gray")
  lines(c(1.1,1.9),c(w1d,n9),lty=3,col="gray")
  lines(c(1.1,1.9),c(w2d,n2),lty=3,col="gray")
  # label the two boxes
  axis(1,c(1,2),c("data","normal")) }

crawley.plot(luz$velocidad)

#Si utilizamos muestras mayores a 30
peces = read.table("./fishes.txt", header=T)
peces

hist(peces$mass)

shapiro.test(peces$mass)

lillie.test(peces$mass)

ad.test(peces$mass)

#Doctor en estad�stica Ian Fellows, por parte de la universidad de California: http://blog.fellstat.com/?p=61

x = rt(1000000,df=200)

hist(x)

qqnorm(x)
qqline(x)

shapiro.test(x)

lillie.test(x)

ad.test(x)