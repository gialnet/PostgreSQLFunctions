--
-- Movimientos de efectivo en el banco
--
CREATE OR REPLACE FUNCTION ReintegrosIngresos(
    xDescripcion in varchar,
    xFecha in varchar,
    xBanco in varchar,
    xImporte in numeric,
    xTipo in varchar
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xVarRegla varchar(150);

BEGIN

xVarRegla := '{"vista":"ReintegrosIngresos.jsp", "xTipo":"'|| xTipo ||'", "cuenta":"' || xBanco || '" }'; 

WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo,reglas) 
    VALUES (xDescripcion,to_date(xFecha, 'YYYY-MM-DD'),
            EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
            EXTRACT(QUARTER FROM to_date(xFecha, 'YYYY-MM-DD')),
            xVarRegla::json
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

-- xTipo Reintegro/Ingreso

if xTipo='Reintegro' then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'5700000000','D',xImporte);
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xImporte);
else
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'5700000000','H',xImporte);
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'D',xImporte);
end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
