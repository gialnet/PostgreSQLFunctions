--
-- Grabar un cliente
--
CREATE OR REPLACE FUNCTION SaveNewCliente(
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xTipo in integer,
    xIBAN in varchar,
    xBIC in varchar,
    xOrdenSepa bytea
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xCliente varchar(20);
    xCuenta varchar(4);

BEGIN

-- averiguar la cuenta en función del tipo de cliente

SELECT cuenta into xCuenta FROM customers_type WHERE id=xTipo;

WITH Customer_ins AS (
    INSERT INTO customers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_customers_type,IBAN,BIC,orden_sepa)
    VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,lower(xmail),xTipo,xIBAN,xBIC, xOrdenSepa)
    RETURNING ID
    )
    select id into xID from Customer_ins;


    -- pasamos de integer a string
    xCliente:=''||xID;

    xCliente:=xCuenta || lpad(xCliente,6,'0');

    -- Añadir la cuenta del cliente a la tabla de cuentas de contabilidad
    INSERT INTO cuentas (concepto,cuenta) VALUES (xNombre,xCliente);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Crear clientes desde un proceso que lee una hoja de cálculo
--
CREATE OR REPLACE FUNCTION SaveNewClienteBulk(
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xIBAN in varchar,
    xBIC in varchar
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xCliente varchar(20);
    xCuenta varchar(4);

BEGIN

-- limpiar las variables
xnif := trim(left(xnif,10));
xnombre := trim(left(xnombre,60));
xDireccion := trim(left(xdireccion,90));
xObjeto := trim(left(xobjeto,40));
xPoblacion := trim(left(xpoblacion,90));
xMovil := trim(left(xmovil,10));
xMail := trim(left(xmail,90));
xIBAN := trim(left(xiban,34));
xBIC := trim(left(xbic,11));
-- comprobar que no se haya añadido con anterioridad

select count(*) into xID from customers where nif = upper(xnif);

if xid > 0 then
   return;
end if;


-- averiguar la cuenta en función del tipo de cliente

SELECT cuenta into xCuenta FROM customers_type WHERE id=1;

WITH Customer_ins AS (
    INSERT INTO customers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_customers_type,IBAN, BIC)
           VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,lower(xmail), 1,xIBAN, xBIC)
    RETURNING ID
    )
    select id into xID from Customer_ins;


    -- pasamos de integer a string
    xCliente:=''||xID;

    xCliente:=xCuenta || lpad(xCliente,6,'0');

    -- Añadir la cuenta del cliente a la tabla de cuentas de contabilidad
    INSERT INTO cuentas (concepto,cuenta) VALUES (xNombre,xCliente);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Crear una cuenta de cliente con un porcentaje de participación
-- será invocado por un proceso de carga de datos masiva
--
-- xVarJSON ejemplo: {"porcentaje_participacion" : 0.1234567890, "comunero" : "125" }
-- se utilizan diez decimales para una buena precisión
--
CREATE OR REPLACE FUNCTION SaveNewClientePorPar(
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xIBAN in varchar,
    xBIC in varchar,
    xPorPar in varchar,
    xOrdenSepa bytea
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xCliente varchar(20);
    xCuenta varchar(4);
    xVarJSON text;
BEGIN

-- limpiar las variables
xnif := trim(left(xnif,10));
xnombre := trim(left(xnombre,60));
xDireccion := trim(left(xdireccion,90));
xObjeto := trim(left(xobjeto,40));
xPoblacion := trim(left(xpoblacion,90));
xMovil := trim(left(xmovil,10));
xMail := trim(left(xmail,90));
xIBAN := trim(left(xiban,34));
xBIC := trim(left(xbic,11));

xVarJSON := '{"porcentaje_participacion": "'|| replace(xPorPar, '.', ',') ||'" }';
-- comprobar que no se haya añadido con anterioridad

select count(*) into xID from customers where nif = upper(xnif);

if xid > 0 then
   return;
end if;


-- averiguar la cuenta en función del tipo de cliente

SELECT cuenta into xCuenta FROM customers_type WHERE id=1;

WITH Customer_ins AS (
    INSERT INTO customers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_customers_type,IBAN,BIC, otros_datos, orden_sepa)
    VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,lower(xmail), 1,xIBAN,xBIC, xVarJSON::json, xOrdenSepa)
    RETURNING ID
    )
    select id into xID from Customer_ins;


    -- pasamos de integer a string
    xCliente:=''||xID;

    xCliente:=xCuenta || lpad(xCliente,6,'0');

    -- Añadir la cuenta del cliente a la tabla de cuentas de contabilidad
    INSERT INTO cuentas (concepto,cuenta) VALUES (xNombre,xCliente);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Para carga masiva vía hoja de calculo
