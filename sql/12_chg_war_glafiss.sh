#!/bin/sh

clear

#
# Actualizar el depliegue de la aplicación
#
# versión 1.0
# 14 enero 2014
#

# copiar el codigo javascript de Tetbury en la carpeta raiz del NGINX
# todo el contenido estático imagenes, css, javascript, html, video, etc.

cp /export/home/antonio/gf4/src/main/webapp/js_tetbury/* /opt/http/html/js_tetbury/

# asignar el desplegable al usuario de Glassfish

chown glssfsh:glssfsh /export/home/antonio/gf4/target/FacturaRedmoon-1.0-rc1.war

# Redesplegar la aplicación de facturación y contabilidad

echo "Actualizando la aplicación"
/opt/glassfish4/glassfish/bin/asadmin --passwordfile /opt/glassfish4/glassfish/domains/domain1/config/local-password --host localhost --user admin deploy --force=true /export/home/antonio/gf4/target/FacturaRedmoon-1.0-rc1.war