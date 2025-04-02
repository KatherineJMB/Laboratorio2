#!/bin/bash

#Se recibe el argumento 
argumento_proceso=$1
$argumento_proceso & #Ejecutar en segundo plano
archivo_log="monitoreo_$(date +%Y%m%d_%H%M%S).log"

#Nombre respectivo de cada dato
echo "Fecha y Hora,PID,Comando,CPU (%),Memoria (%)" > "$archivo_log"

#Se guardan los datos correspondientes en el archivo 
for i in {1..10} ; do
	fecha=$(date +"%Y-%m-%d %H:%M:%S")	
	ps -p $PID -o pcpu,pmem,comm 
	"$fecha,$PID,$comando,$pcpu,$pmem" >> "$archivo_log" 
	sleep 1
done

#Hacer grafico 
cat > "$grafico_gnuplot" 
set terminal png size 800,400
set output "$GRAFICO_PNG"
set title "Monitoreo de CPU y Memoria"
set xlabel "Tiempo"
set ylabel "Porcentaje"
plot "$ARCHIVO_LOG" using 1:4 with lines title "CPU", \
     "$ARCHIVO_LOG" using 1:5 with lines title "Memoria"
gnuplot "$grafico_gnuplot"



