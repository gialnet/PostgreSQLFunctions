
--
-- Guardar una factura de compras/gastos
--

CREATE OR REPLACE FUNCTION SaveReciboComunidad(xLDetalle in varchar) returns void
AS
$body$
DECLARE

    xUnaLinea json;

    curs4 CURSOR IS SELECT * from json_array_elements(xLDetalle::json);

    cCursor RECORD;

    xVar json;
    
    ximporte text;    
    xConcepto text;
    xFijo_variable text;
    xOrigen text;

BEGIN

    

   
    -- Insertar las líneas de detalle del recibo

    FOR cCursor IN curs4 LOOP

        xVar := cCursor.value;
        RAISE NOTICE 'Línea de detalle %', xVar;
        -- descodifica una linea
        
        xConcepto := xVar::json->>'concepto';
        xFijo_variable:=xVar::json->>'tipo';        
        xOrigen:=xVar::json->>'origen';
        ximporte:=xVar::json->>'importe';
        ximporte:=replace(ximporte, '.', ',');
       

        INSERT INTO template_row_bill (concepto,origen,importe,fijo_variable) 
            VALUES (xConcepto, 
            upper(xOrigen), 
            to_number(ximporte,'99999999D99'), 
            xFijo_variable);

    END LOOP;

    


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
/