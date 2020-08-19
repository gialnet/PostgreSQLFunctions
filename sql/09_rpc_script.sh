#!/bin/sh

#
# Antonio Pérez Caballero
# 22 Diciembre 2011
# descomprimir una release y copiar los archivos en las carpetas detino para Aguas y Mancomunidad
#
# ejemplo de uso: ./subir_release.sh release_11_12_22.zip
#

clear

nombre_file=$1

if [ -n "$nombre_file" ]
then
   echo 'existe, voy a borrar la versión anterior'
   carpeta="${nombre_file%.[^.]*}"
   #sudo rm -r $carpeta
   su --session-command="rm -r $carpeta" ec2-user &
else
   echo 'Not found directory'
fi

# descomprimir archivo
echo "descomprimir $nombre_file"
#sudo unzip -q $nombre_file
su --session-command="unzip -q $nombre_file" ec2-user &

# hay que probar esto para SmartOS
su - usuario -c "command args"

# eliminar la versión anterior del servidor WEB
# se eliminan todos los archivos y carpetas

#sudo rm -r /var/www/html/*
su --session-command="rm -r /var/www/html/*" ec2-user &

# Crear la carpeta de la mancomunidad
#sudo mkdir /var/www/html/mm
su --session-command="mkdir /var/www/html/mm" ec2-user &

# copiar el archivo de reglas de Apache al directorio raiz

#sudo cp /var/www/.htaccess /var/www/html
su --session-command="cp /var/www/.htaccess /var/www/html" ec2-user &

# Copiar la nueva versión en el home del servidor Apache

echo "Publicar el contenido de la carpeta $carpeta"

#sudo cp -R $carpeta/* /var/www/html/
su --session-command="cp -R $carpeta/* /var/www/html/" ec2-user &

#sudo cp -R $carpeta/* /var/www/html/mm/
su --session-command="cp -R $carpeta/* /var/www/html/mm/" ec2-user &

# Ajustar el usuario de la conexión a la Mancomunidad
#sudo sed -i 's/REGISTRO_AS/REGISTRO_MM/' /var/www/html/mm/php/config/pebi_cn.inc.php
su --session-command="sed -i 's/REGISTRO_AS/REGISTRO_MM/' /var/www/html/mm/php/config/pebi_cn.inc.php" ec2-user &


