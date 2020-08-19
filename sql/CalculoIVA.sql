
-- *****************************
-- Calcular el IVA del Trimestre
-- *****************************

CREATE OR REPLACE FUNCTION  CalcularIVA(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xId_leg integer;
    xCuenta varchar(10);
    xEstado varchar(10);

    xSumaCobrado numeric(8,2) :=0;
    xSumaPagado numeric(8,2) :=0;
    xBaseImponible numeric(8,2) :=0;
    xCarga_impositiva numeric(4,2);

BEGIN


--  comprobamos si ya existe esta anotación
SELECT Id, estado INTO xId_leg, xEstado FROM leg_obligaciones WHERE naturaleza='Modelo 303-IVA'
        AND year_fiscal=xYear
        AND periodo=xPeri;

-- si no existe la obligación la creamos
if xId_leg is null then

    WITH leg_obligaciones_ins AS (
    INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal,periodo) 
        VALUES ('Trimestre de IVA', 'Modelo 303-IVA',xYear, xPeri)
    RETURNING ID
    )
    select id into xId_leg from leg_obligaciones_ins;

else

    IF xEstado != 'PENDIENTE' THEN
       RAISE NOTICE 'Estado %', xEstado;
       RETURN;
    END IF;

    DELETE FROM leg_detalle WHERE id_leg=xId_leg;
end if;

-- Si hay que hacerla

SELECT SumaIVACobradoPeriodo(xYear,xPeri) INTO xSumaCobrado;
SELECT SumaIVAPagadoPeriodo(xYear,xPeri) INTO xSumaPagado;


    -- beneficios a tributar
    -- a compensar saldrán valores en negativo
    xBaseImponible := xSumaCobrado - xSumaPagado;


SELECT cuenta INTO xCuenta FROM Obligaciones 
    WHERE naturaleza='Modelo 303-IVA';    

INSERT INTO leg_detalle (cuenta, id_leg, importe) 
                VALUES (xCuenta, xId_leg, xBaseImponible);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ************************
-- Sumar el IVA del periodo
-- ************************
CREATE OR REPLACE FUNCTION  SumaIVACobradoPeriodo(
    xYear in varchar,
    xPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaIVA numeric(8,2) :=0;
    
BEGIN

select sum(T.base*T.iva/100) INTO xSumaIVA
            from total_bill T, vwhead_bill B
            where B.id=T.id_bill and T.iva > 0
            and B.fiscal_year=xYear 
            and B.trimestre=xPeri
            and B.global_dto=0;


if xSumaIVA is null then
    xSumaIVA:=0;
end if;

return xSumaIVA;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;




-- *********************************
-- Suma del IVA Pagado en el periodo
-- *********************************
CREATE OR REPLACE FUNCTION  SumaIVAPagadoPeriodo(
    xYear in varchar,
    xPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaIVA numeric(8,2) :=0;
    
BEGIN

select sum(T.base*T.iva/100) INTO xSumaIVA
            from total_recibidas T, vw_recibidas B
            where B.id=T.id_inre and T.iva > 0 
            and B.fiscal_year=xYear 
            and B.trimestre=xPeri;

if xSumaIVA is null then
    xSumaIVA:=0;
end if;

return xSumaIVA;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ***********************************************************************************
-- Embolsar una factura de un trimestre para otro
-- todas aquellas facturas que tengan un global_dto=1 no computan de cara al trimestre
-- ***********************************************************************************
CREATE OR REPLACE FUNCTION  EmbolsarIVACobradoPeriodo(xIDFact in integer) 
returns void
AS
$body$
BEGIN

UPDATE head_bill SET global_dto=1 WHERE id=xIDFact;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ***************************************
-- Cambiar de estado para que si aparezcan
-- ***************************************
CREATE OR REPLACE FUNCTION  DesembolsarIVACobradoPeriodo(xIDFact in integer) 
returns void
AS
$body$
BEGIN

UPDATE head_bill SET global_dto=0 WHERE id=xIDFact;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

