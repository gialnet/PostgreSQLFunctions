
--
-- Realizar los calculos de la cuenta de perdidas 
--
-- xTipo in integer 1 normal 2 abreviada

CREATE OR REPLACE FUNCTION  PerdidasyGanancias(xYear in varchar, xUser in varchar) 
returns void
AS
$body$
DECLARE

    OPERATING_INCOME numeric(12,2) :=0;
    FINANCIAL_RESULTS  numeric(12,2) :=0;
    EBITDA numeric(12,2) :=0;
    PROFIT numeric(12,2) :=0;

BEGIN

-- Borrar el balance anterior, para limpiar los datos del listado
DELETE FROM tmp_ResultPyG WHERE year_fiscal=xYear AND usuario=xUser;

-- Las reglas de calculo de las secciones

PERFORM AplicaReglasPyG(xUser, xYear, 1); -- 1 normal 2 abreviada


--
-- Realizar las operaciones
--

-- OPERATING INCOME, EBITDA, FINANCIAL RESULTS y PROFIT

-- A) OPERATING INCOME suma de los registro 1..13
SELECT SUM(IMPORTE) INTO OPERATING_INCOME FROM tmp_ResultPyG 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND id_SeccionPyG <=13;

UPDATE tmp_ResultPyG SET importe=OPERATING_INCOME 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND tipo_registro='OPERATING INCOME';


-- B) FINANCIAL RESULTS suma de los registro 14..18

SELECT SUM(IMPORTE) INTO FINANCIAL_RESULTS FROM tmp_ResultPyG 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND id_SeccionPyG BETWEEN 15 and 21;

UPDATE tmp_ResultPyG SET importe = FINANCIAL_RESULTS 
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND tipo_registro='FINANCIAL RESULTS';

-- C) EBITDA ------------> A+B

EBITDA := OPERATING_INCOME + FINANCIAL_RESULTS;

UPDATE tmp_ResultPyG SET importe = EBITDA
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND tipo_registro='EBITDA';

-- PROFIT -------------> C+19
SELECT IMPORTE INTO PROFIT FROM tmp_ResultPyG 
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND id_SeccionPyG=24; -- Columna 19 del documento impuestos sobre beneficios

PROFIT:= PROFIT + EBITDA;

UPDATE tmp_ResultPyG SET importe = PROFIT 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND tipo_registro='PROFIT';


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ****************
-- Metodo Abreviado
-- ****************
CREATE OR REPLACE FUNCTION  PerdidasyGananciasAbreviado(xYear in varchar, xUser in varchar) 
returns void
AS
$body$
DECLARE

    OPERATING_INCOME numeric(12,2) :=0;
    FINANCIAL_RESULTS  numeric(12,2) :=0;
    EBITDA numeric(12,2) :=0;
    PROFIT numeric(12,2) :=0;

BEGIN

-- Borrar el balance anterior, para limpiar los datos del listado
DELETE FROM tmp_ResultPyG WHERE year_fiscal=xYear AND usuario=xUser;

-- Las reglas de calculo de las secciones

PERFORM AplicaReglasPyG(xUser, xYear, 2); -- 1 normal 2 abreviada


--
-- Realizar las operaciones
--

-- OPERATING INCOME, EBITDA, FINANCIAL RESULTS y PROFIT

-- A) OPERATING INCOME suma de los registro 26..36
SELECT SUM(IMPORTE) INTO OPERATING_INCOME FROM tmp_ResultPyG 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND id_SeccionPyG <=36;

UPDATE tmp_ResultPyG SET importe=OPERATING_INCOME 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND tipo_registro='OPERATING INCOME';


-- B) FINANCIAL RESULTS suma de los registro 12..16 38..42

SELECT SUM(IMPORTE) INTO FINANCIAL_RESULTS FROM tmp_ResultPyG 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND id_SeccionPyG BETWEEN 38 and 42;

UPDATE tmp_ResultPyG SET importe = FINANCIAL_RESULTS 
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND tipo_registro='FINANCIAL RESULTS';

-- C) EBITDA ------------> A+B

EBITDA := OPERATING_INCOME + FINANCIAL_RESULTS;

UPDATE tmp_ResultPyG SET importe = EBITDA
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND tipo_registro='EBITDA';

-- PROFIT -------------> C+17
SELECT IMPORTE INTO PROFIT FROM tmp_ResultPyG 
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND id_SeccionPyG=45; -- Columna 17 del documento impuestos sobre beneficios

PROFIT:= PROFIT + EBITDA;

UPDATE tmp_ResultPyG SET importe = PROFIT 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND tipo_registro='PROFIT';


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ***************************************************************************
--                      Aplicar las reglas de PyG para su calculo
-- ***************************************************************************

CREATE OR REPLACE FUNCTION AplicaReglasPyG(xUser in varchar, xYear in varchar, xTipo in integer)
returns void
AS
$body$
DECLARE

    xCuenta varchar(10);
    xSigno varchar(1);

    xSaldo2 numeric(8,2) :=0;
    xSumaSaldo numeric(8,2) :=0;
    xSumaSaldoSeccion numeric(8,2) :=0;
    xDebe numeric(8,2) :=0;
    xHaber numeric(8,2) :=0;
    
    curs4 CURSOR IS SELECT id,grupo_cuentas,Seccion,tipo_registro
    FROM SeccionPyG
    WHERE id_pyg = xTipo -- 1 Normal 2 Abreviado
    ORDER BY ID;

    cCursor RECORD;
BEGIN

--
-- Lista de cuentas de las SeccionPyG
--
FOR cCursor IN curs4 LOOP


    FOREACH xCuenta IN ARRAY cCursor.grupo_cuentas
    LOOP

        if xCuenta is null or xCuenta ='' then

            continue;

        end if;

        xSigno:=substr(xCuenta,1,1);
        xCuenta:=substr(xCuenta,2);

        -- Leer los saldos del grupo de cuentas
        SELECT xSumDebe, xSumHaber, xSaldo INTO xDebe, xHaber, xSaldo2 from SaldoGrupoCuenta(xCuenta, xYear);

        if xDebe is not null and xHaber is not null and  xSaldo2 is not null then

            -- - Debe  + Haber
            if xSigno='-' then
                xSumaSaldo := xSumaSaldo + xDebe;
            else
                xSumaSaldo := xSumaSaldo + xHaber;
            end if;
        end if;

    END LOOP;

    -- Insertamos el campo si tiene algún valor

    INSERT INTO tmp_ResultPyG (usuario, year_fiscal, tipo_registro, id_SeccionPyG, Seccion, Importe) 
        VALUES (xUser, xYear, cCursor.tipo_registro, cCursor.ID, cCursor.Seccion, xSumaSaldo);


    xSumaSaldo :=0;

END LOOP;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
