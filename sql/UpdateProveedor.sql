--
-- Actualizar un proveedor
--
CREATE OR REPLACE FUNCTION UpdateProveedor(
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
    xBIC in varchar
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

-- averiguar la cuenta en función del tipo de proveedor

SELECT cuenta into xCuenta FROM suppliers_type WHERE id=xTipo;

-- averiguar la cuenta anterior a la modificación

SELECT id_suppliers_type into xOldType FROM suppliers WHERE id=xId;

if (xOldType<>xTipo) then
    SELECT cuenta into xOldCuenta FROM suppliers_type WHERE id=xOldType;
end if;

-- actualizamos los datos del proveedor
UPDATE suppliers SET nif=xNif,nombre=xNombre,direccion=xDireccion,
    objeto=xObjeto,poblacion=xPoblacion,movil=xMovil,mail=xMail,id_suppliers_type=xTipo, IBAN=xIBAN, bic=xbic
    WHERE id=xID;

    -- pasamos de integer a string
    xCliente:=  ''||xID;
    xCliente:=  lpad(xCliente,6,'0');
    xOldCliente:=xOldCuenta || xCliente;
    xCliente:=  xCuenta || xCliente;
    
    -- actualizamos el nombre del proveedor en las cuentas

    -- pero si ha cambiado de tipo de proveedor tenemos un problema
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
        UPDATE cuentas SET concepto=xNombre WHERE cuenta=xCliente;
    end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

