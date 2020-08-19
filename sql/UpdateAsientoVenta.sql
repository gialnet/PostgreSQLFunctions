--
-- Apunte de ventas a clientes
--
CREATE OR REPLACE FUNCTION UpdateAsientoVenta(xIDFact in integer) returns void
AS
$body$
DECLARE

    xFecha date; 
    xTotal numeric(8,2):=0;
    xIva numeric(8,2):=0;
    xImpREQ numeric(8,2):=0;
    xRecargo numeric(8,2):=0;
    xBase numeric(8,2):=0;
    xConcepto varchar(120);
    xIDCliente integer;
    xTipo integer;
    xCuenta varchar(4);
    xGasto varchar(4);
    xCliente varchar(20);
    xId_apunte INTEGER;
    xNumFact varchar(20);
    curs4 CURSOR IS SELECT ((importe - getdto(importe,por_dto)) * unidades) as base, 
    getiva(((importe - getdto(importe,por_dto)) * unidades), por_vat) as iva, por_vat
    FROM row_bill WHERE id_bill=xIDFact;
    cCursor RECORD;

    xVarRegla varchar(150);
BEGIN


    SELECT h.id_cliente,h.id_apunte,h.fecha,h.numero,c.id_customers_type 
    into xIDCliente,xId_apunte,xFecha,xNumFact,xTipo 
        from head_bill h, customers c where h.id=xIDFact and c.id=h.id_cliente;

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

    UPDATE Apuntes SET concepto=xConcepto,fecha=xFecha,
        year_fiscal=EXTRACT(year FROM xFecha),
        periodo=EXTRACT(QUARTER FROM xFecha),
        reglas=xVarRegla::json
    WHERE ID=xId_apunte;

    -- borrar el asiento anterior
    DELETE FROM Diario WHERE id_apunte = xId_apunte;

    -- PONER LOS NUEVOS VALORES
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,xCliente,'D',xTotal);

    -- para Canarias Ceuta Melilla y paises UE no llevan IVA
    if xTipo=1 or xTipo=2 or xTipo=6 then
        INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,'4770000000','H',xIva+xRecargo);
    end if;

    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId_apunte,'7000000000','H',xBase);



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
