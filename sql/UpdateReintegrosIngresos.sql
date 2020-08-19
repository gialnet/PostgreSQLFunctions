--
-- Movimientos de efectivo en el banco
--
CREATE OR REPLACE FUNCTION UpdateReintegrosIngresos(
    xIDAsiento in integer,
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

BEGIN

-- actualizar el apunte
UPDATE Apuntes SET concepto=xDescripcion,fecha=to_date(xFecha, 'YYYY-MM-DD'),
    year_fiscal=EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
    periodo=EXTRACT(QUARTER FROM to_date(xFecha, 'YYYY-MM-DD')),
    reglas='{"vista":"ReintegrosIngresos.jsp","xTipo":"'|| xTipo ||'","cuenta":"' || xBanco || '"}'
    WHERE id=xIDAsiento;

-- borrar el anterior diario
DELETE FROM Diario WHERE id_apunte=xIDAsiento;
-- xTipo Reintegro/Ingreso


if xTipo='Reintegro' then
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDAsiento,'5700000000','D',xImporte);
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDAsiento,xBanco,'H',xImporte);
else
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDAsiento,'5700000000','H',xImporte);
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDAsiento,xBanco,'D',xImporte);
end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


