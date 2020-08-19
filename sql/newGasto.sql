
--
-- Guardar una factura de compras/gastos
--

CREATE OR REPLACE FUNCTION SaveGasto(fichero IN bytea, id_pro in int, xFecha in varchar, xLDetalle in varchar) returns int
AS
$body$
DECLARE

    xContador integer;
    xYear varchar(4);
    xValor varchar(20);
    xID int;
    xAsiento integer;
--    xLineaFact LineaFact;
    xUnaLinea json;

    CurLineasDetalle CURSOR IS SELECT * from json_array_elements(xLDetalle::json);

    cCursor RECORD;

    xVar json;

    xUnidades text;
    ximporte text;
    xpor_vat text;
    xConcepto text;

BEGIN

    -- extaer el trimestre
    -- SELECT EXTRACT(QUARTER FROM now());

    SELECT nextval('cont_recibidas'),EXTRACT(year FROM now()) INTO xContador, xYear;

    -- pasamos de integer a string
    xValor:=''||xContador;

    xValor:=xYear||'/'||lpad(xValor,7,'0');

    WITH invoices_received_ins AS (
    INSERT INTO invoices_received (id_proveedor,fecha, numero,fiscal_year,trimestre) 
        VALUES (id_pro,to_date(xFecha,'YYYY-MM-DD'), xValor,xYear,EXTRACT(QUARTER FROM to_date(xFecha,'YYYY-MM-DD')))
    RETURNING ID
    )
    select id into xID from invoices_received_ins;
    

    -- Insertar las líneas de detalle de la factura

    FOR cCursor IN CurLineasDetalle LOOP

        xVar := cCursor.value;
        --RAISE NOTICE 'Línea de detalle %', xVar;
        -- descodifica una linea
        --select * from json_populate_record(xLineaFact::LineaFact, cCursor.value);
        xConcepto := xVar::json->>'concepto';
        xUnidades:=xVar::json->>'unidades';
        xUnidades:=replace(xUnidades, '.', ',');
        ximporte:=xVar::json->>'importe';
        ximporte:=replace(ximporte, '.', ',');
        xpor_vat:=xVar::json->>'por_vat';
        xpor_vat:=replace(xpor_vat, '.', ',');

        INSERT INTO row_invoices_received (id_inre,concepto,unidades,importe,por_vat) 
            VALUES (xID, xConcepto, 
            to_number(xUnidades,'99D99'), 
            to_number(ximporte,'99999999D99'), 
            to_number(xpor_vat,'99D99'));

    END LOOP;

    -- Añadir un apunte contable de compras
    SELECT ApunteCompra(xID) INTO xAsiento;

    UPDATE invoices_received SET id_apunte=xAsiento WHERE id=xId;
    --
    -- Si no hay fichero terminamos
    --
    if fichero is null then
      return xID;
    end if;


    -- JUSTIFICANTES DE FACTURAS RECIBIDAS
    INSERT INTO doc_supporting (fileblob,id_received,hash_algo) 
        VALUES (fichero, xID, encode(digest(fichero, 'sha512'), 'hex'));

    return xID;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
