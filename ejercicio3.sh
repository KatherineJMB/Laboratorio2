#!/bin/bash 

#Guardar el directorio a monitorear en una variable 
directorio_monitorear=/home/katherinemartinez
archivo_log="$directorio_monitorear"
 
#Monitorear el directorio y enviar los datos al archivo de log
$ inotifywait -m -r ~/.$"directorio_monitorear" -e create,modify,delete  > archivo_log

# Crear el script de monitoreo
sudo nano /home/katherinemartinez/monitoreo/ejercicio3.sh
#Creacion de archivo de unidad de servicio systemd 
[Unit]
Description=Monitoreo de cambios en el directorio 
After=network.target
[Service]
Type=simple
ExecStart=/bin/bash /home/katherinemartinez/monitoreo/ejercicio3.sh
WorkingDirectory=/home/katherinemartinez/monitoreo 
[Install]
sudo 	WantedBy=multi-user.target

