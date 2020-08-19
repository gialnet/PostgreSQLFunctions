
--
-- Calcular Nomina
--

CREATE OR REPLACE FUNCTION  CalcularNomina(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xId_leg integer;
    xCuenta varchar(10);

    xSalario numeric(8,2) :=0;

BEGIN


SELECT cuenta INTO xCuenta FROM Obligaciones WHERE naturaleza='NOMINAS';

--  comprobamos si ya existe esta anotación
SELECT Id INTO xId_leg FROM leg_obligaciones WHERE naturaleza='NOMINAS'
        AND year_fiscal=xYear
        AND periodo=xPeri;

-- si no existe la obligación la creamos
if xId_leg is null then

    WITH leg_obligaciones_ins AS (
    INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal,periodo) 
        VALUES ('Salarios del mes '||xPeri, 'NOMINAS', xYear, xPeri)
    RETURNING ID
    )
    select id into xId_leg from leg_obligaciones_ins;

else
    DELETE FROM leg_detalle WHERE id_leg=xId_leg;
end if;

-- saber el importe
SELECT sum(importe) INTO xSalario FROM Diario D, Apuntes A 
    WHERE A.id=D.id_apunte
        AND cuenta='4650000000' 
        AND debe_haber='H'
        AND year_fiscal=xYear
        AND periodo=xPeri;

if xSalario is null then
    xSalario:=0;
end if;

INSERT INTO leg_detalle (cuenta, id_leg,importe) 
                VALUES (xCuenta, xId_leg, xSalario);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- *****************************
-- Sumar las nóminas del mes
-- *****************************
CREATE OR REPLACE FUNCTION  SumaNominasMes(
    xYear in varchar,
    xMes in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaNominas numeric(8,2) :=0;
    
BEGIN

select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and naturaleza='NOMINAS'
            and O.year_fiscal=xYear 
            and O.periodo=xMes;


if xSumaNominas is null then
    xSumaNominas:=0;
end if;

return xSumaNominas;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- *********************************
-- Sumas las nóminas de un trimestre
-- *********************************
CREATE OR REPLACE FUNCTION  SumaNominasTrimestre(
    xYear in varchar,
    xPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaNominas numeric(8,2) :=0;
    
BEGIN

if xPeri='1' then
select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and O.naturaleza='NOMINAS'
            and O.year_fiscal=xYear 
            and O.periodo in ('1','2','3');
end if;

if xPeri='2' then
select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and O.naturaleza='NOMINAS'
            and O.year_fiscal=xYear 
            and O.periodo in ('4','5','6');
end if;

if xPeri='3' then
select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and O.naturaleza='NOMINAS'
            and O.year_fiscal=xYear 
            and O.periodo in ('7','8','9');
end if;

if xPeri='4' then
select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and O.naturaleza='NOMINAS'
            and O.year_fiscal=xYear 
            and O.periodo in ('10','11','12');
end if;

if xSumaNominas is null then
    xSumaNominas:=0;
end if;

return xSumaNominas;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ************************************
-- Sumas las nóminas de un año completo
-- ************************************

CREATE OR REPLACE FUNCTION  SumaNominasYear(xYear in varchar) returns numeric
AS
$body$
DECLARE

    xSumaNominas numeric(8,2) :=0;
    
BEGIN


select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and naturaleza='NOMINAS'
            and O.year_fiscal=xYear;

if xSumaNominas is null then
    xSumaNominas:=0;
end if;

return xSumaNominas;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
