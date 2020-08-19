-- 
-- Hacer efectivo el ingreso de las nóminas los ingresos
-- de SS se hace a mes vencido y el de IRPF a trimestre
-- Por lo tanto solo se ingresan la parte de las remuneraciones 
--
CREATE OR REPLACE FUNCTION IngresoNomina(
    xIDNomina in integer,
    xFecha in varchar,
    xBanco in varchar
)
returns void
AS
$body$
DECLARE

    xID integer;
    xImporte numeric(8,2);
    xConcepto varchar(120);
    xEstado varchar(10);

BEGIN


    -- Si ya esta pagado salir
    SELECT estado INTO xEstado FROM leg_obligaciones 
        WHERE id_apunte=xIDNomina 
        AND naturaleza = 'NOMINAS';

    IF  xEstado = 'PAGADO' THEN
        RAISE NOTICE 'Estado %', xEstado;
        RETURN;
    END IF;

    -- la remuneración
    SELECT importe INTO xImporte FROM Diario where id_apunte=xIDNomina and cuenta='4650000000';

    SELECT concepto INTO xConcepto FROM Apuntes WHERE id=xIDNomina;

    xConcepto:= 'Pago Banco: ' || xConcepto;

    WITH Apuntes_ins AS (
        INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo,reglas)
        VALUES (xConcepto,to_date(xFecha, 'YYYY-MM-DD'),
        EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
        EXTRACT(MONTH FROM to_date(xFecha, 'YYYY-MM-DD')),
        '{"vista":"BrowseNominas.jsp"}'
    )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;
    
    --
    -- Movimientos a 
    --  Remuneraciones pendientes de pago a Bancos
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4650000000','D',xImporte); 
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xImporte);

    -- Indicar a la tabla de obligaciones que hemos pagado
    UPDATE leg_obligaciones SET estado='PAGADO' WHERE id_apunte=xIDNomina AND naturaleza = 'NOMINAS';

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ******************************
-- Deshacer un ingreso de nóminas
-- ******************************
CREATE OR REPLACE FUNCTION DehacerIngresoNomina( xIDNomina in integer )
returns void
AS
$body$
DECLARE

    xEstado varchar(10);

BEGIN


    -- Si ya esta cerrado el periodo salir
    SELECT estado INTO xEstado FROM leg_obligaciones WHERE id_apunte=xIDNomina AND naturaleza = 'NOMINAS';

    IF  xEstado = 'CERRADO' THEN
        RAISE NOTICE 'Estado %', xEstado;
        RETURN;
    END IF;

    -- Si no está pagado salir
    IF  xEstado != 'PAGADO' THEN
        RAISE NOTICE 'Estado %', xEstado;
        RETURN;
    END IF;
    
    -- Borramos el diario
    DELETE FROM Diario WHERE id_apunte = xIDNomina;

    -- Borramos el apunte
    DELETE FROM Apuntes WHERE id = xIDNomina;

    -- Indicar a la tabla de obligaciones que hemos pagado
    UPDATE leg_obligaciones SET estado='PENDIENTE' WHERE id_apunte = xIDNomina AND naturaleza = 'NOMINAS';

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
