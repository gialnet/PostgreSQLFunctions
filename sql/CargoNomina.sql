--
-- Cargo de una nómina
--
CREATE OR REPLACE FUNCTION CargoNomina(
    xDescripcion in varchar,
    xFecha in varchar,
    xSueldo in numeric,
    xSSEmpresa in numeric,
    xSSTotal in numeric,
    xRetencion in numeric,
    xRemuneracion in numeric
) 
returns void
AS
$body$
DECLARE

    xID integer;
    SumaDebe numeric(12,2);
    SumaHaber numeric(12,2);

BEGIN

SumaDebe := xSueldo + xSSEmpresa;
SumaHaber := xSSTotal + xRetencion + xRemuneracion;

if SumaDebe != SumaHaber then
    RAISE EXCEPTION 'SumaDebe  % != de SumaHaber %', SumaDebe, SumaHaber;
end if;

--
-- Apunte contable
--
--RAISE NOTICE 'xDescripcion %', xDescripcion;
--RAISE NOTICE 'longitud %', length(xDescripcion);


WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo, reglas) 
    VALUES (xDescripcion,to_date(xFecha, 'YYYY-MM-DD'),
            EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
            EXTRACT(MONTH FROM to_date(xFecha, 'YYYY-MM-DD')),
            '{"vista":"CargoNominas.jsp","xSueldo":' ||xSueldo ||',"xSSEmpresa":' || xSSEmpresa ||
            ',"xSSTotal": '|| xSSTotal ||',"xRetencion":'|| xRetencion ||',"xRemuneracion":'|| xRemuneracion ||'}'
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'6400000000','D',xSueldo);

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'6420000000','D',xSSEmpresa);

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4760000000','H',xSSTotal);

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4751000000','H',xRetencion);

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4650000000','H',xRemuneracion);




END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Borrar un asiento de nóminas
--
CREATE OR REPLACE FUNCTION DeleteCargoNomina( xIDAsiento in integer ) 
returns void
AS
$body$
DECLARE


BEGIN

-- Comprobar si se puede borrar

-- Borrar el Asiento
Delete from Diario where id_apunte = xIDAsiento;
Delete from Apuntes where id = xIDAsiento;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
