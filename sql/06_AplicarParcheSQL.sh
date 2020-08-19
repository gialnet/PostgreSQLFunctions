#!/bin/sh

clear

#ejecuta el script

echo "Actualizar los fuentes SQL desde Dilar a myEmpresa"

echo "activar permiso de ejecución de los scripts"
cd /home/antonio/NetBeansProjects/billing_accounting/FacturaRedmoon/src/main/webapp/SQL

echo "comprimir los fuentes SQL"
time zip -FS /home/antonio/Certificados/ParcheSQL_1 * 

cd /home/antonio/Certificados

echo "copiando ParcheSQL_1.zip a myEmpresa Beta1 en 10.56.33.51"
time scp ParcheSQL_1.zip root@10.56.33.51:/root/sql

echo "descomprimir el SQL del parche" 
time ssh root@10.56.33.51 'cd /root/sql; unzip ParcheSQL_1.zip;'


echo "Lanzar el script de creación crear todas que invoca a 01_crear_db.sh 30 veces"
time ssh root@10.56.33.51 'cd /root/sql; sh 07_ParcheSQL_1.sh;'
