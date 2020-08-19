/*
    Un Nuevo cliente
*/

CREATE OR REPLACE FUNCTION CreaCuentasClientes() returns void
AS
$body$
DECLARE
curs4 CURSOR is SELECT * from customers;
cCursor RECORD;
xCliente varchar(20);
BEGIN

FOR cCursor IN curs4 LOOP
		xCliente:=''|| cCursor.id;
    INSERT INTO cuentas (concepto,cuenta) VALUES (cCursor.nombre, '430'|| lpad(xCliente,7,'0'));

END LOOP;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
/

CREATE OR REPLACE FUNCTION CreaCuentasProveedores() returns void
AS
$body$
DECLARE
curs4 CURSOR is SELECT * from suppliers;
cCursor RECORD;
xCliente varchar(20);
BEGIN

FOR cCursor IN curs4 LOOP
		xCliente:=''|| cCursor.id;
    INSERT INTO cuentas (concepto,cuenta) VALUES (cCursor.nombre, '400'|| lpad(xCliente,7,'0'));

END LOOP;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
/

