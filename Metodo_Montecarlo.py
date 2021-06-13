# -*- coding: utf-8 -*-
"""
Created on Sat Jun 12 17:11:50 2021

@author: HP
"""

import numpy as np # se importa esta libreria para poder utilizar la funcion hiperbolico y logaritmo.
import matplotlib.pyplot as plt
from numpy.random import uniform as unif # esta libreria me va ayudar generar los numeros aleatorios 

cant_num=10000 #cantidad de numeros aleatorios que generamos decimos que la corrida sea diez 

# estas dos lineas solo son para graficar 
c=np.linspace(0.0001,3.2)
f=1/(1+np.sinh(2*c)*(np.log(c))**2)

# aqui genero numeros aleatorios especificamente en este intervalo
lim_inf=0.8 #limite del intervalo inferior 
lim_sup=3 # limite del intervalo superior 
x=unif(lim_inf,lim_sup,cant_num) # genera un arreglo de numeros que va empezar de 0.8 y termina en 3 y va tener cantidad de numeros aleatorios

suma=0 #inicilaizamos la variable de la sumatoria 

for j in range(cant_num): # ciclo for que irà aumentando el contador hasta llegar al rango que le propusimos realizar de la cantidad de numeros aleatorios 
    suma=suma+1/(1+np.sinh(2*x[j])*(np.log(x[j]))**2) # aqui se irà evaluando diferentes nùmeros aleatorios que se va generando al mismo tiempo que se ira almacenando en suma
resultado=(lim_sup-lim_inf)*suma/cant_num # formula para calcular la funcion 

plt.xlabel("x")
plt.ylabel("y")
plt.plot(c,f)
plt.hist(x,density=True)

print("El resultado aproximado de la integral es:") # se manda un mensaje 
print(resultado) # se imprime el resultado.