--

CREATE OR REPLACE FUNCTION SaveNewClientePorParBulk(
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xIBAN in varchar,
    xBIC in varchar,
    xPorPar in varchar
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xCliente varchar(20);
    xCuenta varchar(4);
    xVarJSON text;
BEGIN

-- limpiar las variables
xnif := trim(left(xnif,10));
xnombre := trim(left(xnombre,60));
xDireccion := trim(left(xdireccion,90));
xObjeto := trim(left(xobjeto,40));
xPoblacion := trim(left(xpoblacion,90));
xMovil := trim(left(xmovil,10));
xMail := trim(left(xmail,90));
xIBAN := trim(left(xiban,34));
xBIC := trim(left(xbic,11));

xVarJSON := '{"porcentaje_participacion": "'|| replace(xPorPar, '.', ',') ||'" }';
-- comprobar que no se haya añadido con anterioridad

select count(*) into xID from customers where nif = upper(xnif);

if xid > 0 then
   return;
end if;


-- averiguar la cuenta en función del tipo de cliente

SELECT cuenta into xCuenta FROM customers_type WHERE id=1;

WITH Customer_ins AS (
    INSERT INTO customers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_customers_type,IBAN,BIC, otros_datos)
    VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,lower(xmail), 1,xIBAN,xBIC, xVarJSON::json)
    RETURNING ID
    )
    select id into xID from Customer_ins;


    -- pasamos de integer a string
    xCliente:=''||xID;

    xCliente:=xCuenta || lpad(xCliente,6,'0');

    -- Añadir la cuenta del cliente a la tabla de cuentas de contabilidad
    INSERT INTO cuentas (concepto,cuenta) VALUES (xNombre,xCliente);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;





-- ****************************************************************
-- Para empresas que trabajan por iguala como Asesorias y similares
-- ****************************************************************

CREATE OR REPLACE FUNCTION SaveNewClienteIguala(
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xIBAN in varchar,
    xBIC in varchar,
    xIguala in varchar,
    xOrdenSepa bytea
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xCliente varchar(20);
    xCuenta varchar(4);
    xVarJSON text;
    xCuotaServicio numeric(8,2);

BEGIN

-- limpiar las variables
xnif := trim(left(xnif,10));
xnombre := trim(left(xnombre,60));
xDireccion := trim(left(xdireccion,90));
xObjeto := trim(left(xobjeto,40));
xPoblacion := trim(left(xpoblacion,90));
xMovil := trim(left(xmovil,10));
xMail := trim(left(xmail,90));
xIBAN := trim(left(xiban,34));
xBIC := trim(left(xbic,11));

xVarJSON := '{"iguala_mes": "'|| replace(xIguala, '.', ',') ||'" }';
-- comprobar que no se haya añadido con anterioridad

select count(*) into xID from customers where nif = upper(xnif);

if xid > 0 then
   return;
end if;


xCuotaServicio:= to_number(replace(xIguala, '.', ','),'99999999D99');

-- averiguar la cuenta en función del tipo de cliente

SELECT cuenta into xCuenta FROM customers_type WHERE id=1;

WITH Customer_ins AS (
    INSERT INTO customers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_customers_type,IBAN,BIC, otros_datos, orden_sepa, CuotaServicio)
    VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,lower(xmail), 1,xIBAN,xBIC, xVarJSON::json, xOrdenSepa, xCuotaServicio)
    RETURNING ID
    )
    select id into xID from Customer_ins;


    -- pasamos de integer a string
    xCliente:=''||xID;

    xCliente:=xCuenta || lpad(xCliente,6,'0');

    -- Añadir la cuenta del cliente a la tabla de cuentas de contabilidad
    INSERT INTO cuentas (concepto,cuenta) VALUES (xNombre,xCliente);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Para carga masiva vía hoja de calculo
