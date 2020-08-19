--
-- Apunte de compras o suministros
--
CREATE OR REPLACE FUNCTION ApunteCompra(xIdGasto in integer) returns integer
AS
$body$
DECLARE

    xFecha date; 
    xTotal numeric(8,2):=0;
    xIva numeric(8,2):=0;
    xBase numeric(8,2):=0;
    xConcepto varchar(120);
    xIDProveedor integer;
    xProveedor varchar(20);
    xID integer;
    xNumFact varchar(20);
    xTipo integer;
    xCuenta varchar(4);
    xGasto varchar(4);
    xCuentaGasto varchar(10);
    xCuentaIRPF varchar(10):='4751000111'; -- pago a profesionales
    xCuentaIRPF_al varchar(10):='4751000115'; -- pago de alquileres
    xirpf_profesionales numeric(4,2);
    xReglas text;

    LineasDetalle CURSOR IS SELECT ((importe - getdto(importe,por_dto)) * unidades) as base, 
    getiva(((importe - getdto(importe,por_dto)) * unidades), por_vat) as iva, por_vat
    FROM row_invoices_received WHERE id_inre=xIdGasto;

    cCursor RECORD;

BEGIN

    -- datos clave de la factura
    SELECT i.id_proveedor,i.fecha,s.id_suppliers_type
        into xIDProveedor,xFecha,xTipo
        from invoices_received i, suppliers s 
        where i.id=xIdGasto and i.id_proveedor=s.id;

    

-- Leer los valores de base imponible e IVA

    FOR cCursor IN LineasDetalle LOOP

        xBase := xBase + cCursor.base;
        xIva  := xIva + cCursor.iva;


    END LOOP;

    xTotal := xBase + xIva;

    -- averiguar la cuenta en función del tipo de proveedor
    
    SELECT cuenta,gasto into xCuenta,xGasto FROM suppliers_type WHERE id=xTipo;

    --RAISE NOTICE 'cuenta % gasto %', xCuenta, xGasto;

    -- los proveedores y los bancos tiene cuenta individualizada
    if xTipo=1 or xTipo=2 or  xTipo=3 or xTipo=4 then
        -- pasamos de integer a string
        xProveedor:=''||xIDProveedor;
        xProveedor:=xCuenta || lpad(xProveedor,6,'0');
    else
        xProveedor:=xCuenta ||'000000';
    end if;

    xCuentaGasto:=xGasto||'000000';

    
xReglas:='{"vista":"newGasto.jsp", "IDGastos":"'|| xIdGasto ||'", "id_proveedor":"' || xIDProveedor || '" }';

xConcepto:='Compra/Gasto nº: ' || xIdGasto;

WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo,reglas) 
    VALUES (xConcepto,xFecha,
            EXTRACT(year FROM xFecha),EXTRACT(QUARTER FROM xFecha),
            xReglas::json
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xProveedor,'H',xTotal);

 if xTipo=1 then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4720000000','D',xIva); --iva soportado
 end if;
 if xTipo=2 then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4720000001','D',xIva); --iva soportado paises UE
 end if;
 if xTipo=3 then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4720000002','D',xIva); --iva soportado paises fuera UE
 end if;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xCuentaGasto,'D',xBase);
 
 -- practicar la retención de los alquileres
 if xTipo=5 then
    select irpf_profesionales into xirpf_profesionales from DatosPer where id=1;
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xCuentaIRPF_al,'H',xBase*irpf_alquileres/100);
 end if;

-- practicar la retención de los profesionales
 if xTipo=7 then
    select irpf_profesionales into xirpf_profesionales from DatosPer where id=1;
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xCuentaIRPF,'H',xBase*xirpf_profesionales/100);
 end if;

return xID;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- *****************************************************************************
-- Actualizar Apunte de Compras/Gastos
-- *****************************************************************************


