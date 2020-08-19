--
-- Apunte de pago de una compra
--
CREATE OR REPLACE FUNCTION PagoCompraBanco(
    xIDGasto in integer,
    xFechaPago in varchar,
    xBanco in varchar
) returns void
AS
$body$
DECLARE

    xTotal numeric(8,2):=0;
    xConcepto varchar(120);
    xIDProveedor integer;
    xProveedor varchar(20);
    xID integer;
    xReglas text;
    xCuenta varchar(4);
    xGasto varchar(4);

BEGIN


    SELECT i.id_proveedor, t.total into xIDProveedor, xTotal
        from invoices_received i,total_a_pagar_emi t 
        where i.id=xIDGasto and t.id_inre = i.id;

    -- buscar la cuenta a la que corresponde
    
    SELECT cuenta,gasto into xCuenta,xGasto FROM suppliers_type 
        WHERE id=(select id_suppliers_type from suppliers where id=xIDProveedor);

    -- pasamos de integer a string
    xProveedor:=''||xIDProveedor;

    xProveedor:=xCuenta || lpad(xProveedor,6,'0');

    xConcepto:='Pago compra/gasto: ' || xIDGasto || ' de fecha: ' || xFechaPago;
    xReglas:='{"vista":"BrowseFacturasRecibidas.jsp", "xIDGasto":"'|| xIDGasto ||'", "cuenta":"' || xBanco || '" }';

WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo,reglas) 
    VALUES (xConcepto,to_date(xFechaPago, 'YYYY-MM-DD'),
        EXTRACT(year FROM to_date(xFechaPago, 'YYYY-MM-DD')),
        EXTRACT(QUARTER FROM to_date(xFechaPago, 'YYYY-MM-DD')),
        xReglas::json
        )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xProveedor,'D',xTotal);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xTotal);
 
-- actualizamos el número de asiento del pago
UPDATE invoices_received SET id_appago=xId, 
        fecha_pago=to_date(xFechaPago, 'YYYY-MM-DD'),
        estado='PAGADA' 
        where id=xIDGasto;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
