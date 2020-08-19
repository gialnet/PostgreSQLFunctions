--
-- Calcular Trimestre de Sociedades
-- Este impuesto se debe de calcular si la sociedad dío beneficios el año
-- anterior.
--

CREATE OR REPLACE FUNCTION  CalcularTrimestreSociedades(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xId_leg integer;
    xCuenta varchar(10);

    xSumaCobrado numeric(8,2) :=0;
    xSumaPagado numeric(8,2) :=0;
    xBaseImponible numeric(8,2) :=0;
    xCarga_impositiva numeric(4,2);
    xSociedades varchar(2);

BEGIN


-- Comprobar si tiene la obligación de realizar el pago del impuesto

SELECT sociedades INTO xSociedades FROM DatosPer WHERE id=1;

IF xSociedades != 'SI' THEN
   RETURN;
END IF;


SELECT cuenta INTO xCuenta FROM Obligaciones WHERE naturaleza='Modelo 202-Acuenta Sociedades';

--  comprobamos si ya existe esta anotación
SELECT Id INTO xId_leg FROM leg_obligaciones WHERE naturaleza='Modelo 202-Acuenta Sociedades'
        AND year_fiscal=xYear
        AND periodo=xPeri;

-- si no existe la obligación la creamos
if xId_leg is null then

    WITH leg_obligaciones_ins AS (
    INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal,periodo) 
        VALUES ('Trimestre de Impuesto de Sociedades', 'Modelo 202-Acuenta Sociedades',xYear, xPeri)
    RETURNING ID
    )
    select id into xId_leg from leg_obligaciones_ins;

else
    DELETE FROM leg_detalle WHERE id_leg=xId_leg;
end if;

-- Si hay que hacerla

SELECT SumaIVACobradoPeriodo(xYear,xPeri) INTO xSumaCobrado;
SELECT SumaIVAPagadoPeriodo(xYear,xPeri) INTO xSumaPagado;


if (xSumaCobrado - xSumaPagado) > 0 then

    -- beneficios a tributar
    xBaseImponible = xSumaCobrado - xSumaPagado;

else
    -- perdidas saldrán los valores en negativo
    xBaseImponible:=0;

end if;

    

INSERT INTO leg_detalle (cuenta, id_leg,importe) 
                VALUES (xCuenta, xId_leg, xBaseImponible);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;




--
-- Calcular Sociedades
--
CREATE OR REPLACE FUNCTION  CalcularSociedades(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xId_leg integer;
    xCuenta varchar(10);

    xSumaCobrado numeric(8,2) :=0;
    xSumaPagado numeric(8,2) :=0;
    xBaseImponible numeric(8,2) :=0;
    xCarga_impositiva numeric(4,2);

BEGIN


SELECT cuenta INTO xCuenta FROM Obligaciones WHERE naturaleza='Modelo 200-SOCIEDADES';

--  comprobamos si ya existe esta anotación
SELECT Id INTO xId_leg FROM leg_obligaciones WHERE naturaleza='Modelo 200-SOCIEDADES'
        AND year_fiscal=xYear
        AND periodo=xPeri;

-- si no existe la obligación la creamos
if xId_leg is null then

    WITH leg_obligaciones_ins AS (
    INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal,periodo) 
        VALUES ('Impuesto de Sociedades', 'Modelo 200-SOCIEDADES',xYear, xPeri)
    RETURNING ID
    )
    select id into xId_leg from leg_obligaciones_ins;

else
    DELETE FROM leg_detalle WHERE id_leg=xId_leg;
end if;

-- Si hay que hacerla

SELECT SumaIVACobradoPeriodo(xYear,xPeri) INTO xSumaCobrado;
SELECT SumaIVAPagadoPeriodo(xYear,xPeri) INTO xSumaPagado;


if (xSumaCobrado - xSumaPagado) > 0 then

    -- beneficios a tributar
    xBaseImponible = xSumaCobrado - xSumaPagado;

else
    -- perdidas saldrán los valores en negativo
    xBaseImponible:=0;

end if;

    

INSERT INTO leg_detalle (cuenta, id_leg,importe) 
                VALUES (xCuenta, xId_leg, xBaseImponible);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


