
--
-- Actualizar una factura de compras
--
-- [{"id":"76","id_bill":"47","id_item":"","id_store":"","concepto":"algo","unidades":"1.00","importe":"100.00","por_vat":"21.00",
-- "por_dto":"0","por_req":"0.00","total":"100.00"}]
--
-- 
CREATE OR REPLACE FUNCTION UpdateCompra(xid IN integer, 
    fichero IN bytea,
    xidproveedor in integer,
    xfecha in varchar, xLDetalle in varchar
) returns void
AS
$body$
DECLARE

    curs4 CURSOR IS SELECT value from json_array_elements(xLDetalle::json);

    cCursor RECORD;

    xVar json;

    xUnidades text;
    ximporte text;
    xpor_vat text;
    xConcepto text;

BEGIN

    -- borrar las anteriores líneas de detalle
    delete from row_invoices_received where id_inre=xid;

    -- actualizar los datos de cabecera
    update invoices_received SET id_proveedor=xidproveedor , fecha=to_date(xfecha, 'YYYY-MM-DD'), 
    fiscal_year=EXTRACT(year FROM to_date(xFecha,'YYYY-MM-DD')),
    trimestre=EXTRACT(QUARTER FROM to_date(xFecha,'YYYY-MM-DD'))
    where id=xid;

-- Insertar las líneas de detalle de la factura

    FOR cCursor IN curs4 LOOP

        -- descodifica una linea
        xVar := cCursor.value;
        --RAISE NOTICE 'i want to print %', xVar;

        --PERFORM json_populate_record(xLineaFact::LineaFact, xVar);

        --RAISE NOTICE 'concepto %', xVar::json->'concepto';
        --RAISE NOTICE 'importe %', xVar::json->'importe';
        xConcepto:=xVar::json->>'concepto';
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

    PERFORM UpdateApunteCompra(xID);

    --
    -- Si no hay fichero terminamos
    --
    if fichero is null then
      return;
    else
        -- borrar el documento
        delete from doc_supporting where id_received=xid;
    end if;


    -- JUSTIFICANTES DE FACTURAS RECIBIDAS
    INSERT INTO doc_supporting (fileblob,id_received,hash_algo) 
    VALUES (fichero, xid,encode(digest(fichero, 'sha512'), 'hex'));

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
