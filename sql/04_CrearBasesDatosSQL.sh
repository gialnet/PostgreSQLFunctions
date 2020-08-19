#!/bin/sh

clear

#ejecuta el script

echo "Crear las bases de datos de los fuentes SQL desde Dilar a myEmpresa"

echo "activar permiso de ejecución de los scripts"
cd /home/antonio/NetBeansProjects/billing_accounting/FacturaRedmoon/src/main/webapp/SQL
chmod +x 01_crear_db.sh
chmod +x 02_crear_todas.sh
chmod +x 03_borrar_todas.sh
chmod +x 04_CrearBasesDatosSQL.sh


echo "comprimir los fuentes SQL"
time zip -FS /home/antonio/Certificados/SQL * 

cd /home/antonio/Certificados

echo "copiando SQL.zip a myEmpresa Beta1 en 10.56.33.51"
time scp SQL.zip antonio@10.56.33.51:/export/home/antonio/sql

echo "borrar el SQL de la versión anterior"
time ssh antonio@10.56.33.51 'rm /export/home/antonio/sql/*.sql'
time ssh antonio@10.56.33.51 'rm /export/home/antonio/sql/*.sh'

echo "descomprimir el SQL de la nueva versión" 
time ssh antonio@10.56.33.51 'cd /export/home/antonio/sql; unzip SQL.zip;'

echo "borrar todas las bases de datos y sus usuarios"
time ssh antonio@10.56.33.51 'cd /export/home/antonio/sql; sh 03_borrar_todas.sh;'

echo "Lanzar el script de creación crear todas que invoca a 01_crear_db.sh 30 veces"
time ssh antonio@10.56.33.51 'cd /export/home/antonio/sql; sh 02_crear_todas.sh;'
