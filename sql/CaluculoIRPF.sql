


-- ******************************
-- Calcular el IRPF de un periodo
-- ******************************
CREATE OR REPLACE FUNCTION  CalculoIRPF(
    xYear in varchar,
    xPeri in varchar
) 
returns VOID
AS
$body$
DECLARE

    xSumaIRPF numeric(8,2) :=0;
    
BEGIN

-- Obligatorio
PERFORM CalculoIRPF111(xYear, xPeri);

-- Si corresponde, es decir tenemos algo alquilado
PERFORM CalculoIRPF115(xYear, xPeri);

-- Si corresponde, hemos retenido a profesionales no residentes
PERFORM CalculoIRPF216(xYear, xPeri);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



--
-- Retenciones a Trabajadores y Profesionales
--
CREATE OR REPLACE FUNCTION  CalculoIRPF111(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xCuantos integer;
    xId_leg integer;
    xSumaIRPF numeric(8,2) :=0;
    xEstado varchar(10);
    xCuenta varchar(10);

BEGIN


    --  comprobamos si ya existe esta anotación
    SELECT Id, estado INTO xId_leg, xEstado FROM leg_obligaciones 
        WHERE naturaleza='Modelo 111-IRPF empleados y prof.'
        AND year_fiscal=xYear
        AND periodo=xPeri;


    -- si no existe la obligación la creamos
    if xId_leg is null then

        WITH leg_obligaciones_ins AS (

        INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal, periodo) 
            VALUES ('IRPF Trabajadores y profesionales',
            'Modelo 111-IRPF empleados y prof.',xYear, xPeri)
        RETURNING ID

        )
        select id into xId_leg from leg_obligaciones_ins;

    else

        IF xEstado != 'PENDIENTE' THEN
            RAISE NOTICE 'Estado %', xEstado;
            RETURN;
        END IF;

        -- Borrar los calculos anteriores
        DELETE FROM leg_detalle WHERE id_leg=xId_leg;
    end if;

    -- Obtener la cuenta de IRPF
    SELECT cuenta INTO xCuenta FROM Obligaciones 
        WHERE naturaleza='Modelo 111-IRPF empleados y prof.';
        
    SELECT SumaIRPFCuentaPeriodo(xCuenta, xYear, xPeri) INTO xSumaIRPF;
        

    INSERT INTO leg_detalle (cuenta, id_leg,importe) 
           VALUES (xCuenta, xId_leg, xSumaIRPF);





END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ***************
-- IRPF Alquileres
-- ***************
CREATE OR REPLACE FUNCTION  CalculoIRPF115(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xCuantos integer;
    xId_leg integer;
    xSumaIRPF numeric(8,2) :=0;
    xEstado varchar(10);
    xCuenta varchar(10);

BEGIN


    --  comprobamos si ya existe esta anotación
    SELECT Id, estado INTO xId_leg, xEstado FROM leg_obligaciones 
        WHERE naturaleza='Modelo 115-IRPF alquileres'
        AND year_fiscal=xYear
        AND periodo=xPeri;


    -- si no existe la obligación la creamos
    if xId_leg is null then

        -- Obtener la cuenta de IRPF
        SELECT cuenta INTO xCuenta FROM Obligaciones 
            WHERE naturaleza='Modelo 115-IRPF alquileres';
        
        SELECT SumaIRPFCuentaPeriodo(xCuenta, xYear, xPeri) INTO xSumaIRPF;

        -- si el valor es cero no hay que declarar

        IF xSumaIRPF = 0 THEN
            RETURN;
        END IF;

        WITH leg_obligaciones_ins AS (

        INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal, periodo) 
            VALUES ('IRPF Alquileres',
            'Modelo 115-IRPF alquileres',xYear, xPeri)
        RETURNING ID

        )
        select id into xId_leg from leg_obligaciones_ins;

    else

        IF xEstado != 'PENDIENTE' THEN
            -- RAISE NOTICE 'Estado %', xEstado;
            RETURN;
        END IF;

        -- Borrar los calculos anteriores
        DELETE FROM leg_detalle WHERE id_leg=xId_leg;
    end if;


    INSERT INTO leg_detalle (cuenta, id_leg,importe) 
           VALUES (xCuenta, xId_leg, xSumaIRPF);



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ******************
-- IRPF No residentes
-- ******************
CREATE OR REPLACE FUNCTION  CalculoIRPF216(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xCuantos integer;
    xId_leg integer;
    xSumaIRPF numeric(8,2) :=0;
    xEstado varchar(10);
    xCuenta varchar(10);

BEGIN


    --  comprobamos si ya existe esta anotación
    SELECT Id, estado INTO xId_leg, xEstado FROM leg_obligaciones 
        WHERE naturaleza='Modelo 216-IRPF no residentes'
        AND year_fiscal=xYear
        AND periodo=xPeri;


    -- si no existe la obligación la creamos
    if xId_leg is null then

        -- Obtener la cuenta de IRPF
        SELECT cuenta INTO xCuenta FROM Obligaciones 
            WHERE naturaleza='Modelo 216-IRPF no residentes';
        
        SELECT SumaIRPFCuentaPeriodo(xCuenta, xYear, xPeri) INTO xSumaIRPF;

        -- si el valor es cero no hay que declarar

        IF xSumaIRPF = 0 THEN
            RETURN;
        END IF;
        
        WITH leg_obligaciones_ins AS (

        INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal, periodo) 
            VALUES ('IRPF No residentes',
            'Modelo 216-IRPF no residentes',xYear, xPeri)
        RETURNING ID

        )
        select id into xId_leg from leg_obligaciones_ins;

    else

        IF xEstado != 'PENDIENTE' THEN
            RAISE NOTICE 'Estado %', xEstado;
            RETURN;
        END IF;

        -- Borrar los calculos anteriores
        DELETE FROM leg_detalle WHERE id_leg=xId_leg;
    end if;


    INSERT INTO leg_detalle (cuenta, id_leg,importe) 
           VALUES (xCuenta, xId_leg, xSumaIRPF);



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ********************************************
-- Sumar el perido de una cuenta de retenciones
-- ********************************************
CREATE OR REPLACE FUNCTION  SumaIRPFCuentaPeriodo(
    xCuenta in varchar,
    xYear in varchar,
    xPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaIRPF numeric(8,2) :=0;
    
BEGIN

SELECT sum(importe) INTO xSumaIRPF FROM Diario D, Apuntes A 
    WHERE A.id=D.id_apunte
    and cuenta=xCuenta
    and debe_haber='H'
    and year_fiscal=xYear
    and periodo=xPeri;

if xSumaIRPF is null then
    xSumaIRPF:=0;
end if;

return xSumaIRPF;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- *********************************
-- Para vistas de totales y gráficos
-- *********************************
CREATE OR REPLACE FUNCTION  SumaIRPFPeriodo(
    xYear in varchar,
    xPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaIRPF numeric(8,2) :=0;
    
BEGIN

SELECT sum(importe) INTO xSumaIRPF FROM Diario D, Apuntes A 
    WHERE A.id=D.id_apunte
    and cuenta like '4751%'
    and debe_haber='H'
    and year_fiscal=xYear
    and periodo=xPeri;

if xSumaIRPF is null then
    xSumaIRPF:=0;
end if;

return xSumaIRPF;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


