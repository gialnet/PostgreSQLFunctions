--
-- Apunte de ventas a clientes
--
CREATE OR REPLACE FUNCTION ApunteVenta(xIDFact in integer) returns int
AS
$body$
DECLARE

    xFecha date; 
    xTotal numeric(8,2):=0;
    xIva numeric(8,2):=0;
    xBase numeric(8,2):=0;
    xImpREQ numeric(8,2):=0;
    xRecargo numeric(8,2):=0;
    xConcepto varchar(120);
    xIDCliente integer;
    xCliente varchar(20);
    xCuenta varchar(4);
    xGasto varchar(4);
    xID integer;
    xTipo integer;
    xNumFact varchar(20);
    curs4 CURSOR IS SELECT ((importe - getdto(importe,por_dto)) * unidades) as base, 
    getiva(((importe - getdto(importe,por_dto)) * unidades), por_vat) as iva, por_vat
    FROM row_bill WHERE id_bill=xIDFact;
    cCursor RECORD;

    xVarRegla varchar(150);
BEGIN


    SELECT h.id_cliente,h.fecha,h.numero,s.id_customers_type into xIDCliente,xFecha,xNumFact,xTipo 
        from head_bill h, customers s where s.id=h.id_cliente and h.id=xIDFact;

-- Leer los valores de base imponible e IVA

FOR cCursor IN curs4 LOOP

    xBase := xBase + cCursor.base;
    xIva  := xIva + cCursor.iva;

    -- cliente con recargo de equivalencia, comercio minorista
    if xTipo=2 then
        -- 21-->5,2%, 10-->1,4%, 4-->0,5%
        if cCursor.por_vat = 21 then
           xImpREQ = cCursor.base * 5.2 / 100;
        end if;

        if cCursor.por_vat = 10 then
           xImpREQ = cCursor.base * 1.4 / 100;
        end if;

        if cCursor.por_vat = 4 then
           xImpREQ = cCursor.base * 0.5 / 100;
        end if;

        xRecargo := xRecargo + xImpREQ;
    end if;

END LOOP;

    xTotal := xBase + xIva;

    -- averiguar la cuenta en función del tipo de cliente
    
    SELECT cuenta,gasto into xCuenta,xGasto FROM customers_type WHERE id=xTipo;

    -- pasamos de integer a string
    xCliente:=''||xIDCliente;

    xCliente:=xCuenta || lpad(xCliente,6,'0');

    xConcepto:='Factura nº: ' || xNumFact;
    
    xVarRegla:='{"vista":"newFactura.jsp", "IDFactura":"'|| xIDFact ||'", "id_cliente":"' || xIDCliente || '" }';

WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo, reglas) 
    VALUES (xConcepto,
            xFecha,
            EXTRACT(year FROM xFecha),EXTRACT(QUARTER FROM xFecha),
            xVarRegla::json
    )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xCliente,'D',xTotal); -- total

-- para Canarias Ceuta Melilla y paises UE no llevan IVA
if xTipo=1 or xTipo=2 or xTipo=6 then

    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4770000000','H',xIva+xRecargo);   -- iva

end if;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'7000000000','H',xBase);  -- base imponible


    return xID;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

-- **************************************************
-- Total ventas por cliente y pendiente de un cliente

-- SELECT TotalFactura, TotalPendiente INTO xTotalFactura, xTotalPendiente from VolumenNegocioCliente(xIDCliente);

-- **************************************************

CREATE OR REPLACE FUNCTION VolumenNegocioCliente(xIDCliente in integer, TotalFactura out numeric, TotalPendiente out numeric) 
returns RECORD
AS
$body$
DECLARE


BEGIN

--
-- Total ventas a un cliente
--

select sum(total) into TotalFactura from head_bill, total_a_pagar 
    where total_a_pagar.id_bill=head_bill.id 
    and id_cliente = xIDCliente;

if TotalFactura is null then
    TotalFactura := 0;
end if;
--
-- pendiente de cobro por cliente
--

select sum(total) into TotalPendiente from head_bill, total_a_pagar 
    where total_a_pagar.id_bill=head_bill.id 
    and id_cliente = xIDCliente 
    and estado='PENDIENTE';


if TotalPendiente is null then
    TotalPendiente := 0;
end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;