--
-- Hacer efectivo el ingreso de los seguros sociales
--
CREATE OR REPLACE FUNCTION IngresoSS(
    xFecha in varchar,
    xBanco in varchar,
    xImporte in numeric
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xImporte numeric(8,2);

BEGIN

WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo) 
    VALUES ('Ingreso SS nóminas',to_date(xFecha, 'YYYY-MM-DD'),
            EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
            EXTRACT(QUARTER FROM to_date(xFecha, 'YYYY-MM-DD')),
            '{"vista":".jsp"}'
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

-- Al pago de los seguros sociales, se paga a mes vencido, es decir las de enero se pagan en febrero, etc.

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4760000000','D',xImporte);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xImporte);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
