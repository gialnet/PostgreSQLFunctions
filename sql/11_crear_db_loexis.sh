#!/bin/sh
#
# Crear una base de datos desde la línea de comandos del Shell
#

echo 'crear el usuario'

PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:/opt/pg944/bin

export PATH

usuario='us'$1
database='myempresa'$1
pass="'PassMaquina1'"

# poner el nombre del certificado en mayúsculas
UpperCert=`echo $1 | tr '[:lower:]' '[:upper:]'` 

cert="'$UpperCert.p12'"
# useradd ${usuario}

# usermod -d /usuarios/pgsql ${usuario}

/opt/pg944/bin/psql -d secure -U postgres -c "CREATE USER ${usuario} PASSWORD ${pass};"

echo 'crear la base de datos'
/opt/pg944/bin/psql -d secure -U postgres -c "CREATE DATABASE ${database} OWNER ${usuario};"

echo 'Añadir las funciones criptográficas'
/opt/pg944/bin/psql -d ${database} -U postgres -c "CREATE EXTENSION pgcrypto;"

# crear las tablas
echo 'crear las tablas'
/opt/pg944/bin/psql -d ${database} -f CrearTablas.sql -U ${usuario}

# Añadir el certificado de la base de datos
/opt/pg944/bin/psql -d ${database} -U postgres -c "UPDATE PersonalRRHH SET email='loexisasesores@gmail.com', certificado=pg_read_binary_file(${cert});"

# crear las funciones
echo 'crear las funciones'

/opt/pg944/bin/psql -d ${database} -f ApunteCompras.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f ApunteContable.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f ApunteVenta.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f Balance.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f BalancesCalculos.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f BorraPagoCompraBanco.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f BorrarCobroVentaBanco.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CalculaNomina.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CalculaSociedades.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CalculaSS.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CalculaTodo.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CalculoIVA.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CaluculoIRPF.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CargoNomina.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f CobroVentaBanco.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f EstadoIngresosGastosReconocidos.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f getCuentaDebe.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f Utilidades_lineas_fact.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f ImpuestoSociedades.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f ingresonominas.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f ingresoSS.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f newGasto.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f newHeadFactura.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f PagoAutonomos.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f PagoCompraBanco.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f PagoTributos.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f PanelFacturacion.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f PerdidasyGanancias.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f ReintegrosIngresos.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f SaldoCuenta.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f SaveFactPDF.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f SaveNewCliente.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f SaveNewProveedor.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f Socios.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateApartado.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateAsientoVenta.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateCargoNominas.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateCliente.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateCompra.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateFact.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateProveedor.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f UpdateReintegrosIngresos.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f DatosPerFunctions.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f administradores.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f asesores.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f plangeneral.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f RemesasCuotas.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f ComunidadesPropietarios.sql -U ${usuario}
/opt/pg944/bin/psql -d ${database} -f MyHD_pkDocs.sql -U ${usuario}
# crear las vistas
echo 'crear las vistas'
/opt/pg944/bin/psql -d ${database} -f CrearView.sql -U ${usuario}

echo 'proceso concluido'