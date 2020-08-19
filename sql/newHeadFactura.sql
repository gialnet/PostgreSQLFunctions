--
-- Paises Euro
--
--  Alemania,Austria,Bélgica,Chipre,Eslovaquia,Eslovenia,Estonia,España,Finlandia,Francia,Grecia,Irlanda,Italia,Letonia,Luxemburgo,Malta,Países Bajos,Portugal

--
-- Paises de la unión europea con moneda propia
--
-- Bulgaria, República Checa, Dinamarca, Croacia, Lituania, Hungría, Polonia, Rumanía, Suecia y Reino Unido


-- http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml
-- ****************************************************************************
--  Nueva Factura con sus líneas correspondientes
-- ****************************************************************************

-- por ahora no se utiliza pues los datos que viene del interfaz HTML
-- en los campos númericos tiene cambiados los significados de los . y ,
-- . decimal , separador de miles
--
CREATE TYPE LineaFact AS (
    id                  integer,
    id_bill             integer,
    id_item             integer,
    id_store            integer,
    concepto            varchar(90),
    unidades            numeric(4,2),
    importe             numeric(8,2),
    por_vat             numeric(4,2),
    por_req             numeric(4,2),
    por_dto             numeric(4,2)
);

--
-- Nueva forma de hacer la factura a partir de postgreSQL 9.3
--
CREATE OR REPLACE FUNCTION newFactura(id_cli in int, xFecha in varchar, xLDetalle in varchar) returns int
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

    curs4 CURSOR IS SELECT * from json_array_elements(xLDetalle::json);

    cCursor RECORD;

    xVar json;

    xUnidades text;
    ximporte text;
    xpor_vat text;
    xConcepto text;

BEGIN

    -- extaer el trimestre
    -- SELECT EXTRACT(QUARTER FROM now());

    SELECT nextval('cont_facturas'),EXTRACT(year FROM now()) INTO xContador, xYear;

    -- pasamos de integer a string
    xValor:=''||xContador;

    xValor:=xYear||'/'||lpad(xValor,7,'0');

    WITH head_bill_ins AS (
    INSERT INTO head_bill (id_cliente,fecha, numero,fiscal_year,trimestre) 
        VALUES (id_cli,to_date(xFecha,'YYYY-MM-DD'), xValor,xYear,EXTRACT(QUARTER FROM to_date(xFecha,'YYYY-MM-DD')))
    RETURNING ID
    )
    select id into xID from head_bill_ins;
    

    -- Insertar las líneas de detalle de la factura

    FOR cCursor IN curs4 LOOP

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

        INSERT INTO ROW_BILL (id_bill,concepto,unidades,importe,por_vat) 
            VALUES (xID, xConcepto, 
            to_number(xUnidades,'99D99'), 
            to_number(ximporte,'99999999D99'), 
            to_number(xpor_vat,'99D99'));

    END LOOP;

    SELECT ApunteVenta(xID) INTO xAsiento;

    UPDATE head_bill SET id_apunte=xAsiento WHERE id=xId;

    return xID;

    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Generar una factura para una remesa
--
CREATE OR REPLACE FUNCTION newFacturaRemesa(
    id_cli in int, 
    xFecha in varchar, 
    xLDetalle in varchar,
    xRemesa in integer) 
returns int
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

    curs4 CURSOR IS SELECT * from json_array_elements(xLDetalle::json);

    cCursor RECORD;

    xVar json;

    xUnidades text;
    ximporte text;
    xpor_vat text;
    xConcepto text;

BEGIN

    -- extaer el trimestre
    -- SELECT EXTRACT(QUARTER FROM now());

    SELECT nextval('cont_facturas'),EXTRACT(year FROM now()) INTO xContador, xYear;

    -- pasamos de integer a string
    xValor:=''||xContador;

    xValor:=xYear||'/'||lpad(xValor,7,'0');

    WITH head_bill_ins AS (
    INSERT INTO head_bill (id_cliente,fecha, numero,fiscal_year,trimestre, Id_Remesa) 
        VALUES (id_cli,to_date(xFecha,'YYYY-MM-DD'), xValor,xYear,EXTRACT(QUARTER FROM to_date(xFecha,'YYYY-MM-DD')), xRemesa)
    RETURNING ID
    )
    select id into xID from head_bill_ins;
    

    -- Insertar las líneas de detalle de la factura

    FOR cCursor IN curs4 LOOP

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

        INSERT INTO ROW_BILL (id_bill,concepto,unidades,importe,por_vat) 
            VALUES (xID, xConcepto, 
            to_number(xUnidades,'99D99'), 
            to_number(ximporte,'99999999D99'), 
            to_number(xpor_vat,'99D99'));

    END LOOP;

    SELECT ApunteVenta(xID) INTO xAsiento;

    UPDATE head_bill SET id_apunte=xAsiento WHERE id=xId;

    return xID;

    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Añadir factura pro forma
--

CREATE OR REPLACE FUNCTION newFacturaProforma(id_cli in int, xFecha in varchar, xLDetalle in varchar) returns int
AS
$body$
DECLARE

    xContador integer;
    xYear varchar(4);
    xValor varchar(20);
    xID int;

    xUnaLinea json;

    CurDetalle CURSOR IS SELECT * from json_array_elements(xLDetalle::json);

    cCursor RECORD;

    xVar json;

    xUnidades text;
    ximporte text;
    xpor_vat text;
    xConcepto text;

BEGIN


    SELECT nextval('cont_facturas_proforma'),EXTRACT(year FROM now()) INTO xContador, xYear;

    -- pasamos de integer a string
    xValor:=''||xContador;

    xValor:=xYear||'/'||lpad(xValor,7,'0');

    WITH head_bill_ins AS (
    INSERT INTO head_budgetbill (id_cliente,fecha, numero) 
        VALUES (id_cli,to_date(xFecha,'YYYY-MM-DD'), xValor)
    RETURNING ID
    )
    select id into xID from head_bill_ins;
    

    -- Insertar las líneas de detalle de la factura

    FOR cCursor IN CurDetalle LOOP

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

        INSERT INTO row_budgetbill (id_head_budgetbill,concepto,unidades,importe,por_vat) 
            VALUES (xID, xConcepto, 
            to_number(xUnidades,'99D99'), 
            to_number(ximporte,'99999999D99'), 
            to_number(xpor_vat,'99D99'));

    END LOOP;

    return xID;

    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
