--
-- Actualizar un cliente
--
CREATE OR REPLACE FUNCTION UpdateCliente(
    xID integer,
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xTipo in integer,
    xIBAN in varchar,
    xOrdenSepa bytea
) 
returns void
AS
$body$
DECLARE

    xCliente varchar(20);
    xOldCliente varchar(20);
    xCuenta varchar(4);
    xOldCuenta varchar(4);
    xOldType integer;
    xCuantos integer;

BEGIN

SELECT cuenta into xCuenta FROM customers_type WHERE id=xTipo;

SELECT id_customers_type into xOldType FROM customers WHERE id=xId;

if (xOldType<>xTipo) then
    SELECT cuenta into xOldCuenta FROM customers_type WHERE id=xOldType;
end if;

-- actualizamos los datos del cliente
UPDATE customers SET nif=xNif,nombre=xNombre,direccion=xDireccion,
    objeto=xObjeto,poblacion=xPoblacion,movil=xMovil,mail=lower(xMail),
    id_customers_type=xTipo,IBAN=xIBAN,orden_sepa=xOrdenSepa
    WHERE id=xID;

-- pasamos de integer a string
    xCliente:=  ''||xID;
    xCliente:=  lpad(xCliente,6,'0');
    xOldCliente:=xOldCuenta || xCliente;
    xCliente:=  xCuenta || xCliente;


    -- actualizamos el nombre del cliente en las cuentas

    -- pero si ha cambiado de tipo de cliente tenemos un problema
    -- además si hay apuntes a esta cuenta que intentamos modificar
    -- tendremos problemas de integridad y fallará la actualización

    if xOldType!=xTipo then

            SELECT count(*) into xCuantos FROM Diario WHERE cuenta=xOldCliente;
            
            if xCuantos = 0 then
                UPDATE cuentas SET concepto=xNombre,cuenta=xCliente WHERE cuenta=xOldCliente;
            else
                RAISE NOTICE 'se han realizado apuntes, no se puede modificar la cuenta';
            end if;

    else
        -- actualizamos el nombre del cliente en las cuentas
        UPDATE cuentas SET concepto=xNombre WHERE cuenta=xCliente;
    end if;
    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



--
-- Actualizar un cliente de comunidades de propietarios
--
CREATE OR REPLACE FUNCTION UpdateClientePorPar(
    xID integer,
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xIBAN in varchar,
    xPorPar in varchar,
    xOrdenSepa bytea
) 
returns void
AS
$body$
DECLARE

    xCliente varchar(20);
    xOldCliente varchar(20);
    xCuenta varchar(4);
    xOldCuenta varchar(4);
    xOldType integer;
    xCuantos integer;
    xVarJSON text;

BEGIN

xVarJSON := '{"porcentaje_participacion": "'|| xPorPar ||'" }';

SELECT cuenta into xCuenta FROM customers_type WHERE id=1;

SELECT id_customers_type into xOldType FROM customers WHERE id=xId;

if (xOldType<>1) then
    SELECT cuenta into xOldCuenta FROM customers_type WHERE id=xOldType;
end if;

-- actualizamos los datos del cliente
UPDATE customers SET nif=xNif,nombre=xNombre,direccion=xDireccion,
    objeto=xObjeto,poblacion=xPoblacion,movil=xMovil,mail=lower(xMail),
    id_customers_type=1,IBAN=xIBAN, otros_datos=xVarJSON::json,
    orden_sepa=xOrdenSepa
    WHERE id=xID;

-- pasamos de integer a string
    xCliente:=  ''||xID;
    xCliente:=  lpad(xCliente,6,'0');
    xOldCliente:=xOldCuenta || xCliente;
    xCliente:=  xCuenta || xCliente;


    -- actualizamos el nombre del cliente en las cuentas

    -- pero si ha cambiado de tipo de cliente tenemos un problema
    -- además si hay apuntes a esta cuenta que intentamos modificar
    -- tendremos problemas de integridad y fallará la actualización

    if xOldType!=1 then

            SELECT count(*) into xCuantos FROM Diario WHERE cuenta=xOldCliente;
            
            if xCuantos = 0 then
                UPDATE cuentas SET concepto=xNombre,cuenta=xCliente WHERE cuenta=xOldCliente;
            else
                RAISE NOTICE 'se han realizado apuntes, no se puede modificar la cuenta';
            end if;

    else
        -- actualizamos el nombre del cliente en las cuentas
        UPDATE cuentas SET concepto=xNombre WHERE cuenta=xCliente;
    end if;
    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Actualizar un cliente de comunidades de propietarios
--
CREATE OR REPLACE FUNCTION UpdateClienteIguala(
    xID integer,
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xIBAN in varchar,
    xIguala in varchar,
    xOrdenSepa bytea
) 
returns void
AS
$body$
DECLARE

    xCliente varchar(20);
    xOldCliente varchar(20);
    xCuenta varchar(4);
    xOldCuenta varchar(4);
    xOldType integer;
    xCuantos integer;
    xVarJSON text;

BEGIN

xVarJSON := '{"iguala_mes": "'|| xIguala ||'" }';

SELECT cuenta into xCuenta FROM customers_type WHERE id=1;

SELECT id_customers_type into xOldType FROM customers WHERE id=xId;

if (xOldType<>1) then
    SELECT cuenta into xOldCuenta FROM customers_type WHERE id=xOldType;
end if;

-- actualizamos los datos del cliente
UPDATE customers SET nif=xNif,nombre=xNombre,direccion=xDireccion,
    objeto=xObjeto,poblacion=xPoblacion,movil=xMovil,mail=lower(xMail),
    id_customers_type=1,IBAN=xIBAN, otros_datos=xVarJSON::json,
    orden_sepa=xOrdenSepa
    WHERE id=xID;

-- pasamos de integer a string
    xCliente:=  ''||xID;
    xCliente:=  lpad(xCliente,6,'0');
    xOldCliente:=xOldCuenta || xCliente;
    xCliente:=  xCuenta || xCliente;


    -- actualizamos el nombre del cliente en las cuentas

    -- pero si ha cambiado de tipo de cliente tenemos un problema
    -- además si hay apuntes a esta cuenta que intentamos modificar
    -- tendremos problemas de integridad y fallará la actualización

    if xOldType!=1 then

            SELECT count(*) into xCuantos FROM Diario WHERE cuenta=xOldCliente;
            
            if xCuantos = 0 then
                UPDATE cuentas SET concepto=xNombre,cuenta=xCliente WHERE cuenta=xOldCliente;
            else
                RAISE NOTICE 'se han realizado apuntes, no se puede modificar la cuenta';
            end if;

    else
        -- actualizamos el nombre del cliente en las cuentas
        UPDATE cuentas SET concepto=xNombre WHERE cuenta=xCliente;
    end if;
    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Borrar un cliente
--

CREATE OR REPLACE FUNCTION DeleteCliente(
    xID integer
) 
returns void
AS
$body$
DECLARE

    xCliente varchar(20);
    xCuenta varchar(4);
    xType integer;

BEGIN


select id_customers_type into xType from customers where id=xID;

SELECT cuenta into xCuenta FROM customers_type WHERE id=xType;

    -- averiguar la cuenta del cliente

    xCliente:=  ''||xID;
    xCliente:=  lpad(xCliente,6,'0');
    xCliente:=  xCuenta || xCliente;

DELETE FROM cuentas where cuenta=xCliente;

DELETE FROM customers where id=xID;


    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
