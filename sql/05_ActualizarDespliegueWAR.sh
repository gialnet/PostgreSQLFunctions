#!/bin/sh

clear

#ejecuta el script

echo "Actualizar los fuentes proyecto Glassfish FacturaRedmoon desde Dilar a myEmpresa"

echo "movernos a la carpeta de los fuentes"
cd /home/antonio/NetBeansProjects/billing_accounting/FacturaRedmoon

echo "comprimir los fuentes del proyecto Glassfish"
time zip -r -FS /home/antonio/Certificados/GF4 * --exclude "target/*" "src/main/webapp/SQL" "dss-itext-1.00.jar" "src/main/webapp/js/*" "src/main/webapp/img/*" "src/main/webapp/css/*"
echo "Se excluye el código SQL y el WAR de despliegue"

cd /home/antonio/Certificados

echo "Copiar la librería dss-itext"
#scp /home/antonio/libjars/dss-itext-1.00.jar antonio@10.56.33.51:/antonio/libjar
# crear carpeta
#existe = ssh antonio@10.56.33.51 'test -d /antonio/gl4; [ -d /antonio/gl4 ] && echo "Found" || echo "Not found"'


#if [ ${existe} == 'Not found' ] then
#    time ssh antonio@10.56.33.51 'mkdir -p /antonio/gl4'
#fi


echo "borrar la versión actual"
time ssh antonio@10.56.33.51 'rm -rf /export/home/antonio/gf4/*'

echo "copiando GF4.zip a myEmpresa Beta1 en 10.56.33.51"
time scp GF4.zip antonio@10.56.33.51:/export/home/antonio/gf4

echo "descomprimir el código de la nueva versión"
time ssh antonio@10.56.33.51 'cd /export/home/antonio/gf4; unzip GF4.zip;'

echo "compilar el proyecto con maven"
# para crear el WAR
# mvn clean install -U
#
time ssh antonio@10.56.33.51 'source .profile; cd /export/home/antonio/gf4; mvn clean install;'

# cambiar el usuario de antonio a glssfsh

echo "cambiar el propietario del archivo de despligue de antonio a glafish"

time ssh antonio@10.56.33.51 'chown glssfsh:glssfsh /export/home/antonio/gf4/target/FacturaRedmoon-1.0-rc1.war;'

echo "Terminado"
echo "cambiar el propietario del WAR de antonio a glafish"
echo "Copiar el WAR de despliegue en el servidor de Glassfish"
echo "desplegar con contraseña Tetbury_{2014}"
ssh antonio@10.56.33.51
