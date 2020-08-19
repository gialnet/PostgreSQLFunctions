--
-- Calcular Seguros Sociales
--

CREATE OR REPLACE FUNCTION  CalcularSS(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xId_leg integer;
    xCuenta varchar(10);

    xSS numeric(8,2) :=0;

BEGIN


SELECT cuenta INTO xCuenta FROM Obligaciones WHERE naturaleza='SEGURIDAD-SOCIAL';

--  comprobamos si ya existe esta anotación
SELECT Id INTO xId_leg FROM leg_obligaciones WHERE naturaleza='SEGURIDAD-SOCIAL'
        AND year_fiscal=xYear
        AND periodo=xPeri;

-- si no existe la obligación la creamos
if xId_leg is null then

    WITH leg_obligaciones_ins AS (
    INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal,periodo) 
        VALUES ('SS del mes ' || xPeri, 
                'SEGURIDAD-SOCIAL', xYear, xPeri)
    RETURNING ID
    )
    select id into xId_leg from leg_obligaciones_ins;

else
    DELETE FROM leg_detalle WHERE id_leg=xId_leg;
end if;

-- saber el importe
SELECT sum(importe) INTO xSS FROM Diario D, Apuntes A 
    WHERE A.id=D.id_apunte 
        AND cuenta='4760000000' 
        AND debe_haber='H'
        AND year_fiscal=xYear
        AND periodo=xPeri;

if xSS is null then
    xSS:=0;
end if;

INSERT INTO leg_detalle (cuenta, id_leg,importe) 
                VALUES (xCuenta, xId_leg, xSS);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Sumar las seguros sociales del mes
--
CREATE OR REPLACE FUNCTION  SumaSSMes(
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
            and O.year_fiscal=xYear 
            and O.periodo=xMes
            and naturaleza='SEGURIDAD-SOCIAL';


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


--
-- Sumas los seguros sociales de un trimestre
--
CREATE OR REPLACE FUNCTION  SumaSSTrimestre(
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
            and O.year_fiscal=xYear 
            and naturaleza='SEGURIDAD-SOCIAL'
            and O.periodo in ('1','2','3');
end if;

if xPeri='2' then
select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and O.year_fiscal=xYear 
            and naturaleza='SEGURIDAD-SOCIAL'
            and O.periodo in ('4','5','6');
end if;

if xPeri='3' then
select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and O.year_fiscal=xYear 
            and naturaleza='SEGURIDAD-SOCIAL'
            and O.periodo in ('7','8','9');
end if;

if xPeri='4' then
select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and O.year_fiscal=xYear 
            AND naturaleza='SEGURIDAD-SOCIAL'
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


--
-- Sumas los seguros sociales de un año completo
--
CREATE OR REPLACE FUNCTION  SumaSSYear(xYear in varchar) returns numeric
AS
$body$
DECLARE

    xSumaNominas numeric(8,2) :=0;
    
BEGIN


select sum(importe) INTO xSumaNominas
            from leg_detalle D, leg_obligaciones O
            where O.id=D.id_leg
            and naturaleza='SEGURIDAD-SOCIAL'
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

