#!/bin/sh

clear

#ejecuta el script

echo "Crear las bases de datos de los fuentes SQL desde Dilar a Loexis Asesores"

echo "activar permiso de ejecución de los scripts"
cd /home/antonio/NetBeansProjects/billing_accounting/FacturaRedmoon/src/main/webapp/SQL
chmod +x 01_crear_db.sh
chmod +x 02_crear_todas.sh
chmod +x 03_borrar_todas.sh
chmod +x 04_CrearBasesDatosSQL.sh
chmod +x 10_loexis_CrearBasesDatosSQL.sh


echo "comprimir los fuentes SQL"
time zip -FS /home/antonio/Certificados/SQL * 

cd /home/antonio/Certificados

echo "copiando SQL.zip a Loexis Asesores Beta1 en 81.45.22.58"
time scp SQL.zip root@81.45.22.58:/root/sql

echo "borrar el SQL de la versión anterior"
time ssh root@81.45.22.58 'rm /root/sql/*.sql'
time ssh root@81.45.22.58 'rm /root/sql/*.sh'

echo "descomprimir el SQL de la nueva versión" 
time ssh root@81.45.22.58 'cd /root/sql; unzip SQL.zip;'

echo "Lanzar el script de creación de la base de datos para Loexis Asesores"
time ssh root@81.45.22.58 'cd /root/sql; sh 01_crear_db.sh 23;'