CREATE OR REPLACE FUNCTION UpdateApunteCompra(xIdGasto in integer) returns integer
AS
$body$
DECLARE

    xFecha date;
    xTotal numeric(8,2):=0;
    xIva numeric(8,2):=0;
    xBase numeric(8,2):=0;
    xConcepto varchar(120);
    xIDProveedor integer;
    xId_apunte integer;
    xProveedor varchar(20);
    xID integer;
    xNumFact varchar(20);
    xTipo integer;
    xCuenta varchar(4);
    xGasto varchar(4);
    xCuentaGasto varchar(10);
    xCuentaIRPF varchar(10):='4751000111'; -- pago a profesionales
    xCuentaIRPF_al varchar(10):='4751000115'; -- pago de alquileres
    xirpf_profesionales numeric(4,2);
    xReglas text;

    LineasDetalle CURSOR IS SELECT ((importe - getdto(importe,por_dto)) * unidades) as base, 
    getiva(((importe - getdto(importe,por_dto)) * unidades), por_vat) as iva, por_vat
    FROM row_invoices_received WHERE id_inre=xIdGasto;

    cCursor RECORD;

    xVarRegla varchar(150);

BEGIN

    -- 

    SELECT h.id_apunte,h.fecha,c.id_suppliers_type,c.id
    into xId_apunte,xFecha,xTipo,xIDProveedor
        from invoices_received h, suppliers c 
        where h.id=xIdGasto 
        and c.id=h.id_proveedor;

    FOR cCursor IN LineasDetalle LOOP

        xBase := xBase + cCursor.base;
        xIva  := xIva + cCursor.iva;

    END LOOP;

    xTotal := xBase + xIva;

    -- averiguar la cuenta en función del tipo de proveedor
    
    SELECT cuenta,gasto into xCuenta,xGasto FROM suppliers_type WHERE id=xTipo;
    --RAISE NOTICE 'cuenta % gasto %', xCuenta, xGasto;

    -- los proveedores y los bancos tiene cuenta individualizada
    if xTipo=1 or xTipo=2 or  xTipo=3 or xTipo=4 then
        -- pasamos de integer a string
        xProveedor:=''||xIDProveedor;
        xProveedor:=xCuenta || lpad(xProveedor,6,'0');
    else
        xProveedor:=xCuenta ||'000000';
    end if;

    xCuentaGasto:=xGasto||'000000';

    --RAISE NOTICE 'cuenta de gasto %', xCuentaGasto;
    --RAISE NOTICE 'cuenta de proveedor %',xProveedor;

xReglas:='{"vista":"newGasto.jsp", "IDGastos":"'|| xIdGasto ||'", "id_proveedor":"' || xIDProveedor || '" }';
xConcepto:='Compra/Gasto nº: ' || xIdGasto;

    UPDATE Apuntes SET concepto=xConcepto ,fecha=xFecha,
        year_fiscal=EXTRACT(year FROM xFecha),
        periodo=EXTRACT(QUARTER FROM xFecha),
        reglas=xReglas::json
        WHERE ID = xId_apunte;
    
    -- Borrar el detalle anteriror
    DELETE FROM Diario WHERE id_apunte = xId_apunte;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,xProveedor,'H',xTotal);

 if xTipo=1 then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,'4720000000','D',xIva); --iva soportado
 end if;
 if xTipo=2 then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,'4720000001','D',xIva); --iva soportado paises UE
 end if;
 if xTipo=3 then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,'4720000002','D',xIva); --iva soportado paises fuera UE
 end if;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,xCuentaGasto,'D',xBase);
 
 -- practicar la retención de los alquileres
 if xTipo=5 then
    select irpf_profesionales into xirpf_profesionales from DatosPer where id=1;
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,xCuentaIRPF_al,'H',xBase*irpf_alquileres/100);
 end if;

-- practicar la retención
 if xTipo=7 then
    select irpf_profesionales into xirpf_profesionales from DatosPer where id=1;
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,xCuentaIRPF,'H',xBase*xirpf_profesionales/100);
 end if;

return xID;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
