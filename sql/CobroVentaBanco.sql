--
-- Apunte de cobro de una venta por banco
--
/*
    572 Banco al debe
        430 Clientes al haber

    xIDFact --> id de la factura
    xBanco  --> cuenta del banco en formato 572000...
    xTotal  --> importe ingresado
    xFecha  --> fecha del ingreso
*/
CREATE OR REPLACE FUNCTION CobroVentaBanco(
    xIDFact in integer, 
    xBanco in varchar, 
    xTotal in numeric,
    xFechaCobro in varchar
    ) returns void
AS
$body$
DECLARE

    xConcepto varchar(120);
    xIDCliente integer;
    xCliente varchar(20);
    xCuenta varchar(4);
    xGasto varchar(4);
    xID integer;
    xTipo integer;
    xNumFact varchar(20);
    xFecha date;
    xReglas text;

BEGIN

    xFecha=to_date(xFechaCobro, 'YYYY-MM-DD');
    -- Buscamos los datos de la factura

    SELECT h.id_cliente,h.numero,c.id_customers_type into xIDCliente,xNumFact,xTipo 
        from head_bill h, customers c where h.id=xIDFact and c.id=h.id_cliente;

    -- averiguar la cuenta en función del tipo de cliente
    
    SELECT cuenta,gasto into xCuenta,xGasto FROM customers_type WHERE id=xTipo;
    -- pasamos de integer a string
    xCliente:=''||xIDCliente;

    xCliente:=xCuenta || lpad(xCliente,6,'0');
    
    xConcepto:='COBRO Factura nº: ' || xNumFact;

    xReglas:='{"vista":"BrowseFacturasEmitidas.jsp", "IDFactura":"'|| xIDFact ||'", "cuenta":"' || xBanco || '" }';
    WITH Apuntes_ins AS (
        INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo,reglas) 
        VALUES (xConcepto,xFecha,
                EXTRACT(year FROM xFecha),EXTRACT(QUARTER FROM xFecha),
                xReglas::json
                )
        RETURNING ID
    )
    select id into xID from Apuntes_ins;

    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xCliente,'H',xTotal);
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'D',xTotal);

    -- actualizamos el número de asiento del cobro
    UPDATE head_bill SET id_apcobro=xId, fecha_cobro=xFecha,estado='PAGADA' where id=xIDFact;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
