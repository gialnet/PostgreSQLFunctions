--
-- Grabar un proveedor
--
CREATE OR REPLACE FUNCTION SaveNewProveedor(
    xNif in varchar,
    xNombre in varchar,
    xDireccion in varchar,
    xObjeto in varchar,
    xPoblacion in varchar,
    xMovil in varchar,
    xMail in varchar,
    xTipo in integer,
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

-- averiguar la cuenta en función del tipo de proveedor

SELECT cuenta into xCuenta FROM suppliers_type WHERE id=xTipo;

WITH Customer_ins AS (
    INSERT INTO suppliers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_suppliers_type,IBAN, BIC)
    VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,xmail,xTipo,upper(xIBAN), upper(xBIC))
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
-- Grabar un proveedor a traves de un proceso masivo vía hoja de cálculo
--
CREATE OR REPLACE FUNCTION SaveNewProveedorBulk(
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


select count(*) into xID from suppliers where nif = upper(xnif);

if xid > 0 then
   return;
end if;


-- averiguar la cuenta en función del tipo de proveedor

SELECT cuenta into xCuenta FROM suppliers_type WHERE id=1;

WITH Customer_ins AS (
    INSERT INTO suppliers (nif,nombre,direccion,objeto,poblacion,movil,mail,id_suppliers_type,IBAN, BIC)
    VALUES (upper(xnif),xnombre,xdireccion,xobjeto,xpoblacion,xmovil,xmail,1,upper(xIBAN), upper(xBIC))
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