--

CREATE OR REPLACE FUNCTION SaveNewClienteIgualaBulk(
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xIBAN in varchar,
    xBIC in varchar,
    xIguala in varchar
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xCliente varchar(20);
    xCuenta varchar(4);
    xVarJSON text;
    xCuotaServicio numeric(8,2);

BEGIN

-- limpiar las variables
xnif := trim(left(xnif,10));
xnombre := trim(left(xnombre,60));
xDireccion := trim(left(xdireccion,90));
xObjeto := trim(left(xobjeto,40));
xPoblacion := trim(left(xpoblacion,90));
xMovil := trim(left(xmovil,10));
xMail := trim(left(xmail,90));
xIBAN := trim(left(xiban,34));
xBIC := trim(left(xbic,11));

xVarJSON := '{"iguala_mes": "'|| replace(xIguala, '.', ',') ||'" }';
-- comprobar que no se haya añadido con anterioridad

select count(*) into xID from customers where nif = upper(xnif);

if xid > 0 then
   return;
end if;


-- averiguar la cuenta en función del tipo de cliente

SELECT cuenta into xCuenta FROM customers_type WHERE id=1;

xCuotaServicio:= to_number(replace(xIguala, '.', ','),'99999999D99');

WITH Customer_ins AS (
    INSERT INTO customers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_customers_type,IBAN,BIC, otros_datos, CuotaServicio)
    VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,lower(xmail), 1,xIBAN,xBIC, xVarJSON::json, xCuotaServicio)
    RETURNING ID
    )
    select id into xID from Customer_ins;


    -- pasamos de integer a string
    xCliente:=''||xID;

    xCliente:=xCuenta || lpad(xCliente,6,'0');

    -- Añadir la cuenta del cliente a la tabla de cuentas de contabilidad
    INSERT INTO cuentas (concepto,cuenta) VALUES (xNombre,xCliente);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ***************************************************************************
-- Cambiar el importe de la cuota mensual
--
-- Cuando el importe sea mayor de cero estará domiciliado en caso contrario
-- el campo domiciliado se establece a NO
--
CREATE OR REPLACE FUNCTION ChgClienteIguala(
    xIDCliente in integer,   xIguala in varchar
) 
returns void
AS
$body$
DECLARE

    xVarJSON text;
    xCuotaServicio numeric(8,2);

BEGIN

xVarJSON := '{"iguala_mes": "'|| replace(xIguala, '.', ',') ||'" }';

xCuotaServicio := to_number(replace(xIguala, '.', ','),'99999999D99');


UPDATE customers SET otros_datos=xVarJSON::json, CuotaServicio=xCuotaServicio
    WHERE id = xIDCliente;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Disparador para ajustar la variable de domiciliado en función del importe
-- de la cuota de servicio
--

CREATE OR REPLACE FUNCTION set_domiciliado_cus() RETURNS TRIGGER AS $set_domiciliado_customer$
  BEGIN

       if NEW.CuotaServicio > 0 then
            NEW.domiciliado := 'domiciliado';
       else
            NEW.domiciliado := 'NO';
       end if;

       RETURN NEW;
  END;
$set_domiciliado_customer$ LANGUAGE 'plpgsql';

CREATE TRIGGER set_domiciliado_customer
BEFORE INSERT OR UPDATE ON customers
    FOR EACH ROW EXECUTE PROCEDURE set_domiciliado_cus();

