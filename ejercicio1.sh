#!/bin/bash

# Verificar que sea root el usuario
if [ $(id -u) -ne "0" ] ; then
    echo "El usuario que esta intentando correr el script no es root"
    exit 1
fi

#Se guardan los parametros en variables
nombre_usuario=$1
nombre_grupo=$2
ruta_archivo=$3

# Verificar si la ruta del archivo existe o no
if [ ! -e "$ruta_archivo" ]; then
    echo "Log=El archivo '$ruta_archivo' no existe"
    exit 1
fi

# Verificar si hay un grupo con ese nombre o crearlo 
if ! grep -i "^$nombre_grupo" /etc/group  ; then
    sudo addgroup "$nombre_grupo"
    echo "Log=El grupo se agrego con exito"
else
    echo "Log=El grupo ya existe"
fi

# Verificar si existe un usuario con ese nombre y sino crearlo 
if ! id "$nombre_usuario"  &>/dev/null ; then
    sudo adduser "$nombre_usuario"
    echo "Log=El usuario ha sido agregado con exito"
else
    echo "Log=El usuario ya existe"
	sudo usermod -a -G "$nombre_grupo" "nombre_usuario"
fi


# Cambiar la ruta y los permisos
sudo chown"$nombre_usuario":"$nombre_grupo" "$ruta_archivo"
sudo chmod u+rwx "$ruta_archivo"
sudo chmod g-wx "$ruta_archivo"
sudo chmod o-rwx "$ruta_archivo"
