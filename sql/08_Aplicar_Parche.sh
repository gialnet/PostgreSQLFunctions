#!/bin/sh

clear

#ejecuta el script

echo "Crear las bases de datos de los fuentes SQL desde Dilar a myEmpresa"

echo "activar permiso de ejecución de los scripts"
cd /home/antonio/NetBeansProjects/billing_accounting/FacturaRedmoon/src/main/webapp/SQL


echo "comprimir los fuentes SQL"
time zip -FS /home/antonio/Certificados/ParcheSQL_1 *ParcheSQL_1.*

cd /home/antonio/Certificados

echo "copiando SQL.zip a myEmpresa Beta1 en 10.56.33.51"
time scp ParcheSQL_1.zip root@10.56.33.51:/root/sql

echo "borrar el SQL de la versión anterior"
time ssh root@10.56.33.51 'rm /root/sql/ParcheSQL_1.sql'
time ssh root@10.56.33.51 'rm /root/sql/07_ParcheSQL_1.sh'

echo "descomprimir el SQL de la nueva versión" 
time ssh root@10.56.33.51 'cd /root/sql; unzip ParcheSQL_1.zip;'

echo "borrar todas las bases de datos y sus usuarios"
time ssh root@10.56.33.51 'cd /root/sql; sh 07_ParcheSQL_1.sh;'

echo "Proceso terminado"

