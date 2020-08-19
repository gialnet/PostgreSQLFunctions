#!/bin/sh
#
# Borrar todas las bases de datos
#

echo 'borrar 30 bases de datos desde la 01 hasta 1E hexadecimal'

echo 'BORRAR la base de datos'

psql -d secure -U postgres -c "DROP DATABASE myempresa01;"
psql -d secure -U postgres -c "DROP USER us01;"

psql -d secure -U postgres -c "DROP DATABASE myempresa02;"
psql -d secure -U postgres -c "DROP USER us02;"

psql -d secure -U postgres -c "DROP DATABASE myempresa03;"
psql -d secure -U postgres -c "DROP USER us03;"

psql -d secure -U postgres -c "DROP DATABASE myempresa04;"
psql -d secure -U postgres -c "DROP USER us04;"

psql -d secure -U postgres -c "DROP DATABASE myempresa05;"
psql -d secure -U postgres -c "DROP USER us05;"

psql -d secure -U postgres -c "DROP DATABASE myempresa06;"
psql -d secure -U postgres -c "DROP USER us06;"

psql -d secure -U postgres -c "DROP DATABASE myempresa07;"
psql -d secure -U postgres -c "DROP USER us07;"

psql -d secure -U postgres -c "DROP DATABASE myempresa08;"
psql -d secure -U postgres -c "DROP USER us08;"

psql -d secure -U postgres -c "DROP DATABASE myempresa09;"
psql -d secure -U postgres -c "DROP USER us09;"

psql -d secure -U postgres -c "DROP DATABASE myempresa0a;"
psql -d secure -U postgres -c "DROP USER us0a;"

psql -d secure -U postgres -c "DROP DATABASE myempresa0b;"
psql -d secure -U postgres -c "DROP USER us0b;"

psql -d secure -U postgres -c "DROP DATABASE myempresa0c;"
psql -d secure -U postgres -c "DROP USER us0c;"

psql -d secure -U postgres -c "DROP DATABASE myempresa0d;"
psql -d secure -U postgres -c "DROP USER us0d;"

psql -d secure -U postgres -c "DROP DATABASE myempresa0e;"
psql -d secure -U postgres -c "DROP USER us0e;"

psql -d secure -U postgres -c "DROP DATABASE myempresa0f;"
psql -d secure -U postgres -c "DROP USER us0f;"

psql -d secure -U postgres -c "DROP DATABASE myempresa10;"
psql -d secure -U postgres -c "DROP USER us10;"

psql -d secure -U postgres -c "DROP DATABASE myempresa11;"
psql -d secure -U postgres -c "DROP USER us11;"

psql -d secure -U postgres -c "DROP DATABASE myempresa12;"
psql -d secure -U postgres -c "DROP USER us12;"

psql -d secure -U postgres -c "DROP DATABASE myempresa13;"
psql -d secure -U postgres -c "DROP USER us13;"

psql -d secure -U postgres -c "DROP DATABASE myempresa14;"
psql -d secure -U postgres -c "DROP USER us14;"

psql -d secure -U postgres -c "DROP DATABASE myempresa15;"
psql -d secure -U postgres -c "DROP USER us15;"

psql -d secure -U postgres -c "DROP DATABASE myempresa16;"
psql -d secure -U postgres -c "DROP USER us16;"

psql -d secure -U postgres -c "DROP DATABASE myempresa17;"
psql -d secure -U postgres -c "DROP USER us17;"

psql -d secure -U postgres -c "DROP DATABASE myempresa18;"
psql -d secure -U postgres -c "DROP USER us18;"

psql -d secure -U postgres -c "DROP DATABASE myempresa19;"
psql -d secure -U postgres -c "DROP USER us19;"

psql -d secure -U postgres -c "DROP DATABASE myempresa1a;"
psql -d secure -U postgres -c "DROP USER us1a;"

psql -d secure -U postgres -c "DROP DATABASE myempresa1b;"
psql -d secure -U postgres -c "DROP USER us1b;"

psql -d secure -U postgres -c "DROP DATABASE myempresa1c;"
psql -d secure -U postgres -c "DROP USER us1c;"

psql -d secure -U postgres -c "DROP DATABASE myempresa1d;"
psql -d secure -U postgres -c "DROP USER us1d;"

psql -d secure -U postgres -c "DROP DATABASE myempresa1e;"
psql -d secure -U postgres -c "DROP USER us1e;"